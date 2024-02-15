Return-Path: <linux-kernel+bounces-67474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C8856C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E701C2098A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CB1384A4;
	Thu, 15 Feb 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIY+9Vl7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CB1369AD;
	Thu, 15 Feb 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020599; cv=none; b=XcPpAR+GguhKIr7jeim/OtziCAF66VyH5PGvLzBztdo9h2wLiRTawY6BR+H/8l+nKx6TEMAAHCydfcCCaBlLuFoAA5TkB+xNnB5biXAl/5JZjGg1sJWeHB8Z4Ljkyj6mkC0crLKcPl7Ki1CNuP1Kt3qERvhDLmQl33AOlo1yBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020599; c=relaxed/simple;
	bh=9LTX5p5ECOAIOrnzChPk4OdgPxQGNVKmHTp4cFz6qSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg+PMcchCyTOQBff5Qk5y3KyEeCWHr/863MpDWuBKwZELTICMp1Y3F1rWC77dhb2ssH7a3b3x3xyZFrukQ4s9hxTODUiz4qVF8UXDQETJIb1DFeqVYMgsoP6qDB6bW/3OmMwhv0BqdjBHIb8l2SiJoCiAvOcwIeryHm3UIND7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIY+9Vl7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51181d8f52fso1473663e87.3;
        Thu, 15 Feb 2024 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020595; x=1708625395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsK9sMUkCnAium0cXNBDUzfqUg2ZTSLKAEAIbODiMlA=;
        b=RIY+9Vl7VG0jt5rGLAq7FcR2bqFMEQUDEHPcaX9PRaVq3UuiIuMimDnrmvmisZ1Lh8
         hJRrC5sAT7wHWvNjvnm0QpHsQY5RWmNUIDq/J6mgVq+Sx4fwmZg8NxN1JrremeyX9DSN
         /hwPNia5URc6CNYqKIqh5MjbczeFgVctvjlZSFrz7YmKAbkKIzeNUYGia04i9ZX9o6wf
         eqDHe89/yUkt3N5x0PbU3lIlmayfPJ7eR/x254By2o0dMN4/W/OJpx+dSiFYxBC67q+v
         KCrE4iNI+SF8zGqFeUWiG5+u9Y2ei+Y1b52LYwqqM5WU4tFh/kq5Oz3icKgmpWMA79VG
         7+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020595; x=1708625395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsK9sMUkCnAium0cXNBDUzfqUg2ZTSLKAEAIbODiMlA=;
        b=mDxR62OJ8rp5jWoA8/JT01ZbyO8xHh0Cxv3783bGkhO6hKqRWbksc6ZL8MVM1IOnmG
         jfHuMX3C03ZR05O3uadJhJYLIHRkKNcSdtxjn2JUsqwrc7Qb+yPuZkEPmOpcE97uI+9w
         7c+3GSi5OKZCPBo39cAvyFzeB3X61IEUIAqfmi8sSFGnwfoyZC8HXWtJYKt1xNgjmG9y
         bqb+yIdoN1BaBUZJmtBu/y+za8dBXZQ4i0eBcSXuGZeyoDdLtVs102ic3wCrR3PKWw9Y
         WscSvjnSyEx4YG+P3sjq69Kaqn53S9k6Wx9scYqAm16WkpUczpWAho7BIedYHVkJoWrt
         oZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCVcrBBs0YEO2zulVsKhaH7s0s6TfA01Fz2O5tWozu0sQDrsRf78edgVPS8epk5qxUP8LuqZcNo6satT32TXrZjcWpbTMH1VJbh8lbVt
X-Gm-Message-State: AOJu0YzviAMVN61dWd2jn3c6dCLeFtkOTDlLbPdAPA5k2uUsZKG/Dta0
	jjVLQ83hMfErQAZaJmHR3AgyMM9QIGM13wjjf+FjzQHXewsNGJ4N
X-Google-Smtp-Source: AGHT+IGmPCAzrJRmFJvVMrsiuRVs+q5aNELJEAQBaCzuITGqFHhoSV/ayO6lNlEu2bIZKCXz5Vbnig==
X-Received: by 2002:a19:911e:0:b0:511:941d:37d4 with SMTP id t30-20020a19911e000000b00511941d37d4mr1823053lfd.5.1708020594849;
        Thu, 15 Feb 2024 10:09:54 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b00a3c5d10bcdbsm782485ejc.114.2024.02.15.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:09:54 -0800 (PST)
Date: Thu, 15 Feb 2024 20:09:52 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 13/15] net: dsa: vsc73xx: Implement vsc73xx
 8021q tagger
Message-ID: <20240215180952.b55l3qxno2mexqqs@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-14-paweldembicki@gmail.com>
 <20240213220331.239031-14-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-14-paweldembicki@gmail.com>
 <20240213220331.239031-14-paweldembicki@gmail.com>

In the context of DSA, tagger is synonymous with "tagging protocol
driver", aka what the previous patch implemented in
net/dsa/tag_vsc73xx_8021q.c. It would be better to rename the commit
title to "Implement the tag_8021q VLAN operations".

On Tue, Feb 13, 2024 at 11:03:26PM +0100, Pawel Dembicki wrote:
> This patch is a simple implementation of 802.1q tagging in the vsc73xx
> driver. Currently, devices with DSA_TAG_PROTO_NONE are not functional.
> The VSC73XX family doesn't provide any tag support for external Ethernet
> ports.
> 
> The only option available is VLAN-based tagging, which requires constant
> hardware VLAN filtering. While the VSC73XX family supports provider
> bridging, it only supports QinQ without full implementation of 802.1AD.
> This means it only allows the doubled 0x8100 TPID.
> 
> In the simple port mode, QinQ is enabled to preserve forwarding of
> VLAN-tagged frames.
> 
> The tag driver introduces the most basic functionality required for
> proper tagging support.

I guess this sentence is in place from before the tagging protocol
driver split in v3. Please remove it, it is confusing now.

> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v4:
>   - adjust tag8021q implementation for changed untagged vlan storage
>   - minor fixes
> v3:
>   - Split tagger and tag implementation into separate commits
> 
>  drivers/net/dsa/Kconfig                |  2 +-
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 38 ++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 3092b391031a..22a04636d09e 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -126,7 +126,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
>  
>  config NET_DSA_VITESSE_VSC73XX
>  	tristate
> -	select NET_DSA_TAG_NONE
> +	select NET_DSA_TAG_VSC73XX_8021Q
>  	select FIXED_PHY
>  	select VITESSE_PHY
>  	select GPIOLIB
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 6c7bd1c200b4..9f94ae8c763a 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/iopoll.h>

I believe iopoll.h is misplaced in this patch. Probably the first one to
have used read_poll_timeout() should have included it.

>  #include <linux/of.h>
>  #include <linux/of_mdio.h>
>  #include <linux/bitops.h>

