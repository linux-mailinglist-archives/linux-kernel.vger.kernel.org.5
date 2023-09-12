Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAAA79D527
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjILPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:41:38 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E68110E5;
        Tue, 12 Sep 2023 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jcNhuGiuvlufLMmmJWjXnQrVR4HUnrinAE2kQhhku7Q=; b=Qc9E8cHsgoi7R3CAggnd9UMSC5
        JAGK+u0XXGAYP8PolDIUPfid98jIAo1WzneEywa6muZHt30lLpxRfr5jqw+ZIHJrd8owon8Sl82RH
        Sez57piojvzb/yqbr2nKEnlHQ524XnBGn+2IZCJvxTskPkRfcAI1sndv1RBBv6bewVhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qg5W7-006F8Y-NZ; Tue, 12 Sep 2023 17:41:31 +0200
Date:   Tue, 12 Sep 2023 17:41:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
        thomas.petazzoni@bootlin.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <d0a4c2c5-2d2b-42b6-a15c-06f9dc3c1e04@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <20230907092407.647139-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907092407.647139-2-maxime.chevallier@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Introduce a numbering scheme allowing to enumerate PHY devices that
> belong to any netdev, which can in turn allow userspace to take more
> precise decisions with regard to each PHY's configuration.

A minor point, and i know naming is hard, but i keep reading _ns_ and
think namespace, as in ip netns. Maybe we should think of something
other than ns.

      Andrew
