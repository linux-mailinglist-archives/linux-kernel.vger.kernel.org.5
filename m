Return-Path: <linux-kernel+bounces-34923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904B838944
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE11C23DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC63156B89;
	Tue, 23 Jan 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj47kk2s"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE45676A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999203; cv=none; b=IVgLvFQLyOmVPV1zQqetI0r+OxYQk3ACxEvI+R52ktSec7/ezcO0rK9Y623zejIFVXiPiAlrfxH2Iuqvy+n0uvHrxI2lfnwIRt1W/grvPhTNNFVIkrxSrPhvKRRSoshuXnXewxaltcyicrlPeEdLuI/wOTjB0zdlNEjuBLdnopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999203; c=relaxed/simple;
	bh=icdMWYGH8hQIPKZhJTP/Ad0yobupNW9s1Au6TP+h++E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSoEOaXdD63fJOhfpsABEh7C94TwtWKm1wpu/jivTK8NtnWFZlHyWDZ4tm+6NTXMquXw53Yw9AyY73IChWORRh0fDzNS+xYWLrwFJzjQkFX/oa9Eu/AqU8h40YU2VZQ/6LxG4UqG1ZOYII4AqJcd5NpDdCE/wa1FqVpCzdl+wMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jj47kk2s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so51421605e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705999200; x=1706604000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tRP0lRa5MWneuC/0KW09V1JK5tM0R1XHmv5b0cWHNw=;
        b=jj47kk2s8KamkPsxohaRVQk20WuTUIltqrY3n1QUY1khMMOgitgyYmbv2wXTinUfS+
         +Xi4BcsZRymtbKv5digBcJu6OoqzVxZwFEgQlbE9FDkgqeIW/wzkjAWj67NHdE+Kd5Ew
         aM0NJ9Y/xRaqvk9Dg7enmXhRNNVCpiUJpVinh94Rrfdn0oK6vpHIrgNIhRb6Kq7cZs8L
         +zWU6uVny0+tT+V4t1irx2ZT8E4LU0Hym432GKCIqwXu9gvFExZmQ74ie9gTG1dURvxC
         kFLMhd3vKTQEBK0Ur+UwP90cMZNOZqm/0/3GcYDbAp6WVJBz8cbJ9aK3bht0XapSFlE7
         VsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999200; x=1706604000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tRP0lRa5MWneuC/0KW09V1JK5tM0R1XHmv5b0cWHNw=;
        b=Nt5S7jKqJPbmkME74T8153y9x/6CosG6LL4kEw5ERrNmbRFphvDzc7Tj8mKHUpvsjA
         adL/ZYeBfgoLwqncj/cUPi8Xdr4HrT+DxbokJUzVhsurj4zq1OAn4RM3foPSj6Atmy7n
         3l2p6cr17aMLpqFfhk+neO9B3qmrbQINQvzVA/2d2bdmbtMfNptCxFYikPpF/gnRnUky
         vdVyNOFDrBM8ttpiZl6M9MlNO3xT/GjziaFqPs8cHsULzJTgqpqdCU8uR11tO2l58KKm
         kqICMh/EbnSf/CEsnelcGE4WdtEc72Ya+qu1eMvH23tZRnJ9eV/DfQ15DsmuOcYd4xBs
         W/jQ==
X-Gm-Message-State: AOJu0YxNebnxad8kCffzRDljQ0s489TKFFEYGVQUvu0cMSjQ9DxIYKu/
	NgHy4VGwd2vASGC10NgH9RTTWQcRjsMC0Rfw5qtZe7IqzQDWgOBLqHMLndrco98=
X-Google-Smtp-Source: AGHT+IF6aytL8mpyBfDiZmtDzTjYm6QzA21E+Ld/3mJyiTXtv8FYwZX+JGfZ1M6mWoeph29k8VgfaQ==
X-Received: by 2002:a05:600c:1f94:b0:40e:66ee:2ba3 with SMTP id je20-20020a05600c1f9400b0040e66ee2ba3mr311799wmb.29.1705999199702;
        Tue, 23 Jan 2024 00:39:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0040e48abec33sm45449108wmq.45.2024.01.23.00.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 00:39:59 -0800 (PST)
Message-ID: <7fdc00e1-0a93-43a6-8fb6-c447ad8aef64@linaro.org>
Date: Tue, 23 Jan 2024 09:39:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] arm64: dts: exynos: gs101: define USI8 with I2C
 configuration
Content-Language: en-US
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 andre.draszik@linaro.org, semen.protsenko@linaro.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-8-tudor.ambarus@linaro.org>
 <9d12f4f9-1892-48f3-b8d1-8f59788cc91d@linaro.org>
 <6ddbf20c-6929-4cb0-9fdb-570cc7170b9c@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6ddbf20c-6929-4cb0-9fdb-570cc7170b9c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 09:34, Tudor Ambarus wrote:
> 
> 
> On 1/23/24 07:52, Krzysztof Kozlowski wrote:
>> On 19/01/2024 12:11, Tudor Ambarus wrote:
>>> USI8 I2C is used to communicate with an eeprom found on the battery
>>> connector. Define USI8 in I2C configuration.
>>>
>>> USI8 CONFIG register comes with a 0x0 reset value, meaning that USI8
>>> doesn't have a default protocol (I2C, SPI, UART) at reset. Thus the
>>> selection of the protocol is intentionally left for the board dts file.
>>
>> ... and dropped, because this patch does not build:
>> https://krzk.eu/#/builders/29/builds/3869
>> and I missed weird dependency mentioned in cover letter:
>>
>> "This patch set shall be queued after the cmu_misc clock name fixes from:"
>>
>> Sorry, this cannot work like that. DTS for new features cannot build
>> depend on driver changes.
> 
> No worries. What shall I do so that you re-consider the dropped patches?
> I'm not yet familiar with your release management, but I guess that if
> you submit your "fixes-clk" branch for integration into v6.8-rc2, and
> then merge v6.8-rc2 into your "next/dt64", you'll then be able to queue
> the dropped patches as well.

It is nothing specific to my release management but years old rule: DTS
branch cannot contain driver commits. It is nothing new, discussed on
mailing lists for various SoC architectures many times.

However I don't fully understand why that dependency - except patch hunk
context - exists. You shouldn't have such dependency.

Best regards,
Krzysztof


