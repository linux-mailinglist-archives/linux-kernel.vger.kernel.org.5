Return-Path: <linux-kernel+bounces-108569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C14880C54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56599B220A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147A2576B;
	Wed, 20 Mar 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRC44tL1"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B851DA3A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920869; cv=none; b=dNELnpDCYKEj53Lm1CfRX1iHQq8kU3i31C8I+x7xU0t2OLHCE8PAtj+iGjnv1QP0QPg5MvNMT+VfR5zKLsc1onHTfYfb7RRUzfhhNL87430Qetyw2fY/xH9QknzzejH6OwXJmQ8K5SY2j1tnSk6uB4/C4waxR8d2G4WQhO33BQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920869; c=relaxed/simple;
	bh=t2wm18haUb5zgLnO+t9LRU0/xcGucVsdjym5/5wtfNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgVmHzAKp/p9OMCpuGH9xnZTlr9nvy3XTL/tkUZ7i/a6UH/DawiFpDnU0CHWD20VWlzqYIvTTAMsVxOlEo464LnDP0NoaqbwDiVdDsGdDbcAkzH4UWj8VKwd2Yzo0KDZ4dpzS7ECFv3SenKoBWYnaV9DA5AQdKS+m3CUed2Wi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRC44tL1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56b857bac38so1336511a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710920864; x=1711525664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f0kRypK3YZBBne8paZFA5fiyJqOqtaf45VrPcMgCFA0=;
        b=pRC44tL1i+GIac1/EZdXgniStfgDc3Zbr0GKCj9NhUjq7P6hpUI4v7nR85WbSLCB+g
         ymK2UorXCds/gg1KjJObyPlHO0I1dKvwhh03Pg8K6Iyv2/eJigvMF3dsMbnEdgHyleUk
         lywJDZFgc96bkeJ5f1PegR/aw8fe23QZzOyoh2zrBYtatpI+btHbN8p2ogoH07NShRX/
         BdshrnLen6eH5+atVUSXJ47EUJuvgSRaN17aqDWibDcrHsIlGUhaglIGpPaWGsyNjQrJ
         IvBp3bYZP9tOjUhgNNsHOggBT1wEyjDIfq4kkt0qI1C+BV1VQ6reaeqSBA5LPUMveo5m
         CaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710920864; x=1711525664;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0kRypK3YZBBne8paZFA5fiyJqOqtaf45VrPcMgCFA0=;
        b=YAcOTwppD+puAqfc/LF6+HedK6e7pdm04rdlSuPiJ3WJpjrcSpNSkEKjrSmFLw9xwz
         zIwDOdZ9wV+W7ZB3YkWIy5seYZ529Ll9NZmV2C9lDJVEnGctjbNmsXwiKc1Kf8GdVD4h
         sul2PNeFXUnE2wsAECfdW5eIlbxE2Z1I5LkMIt1usi7cPFpQt4c5pNHqJ0hg+2hNtW73
         ZOtuTl1bOCzb48wGchHE4SW0xhNFdjvfvB3wnrHUAxZHtWSQPUXSX0htGSF+yn3t+GPb
         tyzG4ViwKUyjSz1Tc95hKqsTv8OhVOLJ2Ni3ubna95HU8HRKUySVMvXt8LMfBkZyF2be
         OZCA==
X-Forwarded-Encrypted: i=1; AJvYcCXakit6O2DPqCaHvaIatEF3eyELmGnb7w7mKyf05ri0Miy6XN4yUeNb7qjiV3JWmvIb4mhJsLIIWgS2khSawJhmnBboPRnnV9EoyWcy
X-Gm-Message-State: AOJu0Yw7ALoQDTmoAV0GAbQzWYaMYlh2lZAZPXW0FFiNf/BuVZsJdBuP
	ZRwk6Jytzk5fhkZ7SbFvj+NdBbamBThX7u+U3GbPaM9FsTI9X6zK4b3hk4mmJyk=
X-Google-Smtp-Source: AGHT+IHsfi3bjT0neqvf5ehY53thvgxCP8uGLAhKGePJNt9nePJzNCZtR2iCEF9mmV7qH9PUYRE7/Q==
X-Received: by 2002:a05:6402:2418:b0:568:d19e:7ab0 with SMTP id t24-20020a056402241800b00568d19e7ab0mr9398054eda.36.1710920864395;
        Wed, 20 Mar 2024 00:47:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ec55-20020a0564020d7700b0056bb14935e9sm352963edb.2.2024.03.20.00.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:47:43 -0700 (PDT)
Message-ID: <918b1700-17d7-4475-a39c-c317472da0b4@linaro.org>
Date: Wed, 20 Mar 2024 08:47:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: fsl: Document missing s32g3
 board
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Josua Mayer <josua@solid-run.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240319221614.56652-1-wafgo01@gmail.com>
 <20240319221614.56652-3-wafgo01@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240319221614.56652-3-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 23:16, Wadim Mueller wrote:
> The nxp, s32g399a-rdb3 board is not documented.

Use full name of the board.

Subject: How is it missing? There is no such board in the kernel, so
binding is not missing. Also, you touch here serial...

> 
>  * Add entry for S32G3 based boards with nxp,s32g399a-rdb3 item
>  * Add nxp,s32g3-linflexuart documentation
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Bindings go before users.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml              | 6 ++++++
>  .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml     | 3 +++

Split the patches. They will go via different subsystems.

>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 228dcc5c7d6f..23bf1d7f95b1 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1503,6 +1503,12 @@ properties:
>                - nxp,s32g274a-rdb2
>            - const: nxp,s32g2
>  
> +      - description: S32G3 based Boards
> +        items:
> +          - enum:
> +              - nxp,s32g399a-rdb3
> +          - const: nxp,s32g3


Best regards,
Krzysztof


