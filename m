Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700647F4EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjKVRxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjKVRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:53:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8E1A8;
        Wed, 22 Nov 2023 09:53:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316d09c645so3620816f8f.0;
        Wed, 22 Nov 2023 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700675622; x=1701280422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AdOBPKB2H9imCd9isIgQYWfbsuOE5ddo9bpSACnZw7o=;
        b=X1QfVTaDZlrZlY8VYrFGXSKljh5vJ+6tN6jZO4PO5gqom8HXXeWlwjbsWdWmR2Smz5
         8Big+26BVjQPuAOw/UJzklCyRjUD53Qu+zIbaFa4M7WOG8w83ODm7P408a2U2lGAhjvN
         nfeyXKfgXIThQ5TK0xjqSjM9REuI9KIFB3rpHPSq+CYzULEmZ2zCXxKcjNvtqY3FY4/v
         Z052waF+qfkQ5/ADvoTpi7xKNgc0ZzPJx/6UO+WG/cx3hTaQ71os5oaALiA9M5H5ZrzI
         K6dnekuSeHzPSS3YTWmh2e0P4b5FOB24X8S0A+V5ySoN8cgoRBn1BKLRic3shf7TktXD
         6M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675622; x=1701280422;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdOBPKB2H9imCd9isIgQYWfbsuOE5ddo9bpSACnZw7o=;
        b=IxXYKczN2g3xWM4gi7rqMJbyrrVULYbaG5WIAWgAT39zgt/VEJ284CF1JiLCMaVs4Y
         RcUEbR+tWVN+lit1S90cpe8z+1H5F49I08UpvtNcpFOtLsV4efLVA76ZNpo4XzI1SspO
         yX2kBfD/PbflJpYb3+r1uFDZq1LrzB7N/LPE0U2DObEtQCc1RrrS8LS/FvG+aUB2Rhe6
         iXW/2XcjuUcxQX6tdssIxj8IS48s1fA1q1uUtAez+DftfZFDfZ+zF4ka+wPkAyo1vIfa
         Vw9ndSYN9Yw8lo9GB+k96P/sRSg4EwUvi1+CVKiwMaSFru13uMf/NoRcHanXHHd9dAAc
         SvaQ==
X-Gm-Message-State: AOJu0Yw9VJriRPyLzPckXnNOW8NcgzBbMBKKNjGUUgo0MyG5g4Cl+KEO
        qgJysMOaEzsHllTtNXp2qOU=
X-Google-Smtp-Source: AGHT+IFlnSL12ZSmipJ4vORisCI3rn2874HDuY5w0IGDLNY/BeJv0cNVcWDQ9nqh7rT9QWFD5rDiPw==
X-Received: by 2002:a5d:67c5:0:b0:332:c441:70aa with SMTP id n5-20020a5d67c5000000b00332c44170aamr2256749wrw.26.1700675622215;
        Wed, 22 Nov 2023 09:53:42 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id k5-20020adfe8c5000000b00331733a98ddsm14781231wrn.111.2023.11.22.09.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:53:41 -0800 (PST)
Message-ID: <655e4025.df0a0220.50550.3d70@mx.google.com>
X-Google-Original-Message-ID: <ZV5AI/KsHnNi/gKs@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 18:53:39 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
References: <20231122170813.1222-1-ansuelsmth@gmail.com>
 <ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV45UY6nYZ/WAHpG@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 05:24:33PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 22, 2023 at 06:08:13PM +0100, Christian Marangi wrote:
> > On further testing on BE target with kernel test robot, it was notice
> > that the endianness conversion for addr and CRC in fw_load_memory was
> > wrong and actually not needed. Values in define doesn't get converted
> > and are passed as is and hardcoded values are already in what the PHY
> > require, that is LE.
> > 
> > Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> > _swab32 instead, the word is taked from firmware and is always LE, the
> 
>                                taken
> 
> > mailbox will emit a BE CRC hence the word needs to be always swapped and
> > the endianness of the host needs to be ignored.
> 
> I'm not convinced. If the firmware is a bytestream (as most "files" are)
> then for val = get_unaligned((u32 *)ptr), where ptr is an array of u8:
> 
> ptr[0]	ptr[1]	ptr[2]	ptr[3]	val on LE	val on BE
> 0x01	0x02	0x03	0x04	0x04030201	0x01020304
> 
> So, endianness matters here, and I think as Jakub already suggested, you
> need to use get_unaligned_le32().
>

So they DO get converted to the HOST endian on reading the firmware from
an nvmem cell or a filesystem?

Again this is really dumping raw data from the read file directly to the
mailbox. Unless phy_write does some conversion internally, but in that
case how does it know what endian is the PHY internally?

> > diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> > index c5f292b1c4c8..bd093633d0cf 100644
> > --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> > +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> > @@ -93,9 +93,9 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> >  	u16 crc = 0, up_crc;
> >  	size_t pos;
> >  
> > -	/* PHY expect addr in LE */
> > -	addr = (__force u32)cpu_to_le32(addr);
> > -
> > +	/* PHY expect addr in LE. Hardcoded addr in defines are
> > +	 * already in this format.
> > +	 */
> >  	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> >  		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> >  		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > @@ -128,7 +128,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> >  		 * We convert word to big-endian as PHY is BE and mailbox will
> >  		 * return a BE CRC.
> >  		 */
> > -		word = (__force u32)cpu_to_be32(word);
> > +		word = __swab32(word);
> >  		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> 
> Again, I think you need to be careful with the endianness here again.
> From what I understand here, it seems the CRC needs to be generated by
> looking at the byte at ptr[3] first, then ptr[2], ptr[1] and finally
> ptr[0] ?
> 
> If that is the case, the problem is using __swab32() on LE will do the
> job for you, but on BE machines, it will be wrong.
> 
> I would make this explicit:
> 
> 		u8 crc_data[4];
> 
> 		...
> 
> 		/* CRC is calculated using BE order */
> 		crc_data[0] = word >> 24;
> 		crc_data[1] = word >> 16;
> 		crc_data[2] = word >> 8;
> 		crc_data[3] = word;
> 
> 		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
> 
> which will be (a) completely unambiguous, and (b) completely
> independent of the host endianness.

But isn't this exactly what is done with ___constant_swab32 ?
__swab32 should not change if the HOST is BE or LE.

The real question is if word is converted. (by either the read API on
reading the FW or by phy_write on writing the thing to mailbox) (the
test are done on a LE HOST)

Our theory is that mailbox takes LE and internally converts to BE (as
the PHY is BE) but the CRC reg calculates the CRC out of the converted
data aka it does calculates the CRC from the BE data (converted
internally).

-- 
	Ansuel
