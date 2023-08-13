Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C305177AADC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjHMTWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHMTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:22:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175BF18E;
        Sun, 13 Aug 2023 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZxIg9UUewrFM0vEREoEcGwG6IbEZLqB2tnEvw27Bhyw=; b=lOurZ5u9goav9sLbBJjIWVfaq2
        TgKUPLHapU5ze2gv9nHt7Y/NCxbpE8W7D+jh2Fkd5wYrFiGQMhcj4HX+hzh9rOBve0t8O4jze/IKm
        z7xDsOY9kzlTwmsgKjRNIdw+62u5gRc6Ss/l//GJWYUaflJhT2AtSdO4P0bd+5hmtXLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVGfT-003zDS-Sv; Sun, 13 Aug 2023 21:22:27 +0200
Date:   Sun, 13 Aug 2023 21:22:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: phy: mediatek-ge-soc: support PHY LEDs
Message-ID: <473888d3-256f-43ac-bd33-e578918424be@lunn.ch>
References: <32e534441225c62e3bf9384b797d9beda7475053.1691943605.git.daniel@makrotopia.org>
 <8f20d427-91cc-4fbc-b263-dfc76df855f9@lunn.ch>
 <ZNkpPRc9loNX2Wos@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNkpPRc9loNX2Wos@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 08:04:29PM +0100, Daniel Golle wrote:
> On Sun, Aug 13, 2023 at 08:57:01PM +0200, Andrew Lunn wrote:
> > On Sun, Aug 13, 2023 at 05:24:55PM +0100, Daniel Golle wrote:
> > > Implement netdev trigger and primitive bliking offloading as well as
> > > simple set_brigthness function for both PHY LEDs of the in-SoC PHYs
> > > found in MT7981 and MT7988.
> > > 
> > > For MT7988, read boottrap register and apply LED polarities accordingly
> > 
> > Should this be bootstrap? With an S? boottrap appears quite often in
> > the code, so maybe the datasheet does say boottrap?
> 
> Yes, datasheet and vendor code refer to boottrap register which reflects
> the state of the pins used for bootStrapping the SoC...

O.K. So following the datasheet makes sense.

Again, if there is need for a respin, maybe add a comment next to the
#define.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
