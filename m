Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED37CD579
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJRHZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJRHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:25:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954AF7;
        Wed, 18 Oct 2023 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pfDXC/yC0D6NPEvRRuSAl/CZ8bNfgEG2WS3sXs6JgQI=; b=itHVHO6qdF0/oBOpNP2MkKT1WL
        1uP9xdCDFUbl9CFtGrTDBbdzdG76VR2w8LixuCBhUG4npS9LPnNSikeWkzBN6/DS0AMhtIVPMVCRv
        SDVsFN6B/qtqKeu3xfJhdlcnasMmlzDpuGXvDUoZXDKgb6H9v6PleaBcSXMlb1I03APmSACupT5rc
        bk+QPKs3P9s003vom8RzslevvNI6EK2RAa79YYSrH2xsvZWQk4i2wPv0kT5tmYPfMphtGTejsiXL1
        2mM9BDfOJ0lsP8rX36uSmCV1YCEK0IHgKdsHKLSnVM3voDNQo2XV8CtGs30VoaR1RZKnK7Ljf8Obr
        ENVCla3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41020)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qt0vU-0004eT-2c;
        Wed, 18 Oct 2023 08:25:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qt0vS-0007bb-KT; Wed, 18 Oct 2023 08:25:06 +0100
Date:   Wed, 18 Oct 2023 08:25:06 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net 1/1] net: stmmac: update MAC capabilities when tx
 queues are updated
Message-ID: <ZS+IUo5q/AnYm1Gb@shell.armlinux.org.uk>
References: <20231018023137.652132-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018023137.652132-1-yi.fang.gan@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:31:36AM +0800, Gan, Yi Fang wrote:
> From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> 
> Upon boot up, the driver will configure the MAC capabilities based on
> the maximum number of tx and rx queues. When the user changes the
> tx queues to single queue, the MAC should be capable of supporting Half
> Duplex, but the driver does not update the MAC capabilities when it is
> configured so.
> 
> Using the stmmac_reinit_queues() to check the number of tx queues
> and set the MAC capabilities accordingly.

There is other setup elsewhere in the driver that fiddles with this in
stmmac_phy_setup(). Maybe provide a helper function so that this
decision making can be made in one function called from both these
locations, so if the decision making for HD support changes, only one
place needs changing?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
