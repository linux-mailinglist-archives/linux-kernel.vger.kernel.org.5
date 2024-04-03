Return-Path: <linux-kernel+bounces-129673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD6896E50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913FB1F28673
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F8146003;
	Wed,  3 Apr 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzm+f6zW"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83F143870;
	Wed,  3 Apr 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144189; cv=none; b=vB6uOFgw23XUkOCF9Oqo1utUdKAEXHTk96BM4iIk/LmOSIlAdAUURottB3uCc7nn0nCUd/CGLs1u5s/LrN7M9ds6OkVM0IeUJTUq8MszeDJtRu9grRku6A2JrLxQu/P1riRq5CUtCMT5fvy8Gg/GCAcVaACufYc38B8NsUJ9q3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144189; c=relaxed/simple;
	bh=5kWFz8zbQLSEVFdnby66rZBA85dW67ritiVu2PLeHcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx8KJAsGstItubeeIiV0aKjydfDc3M16LknSkZzoDiBz0WhdORYs2MSfdmmaDfgWy3v8OhVUbmrKfhBcvS0/J4TehAFskHYif0sTJNZDWuR1FaldTJS8STzHCb/b6k9gYdJBthqFaXiUlSMTtdduPYLAJCBOsR2XsZ6eiDT+fQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzm+f6zW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a466fc8fcccso802421466b.1;
        Wed, 03 Apr 2024 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712144186; x=1712748986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wl9GbSbwwtw06Z6YDwV4UaKz7eSEFkKaGsjFATdLc6A=;
        b=hzm+f6zWxFYPC9RnSO7Dm3tDfmGyqmNt9wfAw5trixh/iO2N3WDVsZsS9po7TMOgFv
         oteieaMkuzjQ8EUtC7yQHFPft4wHsVxIZ4wmJsvi6M4gJkOT1/sXKJh6GIiV305t7vGn
         13EwpLLYGZ847wdD0Kd8KQDAK8V1Dhs1UIQQAB1D26De76iJ93EzIaGd8QnyStFxnKmm
         uvrgO9D/NEvn/U/BTBy1vMmIMlgKVyTmU39FKdrcIaSCeWE3RJF2nhZd2almO+SUtjtF
         +z0SIiEkzgFaP0QKYD2c0+FlcOEcUYKiZhRRplb3b6xUhomGJjcZWrHFTQU/Vb//z9md
         2Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712144186; x=1712748986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl9GbSbwwtw06Z6YDwV4UaKz7eSEFkKaGsjFATdLc6A=;
        b=i2kArWKlflkc2v3gMpNbnc6EzAJMkeNCq/AiGDd3WJBJ6zS9ESBNw8WR6dBQ1/7vKg
         YovDK7Y0mpILWI/7t7ac7Mt8/u/UTFHju0FoLXtEh39xLFgpf7MCAYYxxA0erLtN2qbq
         zVv/puN9bzTbkB2yeBpMr9bAMJtpUGjmFVLdGO+ZmA36CfI7Oth79bIju2sh4W0DxhPQ
         eWzb0P2DzsYPV7gVN/FmlnA0LmXbAPCLiMNyQeIZB4u6DtLbuoauKvjqcDbGdZs4XrDD
         fJk7KAx5qMG2oFRRq7PRQq0RVWRuzflczz3myVPThfBiUgbvjPXEfvmg6Dxh1dwPs7mn
         JLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4va/KGs/nELxmBxTq+KCDL0qRfZsB7mQo613fQX3X/kV3u+0AGu1t/4aycnjw6Vk08qwAu+iIsV0s4KZCD+L8gaV7Pgra7xm7LbebctoOILV2ig99doOWELkx0TTgkCAysa9b
X-Gm-Message-State: AOJu0YwhzVtXSyJmgLA7pAKuO40qFWGbUanACeln1VGBu89PUB/zj1+5
	yPN6RJb+mmTBTwQtLYTcMyrYLLzmamwCDpJzW/1VxDr08iE53QON
X-Google-Smtp-Source: AGHT+IFeojqKVT4WjW3ahppifgXq3dOGY9Pv1Sl+7bp/cHTUY0bwZAlPHfe0pZqlEI9V+C3l4C7Lhw==
X-Received: by 2002:a17:906:13ca:b0:a51:18cf:b776 with SMTP id g10-20020a17090613ca00b00a5118cfb776mr581189ejc.2.1712144185730;
        Wed, 03 Apr 2024 04:36:25 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906124700b00a4e8a47107asm1888764eja.200.2024.04.03.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:36:24 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:36:22 +0300
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
Subject: Re: [PATCH net-next v2 2/9] net: dsa: microchip: add IPV information
 support
Message-ID: <20240403113622.cg7gf3ejh4kb2uji@skbuf>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
 <20240403092905.2107522-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403092905.2107522-3-o.rempel@pengutronix.de>

On Wed, Apr 03, 2024 at 11:28:58AM +0200, Oleksij Rempel wrote:
> Most of Microchip KSZ switches use Internal Priority Value associated
> with every frame. For example, it is possible to map any VLAN PCP or
> DSCP value to IPV and at the end, map IPV to a queue.
> 
> Since amount of IPVs is not equal to amount of queues, add this
> information and make use of it in some functions.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
> @@ -2296,6 +2313,13 @@ static int ksz_setup(struct dsa_switch *ds)
>  
>  	dev->dev_ops->enable_stp_addr(dev);
>  
> +	/* Make sure driver provide plausible queue and IPV values */

provides

> +	if (!dev->info->num_tx_queues ||
> +	    dev->info->num_tx_queues > dev->info->max_ipvs) {

This only works because "max_ipvs" actually holds the _number_ of IPVs.
If it actually held _max_, it would have been off by one. Conclusion:
please rename it num_ipvs.

> +		dev_err(dev->dev, "Number of TX queues exceeds maximum supported IPVs\n");
> +		return -EINVAL;

Is the validation actually that helpful? FWIW, more TX queues than IPVs
is nothing out of the ordinary (maybe not for this hardware IP). You can
do multi-queue egress scheduling for a traffic class, even mqprio allows
configuring this (e.g. "2@0 2@2" which means 4 queues using 2 TCs).

> +	}
> +
>  	ds->num_tx_queues = dev->info->num_tx_queues;
>  
>  	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
> @@ -3522,7 +3546,7 @@ static int ksz_tc_ets_add(struct ksz_device *dev, int port,
>  	for (tc_prio = 0; tc_prio < ARRAY_SIZE(p->priomap); tc_prio++) {
>  		int queue;
>  
> -		if (tc_prio > KSZ9477_MAX_TC_PRIO)
> +		if (tc_prio >= dev->info->max_ipvs)

Same here (please rename max_ipvs to num_ipvs). Otherwise, the operator
change makes no sense (we have "max" -> "max" but ">" -> ">=").

>  			break;
>  
>  		queue = ksz_ets_band_to_queue(p, p->priomap[tc_prio]);
> @@ -3564,7 +3588,7 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
>  	/* Revert the queue mapping for TC-priority to its default setting on
>  	 * the chip.
>  	 */
> -	for (tc_prio = 0; tc_prio <= KSZ9477_MAX_TC_PRIO; tc_prio++) {
> +	for (tc_prio = 0; tc_prio < dev->info->max_ipvs; tc_prio++) {
>  		int queue;
>  
>  		queue = tc_prio >> s;
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 40c11b0d6b625..1bedd240cbbe4 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -58,6 +58,7 @@ struct ksz_chip_data {
>  	int port_cnt;
>  	u8 port_nirqs;
>  	u8 num_tx_queues;
> +	u8 max_ipvs; /* max number of Internal Priority Values */
>  	bool tc_cbs_supported;
>  	bool tc_ets_supported;
>  	const struct ksz_dev_ops *ops;
> @@ -722,7 +723,6 @@ static inline int is_lan937x(struct ksz_device *dev)
>  #define KSZ9477_PORT_MRI_TC_MAP__4	0x0808
>  
>  #define KSZ9477_PORT_TC_MAP_S		4
> -#define KSZ9477_MAX_TC_PRIO		7
>  
>  /* CBS related registers */
>  #define REG_PORT_MTI_QUEUE_INDEX__4	0x0900
> -- 
> 2.39.2
> 

