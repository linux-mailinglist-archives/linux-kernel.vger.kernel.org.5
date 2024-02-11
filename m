Return-Path: <linux-kernel+bounces-60788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B117850972
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76975B2178C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D738DCC;
	Sun, 11 Feb 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGcM6h7P"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7D5A796
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707658975; cv=none; b=nyC6rkNXfoh5JfJ2GebzwViyUoGli16qIOB4czd5Glmayc7HjxEP+VI2e5j4JbEoViQsLQ+WrEv4iRVvDEp11JeVntHm9q2IFqixd2q28np6E0+zF9ZorqH/4PcOkzaXpGV/EKyFK/5FAWDUglrWRlZz3Z27vdZxihzOxg0GTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707658975; c=relaxed/simple;
	bh=4HICgIwcA4E03AfeL5kgkyGrXmMH3I2/2JdFXSNqDhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oEpXkPO3GpssB7QCO0sdl9VbPKOOTQ0HwhndndIWRGMhH91ZZDcA2Dw8Iz1dPSHb4B8HX9y1EVPrGx4eoYKTs3ttpfqCRLUzrT0OnBLXGQx0KSMfnEHTFwx0r3Ko62O7cHny7Ts3iFoeGVS4+QMGPmFn68Oyg16RG3dd4P63byk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGcM6h7P; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b13332ca7so1335509f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707658971; x=1708263771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNl2TNJJT9F/ECiKzGFxOoeb4VRRB8d6Ro6PERp/HBw=;
        b=vGcM6h7Pvy5WetFXJ54u/CoUEihh2Kh2d4HP3XNdNqXqwDKESNoyeMvezGVg8U5tiN
         PuhILZsobyMuun/HcH9nLf6aDWeETUGqm26IF0H1W7KITJ4xfOW9zEeEu9/67QaWeOdD
         hSI7u4XiL2+V1vrxGDhSYXZ410pRHYx3KqLZzYgMsnmWK9SGC5BNQEjhvrWnWp6ygB1F
         SlgOH6R6WL30ZiiNVpGSJj3+gurj8y6HwzcvgwOe5C+Lt8r+A3JM9YE7TC8rYakHDZB5
         X6WUI+7CoCTPksCMYIPLWk1kbv2l8Z+nnLOP7KwO0ixM3B69F6ZUJT7a0b8YP3WUNH8S
         K/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707658971; x=1708263771;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNl2TNJJT9F/ECiKzGFxOoeb4VRRB8d6Ro6PERp/HBw=;
        b=k13B3zjZQOsH0pvlbdP9b+l5rQIOzSb2MNXI44I2qgCvzvRhbDh0RfpiJUCpu7HlpP
         9pN9nMjvZRFpig9FQdUH71/GYypWilFca8711JEZpSvQmS5Jcu1c8eobLRWbqn2E8yHm
         imU1ZsyKmZ9PC06XvFe8egG6flsoJaY1gL7XhL6kLgmVV6gW91CQqC7FuJSzlL4tH9xv
         99EkbODMcR3wti1+1YsLZyVe4PLN51btPSOthgHDO7bMukPXdI0MoUUjoKPOpMy5ka2s
         xfd7AHO/ApcdI/z6LSWDu0MzubZX5X5jMECLtH9NKo7Gawq44pOUHirYHpkyIj2BKt4H
         tR/w==
X-Forwarded-Encrypted: i=1; AJvYcCWWWhLsoJMqyMP4+1rRtaeOUC/i0dKsS/JKI894mUr5pT5afWFzVbAOJJKeDMfSHiUqoQTxFnBbbarpeWlO88LSx3wEoHyedSeFQtO5
X-Gm-Message-State: AOJu0YwXeCJfDxBzCe7JiZ6YYV2ellQ88rkYJsLxGleSBjAl8NsAk2GT
	YclyJp13Z9+rM+7FLa/BjpR0jVYn8AnPIiTcBavmThAfRq/i2f8xa7rhQRD0ASo=
X-Google-Smtp-Source: AGHT+IHZ/a5U6it5nOITDX6BVKRmPbh7X1afwcLmxuPyfMAqtYz3gHLXPT8ZIBqIsDnKSqR/+VJpqw==
X-Received: by 2002:adf:d1ee:0:b0:33b:649a:1a12 with SMTP id g14-20020adfd1ee000000b0033b649a1a12mr4062726wrd.55.1707658970873;
        Sun, 11 Feb 2024 05:42:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXp7r9BIoB/cXoY9YZQSb5jOs+5TxAm1QbngscDcGXCd3VYAoUurb6YMWRyhbxrbC+veqwNRiX3IEg0teXQRmJ9O5IrqtjGpLUvMe8I+cUuorrKAZkkqnlg13ImHzbjuHOohFgNigDuO9fkZk8EvWtoo3P1N11DjI+1rYdZ4Gj9ZUBW9LPKbrTJr79MY6smBKmfbE6SZk6oyB90L0uI2Ktv1nidF67JEpbi8TlWPUqGlr7G7GptZ/QUbFATm8orhvg3XIoLlPTaV/w6aJsrQgVLTqBUKIpaKb//h0htOhNGPC7L2r0mSe/s2HLum4ocKd6XaX+J0cf0Bb2MdRBsOD+QkOyJMBZKywmTPP9uN1iKQfDhJfanR38FYnS8Px0YktK5Ylrv2Bg6nSFmtgz3kbUDLzEYWtIGgMfoq+nFwKj3DmiQF1x861bpAN2YrrwOeTUH+cABU5AvZQa3K5jrZ3SjNKISVDW2yboZQoENTvBi+nX+3Llv5C1Pq8zgzqAB6ZY1uXAf1+creAgbla8QmK6ZrGZsDfgjMm93zET2WO9qPOEKrvUa99tf72xRllcPS/nVnrqatXmwvu1hNrSp+bEWxTDWHs16gSQ0+XdN/Qv5qaiJPkF4hCJVR50VfKfIVKsHD1wEIMAb5ikmsFl5L40iBwovmB97fTpnfW5L8xz5HwPe+6fDbHTTT25c4ntM6VjOO++CcvDxHYsiiIb3rgh9aawVU0qSA00iyHTu9mcIfsniZ8zMNdbtcOc+4jR8HVU=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id dv5-20020a0560000d8500b0033b483d1abcsm4273462wrb.53.2024.02.11.05.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:42:50 -0800 (PST)
Message-ID: <b6c28118-a20c-46a5-b070-2306d4c0b2a1@linaro.org>
Date: Sun, 11 Feb 2024 14:42:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
 <SkyLake.Huang@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <745f8b46f676e94c1a396df8c46aefe0e8b4771c.1707530671.git.daniel@makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <745f8b46f676e94c1a396df8c46aefe0e8b4771c.1707530671.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 03:10, Daniel Golle wrote:
> Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
> via USXGMII PCS:
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
> 
> via LynxI SGMII PCS:
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v3: Add reference to MediaTek-internal "pextp" name, better explain reset as
>     well as 10GBase-R tuning work-around.
> v2: unify filename and compatible as requested
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


