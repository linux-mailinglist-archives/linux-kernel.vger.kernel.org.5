Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB7577AA49
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjHMRRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMRRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:17:54 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44610D0;
        Sun, 13 Aug 2023 10:17:56 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qVEim-00009H-1y;
        Sun, 13 Aug 2023 17:17:44 +0000
Date:   Sun, 13 Aug 2023 18:17:11 +0100
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
Message-ID: <ZNkQFwvm_sNiVDRO@makrotopia.org>
References: <32e534441225c62e3bf9384b797d9beda7475053.1691943605.git.daniel@makrotopia.org>
 <9bae16cd-501e-4fe5-9736-d32d958aec7c@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bae16cd-501e-4fe5-9736-d32d958aec7c@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thank you for reviewing my patch!

On Sun, Aug 13, 2023 at 07:03:21PM +0200, Andrew Lunn wrote:
> Hi Daniel
> 
> > This requires syscon phandle 'mediatek,pio' present in parenting MDIO bus
> > which should point to the syscon holding the boottrap register.
> 
> If i'm reading the code correct, if this property is missing, the PHY
> will fail to probe? Since this was never a mandatory property, it
> looks like this will break old DT blobs?

As the for-upstream-Linux dtsi for the MediaTek MT7988 SoC is still in
the making there aren't any existing DT blobs we'd want to be compatible
with at this point.

> 
> If there are LED properties, then it should be mandatory, otherwise it
> should be optional. That way you keep backwards compatibility with old
> blobs.

Do you still want me to check for the presence of any led properties
before looking for the syscon phandle?
As in: would you like to have it that way anyway even if compatibility
is not an issue?


Cheers


Daniel
