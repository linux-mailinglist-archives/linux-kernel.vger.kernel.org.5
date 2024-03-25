Return-Path: <linux-kernel+bounces-117031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A388A654
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770B2C50AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A179381D9;
	Mon, 25 Mar 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHh6WPfN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270512B77
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370742; cv=none; b=nrWHCJcSBG3+e2luF2bNvsw8TfoRtLy8ogLqBuWzcZbGw/R+QUdwI9rWJXHQTs2mmJvYrn19EU7SZaLtjeMNErYYVvK5W8ojW/CGFQzbU+GHg9xh0Knc/E7/4ILGWdIS84t8dfrHFRahWT1v+JATt206mowldc7qJ0FznKN8+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370742; c=relaxed/simple;
	bh=jFAJJBZ7w2HGxEoQD4IPOO+YemTNHNOU01iTofesezQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFGrRBXlTrBEZA8QqkLzBNg3wD4jp4xzxGpNzb1T/ucF6QiRBysw/hCQD8cHNzz+1HN8F1UQRNrcP2dLs0kq8uRJmGA37P22jD7iZR+vDABpfcSn2Yw5VHmJzAksVLj0Ma7jQhNnkjBY9BKyubVW+4rIATrY83kx5FKErzqOc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHh6WPfN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4147e135f4dso18056855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711370739; x=1711975539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mr094tqbb7t0gaddbBeDzNaAJNuOic0uHzVPON5hPTo=;
        b=aHh6WPfNuxDdhzXgqDBwQyzelK4BBytCAwJqgpIvCYL+lsl2I1In/QMrXUuaKQj+Co
         y2TCJpWJNuXdv/cfWFD7lTL3NlvoM5l+Le8nc5G4ZCrSf1771RN/QNLixQuDLIpE0rjm
         VIlaiXaOARzd/0KzVhkBseDsqf3vS+knGUmME1ioxy9ufu7mwns6Nlay4W4xDYvKo255
         klI8EnqB6gVXCDePDZO/fyb9sUGck4zDAeivTKZFKlRVhHIhLaCFRZ7AS9mHTFSpx7uJ
         SW4NAu4LTrAyOporDj/sD2m60ZI0p/fcdp26e9nvSW3BNzQGclOKTmpHOD7N7+uy9sMc
         UTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711370739; x=1711975539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr094tqbb7t0gaddbBeDzNaAJNuOic0uHzVPON5hPTo=;
        b=swcsCsAsLxmWmkDEEQ6j49QyTs0bb4WP8NTJ60ET6Fi7A0lHtKrR4FH88EWNm5VdEW
         WVxQR6wDyMx8JxSV9OAEvkusFlzI0vh67+kU0L+WEUtj+la3BPMghlYPvZsyV3L5Qxi9
         GhYT6Idbnp5n3QeoHs7X87GSbhNZvCHfrUu8WkWy6/ZHgu7S3qrHkIOs3ny1oUlYccj4
         BUzNkr99cJ9V54XX4t8TsEmXrwO6oAMJpvA4O+mA5Pakb6w+Qn3IFvJNZBJX+Pe7mNcJ
         cii3MVBNbsqVKTeUVLuH4FBhYmakSS+dZ4aManUuVhvRkNbqIUiSb6hLo4IWROVAw2pj
         DVew==
X-Forwarded-Encrypted: i=1; AJvYcCVg9l0Ll1XPF49K4m2xCa20P29TiGCeNKH9reX/IdnL3NFn18M5XtPbrUtBW41HhsKXB3I4HMEA4tmK5hCzYYSW74qjSpTQBOVIufqq
X-Gm-Message-State: AOJu0YzHsBE0hr6viiL1uD4vR/S1MziuVkwaRKtolemeVySmK7YSV4DE
	4IRdo6avdqs7SNm/yjm4mK/9M36YGgHlSp5mOEWvNd/W0A7KWl2cnoF3lpFnkO0=
X-Google-Smtp-Source: AGHT+IEdhASmhpgpMn0JRksM/eo2Hqq1dK9CQwhtcLk2Ko9opS+KAE+Y9nF5MLutxyGPWmJ/PyVnow==
X-Received: by 2002:a05:600c:1987:b0:414:8865:bf99 with SMTP id t7-20020a05600c198700b004148865bf99mr2767476wmq.27.1711370739088;
        Mon, 25 Mar 2024 05:45:39 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id u13-20020a056000038d00b00341c934ae4asm4402949wrf.75.2024.03.25.05.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:45:38 -0700 (PDT)
Message-ID: <a385246b-bcdf-4fd1-ba28-06a5d2d64e21@linaro.org>
Date: Mon, 25 Mar 2024 12:45:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] ARM: dts: samsung: exynos5433: specify the SPI
 FIFO depth
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org, andi.shyti@kernel.org,
 semen.protsenko@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, andre.draszik@linaro.org, peter.griffin@linaro.org
References: <20240216140449.2564625-1-tudor.ambarus@linaro.org>
 <20240216140449.2564625-6-tudor.ambarus@linaro.org>
 <1d9f160f-e155-4d2b-b598-d1dc76e49110@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1d9f160f-e155-4d2b-b598-d1dc76e49110@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/24 11:13, Krzysztof Kozlowski wrote:
>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 5 +++++
> This and next one has wrong subject prefix. I fixed it.

ah, s/arm/arm64. Thank you!

