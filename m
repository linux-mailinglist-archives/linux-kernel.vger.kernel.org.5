Return-Path: <linux-kernel+bounces-55088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAC84B78C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447921C2594D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC0131E47;
	Tue,  6 Feb 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNSe6W9D"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB813172D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228776; cv=none; b=KBWLDgDHQIdHGVJPp4pjyKEuo7FcY/OtbGQrjsD/Z7TRavhFmU9mBpPb2gyz+vG3dHE3DJdttbMf1SIFrycWUcAvlPshdsjWKbGDeqwO5wU9vtjgZUfswsI57jJ3Q4b/frIxOs2zm01VWMS0tQt1bRWM+2Ma1uy6Li/zlKSX11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228776; c=relaxed/simple;
	bh=Bsokvn5YWnf3uoqaFnfN9YvfGrwDEWEVf1pfDUZWanA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMd5Q1QYynvwgt66aEfhk+h+M4gtfuypAyZfGn9iRAXPtMEbXcX/q+dVji6M3AAq2Iz2dLfuGJlnVHJe/CcQfvHaRobYg4xfJiwcTgxdlfSKYVOOYONimf0qiCy2SLD+WtttBZR8d319EPgw04wg7ocp4CBzJ7JY3h8pWmhODMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNSe6W9D; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe32fcbdaso4997005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707228772; x=1707833572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/GUlRf0HmWkHoc7OTDeUe7IIuv9mQx9L8UMYHSrdxA=;
        b=DNSe6W9DkJoXUkrMGXQJWfqkBeVCot3zQlUpGunagiP2iK54ajiKCb1E2c7+0pX6Q1
         L9yvzX6BSIDOt+dJlch7MHyeGEpwIQksDJbEzaevakOZNG/cHPPInAhL0m03IwqAZLpk
         k/TKuoXZQ7+esLkASazKXQKP2zPV2j9tLcP9tvsnB4Pi99+zuklAVewoEqxo34hM+wSE
         0yutnOuf9rZ8i8tikN0CCSxRhMIOhLrVKjZpY7P2fMFxp9c0QfMqfZ58kA128I7QT96K
         zaa+Wt3MDZVqYNGAZK8hh8S68pF+va34ZH3YDrEkbVT8v2svL0DJZUt1jooKroyTfJEz
         /mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707228772; x=1707833572;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/GUlRf0HmWkHoc7OTDeUe7IIuv9mQx9L8UMYHSrdxA=;
        b=DA6/pTyaRkwN4NP84i7WOZTDvreEhZBZjlKD4Q028CmDbN2a842ZWU+/tGvFh+5osA
         D7V+i/A+ICJa+RI/j2dIJeQPR8jQCkIsUJy0gkJ84oaHJv4vo1iF6VwCRbwmDj3B1/AS
         MNt2J6BS9slgfs12D3u3kbTUTITE+GO2RoNBp9+AimIVt288NNrrhdWpgvWKfRcOeUo6
         JEoH2OiPpgcxemEyOrch4YJwUL9oanvd5yX+wvXFW9Ug7FXvUsxPyeidvCXx0c7724eD
         SpYhLb1e1BUwgi1c8VmqWlH+3ue46dhBM1ztP4C8g6isklkdP2Uc5OLDPavPNQXVh+Lw
         iZcA==
X-Gm-Message-State: AOJu0YwtqGz5aG0uaLnm+W//Wv75rVLCsUXMktF79Bz+ysubOmr6cWeA
	Zl8fWoGzbGZUBTZGPh1PdMM29CG6nCV26ppLBKiBW2NRWMs9pyjsmDDqdyTt86k=
X-Google-Smtp-Source: AGHT+IHztXKPPEoRWAl5ItxM7oX/l5Dxb1UecXG0cZZ9t15hDEmGoMSNhlYb/7y1oEuc+RYvYgxATw==
X-Received: by 2002:a05:600c:198f:b0:40f:dd35:9224 with SMTP id t15-20020a05600c198f00b0040fdd359224mr1646897wmq.4.1707228772550;
        Tue, 06 Feb 2024 06:12:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXu+7aOEidgQf+ZljxAaXruBbmXFWN7vR9z/Xj1+EilHtJc4CQHZBO4NYKZVo15M0MdsaG73qvdBsSXXCuGsWReOfWbhkwxwv0xOBJlH/mKUIBwj/sSFVpqgEvX0mrMeKcKBqm1L01vapmGUU6g5fLbgc2XcwMhvdVZA2sXFNP0Ge76dzGNLNTU5jzcA13UlyncTqDZqDUW31pQmqG/IwTgXkVK4tIcd0BWLjaP7ng0xXd3vTiA3Cnto6gLmWSj/4RnUyUsMimpaOmlQhUGT3g8iu3v9tFCekBJairVp/DNC3kUb58BJsOPyrihhB7JEz4Lguiv0jDBbZFSBHPBNeBaO2MgtcUoPY+QVaIAY6TFH5vit/H90wtS5ucV/E2+6qZ/jtiTjdspcMl0jXIPEIWcZDMgLvJn7aJ2A8WdrGJ4UoOKWK5NTYViye/yaKlDPOc6z6betTFmmbqRaE4qW6u83KTS3ByYXgNbAepIWnHzKwPGxRy/QNwU78itobeaEKaSaXQjyWCycUHOb80fFjZSbAkw
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6811000000b0033afcc899c1sm2213579wru.13.2024.02.06.06.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:12:52 -0800 (PST)
Message-ID: <47bbd3e5-d94a-4b7e-afc2-68297f5a79c1@linaro.org>
Date: Tue, 6 Feb 2024 15:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux][PATCH] ASoC: dt-bindings: atmel,sam9x5-wm8731: Convert to
 json-schema
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>, claudiu.beznea@tuxon.dev,
 lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hari.prasathge@microchip.com
References: <20240206064418.237377-1-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206064418.237377-1-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 07:44, Dharma Balasubiramani wrote:
> Convert atmel sam9x5-wm8731-audio devicetree binding to json-schema.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

There is no need to prefix patches with "linux".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


