Return-Path: <linux-kernel+bounces-64841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72C854390
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C73283912
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DCE11716;
	Wed, 14 Feb 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0+dNpg4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73438125A3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896586; cv=none; b=EaAGH4E5SPX33PvdI+lV1/59pK97yn8pc6bVXFbyDlmX+dXkflVBn/Tgwqj/YjoT75W1a/RJMmkv0qwjAhqe9/LkxBQLzHB5Ns3vrA+59LrmDhRmOxMPAN58qixUv6sevnO1NTjc+a33JVvcjrZPIEeBIohyMAvpoelUrhhGnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896586; c=relaxed/simple;
	bh=VWEOVPjzwG5LyVakYdf3057OxZUScV4IOC88KiJYLM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRgTp2XJLoAwNpZWGwD/fVoY/tnChkSXkbStrhRJ8x/cs3DOSmRJqyhe+tTVBOPr5QePt8Lh1wYDCy7FDqYYGWHV4DV45tdsG2Jdff9BESCZ7pM0QoAfUUFg+8t8zGETvqOHiPAjA8duh3ZfJmABavTJ75F4bImDaRKt2APykek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0+dNpg4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d11d180652so1648811fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707896582; x=1708501382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qm35U4zALwNw8pnZRUH8OtgtOhB7/DRacCD6hYwcr6s=;
        b=i0+dNpg4+lo1JHLpmJDwvRh6w8H5ra71CjQy3kIEHaRhKePq1hCYhxuZ3hK+5cBFxo
         BRbi55RLs0LwK/3t4DYeKMf5qJeuyvM5vQGoIcAzVbjIAJNLE9FqOizQzYeSOVBS6DYP
         KKL7l61ZgzngMfJEAbciAUVBzjykfRuxbSJKkC13R8ScHD/dvjjIxltAl5O1PUTgL5SN
         IX8NziLLYbEYDYWBGPl0Ymn/3XsKLY0cwRS0uZzu/SfkvTK/BxwQFyREMnQFA45Lwu2F
         yCiT0hx4kqsxgfDXkjlzOggoUvexfX4pElxwEx2V3Tcj37llgDFU0whPRUVZLb5nSYK8
         1HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707896582; x=1708501382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm35U4zALwNw8pnZRUH8OtgtOhB7/DRacCD6hYwcr6s=;
        b=HPR+eIEqNYAOcu0yLhbKswv33YJmToONSPqQ8+uAd1QnKZCuiQVy1dhna0gqly9M80
         +VPXw1vffnIGAD8iVLjuISorDkol8X3CS8oFsz98zFmG+XjnviCHRvfgWlrLYSbwvIOk
         EGV4qrn2KDqpWQodG3EhyxkbdZOM4h/3/NTZus34nIA8VXdiKNYcFpXAjopgpeYgAP0w
         ytEZh05Zfsh+bWo5qQPXsAhGCg8lxIBElj2Ji8MIQEdNXhqCXk9VxO+79DNMyrogjee7
         WaxKa+ffq/AN4p6nttA1M71K1DWbm6it69/OyDgEp1okmwxnaEI6XkqDTl1NRtndjgyp
         YKwA==
X-Forwarded-Encrypted: i=1; AJvYcCWxaE5oBw0XE5Oe26HEC9TZU53mPoatJW8MF3Oa2CmGXYRjn1kOV4mHasLPRboLvyI/CisL+7NX8oxYeDuxBkFvDJ7RwvdiyluZ3HX9
X-Gm-Message-State: AOJu0YyFmXsCBDGhD8yCYgRioVA9np+mpRehOBR/eysvD1gkzJeoJTgB
	qrkS7XzjXjcI4Z5S28OaT6kz5Sxv9zLbaTjmpMrwt0RH5Sn3hUnBjm9U6fb/B1g=
X-Google-Smtp-Source: AGHT+IFgCBpIBi9Yw7Zbk0svMSXIz5z2ckU3mgemyBuFKJc7Ohs0vatZR0iczHy/Ul9qTbzaqUc4yg==
X-Received: by 2002:a2e:82c3:0:b0:2d0:ac7f:eef9 with SMTP id n3-20020a2e82c3000000b002d0ac7feef9mr1312036ljh.34.1707896582368;
        Tue, 13 Feb 2024 23:43:02 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id x17-20020a05600c21d100b00410b98a5c77sm1059749wmj.32.2024.02.13.23.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 23:43:01 -0800 (PST)
Message-ID: <d5d71068-eff7-4a1d-ad2f-948bf0313b9c@linaro.org>
Date: Wed, 14 Feb 2024 07:42:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
 <69f023bb-2844-496f-9f3f-4e2e80129d33@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <69f023bb-2844-496f-9f3f-4e2e80129d33@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/24 15:28, Mark Brown wrote:
> On Tue, Feb 13, 2024 at 12:39:02PM +0000, Tudor Ambarus wrote:
>> On 2/9/24 13:51, Théo Lebrun wrote:
> 
>>> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
>>> +
> 
>> Would be good to be able to opt out the statistics if one wants it.
> 
>> SPI NORs can write with a single write op maximum page_size bytes, which
>> is typically 256 bytes. And since there are SPI NORs that can run at 400
>> MHz, I guess some performance penalty shouldn't be excluded.
> 
> If we can cope with this sort of statistics collection in the networking
> fast path we can probably cope with it for SPI too, the immediate
> recording is all per CPU so I'd like to see some numbers showing that
> it's a problem before worrying about it too much.  Even the people doing
> things like saturating CAN buses haven't been raising it as a concern
> for the regular SPI data path.  We could add a Kconfig if it's an issue.

Ok, we can deal with it afterwards if it'll become an issue.

