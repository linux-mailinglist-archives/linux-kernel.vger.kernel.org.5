Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96878A0C9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjH0R6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjH0R6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:58:18 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8ECC4;
        Sun, 27 Aug 2023 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3bcqGb8c9MJdTQ6tWNLuuoF9D7rQzI8cfAXINlj2RDI=; b=XXdQMLUmFZOx4/OSGyjOKjkXQO
        6NMQdjFHsIPxoVX1hyRgrdHuXR63gKElQ/cNdJIl2uZ3gy5+NGINuxF7oWPDqxBA9ThHOW+f3osK7
        p+fDlQ90EEK5mC2Z0A9LTYzcEvDFtEWGrAEELsbthQkpWFt5pbHF6I79rRBECnHF5zE6WfQFZxTxe
        SNGGsfVnpxQ8IzqYH+8qz4BvRZq4a1jv/K2SiW2oxuazQccAMje6MBWTRnsnR2pwmUP9y5sj1s0qT
        eUwkURqWTczX0h8KVf+nROL0UQy/zYNAMEcVjXJOPYf2Q07tNq47i/ekqDZG8/uE+Ci8IsnFrinC1
        vlLHV+KQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51984)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qaK0f-00076U-35;
        Sun, 27 Aug 2023 18:57:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qaK0c-0002it-AX; Sun, 27 Aug 2023 18:57:10 +0100
Date:   Sun, 27 Aug 2023 18:57:10 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Samin Guo <samin.guo@starfivetech.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-starfive: remove
 unnecessary clk_get_rate()
Message-ID: <ZOuOdt2/y5mKuuv0@shell.armlinux.org.uk>
References: <20230827134150.2918-1-jszhang@kernel.org>
 <20230827134150.2918-3-jszhang@kernel.org>
 <CANBLGcwFW_Y4PC1hxJ7OQN-h025e5wwoCNwnk8OXh3ALFQPcXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBLGcwFW_Y4PC1hxJ7OQN-h025e5wwoCNwnk8OXh3ALFQPcXg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 07:33:10PM +0200, Emil Renner Berthing wrote:
> On Sun, 27 Aug 2023 at 15:53, Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > In starfive_dwmac_fix_mac_speed(), the rate gotten by clk_get_rate()
> > is not necessary, remove the clk_get_rate() calling.
> 
> Thanks. I suggested this change during the initial review, but someone
> wanted the code as it is. I must admit I don't understand why, so
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

The code in starfive_dwmac_fix_mac_speed() is a repeated pattern amongst
many drivers, and having each platform driver re-implement this is not
sane. Those who know me will know that I have a patch that cleans this
all up - moving basically the guts of this to a library function which
platform drivers can make use of.

It's not like the clock rates are somehow special - they're standard for
10M/100M/1G speeds on a GMII-family interface, and the 10M/100M also
share the clock rates with MII.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
