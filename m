Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA477FFC99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376304AbjK3Ues (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346798AbjK3Ueq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:34:46 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB2A1703;
        Thu, 30 Nov 2023 12:34:50 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FFB8240006;
        Thu, 30 Nov 2023 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701376488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzQ3On710hTv4xHUxSRSe52ROEYKFUSjwFd+FRw9ZWo=;
        b=ZDiYNDVjFXSdd+LTZVKANyqlnEkTWiTR8yc/VLuFsekCuu17tQQuKYpOMDajW5APgyyZgn
        K/c4zgpvDVG+cc2AUL7Bo/kTCLhhz+QBP1BknOrBANFqUrIU9nnWBdMTcyHg44TN4JAuCU
        1L+grucTiVpIrmCYvcsvxcBaFj0opmJp6PWECQ0NsgXWyKBlp2eMcWvfnj2uuYgatUS1wI
        bQIhD6vcX0DlHmnQNKoXgzm4ogPNiRCBhbtPqU5k2scwA3MTTyGvgf8E3jSLWwnf9uqbiM
        aHV/8bpcShrEg/vqzSLYKYmJ4+jHTjP5zGv3rKUmt7UINkA+DanGsptTm8CfSw==
Date:   Thu, 30 Nov 2023 21:34:41 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        davem@davemloft.net, avifishman70@gmail.com, venture@google.com,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        tali.perry1@gmail.com, mcoquelin.stm32@gmail.com,
        edumazet@google.com, joabreu@synopsys.com, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, peppe.cavallaro@st.com,
        j.neuschaefer@gmx.net, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjaminfair@google.com
Subject: Re: [Linux-stm32] [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <20231130213441.032a661c@device.home>
In-Reply-To: <xvy2coamb6cl3wcbkl32f6w7kksoxfocyd63t7k7bz4pne2gyx@lktivhqovy7p>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
        <20231121151733.2015384-3-tmaimon77@gmail.com>
        <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
        <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
        <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
        <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
        <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
        <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
        <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>
        <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
        <xvy2coamb6cl3wcbkl32f6w7kksoxfocyd63t7k7bz4pne2gyx@lktivhqovy7p>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 30 Nov 2023 22:59:32 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Thu, Nov 30, 2023 at 06:26:13PM +0100, Andrew Lunn wrote:
> > > I will check with the xpcs maintainer how can we add indirect access
> > > to the xpcs module.  
> > 
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c#L449
> > 
> > It creates a regmap for the memory range. On top of that it creates an
> > MDIO bus. You can then access the PCS in the normal way.  
> 
> Actually Synopsys DW XPCS can be synthesized with two types of the CSR
> interfaces:
> 1. MDIO: device looks as a normal MDIO device. This option is currently
>    supported by the STMMAC MDIO driver.
> 2. MCI/APB3: device MMD CSRs are directly (all CSRs are visible) or
>    indirectly (paged-base access) accessible over the system memory bus.
> 
> In addition to the above XPCS device can be equipped with separate
> clock sources (at least to feed the MCI or APB3 interface) and may
> have dedicated IRQ line to signal various events like link
> establishing, failures, etc. From that perspective XPCS in both cases
> looks as a normal platform device for which would be better to have a
> special DT-node defined with all those resources supplied. Then the
> XPCS DT-node could be passed to the DW MAC DT-node via the already
> standardized "pcs-handle" DT-property.

To my understanding, this should work, there's another PCS that works
this way : 
https://elixir.bootlin.com/linux/v6.7-rc3/source/drivers/net/pcs/pcs-rzn1-miic.c

Are you still able to use the mdio-regmap glue that Andrew mentioned,
to avoid the duplication between the mdio and mmio register accesses ?

Maxime
