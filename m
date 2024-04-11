Return-Path: <linux-kernel+bounces-139964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07B8A09AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37C6B28182
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3251F13E04F;
	Thu, 11 Apr 2024 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAsiio4o"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8713E049
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820331; cv=none; b=IPkFqWkGbGyhEC6fYukqa8VBJeHMa6rUY8nlKlaUgjmSD4N5h6T+ok6JWATGmCRYYmZgACkrg0w5wKbqLL0vORGYO1fZdgIuGHhsp43hBHSGIrFE4GFt2GT0+2+K9twg2WgvovfOG62v8/CtoBpQq01XQYXXXgYXeQzLe4Q9+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820331; c=relaxed/simple;
	bh=h4dFsYtnlN8ZUYzMeIJnNwkAeG3dqWQK76oIMf60zOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IKe2cjewe6+FABFcbDX7WJjcNzJClCzJrphnyj9RHiIQjx2GkICGy68n9+ysV6fSp1OeiAaGUU0+tY6mK9q/AQFcOy04sZWWQSw+G7wQM4WaTvypHztO8ARhvDYg372kIdrbJvloT2GEIvdzHUBwIdlVsQsCipQnLgp+d4JOUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAsiio4o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41551500a7eso57905405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712820328; x=1713425128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9zwE2+Q5g17pW6wKSw7re4stV4qmExBkSpcgkO2N+1Q=;
        b=IAsiio4oYOe5rDh1z4GldBPE57RaYejmAA5gSM8IrZi9eLsagZG/rvT6yoDXDhfbJU
         OOsMG+MVLMLaSTM5c0fXq2TsOoivgUUPy956UYkj0x1rPV0cQCYn8h5ojeaOHsn+Kl60
         W2/FJxwe54JJmtOFeQfP2m8sh5AtG1FeBzFsKL8KtZWIiUMn8NNfDW5SGN1o6R1sA1FQ
         2TF2p4LlPN+t2OPYwUhiPhaaP9Uv1HBOhb9sQxWxJi0gpj6vEDEEL7FSy5W0Rtmq9o9S
         F9GcRxYCjAzlvhwjKhuzxNjLvZ9s8obeCRca60EsEFIZ2uZ69RlGFtd82/uZa6loukO5
         uaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820328; x=1713425128;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zwE2+Q5g17pW6wKSw7re4stV4qmExBkSpcgkO2N+1Q=;
        b=sYi01/M31RnIFKu/tkiqARXeundhrhfOF26Izr64JYlP6o+4yT3NW9FAJtMLiEzhvr
         bKPPIJ+6dV98vdC9MtFKSDh65lclk5gN5OgewrLuO/Q53pcrHuTMNiLtFx8B5dhXKLEG
         3rsF5P6zYGuPjnK7SQ4sO9eysdhV9U4pbS/xzqtYUleUppRc7c/gWY9usrhYo9s8Qi0c
         LyNkVS2GDiJbIRklS3lvKPrlzJvN6MYkIZF4FV+vqXaxUfGXT/r0JqOp8goqEspB+6Nh
         sCaJ4LCLoijoNVw3yS5EsD6VCtjaVScPa8Xix7GrKuIT0NoiDVXlM0pdhcMlVo/T2NWj
         1FlA==
X-Forwarded-Encrypted: i=1; AJvYcCW+y/xiBQrx4SPM785HWloYbW45LDC2xJw9etZzN/W3+wV7ujpHlhRFKvx9vLExX9aqjIhGKH8Lww0HahN0X8dpC5O8QguiNNqZmJDP
X-Gm-Message-State: AOJu0YxeYU7SvR8P5I5hDc68FgG5DwGSpxx9+i7zhrxkGYIy0S4INC/A
	am+SDhVsAVsfY3JPJPmrVEHRSb2C3FnoJurZicKDRRHgJ2plEsRMGSxmF+PHaaQ=
X-Google-Smtp-Source: AGHT+IHorrDqbK9zt/IoHlc21hKNjB613X7hy+TtL6kaGHau0izWH/4cPFxd84HwbzhID2FR+rKNSw==
X-Received: by 2002:a5d:6d4e:0:b0:346:72f4:c805 with SMTP id k14-20020a5d6d4e000000b0034672f4c805mr2713947wri.66.1712820327621;
        Thu, 11 Apr 2024 00:25:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b00346bda84bf9sm816474wrr.78.2024.04.11.00.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:25:27 -0700 (PDT)
Message-ID: <051c6e44-4844-48b9-846d-cf9b81611415@linaro.org>
Date: Thu, 11 Apr 2024 09:25:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: usb: add common Type-C USB Switch schema
To: Luca Weiss <luca.weiss@fairphone.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240122094406.32198-1-krzysztof.kozlowski@linaro.org>
 <D0H3VE6RLM2I.MK2NT1P9N02O@fairphone.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0H3VE6RLM2I.MK2NT1P9N02O@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 09:13, Luca Weiss wrote:
> On Mon Jan 22, 2024 at 10:44 AM CET, Krzysztof Kozlowski wrote:
>> Several bindings implement parts of Type-C USB orientation and mode
>> switching, and retiming.  Keep definition of such properties in one
>> place, new usb-switch schema, to avoid duplicate defines.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes in v2:
>> 1. Fix language typos handle->handler (Luca)
>> 2. Drop debugging left-over (Luca)
>> ---
>>  .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 12 ++--
>>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 12 ++--
>>  .../devicetree/bindings/usb/nxp,ptn36502.yaml | 12 ++--
>>  .../bindings/usb/onnn,nb7vpq904m.yaml         | 13 ++--
>>  .../bindings/usb/qcom,wcd939x-usbss.yaml      | 12 ++--
>>  .../devicetree/bindings/usb/usb-switch.yaml   | 67 +++++++++++++++++++
>>  6 files changed, 92 insertions(+), 36 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/usb-switch.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
>> index f9410eb76a62..8b25b9a01ced 100644
>> --- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
>> +++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
>> @@ -27,13 +27,8 @@ properties:
>>    vcc-supply:
>>      description: power supply (2.7V-5.5V)
>>  
>> -  mode-switch:
>> -    description: Flag the port as possible handle of altmode switching
>> -    type: boolean
>> -
>> -  orientation-switch:
>> -    description: Flag the port as possible handler of orientation switching
>> -    type: boolean
>> +  mode-switch: true
>> +  orientation-switch: true
>>  
>>    port:
>>      $ref: /schemas/graph.yaml#/$defs/port-base
>> @@ -79,6 +74,9 @@ required:
>>    - reg
>>    - port
>>  
>> +allOf:
>> +  - $ref: usb-switch.yaml#
>> +
>>  additionalProperties: false
>>  
>>  examples:
> 
> Hi Krzysztof,
> 
> This patch seems to break validation for fsa4480 if data-lanes is set in
> the endpoint like the following
> 
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> index f9410eb76a62..3aa03fd65556 100644
> --- a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> +++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
> @@ -102,6 +102,7 @@ examples:
>            port {
>              fsa4480_ept: endpoint {
>                remote-endpoint = <&typec_controller>;
> +              data-lanes = <0 1>;
>              };
>            };
>          };
> 
> Similar to how it's already used on qcom/qcm6490-fairphone-fp5.dts
> 
> I'm guessing the 'port' definition in the common schema somehow
> disallows the fsa4480 schema from describing it further?

There is no such code in qcm6490-fairphone-fp5.dts. There was no such
code in the example of fsa4480 when I was testing my changes (and
examples should be complete), so this did not pop up.

You right, new schema does not allow extending the port. However the
true question is, why muxing happens on the port to the SoC controller?
The graph in commit msg fad89aa14 shows it happens on the side of the
connector.

Looks like fsa4480 mixes connector with the controller.

Best regards,
Krzysztof


