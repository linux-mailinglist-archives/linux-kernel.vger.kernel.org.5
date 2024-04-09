Return-Path: <linux-kernel+bounces-137290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24989E07C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A627AB2B918
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9F13D891;
	Tue,  9 Apr 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfcqSF9F"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DB136E1C;
	Tue,  9 Apr 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678901; cv=none; b=tm+A/yNiSKT2XA6HGy1NdvlvkYF4ozDq7ZjrpT9GsKDFz0Iem9ErZ9D9No2RVvk2Z6VEdYj2DOnqD5WxDwxLru5Af/JyJBd/3TP7HcEMC8RYaB4wRrLyFH4OD4E9xDnNbpUerGk3/LXUl9gvNM8732sxLU44Goye7iicfaWyJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678901; c=relaxed/simple;
	bh=CQjFb41kM2YC/CrSVJHgmJgtfd5UO6hYIm2H4xrCyGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5t59QfNN75y/yUDTaz9h4lmUoatAHIZciESlElcNjO1GF3JAr8FAD5eO0yjmFP26yoB18jcupHhbKTSLFI08e6E+IWePJC86+NOW55DOx92d3xfNJXCAvlsp/ipt0NXOYCOBNnX4PllayeOJs/gKLKEqZdOsSmqLTBj5Q57FOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfcqSF9F; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so7094141fa.3;
        Tue, 09 Apr 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712678897; x=1713283697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDx6pJQ6JdPApAMOGtnecliIui0292mK8Yf3WMZftts=;
        b=TfcqSF9FagVxbzkUniYQ5nHnwKqFAAEiaQWV51kR7greH9Y54XVnQCygP8htGg8moG
         Z4CIM+k2DTz6HeSASU45fKrBrsL6cQKtNbt5oFKHreBrwOqiJAc+WtT7ylOoRPP7z3FZ
         qef+MxFEb5Cu1gaEV1j2eucymGXC8LaE8SUET+x+SammuBRK8Q4SKRQjQaWh8SDm+k9a
         h39pEjpmf9IrzkE0PoPNkk1hNQsdGWMjj8yZe0/SDxgJleywtSMmY/AR05YvkGf7EYpc
         VSXJXSWEYDQ1tCFPU1mxv1m1oN/KZjk3Irv9hLxGyYGVlgy4qnJCPH6EbXQWCUC+Pvdg
         peHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678897; x=1713283697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDx6pJQ6JdPApAMOGtnecliIui0292mK8Yf3WMZftts=;
        b=wY3OlxMnOS64YRBPqJw7YQAGgCOzg1mj/4RkE4IN7jXUJi4tGZggc3h71fqIdS4yYM
         DZRwbtkGGIeYxH7XAIp7FnKHbrU6zF0YNFzKBvNsC3Ak9pk/F0ILI9/jJBBx0hpjowD8
         fRcIfUb5VDIMDkTkT8kd6iomJI3bHlicgosulksrCsQWEDHnfbiaUwY+1XWXYlRV9rBm
         +jV0hbKOKSDgpjbzHjpSwY+AGOnU8HuuVYhnJXlD8ezijVj/ReSdHuBqJKK966j//LcT
         xuDvEsKTz5FVJA233aqnq5cCD3x9YvM0rU1C8e/Aab1ttVPBDKUrUTqAZS80l/tC+tJe
         /Zsw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHl0YjGo6W33DK1pczy9+PsY+evM2AMx4lHdum3sOnLb8/i1coijELtaP6UqvSyvP2/QJWZ+lMyQjRPkN7FOhlE5a1oB+6lhfRslFgI+y7B1RCOQ4dXdc3JRoPSs6UKV6PE4w
X-Gm-Message-State: AOJu0YyMKNIVcIJy7omg1RPGmjJ/4KeVo8L/rHo3XnhGCPGeo1LQ6ROW
	MNO4Fdv3Jef4Btn+1vRg5P3C5WsiBiDzUqQ0WCJ51mPpicJQWtsZ
X-Google-Smtp-Source: AGHT+IEXergsLXHUpw0Kqvvz2kw938mxHmceRL68XvwgVFRk667N+vrCyUKixGppoK5zrUqsQcAHEw==
X-Received: by 2002:a05:651c:169c:b0:2d6:ff04:200f with SMTP id bd28-20020a05651c169c00b002d6ff04200fmr167332ljb.33.1712678896979;
        Tue, 09 Apr 2024 09:08:16 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b004146e58cc35sm21490048wmo.46.2024.04.09.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:08:16 -0700 (PDT)
Date: Tue, 9 Apr 2024 19:08:13 +0300
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
Subject: Re: [PATCH net-next v5 3/9] net: add IEEE 802.1q specific helpers
Message-ID: <20240409160813.c4afvjtgbi76tc3b@skbuf>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
 <20240409081851.3530641-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409081851.3530641-4-o.rempel@pengutronix.de>

On Tue, Apr 09, 2024 at 10:18:45AM +0200, Oleksij Rempel wrote:
> diff --git a/net/Kconfig b/net/Kconfig
> index d5ab791f7afa2..b94ee06f28c18 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -452,6 +452,10 @@ config GRO_CELLS
>  config SOCK_VALIDATE_XMIT
>  	bool
>  
> +config NET_IEEE8021Q_HELPERS
> +	bool
> +	default n

default n is implicit, please remove this.

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
> index 0000000000000..3564dc83d1d3d
> --- /dev/null
> +++ b/net/core/ieee8021q_helpers.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> +
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +#include <net/dscp.h>
> +#include <net/ieee8021q.h>
> +
> +/* Following arrays map Traffic Types (TT) to traffic classes (TC) for different

The following

> + * number of queues as shown in the example provided by  IEEE 802.1Q-2022 in
> + * Annex I "I.3 Traffic type to traffic class mapping" and Table I-1 "Traffic
> + * type to traffic class mapping".
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
> + * example provided by IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic
> + * class mapping" and Table I-1 "Traffic type to traffic class mapping".
> + *
> + * Return: Traffic Class corresponding to the given Traffic Type or -EINVAL if
> + * the number of queues is not supported. -EINVAL is used to differentiate from
> + * -EOPNOTSUPP which is used to indicate that this library function is not
> + * compiled in.
> + */
> +int ieee8021q_tt_to_tc(int tt, int num_queues)
> +{

Range validation for tt? You index an array with it.

> +	switch (num_queues) {
> +	case 8:
> +		return ieee8021q_8queue_tt_tc_map[tt];
> +	case 7:
> +		return ieee8021q_7queue_tt_tc_map[tt];
> +	case 6:
> +		return ieee8021q_6queue_tt_tc_map[tt];
> +	case 5:
> +		return ieee8021q_5queue_tt_tc_map[tt];
> +	case 4:
> +		return ieee8021q_4queue_tt_tc_map[tt];
> +	case 3:
> +		return ieee8021q_3queue_tt_tc_map[tt];
> +	case 2:
> +		return ieee8021q_2queue_tt_tc_map[tt];
> +	case 1:
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
> +

Extraneous blank line.

> +int ietf_dscp_to_ieee8021q_tt(int dscp)
> +{
> +	switch (dscp) {
> +	case DSCP_CS0:
> +	case DSCP_AF11:
> +	case DSCP_AF12:
> +	case DSCP_AF13:
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
> +	return (dscp >> 3) & 0x7;

Use a macro for this operation rather than "magic numbers"?

> +}
> +EXPORT_SYMBOL_GPL(ietf_dscp_to_ieee8021q_tt);
> -- 
> 2.39.2
> 

