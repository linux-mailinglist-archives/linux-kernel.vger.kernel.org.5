Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C1798A21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbjIHPme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjIHPme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:42:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8C1FD9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:42:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31EC433C9;
        Fri,  8 Sep 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694187749;
        bh=GtViuvQNjO5QyEqMbHXIoI+ao0sM4hudHD4TCioXYDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S6HKSkVxEMXvAIoGpPPnYkmN6UhqxYt6LWw7o8KOq3fuZ8pteF+7X124oopEpqq0l
         JfS2N3rOPa2/ld+k6qz4C/OHtfUFXYHOFuYWyyd7ROToOGOEz4OpeC+Dst/SndGjMK
         RbchcMdk7T76emowY1XWKIR7H9MhtkODFkIT+sjp+c2/o+Wup2AMFXrMxCUc+XU7d4
         K0Qq3Xsu9pLr6Y4KHWoyls2DoFOlplTgNvwgVsW4C5w04GuFjNg/+NxubJCyP5L3t5
         XRfpQldS8uz9SU6WTjYjt2jNeEWC9Ay1XHcHfCytRSaMfkbK/FBDDbCJSrKO65iWSZ
         r2cKM1oDyq+Kw==
Date:   Fri, 8 Sep 2023 08:42:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230908084228.7887c1a9@kernel.org>
In-Reply-To: <20230907092407.647139-7-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-7-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Sep 2023 11:24:04 +0200 Maxime Chevallier wrote:
> +enum phy_upstream_type {
> +	PHY_UPSTREAM_MAC,
> +	PHY_UPSTREAM_SFP,
> +	PHY_UPSTREAM_PHY,
> +};

Would be good to define the enum in the YAML spec, too.
That way YNL users can auto-magically see strings for the values.
