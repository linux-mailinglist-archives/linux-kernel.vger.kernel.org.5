Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10297635E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGZMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:12:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D064810F6;
        Wed, 26 Jul 2023 05:12:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3163eb69487so642779f8f.1;
        Wed, 26 Jul 2023 05:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373536; x=1690978336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2nU+bAX6kxjYVWuXj2WdFQzPdKXHe7OZMyn0349efQ=;
        b=bfPgcHrnXlY86nfsSjeIKb592GI3EnqkJWXRgmCkvnvflSR3OlLTIUKCRKGTsup3Gw
         J8PaojWrGiKRr1ec+GWU/fvKy6SZT0IBjaH/xlGKAFFSpm2jW/39pNw0sQ8LPh/ublNu
         1sHkhqNhxt7ashzhsM8VE9bF8eIcdYQrAWdUVupGnjWjkB7oB7d60Jng1glZOgvOKuwD
         gdiHrDfGJ/GvBXVW08pJeWVCne0eT8cbcuWqQV2kh8/F4ehA1Sc8CxpMgfeZk7FhDzIg
         62h5cElztyMUEbfcmzBmG2UBSXhLOyu91Yf4ItKST5SArDGkuV79bSzy7bVdRMfozb8Z
         9rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373536; x=1690978336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2nU+bAX6kxjYVWuXj2WdFQzPdKXHe7OZMyn0349efQ=;
        b=Yk5FpWXRfd9/9g3jMrmalLcqRAw6guR44mBBVIQWaK6/fDHs8kq3R5GKvObtFCxrIY
         55nEcNS8qfg5atsDVS/LzjUdWKsFXl9E2IvMh4xCehyFCeZemR94l4j4/OL14X6PBrRI
         6q8nX7VkEXe2gA456wW642+Y2UtoPmR1ci8fz8CwdO+3YS6HoLAtlxKUQz8NDwbriR9v
         6KOTSw1zFIMm1lBmB5eIQFC29SZUlGW5T+omHhmvclDQ3aBq+NlY5r97P2Ttn5Abmt3h
         7JRMySZACzL8WywQAVgCZnJo5KKZYBKMau9fENJZqizjiwaLe+++6CHr1CASv0/psQ8r
         HIpA==
X-Gm-Message-State: ABy/qLYsPVVA9waz9YfDmwM5a9cTig08tblT0AirBG0LXNJ5f2Wxi4Mv
        sJ+5trNRDC7kH31XKI4W1/Y=
X-Google-Smtp-Source: APBJJlGLbfCHnTaCm4ogb3MRKwiwNVwJGzgzU14fE0MBraouGsYWvGK05pgcZ8htFKxdUi999rZI0w==
X-Received: by 2002:a5d:680b:0:b0:317:59a6:6f68 with SMTP id w11-20020a5d680b000000b0031759a66f68mr1950752wru.0.1690373536124;
        Wed, 26 Jul 2023 05:12:16 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b003143c6e09ccsm19424870wrx.16.2023.07.26.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:12:15 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:12:13 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <20230726121213.3uehfygkz7rchlqf@skbuf>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-2-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:30:57AM +0200, Christian Marangi wrote:
> Address learning should initially be turned off by the driver for port
> operation in standalone mode, then the DSA core handles changes to it
> via ds->ops->port_bridge_flags().
> 
> Currently this is not the case for qca8k where learning is enabled
> unconditionally in qca8k_setup for every user port.
> 
> Handle ports configured in standalone mode by making the learning
> configurable and not enabling it by default.
> 
> Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
> enable learning for bridge that request it and tweak
> .port_stp_state_set to correctly disable learning when port is
> configured in standalone mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Small nitpick below.

>  drivers/net/dsa/qca/qca8k-8xxx.c   |  7 +++--
>  drivers/net/dsa/qca/qca8k-common.c | 44 ++++++++++++++++++++++++++++++
>  drivers/net/dsa/qca/qca8k.h        |  6 ++++
>  3 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index ae088a4df794..31552853fdd4 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1870,9 +1870,8 @@ qca8k_setup(struct dsa_switch *ds)
>  			if (ret)
>  				return ret;
>  
> -			/* Enable ARP Auto-learning by default */
> -			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
> -					      QCA8K_PORT_LOOKUP_LEARN);
> +			ret = regmap_clear_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
> +						QCA8K_PORT_LOOKUP_LEARN);
>  			if (ret)
>  				return ret;
>  
> @@ -1978,6 +1977,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
>  	.port_change_mtu	= qca8k_port_change_mtu,
>  	.port_max_mtu		= qca8k_port_max_mtu,
>  	.port_stp_state_set	= qca8k_port_stp_state_set,
> +	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
> +	.port_bridge_flags	= qca8k_port_bridge_flags,
>  	.port_bridge_join	= qca8k_port_bridge_join,
>  	.port_bridge_leave	= qca8k_port_bridge_leave,
>  	.port_fast_age		= qca8k_port_fast_age,
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 13b8452ce5b2..e53694d2852a 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -565,9 +565,26 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
> +					 bool learning)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +
> +	if (learning)
> +		return regmap_set_bits(priv->regmap,
> +				       QCA8K_PORT_LOOKUP_CTRL(port),
> +				       QCA8K_PORT_LOOKUP_LEARN);
> +	else
> +		return regmap_clear_bits(priv->regmap,
> +					 QCA8K_PORT_LOOKUP_CTRL(port),
> +					 QCA8K_PORT_LOOKUP_LEARN);
> +}
> +
>  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  {
> +	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct qca8k_priv *priv = ds->priv;
> +	bool learning = false;
>  	u32 stp_state;
>  
>  	switch (state) {
> @@ -582,8 +599,11 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  		break;
>  	case BR_STATE_LEARNING:
>  		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
> +		learning = dp->learning;
>  		break;
>  	case BR_STATE_FORWARDING:
> +		learning = dp->learning;
> +		fallthrough;
>  	default:
>  		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
>  		break;
> @@ -591,6 +611,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  
>  	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
>  		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> +
> +	qca8k_port_configure_learning(ds, port, learning);
> +}
> +
> +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> +				struct switchdev_brport_flags flags,
> +				struct netlink_ext_ack *extack)
> +{
> +	if (flags.mask & ~BR_LEARNING)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> +			    struct switchdev_brport_flags flags,
> +			    struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +
> +	ret = qca8k_port_configure_learning(ds, port,
> +					    flags.val & BR_LEARNING);
> +
> +	return ret;

I worry that the way in this is formulated will attract patches from
kernel janitors to simplify it to:

	return qca8k_port_configure_learning(...)

I agree that it's not strictly necessary to check flags.mask when
port_pre_bridge_flags supports a single flag, but if you did that and
structured the code for more future flags, you could avoid that.

	int ret;

	if (flags.mask & BR_LEARNING) {
		ret = qca8k_port_configure_learning(...,
						    flags.val & BR_LEARNING);
		if (ret)
			return ret;
	}

	return 0;

Anyway, probably not a big deal.

>  }
>  
>  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
> diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> index c5cc8a172d65..8f88b7db384d 100644
> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/drivers/net/dsa/qca/qca8k.h
> @@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
>  
>  /* Common bridge function */
>  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
> +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> +				struct switchdev_brport_flags flags,
> +				struct netlink_ext_ack *extack);
> +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> +			    struct switchdev_brport_flags flags,
> +			    struct netlink_ext_ack *extack);
>  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
>  			   struct dsa_bridge bridge,
>  			   bool *tx_fwd_offload,
> -- 
> 2.40.1
> 

