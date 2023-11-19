Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB57F0408
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjKSC1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSC07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:26:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8CF93
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:26:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD81CC433C8;
        Sun, 19 Nov 2023 02:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700360816;
        bh=VoHoOfSpNaP9qVLMEtcQXPYQyIswkE0mHkAveNm44rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hxH5lUG3ZKnoTO3Bu6m7TnuVK1fkIPSp+yMLAWtjYf7QgrT9h+xXFetL/xsev9O+R
         vzjjCyLFmZluckTgeZDmJkpHglkVRznuw14VLPeae0Rh/rh+35lwGGetX/hzGgQDLw
         odUA935ulOMsiIgLUnuM8IGQ1E+dQZ5Tob10ujEvbmBrfIXYLMRftThz0Amka/idNh
         pG1R+pZL/8D877iWFsX4gpguLOYcHglA6RLgzGvNqJoE1nyNp3xZpvhiZHOPkbBiat
         UyBetbn7Fjbd1peWu8cCTwlw4jJi7kxbMtj5aNoY0YWk9uTWaxKCVXsaiQaPQIt6va
         hNeP4FuFGXWvA==
Date:   Sat, 18 Nov 2023 18:26:53 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 10/16] net: ethtool: Add a command to list
 available time stamping layers
Message-ID: <20231118182653.4b706d99@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-10-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-10-472e77951e40@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 12:28:38 +0100 Kory Maincent wrote:
> +	ETHTOOL_A_TS_LIST_LAYER,		/* array, u32 */

multi-attr u32, please
