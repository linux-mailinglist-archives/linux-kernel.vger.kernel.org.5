Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C964781FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjHTTwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjHTTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:52:43 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895210DD;
        Sun, 20 Aug 2023 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n6Nriy9y1QGK+aN6W7CXzj6VGKuJeaOqJSwIfNghFso=; b=ekRsQSuj716j10CXNiOb2CSmYq
        DRxAAxejcpIDPyiIUB5CsBHPqb/6wBnL1tarMzs95y8x0eCFqm4UKYlmvbTORt7HAEhKUdLz937bc
        w0SdeGRVuIpRldKcTQm5ml9s2EZtuHphBupIttx2tjbXyXRUv9ONZds/IUGSdMo8IlR/D/FiZH8XH
        WsLiGbh5a/nTlsE4AbaLXHqFfpJwc12ZkkztSnjKyuuTX62BLvKNz0oDpG1q36ayB9ZKEwgsya3x+
        Xvx5o2YdzxJUZb1dbYmFyvDBZOjewxtVebysjmZLM78rEq1CSgSI+rMavH9lv9l7g60agO0anFlUc
        M7TMv9uQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33380)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qXoSe-0007mx-1P;
        Sun, 20 Aug 2023 20:51:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qXoSb-00041h-Fa; Sun, 20 Aug 2023 20:51:41 +0100
Date:   Sun, 20 Aug 2023 20:51:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 2/9] net: stmmac: xgmac: add more feature
 parsing from hw cap
Message-ID: <ZOJuzakni1youMtX@shell.armlinux.org.uk>
References: <20230816152926.4093-1-jszhang@kernel.org>
 <20230816152926.4093-3-jszhang@kernel.org>
 <9e55fd03-6b05-46de-874e-01d9cdbf4524@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e55fd03-6b05-46de-874e-01d9cdbf4524@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 09:15:06PM +0200, Andrew Lunn wrote:
> On Wed, Aug 16, 2023 at 11:29:19PM +0800, Jisheng Zhang wrote:
> > The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
> > or not.
> 
> The commit message fails to explain the 'Why?' question. GMII does
> normally imply 10/100/1000, so i would expect dma_cap->mbps_1000 also
> implies 10/100/1000? So why also set dma_cap->mbps_10_100?
> 
> Maybe a better change would be to modify:
> 
>         seq_printf(seq, "\t1000 Mbps: %s\n",
>                    (priv->dma_cap.mbps_1000) ? "Y" : "N");
> 
> to actually say 10/100/1000 Mbps? It does not appear this is used for
> anything other than debugfs?

Indeed, it also looks to me like mbps_1000 and mbps_10_100 are only
used to print things in the debugfs file, and do not have any effect
on the driver.

Moreover:

drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_FEAT_GMIISEL      BIT(1)
drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_GMIISEL       0x00000002       /* 1000 Mbps Support */
drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define XGMAC_HWFEAT_GMIISEL    BIT(1)

Seems to be all the same bit, and:

drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_FEAT_MIISEL       BIT(0)
drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_MIISEL 0x00000001      /* 10/100 Mbps Support */

So, if everyone defines the first few bits of the hw_cap identically,
is there any point to decoding this separately in each driver? Couldn't
the debugfs "show" function just parse the hw_cap directly? Wouldn't it
make more sense to print MII / GMII rather than 10/100 and 1000 ?

It does bring up one last question though: if the driver makes no use
of these hw_cap bits, then is there any point in printing them in the
debugfs file?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
