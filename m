Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137F7B00FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjI0Jvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0Jva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:51:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1811F10E;
        Wed, 27 Sep 2023 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vKsM+wBJcSBpQ28kkR+epO1vMvl77ryBtmDcTsO1n2o=; b=WN+B+LSEPWBw93eSmhjO8z6kXf
        7W197rTkyEhmau3NLA7GhTeOuKhCJdhZSOvV5kLcVTVoM3q0Yf6fmqx21fz10ofOODe9JAR8Xy4uf
        pz5OM5p6xhblup8KPRb3TyU0zTBr/QUE8XPLjVyniSptlJGQFp5X2cU0qpnUtqORWK42gggZdhGa2
        sRGrsrIL9nZEXk7twT4WwP4pRhsp//OEa/muAbigomaJy+tyAWbxWN86+Qn3XHlFEGlKdW26Efw7m
        nYxBuZcrC3Dbj13FdJw2OtSHfj+rbyZ6/ObYFaCQd3m7+8VcTtOeJeSYbWkGD5UVnhp+pXS9mUO49
        65q6iSUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42172)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qlRCQ-0003j8-0e;
        Wed, 27 Sep 2023 10:51:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qlRCP-0001Kv-QV; Wed, 27 Sep 2023 10:51:17 +0100
Date:   Wed, 27 Sep 2023 10:51:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone
 GPON-ONU-34-20BI
Message-ID: <ZRP7FU3BglzFBfgX@shell.armlinux.org.uk>
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
 <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
 <5615a39b3402e7499fd531c928845e102fba6f1c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5615a39b3402e7499fd531c928845e102fba6f1c.camel@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 04:40:45PM +0200, Paolo Abeni wrote:
> Hi Russel,
> 
> On Tue, 2023-09-19 at 14:40 +0100, Russell King (Oracle) wrote:
> > On Tue, Sep 19, 2023 at 02:47:20PM +0200, Christian Marangi wrote:
> > > Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> > > NRZ in their EEPROM.
> > > 
> > > The module also require the ignore tx fault fixup similar to Huawei MA5671A
> > > as it gets disabled on error messages with serial redirection enabled.
> > 
> > I'll send you shortly a different approach for the "ignore tx fault"
> > thing that I'd like you to test please.
> 
> Said patch is not blocking this one, am I correct?

Correct, but Christian has not responded in any way despite me sending
him the patch that I'd like tested, which is very disappointing.

This is what I fear - that merging his patch removes the incentive to
test my patch. Oh well, I guess I will just send my patch that I can't
test to be merged anyway, and to hell with it. If it breaks this and
other modules, I'm sure someone will eventually send a report about
that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
