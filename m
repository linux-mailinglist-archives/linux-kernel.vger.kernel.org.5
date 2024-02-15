Return-Path: <linux-kernel+bounces-67423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA52856B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC51F23478
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D21386C0;
	Thu, 15 Feb 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQET31Um"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3C138490;
	Thu, 15 Feb 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018788; cv=none; b=kJf0IZSaSmt+N3II3FHItaiSf34zVFanzFsJFgYgVdlZIfN1wonCEDKKcoveRCY0Q70y+TUoB2SAdgjGvwkG0cwl6Oj4XwvGknGcsmv4092ng/8xdOJDhOOGcQU81tTUBSCPZP+WAItZNpbAoTk6urWLDr12qbmrLAWnMR1+CVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018788; c=relaxed/simple;
	bh=DepMm0E1rykVEHl91v/EejSEa+JDtowq+qU872OTaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtOT02ZZtq/mcYFo4/lS0ZXnf9wsNtBDhUPGeCvv/4A3p2gFqGtpWxxhLk/wmsX6lNPesTQs4iuaqn/L6M9oG+fTFRGcntOH4jdjCxttSdpVRtvLOf9FRe48y7tlDIg1pv1e0jknWdsV+3BCqc3wlEsySGbs02v8yEleAxiFGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQET31Um; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so1291412e87.2;
        Thu, 15 Feb 2024 09:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708018784; x=1708623584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1ki9zK7OcLCmqsO7Ewd3y2YJoqglQbEuSLuAip6u9k=;
        b=fQET31Um4+3b6Inowc9NZrgNFFLgqrwVPE3Vn3wA08moGsfYOBnh9wMNGiUPNf+e9R
         WwXCXA+zvhx+4ZUI+GFEtkkwa0JsWSBv1jszxIReQj4aYG7wwTZ83GFHDzJFMlk51H4u
         Fx9jIeHUIG8QZ0BpY0q/+Muic8HHxPNEo0VUi/bkqCSu7/RryHp+vpBTgZx0j1J3bj5l
         EC6+v0yBFZ1FB1EjErplCuxWlohWXl0ZDW1ttjYaTiipVXPaK6xrNTdZimqlXQMzwXPC
         D5HwWbWaINkvlQeAiV8H9Hm7n/9FuI++DrgSF16qesM+CO/Khe74Pc+iLQhgLoYwdMX+
         pYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018784; x=1708623584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1ki9zK7OcLCmqsO7Ewd3y2YJoqglQbEuSLuAip6u9k=;
        b=RKskyCGtRmybQyQG0i7g0R4iAsRie03YfEwyFLn8w3UR4WzDaJRKzWta+K2ukrZuh8
         mjMn8tuSMU7a5SwkK91K0U8FYVX1rSYPgxs2h67xe6+9quLbI6wACsMrPFmDgKvBiEs5
         sq4PAKk0y2MlLi2OEqnFlw0tYbjn+yeq61g8lKrxvnvCcQqVASDLgyBa3hl/l1uvL+Mg
         tz2O7rrCRGxR7Gnbe+I5L9bQYBmdXuRoAsFsCojVaKmMF0Zy6/2srzP4HqkuBuvz7WZz
         6XUODKiCibRXfHcRLucOjTtcuc9Df/a3LErwnnSnZxNVncTTTLilr1XAOb3PV9X/mhFN
         i7gA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/qrD/FbFkLCi+vGVulHVI7utn+M4A4cr6Xdz8J3lbd9F54/gQ8OJMB1uFfEc9OS7Vl7rSV3YHTgzOsWg1JPp/o1OfGX/llA8w71z
X-Gm-Message-State: AOJu0Yx6A/02BmgN5qMq3hdcYb2yc7x6JmvnE3/stEo27Cu7LbSPNyJM
	IumhHYom1jqPrSwyMjS49UkvoILnxzaJcfgyet3R9Gg6YwTNRj4W
X-Google-Smtp-Source: AGHT+IEOAuW75/Z347ixI4RTdUIvVIqm8O4WQjbwpKWvkWS8noyX3FQEWifQ4dByJEDwos73dXtPzw==
X-Received: by 2002:ac2:4ac9:0:b0:511:8bc0:9231 with SMTP id m9-20020ac24ac9000000b005118bc09231mr1767732lfp.55.1708018783678;
        Thu, 15 Feb 2024 09:39:43 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id h32-20020a0564020ea000b00561e675a3casm736119eda.68.2024.02.15.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:39:43 -0800 (PST)
Date: Thu, 15 Feb 2024 19:39:40 +0200
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
Subject: Re: [PATCH net-next v4 12/15] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
Message-ID: <20240215173940.4jscb7dk6wnkdsyg@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-13-paweldembicki@gmail.com>
 <20240213220331.239031-13-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-13-paweldembicki@gmail.com>
 <20240213220331.239031-13-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:25PM +0100, Pawel Dembicki wrote:
> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v4:
>   - rebase to net-next/main
> v3:
>   - Introduce a patch after the tagging patch split
> 
>  include/net/dsa.h           |  2 ++
>  net/dsa/Kconfig             |  6 ++++
>  net/dsa/Makefile            |  1 +
>  net/dsa/tag_vsc73xx_8021q.c | 69 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 78 insertions(+)
>  create mode 100644 net/dsa/tag_vsc73xx_8021q.c
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 7c0da9effe4e..b79e136e4c41 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -56,6 +56,7 @@ struct phylink_link_state;
>  #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
>  #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
>  #define DSA_TAG_PROTO_LAN937X_VALUE		27
> +#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
>  
>  enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> @@ -86,6 +87,7 @@ enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
>  	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
>  	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
> +	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
>  };
>  
>  struct dsa_switch;
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 8e698bea99a3..e59360071c67 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
>  	  Say Y or M if you want to enable support for tagging frames at
>  	  with a trailed. e.g. Marvell 88E6060.
>  
> +config NET_DSA_TAG_VSC73XX_8021Q
> +	tristate "Tag driver for Microchip/Vitesse VSC73xx family of switches, using VLAN"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames with a
> +	  custom VLAN-based header.
> +
>  config NET_DSA_TAG_XRS700X
>  	tristate "Tag driver for XRS700x switches"
>  	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 8a1894a42552..555c07cfeb71 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
>  obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
>  obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
>  obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
> +obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
>  obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
>  
>  # for tracing framework to find trace.h
> diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
> new file mode 100644
> index 000000000000..0bf150a10576
> --- /dev/null
> +++ b/net/dsa/tag_vsc73xx_8021q.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/* Copyright (C) 2023 Pawel Dembicki <paweldembicki@gmail.com>

It's 2024 already :)

> + */
> +#include <linux/dsa/8021q.h>
> +
> +#include "tag.h"
> +#include "tag_8021q.h"
> +
> +#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
> +
> +static struct sk_buff *vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(netdev);
> +	u16 queue_mapping = skb_get_queue_mapping(skb);
> +	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
> +	u8 pcp;
> +
> +	if (skb->offload_fwd_mark) {
> +		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
> +		struct net_device *br = dsa_port_bridge_dev_get(dp);
> +
> +		if (br_vlan_enabled(br))
> +			return skb;
> +
> +		tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
> +	}
> +
> +	pcp = netdev_txq_to_tc(netdev, queue_mapping);
> +
> +	return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
> +			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> +}
> +
> +static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	int src_port = -1, switch_id = -1, vbid = -1, vid = -1;
> +
> +	if (skb_vlan_tag_present(skb)) {
> +		/* Normal traffic path. */
> +		dsa_8021q_rcv(skb, &src_port, &switch_id, &vbid, &vid);

dsa_8021q_rcv() also works with VLAN tags in the skb head, not in the
hwaccel area. So please remove "if (skb_vlan_tag_present())" and the
"else" clause, and let dsa_tag_8021q_find_user() below fail if it will.

> +	} else {
> +		netdev_warn(netdev, "Couldn't decode source port\n");
> +		return NULL;
> +	}
> +
> +	skb->dev = dsa_tag_8021q_find_user(netdev, src_port, switch_id, vid, vbid);
> +	if (!skb->dev) {
> +		netdev_warn(netdev, "Couldn't decode source port\n");
> +		return NULL;
> +	}
> +
> +	dsa_default_offload_fwd_mark(skb);
> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops vsc73xx_8021q_netdev_ops = {
> +	.name			= VSC73XX_8021Q_NAME,
> +	.proto			= DSA_TAG_PROTO_VSC73XX_8021Q,
> +	.xmit			= vsc73xx_xmit,
> +	.rcv			= vsc73xx_rcv,
> +	.needed_headroom	= VLAN_HLEN,
> +	.promisc_on_conduit	= true,
> +};
> +
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
> +
> +module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
> -- 
> 2.34.1
> 

