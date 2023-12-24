Return-Path: <linux-kernel+bounces-10664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA581D866
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BDB1F21A52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A71866;
	Sun, 24 Dec 2023 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHU44GoQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B720E0;
	Sun, 24 Dec 2023 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35fcc55f776so14342575ab.1;
        Sun, 24 Dec 2023 00:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703407632; x=1704012432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+TdUy7n0bW8MoAnemDGn/iTVbgzWkn9TsPCN0MQJmM=;
        b=BHU44GoQ2nhYjq1dA+8n6gWpVKZWGSioNZVEWDIcHqvPW2o2SQOOjRvDuC8/+wPDzq
         Sq827ua2UFew/kW8nZ6tPHm1fgmrqd9sGF9PuLv7J32brRhSxj664lZyDrb9zZB6LKPP
         i6qfBedHKm6/f9oidOx7hdgREy91WP6tlkEtpMq46hZ5HD+inn3WOkBaIFLJSV8R5FJ+
         xkNi1urwDPy6cUyNHyvtpi33HOa7fP5zU/swyIR3I/l4M/BOhZ8kx99XU5ZrlVSno8Fv
         WOQNfu5WdLS9udsCw/Gj9g3ixqhO/4U1M5aPPq1nvYai2gD9MGm9sZ5gr+PcqUnE8k/f
         CV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703407632; x=1704012432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+TdUy7n0bW8MoAnemDGn/iTVbgzWkn9TsPCN0MQJmM=;
        b=l21YeVJTbKT0PeHYWpukIDys8Gp3XGrqgDUfP+ti9YeEGw+UE5r3NFRBurgcCtTvIu
         vKnl4NuoXwxE5YnVZtnhbYdiw8i8lWE3RUDkVOjDvULi28QlMJsblH+MezKb1Kv784hY
         oNQhEnOVP6o1Gew9mzDvH1nRIwDSVtOmgXI2oN7KfQNSvN8+tp8ANe6bUwwOb0mExefE
         wHC/eJtlqqmEl7zDIp2dBANIx9iyovs0B0lKlyMO5ZC11bWXdTOGmUOmJSZivbQpLW1S
         lfAGKHXFg9r69eDtc1bCbbGQVU+xGFtg4LoVI7juLX9C3gHcfylsYEEAmfbL5rpYec/k
         +o+Q==
X-Gm-Message-State: AOJu0YxQb0n8P54Dsrip7s+nSBEWrosSwg/EY2C6yXeptjDA0T88eRVe
	YSkA02lOhJ8DHIF0u6UGV6Q=
X-Google-Smtp-Source: AGHT+IEfyabAxIPyqID6z4uLc/cDFZmYixgKiJUf3SeAKqiHZfaGcAN6FVP1MeKJoZBzGkrD20Atow==
X-Received: by 2002:a05:6e02:15c1:b0:35f:c73b:7ff7 with SMTP id q1-20020a056e0215c100b0035fc73b7ff7mr8010250ilu.59.1703407632141;
        Sun, 24 Dec 2023 00:47:12 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:765c:936e:ea43:6046])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090a2ec600b0028afdb88d08sm10020003pjs.23.2023.12.24.00.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 00:47:11 -0800 (PST)
Date: Sun, 24 Dec 2023 00:47:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	rydberg@bitmath.org, linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com, u.kleine-koenig@pengutronix.de,
	heiko@sntech.de, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen
 rotation
Message-ID: <ZYfwDJYesTwnoun6@google.com>
References: <20231223221213.774868-1-andreas@kemnade.info>
 <20231223221213.774868-5-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223221213.774868-5-andreas@kemnade.info>

On Sat, Dec 23, 2023 at 11:12:13PM +0100, Andreas Kemnade wrote:
> The display is in landscape orientation, but the touchscreen is in portrait
> orientation. Specify that properly in the devicetree.

This needs to be merged by the board maintainer.

> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
> index 815119c12bd48..5636fb3661e8a 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
> @@ -141,8 +141,10 @@ zforce: touchscreen@50 {
>  		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;

Could you please prepare a patch changing this to IRQ_TYPE_LEVEL_LOW to
match what the driver is actually doing?

>  		vdd-supply = <&ldo1_reg>;
>  		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> -		x-size = <1072>;
> -		y-size = <1448>;
> +		touchscreen-size-x = <1072>;
> +		touchscreen-size-y = <1448>;
> +		touchscreen-swapped-x-y;
> +		touchscreen-inverted-x;
>  	};
>  
>  	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
> -- 
> 2.39.2
> 

Thanks.

-- 
Dmitry

