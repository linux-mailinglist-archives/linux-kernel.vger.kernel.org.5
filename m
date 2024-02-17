Return-Path: <linux-kernel+bounces-69760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C979858E26
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7551C212C8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AB11CFAB;
	Sat, 17 Feb 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="igCbZ5WK"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63918149E06
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708159368; cv=none; b=RpfOYzUqLkWEfwBc222USlwxCvIbTEknfF/ZN85jINNx4CuXvBQzWPsls3tUO4wCmtXEhDCiCjaY/1HL8vDto+MvoAKIcGkXsoMvd89LiqWSYvqmNLhkO9xiZY7r7HzIUrlsft8K70ymum/61X0jZvgzMu7vxZJt9uYrU3bwofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708159368; c=relaxed/simple;
	bh=n6wp1zxuJgiu5yC6GiOaR999VO8kf0Rv/b0jUUPBRkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h55bqev73bKHEvXowakl3JLyNS29FDj1SK7iYWx6N4jH+4exY317IEfAc1oVbeEkd3tcMdlsZirrf3Q9IBk5JdwUg5hIMwrKKzBG+deAmy/QP/dwmH+48MZVEjvMleeD585byU1IrqsOOc1P1ymqSleucE9ZeuOQeUaMMs3HKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=igCbZ5WK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5129c8e651fso1044759e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708159365; x=1708764165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYYykVDdG1iw6lQq7/Yt9eASImEBb9b8/x7ssNqKmSY=;
        b=igCbZ5WK9aH4Gt8tbuHpmDoFHn2FfD/phUNDF8O0GCCtwIWeU3VqLSUNCFYTacCXmz
         MfyTJzo6v4T9s5ooV7AmF9L8dQNxHQ82iqxVLmtjaNQxmFfpDqJaQZUP53PSMd39YA81
         FwXjI0vQpwOHKyyc0xQMq98p7bdoi2plcuXYOSBp8nSWw5TQJ4hydJ5LNEmdmDQOsrQT
         TUMFlUBK6lETAL57dMcoTQd/5otMK9pyaPapNF30rZH3qUcNsjhtVrU2ejX7BdmGQDYe
         tbu7ZstPTbwkP7c+LpmnYodo+pY7o8WGbS9vSifHVPR4SyK5iPYgnnU7RI5MjJxy9VG5
         4sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708159365; x=1708764165;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYYykVDdG1iw6lQq7/Yt9eASImEBb9b8/x7ssNqKmSY=;
        b=xOCFsuUgFmeKE/kTBVAg0mTPpa/WL/8zr/aXqeeY7/Xl0EKEk9xbbT+N9dtkEa5b+D
         QAE6UGIj0P+E/SB3PPEnO2DF0FmDxK3Hl+8ItecaRkGqTV3yUBnGzoLP4Wh+2DyO10+y
         KNbB4Cd48p0N9He54WsBpWC5+YdXjLd3jpTHCMFUgxEElrsMhxUSSPKPbES/8Lnj2G/p
         9T8rfXiUMpaFui28qaGWg8o0YNCQzmBB5mP7JiXZxZYe8BUjVUD+OLI0P/n4T7MBO+ym
         JxvRS5nQBNOQ3dZRsjmu3VJweEa77G212FwZeAcxH9zpK33U5nS8TyRx9HzuKZKv6lfH
         ieeg==
X-Forwarded-Encrypted: i=1; AJvYcCVL1WBIALU9BKiHyeHMYcFaVwQMMewvOWa3RO9IikI5jn8NO7MuqvSw1rH0rbpNCe3VijhBzuYHNN1O/YdVJKnEfA3/0WoYwzsQtxcA
X-Gm-Message-State: AOJu0YyuvI4QhZHFwyik7O+vRdx+NZWHdrijYSxO71TJlADVTmUmjWkt
	pwtyqfzEH0eP2oUHWyAUtcRtpdVJY2m/1/UXDJMNw2HIfn9OfMvHKkKuWI+TwiU=
X-Google-Smtp-Source: AGHT+IHCM5/YQSGynEjqzzNk0YYIlBinQOPwvWgdJsieNLqlJ0tZ2oPbhq+F5v/Sm5RypbYmnWyqwg==
X-Received: by 2002:a19:381b:0:b0:511:5fc7:7b84 with SMTP id f27-20020a19381b000000b005115fc77b84mr4682089lfa.59.1708159364725;
        Sat, 17 Feb 2024 00:42:44 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7c449000000b0055ef4a779d9sm730481edr.34.2024.02.17.00.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 00:42:44 -0800 (PST)
Message-ID: <ffc890f0-3cf8-47ba-b9de-fd4a8ad876fb@linaro.org>
Date: Sat, 17 Feb 2024 09:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] ARM: dts: imx6ull-uti260b: Add board
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Wahren <wahrenst@gmx.net>
References: <20240216223654.1312880-1-sre@kernel.org>
 <20240216223654.1312880-17-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216223654.1312880-17-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 23:34, Sebastian Reichel wrote:
> Add UNI-T UTi260b thermal camera board.
> 
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>


> +
> +
> +	mux_spi3: ecspi3grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI		0x100b1
> +			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK		0x100b1
> +		>;
> +	};
> +
> +	mux_spi3_cs: ecspi3_csgrp {

No undescores in node names, please. Use hyphens.

> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20		0x3008
> +		>;
> +	};
> +};

Best regards,
Krzysztof


