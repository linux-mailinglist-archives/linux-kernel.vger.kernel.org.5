Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02676B7BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjHAOhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjHAOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:37:11 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12921BE9;
        Tue,  1 Aug 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Cn/PxLC8AbI28Q5IHeVvnNoMvVL10AEXiSjjBI1jXRg=; b=PHfZpnDgufC4oY/n90EGUM4pho
        Ld1hZx8i1nLktFuBHEjIFUWZ7x5EpUaN5AoH+W7GdXnMZk5BeLYQBjtuIbq+DzAonzwwhbZFZ8vOZ
        8K24ZfQjaq7FPCkf193lKSkLfhePDRvS8zolLReTKubZWUWtg/7tJQyFV5WRpsIwC4M0nCQNQ244a
        r894nBLnDjv0W+OTS57Xb9g9t2MlzQH9HHgcl5X/4DwSD2Mc+Xl0RbQ7ZTohcH4g9hWrbkjIAHvcq
        DXJckWDH6LUPVp7Tc2SAV98ifNIvPS8TqXbgiG6U72vuvCOjpksFCVogVKfyE62sRnqPKkwT+bFWy
        B+CLxojQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35248)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQqUM-0004FE-1H;
        Tue, 01 Aug 2023 15:36:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQqUL-0000la-H1; Tue, 01 Aug 2023 15:36:41 +0100
Date:   Tue, 1 Aug 2023 15:36:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Message-ID: <ZMkYeWY5O2p4OnOT@shell.armlinux.org.uk>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
 <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
 <ZLpyjNJsQjOw2hfj@shell.armlinux.org.uk>
 <20230724082449.GA17358@raju-project-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724082449.GA17358@raju-project-pc>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 01:54:49PM +0530, Raju Lakkaraju wrote:
> The 07/21/2023 12:57, Russell King (Oracle) wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Jul 21, 2023 at 09:49:06AM +0100, Russell King (Oracle) wrote:
> > > On Fri, Jul 21, 2023 at 11:30:17AM +0530, Raju Lakkaraju wrote:
> > > > +   lan743x_mac_cfg_update(adapter, state->link, state->speed,
> > > > +                          state->advertising);
> > >
> > > Please, no new state->speed users in mac_config().
> > 
> > I have just submitted a patch series that results in state->speed always
> > being set to SPEED_UNKNOWN when this function is called to prevent
> > future uses of this struct member.
> 
> Still, these changes are not available in "net-next" branch.
> I will check and fix.

The changes went in last week, which means phylink no longer supports
the legacy mode stuff, nor use of the above.

Please respin your changes to use the modern approach.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
