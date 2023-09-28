Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B27B1EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjI1Nic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjI1Nia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:38:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C89198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:38:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C1FC433C8;
        Thu, 28 Sep 2023 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908308;
        bh=g8ZXaIN93ZfxE2Ei93hCloVx+lzo8p+xJHZE3EoTyxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeY+yq0WZRpbvxIHDdodVZpavSilaGC0SGuJCGzimdgcDrwyAnwfIjvG4EmzVMy9p
         z1EMiBqgmcKaiWq/o0am3uM67cTFY2oALRIcaP5s3SKfjEtFzoxfTZBnprkCQkeIW0
         9XtS45BVAUaqF+GEI5YlLptRXEVSBHmvxSgZ0qEbAkaraft+IrUoYFvSqqycC5Zpiq
         WkLg+aGILOrpJclpz5YkV1NxrcOqD0ilEOd4QMQWal4Qnt4XvuGM4V5U4+7Nj7zpsT
         hR0Kctvufbs3vRS1oanzoQWtQYAp3k5YTFhbBRQcwgjNu9SmmLJK3CxHz8vfeTzewt
         X4kJ3LY5lDi5w==
Date:   Thu, 28 Sep 2023 15:38:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 07/15] net: phylink: centralize
 phy_interface_mode_is_8023z() && phylink_autoneg_inband() checks
Message-ID: <20230928133813.GN24230@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-8-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-8-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:48:56PM +0300, Vladimir Oltean wrote:
> In a future change, we will extend the PHY interface modes for which
> phylink allows the PCS to handle autoneg. Group the existing occurences

nit: occurrences

...
