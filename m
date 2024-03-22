Return-Path: <linux-kernel+bounces-111929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F798872E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7DCB249B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FC64AB6;
	Fri, 22 Mar 2024 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8TPjHS1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DF634E1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131482; cv=none; b=ON9c5vgWppSX3gdwvizCT6NrUUoLXQ1VlJO7oxz59SV9yUChA6NTZKot5TXiu1oU0kk4mMghvEVjjdkUWe4JOBbUjw3igkzUWaznT9CDu+sGUbnqLbJpKT8Tc5jcWdTz1lq5NCw0jnwQ1c9GFr+6OCMTcpfNoFGcuVV8qzUbo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131482; c=relaxed/simple;
	bh=4PZeNkpkgA9MeuFYKbd3qbiEtrgn3qW6NEkoD0AvAHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFs6z7Va6UGZ2RuQzMJY+YNBhQFNGy5VHrYm6/fUu7wu68QlUp1KlOQJ8RbMd3xKOctVDjgPVFZ1PfKblLD55c55kKeucB9ufyyHnOylaZ90XprUwMfNGdKcJlKuHJvySVodyN8vOf4bjoSeb1AECiNxmCM4ZAQJJHrz3sbcUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G8TPjHS1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4644bde1d4so337428366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711131479; x=1711736279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SeiHsFNUoaCnN7xb45zTYPjadaI5jk5AW3v5aPdkC2E=;
        b=G8TPjHS1Ql/oTRYf+u6U0NKmtXpl/4/idaaYTQPncDaT+NWosjPAoWIZUQ2qDWAex5
         B+GnXm64CeHa9UksAmFNd6NqQeN1RMMJK1m/+5PYY5nuCut9C0zdkawKBedoIWOLraR0
         etFIlsS7YyMHi3/VR5EwjORww+x8wEHJucfP4tRVCoCNlc+uOgQvemZw2STJSSLWZmpK
         TmUN6kb7I/iKNVXTx0+lyG7mhn96hUxD1uAKMJTcU3kqJt/yQzyPb61hKdBbRAPlxl5R
         ghCyaScwPUxpRuzDS+P4jBZfz390UdhrbLNlI6u/fnzyuYW4N9QyLyeGJig+vD/+VXcp
         BsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711131479; x=1711736279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeiHsFNUoaCnN7xb45zTYPjadaI5jk5AW3v5aPdkC2E=;
        b=jqVfkaEFTYSDhpTI7RaD+lofA9Q4r0dNFx+A/ykglQ14bj4Tw4X3iPjWF9fp0yrRVR
         3O4WHRtoCmqvJ9fh4F23YJnH2HeJOj3xIFFGxJyEngJh2TiK7mrn9eu/qv88GhyyHDBd
         GtGD8liApHHK2vlryYeXDs9kOSq3qJm5TzAPu7pbuLrSKm33aHG3xC0I6WBwTiAmCDC0
         DiuKz7gFpBEj1EkStUVu2UjYcMQk7V1Eb5GCayhnZ0R98OD6xzIH47Uyauu8r2NXpr4i
         e6AdDHsfECRhIQ3rXegGya+gAkzFOJ5A61bTWxWbNaOS7+l0LqW5olpjyLTVC/WaYK64
         5+ng==
X-Forwarded-Encrypted: i=1; AJvYcCXm3JR+l3g8lcdcHn7sQLJ4vHxAZyN/uxhdC1ALsAyZGJHQcYutxsw+K09OdUHYUmcszqJjReSp3q/U0N1FFwGBVg6g522ePE4Lbvkq
X-Gm-Message-State: AOJu0YxbfcNHEzjdN/J/uWwtwEeDcrIRAgeKSFYU/FxXtOkGnGek+PxD
	bAc5uQNq7FWgBAc9T9l4R+yQyv03o2MSHd9XjxIo62WIrud3MRjbA+/NNyy59z4=
X-Google-Smtp-Source: AGHT+IE8rf51P6ZV2w55aQi32v1RbTPj7yYppeHjfqgIRLq8bBYJrd3E4Qma1nFlYxhYP5nuDoAUOw==
X-Received: by 2002:a17:906:c4c:b0:a46:dca5:8b10 with SMTP id t12-20020a1709060c4c00b00a46dca58b10mr373843ejf.24.1711131478620;
        Fri, 22 Mar 2024 11:17:58 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b00a46a19b8a68sm74040ejg.167.2024.03.22.11.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:17:58 -0700 (PDT)
Message-ID: <5ad8fc4d-cabf-4b50-bb22-60896a13362d@linaro.org>
Date: Fri, 22 Mar 2024 19:17:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: add a link between DWC3 and
 QMP PHY
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org>
 <20240322-typec-fix-sm8250-v1-2-1ac22b333ea9@linaro.org>
 <635f7501-82cf-4df1-9194-27f24eb40a53@linaro.org>
 <CAA8EJpoYBsB8kx8P9w9M3pd6E7iUfqWk4XYwMr2oLoZV_nuYpg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpoYBsB8kx8P9w9M3pd6E7iUfqWk4XYwMr2oLoZV_nuYpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.03.2024 14:19, Dmitry Baryshkov wrote:
> On Fri, 22 Mar 2024 at 14:11, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 22/03/2024 11:58, Dmitry Baryshkov wrote:
>>> The SuperSpeed signals originate from the DWC3 host controller and then
>>> are routed through the Combo QMP PHY, where they are multiplexed with
>>> the DisplayPort signals. Add corresponding OF graph link.
>>>
>>> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++++++++++++++++++++--
>>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> index d57039a4c3aa..e551e733ab94 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
>>> @@ -3917,6 +3917,10 @@ port@0 {
>>>
>>>                               port@1 {
>>>                                       reg = <1>;
>>> +
>>> +                                     usb_1_qmpphy_usb_ss_in: endpoint {
>>> +                                             remote-endpoint = <&usb_1_dwc3_ss_out>;
>>> +                                     };
>>>                               };
>>>
>>>                               port@2 {
>>> @@ -4195,8 +4199,24 @@ usb_1_dwc3: usb@a600000 {
>>>                               phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>>>                               phy-names = "usb2-phy", "usb3-phy";
>>>
>>> -                             port {
>>> -                                     usb_1_dwc3_hs_out: endpoint {};
>>> +                             ports {
>>> +                                     #address-cells = <1>;
>>> +                                     #size-cells = <0>;
>>> +
>>> +                                     port@0 {
>>> +                                             reg = <0>;
>>> +
>>> +                                             usb_1_dwc3_hs_out: endpoint {
>>> +                                             };
>>> +                                     };
>>> +
>>> +                                     port@1 {
>>> +                                             reg = <1>;
>>> +
>>> +                                             usb_1_dwc3_ss_out: endpoint {
>>> +                                                     remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
>>> +                                             };
>>> +                                     };
>>>                               };
>>>                       };
>>>               };
>>>
>>
>> I think these should go into platform definitions, there's nothing at
>> the SoC level that imposes the port constraint.
> 
> The link between DWC3 and QMP PHY is fixed in the SoC, if I remember correctly.

Yes, I believe so too

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 

