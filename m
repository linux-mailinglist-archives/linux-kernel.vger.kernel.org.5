Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1451E7539CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjGNLme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjGNLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:42:29 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C373035B5;
        Fri, 14 Jul 2023 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=At0xbxSbJqBndkT5E1gEuaNWyCKn9gXZSodJ0QJAaUU=; b=U/kh/Ou3OtrX/gDcuCTa0TVUAj
        q/Bn8DYekaFfX+QF/LXcgW/R5Eq0/Ei0Om4xQT4kyPRzDvkJBQR+9Fkv6jCaHwar9LfU9KsWnVmSg
        H0ORBcooY1DbZEbAFWBMiUpmQZJcXO4b2rbX0Wf0clMizYQKpi6QcrlpbkU2k+8mI1gyZkvugmrOC
        OjeJ5xW2QJ3lk8aT7sONIxN/32KiRhELtgjrdUtrTx2zn+xiUADlZAUsJsv1QB+sQ2x5+FwHrcSh0
        O2325oH4m2JFslo4vhPNNYqUjPKb588vY/cNd6isGP1ISq/yFn+1WIDDmF06Of5rTi5EEKNEQCefp
        rQD4VunA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57218)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qKHBI-0000cr-2y;
        Fri, 14 Jul 2023 12:41:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qKHBI-0007CK-Io; Fri, 14 Jul 2023 12:41:52 +0100
Date:   Fri, 14 Jul 2023 12:41:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] net: phy: at803x: add qca8081 fifo reset on the
 link changed
Message-ID: <ZLE0gEwhYq5WLC2g@shell.armlinux.org.uk>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-7-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714063136.21368-7-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:31:36PM +0800, Luo Jie wrote:
> The qca8081 sgmii fifo needs to be reset on link down and
> released on the link up in case of any abnormal issue
> such as the packet blocked on the PHY.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
