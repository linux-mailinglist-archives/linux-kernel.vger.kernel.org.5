Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8A765DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjG0VRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjG0VRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:17:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB430E2;
        Thu, 27 Jul 2023 14:17:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so15443385e9.0;
        Thu, 27 Jul 2023 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492621; x=1691097421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8EiKycpWrQW8TPUC/04LyVjN+dd4bOmadKUuuhDzS8=;
        b=GxB0Dy7BLrtouVb/j8aNJMF6RWEjP5wuLCNfe5Dtygl0ZPHI0+S2MWZQzyaGTyM3FE
         hhBS0uT4abfN7g/3YxnZPh7hi23ThhPgh10HNajPYwhzGgcfO5qs7xRtR+c+2fkWkOK+
         8NBGIhCYFJeKPTvHyzEUL4V11M86KEWpDdmGRTbtBzYIs7FrmEKIiT//phICCAauCGJG
         ZEz9S/SSUkiCGMBKIW76swlb45geU3XnDAHUUCn4VhU4SDa7Sb+6z6MtpT04q3sinBAT
         byIvyYTXdW5mPyBRytKkBCjRZzI09XtRFhHqeWeFdpNpJJDKguwKaUO7MVl3/1JJoqGs
         LrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492621; x=1691097421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8EiKycpWrQW8TPUC/04LyVjN+dd4bOmadKUuuhDzS8=;
        b=eq5p/I7sSgdcXhqzuT3KHehiZl+beiqexEPuym/KNYRmy3MsGcdEc1B6NonwWp4OuL
         C7XAyULA9qHitAB/0ORKQxORMdXojUKc21R4j7NSD10n7imFa2XzGOScplfhpa5GtdIB
         xtrlJad/tjDjdj3kgmiOfceLR4YgAO1/R5zowg8PbwJWamZYkq8rAi+7lPFkeSEwMspT
         42bMi8CWcfjDBy/xd4ZMKJIUOg1qDiyM+z699uJewNdw1CpRkiV5lD/q621eQD20yyA6
         yz8hrkUbMtK0W9C0Kms1rRkeAWGp2IIYnu8p7+2UBayvfb6Cv1D5O7NwwR3sCSz41bmy
         5GMg==
X-Gm-Message-State: ABy/qLZvm1QGlBAdiSSCbbQZPsraTkqz8O6MJtqrQy/L3c4SUmJOkOsH
        b4eYb1apCSp5salsXPiBgOo=
X-Google-Smtp-Source: APBJJlFvtkn/m5BFowdTBQQo1i9q7DMSDUxWMoSa7ByIXErw7qY4O6yChdzPBK5w4rNLFf22KtGfvQ==
X-Received: by 2002:a5d:438f:0:b0:317:54d9:eb48 with SMTP id i15-20020a5d438f000000b0031754d9eb48mr246125wrq.11.1690492621102;
        Thu, 27 Jul 2023 14:17:01 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0031773a8e5c4sm3049793wrn.37.2023.07.27.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:17:00 -0700 (PDT)
Date:   Fri, 28 Jul 2023 00:16:58 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to
 the first CPU port on setup
Message-ID: <20230727211658.3gkjql5jww44hr4c@skbuf>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:30:58AM +0200, Christian Marangi wrote:
> In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
> the port loop and setup the LOOKUP MEMBER mask for user ports only to
> the first CPU port.
> 
> This is to handle flooding condition where every CPU port is set as
> target and prevent packet duplication for unknown frames from user ports.
> 
> Secondary CPU port LOOKUP MEMBER mask will be setup later when
> port_change_master will be implemented.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  drivers/net/dsa/qca/qca8k-8xxx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 31552853fdd4..6286a64a2fe3 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1850,18 +1850,16 @@ qca8k_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> +	/* CPU port gets connected to all user ports of the switch */
> +	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),
> +			QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
> +	if (ret)
> +		return ret;
> +
>  	/* Setup connection between CPU port & user ports
>  	 * Configure specific switch configuration for ports
>  	 */
>  	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
> -		/* CPU port gets connected to all user ports of the switch */
> -		if (dsa_is_cpu_port(ds, i)) {
> -			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
> -					QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
> -			if (ret)
> -				return ret;
> -		}
> -
>  		/* Individual user ports get connected to CPU port only */
>  		if (dsa_is_user_port(ds, i)) {
>  			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),

FWIW, the remaining loop can be rewritten (in a separate patch) using
dsa_switch_for_each_user_port(), which is actually an operation of lower
complexity compared to "for" + "dsa_is_user_port".

> -- 
> 2.40.1
> 
