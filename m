Return-Path: <linux-kernel+bounces-35497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A1839204
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABA61C23025
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE45FBB2;
	Tue, 23 Jan 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzUFckTy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D45FB86
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022266; cv=none; b=FlvFwgOKMhLl4Skzm3dqXIe+ZMEburYEUj3dIND80q6qzB8EkA7UvnNKqq551SYI97ogrUrM9sFhMKdxAqNfyO/REZ0nkiEXp/SBR3qU76xJEM0iEUUff0qMqRLfo2hvFFK/E8LxLcltO57mryteU7hSOriBamZtSIxFrgarPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022266; c=relaxed/simple;
	bh=Tu3cqFci8WaHOnBtzOdldpyunWVYVzEczy4GoS0Ccys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj3OUtVhYLDi3q2vpxoR+KT1Tx3n7Tn8hR9oqQE5QDAvSqNsjUKKM6s3m+6JVn24HNiaSRDHYJ+zhXG862ThlK2TSjsrNG7uhrqLGkezntxdZ24Xpsd53Q0v6Umc2nihLQsFAPofjedRXfvTc+zln9xzv5cFYheiCra7F0xbTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzUFckTy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so55994275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706022263; x=1706627063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1fi6zHbgrXmr+/grPY97P7k3iob9AFkPeQ4v7MnMa8=;
        b=TzUFckTybv6fzLsg/F0o2YJhyXBWLTWw2i623GGk3YLxqCYxrQXpDIxfbKTe+9ZI1B
         Y9Rq7wfxSjKKeksnb6aq034vVO3SzhK2CwKO/ylbDz4cnBteccMmpi8ciaDXTFvRnqPJ
         fjltADxb42OfNR0H4ULL49VMIHh2PDz93JmIwy09wSLJQNVKuRyp8dLEzXTi2/u6fXaq
         C8uJEsKD6HiCAgH1/o0YTwfoFk2iA5Avdz1azairNwxQNng7tvfLXkzccPJ0aGx8kMW/
         H1ZutVW3ba4YDJ2zlSML8efHb9D5vERYQoPvFIJUwoHtcghYyHYCwAl63Xl0Zgjns2EF
         UBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022263; x=1706627063;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1fi6zHbgrXmr+/grPY97P7k3iob9AFkPeQ4v7MnMa8=;
        b=j7QDjIyEl+rCBVs5DFvLCTvGiVq+lfoicQ59tAs63Isx9CQyeJGsjqqhj0NftSmNZ7
         cl3cSknVcrpGEyh75REykSCjPoDJh9e6wIQ0SunbyT0qoMrunn1xZ6SJePcvUibCcVQT
         Zne9KehELqvrA1RmT4rKJ0KC+BDONJyHBUsBdejhjq0E/tqUT4NhmXIQNOEcL7wzuW1h
         lMBqkcAhIZ2gv3SIOKh5FECN+4yQKfMg5GyNS9EOishS+2XdtsccMVJxg2oIL7d5UFMA
         9lEK8P443X+oOU/XpinOA3Y2GOxL53/vB7hNz2Z+SmYCXkIit6ylgBf3GLNewpAflmmR
         BcwQ==
X-Gm-Message-State: AOJu0YxsybAym3UB5XmNccegiDTKzU1/eu//6vjZFXf1fJJrFeKs+U5z
	9tCuZURqGjt2ZXjvZsOvOi/qHcZc7tbJL1+BTcnr6GF8hiq2YVUciwYTdkGwfdk=
X-Google-Smtp-Source: AGHT+IHG1+N4DXUX6qaUZ5kW5x9YZdj37viEablJvTV/ZnuDBzsiR/mSJHZj/NPoGJYg20ErecOWRA==
X-Received: by 2002:a05:600c:584a:b0:40e:6e67:36ac with SMTP id ka10-20020a05600c584a00b0040e6e6736acmr246141wmb.52.1706022263266;
        Tue, 23 Jan 2024 07:04:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b003366c058509sm8526482wro.23.2024.01.23.07.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:04:22 -0800 (PST)
Message-ID: <17fac295-5043-411e-8f1e-32f78ffe4027@linaro.org>
Date: Tue, 23 Jan 2024 16:04:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml file for pcm6240
 codec driver
To: Mark Brown <broonie@kernel.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, conor+dt@kernel.org,
 robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, kevin-lu@ti.com,
 baojun.xu@ti.com, devicetree@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
 pdjuandi@ti.com, j-mcpherson@ti.com, navada@ti.com
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-4-shenghao-ding@ti.com>
 <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
 <9ed437f8-e429-4694-bffc-15931d57a48b@sirena.org.uk>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9ed437f8-e429-4694-bffc-15931d57a48b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 16:01, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 12:25:04PM +0100, Krzysztof Kozlowski wrote:
>> On 23/01/2024 12:14, Shenghao Ding wrote:
> 
>>> ---
>>> Change in v1:
>>>  - Create yaml file for pcm6240 codec driver
> 
>> I don't understand. v1 is the first version. Against what is this change?
> 
> This appears to be a perfectly clear description of the contents of the
> first version, it's a change against the tree before the patch is
> applied.  It's a bit unusual to include a per version changelog on the
> first version but not a problem.
> 
>>> +    enum:
>>> +      - ti,adc3120
>>> +      - ti,adc5120
>>> +      - ti,adc6120
>>> +      - ti,dix4192
>>> +      - ti,pcm1690
>>> +      - ti,pcm3120
>>> +      - ti,pcm3140
>>> +      - ti,pcm5120
>>> +      - ti,pcm5140
>>> +      - ti,pcm6120
>>> +      - ti,pcm6140
>>> +      - ti,pcm6240
>>> +      - ti,pcm6260
>>> +      - ti,pcm9211
>>> +      - ti,pcmd3140
>>> +      - ti,pcmd3180
>>> +      - ti,pcmd512x
>>> +      - ti,taa5212
>>> +      - ti,taa5412
>>> +      - ti,tad5212
>>> +      - ti,tad5412
> 
>> And none of them are compatible with something?
> 
> No idea about these specific chips but that would be entirely normal for
> CODECs, even where things are subsets there's often some tweaks needed
> to initialisation or whatever.

I want to double check with the author.

> 
>>> +     two: pcmdevice@48 {
> 
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Please be more specific about what you're looking to see there.
> pcmdevice doesn't seem particularly more specific than something like
> dsp, it certainly seems within what the text describes.

pcm, codec, audio-codec
"device" seems redundant, because almost everything is some sort of device.

Best regards,
Krzysztof


