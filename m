Return-Path: <linux-kernel+bounces-111828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8D88715B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB12E2896AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64335FDA0;
	Fri, 22 Mar 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFRF7fkq"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CD5FB9C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126400; cv=none; b=Euw8c9Z+QOWXo/PZnB+MoZoX6ajA1zoVrg60PFMcf6ctR6OfqTGMecdNkzGUp92aHBlZ/vktfc/7R92RTeqmOifKe9TXju5moMaFCApf2hvNzRkxTPlE4F75zt920gpa0CCEqIAk2s+A7N1dEI7BRkXNYK9ZWGdcsq0ReEdAlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126400; c=relaxed/simple;
	bh=vx3yN0guA2FOX3V5rAXL+YFNjYh0mI7bQ/JkBfHqFQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdhBKY/Fih45seROC30+bhORsjU6AOZs6gakNUtHAosaaBa8Li0syapLlMMeZx/bL/r67jXVrB3G65W4aed8GZvRr/SGsNB/JdXbNuv83JSWhiSmZNeIv8dCWPheMIGB5VzdJ9uY657ewOEcFE870V0OWfe60q2hdvSKceWOuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LFRF7fkq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a466fc8fcccso323780566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711126396; x=1711731196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O62u5y0QOaRfHhYazQdNyLApTvQMwZDuLmZoNOwvWVE=;
        b=LFRF7fkqD/ICfxxJoN0Nom/2LKOUxwx9GbQCtiiXSeo0q4nAhqt9dAQdP8eIGMuX6f
         QzF9NX3V0oYu+3En9OamEe9EXTT63l8OToOSSWIlt5anOZU4983nFdY8vH5rLog+IZaR
         sT9apNbxrEiqn64Q2fXUnb+7c9iY510FxpXEz4srGuEnqFKUCkSmQ6qBVrSuCwTFU0ow
         +xkXZk6G6UGn4e7xbDvYCaMRv4sHoJGRtyoaNL+EciQ1KvU/3T4LpGJYvS36MyDrEae6
         UPzzhZ0UDWFB1YgR+eZEyDZtcgGRra0O46ZOJGQOTD8p46tRuJEKgjW5C3L2WjwM5T3p
         0LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126396; x=1711731196;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O62u5y0QOaRfHhYazQdNyLApTvQMwZDuLmZoNOwvWVE=;
        b=EC1o+I4+jYdkSzNBa1XTcNg9DVZiINljuuabTahHLVLkl5UY/AlNmYdW99iSPJT1KB
         72BA/by5neyVErjrsoB2jpAF475seL3o2O+Hoy47CzmAayadzfQQAKxBdW30KXXhsI11
         7D8XeYypdQc929w4jsmTkUPkFdib0u2pDvL1Au7HspuoIcGoSCvmeVjJv6ydB78RzhHC
         8j1IhTf2JpfeiNMFVMRIk+lL2zGiY9As9tpc7Z/p9Iuk0E5IGgy2E8CDdUZwYGCRlh0s
         kMcUVTnEnohV5h25bN0vLDxtejPJziqUK6s2f5I1n0oJviQUGsDjPLmot1ngKVcT7xMh
         plqw==
X-Forwarded-Encrypted: i=1; AJvYcCXSt3bXJjZexRskh0N8AigIeEQJRolDzQReXdnjDBK5drNQBaD4PAqR9gS7oC0bcrKi4AFiqbZj60sohF66b3MTRbSktvQKDYeJegti
X-Gm-Message-State: AOJu0YxHrFbyO9fSHYTIPsxTBsOtigw+yeeUVqApGM2iuEYP1zayDwjt
	VOZit7Fap4lo3oo/WhHY7P0Vyzzoe9VpH/FbFQdhjAjgcMvRZ8BCXBmqnuUxJ3c=
X-Google-Smtp-Source: AGHT+IGe3jp/SoBRVu7+PE8TP39IN8A8adEgPqCl3Y8pI1hubRGp7IMHccohvPu+6Pq2dNzQgdszfg==
X-Received: by 2002:a17:907:36a:b0:a47:3601:1884 with SMTP id rs10-20020a170907036a00b00a4736011884mr159337ejb.52.1711126396593;
        Fri, 22 Mar 2024 09:53:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id jy12-20020a170907762c00b00a46ab3adea5sm6903ejc.113.2024.03.22.09.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 09:53:16 -0700 (PDT)
Message-ID: <6974777b-7809-420d-ac6e-7fa9660b1380@linaro.org>
Date: Fri, 22 Mar 2024 17:53:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: Add stubs for GPIO lookup functions
To: Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240322-gpiolib-find-by-fwnode-stub-v1-1-05a0ceee2123@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240322-gpiolib-find-by-fwnode-stub-v1-1-05a0ceee2123@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 17:13, Mark Brown wrote:
> The gpio_device_find_by_() functions do not have stubs which means that if
> they are referenced from code with an optiona dependency on gpiolib then

Maybe can be fixed while applying:
s/optiona/optional/

> the code will fail to link. Add stubs for lookups via fwnode and label. I
> have not added a stub for plain gpio_device_find() since it seems harder to
> see a use case for that which does not depend on gpiolib.
> 
> With the addition of the GPIO reset controller (which lacks a gpiolib
> dependency) to the arm64 defconfig this is causing build breaks for arm64
> virtconfig in -next:
> 
> aarch64-linux-gnu-ld: drivers/reset/core.o: in function `__reset_add_reset_gpio_lookup':
>  /build/stage/linux/drivers/reset/core.c:861:(.text+0xccc): undefined reference to `gpio_device_find_by_fwnode'
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


