Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2557FD344
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjK2JxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2JxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:01 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C16D6C;
        Wed, 29 Nov 2023 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QSUj5Hf27QAanj8NaPVwwZeZA3o2C5Q3Bi2HvrNaM/A=; b=on5VUU3tr5GEfHsjZFwUrgEY1l
        MDU8UIqQXuKAeIK+YVs7aaZFssQwkJ1FkdyCLY8JmKoftwt0BRgh934gGoX9IXCq6JpkLFV+b7bM8
        PVG7kB3MrJOH01NqxhGgwoEEhteJIM0egKh9PO1mfriK1uJo7KUH7qWvJ1vsvS9xRSLBRIWTrBJCm
        Ys9nS0PIh3g1SpOM3Ud5blZGmBwiwkL3h883a4QpF3bB2yURKxINOWNzxSQfW/WbVrL5aW5fJKeAU
        f5SQcivuyurfikG1g69lKQ9qowm1fPftvDZp0mUtGwVCwVGBgbdT0xPjUV6a+kbKB7UB25NSU/8WD
        3Bm5Z0eQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50220)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8HFa-00005y-30;
        Wed, 29 Nov 2023 09:52:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8HFc-0003t4-Ni; Wed, 29 Nov 2023 09:53:00 +0000
Date:   Wed, 29 Nov 2023 09:53:00 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 13/14] net: phy: qcom: deatch qca83xx PHY driver
 from at803x
Message-ID: <ZWcJ/OgC1+cbFvhk@shell.armlinux.org.uk>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-14-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-14-ansuelsmth@gmail.com>
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

On Wed, Nov 29, 2023 at 03:12:18AM +0100, Christian Marangi wrote:
> diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
> index 6a68da8aaa7b..43e4d14df8ea 100644
> --- a/drivers/net/phy/qcom/Makefile
> +++ b/drivers/net/phy/qcom/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_AT803X_PHY)	+= at803x.o
> +obj-$(CONFIG_AT803X_PHY)	+= at803x.o common.o
> +obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o common.o

These PHY drivers can be built as modules. You will end up with several
modules - at803x.ko, qca83xx.ko and common.ko. You don't mark any
functions in common.c as exported, no module license, no author, no
description. common.ko is way too generic a name as well.

Please think about this more and test building these drivers as a
module.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
