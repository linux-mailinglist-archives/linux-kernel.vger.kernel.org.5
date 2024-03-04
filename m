Return-Path: <linux-kernel+bounces-90136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3086FAE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3105B1F22859
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9413FE2;
	Mon,  4 Mar 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIJDkBJF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4C134D8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537507; cv=none; b=HJlGqq+ErOdtKPbnyf8P2CMcFbQlgpxNiCqXmuUCzyDCz2WCLObN5QfrXMOmkMObbC0BFEnQ4gk8cxrm+R1jHuMw9HACX15xh2RwSFHVRA8X4M/WOU2/Thl3TotoMQga2iY0obVnVE3DrBF0z183+jjtj2K/T7ppIK9TvXJb1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537507; c=relaxed/simple;
	bh=66nqHdi7M5gLFbhxmC17gUfb4ScsEict20Pb1KD6cwE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OPOe/sDC2SuScWx+coTqN/saJ79GrG5bwPnNE9HmYJHY+5GgE+PSrePZ0KWNMBZT9TVsHSHWoDlmGqNkAxpv7W2zXVRL2HIdesqInUe/SKHE97Iran+KifBr+NUQtg+wqWrTRdntErFutRaf4My2gsp3vxm6V42zSAj3PnVXJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iIJDkBJF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so29447355e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709537504; x=1710142304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f51VA5MtxnAU0efzg76cN/fIARzVpps0Hh4Af04eUTk=;
        b=iIJDkBJFM6PJ/b9oio9oUPa1KcIx5Y1WixswOjL5orFeYMqjNLV7+g6bMDpjB8g6NG
         0D+uNDMYmPI/mfSlR9JhRfF6TiwXUW26CVG9E74QgoUqaCZ0a4mfdHVP775QLL4xFb6S
         sfmdVx2XVN1xr7lk9vxkTu+Z4RSZhiUxGgW3UE6lz/9GEZft8kt3eROwd3nV78/0fKz5
         n2USfduodHr6PYWIFCRcJg468D14XFR6Z1+Un+8tnOUe9Txv3viZErQ9y19AOV+vpfqV
         ZoyQ143hYHGkWq7DaxiZgQrMRhUm1DWrCxGUtwLbNpgdTTkRPJM1e//w9Y2vYua1dK7N
         rzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709537504; x=1710142304;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f51VA5MtxnAU0efzg76cN/fIARzVpps0Hh4Af04eUTk=;
        b=ONHqabi9q3rDnLUuWC5meAP3z50D9DtcGKikNcYNGinvnd3OPbbhJHkW5WanQA0wLg
         +caWZ0p9s4KimsPkNpqtXC1Z3ju1N6JqlK9P0Xw3bXiRuLDemvyskj+c0ykopfuLshQv
         S8VUkSgv9ZawRJT6oe4idxv5q1wEyXVpvGxUwPMhAfZF8xKRbv7VNlaj3JgK2F98y9k0
         Ni6Q8IvqElr+I1BnzTtRhSPyJ0hjpAm3FLJmuc2TDtq/oVDNo5NmPvpQBX8vawdUlYDy
         VijuLXGWgR5bGADD5Kz8YdJpVSl0totXt+2me1zT0pzyqW4zK4G1THFhzrtRNt6s2u/z
         TZdA==
X-Forwarded-Encrypted: i=1; AJvYcCX/YNI60LUTLj7EJLlUWOt0dtmweRgKc2gRS5UNNN1jm5o5+YqFVYIkb/QPQSO4MrYcB5D52Efg/zD3GqIFZbiZOZQrAWseIr2VYLhJ
X-Gm-Message-State: AOJu0YzCRdKVOg3o7rVIYRX1NPl2O6UlQ9v1wuFb4BCF0PcaNADUJrts
	7L6zH2SudBw+PE/IpblAxSe82OVB1OfvtIuspHeKTwF08ocyNjApCV4E2kI8kgw=
X-Google-Smtp-Source: AGHT+IH50+zD8hJJZMhOea5o5klj2GNCPU/jhf8hnaytno2hnVtJ77HuPpiGjm37w2PqW+nTVUVZwQ==
X-Received: by 2002:a05:600c:470e:b0:412:bcc1:44cc with SMTP id v14-20020a05600c470e00b00412bcc144ccmr6723784wmo.3.1709537503717;
        Sun, 03 Mar 2024 23:31:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e2-20020a05600c218200b004125f34fd7csm16569261wme.31.2024.03.03.23.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 23:31:43 -0800 (PST)
Message-ID: <d377f0ea-2df2-4d4e-b1bc-8a4ca55eec15@linaro.org>
Date: Mon, 4 Mar 2024 08:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Charles Perry <charles.perry@savoirfairelinux.com>,
 Rob Herring <robh+dt@kernel.org>, yilun xu <yilun.xu@intel.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>,
 Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>,
 krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-fpga <linux-fpga@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
 <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
 <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com>
 <cb51aadd-c350-42e2-9684-ac4f7dbf864c@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cb51aadd-c350-42e2-9684-ac4f7dbf864c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 08:30, Krzysztof Kozlowski wrote:
> On 03/03/2024 18:21, Charles Perry wrote:
>> On Feb 27, 2024, at 3:10 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
>>
>>> On 21/02/2024 20:50, Charles Perry wrote:
>>>> Document the SelectMAP interface of Xilinx 7 series FPGA.
>>>>
>>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>>> ---
>>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>>>>  1 file changed, 86 insertions(+)
>>>>  create mode 100644
>>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>> new file mode 100644
>>>> index 0000000000000..08a5e92781657
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>> @@ -0,0 +1,86 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Xilinx SelectMAP FPGA interface
>>>> +
>>>> +maintainers:
>>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>>>> +
>>>> +description: |
>>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>>>> +  parallel port named the SelectMAP interface in the documentation. Only
>>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>>>> +  the clock, with the MSB of each byte presented to the D0 pin.
>>>> +
>>>> +  Datasheets:
>>>> +
>>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - xlnx,fpga-xc7s-selectmap
>>>> +      - xlnx,fpga-xc7a-selectmap
>>>> +      - xlnx,fpga-xc7k-selectmap
>>>> +      - xlnx,fpga-xc7v-selectmap
>>>> +
>>>> +  reg:
>>>> +    description:
>>>> +      At least 1 byte of memory mapped IO
>>>> +    maxItems: 1
>>>> +
>>>> +  prog_b-gpios:
>>>
>>> I commented on this and still see underscore. Nothing in commit msg
>>> explains why this should have underscore. Changelog is also vague -
>>> describes that you brought back underscores, instead of explaining why
>>> you did it.
>>>
>>> So the same comments as usual:
>>>
>>> No underscores in names.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Hello Krzysztof,
>>
>> Yes, I've gone full circle on that issue. Here's what I tried so far:
> 
> And what part of the commit description allows me to understand this?
> 
>>
>>  1) Reuse the same gpio names: Duplicates errors of the past, Krzysztof
>>     doesn't like it.
>>  2) Different gpio names for new driver only: Makes the driver code
>>     overly complicated, Yilun doesn't like it.
> 
> That's a new driver, right? So what is complicated here? You have new
> code and you take prog-b or prog_b?
> 
>>  3) Change gpio names for both drivers, deprecate the old names: Makes
>>     the DT binding and the driver code overly complicated, Rob doesn't
>>     like it.
> 
> I don't think I proposed changing existing bindings.
> 
>>
>> I think that while the driver code shouldn't be the driving force for
>> the DT spec, it can be a good indication that the spec is unpractical to
>> implement.
> 
> What is impractical in implementing this? You just pass either A or B to
> function requesting GPIO. Just choose proper name.
> 
>>
>> In this case, there are two interfaces on a chip that uses the same GPIO
>> protocol, it would only make sense that they use the same names, this
>> discards solution #2.
> 
> I don't understand this. You have devm_gpiod_get() in your new code. Why
> is it difficult to use different name?

And I forgot to emphasize: none of these is mentioned in commit msg, so
for v5 you will get exactly the same complains. And for every other
patch which repeats the same and does not clarify caveats or exceptions.

Best regards,
Krzysztof


