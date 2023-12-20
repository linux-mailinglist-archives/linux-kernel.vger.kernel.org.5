Return-Path: <linux-kernel+bounces-7334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA881A5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387B91C2284D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DB4778C;
	Wed, 20 Dec 2023 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShoNqSbo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3046B86;
	Wed, 20 Dec 2023 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so59690715e9.1;
        Wed, 20 Dec 2023 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703091877; x=1703696677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INk/MVNoQ2UUzk1dXHvibFqURoJv1a6zXTU0efZViEM=;
        b=ShoNqSbovQcGEnuefVMu0d4cAusw/QJecyNDGB9Jcu1VrrxY6dSNiD2UNFu7tu9F58
         xot4SL8dcyBHuqBJKIeIT5BlLhh2/QQRwDujvzlsWt1IYhh5Ef4ZEqnxF/IRvDURikSR
         rGKbPY3Zgk0R/V7rUInv6Cfw1zW3RZr+R+3KUefG0MT/Uv6B+wVvlytM42m1prLxG3Y5
         O9soV5+L42LBK5b0mLFAEk3jQW1CVOmibAGbFlETCpkMXGepX5ETLL3n2BruvKKx0lDM
         NPXyk6d2LTM3xlMBGGaNptrY+mGpxQLhZ0Wv7sgREDlTRyuygVzc/253RIjhkIbBinJn
         7BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703091877; x=1703696677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INk/MVNoQ2UUzk1dXHvibFqURoJv1a6zXTU0efZViEM=;
        b=DRfOWwGH7yv7khTIPDGyoHlOU/DwqoRk6HBTR9Fz6DGMVBhVJwxPx9oB4GF5J4LRvt
         YBzlOo3LZL8Pv6vWrwqhlohbJuvDu0euu2FmLFEpYs5d0D0aOp7rOUaPqxaaLfO/Ryo5
         5UKVuFX7y4gg0T22HVSZiu+6NcseokSHE0jbq4pZbfYMq9EKaYWJdEs/SYrpkWu5BMn5
         LjDYQG0l0PrBSfxQaIs/A1yES2TJIVexbwKuoNpCwhT+/xx3WlQCOhQFkWVvwsOWeCMk
         clyM94F1xzGZk7pnRd3GHKYJPtaIX2AWSPG5QrZxIZAhobcXPYQOWR10kxQvnyrWc9Gw
         wakw==
X-Gm-Message-State: AOJu0YyTmK0h3v9fdvT3LA5MMRIRmY+hryk9dmMOWNwPBUoXYJI2VN7u
	WnJL2jZnSxZBYLPH11StmqI=
X-Google-Smtp-Source: AGHT+IHh6y/Y+b5+6bjmUDcz9Rc43dU9g/m+wQbExtDATUQ5/6ZmupKkVs8JknG1LfDY/thKOV7L8A==
X-Received: by 2002:a05:600c:5187:b0:40d:33cb:b577 with SMTP id fa7-20020a05600c518700b0040d33cbb577mr9913wmb.3.1703091877345;
        Wed, 20 Dec 2023 09:04:37 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0040d18ffbeeasm243399wmg.31.2023.12.20.09.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:04:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 =?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH] gmac: sun8i: r40: add gmac tx_delay support
Date: Wed, 20 Dec 2023 18:04:28 +0100
Message-ID: <2370947.NG923GbCHz@jernej-laptop>
In-Reply-To: <ZYKvCQBD-SY9uVLF@debian.cyg>
References: <ZYKvCQBD-SY9uVLF@debian.cyg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 20. december 2023 ob 10:08:25 CET je fuyao napisal(a):
> r40 can support tx_delay, so we add it.

I don't see how. User manual, 3.3.4.64. GMAC Clock Register talks only
about RX delay.

Best regards,
Jernej

> 
> Signed-off-by: fuyao <fuyao1697@cyg.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 137741b94122..fd07573afc9b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -127,6 +127,7 @@ static const struct emac_variant emac_variant_r40 = {
>  	.support_mii = true,
>  	.support_rgmii = true,
>  	.rx_delay_max = 7,
> +	.tx_delay_max = 7,
>  };
>  
>  static const struct emac_variant emac_variant_a64 = {
> 





