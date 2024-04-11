Return-Path: <linux-kernel+bounces-140384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198758A1399
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AA42819D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28914A4E7;
	Thu, 11 Apr 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9jzayBD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACB149C75;
	Thu, 11 Apr 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836325; cv=none; b=mTv5FUdD18CvwDOCJLVUFgEsP5aEhwGCU9WpnF62eUzzdS88Bl7mkik288bCRot4O0h/ffjLQ/Qf57e4yuDnGUmHiyH4rTQMlugU2SYUrGoUOrnEjZw0r8j0BP33Q0AIHZhv7ciBO7FusffWKyPd4wppIgumGoafJUKpCCtlWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836325; c=relaxed/simple;
	bh=xW+C0nLGdF1fVGE2nxaH6HMCF/ySvZeEiDwNGzVSC88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7lUdYWeL03xnxovykAw85v2d9N58rvV8mqdEuH5w1s5yiE5QKcNLNKH+kPEzq6ma0g673YyQgMVXXujySAEeOPUQ378jYTGy1PHZRW32QGGjswecZeS4j1voJ1HAmbVlclrsHhEnZypymOQXGAsqFGeK1R+xgmlUdnYhMHJdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9jzayBD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso5511783f8f.1;
        Thu, 11 Apr 2024 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836322; x=1713441122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVVZ1nJPbPp+vosTyb5RL8BqBGaUyiZ4311MXvuW50s=;
        b=c9jzayBD77PrcuqJVdsNZnS3OynhcmSvkIbLlr7AAIegcHlNpx90AkvX7BecNrliUt
         W7ZxUzshKUCUhPLNBIQeNhSeuViBrHVDeShXY5UUTHH0ZBVNQhogkFFClrIKE8JOvzYZ
         m6e9ApnNqTLTyDRt3CofHa4xMkLKVwVCKkcQUcAfnOSRLSRjk0d1m9mrJcwl6j12n42j
         AQJKUOlU+K1uuVemb8jveK4b9wXBDdkM3kqiXQbChV4vzgoUy2Fl1o4EHPk3uqDRYAZR
         y+tkjTR3LF3+OFrGeonuI32HT9r75oNYfGtT3+mEVYdP1JuBBXbigUxqCcIZt4AmqHi0
         1Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836322; x=1713441122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVVZ1nJPbPp+vosTyb5RL8BqBGaUyiZ4311MXvuW50s=;
        b=nn88q5GqZm3hSalFQS8DB0d7G98m1QWDKHR9zDw27GdLsDATRrQBqN+AOQp+7W1c38
         JGdOgqG0yQ0u/HDWyW3EsVvzJlSPgLnaBXBnmfmqH1/PqUWovMgdm83eVZ9t6CZxi3ap
         rgrN9ILd8mk/PuqJS61kCZJRS5lLn49lvu6xvoKrl6VwFqRujN6ep6MkfN7tp+uktsVF
         VA97JNxw4yYWrOYLoF2Ux8PdzmUdQFllwcJe0G9FUPq3yuyUW3YDWAq9j+oaPO+QbeWA
         IGj8uuZ9iYGGLdVN9ti/mU/QrfOF1IOn8kb1eMVxsqBUOvRExhh+i0B3AAOhbpVxHjDk
         HFSA==
X-Forwarded-Encrypted: i=1; AJvYcCVgaJg05KOR8MtHrba9tywiYyQv1/Z+xvosUmAj0nTwxS/UtPH7yMn93rU+kSIJYcO/Yj5ufK6HsERebZm4NqdEMXwDDll1DRBwHYU6MOmxPBkFWDruAR5UoB+YL8jr34MZOgkd
X-Gm-Message-State: AOJu0Yw2nTxhQLAfO9/rUU+FztrbesdKba6//D4gseWYs45LtonfJ8tY
	5uyzDZGMs6USX2We+LkRgjf4S/55gIt9BpNhHMjyD1RDgsM/LTpk
X-Google-Smtp-Source: AGHT+IHCtjjN+UKNA7X+7raKMOxDPzARjrUaq5ESZh+KWpurNxlVHTyNOmKd1RKW2iW6fSLPGzDR6g==
X-Received: by 2002:adf:e488:0:b0:33e:bc7e:cadb with SMTP id i8-20020adfe488000000b0033ebc7ecadbmr3685433wrm.41.1712836321836;
        Thu, 11 Apr 2024 04:52:01 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id ea15-20020a0560000ecf00b003438cc1d2b4sm1604472wrb.59.2024.04.11.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:52:01 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:51:58 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v6 3/9] net: add IEEE 802.1q specific helpers
Message-ID: <20240411115158.5yxug7u3gtyvyuxh@skbuf>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-4-o.rempel@pengutronix.de>
 <20240410080556.1241048-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410080556.1241048-4-o.rempel@pengutronix.de>
 <20240410080556.1241048-4-o.rempel@pengutronix.de>

I have the following comments already written; sending the email mainly
to close the window. All of these comments are guarded by a big:
"I'm not sure if this really belongs in the kernel." Anyway, here goes.

On Wed, Apr 10, 2024 at 10:05:50AM +0200, Oleksij Rempel wrote:
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
> ---
> diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
> new file mode 100644
> index 0000000000000..3bec7ec951362
> --- /dev/null
> +++ b/include/net/ieee8021q.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
> +
> +#ifndef _NET_IEEE8021Q_H
> +#define _NET_IEEE8021Q_H
> +
> +#include <linux/errno.h>
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

We get kernel-doc warnings about IEEE8021Q_TT_MAX not being documented.
Simon also suggested to make it private, which I guess will work.

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
> +
> +	IEEE8021Q_TT_MAX,
> +};
> +
> +#define SIMPLE_IETF_DSCP_TO_IEEE8021Q_TT(dscp)		((dscp >> 3) & 0x7)
> +
> +#if IS_ENABLED(CONFIG_NET_IEEE8021Q_HELPERS)
> +
> +int ietf_dscp_to_ieee8021q_tt(u8 dscp);
> +int ieee8021q_tt_to_tc(unsigned int tt, unsigned int num_queues);
> +
> +#else
> +
> +static inline int ietf_dscp_to_ieee8021q_tt(int dscp)

Function prototype differs when CONFIG_NET_IEEE8021Q_HELPERS is disabled
and when it is enabled (u8 dscp vs int dscp).

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int ieee8021q_tt_to_tc(int tt, int num_queues)

Same here (unsigned int tt vs int tt).

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif
> +#endif /* _NET_IEEE8021Q_H */
> diff --git a/net/Kconfig b/net/Kconfig
> index d5ab791f7afa2..f0a8692496ffa 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -452,6 +452,9 @@ config GRO_CELLS
>  config SOCK_VALIDATE_XMIT
>  	bool
>  
> +config NET_IEEE8021Q_HELPERS
> +	bool
> +
>  config NET_SELFTESTS
>  	def_tristate PHYLIB
>  	depends on PHYLIB && INET
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 21d6fbc7e884c..62be9aef25285 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_NETPOLL) += netpoll.o
>  obj-$(CONFIG_FIB_RULES) += fib_rules.o
>  obj-$(CONFIG_TRACEPOINTS) += net-traces.o
>  obj-$(CONFIG_NET_DROP_MONITOR) += drop_monitor.o
> +obj-$(CONFIG_NET_IEEE8021Q_HELPERS) += ieee8021q_helpers.o
>  obj-$(CONFIG_NET_SELFTESTS) += selftests.o
>  obj-$(CONFIG_NETWORK_PHY_TIMESTAMPING) += timestamping.o
>  obj-$(CONFIG_NET_PTP_CLASSIFY) += ptp_classifier.o
> diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
> new file mode 100644
> index 0000000000000..74b42334746da
> --- /dev/null
> +++ b/net/core/ieee8021q_helpers.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> +
> +#include <linux/array_size.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +#include <net/dscp.h>
> +#include <net/ieee8021q.h>
> +
> +/* The following arrays map Traffic Types (TT) to traffic classes (TC) for
> + * different number of queues as shown in the example provided by
> + * IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic class mapping" and
> + * Table I-1 "Traffic type to traffic class mapping".
> + */
> +static const u8 ieee8021q_8queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0,
> +	[IEEE8021Q_TT_BE] = 1,
> +	[IEEE8021Q_TT_EE] = 2,
> +	[IEEE8021Q_TT_CA] = 3,
> +	[IEEE8021Q_TT_VI] = 4,
> +	[IEEE8021Q_TT_VO] = 5,
> +	[IEEE8021Q_TT_IC] = 6,
> +	[IEEE8021Q_TT_NC] = 7,
> +};
> +
> +static const u8 ieee8021q_7queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0,
> +	[IEEE8021Q_TT_BE] = 1,
> +	[IEEE8021Q_TT_EE] = 2,
> +	[IEEE8021Q_TT_CA] = 3,
> +	[IEEE8021Q_TT_VI] = 4,	[IEEE8021Q_TT_VO] = 4,
> +	[IEEE8021Q_TT_IC] = 5,
> +	[IEEE8021Q_TT_NC] = 6,
> +};
> +
> +static const u8 ieee8021q_6queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0,
> +	[IEEE8021Q_TT_BE] = 1,
> +	[IEEE8021Q_TT_EE] = 2,	[IEEE8021Q_TT_CA] = 2,
> +	[IEEE8021Q_TT_VI] = 3,	[IEEE8021Q_TT_VO] = 3,
> +	[IEEE8021Q_TT_IC] = 4,
> +	[IEEE8021Q_TT_NC] = 5,
> +};
> +
> +static const u8 ieee8021q_5queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
> +	[IEEE8021Q_TT_EE] = 1, [IEEE8021Q_TT_CA] = 1,
> +	[IEEE8021Q_TT_VI] = 2, [IEEE8021Q_TT_VO] = 2,
> +	[IEEE8021Q_TT_IC] = 3,
> +	[IEEE8021Q_TT_NC] = 4,
> +};
> +
> +static const u8 ieee8021q_4queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
> +	[IEEE8021Q_TT_EE] = 1, [IEEE8021Q_TT_CA] = 1,
> +	[IEEE8021Q_TT_VI] = 2, [IEEE8021Q_TT_VO] = 2,
> +	[IEEE8021Q_TT_IC] = 3, [IEEE8021Q_TT_NC] = 3,
> +};
> +
> +static const u8 ieee8021q_3queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
> +	[IEEE8021Q_TT_EE] = 0, [IEEE8021Q_TT_CA] = 0,
> +	[IEEE8021Q_TT_VI] = 1, [IEEE8021Q_TT_VO] = 1,
> +	[IEEE8021Q_TT_IC] = 2, [IEEE8021Q_TT_NC] = 2,
> +};
> +
> +static const u8 ieee8021q_2queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
> +	[IEEE8021Q_TT_EE] = 0, [IEEE8021Q_TT_CA] = 0,
> +	[IEEE8021Q_TT_VI] = 1, [IEEE8021Q_TT_VO] = 1,
> +	[IEEE8021Q_TT_IC] = 1, [IEEE8021Q_TT_NC] = 1,
> +};
> +
> +static const u8 ieee8021q_1queue_tt_tc_map[] = {
> +	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
> +	[IEEE8021Q_TT_EE] = 0, [IEEE8021Q_TT_CA] = 0,
> +	[IEEE8021Q_TT_VI] = 0, [IEEE8021Q_TT_VO] = 0,
> +	[IEEE8021Q_TT_IC] = 0, [IEEE8021Q_TT_NC] = 0,
> +};
> +
> +/**
> + * ieee8021q_tt_to_tc - Map IEEE 802.1Q Traffic Type to Traffic Class
> + * @tt: IEEE 802.1Q Traffic Type
> + * @num_queues: Number of queues
> + *
> + * This function maps an IEEE 802.1Q Traffic Type to a Traffic Class (TC) based
> + * on the number of queues configured on the switch. The mapping is based on the

s/switch/NIC/, ideally it should be useful beyond switches :)

> + * example provided by IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic
> + * class mapping" and Table I-1 "Traffic type to traffic class mapping".
> + *
> + * Return: Traffic Class corresponding to the given Traffic Type or -EINVAL if
> + * the number of queues is not supported. -EINVAL is used to differentiate from

Needs to also describe the other error case, or be less specific.

> + * -EOPNOTSUPP which is used to indicate that this library function is not
> + * compiled in.
> + */
> +int ieee8021q_tt_to_tc(unsigned int tt, unsigned int num_queues)

Can the enum ieee8021q_traffic_type be used instead of unsigned int?

> +{
> +	if (tt >= IEEE8021Q_TT_MAX) {
> +		pr_err("Requested Traffic Type (%d) is out of range (%d)\n", tt,
> +		       IEEE8021Q_TT_MAX);
> +		return -EINVAL;
> +	}
> +
> +	switch (num_queues) {
> +	case 8:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_8queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_8queue_tt_tc_map != max - 1");
> +		return ieee8021q_8queue_tt_tc_map[tt];
> +	case 7:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_7queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_7queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_7queue_tt_tc_map[tt];
> +	case 6:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_6queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_6queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_6queue_tt_tc_map[tt];
> +	case 5:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_5queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_5queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_5queue_tt_tc_map[tt];
> +	case 4:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_4queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_4queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_4queue_tt_tc_map[tt];
> +	case 3:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_3queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_3queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_3queue_tt_tc_map[tt];
> +	case 2:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_2queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_2queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_2queue_tt_tc_map[tt];
> +	case 1:
> +		compiletime_assert(ARRAY_SIZE(ieee8021q_1queue_tt_tc_map) !=
> +				   IEEE8021Q_TT_MAX - 1,
> +				   "ieee8021q_1queue_tt_tc_map != max - 1");
> +
> +		return ieee8021q_1queue_tt_tc_map[tt];
> +	}
> +
> +	pr_err("Invalid number of queues %d\n", num_queues);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(ieee8021q_tt_to_tc);
> +
> +/**
> + * ietf_dscp_to_ieee8021q_tt - Map IETF DSCP to IEEE 802.1Q Traffic Type
> + * @dscp: IETF DSCP value
> + *
> + * This function maps an IETF DSCP value to an IEEE 802.1Q Traffic Type (TT).
> + * Since there is no corresponding mapping between DSCP and IEEE 802.1Q Traffic
> + * Type, this function is inspired by the RFC8325 documentation which describe
> + * the mapping between DSCP and 802.11 User Priority (UP) values.
> + *
> + * Return: IEEE 802.1Q Traffic Type corresponding to the given DSCP value
> + */
> +int ietf_dscp_to_ieee8021q_tt(u8 dscp)
> +{
> +	switch (dscp) {
> +	case DSCP_CS0:
> +	case DSCP_AF11:
> +	case DSCP_AF12:
> +	case DSCP_AF13:

Is it correct for AF11, AF12, AF13 to be classified together with CS0
rather than with CS1? It looks strange when their upper 3 bits are the
same as CS1.

> +		return IEEE8021Q_TT_BE;
> +	case DSCP_CS1:
> +		return IEEE8021Q_TT_BK;
> +	case DSCP_CS2:
> +	case DSCP_AF21:
> +	case DSCP_AF22:
> +	case DSCP_AF23:
> +		return IEEE8021Q_TT_EE;
> +	case DSCP_CS3:
> +	case DSCP_AF31:
> +	case DSCP_AF32:
> +	case DSCP_AF33:
> +		return IEEE8021Q_TT_CA;
> +	case DSCP_CS4:
> +	case DSCP_AF41:
> +	case DSCP_AF42:
> +	case DSCP_AF43:
> +		return IEEE8021Q_TT_VI;
> +	case DSCP_CS5:
> +	case DSCP_EF:
> +	case DSCP_VOICE_ADMIT:
> +		return IEEE8021Q_TT_VO;
> +	case DSCP_CS6:
> +		return IEEE8021Q_TT_IC;
> +	case DSCP_CS7:
> +		return IEEE8021Q_TT_NC;
> +	}
> +
> +	return SIMPLE_IETF_DSCP_TO_IEEE8021Q_TT(dscp);
> +}
> +EXPORT_SYMBOL_GPL(ietf_dscp_to_ieee8021q_tt);
> -- 
> 2.39.2
> 

