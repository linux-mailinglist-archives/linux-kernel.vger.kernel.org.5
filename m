Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E50765BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjG0TFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjG0TFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:05:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FB9210B;
        Thu, 27 Jul 2023 12:05:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso14676015e9.1;
        Thu, 27 Jul 2023 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690484731; x=1691089531;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nIx6nzK1csipmfPjI95rDJjLnMfx1PFSyc3lWa7vvrc=;
        b=ii3hjhVJ3BJkubwmKOh79nhvCZikM1KTN7kY7sfD45meSp7XEmATGp7W4mWIx3bJwB
         CWHV25uZpWDIMGKGBBkmv4v67g+DrVd8gHuzFmhoY3wD/3wAKMzIFSVWdBV5QPcFBFm3
         Twe6zGISOulfT8GJ/E3+ow2I0ftejuCVdBdCO+16BcXIoKorJ2RE3aq8iVGlIFJLfBjT
         SHTjPulLqzlRZkdL95WuaYRA5iRhX1+OuWYdfJEwCXcc6LGpM7bQ7Trsb2nYFVmE6XRx
         p+prALiRW6zqI9u9cUB1uUrirm1/f0ce626pVkA4ael7U2AbiuhN3EhIN0ar1G37IFm/
         3rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484731; x=1691089531;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIx6nzK1csipmfPjI95rDJjLnMfx1PFSyc3lWa7vvrc=;
        b=Hro1a4x4QBX02zHlg/IncbuxUpTW5ZK0gMVo/2xrPjR+vEFMwggU8h7cBRGY+joUCE
         ZpnBevSsIjhk/5zGBsnsEetQVXzAugI/urGtJXqOYnKqYejdxMmmN0/ZrPXfTxc+8pEr
         MCx1Ro8bRQLYLq0TNW4o3ilAcRIqAb3vvMxMTLn2NJ2A6wR6rTaE9tQltPQ1UBEOKSu3
         PQ6fXN3jtiEKIMM26iiExjv5KdScrmOd6pt3CRr1JduA9Nj3ahRQuwmoHbIkhSCPpIFB
         +LjflgVfHpzJ+ZM/f85ZX/05bOPeyGyDv1oMmPHrcydn08Cj2SUdLbGtDxXYJ/pSguUX
         Y90A==
X-Gm-Message-State: ABy/qLbX4kGhXYPd6GzCaL6j3DSfVlgsy7/BmU+z/wKgbykMmU6t3ljx
        hxYgPehq5Ig6YnbvHfra5HhmF07MK8ehdg==
X-Google-Smtp-Source: APBJJlHJ7puWts4CflXO4H+wofp3DYNCnNSEPNzyOp9lZBZmPIP+OFWm7CMpHs3T3c1zd2APi0RuEQ==
X-Received: by 2002:a7b:c4d3:0:b0:3f8:fac0:ad40 with SMTP id g19-20020a7bc4d3000000b003f8fac0ad40mr2449541wmk.29.1690484730568;
        Thu, 27 Jul 2023 12:05:30 -0700 (PDT)
Received: from Ansuel-xps. (host-87-19-253-131.retail.telecomitalia.it. [87.19.253.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c029100b003f9bd9e3226sm2530980wmk.7.2023.07.27.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:05:29 -0700 (PDT)
Message-ID: <64c2bff9.050a0220.49b7e.cb84@mx.google.com>
X-Google-Original-Message-ID: <ZMK/+P2OMKuKFl7P@Ansuel-xps.>
Date:   Thu, 27 Jul 2023 21:05:28 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable
 and keep off if standalone
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
 <20230726121213.3uehfygkz7rchlqf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726121213.3uehfygkz7rchlqf@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:12:13PM +0300, Vladimir Oltean wrote:
> On Mon, Jul 24, 2023 at 05:30:57AM +0200, Christian Marangi wrote:
> > Address learning should initially be turned off by the driver for port
> > operation in standalone mode, then the DSA core handles changes to it
> > via ds->ops->port_bridge_flags().
> > 
> > Currently this is not the case for qca8k where learning is enabled
> > unconditionally in qca8k_setup for every user port.
> > 
> > Handle ports configured in standalone mode by making the learning
> > configurable and not enabling it by default.
> > 
> > Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
> > enable learning for bridge that request it and tweak
> > .port_stp_state_set to correctly disable learning when port is
> > configured in standalone mode.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 
> Small nitpick below.
> 
> >  drivers/net/dsa/qca/qca8k-8xxx.c   |  7 +++--
> >  drivers/net/dsa/qca/qca8k-common.c | 44 ++++++++++++++++++++++++++++++
> >  drivers/net/dsa/qca/qca8k.h        |  6 ++++
> >  3 files changed, 54 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> > index ae088a4df794..31552853fdd4 100644
> > --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> > +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> > @@ -1870,9 +1870,8 @@ qca8k_setup(struct dsa_switch *ds)
> >  			if (ret)
> >  				return ret;
> >  
> > -			/* Enable ARP Auto-learning by default */
> > -			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
> > -					      QCA8K_PORT_LOOKUP_LEARN);
> > +			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
> > +						QCA8K_PORT_LOOKUP_LEARN);
> >  			if (ret)
> >  				return ret;
> >  
> > @@ -1978,6 +1977,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
> >  	.port_change_mtu	= qca8k_port_change_mtu,
> >  	.port_max_mtu		= qca8k_port_max_mtu,
> >  	.port_stp_state_set	= qca8k_port_stp_state_set,
> > +	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
> > +	.port_bridge_flags	= qca8k_port_bridge_flags,
> >  	.port_bridge_join	= qca8k_port_bridge_join,
> >  	.port_bridge_leave	= qca8k_port_bridge_leave,
> >  	.port_fast_age		= qca8k_port_fast_age,
> > diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> > index 13b8452ce5b2..e53694d2852a 100644
> > --- a/drivers/net/dsa/qca/qca8k-common.c
> > +++ b/drivers/net/dsa/qca/qca8k-common.c
> > @@ -565,9 +565,26 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
> >  	return 0;
> >  }
> >  
> > +static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
> > +					 bool learning)
> > +{
> > +	struct qca8k_priv *priv = ds->priv;
> > +
> > +	if (learning)
> > +		return regmap_set_bits(priv->regmap,
> > +				       QCA8K_PORT_LOOKUP_CTRL(port),
> > +				       QCA8K_PORT_LOOKUP_LEARN);
> > +	else
> > +		return regmap_clear_bits(priv->regmap,
> > +					 QCA8K_PORT_LOOKUP_CTRL(port),
> > +					 QCA8K_PORT_LOOKUP_LEARN);
> > +}
> > +
> >  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> >  {
> > +	struct dsa_port *dp = dsa_to_port(ds, port);
> >  	struct qca8k_priv *priv = ds->priv;
> > +	bool learning = false;
> >  	u32 stp_state;
> >  
> >  	switch (state) {
> > @@ -582,8 +599,11 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> >  		break;
> >  	case BR_STATE_LEARNING:
> >  		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
> > +		learning = dp->learning;
> >  		break;
> >  	case BR_STATE_FORWARDING:
> > +		learning = dp->learning;
> > +		fallthrough;
> >  	default:
> >  		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
> >  		break;
> > @@ -591,6 +611,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
> >  
> >  	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> >  		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> > +
> > +	qca8k_port_configure_learning(ds, port, learning);
> > +}
> > +
> > +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> > +				struct switchdev_brport_flags flags,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	if (flags.mask & ~BR_LEARNING)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> > +			    struct switchdev_brport_flags flags,
> > +			    struct netlink_ext_ack *extack)
> > +{
> > +	int ret;
> > +
> > +	ret = qca8k_port_configure_learning(ds, port,
> > +					    flags.val & BR_LEARNING);
> > +
> > +	return ret;
> 
> I worry that the way in this is formulated will attract patches from
> kernel janitors to simplify it to:
> 
> 	return qca8k_port_configure_learning(...)
> 
> I agree that it's not strictly necessary to check flags.mask when
> port_pre_bridge_flags supports a single flag, but if you did that and
> structured the code for more future flags, you could avoid that.
> 
> 	int ret;
> 
> 	if (flags.mask & BR_LEARNING) {
> 		ret = qca8k_port_configure_learning(...,
> 						    flags.val & BR_LEARNING);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	return 0;
> 
> Anyway, probably not a big deal.
> 
> >  }

I hope and expect to send fbd isolation later with FLOOD flags so I will
send v2 of this with the suggested format.

> >  
> >  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
> > diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> > index c5cc8a172d65..8f88b7db384d 100644
> > --- a/drivers/net/dsa/qca/qca8k.h
> > +++ b/drivers/net/dsa/qca/qca8k.h
> > @@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
> >  
> >  /* Common bridge function */
> >  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
> > +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> > +				struct switchdev_brport_flags flags,
> > +				struct netlink_ext_ack *extack);
> > +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> > +			    struct switchdev_brport_flags flags,
> > +			    struct netlink_ext_ack *extack);
> >  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
> >  			   struct dsa_bridge bridge,
> >  			   bool *tx_fwd_offload,
> > -- 
> > 2.40.1
> > 
> 

-- 
	Ansuel
