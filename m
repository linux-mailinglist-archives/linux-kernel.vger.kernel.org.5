Return-Path: <linux-kernel+bounces-138375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87EF89F048
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB9A283242
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D489159917;
	Wed, 10 Apr 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4k/3g+3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A16159219;
	Wed, 10 Apr 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746632; cv=none; b=bl6Ec1SDRyH5WW7ZZmbRhbBvbKVRTmbwRRNw7eoA0scuic1rEAiHZkL/ezNt4lkVv+3knNTsI+0PybI2hFzcgaM4wdQxITA84DiF1xGvNZLjV3DwmsJwrcdq6G0IsBp5BC076mRBQ460TDMj6EaLj+t/VntjT/Jj7ABGWGlXBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746632; c=relaxed/simple;
	bh=yER5WqfrYOpPdWi09GgpkEmfXYdO+P/p0Yx8KlZR0R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skqtIxjTtOtYwfkGlzHsthB8VXA8vgcfXm8RHias2ZCSRP0wB7SEu/g1mexpwdIEFDA1ThD2Owu2xFi9fdmuc2T5IQQ0Zxtg9pM4X1KA3SMbkEyUNnrZ523kWvLNO+t5xOE9e2WxXGf1rcoKj7BFYUVT3pC01HZcbWGx8Gscqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4k/3g+3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516ab4b3251so7513397e87.0;
        Wed, 10 Apr 2024 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712746629; x=1713351429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74ZNNn3OhmGXGqjgqGSkw49LZtWek2Tj9NqPh68R1C4=;
        b=B4k/3g+3it2Kdx3quHCiQNkvCwoSQoYAt3Pbv4DYHzvX6TDNytIkT8mWoRS8v8fHCS
         VuhoeLRapc+FW1BeLHJCNdeg3AdGwhGgsBp/Vz5d3j9heoWGC/l0/99kI4pDduDMe+QK
         o8J2AkFiP0cqRAMwck+wHGkNbf1Xtn2ZnsHWKkCAznFTjPXQoHXHgQF9MpsfZ6Xz6Dq2
         5WatXwwJkID/CbJBprhuPihw8xGGPVUNCn+zBM4GgDvs9jPMRlohdiFDH48RgqRZwtE5
         F4YAfjTeOd/geyGtjjwgP0S5jOiWeIxjGsZLvWOenjB62JIzUjIvWbUSgzYotAHEvYj+
         o93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746629; x=1713351429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74ZNNn3OhmGXGqjgqGSkw49LZtWek2Tj9NqPh68R1C4=;
        b=Z8OLwKpp8jdw1rBuRDqnnsCS5j1Sf5c5fxA+NnhzRTAQd2n7MGeVSu9x/49kdv6Ffj
         7SJdH5zta0p1Tc4cdgawl5gpCeRLW5BI5NA/Gc0mkMD8Wj9DRuKbWHXl9SwCkeuU+Yqy
         /TaPxO/TiP0hE6tyfM3dtChj6Haqa6mVdQvlquai6OPS/2CPHcHX7zLANI9YxPVloP4g
         5LlhCEyDxB2BWbQa8mbgtS3B2GCRXHL5KcJA1U2RkdPXq9DJ5HHEuSPRq3aN+s3BVHDf
         KstmVsrcE8+QEQo6osPpK1XSLDS+54MnLGKEmLP5h+Ih0PXjYJd6Zg6GZZS98+gcQHR4
         W7hw==
X-Forwarded-Encrypted: i=1; AJvYcCUgSi61jPum3xtPQPIAEiWvuwwzMHNcSHRDNJjfBGGAD3/igmgSODOGIOt55yTZRsyrbLaHyODHM8FI0GOrkVjfHYuGBEEiCQZtT6YAISthqQhtvOZvZ4Lg/UWIKPWg4fPUSeo6Yx9kjg==
X-Gm-Message-State: AOJu0YxIxdEwBR0iJFSaqLCjfaJ8XqLYek4Y1O3YSfM1dgw2rq67q7nZ
	EgB7IFVyHHLF35taCqMCWWho1zMztjQv2DKp154tDGPm/1g0ym8bg2tZ8q8B
X-Google-Smtp-Source: AGHT+IGOoRrCm8NKtPkPTwaY8w06OViAQwAuOQzUhOLtasjoYvQuK1/vjstArz7gr3uVWZn2CQpi2w==
X-Received: by 2002:a05:6512:481e:b0:515:b164:4112 with SMTP id eo30-20020a056512481e00b00515b1644112mr1436566lfb.68.1712746628864;
        Wed, 10 Apr 2024 03:57:08 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c4-20020ac244a4000000b0051327d2f5e5sm1781863lfm.119.2024.04.10.03.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:57:08 -0700 (PDT)
Message-ID: <dd78b1ef-366a-41e4-8046-e368539839df@gmail.com>
Date: Wed, 10 Apr 2024 13:57:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71879
Content-Language: en-US, en-GB
To: Conor Dooley <conor@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404195423.666446-1-andreas@kemnade.info>
 <20240404195423.666446-2-andreas@kemnade.info>
 <3d5df067-ec94-42c6-bbd0-43ce8cd53e40@gmail.com>
 <20240410-possum-lecturer-716185901aa5@spud>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240410-possum-lecturer-716185901aa5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 13:03, Conor Dooley wrote:
> On Wed, Apr 10, 2024 at 10:57:08AM +0300, Matti Vaittinen wrote:
>> On 4/4/24 22:54, Andreas Kemnade wrote:
>>> As this chip was seen in several devices in the wild, add it.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>>    .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>> index 0b62f854bf6b..07f99738fcf6 100644
>>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>> @@ -17,7 +17,12 @@ description: |
>>>    properties:
>>>      compatible:
>>> -    const: rohm,bd71828
>>> +    oneOf:
>>> +      - const: rohm,bd71828
>>> +
>>> +      - items:
>>> +          - const: rohm,bd71879
>>> +          - const: rohm,bd71828
>>>      reg:
>>>        description:
>>
>> Am I correct, this reads as:
>>
>> Either
>> 	compatible = rohm,bd71828
>> or
>> 	compatible = rohm,bd71879, rohm,bd71828
>>
>> but not compatible = rohm,bd71879?
> 
> Correct.

Thanks Conor!

I guess that if we later find out that there is a 'gizmo' in BD71828 
which is not present on BD71879 - and if we write driver supporting 
this, then we need to have handling for both the BD71879 and BD71828 in 
this driver to ensure the fall-back wont happen. It's a bit ugly as I 
think the fall-back compatible should be used only in case where the 
"fall-back" HW can be guaranteed to have exactly same, or a subset of, 
features of the "full board".

Well, I've been told these are similar by HW colleagues. I have my 
doubts if 'similar' really is '_similar_', or if it's 'similar, except 
of course...' - but let's trust the HW guys on this. We have the above 
mentioned workaround if we should not have trusted...

Acked-By: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


