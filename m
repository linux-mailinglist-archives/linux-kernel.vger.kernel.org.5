Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226887DE42C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjKAPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:51:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F43E4;
        Wed,  1 Nov 2023 08:51:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507973f3b65so10488653e87.3;
        Wed, 01 Nov 2023 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853889; x=1699458689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb0D0LJEi05xwQk6CsVxJcO6PBY8HZV7xQTgB2a9XVw=;
        b=c+lxu02rDBj0w8mV+wEdg5fs6AZZQirAmtoMSUKRNgHVn4TTWVAFaEUnAy0dwgdfRH
         c8uiS7YRml7zgpHei/mYqAz61hcRIgZ1o6saYG45Dg+xLfSXrR+INjX/C9bQr8oeX8g6
         lcPMo0NaubkhHBeqgW6IpuQowdxPRM1cgLksMzcfcTGTSKyo7m3t0NZeuNejHeGdTmls
         Wvuw9QBQC/B3uJO6bkicVKSBSkszHUFFKUypyXlOILIy3OxmqHv8R1LNwGhQj2qUBb6a
         zjFm3tFKon9iODS4XSqcVY27/ZqJdhZ3Z4992qUnxWLCUN7gtqamPQo4Is+i9r3BVbQ9
         MByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853889; x=1699458689;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb0D0LJEi05xwQk6CsVxJcO6PBY8HZV7xQTgB2a9XVw=;
        b=ORUB5+e/Vh1iReprRtXmRIBtKeWIhhHitI5sRqWfOeEVsTZSjZYKkwQKArudu022l7
         jtVbzuLsgIdQhKH9UCFMRALbegysIrLd+7BTnqxrpDj7iyDLn6E5ltg8DTGgX9bAx1kx
         Sj6KMLfhSeJwDVJv/InPiAI+7AIMtew3gfxCTxiyAc2+Pv1hJJnBaQB4T/c6rR980OQy
         O/80Q35DA3RVnCq6Bf++Kd9uYKIUhfDiUZyGyOlQDKoDtPxIuao2FQytlvf4bRsnZVK2
         kbM6uCeo32M9LvH0NGMjm2cHjoPDYhS+y/Fjh45JoQcU7vq0kZrjaQ0kUPlBYGkZRHh7
         kcEQ==
X-Gm-Message-State: AOJu0YxzU7fuWLNJeBeC+hMO68CgY7MuJmHoi7oZUYIbpufGjTgOJejT
        xv++oGgx6PSuUkhxT4t7G1c=
X-Google-Smtp-Source: AGHT+IE9QeWHdiVo83ZsHOu1o033dhfQl9c8uQ1h/NOF2IvJFHmXaV30nqgvvI6ZxGlBldMqZB+2qQ==
X-Received: by 2002:a05:6512:2248:b0:4fe:7e7f:1328 with SMTP id i8-20020a056512224800b004fe7e7f1328mr15484763lfu.16.1698853888568;
        Wed, 01 Nov 2023 08:51:28 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d4903000000b0032f7e832cabsm139349wrq.90.2023.11.01.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:51:28 -0700 (PDT)
Message-ID: <65427400.5d0a0220.41c58.0ded@mx.google.com>
X-Google-Original-Message-ID: <ZUJz/icrdWW94IQI@Ansuel-xps.>
Date:   Wed, 1 Nov 2023 16:51:26 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:13:05PM +0100, Andrew Lunn wrote:
> On Wed, Nov 01, 2023 at 01:36:07PM +0100, Christian Marangi wrote:
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
> > ---
> > Changes v2:
> > - Move out of RFC
> 
> Actually, since we are in the merge window, RFC would be correct.
>

My bad!

> > - Address sanity check for offsets
> > - Add additional comments on firmware load check
> > - Fix some typo
> > - Capitalize CRC in comments
> > - Rename load_sysfs to load_fs
> > 
> >  drivers/net/phy/Kconfig         |   1 +
> >  drivers/net/phy/aquantia_main.c | 304 ++++++++++++++++++++++++++++++++
> >  2 files changed, 305 insertions(+)
> > 
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index 421d2b62918f..46c7194efcea 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -98,6 +98,7 @@ config ADIN1100_PHY
> >  
> >  config AQUANTIA_PHY
> >  	tristate "Aquantia PHYs"
> > +	select CRC_CCITT
> >  	help
> >  	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
> >  
> > diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
> > index 334a6904ca5a..0f1b8d75cca0 100644
> > --- a/drivers/net/phy/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia_main.c
> > @@ -12,6 +12,10 @@
> >  #include <linux/delay.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/phy.h>
> > +#include <linux/of.h>
> > +#include <linux/firmware.h>
> > +#include <linux/crc-ccitt.h>
> > +#include <linux/nvmem-consumer.h>
> >  
> >  #include "aquantia.h"
> >  
> > @@ -92,10 +96,40 @@
> >  #define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
> >  
> >  /* Vendor specific 1, MDIO_MMD_VEND1 */
> > +#define VEND1_GLOBAL_SC				0x0
> > +#define VEND1_GLOBAL_SC_SOFT_RESET		BIT(15)
> > +#define VEND1_GLOBAL_SC_LOW_POWER		BIT(11)
> > +
> >  #define VEND1_GLOBAL_FW_ID			0x0020
> >  #define VEND1_GLOBAL_FW_ID_MAJOR		GENMASK(15, 8)
> >  #define VEND1_GLOBAL_FW_ID_MINOR		GENMASK(7, 0)
> >  
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE1			0x0200
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE		BIT(15)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE		BIT(14)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET	BIT(12)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE1_BUSY		BIT(8)
> > +
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE2			0x0201
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE3			0x0202
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR_MASK	GENMASK(15, 0)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR_MASK, (u16)((x) >> 16))
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE4			0x0203
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK	GENMASK(15, 2)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK, (u16)(x))
> > +
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE5			0x0204
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA_MASK	GENMASK(15, 0)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA_MASK, (u16)((x) >> 16))
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE6			0x0205
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA_MASK	GENMASK(15, 0)
> > +#define VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA_MASK, (u16)(x))
> > +
> > +#define VEND1_GLOBAL_CONTROL2			0xc001
> > +#define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_RST	BIT(15)
> > +#define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD	BIT(6)
> > +#define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL	BIT(0)
> > +
> >  #define VEND1_GLOBAL_GEN_STAT2			0xc831
> >  #define VEND1_GLOBAL_GEN_STAT2_OP_IN_PROG	BIT(15)
> >  
> > @@ -152,6 +186,30 @@
> >  #define AQR107_OP_IN_PROG_SLEEP		1000
> >  #define AQR107_OP_IN_PROG_TIMEOUT	100000
> >  
> > +#define UP_RESET_SLEEP		100
> > +
> > +/* addresses of memory segments in the phy */
> > +#define DRAM_BASE_ADDR		0x3FFE0000
> > +#define IRAM_BASE_ADDR		0x40000000
> > +
> > +/* firmware image format constants */
> > +#define VERSION_STRING_SIZE		0x40
> > +#define VERSION_STRING_OFFSET		0x0200
> > +/* primary offset is written at an offset from the start of the fw blob */
> > +#define PRIMARY_OFFSET_OFFSET		0x8
> > +/* primary offset needs to be then added to a base offset */
> > +#define PRIMARY_OFFSET_SHIFT		12
> > +#define PRIMARY_OFFSET(x)		((x) << PRIMARY_OFFSET_SHIFT)
> > +#define HEADER_OFFSET			0x300
> > +
> > +struct aqr_fw_header {
> > +	u32 padding;
> > +	u8 iram_offset[3];
> > +	u8 iram_size[3];
> > +	u8 dram_offset[3];
> > +	u8 dram_size[3];
> > +} __packed;
> > +
> >  struct aqr107_hw_stat {
> >  	const char *name;
> >  	int reg;
> > @@ -677,6 +735,166 @@ static int aqr107_wait_processor_intensive_op(struct phy_device *phydev)
> >  	return 0;
> >  }
> >  
> > +/* load data into the phy's memory */
> > +static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
> > +				const u8 *data, size_t len)
> > +{
> 
> > +	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
> > +		u32 word = 0;
> > +
> > +		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
> 
> Rather than do a memcpy, use the get_unaligned_ macros. They might map
> to a memcpy(), but some architectures can do unaligned accesses
> without problems.
> 

I don't think this is doable for this loop, think we would end up in
some funny situation where for the last run we have to copy less than
u32. (get_unaligned would always take u32 of data and that would end up
reading more than requested) Am I wrong?

Aside from this, in the other part of the code I can use the macro and
skip having to convert them.

> > +static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size)
> > +{
> > +	const struct aqr_fw_header *header;
> > +	u32 iram_offset = 0, iram_size = 0;
> > +	u32 dram_offset = 0, dram_size = 0;
> > +	char version[VERSION_STRING_SIZE];
> > +	u16 calculated_crc, read_crc;
> > +	u32 primary_offset = 0;
> > +	int ret;
> > +
> > +	/* extract saved CRC at the end of the fw */
> > +	memcpy(&read_crc, data + size - 2, sizeof(read_crc));
> 
> Say size == 1. You just had a buffer underrun.
> 
> > +	/* CRC is saved in big-endian as PHY is BE */
> > +	read_crc = be16_to_cpu(read_crc);
> > +	calculated_crc = crc_ccitt_false(0, data, size - 2);
> > +	if (read_crc != calculated_crc) {
> > +		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
> > +			   read_crc, calculated_crc);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Get the primary offset to extract DRAM and IRAM sections. */
> > +	memcpy(&primary_offset, data + PRIMARY_OFFSET_OFFSET, sizeof(u16));
> 
> What if PRIMARY_OFFSET_OFFSET + sizeof(u16) is greater than size? A
> buffer overrun.
> 
> Assume the firmware is evil and is trying to hack you. Always test
> everything.
> 
> I would suggest some helpers, something like
> 
> int aqr_fw_get_u16(const u8 *data, size_t size, size_t offset, u16 *value)
> 
> Check that offset + sizeof(u16) is within the firmware, and if not return -EINVAL.
> Otherwise set *value to the u16 from the firmware and return 0.
> 
> This is where Rust would be nice :-)
> 
> 	Andrew
> 
> ---
> pw-bot: cr

-- 
	Ansuel
