Return-Path: <linux-kernel+bounces-75011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00A85E17C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1CE1C24482
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F180637;
	Wed, 21 Feb 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ruuFgqAo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90680629
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529963; cv=none; b=ScEEBVRftsgYkyEaRhRjQsPGRQiiqSzMFpPCfVrUMPucEs/8Dqau7dmn/DZLpH4hxm7THIJQo6n8pwA+cFNPMMWmLQi5zsSJB7L/7vwqJyG1HqqQ6PjeYJvxatCFPIp8C4uEia3x6hUQ/RN5bqIxL9Dw3HTK7iUdCgc3nzRvHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529963; c=relaxed/simple;
	bh=pWsam7+52/XRk2RrsltsfGHHP2aanJBgPjcl+66ZUIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX/eymIda1WFGGTUhctXhTtYR5ESCpsoRlgmMqbRjRJOGHeOny4mxFOg1L35UK0V3kCa+BQuW9xXQj6O2d48nTDDKFe13hjL1rtExp605Ij9m99LIKHdVwP0L7yyUHGpCJ0I8CbK81VroKWIN5pp8oeo/hhdaKCUog6L0Hd2mwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ruuFgqAo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso74888666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708529960; x=1709134760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7zYRYU3I+wnoCnVzPK9Qd1+dzDGOicbx6M6rSvNqY4=;
        b=ruuFgqAoRzZlhDE22Zakn1QbHYxx2oAY53mn+lZDyYqdjgH9tgp67ooBDHgbkpauEo
         yqcdDI09owhn4OuQf2nRdM3I/sk6LnWc5GH4PQ/oZNJPgJiz5zJ2ejP+uYyuZEzGuJ6t
         bq8UFZeet97lOz3Gsm4p/U3hqbuQEswc+rPJIOGP2JnFVrzbI1MzR0IZYbs/jw5w+oyi
         fUKOi8aFUDd+64w21UaLgV3wm0Ocodbe3hcvKEcM5cPUtzMv4HZK5oOh89bbR9VUaiUp
         HdIyOcO3jW29Y4W5ImLySP4lEU2+gbLKWkoCt1hNeu87SDJw4kkvMk5g6tObsaNbmd1I
         kcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529960; x=1709134760;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7zYRYU3I+wnoCnVzPK9Qd1+dzDGOicbx6M6rSvNqY4=;
        b=VLV8fe5qmoiSRfyuHLu9rQpLQ8M0T69yo4LyU2NHbUBQiga6eJBsMbZMnhCGhCwHf0
         wJTKZuY/B9V+rioog+rN9/a67KlJAh3/iZx+GbetcwUrr8exKjyz5CfJBpebRvtucFVd
         dIN1aDK9U0GS2UVt0YL+7Y8CPlJp4DMr2qQaG3ED/S/wUAv606SsWrEAUiwIMyjdf8Ko
         BG1NQbPhkG61L0xvRvPiklMH1b3u4f4ac+QPyuUrs5npgOeVvN3OVlFEsn6oEiEHY4al
         m8QbBVwwoZ+AYSXjDV26EWuI1+bbXHKvp5CJpJS1/3GFqOCg5xVh6DorYZ/1ny8noXAZ
         mT5g==
X-Forwarded-Encrypted: i=1; AJvYcCU3nsL/YSVs6y7HgTEoYBMqTqOFbV5HCIw8EV7tT/sWC6206cvDyGXLNE2xOUG/IaQRsY1/ZyBwV2W9g4kHXF1Mypm7EAcqGcKQnGKh
X-Gm-Message-State: AOJu0Yzn48uj8iECZnwBKm/8QUilKoE1pUhjpNtzWCqQ7rAq7D3tbBRJ
	C53qaUrG9vM0vdIEHCYdeqHVNwkrlwbn6177z+Ds1Kir32TLzFPtoEbpMKu7+xU=
X-Google-Smtp-Source: AGHT+IEtd1CtPDVHPJXhyrD3gI/MwE7PUoNHin7lXqvfyHXK1miNtp32xoOoK5Y3aCUo9iKN6bMYTw==
X-Received: by 2002:a17:906:a881:b0:a3d:6a42:a5a8 with SMTP id ha1-20020a170906a88100b00a3d6a42a5a8mr12916514ejb.73.1708529959927;
        Wed, 21 Feb 2024 07:39:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b00a3e51df2280sm4090336ejc.223.2024.02.21.07.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:39:19 -0800 (PST)
Message-ID: <205248ce-caeb-4090-998e-379f79639bec@linaro.org>
Date: Wed, 21 Feb 2024 16:39:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable zram, xfs and loading compressed
 FW support
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@redhat.com>, Erico Nunes <nunes.erico@gmail.com>,
 Enric Balletbo i Serra <eballetbo@redhat.com>,
 Brian Masney <bmasney@redhat.com>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240221125928.3711050-1-javierm@redhat.com>
 <9f419e86-6e14-42a1-84e1-31cab62d8ea2@app.fastmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9f419e86-6e14-42a1-84e1-31cab62d8ea2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 16:31, Arnd Bergmann wrote:
> On Wed, Feb 21, 2024, at 13:59, Javier Martinez Canillas wrote:
>> These options are needed by some Linux distributions (e.g: Fedora), so
>> let's enable them to make it easier for developers using such distros.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
>> @@ -1595,6 +1599,7 @@ CONFIG_HTE_TEGRA194_TEST=m
>>  CONFIG_EXT2_FS=y
>>  CONFIG_EXT3_FS=y
>>  CONFIG_EXT4_FS_POSIX_ACL=y
>> +CONFIG_XFS_FS=m
>>  CONFIG_BTRFS_FS=m
>>  CONFIG_BTRFS_FS_POSIX_ACL=y
> 
> Unfortunately this will increase build time noticeably, but
> I agree it is the right thing to do.
> 
> Can you send it (with any other acks) to soc@kernel.org so
> I can merge it from there?

Due to XFS, please include:

Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

so this will not be precedence used for further patches like this
(Maxime already used such argument, so I want to be sure it will not be
used against me in the future)

Best regards,
Krzysztof


