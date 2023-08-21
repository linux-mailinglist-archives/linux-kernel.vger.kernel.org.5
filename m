Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C347782C33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjHUOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjHUOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:41:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42564E8;
        Mon, 21 Aug 2023 07:41:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso5044815e87.2;
        Mon, 21 Aug 2023 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692628889; x=1693233689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWftEsob0f+Dkg7z53GRt9EawaPiXs/Ay8iEALZ2SSY=;
        b=LuxiMsQ2ZM50eZ9hLkLKWGU6Rs9rW493JJMeX+027xtnYJKH/ho8eDSnXrZKz6YG+H
         unBWWk9UAnour7q2esZxEHRWxlAd7yClbBUTt06uJJXPWDwxzN87b7hX77bvRPa+Xeg2
         eslayYatvwo0GGNLgqDcIqwfWM3lOOWP38K/4kQ/JbcgLmS8or7mqznzoDysTgR/6d7X
         14W/0MjeFHsf6bDGjtonQt6gJiNx/0Pca5fBgftcggCwXL4Tp3nT3JNreSY+r21InyEp
         wwf0EzTk3LRpZ7J6X5Ybv2FY+IVZZ3LjQrdIvkGZoIG3I5dOAMUI1BFkpAlTGpE5aKKE
         gbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628889; x=1693233689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWftEsob0f+Dkg7z53GRt9EawaPiXs/Ay8iEALZ2SSY=;
        b=ibEtiiAmbUFNbtD7fm95wq4DnDyYHRrLtcHEimhpCtNvS+iTThafasf+eaVJpLYSMB
         6flJCqAwsROqp6o9U0imn+vrHM0xsfBoh9//04iLHvSYudPWSV45M6/EvS01q3cx9GS9
         gE6Q+9EJg0u8P9DfOOL+5s8A3Q87A8ZY9057bdDQ5/JXox+5uSpKVUZA4Nf0aRI9ZUv6
         5E+1qs4j8zOtDpWkg5LvSQWW4q1xibu08MIQ5j/ZcGbm7/n4vuvHW22ukib56Zgffoat
         sDmG/AFeclWe66Qgnb+hcIE/CtpoM6ux9ZiuttxdGJkeZeXodozJ8PLGQTq1uqNf5pYx
         qKzg==
X-Gm-Message-State: AOJu0Yw9VUyj9PXiDlj2oDhWHDs8clNYcxXa3qdjBu4bnn67Qx5UlVyO
        od/HVIGicYnwLM/xnG/416M=
X-Google-Smtp-Source: AGHT+IEBpDiIt5kpC7r24FUjjtLHS/Sy4LOdBmhZ0s7j/r9/PFHwv/auiv2ayzBlGq+fU8z8LF8AIw==
X-Received: by 2002:a05:6512:3d2a:b0:500:7e70:ddf5 with SMTP id d42-20020a0565123d2a00b005007e70ddf5mr3719789lfv.43.1692628889173;
        Mon, 21 Aug 2023 07:41:29 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m3-20020ac24283000000b004f4b42e2d7dsm1792814lfh.230.2023.08.21.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:41:28 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:41:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jisheng Zhang <jszhang@kernel.org>,
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
Message-ID: <y6hb5bm6k62q6pjaybmgiexze3swo5q7rmu2zybr2avr55byxa@373ht74dj56e>
References: <20230816152926.4093-1-jszhang@kernel.org>
 <20230816152926.4093-3-jszhang@kernel.org>
 <9e55fd03-6b05-46de-874e-01d9cdbf4524@lunn.ch>
 <ZOJuzakni1youMtX@shell.armlinux.org.uk>
 <dmfhl4ptoytmconczdkccli5qlkct33tgfqaoigygrzak52g63@qw7pwoa5m2x3>
 <ZONtX8EMXnmHQFnD@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZONtX8EMXnmHQFnD@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:57:51PM +0100, Russell King (Oracle) wrote:
> On Mon, Aug 21, 2023 at 04:25:42PM +0300, Serge Semin wrote:
> > Hi Russel, Andrew
> > 
> > On Sun, Aug 20, 2023 at 08:51:41PM +0100, Russell King (Oracle) wrote:
> > > On Sun, Aug 20, 2023 at 09:15:06PM +0200, Andrew Lunn wrote:
> > > > On Wed, Aug 16, 2023 at 11:29:19PM +0800, Jisheng Zhang wrote:
> > 
> > > > > The XGMAC_HWFEAT_GMIISEL bit also indicates whether support 10/100Mbps
> > > > > or not.
> > 
> > > > 
> > > > The commit message fails to explain the 'Why?' question. GMII does
> > > > normally imply 10/100/1000, so i would expect dma_cap->mbps_1000 also
> > > > implies 10/100/1000? So why also set dma_cap->mbps_10_100?
> > 
> > Regarding DW XGMAC. I can't say for sure. Based on DW XGMAC v2.10
> > IP-core HW manual it has MAC_HW_Feature0.GMIISEL(1) flag indicating
> > whether there is GMII interface besides of the XGMII interface. But in
> > my databook MAC_HW_Feature0.BIT(0) is marked as reserved and
> > MAC_Tx_Configuration.SS field doesn't have 10/100Mbps modes despite of
> > what is defined in dwxgmac2.h by means of the XGMAC_CONFIG_SS_10_MII
> > and XGMAC_CONFIG_SS_1000_GMII macros.
> > 
> > But DW GMAC or DW Eth QoS can be synthesized with the 1000-only
> > mode enabled. GMIISEL and MIISEL flags reflect the OP_MODE IP-core
> > synthesize parameter state. It can have three different values:
> > 
> > Mode of Operation	Description: Configures the MAC to work in
> > 			10/100/1000 Mbps mode. Select 10/100/1000
> > 			Mbps for enabling both Fast Ethernet and Gigabit
> > 			operations, 10/100 Mbps for Fast Ethernet-only
> > 			operations, and 1000 Mbps for Gigabit-only operations.
> > !!!			Value Range: 10/100/1000 Mbps, 10/100 Mbps, or 1000 Mbps
> > 			Default Value:
> > 				10/100/1000 Mbps with Gigabit License
> > 				10/100 with Fast Ethernet license
> > HDL Parameter Name: OP_MODE
> > 
> > > > 
> > > > Maybe a better change would be to modify:
> > > > 
> > > >         seq_printf(seq, "\t1000 Mbps: %s\n",
> > > >                    (priv->dma_cap.mbps_1000) ? "Y" : "N");
> > > > 
> > > > to actually say 10/100/1000 Mbps? It does not appear this is used for
> > > > anything other than debugfs?
> > > 
> > 
> > > Indeed, it also looks to me like mbps_1000 and mbps_10_100 are only
> > > used to print things in the debugfs file, and do not have any effect
> > > on the driver.
> > 
> > They should have been utilized somehow in the stmmac_mac_link_up() and
> 
> No, definitely not in mac_link_up(). If these flags indicate what speeds
> are available, then what would mac_link_up() do if, e.g. the core says
> "I don't support 1G" and phylink determines that the result of
> negotiation is 1G?
> 
> This is clearly not the right place. The right place is when
> initialising the phylink MAC capabilities, which is currently done in
> stmmac_phy_setup() without *any* regard what so ever for what speeds
> are actually supported, with the exception of "oh, is that the maximum
> speed".

Ok. My suggestion was based on the current stmmac_mac_link_up()
implementation which configures the MAC speed based on the speed
coming from the phylink core and silently returns if the speed is
unsupported.) 

> 
> > > It does bring up one last question though: if the driver makes no use
> > > of these hw_cap bits, then is there any point in printing them in the
> > > debugfs file?
> > 
> > This question can be applied to almost the half of the dma_feature
> > structure fields.) One more patch extends it with even more mainly
> > unused fields:
> > https://lore.kernel.org/netdev/20230819105440.226892-1-0x1207@gmail.com/
> 

> If the hw_cap field is specific, then how about some hardware specific
> data giving something like an enum listing the capabilties, the enum
> used to index a string table of capabilities, and an array of bit
> numbers in hw_cap for those fields, or an array of masks? This data
> could be const, which means that stmmac_dma_cap_show() only needs
> the hw_cap value and the struct.

That would have been a great solution.

> 
> That also means that stmmac_phy_setup() could also index the
> array of bit numbers to test for e.g. GMII/MII support to determine
> whether 10/100 and 1000 capabilities should be added for phylink.
> 
> If we look at the "half_duplex" dma capability, things are similarly
> stupid. Pulling out of dwmac4:
> 
>         dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
> 
> This is not tested elsewhere from what I can find - neither the
> hwcap nor the half_duplex field except for reporting in debugfs.
> It isn't used to restrict the phylink capabilities for HD, since
> the only test is this:
> 
>         /* Half-Duplex can only work with single queue */
>         if (priv->plat->tx_queues_to_use > 1)
>                 priv->phylink_config.mac_capabilities &=
>                         ~(MAC_10HD | MAC_100HD | MAC_1000HD);
> 
> So, the reporting of "half duplex" mode in debugfs has absolutely
> nothing to do with whether we try to use half duplex modes in the
> driver.
> 
> This is rubbish. Utter rubbish.

So is a lot of stuff in the STMMAC driver. Look closely at what is
implemented there. One bright example is the plat_stmmacenet_data
structure content. For instance, msi_mac_vec, msi_wol_vec,
msi_lpi_vec, msi_sfty_ce_vec, msi_sfty_ue_vec, msi_rx_base_vec,
msi_tx_base_vec aren't even utilized in the core driver, but in the
Intel glue driver only. Some other plat_stmmacenet_data fields are
utilized to either override the dma_features fields or being utilized
even though there is a auto-detectable HW-features field.

All of the HW-abstraction macros accept stmmac_priv pointer as a
parameter meanwhile the abstracting functions don't. So the respective
functions need to have all of parameters passed as arguments
which makes some function prototypes too bulky and would require the
prototype modification should some additional data is required in the
function implementation. Moreover the HW-abstraction function
prototypes aren't unified: some accept the regs base address, some
mac_device_info pointer, etc.

mac_device_info instance is always required but it's separately malloced all
the time the stmmac_drv_probe() is called. It should have been just
embedded into the stmmac_priv data.

and so on and so forth.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
