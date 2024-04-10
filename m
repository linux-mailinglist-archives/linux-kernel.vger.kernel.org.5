Return-Path: <linux-kernel+bounces-139515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D398A03E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809291F23436
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040628379;
	Wed, 10 Apr 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmAlMcvt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF3138E;
	Wed, 10 Apr 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790779; cv=none; b=lXcMDdeoJgtShw6hRAXU7J5J6hHPcDTCPkMR+0Rm/1W09bt4+8Z8faC6VAlTfjQFtM41QHowl08kPEFpWz8vnIoZKI1gquqUHWSBvgnbbSTH2E/2gwWMzQw9xjFO8Hiipnc1/TaGn/8a38BiptkxroAzGWz/2REa56dbOJLhO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790779; c=relaxed/simple;
	bh=vWRuW7lzyPc780lUHE3AcSYdVlra858Bi8u2gWUkz5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaoFqBq+MdIkCc0JleSVkwgSbmEMz7jK1RPkXdNkY/WKrhP3cOISn+RpFRlfkqfaALh+suobpIjB63wAzl4XefOrAEsu5avgzDzXnCZF/ii2XA8YN72F/MHh+elF60YqZINi1/iae4iPyaO8xilUlM7FobLzJFfWKKTItX+VKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmAlMcvt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-417d02ab780so2476065e9.3;
        Wed, 10 Apr 2024 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712790775; x=1713395575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eerM5DZNJ3dNzt0n7ddacenMb0Icz/3xgHh4jA8RJSQ=;
        b=MmAlMcvtdWMETrfg7s6MQdVWRBBafrfVhxrm25qdO8q5B82XCwkWSkUNf0vAEeQQUT
         bHinAZysozGertq+N5PZEN8V2FSUYdmbC4WqAOpEB3PWq0zY0CiSJreFfSEU4KwY3jBP
         HqVZut3GORA7XQN/FY3hAV0SYQ2cEHZGPZ+G01pV9FLdOVbAgz6Jn9dIsuipJewwoB0R
         aY36vnVoIkttmAn1U7AAVKSuZQxqb5MbIrYjp3G01VS8jt4rF8dneszKtKWqL9VLY4Hs
         9hR3P4WTsB6haVK+CTQwFiJHJJWYgh+SBsZ8Yt3DD+npKDdXucpuBrAPSqwkKGODXSjb
         bntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712790775; x=1713395575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eerM5DZNJ3dNzt0n7ddacenMb0Icz/3xgHh4jA8RJSQ=;
        b=FJpy/aQav6DvXYNvCbPEdSvMvKxWvs1EftQvl5I87JXE4r5bfp9v7gWM6YpjYrYkG1
         ebwAeS6airIdX7Gx03DUQywJCK7BdSeahdHsgS+f8nGPOmV1Ckgh5blVpdJgv/MNk8Kl
         1hAvu9tM6p65+EP0jblXABJVqEQ6zkoR40FZeMDZDZ97X36B3Rq4kElfIahKKdgr910/
         cqzQSvYwTK5FWm6tPE7eYnB6G9X+8+lz8uCzWvYvTsg4pOjKh4OcFdJrjDtdHcwSsExC
         G0IchzWi0c0FnlO/Ab6f/dlCuUBPM5dKAi+UxY65TNnVSmLNB9+spzKriG0RHZgZw/FK
         Ch6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVslNlyhhRJqr2ucLOx3bNsRynhdax7rRFPW73XyLzFYRx7NzpaVvT10goJ1LMz+iyfiHkXuuRWj19ZANWgEuNp32MUQDXMOEa1Ztuybmeosdo0TJQmxoi8tbrRqlmQ9DMp0+t8
X-Gm-Message-State: AOJu0YyapZIWSJ2cE11qpDt6wsdwMl4Y2frUx1RXYBNjwyzEhSfT0vab
	J5JfbFnE4r38dM2oNIbaQGCOfRb7jLLGmUsw7PSpZMk9MhiUNb9O
X-Google-Smtp-Source: AGHT+IEqznyyY4xiYDQTESnJnknYHn1Plkq2O/xSnLgP3+Kz8k0k0IiUglGHlJmm4O+6GYjp8tJS8A==
X-Received: by 2002:a05:600c:19cc:b0:417:c38d:5351 with SMTP id u12-20020a05600c19cc00b00417c38d5351mr1314492wmq.10.1712790775136;
        Wed, 10 Apr 2024 16:12:55 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b003462fec9f5asm318140wrx.62.2024.04.10.16.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:12:54 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:12:51 +0300
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
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <20240410231251.macw4i46jfi57wtc@skbuf>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>

Hi Oleksij,

On Wed, Apr 10, 2024 at 10:05:52AM +0200, Oleksij Rempel wrote:
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index b2d1c61400c51..78a9622adecde 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2364,6 +2365,10 @@ static int ksz_setup(struct dsa_switch *ds)
>  		goto out_ptp_clock_unregister;
>  	}
>  
> +	ret = ksz_dcb_init(dev);
> +	if (ret)
> +		goto out_ptp_clock_unregister;
> +
>  	/* start switch */
>  	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
>  			   SW_START, SW_START);
> @@ -2691,7 +2696,7 @@ static int ksz_port_setup(struct dsa_switch *ds, int port)
>  	 * there is no need to do anything.
>  	 */
>  
> -	return 0;
> +	return ksz_dcb_init_port(dev, port);
>  }
>  
>  void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> @@ -3943,6 +3948,11 @@ static const struct dsa_switch_ops ksz_switch_ops = {
>  	.port_setup_tc		= ksz_setup_tc,
>  	.get_mac_eee		= ksz_get_mac_eee,
>  	.set_mac_eee		= ksz_set_mac_eee,
> +	.port_get_default_prio	= ksz_port_get_default_prio,
> +	.port_set_default_prio	= ksz_port_set_default_prio,
> +	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
> +	.port_get_apptrust	= ksz_port_get_apptrust,
> +	.port_set_apptrust	= ksz_port_set_apptrust,
>  };
>  
>  struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
> diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
> new file mode 100644
> index 0000000000000..d2122f844c80b
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz_dcb.c
> +/**
> + * ksz_init_global_dscp_map - Initializes the global DSCP-to-priority mapping
> + * @dev: Pointer to the KSZ switch device structure
> + *
> + * This function initializes the global DSCP-to-priority mapping table for the
> + * switch.
> + *
> + * Return: 0 on success, or a negative error code on failure
> + */
> +static int ksz_init_global_dscp_map(struct ksz_device *dev)
> +{
> +	int reg, per_reg, ret, dscp;
> +	u8 data = 0;
> +	u8 mask;
> +
> +	/* On KSZ9xxx variants, DSCP remapping is disabled by default.
> +	 * Enable to have, predictable and reproducible behavior across
> +	 * different devices.
> +	 */
> +	if (!is_ksz8(dev)) {
> +		ret = ksz_rmw8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL,
> +			       KSZ9477_SW_TOS_DSCP_REMAP,
> +			       KSZ9477_SW_TOS_DSCP_REMAP);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
> +
> +	for (dscp = 0; dscp < DSCP_MAX; dscp++) {
> +		int ipv, shift, tt;
> +
> +		/* Map DSCP to Traffic Type, which is corresponding to the
> +		 * Internal Priority Value (IPV) in the switch.
> +		 */
> +		if (!is_ksz8(dev)) {
> +			ipv = ietf_dscp_to_ieee8021q_tt(dscp);
> +		} else {
> +			/* On KSZ8xxx variants we do not have IPV to queue
> +			 * remapping table. We need to convert DSCP to Traffic
> +			 * Type and then to queue.
> +			 */
> +			tt = ietf_dscp_to_ieee8021q_tt(dscp);
> +			if (tt < 0)
> +				return tt;
> +
> +			ipv = ieee8021q_tt_to_tc(tt, dev->info->num_tx_queues);
> +		}
> +
> +		if (ipv < 0)
> +			return ipv;
> +
> +		shift = (dscp % per_reg) * (8 / per_reg);
> +		data |= (ipv & mask) << shift;
> +
> +		if (dscp % per_reg == per_reg - 1) {
> +			ret = ksz_write8(dev, reg + (dscp / per_reg), data);
> +			if (ret)
> +				return ret;
> +
> +			data = 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ksz_dcb_init_port - Initializes the DCB configuration for a port on a KSZ
> + * @dev: Pointer to the KSZ switch device structure
> + * @port: Port number for which to initialize the DCB configuration
> + *
> + * This function initializes the DCB configuration for the specified port on a
> + * KSZ switch. Particular DCB configuration is set for the port, including the
> + * default priority and apptrust selectors.
> + * The default priority is set to Best Effort, and the apptrust selectors are
> + * set to all supported selectors.
> + *
> + * Return: 0 on success, or a negative error code on failure
> + */
> +int ksz_dcb_init_port(struct ksz_device *dev, int port)
> +{
> +	int ret, ipv;
> +
> +	if (is_ksz8(dev)) {
> +		ipv = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
> +					 dev->info->num_tx_queues);
> +		if (ipv < 0)
> +			return ipv;
> +	} else {
> +		ipv = IEEE8021Q_TT_BE;
> +	}
> +
> +	/* Set the default priority for the port to Best Effort */
> +	ret = ksz_port_set_default_prio(dev->ds, port, ipv);
> +	if (ret)
> +		return ret;
> +
> +	return ksz_port_set_apptrust(dev->ds, port, ksz_supported_apptrust,
> +				     ARRAY_SIZE(ksz_supported_apptrust));
> +}
> +
> +/**
> + * ksz_dcb_init - Initializes the DCB configuration for a KSZ switch
> + * @dev: Pointer to the KSZ switch device structure
> + *
> + * This function initializes the DCB configuration for a KSZ switch. The global
> + * DSCP-to-priority mapping table is initialized.
> + *
> + * Return: 0 on success, or a negative error code on failure
> + */
> +int ksz_dcb_init(struct ksz_device *dev)
> +{
> +	int ret;
> +
> +	ret = ksz_init_global_dscp_map(dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Sorry for not responding to your previous question about this:
https://lore.kernel.org/netdev/ZfmJ-O8XMT8oO-TS@pengutronix.de/
Simply put, I had a period with not a lot of free time, even for reading
emails.

I'm on the fence on whether your solution to the "global DSCP-to-prio
mapping rather than per-port" problem is the right one.

We try to avoid baking policies into the kernel, no matter how well
intended the 802.1Q and IETF RFC8325 recommendations are. They are still
just recommendations and examples, and a particular use case may want to
configure things completely differently (or as hinted in the Wi-Fi specific
RFC8325: maybe the administrator doesn't want to assign the higher
traffic classes, for network control protocols, by using IP DSCP, and
doesn't want user flows to request DSCP values that would get access to
these traffic classes. It can indeed be seen as a security concern).

I empathize with the incovenience of having to map the per-netdev dcbnl
application priority table API with a piece of hardware where that table
is shared across all ports. But yet, I don't think it is a strong enough
justification for us to make an exception and say: "yeah, ok, let's not
even implement .port_set_dscp_prio() to make the thing configurable, but
let's bake into the kernel a fixed policy that's good for everyone".

No, I think we _need_ the thing to be configurable, and not try so hard
with the ieee8021q helpers to hardcode things just right in the kernel.

Have you tried the obvious: "every time there is a change to the global
DSCP mapping table, push the change into the dcbnl app table of all user
netdevs, so that the user becomes aware of what happens"? Kernel drivers
can do that, through direct calls to dcb_ieee_setapp(). DSA does it too,
to probe the initial QoS configuration of the ports and push it to the
application priority tables.

