Return-Path: <linux-kernel+bounces-90141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05C86FAF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0281C21246
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7270613FFD;
	Mon,  4 Mar 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DC1rQkFq"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444713FF0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537781; cv=none; b=UnmWTe3MNh49fVyrA8AyrbPxF+HwK3Yo3JVw7aVufv2jBryfynVmdIrA1DsDkATpxV6B2fx83FkEH4uWsPTgNCTcJu3BKnJDBZwQqhyMrnBy+Eg0dXRJNDjZDbmizBuEnWAi54ei4noY2Cb4okJIZ5Kalf5aLJ1e4fSBMm0mH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537781; c=relaxed/simple;
	bh=zXQlhn1OKr5ZhbfALUDNhNe8VoKcA7jALtchFjIzMzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX+E4aQCnkdvJESkiowEv3mZl6gwNY3kWydI0BRmgFulUiWNqACB2bJbx2uVnLEpureiZmYPKwqaJgcKGJap2Z28+QpRfO+SLlpYNSbA4zszDqR81tTn2SgEiAAClEqpxv2lqb+umXrWgQcDhHoChqFNarbgfngRrUMrcmv/k6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DC1rQkFq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d24a727f78so49951611fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709537778; x=1710142578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4FlQyVTG7p+3ARaoCOGwbmy/932YEedHD7xhr0/eEY=;
        b=DC1rQkFqxESWweJWvb1PZ2fTBBUm9wom842hGVoYS8C/KivfTn4napHnvTEMzC/SrP
         BL1Fwl49IUBbrkoUh0IMyVWTc15M8ZiyyBWRIzMgQmwalQL3HeaPhnRLG1MnAiSZi9Wh
         RMHvqmGaci/xrwjYgmzvmWTZrL8Nm6DklQymi/MiZDvb6XOJx0DxSnYGRLpeleE8H2LC
         z7XRrQPraeZ3y8E+E4SuCAvdt7AIFHTuVt+jmR9vEsgmFnY+ZAUlTX12PAPR9oklmbPJ
         u2w8xig1hxlGz1ZdZ8xmPyZM29BAbuv2/lmSqkbWIhDeqZoOOHSGtUMkLxSEjcbhme8Y
         umHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709537778; x=1710142578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4FlQyVTG7p+3ARaoCOGwbmy/932YEedHD7xhr0/eEY=;
        b=DLXgN5hCTDfjnF0A/6OonQe+A+tTzZsAfcPjRfC1wWjoQI7W0wqycqx5h/HdO+aqTr
         LWCVDkuVl3w4q45Wc6zfapaoXqwkhGrcsJFcv+JZj89any/DCzj0M9GzKTrSfjXHcC/O
         N0xFhaX6HSHf35B9aP53kIlxSRyDsin/URPXIH9qJoBweumZtLB0z4ShOfBU1hQemjFi
         Jhz3fNkKM/CNYWixAF9B1hBRtOTzqWPBM5vFWWgstCS9cOfWKxNn0rpm32oGsanc1WGT
         Q0broe/8umuGWi0OZMtWrwQtIFeBIckksESknn3nQzwfMsJ6CkoIo04ySJBJmUcN/kHo
         07cw==
X-Forwarded-Encrypted: i=1; AJvYcCURvHJEXbiG8lMg4hC08C6zG95aJFWRiRhWyZFkhHvZ2lH+jhcEcZHSAggVzdhXHEnXILaJi0CjoashQgQ8dT8ek97MMAk8V4BvHltt
X-Gm-Message-State: AOJu0Ywls/qah/EPIkPT5N+k3E2Bj+JsAQzYFv0rfa5XK0sO1vXyUdqI
	uMMambOUo/CUAu/880N38VAMJ69xkeomuIcpRtBlAoltZHEdJI0MPDfyTCvMUL7xbX07oK8lyUQ
	P
X-Google-Smtp-Source: AGHT+IGhKbZArLVZK7s0XrRO/PDXj8uz7pOfozYwmD5XCpo9DhwrJC58mJArQBT8UBVtGv5CvjtxIw==
X-Received: by 2002:a05:651c:10a1:b0:2d2:d6a0:6f3e with SMTP id k1-20020a05651c10a100b002d2d6a06f3emr5837047ljn.13.1709537777893;
        Sun, 03 Mar 2024 23:36:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id c26-20020a2e9d9a000000b002d29e1845c9sm1615609ljj.58.2024.03.03.23.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 23:36:17 -0800 (PST)
Message-ID: <ce1c5ba1-4f6a-4d20-8a12-fbae9003657a@linaro.org>
Date: Mon, 4 Mar 2024 08:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: display: atmel,lcdc: convert to dtschema
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240304-lcdc-fb-v2-1-a14b463c157a@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240304-lcdc-fb-v2-1-a14b463c157a@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 06:36, Dharma Balasubiramani wrote:
> Convert the atmel,lcdc bindings to DT schema.
> Changes during conversion: add missing clocks and clock-names properties.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> This patch converts the existing lcdc display text binding to JSON schema.
> The binding is split into two namely
> lcdc.yaml
> - Holds the frame buffer properties
> lcdc-display.yaml
> - Holds the display panel properties which is a phandle to the display
> property in lcdc fb node.
> 
> These bindings are tested against the existing at91 dts files using
> dtbs_check.
> ---
> Changes in v2:
> - Run checkpatch and remove whitespace errors.
> - Add the standard interrupt flags.
> - Split the binding into two, namely lcdc.yaml and lcdc-display.yaml.
> - Link to v1: https://lore.kernel.org/r/20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com
> ---
>  .../bindings/display/atmel,lcdc-display.yaml       | 98 ++++++++++++++++++++++
>  .../devicetree/bindings/display/atmel,lcdc.txt     | 87 -------------------
>  .../devicetree/bindings/display/atmel,lcdc.yaml    | 70 ++++++++++++++++
>  3 files changed, 168 insertions(+), 87 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
> new file mode 100644
> index 000000000000..ea4fd34b9e2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/atmel,lcdc-display.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip's LCDC Display
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Dharma Balasubiramani <dharma.b@microchip.com>
> +
> +description:
> +  The LCD Controller (LCDC) consists of logic for transferring LCD image data
> +  from an external display buffer to a TFT LCD panel. The LCDC has one display
> +  input buffer per layer that fetches pixels through the single bus host
> +  interface and a look-up table to allow palletized display configurations. The
> +  LCDC is programmable on a per layer basis, and supports different LCD
> +  resolutions, window sizes, image formats and pixel depths.
> +
> +# We need a select here since this schema is applicable only for nodes with the
> +# following properties
> +
> +select:
> +  anyOf:
> +    - required: [ 'atmel,dmacon' ]
> +    - required: [ 'atmel,lcdcon2' ]
> +    - required: [ 'atmel,guard-time' ]
> +    - required: [ bits-per-pixel ]

Why quotes in other places? bits-per-pixel is generic property, so you
are now selecting other bindings. Read carefully what Rob wrote.


Best regards,
Krzysztof


