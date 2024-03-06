Return-Path: <linux-kernel+bounces-94690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC987439B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61132B2188B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE461C6AF;
	Wed,  6 Mar 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+0aVbSU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5A1BF40;
	Wed,  6 Mar 2024 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766902; cv=none; b=i+MTXd3Kv6yWE6g71OkV73mXMCZySYVGrzTIxAjnXU9fpWCwc7OIDCgo+EM5JXRmHyRvbQZQCUGxTl/fc9yFb2Pv2U++hMCdqRs5asGK3TStHbckv1fZSdQeRCP67gNp9GGQEN6JYPVOsc7tP+oo2RE3SRk9+g0BBxKeL6fZJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766902; c=relaxed/simple;
	bh=rmkN/rk1OkUf46sCZEUOz0SAufpmECUZvf/L5nkQh7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMbWzEyKGJv8/tF3lpOWyPVey6hwzhXWYsmhdrKmfGG3GQ/35DFqIFgMtWKmSWVLyqxPBXeqUuZXvOvSRW5EaRhvIR7k+nY+mLFdtPA4DXSrhix0zpXhb5eFcuyKiPnHh3nJEUNjxAUjR8AN+H3pmQRXGBX5/HqDuAHmdPuq5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+0aVbSU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso2426865ad.2;
        Wed, 06 Mar 2024 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766900; x=1710371700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ijwo7LBOA8/494JdwWuRvnpoOax7lsgpUyAg0JL7Zt8=;
        b=Y+0aVbSUtXwue3X1AYbQGAUIf1IeaOTWLY8/p/uq3RFVj8PUPCohTcrMdtHvtLkubV
         jXVZ9fGUwWKAnHpi6qcdAnYncAgB7bHcF54T6bejfENsqw9+uejE8XQooYJ/ej7lNrEH
         T+Rwb3FFJE9u5TpJyWKyVQFcElZa6iWqnRSHB0ELjJZoWFdFmFnXch7pWCmyLQHPNej7
         wBYadeLIXYlNtLJVW3Cxm7VirYulBexhznJDLtl+ul5PDFGwJF/4JlfWBmOnhjCxmRNQ
         aVbulkq6qYNOiC5KT/YKbaJCX3IBuLADTnOVxXoca+3T5z5/FQMSAPELCFEwFCiSH6nb
         SGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766900; x=1710371700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijwo7LBOA8/494JdwWuRvnpoOax7lsgpUyAg0JL7Zt8=;
        b=msPOuPbHY/2/U9WL++1rutmbHtRoEW2Z0bE8Sh6xjbjNUwUZ2aS2GAB65UyZFp381S
         qx+kEnMRWZVECvPGf8DsUFvDelcwiyTBoj31iOMMO8raCHzJC9Cx4ZgwWjWKSf4KC04c
         4j3gBDEGmJwe6I8jEoqVbydN2FjLlDMb0D4dPKAp6M3hz1FSPVvAPtzW0tIiLEwsFzEy
         1JGQxsuUuuMmLYx+xge/J2N8UMkVlg/uMa4tMgfJ8HqKJAmmSxXhImzfoHOGMz4xDfR+
         PcJEhr5kzNKWa9W6lb3StqmNr4LSK6USOiHwFzC5W0xQUkDTOP75WGuFK4deCo7clWBg
         AI4A==
X-Forwarded-Encrypted: i=1; AJvYcCWoETPUAHufgPQORWh6LOa/fVVDieZw+Zeor/KF9SLaAL+B4p8wuO2Ogp5TemTr0xUxhOC/bSorL5mXVAr0zob/9DAoYti8A65xNnoFNwyrWgG9evQBIVICu5Gi9NmQXfqKywXk
X-Gm-Message-State: AOJu0Yxo+4LoZT/ZWzLUZrC7m+cAKMDiMVE6LcOzsxnI/5w8WG006Xwz
	Ms0eF8JGFkjnWPFd7SM30sCmBNSKKX8WEjSuXnny9fFwP9R43qKy
X-Google-Smtp-Source: AGHT+IHn768mdnCZcfQYggj1wAhTHLgcQvY4vWgzFa70/3k0LfKpYtQDPrnDLMq6vSfv7Y477Imupw==
X-Received: by 2002:a17:902:ecd1:b0:1dc:8c27:9a07 with SMTP id a17-20020a170902ecd100b001dc8c279a07mr7894615plh.31.1709766899654;
        Wed, 06 Mar 2024 15:14:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d15-20020a170903230f00b001dc3c4e7a12sm13163910plh.14.2024.03.06.15.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:14:59 -0800 (PST)
Message-ID: <3e17163f-81dd-42e5-9aaa-d92ebc3bd343@gmail.com>
Date: Wed, 6 Mar 2024 15:14:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/16] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-13-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-13-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v6:
>    - added missing MODULE_DESCRIPTION()
> v5:
>    - removed skb_vlan_tag_present(skb) checking
>    - use 80 characters per line limit
> v4:
>    - rebase to net-next/main
> v3:
>    - Introduce a patch after the tagging patch split
> 
>   include/net/dsa.h           |  2 ++
>   net/dsa/Kconfig             |  6 ++++
>   net/dsa/Makefile            |  1 +
>   net/dsa/tag_vsc73xx_8021q.c | 67 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 76 insertions(+)
>   create mode 100644 net/dsa/tag_vsc73xx_8021q.c
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 7c0da9effe4e..b79e136e4c41 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -56,6 +56,7 @@ struct phylink_link_state;
>   #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
>   #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
>   #define DSA_TAG_PROTO_LAN937X_VALUE		27
> +#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
>   
>   enum dsa_tag_protocol {
>   	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> @@ -86,6 +87,7 @@ enum dsa_tag_protocol {
>   	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
>   	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
>   	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
> +	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
>   };
>   
>   struct dsa_switch;
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 8e698bea99a3..e59360071c67 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
>   	  Say Y or M if you want to enable support for tagging frames at
>   	  with a trailed. e.g. Marvell 88E6060.
>   
> +config NET_DSA_TAG_VSC73XX_8021Q
> +	tristate "Tag driver for Microchip/Vitesse VSC73xx family of switches, using VLAN"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames with a
> +	  custom VLAN-based header.
> +
>   config NET_DSA_TAG_XRS700X
>   	tristate "Tag driver for XRS700x switches"
>   	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 8a1894a42552..555c07cfeb71 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
>   obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
>   obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
>   obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
> +obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
>   obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
>   
>   # for tracing framework to find trace.h
> diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
> new file mode 100644
> index 000000000000..f7bc0261d54d
> --- /dev/null
> +++ b/net/dsa/tag_vsc73xx_8021q.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/* Copyright (C) 2024 Pawel Dembicki <paweldembicki@gmail.com>
> + */
> +#include <linux/dsa/8021q.h>
> +
> +#include "tag.h"
> +#include "tag_8021q.h"
> +
> +#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
> +
> +static struct sk_buff *
> +vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
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
> +static struct sk_buff *
> +vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	int src_port = -1, switch_id = -1, vbid = -1, vid = -1;
> +
> +	dsa_8021q_rcv(skb, &src_port, &switch_id, &vbid, &vid);
> +
> +	skb->dev = dsa_tag_8021q_find_user(netdev, src_port, switch_id,
> +					   vid, vbid);
> +	if (!skb->dev) {
> +		netdev_warn(netdev, "Couldn't decode source port\n");

Please remove this message, or rate limit it, with that fixed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


