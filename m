Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD777AAC7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHMTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjHMTFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:05:01 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72246DA;
        Sun, 13 Aug 2023 12:04:59 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qVGOJ-0000QV-0X;
        Sun, 13 Aug 2023 19:04:43 +0000
Date:   Sun, 13 Aug 2023 20:04:29 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <ZNkpPRc9loNX2Wos@makrotopia.org>
References: <32e534441225c62e3bf9384b797d9beda7475053.1691943605.git.daniel@makrotopia.org>
 <8f20d427-91cc-4fbc-b263-dfc76df855f9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f20d427-91cc-4fbc-b263-dfc76df855f9@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 08:57:01PM +0200, Andrew Lunn wrote:
> On Sun, Aug 13, 2023 at 05:24:55PM +0100, Daniel Golle wrote:
> > Implement netdev trigger and primitive bliking offloading as well as
> > simple set_brigthness function for both PHY LEDs of the in-SoC PHYs
> > found in MT7981 and MT7988.
> > 
> > For MT7988, read boottrap register and apply LED polarities accordingly
> 
> Should this be bootstrap? With an S? boottrap appears quite often in
> the code, so maybe the datasheet does say boottrap?

Yes, datasheet and vendor code refer to boottrap register which reflects
the state of the pins used for bootStrapping the SoC...

> 
>     Andrew
