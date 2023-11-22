Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64007F435B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbjKVKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjKVKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:13:05 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179DE198;
        Wed, 22 Nov 2023 02:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w6RwZNjGanLOCTIORZpzLlR22CGNQ1cVDCQgks5j9Fw=; b=cDHtQx7uD/ANOBEo+ZQvbLYDwd
        QdbMOatlKS02CgNRWy9Ft+2lOwCYVjcEABfMaphNBkxHKc6fhmXrhdDqgVuGXTq72ZJxtpj3vg+Hr
        vwx5V7clHXIR42QA6tBUVuwfs9B0TmRVX/mFrwOusoLPFs5eOzQRkN1O9OR6WOXDk9YQEzJocDcFS
        szS3guFTdlBKgZD9Lj1gN09t/JDs1lAvT/OVOLC+Uzmprh+KMIVuOFTxLuHv1k8LUaDGiud0DuJX9
        6TlLQMwDImlijhDhMoJfUe/8nBqC54oaaFctEXFen9+SqXvRg7fPXj3kx0cphWQ8hMwUDEXavWrgQ
        t1EIchrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37812)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5kDw-0008Lo-04;
        Wed, 22 Nov 2023 10:12:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5kDw-00056a-SQ; Wed, 22 Nov 2023 10:12:48 +0000
Date:   Wed, 22 Nov 2023 10:12:48 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: make mailbox interface4 lsw
 addr mask more specific
Message-ID: <ZV3UIM+YR0U6PO+e@shell.armlinux.org.uk>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
 <20231121150859.7f934627@kernel.org>
 <655d3e2b.df0a0220.50550.b235@mx.google.com>
 <20231121153918.4234973d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121153918.4234973d@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:39:18PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 00:32:56 +0100 Christian Marangi wrote:
> > the 2 addr comes from a define
> > 
> > #define DRAM_BASE_ADDR		0x3FFE0000
> > #define IRAM_BASE_ADDR		0x40000000
> > 
> > it wasn't clear to me if on BE these addrs gets saved differently or
> > not. PHY wants the addr in LE.
> > 
> > On testing by removing the cpu_to_le32 the error is correctly removed!
> > 
> > I guess on BE the addr was actually swapped and FIELD_GET was correctly
> > warning (and failing) as data was missing in applying the mask.
> 
> I think so. It's the responsibility of whether underlies 
> phy_write_mmd() to make sure the data is put on the bus in
> correct order (but that's still just within the u16 boundaries,
> splitting a constant into u16 halves is not endian dependent).

MDIO bus accesses via the MDIO bus accessors are expected to produce
the correct value in CPU order no matter what endian the host platform
is. So if the BMCR contains the value 0x1234, then reading and then
printing this register is expected to produce 0x1234 irrespective of
the host CPU architecture.

We do have 32-bit values split across two registers in clause 45 PHYs,
namely the MMD present register pair. Another example is the PHY ID.
In both cases we read the registers and apply the appropriate shift.
See get_phy_c45_ids() and get_phy_c22_id(). Note that these, again,
have to work independent of the CPU architecture.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
