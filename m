Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B627E8C05
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKKSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:17:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE42D77;
        Sat, 11 Nov 2023 10:17:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d216597f64so497340366b.3;
        Sat, 11 Nov 2023 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699726622; x=1700331422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iLuEzbxCacp3MJuD2sq/malMmeZbiXSi7sKc98mPqeE=;
        b=b3jGZdYBro3u4CRtpRNRZFhXsrF0+7EtM1vzeEKdKTFiblbF4c/lhZZ1AZxB0LIKEk
         hZZ6kp+eh/WSu+RuYIMstEcEfqjPMrI5tmkPq8lHhV6kJWei6Xu3NERqrus/tvgVYw4G
         mVDnJEccF2ECLA5+NgcvJdoxDYeEM8z211GCv7YHDfZzNZMxCDenSZXebp+Re6fgV+ni
         8hJjMQuIfiTuimvFgbUCjEzTu4Fo2S2s5SEa/PJ4KzN+oqKTsJcuS5K2F4pliMYv1/ob
         T5LrmiAbCcgv/zTHNqpCmMESqmuUL++QqPq7XV1L2QyXR+KDilVWkZfFYIJxGfOsy1s1
         v9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699726622; x=1700331422;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLuEzbxCacp3MJuD2sq/malMmeZbiXSi7sKc98mPqeE=;
        b=EBAbPDR7EOO7xIgiq/sE8J8nx2I4GG7mZ/hio44wTu4/9WyPI9bcz/YCfADvOfgulw
         M3rxMSnjevCfnvqjat2iCTpwZulCusTbdMb7SHeKQM7IAv6mmdQQvfXXcUMLAtfTsGrk
         kCsjXI1QKyDxnyPjLNs+EP2jjHsk2kp5y9eAzOWEy+t3P6bWdV+QFPsSpCeUvXnkBtdd
         0U86HADVoRMIq6LeFK9k0cpr/aFTV6cdrzeivyWs7T0al9I0ArnURjThNPcy/+J2lWJK
         K1yosPXSHYISPk5ijORuJxzKjlfqgnmpnun1CH9UqCTQ1XY5ax63j5t3joHxn/c0uxT7
         A/oA==
X-Gm-Message-State: AOJu0YxKOdA+lEIK9rE4ZDSmrveMJk1+JoufJhcCYrwQrfOiZPB+KTXz
        0V3PNiGdD8YSR7ve14Z/3Q0=
X-Google-Smtp-Source: AGHT+IEDbzhIvDoTtTIO7699ndejAsJBgxyjAfB3uYsWxfNIE697mLnVZS+alZkpukir2ua//9SI7Q==
X-Received: by 2002:a17:907:bb8a:b0:9e4:197e:a5dc with SMTP id xo10-20020a170907bb8a00b009e4197ea5dcmr1881564ejc.44.1699726622139;
        Sat, 11 Nov 2023 10:17:02 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id y19-20020a170906525300b009a13fdc139fsm1383683ejm.183.2023.11.11.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 10:17:01 -0800 (PST)
Message-ID: <654fc51d.170a0220.c0817.43cd@mx.google.com>
X-Google-Original-Message-ID: <ZU/FF8vEGwlFRbm0@Ansuel-xps.>
Date:   Sat, 11 Nov 2023 19:16:55 +0100
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75a8874-5ffe-4d8d-bcb9-27d8dff1cd09@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 04:46:42PM +0100, Andrew Lunn wrote:
> On Fri, Nov 10, 2023 at 11:28:36PM +0100, Christian Marangi wrote:
> > On Fri, Nov 10, 2023 at 07:57:02PM +0000, Simon Horman wrote:
> > > On Thu, Nov 09, 2023 at 01:32:52PM +0100, Christian Marangi wrote:
> > > > From: Robert Marko <robimarko@gmail.com>
> > > > 
> > > > Aquantia PHY-s require firmware to be loaded before they start operating.
> > > > It can be automatically loaded in case when there is a SPI-NOR connected
> > > > to Aquantia PHY-s or can be loaded from the host via MDIO.
> > > > 
> > > > This patch adds support for loading the firmware via MDIO as in most cases
> > > > there is no SPI-NOR being used to save on cost.
> > > > Firmware loading code itself is ported from mainline U-boot with cleanups.
> > > > 
> > > > The firmware has mixed values both in big and little endian.
> > > > PHY core itself is big-endian but it expects values to be in little-endian.
> > > > The firmware is little-endian but CRC-16 value for it is stored at the end
> > > > of firmware in big-endian.
> > > > 
> > > > It seems the PHY does the conversion internally from firmware that is
> > > > little-endian to the PHY that is big-endian on using the mailbox
> > > > but mailbox returns a big-endian CRC-16 to verify the written data
> > > > integrity.
> > > > 
> > > > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > 
> > > Hi Christian and Robert,
> > > 
> > > thanks for your patch-set.
> > > 
> > > I spotted some minor endien issues which I have highlighted below.
> > > 
> > > ...
> > >
> > 
> > Hi Simon,
> > 
> > thanks for the check!
> > 
> > > > +/* load data into the phy's memory */
> > > > +static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> > > > +			      const u8 *data, size_t len)
> > > > +{
> > > > +	u16 crc = 0, up_crc;
> > > > +	size_t pos;
> > > > +
> > > > +	/* PHY expect addr in LE */
> > > > +	addr = cpu_to_le32(addr);
> > > 
> > > The type of addr is host byte-order,
> > > but here it is assigned a little-endian value.
> > > 
> > > Flagged by Sparse.
> > > 
> > > > +
> > > > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > > > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > > > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
> > > 
> > > VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR() performs a bit-shift on addr,
> > > and applies a mask which is in host-byte order.
> > > But, as highlighted above, addr is a little-endian value.
> > > This does not seem right.
> > >
> > 
> > It's really just some magic to split the addr and swap if we are not
> > in little-endian. The passed addr are defined here in the code and are
> > hardcoded, they doesn't come from the firmware. What I can do is just
> > recast __le32 to u32 again with __force to mute the warning...
> > 
> > Resulting in this snippet:
> > 
> > 	__le32 addr;
> > 	size_t pos;
> > 
> > 	/* PHY expect addr in LE */
> > 	addr = cpu_to_le32(load_addr);
> > 
> > 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > 		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > 		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > 		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > 		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR((__force u32)addr));
> > 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > 		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> > 		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR((__force u32)addr));
> > 
> > Also things needs to be casted to u16 anyway as phy_write_mmd expect a
> > u16. And as you said FILED_PREP will use int (from the define) so I
> > wonder if a more clean way would be just addr = (__force u32)cpu_to_le32(load_addr)
> > resulting in a simple bswap32 if we are in big-endian.
> > 
> > Would love some feedback about this.
> 
> I don't think sparse is giving much value here. As you say,
> phy_write_mmd() expects a u16, host endian. The endianness of the bus
> is well defined in 802.3, and we expect the MDIO bus driver to take
> care of converting host endian to whatever is needed by the
> hardware. And typically, that is nothing since it is all integrated.
> 
> There does not appear to be a cpu_to_le32() without sparse markup. So
> i think you are forced to use the ugly __force. I would do that as
> soon as possible, as part of the cpu_to_le32() line.
> 
> > > This is all hidden by a cast in VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR()
> > > This seems dangerous to me.
> 
> That cast could be made more visible. The macro itself looks safe on
> different endians. It uses > and & operations. So try taking the cast
> out of the macro and make it part of the phy_write_mmd() call? I
> assume the cast is needed because you get a compiler warning, passing
> a u32 when a u16 is expected?
>

The cast is a handy way to cut the other 16bit. We make them 0 anyway by
the FIELD_PREP. So yes I think I can just drop the cast there and put it
in the write_mmd. (it's the same thing just making it more clear)

I'm not including your tag in the next revision as I will make these
changes.

-- 
	Ansuel
