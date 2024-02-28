Return-Path: <linux-kernel+bounces-84592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE486A8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50EC1F25B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB1249FA;
	Wed, 28 Feb 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6vxMFA5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A523776
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104569; cv=none; b=uQkYKsvUFL9Hqjwv5M13zv/1uk8qFBjlb2LqDWDQFrNlx7NIjU2fWa4yT2xQb1XStsx9SNFrA5OB/74tu57Ml4+Z2FuLkOYFejER+y+UUDb+dS7vkNGO3cOsfWZTJCJAIihguj5XVEltvML+frxlpzd/47qw3Sc4JnZ2E79D9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104569; c=relaxed/simple;
	bh=kP6EhqgX4zAW40ee4Wjsq5nzeskS5lh4fQqG0DDbjjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLUWLu8Ew98bKp6b6/Vl7QyeY5uotklPrRYpDlC4nSxSH+PnRrAkrh7zLd3u56wLoisNuetGM+EyWS81ckPrFBNK3Nkbj+VGmroNgY5SgcnV6FyncmKhY9vERALDGL8Sm5xjZuDPAPFOJz9Kou+n1QLxW+3NCnOcdodiuh9Z510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6vxMFA5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3f1bf03722so564346866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709104566; x=1709709366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ7mCshscH03zdPfSCxaRDMnzsL5ca+QWX2D+X24Uq0=;
        b=f6vxMFA5yZizfP8brTU5TnuQ0YNXwo1iub09R5dfD1UdSpEnfttsMjGZyaVcxgQrU6
         uwKCQZohvgtNvaRIJGpT38IXj+cdb91wGhvBVAk5E5vlenZ8ayAuza0uGp/IE1l3tm7/
         nyBiLe9TrXPbe1pyMqSrHY6L8Am7duVApDi7yvJeaZJLK++K5K6C/YgSJIgXRQZlQU1G
         5NGavRdTROE1glQDs0Mdkb1jFqeeBeiCZtVOIBFSQpDfFLfI93hGRGahhwvHrjzsJxLc
         Oq8433mtjiJ2JeDvuxHmT2PtGxIenMHX9cal9A6jWMs3P+a2b5QX1D4rqs0ACTzod3Nv
         v2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709104566; x=1709709366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ7mCshscH03zdPfSCxaRDMnzsL5ca+QWX2D+X24Uq0=;
        b=SCilp3r3ky904H/BPDdD0eXGl4Vz5+kCQC1mr2AeblVhsTdgvi7iUR8PQqKgPa2wdH
         iqbDGPzKie2kLgtjIPAExxgzKHMDY91QDe5zqtv617nnY9Gau8LGRjoXDALuxKVA09aT
         EYTQdwRYGaCVhK8kHTH1IY5DzPsRTvikOIgiENqmSABSNHnZbsVj4ZdOXZyKZpXEsXwi
         Z7/43YNAc5v3GS5IuVuOQCbr4FnS9qJNCjaI68I7LCVwg8gzAyTRv/NbtNiZMrpdOohC
         olwx+x6R7SdQy/8p5aWEnafEIdSa8nCEzuD4W5DbI5yt3Hei2wkOi04tuEMJCnHoGu3/
         I0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXNz3lT5iXtwP7E4jYkUU0Dit9LPdAsKttlu+Cwi6yjad+G1555qsZxjiMvjsMjU2EfXRi193hqMPPr6LUvM0yPM/Fry3kPBSw4apYe
X-Gm-Message-State: AOJu0YybIvmudAPluAs7zVfkvoobOIBfYfWcBkOifuhNG79hn1miaZVv
	683TLF6mIhE0qC/+ools297wucMwcUM6S9c7TQn1VMWfqXImQyXosJIKG8mRb3k=
X-Google-Smtp-Source: AGHT+IFMNd53LUeddw4+PtSHexD+bs1oYrwdttLjOpg6hsU0VkQRrP0z0fdJdmBIv46uVd2CMtQjww==
X-Received: by 2002:a17:906:b106:b0:a3f:d7ee:5fdc with SMTP id u6-20020a170906b10600b00a3fd7ee5fdcmr7810816ejy.46.1709104565879;
        Tue, 27 Feb 2024 23:16:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tl26-20020a170907c31a00b00a3fb7cafad8sm1542085ejc.39.2024.02.27.23.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:16:05 -0800 (PST)
Message-ID: <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
Date: Wed, 28 Feb 2024 08:16:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Content-Language: en-US
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 06:12, Dominique Martinet wrote:
> From: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
> 
> When using dtb overlays it can be difficult to predict which iio device
> will get assigned what index, and there is no easy way to create
> symlinks for /sys nodes through udev so to simplify userspace code make
> it possible to request fixed indices for iio devices in device tree.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> 
> For platforms without device trees of_alias_get_id will just fail and
> ida_alloc_range will behave as ida_alloc currently does.
> 
> For platforms with device trees, they can not set an alias, for example
> this would try to get 10 from the ida for the device corresponding to
> adc2:
> aliases {
>   iio10 = &adc2
> };

Sorry, that's why you have labels and compatibles.

Best regards,
Krzysztof


