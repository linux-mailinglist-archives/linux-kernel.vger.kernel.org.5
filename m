Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92657E8C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKKSoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:44:31 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90FEA;
        Sat, 11 Nov 2023 10:44:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9be02fcf268so480426866b.3;
        Sat, 11 Nov 2023 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699728266; x=1700333066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QUB9E/oFVAJtK5Z0i25yQQtafDMmXjP2n3aLJr6Ggyg=;
        b=g6ryl95WcNfLmahpR5DK2Q0K+1EhoQt60a5HuWb/Zu4EdG2qtL37UOEL2teV29gwaZ
         FCz7yO/UJYuRZVcFwGsdVOmCUqh68XH4t90px+DaxcMMnS/KRZIOOmYaSnvbKyuPShS+
         axAEwCOUnIB3+N4JA1GJ2fmji7UE2ZHS5blQd3mg9m4GPkijZBprAxcCKGIeV/04NBCg
         791hexHHxzEbj+nUy9d2DpL9KJyaT/7+DQU6HL5/6dmD9ffmhFChCeMFRrJYFNXiAjnF
         5lLGeGBPsxF+wJBhXn0CDyY7W6Zh/vNVqTb87Zo8NEiOr8abjED6YgXoU0NF37f7+aZQ
         1Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699728266; x=1700333066;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUB9E/oFVAJtK5Z0i25yQQtafDMmXjP2n3aLJr6Ggyg=;
        b=Es5m980ng0mplxktYVRngLRr/i21RxAeEWJPJsko//XfC/KKW1rA8byBFcZGZoa1HS
         oyzeig3HBBgBf/wuNgMzjkVcIVu6u96MlG7ilNI/+92BxUNMxeCVKHYiNc4HTEnXjSqr
         ncIdmk+UTvBijuUMylj7M9Gj8eJ21+XCmNb19YaAuFdwrr03UM4yOWfJB+Oh5LgjxOhK
         RXKzF4LZTUddsOD+/Uf+Fjr4UrKRUXtiKDKPKgTzynOhVIHkxVqyaqBnMAMevFO3OZcg
         482ybsmhLlc1F3Uha8MVM4w7r6wYY11/GqV2q00WLF9KRNM0rUshywrkEsP3A48HWoFT
         Zo8Q==
X-Gm-Message-State: AOJu0YzdYQALudIlxBbCRq6wssER84nXYaaTExsED3oeLu5L0mz01qEk
        Df2G/ERlDRTOH+5A3agvYnc=
X-Google-Smtp-Source: AGHT+IFmICwxTROHRwZQlSpXamvHseAg3ECBvf91c1UQLWWGHHxbgbjUkJzs/dacMktvpg0clbRgiA==
X-Received: by 2002:a17:906:711b:b0:9e5:dac6:86f9 with SMTP id x27-20020a170906711b00b009e5dac686f9mr1711763ejj.69.1699728265555;
        Sat, 11 Nov 2023 10:44:25 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ck20-20020a170906c45400b0099ce188be7fsm1417841ejb.3.2023.11.11.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 10:44:25 -0800 (PST)
Message-ID: <654fcb89.170a0220.b3175.3f69@mx.google.com>
X-Google-Original-Message-ID: <ZU/Lg4crevBXhpIR@Ansuel-xps.>
Date:   Sat, 11 Nov 2023 19:44:19 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v6 3/4] net: phy: aquantia: add firmware
 load support
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
 <20231109123253.3933-3-ansuelsmth@gmail.com>
 <20231110195628.GA673918@kernel.org>
 <654eae99.df0a0220.14db7.0cb8@mx.google.com>
 <e75a8874-5ffe-4d8d-bcb9-27d8dff1cd09@lunn.ch>
 <654fc51d.170a0220.c0817.43cd@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654fc51d.170a0220.c0817.43cd@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 07:16:55PM +0100, Christian Marangi wrote:
> On Sat, Nov 11, 2023 at 04:46:42PM +0100, Andrew Lunn wrote:
> > On Fri, Nov 10, 2023 at 11:28:36PM +0100, Christian Marangi wrote:
> > > On Fri, Nov 10, 2023 at 07:57:02PM +0000, Simon Horman wrote:
> > > > On Thu, Nov 09, 2023 at 01:32:52PM +0100, Christian Marangi wrote:
> > > > > From: Robert Marko <robimarko@gmail.com>
> > > > > 
> > > > > Aquantia PHY-s require firmware to be loaded before they start operating.
> > > > > It can be automatically loaded in case when there is a SPI-NOR connected
> > > > > to Aquantia PHY-s or can be loaded from the host via MDIO.
> > > > > 
> > > > > This patch adds support for loading the firmware via MDIO as in most cases
> > > > > there is no SPI-NOR being used to save on cost.
> > > > > Firmware loading code itself is ported from mainline U-boot with cleanups.
> > > > > 
> > > > > The firmware has mixed values both in big and little endian.
> > > > > PHY core itself is big-endian but it expects values to be in little-endian.
> > > > > The firmware is little-endian but CRC-16 value for it is stored at the end
> > > > > of firmware in big-endian.
> > > > > 
> > > > > It seems the PHY does the conversion internally from firmware that is
> > > > > little-endian to the PHY that is big-endian on using the mailbox
> > > > > but mailbox returns a big-endian CRC-16 to verify the written data
> > > > > integrity.
> > > > > 
> > > > > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > 
> > > > Hi Christian and Robert,
> > > > 
> > > > thanks for your patch-set.
> > > > 
> > > > I spotted some minor endien issues which I have highlighted below.
> > > > 
> > > > ...
> > > >
> > > 
> > > Hi Simon,
> > > 
> > > thanks for the check!
> > > 
> > > > > +/* load data into the phy's memory */
> > > > > +static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> > > > > +			      const u8 *data, size_t len)
> > > > > +{
> > > > > +	u16 crc = 0, up_crc;
> > > > > +	size_t pos;
> > > > > +
> > > > > +	/* PHY expect addr in LE */
> > > > > +	addr = cpu_to_le32(addr);
> > > > 
> > > > The type of addr is host byte-order,
> > > > but here it is assigned a little-endian value.
> > > > 
> > > > Flagged by Sparse.
> > > > 
> > > > > +
> > > > > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > > > > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
> > > > 
> > > > VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR() performs a bit-shift on addr,
> > > > and applies a mask which is in host-byte order.
> > > > But, as highlighted above, addr is a little-endian value.
> > > > This does not seem right.
> > > >
> > > 
> > > It's really just some magic to split the addr and swap if we are not
> > > in little-endian. The passed addr are defined here in the code and are
> > > hardcoded, they doesn't come from the firmware. What I can do is just
> > > recast __le32 to u32 again with __force to mute the warning...
> > > 
> > > Resulting in this snippet:
> > > 
> > > 	__le32 addr;
> > > 	size_t pos;
> > > 
> > > 	/* PHY expect addr in LE */
> > > 	addr = cpu_to_le32(load_addr);
> > > 
> > > 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > 		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > > 		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > > 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > 		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > > 		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR((__force u32)addr));
> > > 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > 		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> > > 		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR((__force u32)addr));
> > > 
> > > Also things needs to be casted to u16 anyway as phy_write_mmd expect a
> > > u16. And as you said FILED_PREP will use int (from the define) so I
> > > wonder if a more clean way would be just addr = (__force u32)cpu_to_le32(load_addr)
> > > resulting in a simple bswap32 if we are in big-endian.
> > > 
> > > Would love some feedback about this.
> > 
> > I don't think sparse is giving much value here. As you say,
> > phy_write_mmd() expects a u16, host endian. The endianness of the bus
> > is well defined in 802.3, and we expect the MDIO bus driver to take
> > care of converting host endian to whatever is needed by the
> > hardware. And typically, that is nothing since it is all integrated.
> > 
> > There does not appear to be a cpu_to_le32() without sparse markup. So
> > i think you are forced to use the ugly __force. I would do that as
> > soon as possible, as part of the cpu_to_le32() line.
> > 
> > > > This is all hidden by a cast in VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR()
> > > > This seems dangerous to me.
> > 
> > That cast could be made more visible. The macro itself looks safe on
> > different endians. It uses > and & operations. So try taking the cast
> > out of the macro and make it part of the phy_write_mmd() call? I
> > assume the cast is needed because you get a compiler warning, passing
> > a u32 when a u16 is expected?
> >
> 
> The cast is a handy way to cut the other 16bit. We make them 0 anyway by
> the FIELD_PREP. So yes I think I can just drop the cast there and put it
> in the write_mmd. (it's the same thing just making it more clear)
> 
> I'm not including your tag in the next revision as I will make these
> changes.
>

Actually the cast in the define are needed for FIELD_PREP or build time
compilation error is triggered for addr being too big for the mask.

So the golden question is... Is it really a problem having the (u16)
cast in the header? 

-- 
	Ansuel
