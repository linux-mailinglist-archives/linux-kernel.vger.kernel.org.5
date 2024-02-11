Return-Path: <linux-kernel+bounces-60861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED88850A45
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E22283E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E85C5F5;
	Sun, 11 Feb 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEAyA/EA"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DC5C022
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668547; cv=none; b=VKgvPP5qhu74xSotcWUxdhFopDUUAvZI262HCgikvQJmD5xRpPKrxWQsqWV+UuWkJ9pleupTNvqtPZ8vdWxknfTVO9G+EdHSKsAUFfi0b06j3j8urFmODxWcaikKNmjja2AxQF6Rn4kBREWKYb4hljDabaTQMOBXDlaLC8BspuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668547; c=relaxed/simple;
	bh=4TJ7iwJUUPfSd8brhjEZk/AUgvwZFEN9TUl3WlovXdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF6neiiyPIp83SgRVjYQsUfgTu+go6ERDpcX79wFKTPQkEE7COBY1JQ38MdBrFmNG9wJbHpjRFNVPdyVtFSCg6Zt4OKqi69+Rdj9kbYm/D1umFFtRHyjbbSrFU91Cww0izjEsDHWbVQhCm7s3erm2ZjvRAUR7pO1YLM9wTFDAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LEAyA/EA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410cb93185dso2022515e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707668543; x=1708273343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f4iW1GiC7usDkHdDRoW5igDjKgk1D4sdUpRvyDFiIWw=;
        b=LEAyA/EApiAzOKpxvtYCUynBsuF6Tf8BS/M9B8zOJ5rp9aZTO2BPcrPj+bvTMU0MU/
         CAwLgxTQgbS/xwViYYnHY9eOUt/xaNCniRwhHk04cB6JkUPLSeSxmVYjtslp6C5ou797
         3vOLKyXLQAaTWjIWAJ1FV8+70rkN4d0x6J7ArYYeI9aTyj1XQUaqvY7WTm4Yb+ngKAr+
         zYLo6wBGsxScwLAGmUf+ad+FqxgX5+eziG6xcnBrh5qvp7lHedFjcA/H+vsZiHK/cEsi
         k636Bu4oJuUKOjY/GEen1mCflkMket/4uQjM2weqco8jgqVLOCbbVhSiZorMh9UFBF5p
         B8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707668543; x=1708273343;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4iW1GiC7usDkHdDRoW5igDjKgk1D4sdUpRvyDFiIWw=;
        b=TmiZrhSZxd7TjiojjBLss97HIb3v+xS2fPCQNjJ4EQG42ROtfABjR/pSyp/TOrH/NS
         gHItM9pvgbG8QnwmaO1aCOmrVZsZGQ1/sMsYAyNOZiN4BtLH3xd2BWASj9EMLwmmHwcl
         aJaoY+YdPGUmSzOtXUsNXDQYO0QGcQiLhjwHzgLrKLcbe2fr5lI0ESIOjD40Zhjwe+8h
         sBUYt1XmWkJ6+7pFyO4WBRcuvIHTQRlCkJFEObkhndlMi8UGrPd0DE2RiAbPIiwyhTmF
         lDq6FN4IjYd3nvQiy3DRu5vjF2gUUcNUIFFlaU3t+395Vk2IHxdC7/FgcQ/PNxXuqfIF
         yD1A==
X-Gm-Message-State: AOJu0Yytc9dpAj65zOxwncBYIdWHtjmeD6HW5WZ2efzRukLnSNY9BmSb
	RPVI5v7zRa1NkL3avIjF5WHMhSKh6zUqOsrlGxHUhyz+DkA8EibR/qfPTH0C2s8=
X-Google-Smtp-Source: AGHT+IHQRhs99L412W7tmV3PSlhB5xIFz/KqD4QsUXYmyt7xOLWNeBRKZSqRv4BTabO//XPoRpZLQw==
X-Received: by 2002:a05:600c:470e:b0:410:9b23:43fe with SMTP id v14-20020a05600c470e00b004109b2343femr2566055wmo.8.1707668543405;
        Sun, 11 Feb 2024 08:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmYO5ttjSAjkKvM/kMGBoLSGl3vleS2unNyBYxdtAbWU4N4RxT4D2lnWR3vGwGjXBV4h5RpP4yZNz2ySLUYKYRHwLMXL3i/C1PfcxWH4ZCaWEHJvOUsuSDlRF8dGcbC8qSNemlFvxwY8DdXApspkHGR6ZrHNXvbNcwXZP8yTyWff5oOiSO3ysUj+c6cXEDSk5JfbXMH27lwy8T1q5dx+sd1YbBGN0GvgTn7HDmQKhLIa0BRu49VMIgZZNcIwJWIb5PSXn1sVNQa75PmWg4dAtuWtD12Ffyo60MJrAT4d9Vzb3ntfeVTJSo2V68oZWXcAmJLauPf/3rglDOPnKZJV2qKXD+E138jlGEHeJ/Yk7WQAggxKv1KdzbiLWgJ3xi1/2FywYKZKdxccFZgkkgikSRFCCgnSnkq8cqjIo/1Gq6DamknkNIhp3cJ2naySAEytMJyTC4iwGQjOI=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c298400b0040fdc7f4fcdsm6216986wmd.4.2024.02.11.08.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:22:22 -0800 (PST)
Message-ID: <a5b049eb-275e-4386-be24-884575218d9d@linaro.org>
Date: Sun, 11 Feb 2024 17:22:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] dt-bindings: rtc: abx80x: convert to yaml
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
 <20240211-add-am64-som-v5-2-790ed7121249@solid-run.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240211-add-am64-som-v5-2-790ed7121249@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2024 16:07, Josua Mayer wrote:
> Convert the abracon abx80x rtc text bindings to dt-schema format.
> 
> In addition to the text description reference generic interrupts
> properties and add an example.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


