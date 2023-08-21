Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86097782A72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjHUNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHUNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:25:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD144A8;
        Mon, 21 Aug 2023 06:25:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ff09632194so4513683e87.2;
        Mon, 21 Aug 2023 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692624346; x=1693229146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBRY+GcFPhlqGwO6CgJ2oymAOz5seMAN2xGmhl4bwNQ=;
        b=ZbHqJ9vCzUSl+PYAHM9x54MlmK1QzC5l0kUOFeI5GiYReXTQhs6DJIw/zV7G9vntu7
         H9RrQfYHXDdhFvzBpHKfIjAUBVqzxkMoCriClkEpCh6i8ixe0FoSmi84fsrhDpjvyxC+
         6pRkCl1tacxtqyWpyaZB1FnRRt+Rr0zges+YsPFRnCNt9qjanLpvx6FnpCYg5WNnNACr
         0ZYgJ15fOvzz6AJjyCLPZBZzJffcWMDGVzuihPpiUhuR+ExcKMM5E39nDEMUk2/V22vK
         1VdYa30nw6gnAAbvTmanvScEXw9LIQoKqyzyDzQjKBBmDGaz3p3COrxmYf73OZdjVzme
         whiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624346; x=1693229146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBRY+GcFPhlqGwO6CgJ2oymAOz5seMAN2xGmhl4bwNQ=;
        b=J6lzuSiiee/MHUaaOeJnF5uu/Ne0rGUilZW3TB6xQiU5ROlqmNRzSqXx103O3zm6pg
         6xaBDfG3MI5dUBRPw+Sncr5emmkgcSueS/B99booQ1p0UAa+m9BfL2SkEDbBG8Vdaggq
         E/LlPA+x+xjHuvXqQJcW8lKKyo6qr70OiKDGpIp5OIxSPZQ/54wEPBgRXXAi1X965cTB
         8Ix4L+SLj4/K2X70H3KhhvhnQ2lLL3USci+OYeeF5j8T7p0tNxdm9CazGiqprQC1G5RF
         /g62+1JQM03ZxFBPrr3RzOONJHe0Jn+IcQhNxCdAIa11BYrx+RJE3TAiGXS1/HvcG7mq
         gr/Q==
X-Gm-Message-State: AOJu0Yym1iAfzLByka0IaXUyowGjDCiTzvz68b+KHnA5BS3bVpaw5aDr
        xa+FopCVny72HP28FHNqqRk=
X-Google-Smtp-Source: AGHT+IGOCvr+NEWAEaUuNqO1TOUaJ/9vWejULa88v0M7ivbYQD2P6Yltb0IrzK2DMKo8ORRHePvbLQ==
X-Received: by 2002:a05:6512:2524:b0:4f8:766f:8dc3 with SMTP id be36-20020a056512252400b004f8766f8dc3mr4777276lfb.32.1692624345767;
        Mon, 21 Aug 2023 06:25:45 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w5-20020ac254a5000000b004fe142afd1esm1775798lfk.152.2023.08.21.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:25:45 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:25:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <dmfhl4ptoytmconczdkccli5qlkct33tgfqaoigygrzak52g63@qw7pwoa5m2x3>
References: <20230816152926.4093-1-jszhang@kernel.org>
 <20230816152926.4093-3-jszhang@kernel.org>
 <9e55fd03-6b05-46de-874e-01d9cdbf4524@lunn.ch>
 <ZOJuzakni1youMtX@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOJuzakni1youMtX@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel, Andrew

On Sun, Aug 20, 2023 at 08:51:41PM +0100, Russell King (Oracle) wrote:
> On Sun, Aug 20, 2023 at 09:15:06PM +0200, Andrew Lunn wrote:
> > On Wed, Aug 16, 2023 at 11:29:19PM +0800, Jisheng Zhang wrote:

> > > The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
> > > or not.

> > 
> > The commit message fails to explain the 'Why?' question. GMII does
> > normally imply 10/100/1000, so i would expect dma_cap->mbps_1000 also
> > implies 10/100/1000? So why also set dma_cap->mbps_10_100?

Regarding DW XGMAC. I can't say for sure. Based on DW XGMAC v2.10
IP-core HW manual it has MAC_HW_Feature0.GMIISEL(1) flag indicating
whether there is GMII interface besides of the XGMII interface. But in
my databook MAC_HW_Feature0.BIT(0) is marked as reserved and
MAC_Tx_Configuration.SS field doesn't have 10/100Mbps modes despite of
what is defined in dwxgmac2.h by means of the XGMAC_CONFIG_SS_10_MII
and XGMAC_CONFIG_SS_1000_GMII macros.

But DW GMAC or DW Eth QoS can be synthesized with the 1000-only
mode enabled. GMIISEL and MIISEL flags reflect the OP_MODE IP-core
synthesize parameter state. It can have three different values:

Mode of Operation	Description: Configures the MAC to work in
			10/100/1000 Mbps mode. Select 10/100/1000
			Mbps for enabling both Fast Ethernet and Gigabit
			operations, 10/100 Mbps for Fast Ethernet-only
			operations, and 1000 Mbps for Gigabit-only operations.
!!!			Value Range: 10/100/1000 Mbps, 10/100 Mbps, or 1000 Mbps
			Default Value:
				10/100/1000 Mbps with Gigabit License
				10/100 with Fast Ethernet license
HDL Parameter Name: OP_MODE

> > 
> > Maybe a better change would be to modify:
> > 
> >         seq_printf(seq, "\t1000 Mbps: %s\n",
> >                    (priv->dma_cap.mbps_1000) ? "Y" : "N");
> > 
> > to actually say 10/100/1000 Mbps? It does not appear this is used for
> > anything other than debugfs?
> 

> Indeed, it also looks to me like mbps_1000 and mbps_10_100 are only
> used to print things in the debugfs file, and do not have any effect
> on the driver.

They should have been utilized somehow in the stmmac_mac_link_up() and
in the dwmac1000_setup(), dwmac4_setup(), etc methods in order to
select the proper speed. But yeah, currently they are used to print the
DebugFS node data only.

> 
> Moreover:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_FEAT_GMIISEL      BIT(1)
> drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_GMIISEL       0x00000002       /* 1000 Mbps Support */
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h:#define XGMAC_HWFEAT_GMIISEL    BIT(1)
> 
> Seems to be all the same bit, and:
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac4.h:#define GMAC_HW_FEAT_MIISEL       BIT(0)
> drivers/net/ethernet/stmicro/stmmac/common.h:#define DMA_HW_FEAT_MIISEL 0x00000001      /* 10/100 Mbps Support */
> 
> So, if everyone defines the first few bits of the hw_cap identically,
> is there any point to decoding this separately in each driver? Couldn't
> the debugfs "show" function just parse the hw_cap directly? 

The rest of the data in the HW-feature registers is almost completely
different. DW GMAC (common.h) has a single HW-Feature register which
has very little in common with the DW XGMAC (dwxgmac2.h) and DW Eth
QoS (dwmac4.h) MAC_HW_Feature0 register. The later two IP-cores have
the HW-feature registers looking very similar but still differing in
some flags. So in order not to have a partly measured change I would
suggest to preserve the separate HW-features macros space for each
type of the devices for now. If somebody cares to have them indicating
common and separate flags one could provide a comprehensive patch
fixing the entire HW-feature macros definitions. Although I don't see
this being that much necessary.

> Wouldn't it
> make more sense to print MII / GMII rather than 10/100 and 1000 ?
> 

Based on the GMIISEL and MIISEL flags description they are
speed-related, not the interface type:
GMIISEL		1000 Mbps Support
MIISEL		10 or 100 Mbps support

> It does bring up one last question though: if the driver makes no use
> of these hw_cap bits, then is there any point in printing them in the
> debugfs file?

This question can be applied to almost the half of the dma_feature
structure fields.) One more patch extends it with even more mainly
unused fields:
https://lore.kernel.org/netdev/20230819105440.226892-1-0x1207@gmail.com/

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
