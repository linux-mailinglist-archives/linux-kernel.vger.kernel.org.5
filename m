Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1685A7F0405
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKSCZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSCZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:25:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF34E0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:25:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2378DC433C8;
        Sun, 19 Nov 2023 02:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700360712;
        bh=POWSirjZ6zTCT6jiTYaz4Ladza7MojwlK1oOFCZP/Bk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/BNYQnMTD9rublX+rGu5ulgy+9lBQj5hfurEmJWDqti4AGA2ddaF9cgPy7PXsZub
         sqjWgdnGAVJZtErIACW1aXKjWsh1jF0M0nerrILzDjB0OETE2Mst67kFwnihYGUbnD
         c3EkfQDPxAx6H/ebviLI/l63FUrYl1VXq3GeOfl5eGZ51ESnIeUI4hwuQ17vjFvpYT
         gtgdwpkCxkEm9B/qy853kkxiXVeTDUuIM6MCa1IO/XYb7jKW/e1q927bHPQWleP+/q
         lrP4MmqxsdUxlYdwY2rAxLZPzpfwbtGHhbfDzJ/q783ByXLflB6We+SAEFzeLbCeqd
         c74gH/5oCIXLA==
Date:   Sat, 18 Nov 2023 18:25:10 -0800
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
Subject: Re: [PATCH net-next v7 09/16] netlink: specs: Introduce new netlink
 command to get current timestamp
Message-ID: <20231118182510.42c436c8@kernel.org>
In-Reply-To: <20231114-feature_ptp_netnext-v7-9-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
        <20231114-feature_ptp_netnext-v7-9-472e77951e40@bootlin.com>
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

On Tue, 14 Nov 2023 12:28:37 +0100 Kory Maincent wrote:
> +  -
> +    name: ts
> +    attributes:
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: ts-layer
> +        type: u32

Please add the definition of the enum to the spec,
and link it here, so that Python can convert the values
to names.
