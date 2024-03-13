Return-Path: <linux-kernel+bounces-101545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4A87A890
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FE81F24860
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632A41A81;
	Wed, 13 Mar 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I+vtFS5h"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF440872;
	Wed, 13 Mar 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336992; cv=none; b=VUwcn+ft/LKRpaZZMAbU2wX3apaUOU7UqTzqa2BA1So4VCDS6xjpWFHulPQGqKk2sVjqm1kv1BLdnxlaRDMCnggHhry+3LJ2YK/7yflhwqrrXrzJtECQUwPl0wuq9ckgve1NOF0XYhci5k1lQPS0xP3z8jauMI+OmypTOYsaQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336992; c=relaxed/simple;
	bh=btb1SHUYCqO+8fD8qTU38TpwlDzeH5YwyiyceJigGNk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/9UmeZ1HQSusUTJCQhwRQCcyZXgHRosNMVYK2kabc2iTbAZuLKbFIY5xiZ/SiL7clihS2Ads50CWJZp6hh5YVYoX76RQSBCVikNq5GUrnxtxHfwnw2a11nrFF1H9m4zWLunT+4hhNfgDPil+XDOc2XTwUK4kkX3ytFct8x3g0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I+vtFS5h; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D9Wib0022081;
	Wed, 13 Mar 2024 06:36:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=S3k3UGSaMW22BSoOxHWpzG
	XLOO1X22H060qF0fLZNwM=; b=I+vtFS5hB+0xUKSd3aTTrqxSvUN/cPEmwirTgW
	RzZVH5xWfHlGGRUr9bos3ED57Y6/yYghRlNlyAANsLP3xTPV6FofTD1dUxiAdCfn
	NfcK0MD/Shp6sShdMkqoLn7wtfGnjSEZi8QoFcB9FMYNX0tsj4t5YNGdf9/BJrT+
	dEcSD0R9Hpy5y7aImV0sH2T/cATJ9X8HjRurC7nNWkPepnzI48tWvMq48v/GlwJw
	Bz8gPCgoyfeRc/xDwg3dVVR+fUKexQ8blQdRvKKeFRkgJIf+8DER4pY4eOhQ8Z6t
	YcD2I4GbyCleWloiXDf57RHtcY43D7Ns7D1TGrg/Xx7FaWVg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wu9kvrr00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 06:36:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 13 Mar 2024 06:36:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 13 Mar 2024 06:36:07 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2B2AA3F705C;
	Wed, 13 Mar 2024 06:36:03 -0700 (PDT)
Date: Wed, 13 Mar 2024 19:06:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Mark Cilissen <mark@yotsuba.nl>
CC: <netdev@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Breno Leitao
	<leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netpoll: support sending over raw IP interfaces
Message-ID: <20240313133602.GA1263314@maili.marvell.com>
References: <20240313124613.51399-1-mark@yotsuba.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313124613.51399-1-mark@yotsuba.nl>
X-Proofpoint-GUID: WfduN_LFavjnjhcDqmIw6cJIOIFP2Gqm
X-Proofpoint-ORIG-GUID: WfduN_LFavjnjhcDqmIw6cJIOIFP2Gqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_08,2024-03-12_01,2023-05-22_02

On 2024-03-13 at 18:16:13, Mark Cilissen (mark@yotsuba.nl) wrote:
> Currently, netpoll only supports interfaces with an ethernet-compatible
> link layer. Certain interfaces like SLIP do not have a link layer
> on the network interface level at all and expect raw IP packets,
> and could benefit from being supported by netpoll.
>
> This commit adds support for such interfaces by using the network device's
> `hard_header_len` field as an indication that no link layer is present.
> If that is the case we simply skip adding the ethernet header, causing
> a raw IP packet to be sent over the interface. This has been confirmed
> to add netconsole support to at least SLIP and WireGuard interfaces.
>
> Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
> ---
>  Documentation/networking/netconsole.rst |  3 ++-
>  net/core/netpoll.c                      | 30 ++++++++++++++++---------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index d55c2a22ec7a..434ce0366027 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -327,4 +327,5 @@ enable the logging of even the most critical kernel bugs. It works
>  from IRQ contexts as well, and does not enable interrupts while
>  sending packets. Due to these unique needs, configuration cannot
>  be more automatic, and some fundamental limitations will remain:
> -only IP networks, UDP packets and ethernet devices are supported.
> +only UDP packets over IP networks, over ethernet links if a
> +hardware layer is required, are supported.
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 543007f159f9..0299fb71b456 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -399,7 +399,7 @@ EXPORT_SYMBOL(netpoll_send_skb);
>
>  void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  {
> -	int total_len, ip_len, udp_len;
> +	int total_len, ip_len, udp_len, link_len;
>  	struct sk_buff *skb;
>  	struct udphdr *udph;
>  	struct iphdr *iph;
> @@ -416,7 +416,10 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  	else
>  		ip_len = udp_len + sizeof(*iph);
>
> -	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
> +	/* if there's a hardware header assume ethernet, else raw IP */
Taking an assumption based on dev's lower layer does not look to be good.
why not transmit packet from skb_network_header() in your driver (by making
changes in your driver)

> +	eth = NULL;
> +	link_len = np->dev->hard_header_len ? LL_RESERVED_SPACE(np->dev) : 0;
> +	total_len = ip_len + link_len;
>
>  	skb = find_skb(np, total_len + np->dev->needed_tailroom,
>  		       total_len - len);
> @@ -458,9 +461,11 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  		ip6h->saddr = np->local_ip.in6;
>  		ip6h->daddr = np->remote_ip.in6;
>
> -		eth = skb_push(skb, ETH_HLEN);
> -		skb_reset_mac_header(skb);
> -		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
> +		skb->protocol = htons(ETH_P_IPV6);
> +		if (link_len) {
> +			eth = skb_push(skb, ETH_HLEN);
> +			skb_reset_mac_header(skb);
> +		}
>  	} else {
>  		udph->check = 0;
>  		udph->check = csum_tcpudp_magic(np->local_ip.ip,
> @@ -487,13 +492,18 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  		put_unaligned(np->remote_ip.ip, &(iph->daddr));
>  		iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
>
> -		eth = skb_push(skb, ETH_HLEN);
> -		skb_reset_mac_header(skb);
> -		skb->protocol = eth->h_proto = htons(ETH_P_IP);
> +		skb->protocol = htons(ETH_P_IP);
> +		if (link_len) {
> +			eth = skb_push(skb, ETH_HLEN);
> +			skb_reset_mac_header(skb);
> +		}
>  	}
>
> -	ether_addr_copy(eth->h_source, np->dev->dev_addr);
> -	ether_addr_copy(eth->h_dest, np->remote_mac);
> +	if (eth) {
> +		eth->h_proto = skb->protocol;
> +		ether_addr_copy(eth->h_source, np->dev->dev_addr);
> +		ether_addr_copy(eth->h_dest, np->remote_mac);
> +	}
>
>  	skb->dev = np->dev;
>
> --
> 2.43.0
>

