Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3A78FDB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjIAMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjIAMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:47:41 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9361712;
        Fri,  1 Sep 2023 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hBuX7nam5gAwvmnrcnEmb9akPHOPpfY13LdGw+HDNN4=; b=VS9CV/bnPTECa4kVBOglmidFnz
        DZoU2xOv9m6v9xwyr03s63CnbrEebOlw0HhCxVIkktpuz1VoecbABL07nFYO/XgMbjcDFMOpmoWT/
        WM0K/JQ85uw34SMTY56jBM58KJ1EERr5V2vOhxFSnEXAmSKv/wyhKHnWg0Sm3I8EQCYPCL/alRn1H
        IE3xv/kreq3kgA6iMpZ4Cc5cd6GBUSgSgVXmT81zdF5OeK0BlPOzjN6PfWv/oXZFGGZlRG0AAmrfG
        gf/Rn0oMnsR5kWFPpKOHSO9Qzo3igTW23eZlaiPolOld6zK58nMfFs1+j2g5fec7+Syn2aFWM9MUC
        m7HzmWTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35794)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qc3X1-00049k-0L;
        Fri, 01 Sep 2023 13:45:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qc3Wy-0007qD-LR; Fri, 01 Sep 2023 13:45:44 +0100
Date:   Fri, 1 Sep 2023 13:45:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     Radu Pirea <radu-nicolae.pirea@nxp.com>,
        "atenart@kernel.org" <atenart@kernel.org>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <ZPHc+Jr14WAMKXvX@shell.armlinux.org.uk>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
 <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPGuchwza3xr5SaF@shell.armlinux.org.uk>
 <f094ff74-4ee8-e58e-a1f1-0be27cfe729a@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f094ff74-4ee8-e58e-a1f1-0be27cfe729a@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:31:32PM +0300, Radu Pirea (OSS) wrote:
> On 01.09.2023 12:27, Russell King (Oracle) wrote:
> > On Fri, Sep 01, 2023 at 09:09:06AM +0000, Radu Pirea wrote:
> > > On Wed, 2023-08-30 at 13:35 +0200, Sabrina Dubroca wrote:
> > > ...
> > > 
> > > > And it's not restored when the link goes back up? That's inconvenient
> > > > :/
> > > > Do we end up with inconsistent state? ie driver and core believe
> > > > everything is still offloaded, but HW lost all state? do we leak
> > > > some resources allocated by the driver?
> > > 
> > > Yes. We end up with inconsistent state. The HW will lost all state when
> > > the phy is reseted. No resource is leaked, everything is there, but the
> > > configuration needs to be reapplied.
> > 
> > If it's happening because the PHY is being re-attached from the network
> > driver, then wouldn't it be a good idea to synchronise the hardware > state with the software configuration in the ->config_init function?
> 
> .config_init might be an option, but keeping the keys in the driver might
> not be a good idea.
> 
> > 
> > Presumably the hardware state is also lost when resuming from suspend
> > as well? If so, that'll also fix that issue as well.
> soft_reset is called when resuming from suspend, so, in this case, the
> MACsec configuration will be lost.

Depending on what loses power at suspend time, it could be that the PHY
is powered down, and thus would lose all configuration. This is
something that the MACSEC core _has_ to expect may happen, and there
has to be some way to restore the configuration, including the
keys!

One can't "write configuration to hardware and then forget" when the
hardware may lose state, no matter what the configuration is.

Take for example hibernation... where the system may be effectively
powered off - maybe even if it's a piece of mains powered equipment,
it may be unplugged from the mains. When the system resumes, shouldn't
the configuration be completely restored, keys and all, so that it
continues to function as it was before hibernation?

The only possible alternative would be to have some kind of way for
the driver to tell the core that state was lost, so the core can
invalidate that state and inform userspace of that event, so userspace
gets the opportunity itself to restore the lost state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
