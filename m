Return-Path: <linux-kernel+bounces-133456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6689A3F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A71C21FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28255171E7D;
	Fri,  5 Apr 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKBfkjVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C04171E54;
	Fri,  5 Apr 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340975; cv=none; b=DNDoTgNA3qDlXqS3TNFKfjIf5l4g+LGsKrSfLfD8a/r7SXunCSDi6k2f4Z65p6i/rvGNzAI9lGHzvKT20Y0gNaMksf3vajKFABfeLfSi9NClJ5s5lmLC1B8Ta2qNvmLf+y2FaEce6DiUmgDWYFKDQxb8/XRDUgmIt0zhAD97HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340975; c=relaxed/simple;
	bh=85o/MtIsVZA9JcsCwO7Kl8HDfm0QcVULME1Rb0ofTnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rymB9MzE6hore2Ij5soLNIDdhPkbXSgf4pCqDT6/FUIbWCT0AOfMK/OHDBr7JcjfiSc9rBKna1ZFZ3oMvWPROy0cwBZxgeSJi/tohAgi3/+86shovCO8QAeZR5VM4OQ54vOX5YBBv75RpTH2chNIRkteF6qK/ezIGfKuxAOdud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKBfkjVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC5BC433F1;
	Fri,  5 Apr 2024 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712340975;
	bh=85o/MtIsVZA9JcsCwO7Kl8HDfm0QcVULME1Rb0ofTnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKBfkjVDPOSJz5jlPNc4uwLU5ghVlX5i1uqmJ6SeLG+HXmQsWm6Of+9Upb8jcDoMJ
	 VV6HciDw3u/c/pR9ySqCCJ8I4XXzhTZuDE+f5vSlaq4uclz/gyb4tYi0yjpO34oTxU
	 wSaLUz34p78rXLTE4fheKGo7Xu4+iGt63Fj1NUInHP+xNJevUdeA493DNNV2+X1fjN
	 D4bEq44m2FGgQyRcMFTlle4haqQUMvvtBtDYT6vf8mweVIArkTxwzAPgy+ock2epKE
	 GhFuFuTYlaU0yC+2/Ci+9nNMWp5Te+Oj3j6+g9KqDky2CV4xYPpCJ8zKmf9CMWQ9sa
	 R3iHSVCNFgSbw==
Date: Fri, 5 Apr 2024 19:16:09 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v2 3/9] net: add IEEE 802.1q specific helpers
Message-ID: <20240405181609.GS26556@kernel.org>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
 <20240403092905.2107522-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403092905.2107522-4-o.rempel@pengutronix.de>

On Wed, Apr 03, 2024 at 11:28:59AM +0200, Oleksij Rempel wrote:
> IEEE 802.1q specification provides recommendation and examples which can
> be used as good default values for different drivers.
> 
> This patch implements mapping examples documented in IEEE 802.1Q-2022 in
> Annex I "I.3 Traffic type to traffic class mapping" and IETF DSCP naming
> and mapping DSCP to Traffic Type inspired by RFC8325.
> 
> This helpers will be used in followup patches for dsa/microchip DCB
> implementation.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

..

> diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
> new file mode 100644
> index 0000000000000..da1e4db7e3db6
> --- /dev/null
> +++ b/include/net/ieee8021q.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
> +
> +#ifndef _NET_IEEE8021Q_H
> +#define _NET_IEEE8021Q_H
> +
> +/**
> + * enum ieee8021q_traffic_type - 802.1Q traffic type priority values (802.1Q-2022)
> + *
> + * @IEEE8021Q_TT_BK: Background
> + * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022, BE is 0
> + * but has higher priority than BK which is 1.
> + * @IEEE8021Q_TT_EE: Excellent Effort
> + * @IEEE8021Q_TT_CA: Critical Applications
> + * @IEEE8021Q_TT_VI: Video, < 100 ms latency and jitter
> + * @IEEE8021Q_TT_VO: Voice, < 10 ms latency and jitter
> + * @IEEE8021Q_TT_IC: Internetwork Control
> + * @IEEE8021Q_TT_NC: Network Control
> + */
> +enum ieee8021q_traffic_type {
> +	IEEE8021Q_TT_BK = 0,
> +	IEEE8021Q_TT_BE = 1,
> +	IEEE8021Q_TT_EE = 2,
> +	IEEE8021Q_TT_CA = 3,
> +	IEEE8021Q_TT_VI = 4,
> +	IEEE8021Q_TT_VO = 5,
> +	IEEE8021Q_TT_IC = 6,
> +	IEEE8021Q_TT_NC = 7,
> +};
> +
> +#if IS_ENABLED(CONFIG_NET_IEEE8021Q_HELPERS)
> +
> +int ietf_dscp_to_ieee8021q_tt(int dscp);
> +int ieee8021q_tt_to_tc(int tt, int num_queues);
> +
> +#else
> +
> +static inline int ietf_dscp_to_ieee8021q_tt(int dscp)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int ieee8021q_tt_to_tc(int tt, int num_queues)
> +{
> +	return -ENOTSUPP;
> +}

Hi Oleksij,

I think that it would be better to use EOPNOTSUPP, rather than ENOTSUPP.
Although the latter has historically been misused, I understand that
strictly speaking it only relates to NFSv3.

Also, I think this file should include linux/errno.h

> +
> +#endif
> +#endif /* _NET_IEEE8021Q_H */

..

