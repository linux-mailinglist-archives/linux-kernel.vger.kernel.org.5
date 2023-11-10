Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36B17E85B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbjKJW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKJW2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:28:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9B448C;
        Fri, 10 Nov 2023 14:28:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-408382da7f0so19090895e9.0;
        Fri, 10 Nov 2023 14:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699655322; x=1700260122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2uyp+vihWlmfUtHKNnOOdv5LG22ZhSVMoL0CChw4utk=;
        b=a3v39h3WuwypABMfDPUZ0EX2YS7GEBfj6f3NA7tEBjX9NisTgx+IN9hfj7U43Owkzp
         21rTfP3hi8Y/guesmDl2cr8rTHqy/ZIYN5iMACbkOaXQruaxiG+RkOLd2QQlrgyfdno5
         3CYqpwWHYSYG4jbAIAlneLrQUhteYt6V15BfypocU91yXuAgTnhc7kQgLXtzb/JmZeWG
         AbrKrk+xHVHs/QJCeg2rcnFxqg/1SLlvthMl3By/Tq9IroAIIygD28c7M2jgeEvW+gkL
         6k+NaxC0ClwBKGaolkxZGaEQzfTZFz09qqlkzlugKsbtgoDPYsTvoJm8mU+aTlcli2su
         mjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699655322; x=1700260122;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uyp+vihWlmfUtHKNnOOdv5LG22ZhSVMoL0CChw4utk=;
        b=ot1hRdSlCqHn+jN6r9M1kJ7k3Q+76M4UPxyfTqHYTQITQyNkNkDPIIN3Mk5fU1cZ8z
         s6iWR9BHyrFd7N5VPkk73WiMo5Q3URMRsDSRx7Y7+UntNxTXKBlNLGXnrr1d+nN3w1X8
         suLu4eLqjxZuHhLiJvkHAhgG8FzuCylwB3NSi6mFronJgWoFH7wvNAVW5rKUC6gu6wKI
         TK3OKGVutEymoBkbCqEZ3/nik2tXPMPL1QH2tGUysW8h6YJD5zGHFXMYIuwoAnuq+pLt
         ii0wgowmMKN9/N0mLSlFTW0wijxRUtV5JLWqc3BATx2E6DyZjH5vE7EY/WewQbHjTVNj
         HTKg==
X-Gm-Message-State: AOJu0YzcyMavqeMBWNwyQDw2iVOtJCMbEJXLD3n52/Cv3myzxE7d2XqN
        /py9eANfcNLcRIrxtEWhPLA=
X-Google-Smtp-Source: AGHT+IESeKZlcAdWVmxVgB7ypnyiMUuBeI9QhVdrft2TA83P3XjjACShezcgLgzxE3KTIRr6LlrQiQ==
X-Received: by 2002:adf:fb42:0:b0:31f:ea18:6f6b with SMTP id c2-20020adffb42000000b0031fea186f6bmr347617wrs.19.1699655322038;
        Fri, 10 Nov 2023 14:28:42 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0032f7f4089b7sm251841wrr.43.2023.11.10.14.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 14:28:41 -0800 (PST)
Message-ID: <654eae99.df0a0220.14db7.0cb8@mx.google.com>
X-Google-Original-Message-ID: <ZU6ulIA5cpQbK4fo@Ansuel-xps.>
Date:   Fri, 10 Nov 2023 23:28:36 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Simon Horman <horms@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110195628.GA673918@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 07:57:02PM +0000, Simon Horman wrote:
> On Thu, Nov 09, 2023 at 01:32:52PM +0100, Christian Marangi wrote:
> > From: Robert Marko <robimarko@gmail.com>
> > 
> > Aquantia PHY-s require firmware to be loaded before they start operating.
> > It can be automatically loaded in case when there is a SPI-NOR connected
> > to Aquantia PHY-s or can be loaded from the host via MDIO.
> > 
> > This patch adds support for loading the firmware via MDIO as in most cases
> > there is no SPI-NOR being used to save on cost.
> > Firmware loading code itself is ported from mainline U-boot with cleanups.
> > 
> > The firmware has mixed values both in big and little endian.
> > PHY core itself is big-endian but it expects values to be in little-endian.
> > The firmware is little-endian but CRC-16 value for it is stored at the end
> > of firmware in big-endian.
> > 
> > It seems the PHY does the conversion internally from firmware that is
> > little-endian to the PHY that is big-endian on using the mailbox
> > but mailbox returns a big-endian CRC-16 to verify the written data
> > integrity.
> > 
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Hi Christian and Robert,
> 
> thanks for your patch-set.
> 
> I spotted some minor endien issues which I have highlighted below.
> 
> ...
>

Hi Simon,

thanks for the check!

> > +/* load data into the phy's memory */
> > +static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> > +			      const u8 *data, size_t len)
> > +{
> > +	u16 crc = 0, up_crc;
> > +	size_t pos;
> > +
> > +	/* PHY expect addr in LE */
> > +	addr = cpu_to_le32(addr);
> 
> The type of addr is host byte-order,
> but here it is assigned a little-endian value.
> 
> Flagged by Sparse.
> 
> > +
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
> 
> VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR() performs a bit-shift on addr,
> and applies a mask which is in host-byte order.
> But, as highlighted above, addr is a little-endian value.
> This does not seem right.
>

It's really just some magic to split the addr and swap if we are not
in little-endian. The passed addr are defined here in the code and are
hardcoded, they doesn't come from the firmware. What I can do is just
recast __le32 to u32 again with __force to mute the warning...

Resulting in this snippet:

	__le32 addr;
	size_t pos;

	/* PHY expect addr in LE */
	addr = cpu_to_le32(load_addr);

	phy_write_mmd(phydev, MDIO_MMD_VEND1,
		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
	phy_write_mmd(phydev, MDIO_MMD_VEND1,
		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR((__force u32)addr));
	phy_write_mmd(phydev, MDIO_MMD_VEND1,
		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR((__force u32)addr));

Also things needs to be casted to u16 anyway as phy_write_mmd expect a
u16. And as you said FILED_PREP will use int (from the define) so I
wonder if a more clean way would be just addr = (__force u32)cpu_to_le32(load_addr)
resulting in a simple bswap32 if we are in big-endian.

Would love some feedback about this.

> This is all hidden by a cast in VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR()
> This seems dangerous to me.
> 
> 
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));
> 
> There seem to be similar issues with the use of addr here.
> 
> > +
> > +	/* We assume and enforce the size to be word aligned.
> > +	 * If a firmware that is not word aligned is found, please report upstream.
> > +	 */
> > +	for (pos = 0; pos < len; pos += sizeof(u32)) {
> > +		u32 word = get_unaligned((const u32 *)(data + pos));
> > +
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE6,
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(word));
> > +
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
> > +
> > +		/* calculate CRC as we load data to the mailbox.
> > +		 * We convert word to big-endiang as PHY is BE and mailbox will
> > +		 * return a BE CRC.
> > +		 */
> > +		word = cpu_to_be32(word);
> 
> Similarly here, Sparse flags that a little-endian value is assigned to a
> host byte-order variable.
> 

Same here, I'm solving by declaring a new __be32 variable but in
crc_ccitt_false the thing needs to be casted anyway, doesn't that makes
the check useless?

> > +		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> > +	}
> 
> ...
> 
> pw-bot: changes-requested

-- 
	Ansuel
