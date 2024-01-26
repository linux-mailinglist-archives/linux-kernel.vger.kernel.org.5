Return-Path: <linux-kernel+bounces-39762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09383D5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E880B24AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAE1B959;
	Fri, 26 Jan 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2M+A+H8"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B041B940
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257674; cv=none; b=GwtgSXkKKAZ0RS7JMQBi+OBQAGzvoRik+ZAKAg5c6tNoHVew2a5A9oBzqrchRRvQ1bNOA5PceNabrJQmj760CyWaycZjpMQyTrVxRQewDZbimrwGYl/iKtoTzrt+h2FKh/kJ5hB618C1T6FkywcA9ZK3bDVEkOOFySJTaD9MkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257674; c=relaxed/simple;
	bh=iGtHLHEEHiS6uj0QwPvMFkaRW6WE8OwPPgr8M4LcXSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHfe8LYQ3xo8P/nfTqDRpgJSN3Oi80aPaiL896N5bb2yfi7ItWVrXMZeKp8zzBMFpGq/J5JR/VD4Kk+rwgnhdQqtrj289IZTlijOUbBg7rAbumx+YuKg4PvJG1cHggL3eMC+TJQ3B/YMJQRebGTi3ZqfPTwmI5qv4Z+Oh28OESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2M+A+H8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55cdaa96f34so2971185a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706257670; x=1706862470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/IPAH8DIzGg3QLNUNSBtjrthJB0vkfcBLJNMSgUZw60=;
        b=g2M+A+H837337XkwCHOcCmhq7mfw8ubI9PV1JWQJ+tOhNIAl64mlgJ/bAEZ0uyutS5
         kKuTfXADG6jFuQ5qsCRkcYAdqIIsQgYr53/UdbpgGb0Q65gMjASyAwnWyXyUb3XMZVT3
         PI1qpo06eoVRQus0U+eWdtW0XOG60tq3YhsSC14yfV+0Q9mQ9RoVyHHiCVqRItFoBHal
         HvCQQmbQN3/0C4L1rbzHyRGZXrYaAeOAeDeYqCL5D/7cTde4C1sWxII9O09tRNPUkbma
         A0vmiwqTm2mfhFIJk13cenOXlB0IpB9oed7BL0gB2dNEMQE+S01IOYJWDjcecymGaMcf
         sriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706257670; x=1706862470;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IPAH8DIzGg3QLNUNSBtjrthJB0vkfcBLJNMSgUZw60=;
        b=sWbhB3/z5Geo4M0IeDbLo52PcCduGMdYVjkkMnx3VhR2C+kVWgl/OLcqENu8oPBlvy
         pSNL1E4OFcRvhEmv6ePB8j6wCtc9KxFmOh1tqMxbHadaiveKlrWmTvGrIsP3mSDyAHKs
         3WpjNgtX8OplzDYM6GQGQGU8ykjqFoXlwQG9E406Lrzv3s5GCXzsayQjxkX2ySizdkCm
         o3joDuopqbRHLDWcd5fFtWrRDxY0nx2pDsiJfVlse/HFar5FqBMNhpGmUVrbjwqdfyDv
         ZGg1RfpyL0R79PUghjia6mbB2rvLZHdDyvhQMuMswP5XxNxsXUTfvn/lP8YBnSWuG9zB
         RT8w==
X-Gm-Message-State: AOJu0Yws2gpPibQIa593QS7Ks5a1UyTyKLDqgkQjP4g5fQ01dSiU1MBI
	6gQdLFYd3uqqszSgxXnZ1RUhlyke9r+pi3YZ0nzTYXK0QAjON6ZZGbGP27qciQA=
X-Google-Smtp-Source: AGHT+IEBZHD1wW7iPcP4z0alptoeDbgQjFkTTbrvST3VQjoPUHYb9ZlEtyTmeZdUd7cDEZIYVUOAdg==
X-Received: by 2002:a17:907:f95:b0:a26:f7ea:7cb6 with SMTP id kb21-20020a1709070f9500b00a26f7ea7cb6mr680931ejc.16.1706257670372;
        Fri, 26 Jan 2024 00:27:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090616cc00b00a317be75012sm374069ejd.27.2024.01.26.00.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:27:49 -0800 (PST)
Message-ID: <f7a2de19-55c5-4aa9-b0a8-632f22b6c147@linaro.org>
Date: Fri, 26 Jan 2024 09:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
 conor+dt@kernel.org
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, kevin-lu@ti.com,
 baojun.xu@ti.com, devicetree@vger.kernel.org, v-po@ti.com,
 lgirdwood@gmail.com, perex@perex.cz, pierre-louis.bossart@linux.intel.com,
 13916275206@139.com, mohit.chawla@ti.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com, soyer@irl.hu,
 jkhuang3@ti.com, tiwai@suse.de, pdjuandi@ti.com, j-mcpherson@ti.com,
 navada@ti.com
References: <20240126035855.1785-1-shenghao-ding@ti.com>
 <20240126035855.1785-4-shenghao-ding@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240126035855.1785-4-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/01/2024 04:58, Shenghao Ding wrote:
> PCM6240 driver implements a flexible and configurable setting for register
> and filter coefficients, to one, two or even multiple PCM6240 Family Audio
> chips.
> 

Subject: you just ignored my comment...

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Tools like b4 or scripts_getmaintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, use mainline), work on fork of kernel (don't, use
mainline) or you ignore some maintainers (really don't). Just use b4 and
all the problems go away.

..

> +      ti,pcmd3140: Four-channel PDM-input to TDM or I�S output converter.

This does not look like proper encoding.

> +
> +      ti,pcmd3180: Eight-channel pulse-density-modulation input to TDM or
> +      I�S output converter.
> +
> +      ti,taa5212: Low-power high-performance stereo audio ADC with 118-dB
> +      dynamic range.
> +
> +      ti,tad5212: Low-power stereo audio DAC with 120-dB dynamic range.
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,adc3120
> +              - ti,adc5120
> +              - ti,pcm3120
> +              - ti,pcm5120
> +              - ti,pcm6120
> +          - const: ti,adc6120
> +      - items:
> +          - enum:
> +              - ti,pcm6260
> +              - ti,pcm6140
> +              - ti,pcm3140
> +              - ti,pcm5140
> +          - const: ti,pcm6240
> +      - items:
> +          - const: ti,dix4192
> +          - const: ti,pcm6240
> +          - const: ti,adc6120

It does not make sense. You said above adc6120 is not compatible with
pcm6240.

> +      - items:
> +          - const: ti,pcm1690
> +          - const: ti,pcm9211
> +          - const: ti,pcmd512x
> +      - items:
> +          - enum:
> +              - ti,pcmd3180
> +          - const: ti,pcmd3140
> +      - items:
> +          - enum:
> +              - taa5412
> +          - const: ti,taa5212
> +      - items:
> +          - enum:
> +              - tad5412
> +          - const: ti,tad5212
> +      - items:

No need for items.

> +          - enum:
> +              - ti,pcm6240
> +              - ti,pcmd3140
> +              - ti,taa5212
> +              - ti,tad5212
> +              - ti,pcmd3180

Where is adc6120 and others?

Missing blank line.

> +  reg:
> +    description:
> +      I2C address, in multiple pcmdevices case, all the i2c address
> +      aggregate as one Audio Device to support multiple audio slots.
> +    minItems: 1
> +    maxItems: 4
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Invalid only for ti,pcm1690 because of no INT pin.
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,pcm1690
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            minimum: 0x4c
> +            maximum: 0x4f

Nothing improved.

> +        interrupts: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,adc3120
> +              - ti,adc5120
> +              - ti,adc6120
> +              - ti,pcm3120
> +              - ti,pcm5120
> +              - ti,pcm6120
> +              - ti,pcmd3140
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +          items:
> +            maximum: 0x4e
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,dix4192
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            minimum: 0x70
> +            maximum: 0x73

Drop entire if

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,pcm6240
> +              - ti,pcm6260
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 4
> +          items:
> +            minimum: 0x48
> +            maximum: 0x4b

Drop entire if

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,pcm9211
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            minimum: 0x40
> +            maximum: 0x43

Drop entire if


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,taa5212
> +              - ti,taa5412
> +              - ti,tad5212
> +              - ti,tad5412
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            minimum: 0x50
> +            maximum: 0x53

Drop entire if


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c {
> +     /* example for two devices with interrupt support */
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     pcm6240: audio-codec@48 {
> +       compatible = "ti,pcm6240";
> +       reg = <0x48>, /* primary-device */
> +            <0x4b>; /* secondary-device */

Looks misaligned.



Best regards,
Krzysztof


