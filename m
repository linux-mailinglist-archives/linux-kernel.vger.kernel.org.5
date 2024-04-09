Return-Path: <linux-kernel+bounces-137111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419189DD29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C7AB236C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF01304AB;
	Tue,  9 Apr 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alofp5dw"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADA50275;
	Tue,  9 Apr 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673842; cv=none; b=qTIdOGK72g/XznKMU2xdSrpuHgElAH57mMh9oGkf4DpnLJnIu6zJuL68mHHpAjmTuM4PIDH9p1zcCnivmpVtkEJ1rXH8Cpg2gAROLPq4HDAcBvBDyj/2LP+leQm670Qj4laM/kKkbBTgvbWfXv1as8paC9lPU7aY7Bom2BQSvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673842; c=relaxed/simple;
	bh=TX7drptoizj7yMo7tlk2MRiASPssDjpb1m0JlS/t/KY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Y1ok1ioTQWwIxhdVS7q/C+FE/ZTw1DMT34MazuCQKEvVT1m7P53wPFmibejy1MHZ63wJflOcIvB/+97I5lHNHJi5ZkjYd8E+n6H7UCcKRuPAEGhzK0RhDk314i7EXr2As9xulPxUnN1Apy19FdHt762JQ9NyJXuJxs/rJEfXmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alofp5dw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434925427c6so9780031cf.1;
        Tue, 09 Apr 2024 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673839; x=1713278639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHL0RXFr2CJfinyZBuEKsLTHwq4/wJAcA1+55f/eT84=;
        b=Alofp5dwcQ4HFF3tC+bzA8ooj5UKbyx1AF/QICKOHTygxcLTCvOjGz4eQdk0uE9Q3k
         vwWzFZA3Kp3fsanyxEwIXCbhwItasXZ4usb/N7jmTsqPVLJFoUYna7bhgI774g5lC9GR
         NShic+zAJvdcujUjeEBnrNKyoDAIyniI4RoWUu9zQYcpoz6MHjeWMtggJKfc/1LLmVG4
         ZCZstH0nzBJw7iAH29s3xYCSUdGjWdW/w/H5nrAiS9JginQ2Jds+1aEwu7F07lTO3laz
         V3ytmywhBcd+FzfEuUTipN4PU33fwosw//Gj/nDEgsu8kTZmt2DgTqhhsP8kNTDMvEJA
         SYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673839; x=1713278639;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHL0RXFr2CJfinyZBuEKsLTHwq4/wJAcA1+55f/eT84=;
        b=tHsXzPuU3FUsQGhvwmRUyYVJ8ogrXvAXxyKHXWroD8Tx7eb78vwuiPeOcH8q9ENfec
         MojYsTqIRtCp8FLWeTPpMTBmMNdjoKajAvunn/FCSlS99njjTvXvtR4KPh5yzvrYsGxr
         sxFW1x3r3nWYp6kD/SoZxc+1a0wh1TiuINh1/Nf+Icg1OWPu7nEzGX9HB1yS5Q9R6DZp
         dv1czOW5bwe1J4Q4rAjbICbW4CiFA5tDBp/NB+P7yPrJraeTv2ODAUgBsrncH92RQ8ws
         vgqaVlCeFemXpFdo8ytfvaOLWyktUaGpEOxg9MKZk0IxV3o7NedK/hpm5lllGufU1JV8
         OVag==
X-Forwarded-Encrypted: i=1; AJvYcCV1lQyHrqJlqm6NzZB9nlhXRnIOLX5/XFXtXQ3av12MvzhKQpNY6JJ6mqsGEbdj3mZM6HZ2nBTUksJ9WDY0Lgk4ZK6YznSoFnL+hmb3XW/5Uui5q2ziKhWc9didLDByzpp7ff8wuyteS9xIvWi7eRx3y4PbSkiV5nJqnnLhkcaM
X-Gm-Message-State: AOJu0Yy3vTfgX9EisHG8ktzUmTlmxJpBbDhmq0TYLpa5Mfie0kWYbxqo
	RKVCX8FGCmfdociBO+5u1nu9WGv3Ut8hYh/T3y9wKNfDrcJNDT8Y
X-Google-Smtp-Source: AGHT+IGmVVuOOT+gaywxcpqHxcdLnkGDJu/jgmHipvFXgrAm3d0jeVJNp5P+ms8PkckE1M5QcbwFhA==
X-Received: by 2002:a05:622a:389:b0:432:f69d:aa1c with SMTP id j9-20020a05622a038900b00432f69daa1cmr14283424qtx.49.1712673839387;
        Tue, 09 Apr 2024 07:43:59 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id bw9-20020a05622a098900b004330090b874sm4672604qtb.95.2024.04.09.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:43:59 -0700 (PDT)
Date: Tue, 09 Apr 2024 10:43:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, 
 Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
Message-ID: <6615542edc90f_23a2b2294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409-feature_ptp_netnext-v10-2-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
 <20240409-feature_ptp_netnext-v10-2-0fa2ea5c89a9@bootlin.com>
Subject: Re: [PATCH net-next v10 02/13] net: Move dev_set_hwtstamp_phylib to
 net/core/dev.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kory Maincent wrote:
> This declaration was added to the header to be called from ethtool.
> ethtool is separated from core for code organization but it is not really
> a separate entity, it controls very core things.
> As ethtool is an internal stuff it is not wise to have it in netdevice.h.
> Move the declaration to net/core/dev.h instead.
> 
> Remove the EXPORT_SYMBOL_GPL call as ethtool can not be built as a module.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

At this point this function does not need to be defined in a header at
all. But patch 12 will change that.

net/ethtool can be built-in or not, but cannot be built as module, so
no need for the EXPORT_SYMBOL_GPL indeed.

> ---
> 
> Change in v10:
> - New patch.
> ---
>  include/linux/netdevice.h | 3 ---
>  net/core/dev.h            | 4 ++++
>  net/core/dev_ioctl.c      | 1 -
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d45f330d083d..9a4b92b49fac 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3901,9 +3901,6 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
>  int generic_hwtstamp_set_lower(struct net_device *dev,
>  			       struct kernel_hwtstamp_config *kernel_cfg,
>  			       struct netlink_ext_ack *extack);
> -int dev_set_hwtstamp_phylib(struct net_device *dev,
> -			    struct kernel_hwtstamp_config *cfg,
> -			    struct netlink_ext_ack *extack);
>  int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
>  unsigned int dev_get_flags(const struct net_device *);
>  int __dev_change_flags(struct net_device *dev, unsigned int flags,
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 8572d2c8dc4a..39819fffece7 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -167,4 +167,8 @@ static inline void dev_xmit_recursion_dec(void)
>  	__this_cpu_dec(softnet_data.xmit.recursion);
>  }
>  
> +int dev_set_hwtstamp_phylib(struct net_device *dev,
> +			    struct kernel_hwtstamp_config *cfg,
> +			    struct netlink_ext_ack *extack);
> +
>  #endif
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 9a66cf5015f2..b9719ed3c3fd 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -363,7 +363,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(dev_set_hwtstamp_phylib);
>  
>  static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
>  {
> 
> -- 
> 2.34.1
> 



