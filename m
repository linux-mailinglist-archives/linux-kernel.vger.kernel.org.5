Return-Path: <linux-kernel+bounces-39167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962B83CBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C36C1C21A49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5E134720;
	Thu, 25 Jan 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfxGMDUj"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE11339B7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209276; cv=none; b=TZX4b4hOhYK5wKWCfyJ/04Pp82edJBTUNTUKAkPxnD1zcVwLFSambHyIduzhjbaoxbXlPLEdRiN13fasVLU/O+n76XYJ6ajRdekZgf5diBs1iFORBH5OpB9MZqdZI0+pxzMjPbWrElJVMi+s4dWezJKXQyDPob2G/ja3aFCpP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209276; c=relaxed/simple;
	bh=3l+IaiZHZv/Fe8lERi3/HFhALnFg+BculQ2om86Od/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TN0DmCpKtuU4yu7VfjROMDZCUxlguxzD5goM7IlGh5oW5Kjy6ZrY7kPbkBcMZDKlAiIXG5X+lVOIRit/BFGT1F96McMbKcrGb5AfhKvQDq8nvkIp2ZiBhnK3BW3R+/epgX6rserjHjU8QfQQR0hSBYZ7xNiIw5jt72jmW2mRu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WfxGMDUj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b12dd21so4769909f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706209273; x=1706814073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmN7I+9NF0wxlajdSp9I8HACKLWc2WQole+/PqyLTmw=;
        b=WfxGMDUj+jiNXnGj1RT38BlkPxJee9iNE+6rdI3wnr8lM1bTxwVBkVXMGTIqKEhs4A
         hrXSCzLOlaSeTEOe/Fot0dA6O9WnnSU5t6vQ8ZuJ1BLPOdQe9YwpevrLnEZ+yPFhu9YI
         0nOB4TjRcUgQMWPX2+uTNBpr08MKkoBf+m+ZbROe188Ryq26eZMqmSKr0TBxg55/9m/f
         VP0wQTBtiPEOD0YMqDBvCSYliYXEqHfAEPHcrldFHFw3gDnLZkDnv8uOid1vgw6W8uRM
         Z1BRM0l9+5nK67mNe4ax+8rze1pN94TFfTy0UoIX7HIMHSAKik28K8sRGsKADCGfIaY4
         rQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209273; x=1706814073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmN7I+9NF0wxlajdSp9I8HACKLWc2WQole+/PqyLTmw=;
        b=fU0Bje41zgEIsw2S/2+btRahplYg8XwO6j5CGsKXsZvwlAUHa/BtXVzOsIqWE2IqIs
         Yx+jDRb9K+SoVP0+Vo7NfJ7oisLBMSVX7MlXq98lvaDjKlv4Fxc7j9PQ1ST9sZTbpaI8
         Cc/ZokQpI8RlHowYnz2praBucDrR0qpPwRE0HL5kAxxXe8tjywXINt/ueec3OoGOyNF6
         7wlwqV9afeYWSFgNUsGqcUwdaOyyagEQVNpvJETq3YwOEY9NCfSJi6KtmAl4N1TtPJDZ
         /lYAlDxH4yv2wIaRHZ9z1eWKmomW+KcTvnRzwadXPfStP0yZQD92EeWjH+LYn6VbOYLu
         yA0w==
X-Gm-Message-State: AOJu0YzBd5d8sCnmk5grRhj6nmPVeZQ6SpKjQ2J/0L/ViuzOfDbgeFo0
	YPZaQvOCFhv4Wj+2ZFEnxj9EJ/Q2eN3Q6esjOZWVsPApgVPICwHLFlI8Pniszq8=
X-Google-Smtp-Source: AGHT+IHC7Mstw0DGiNo4tWtWCkZLvrWPOabFhDIsnvgtLlwTRPhqhBdNAB3jnq5GXT72VzereEQh0w==
X-Received: by 2002:a5d:5689:0:b0:337:c6be:7737 with SMTP id f9-20020a5d5689000000b00337c6be7737mr154375wrv.48.1706209273304;
        Thu, 25 Jan 2024 11:01:13 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d5608000000b003392bcd6c48sm13097531wrv.79.2024.01.25.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 11:01:12 -0800 (PST)
Message-ID: <96f9306f-3445-484b-bd3c-82e708681f1b@linaro.org>
Date: Thu, 25 Jan 2024 19:01:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/28] spi: dt-bindings: samsung: add
 samsung,spi-fifosize property
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: andi.shyti@kernel.org, arnd@arndb.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, semen.protsenko@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-6-tudor.ambarus@linaro.org>
 <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
 <1c58deef-bc0f-4889-bf40-54168ce9ff7c@linaro.org>
 <55af5d4a-7bc9-4ae7-88c5-5acae4666450@sirena.org.uk>
 <f2ec664b-cd67-4cae-9c0d-5a435c72f121@linaro.org>
 <f44d5c58-234d-45ec-8027-47df079e2f16@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <f44d5c58-234d-45ec-8027-47df079e2f16@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 17:45, Mark Brown wrote:
> On Thu, Jan 25, 2024 at 05:30:53PM +0000, Tudor Ambarus wrote:
>> On 1/25/24 17:26, Mark Brown wrote:
> 
>>> OK, so just the compatible is enough information then?
> 
>> For gs101, yes. All the gs101 SPI instances are configured with 64 bytes
>> FIFO depths. So instead of specifying the FIFO depth for each SPI node,
>> we can infer the FIFO depth from the compatible.
> 
> But this is needed for other SoCs?  This change is scattered through a

There are SoCs that have multiple instances of the SPI IP, and they
configure them with different FIFO depths. See
"samsung,exynosautov9-spi" for example: SPI0, SPI1, and SPI6 are
configured by the SoC to use 256 bytes FIFO depths, while all the other
8 SPI instances use 64 bytes FIFOs. I tried to explain the entire logic
of the series in another reply, see it here:
https://lore.kernel.org/linux-arm-kernel/40ba9481-4aea-4a72-87bd-c2db319be069@linaro.org/T/#u

> very large series which does multiple things so it's a bit difficult to
> follow what's going on here.

Sorry, I was afraid that this might happen. I agree, I'll split tomorrow
this patch set in 3 smaller sets:
1/ dumb cleaning patches
2/ heavy lifting cleaning patches
3/ gs101 addition

