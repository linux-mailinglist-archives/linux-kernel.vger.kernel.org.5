Return-Path: <linux-kernel+bounces-136143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B889D071
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD148B24745
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CE548EB;
	Tue,  9 Apr 2024 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glj6MtJW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247E54277;
	Tue,  9 Apr 2024 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630288; cv=none; b=WyEBFFZ+JYkvFtphauUovmSP1j9ZabflMOvOrpYwohadx1IMEViK7fcuC42hHhA4RA2EdSR2fnpfPxjNa7IgfCcov8wmkBjVF7HgILtW9YjWzzCf97spW019FI+tRXYncqtegvKD23CeCijdqHIPzTfUCoP4qS3undnUbgWS3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630288; c=relaxed/simple;
	bh=ZaSNch7ppjwTf72rqXNMumJmMiYkKU6hb6xogCXGmxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axLbJDr7YtAdNi45JltIMPnuLOdWhQRrOjX6hGflYK4jVPzIlslmIac9uHSrqwYsY5UtUVzJ+h4nNCNr/lVmqf1mcZaTlKGZ6DKQS5yyrNQ8tL/Dt6r+Dc8iU9uy/zOaYbL37o0n5hG862mI5vBKaNu/7PeBaAXLZqGFSu3ukUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glj6MtJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F505C433C7;
	Tue,  9 Apr 2024 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712630287;
	bh=ZaSNch7ppjwTf72rqXNMumJmMiYkKU6hb6xogCXGmxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Glj6MtJWarHReno35RLiyvDCkLE7UqRmNYTZNbPyGmoKssL6F2DpCEjA2hmzbcBM+
	 LO0EPFuDNpjBXiXufgQRa18M8Ciy/XD3kcrVb7pB65znO29uKgpap0Omj+zsN6weV0
	 W0RG2SdST4lpEO4k52VgobfPuo8bJpSeJJaAtSbWsA52wVR+EBUL1w2kdM6HfNRkni
	 PbY7K7iY+DXsFy/C23zT9pa/CDX0bUQexDVaDW6wslqddYVUoeuvEYlkFM2ohEEVzy
	 nkRIBEXyw+Y33V948Y9GPRap7BPeUVyD3jVOZgsFGCWrwkCTEPn8EgIGNDcdQlWaMd
	 OtaJy4+1wwswg==
Date: Mon, 8 Apr 2024 19:38:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 7/7] netdev_features: convert
 NETIF_F_FCOE_MTU to IFF_FCOE_MTU
Message-ID: <20240408193806.18e227c8@kernel.org>
In-Reply-To: <20240405133731.1010128-8-aleksander.lobakin@intel.com>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
	<20240405133731.1010128-8-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Apr 2024 15:37:31 +0200 Alexander Lobakin wrote:
> Ability to handle maximum FCoE frames of 2158 bytes can never be changed
> and thus more of an attribute, not a toggleable feature.
> Move it from netdev_features_t to netdev_priv_flags and free one more
> feature bit.

> @@ -1700,6 +1701,7 @@ enum netdev_priv_flags {
>  	IFF_NETNS_LOCAL			= BIT_ULL(35),
>  	IFF_HIGHDMA			= BIT_ULL(36),
>  	IFF_VLAN_CHALLENGED		= BIT_ULL(37),
> +	IFF_FCOE_MTU			= BIT_ULL(38),
>  	IFF_LOGICAL			= IFF_NO_QUEUE | IFF_LLTX,
>  	IFF_ONE_FOR_ALL			= IFF_HIGHDMA | IFF_VLAN_CHALLENGED,
>  	IFF_ALL_FOR_ALL			= IFF_XMIT_DST_RELEASE |

Any reason not to make it a bitfield? I haven't looked at the longer
patches but this one seems to be used like a basic bool.

> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 2de4dd5a30de..71e36e1a1b15 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -47,7 +47,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>  
>  	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
>  	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
> -	[NETIF_F_FCOE_MTU_BIT] =         "fcoe-mtu",


But this definitely _is_ a uAPI change, right?
Some analysis why this is fine and why avoiding the problem isn't worth
it in the cover letter would be great.

>  	[NETIF_F_NTUPLE_BIT] =           "rx-ntuple-filter",
>  	[NETIF_F_RXHASH_BIT] =           "rx-hashing",
>  	[NETIF_F_RXCSUM_BIT] =           "rx-checksum",


