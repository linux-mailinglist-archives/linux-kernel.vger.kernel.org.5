Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110F379D5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjILQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjILQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:10:19 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7BA10F2;
        Tue, 12 Sep 2023 09:10:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 714D1240003;
        Tue, 12 Sep 2023 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694535013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DT8iGeDItdtWzaedjFGa4m53NfWAlQ4+8otdLECzuho=;
        b=PnoY2ckTZmkESHjnuiBZzsNYU8+9I/M7/DFM3hDegKEZIkY66s7GOATe2qgCi4iJT3CDJc
        YJ3NCGAKB7C3ZHrFCfsrvDS6WNbkrZHvIfojkIjbCqTK3bQbAEJFE0+OhwkW9KD1J32vn4
        V73Nvjem4WcchpXoCRTCHJlmvucUOEJdtABoVcOK2Ty5gcYZwUQsV4otx3s+dbAifJF83J
        djDIm2CwkB1WA/lYQRshJ8Fbq28OxB0C/UMJlYAlryHzScmaoNzLhFgtsq7u9kiwSEzl/1
        /utBFWgQyBN/YZZ7AzJ8jEQdXx0L3DCRyK5ZLhex2XN3EEm5bVGYQaBRtQ7Y7w==
Date:   Tue, 12 Sep 2023 18:10:10 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230912181010.615d6b79@fedora>
In-Reply-To: <d0a4c2c5-2d2b-42b6-a15c-06f9dc3c1e04@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
        <20230907092407.647139-2-maxime.chevallier@bootlin.com>
        <d0a4c2c5-2d2b-42b6-a15c-06f9dc3c1e04@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 12 Sep 2023 17:41:31 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Introduce a numbering scheme allowing to enumerate PHY devices that
> > belong to any netdev, which can in turn allow userspace to take more
> > precise decisions with regard to each PHY's configuration.  
> 
> A minor point, and i know naming is hard, but i keep reading _ns_ and
> think namespace, as in ip netns. Maybe we should think of something
> other than ns.

Yeah that was the initial idea, to imply that the numering is
independent between netdevices... I thought about "phy_list", "phys",
"phy_devices" but none of that felt correct :(

Any idea here would be welcome :D

Maxime

>       Andrew

