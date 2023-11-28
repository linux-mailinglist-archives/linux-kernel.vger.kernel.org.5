Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9883A7FBA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbjK1Mpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjK1Mp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:45:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB9810FB;
        Tue, 28 Nov 2023 04:45:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40838915cecso37965365e9.2;
        Tue, 28 Nov 2023 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701175525; x=1701780325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTNgL8/ETpBzsbPQ1ckigUJeZWAIyuGGeISrmqZ9ANw=;
        b=JTmOkAa/VxR2ksnHeCU7vyNCSDX+kfyKhpoDt07k5ZUkcrPnj8MrTFce/oVu995Tcb
         Of+ddyXJvUrav34NcqQ91uhwh8CUBNg7YWvaahOXPRhDqHKfPBTfGT5moYmf91i+RM/Q
         8w/8gI0HPt7Zntf5eA36aLatBiAMSa9Cx3B4r22Sxu8ZIBa1S+rpE8Fo6H/IscbRNISZ
         WlOFwalEncInSu4obhCpoSgWUAlZmaG3OOqBMpwbET+wQJCtPoebnrKb2yCfCid1faMG
         LIkE2QIF1uQ+340OZ8uZm5Ck4RKNagxRa0U8JNEMoL9NEVZLjKW40d00iSQm0KvsA1oF
         oRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701175525; x=1701780325;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTNgL8/ETpBzsbPQ1ckigUJeZWAIyuGGeISrmqZ9ANw=;
        b=Qw6Qr6l+yVbwMX12T5N0HuyOL1lU/76OciQeIcQ+bdeHAI5tC2U2eBaQZuxkQ1xUlG
         ve7gCIsxrBIuxYYNjC53z8+oIFW+wK5BrmTMtvEVfJrbxCR8iOu6XyJfMwJtZlgyHQDM
         oeRA2A2F1S7h7Q5O8Vk3puEqRVneZSEN4ryUCAZ3qVf+LpFYCi8yt0+/4/XypjIlPnvK
         AOnpUMRyH14UOfauLHeBG/eMxYoHmj8NrE1w9PZuINMUibt4LezuKgVPFSxHS91dz/fA
         iU9oiCxNou6q/mAXSGPEM1gWrhXJSBXoyPfsAEVr/t8a/WVP1z8forjitxUJ3NxsCRjJ
         RkeQ==
X-Gm-Message-State: AOJu0YwCtvL6gE4JN4XbfhCHR5jixlvsZdSZxpRQfXd8RcJRtaHHXmYH
        K4N2dZUeSeTdXvEAqWaZkvA=
X-Google-Smtp-Source: AGHT+IFLZ1CKlfGwmylWXmZqS7hHEtlpEIpfHIp1yeCpstNj5WRyu6jEiMOpS5Gdy47ohu3wCfSR9Q==
X-Received: by 2002:a05:600c:1d1d:b0:40b:5008:9c0 with SMTP id l29-20020a05600c1d1d00b0040b500809c0mr229014wms.9.1701175524908;
        Tue, 28 Nov 2023 04:45:24 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6105000000b0032f7fab0712sm14826186wrt.52.2023.11.28.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:45:24 -0800 (PST)
Message-ID: <6565e0e4.5d0a0220.26ded.fe1e@mx.google.com>
X-Google-Original-Message-ID: <ZWXgt4LYGemyVrTg@Ansuel-xps.>
Date:   Tue, 28 Nov 2023 13:44:39 +0100
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
Subject: Re: [net-next PATCH v2] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
References: <20231127002924.22384-1-ansuelsmth@gmail.com>
 <ZWRpS9CL5OarIOkA@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWRpS9CL5OarIOkA@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:02:51AM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 27, 2023 at 01:29:24AM +0100, Christian Marangi wrote:
> > On further testing on BE target with kernel test robot, it was notice
> > that the endianness conversion for addr and CRC in fw_load_memory was
> > wrong and actually not needed. Values in define doesn't get converted
> > and are passed as is and hardcoded values are already in what the PHY
> > require, that is LE.
> > 
> > Use get_unaligned_le32 instead of get_unaligned for FW data word load to
> > correctly convert data in the correct order to follow system endian.
> > 
> > Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> > get_unaligned_be32 instead. The word is taken from firmware and is
> > always LE, the mailbox will emit a BE CRC from BE word hence the
> > word needs to be swapped on u8 to u32 cast on LE system.
> > This is needed as crc_ccitt_false will recast u32 to u8 and read order
> > changes between BE and LE system. By using get_unaligned_be32, word is
> > swapped only when needed resulting in the correct CRC calculated.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202311210414.sEJZjlcD-lkp@intel.com/
> > Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
> > Tested-by: Robert Marko <robimarko@gmail.com> # ipq8072 LE device
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Add further explaination in commit description
> > - Fix wrong CRC conversion and swap only when needed
> > 
> >  drivers/net/phy/aquantia/aquantia_firmware.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> > index c5f292b1c4c8..c12e8a3acb77 100644
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
> 
> Please fix this comment. No, the address is not in LE. You program the
> address into a register in the PHY. Bit 0 of the register is bit 0 of
> the data field on the MDIO bus, and bit 0 of the value passed to
> phy_write_mmd() which is in CPU endian. Bit 15 of the register is bit
> 15 of the data field on the MDIO bus, which is bit 15 of the value
> passed to phy_write_mmd().
> 
> So the talk of "LE" here is meaningless. Please stop over-complicating
> this.
>

Will drop sorry.

> >  	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> >  		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> >  		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > @@ -113,7 +113,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> >  		u32 word;
> >  
> >  		/* FW data is always stored in little-endian */
> > -		word = get_unaligned((const u32 *)(data + pos));
> > +		word = get_unaligned_le32((const u32 *)(data + pos));
> 
> This comment is appropriate, and get_unaligned_le32() is correct.
> 
> >  
> >  		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
> >  			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
> > @@ -125,10 +125,10 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
> >  			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
> >  
> >  		/* calculate CRC as we load data to the mailbox.
> > -		 * We convert word to big-endian as PHY is BE and mailbox will
> > +		 * We read word as big-endian as PHY is BE and mailbox will
> >  		 * return a BE CRC.
> 
> Is that true (about returning a BE CRC) ?
> 

More info at the bottom.

> >  		 */
> > -		word = (__force u32)cpu_to_be32(word);
> > +		word = get_unaligned_be32((const u32 *)(data + pos));
> >  		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> >  	}
> 
> And you _still_ haven't taken on board my issue with this, sigh. No,
> this will be subject to variation in result from CPU endianness.
> 
> For the sake of your education on the first point, do this:
> 
> 	u16 le_crc = 0, be_crc = 0, up_crc;
> 
> ...
> 		le_crc = crc_ccitt_false(le_crc, (u8 *)&word, sizeof(word));
> 		word = get_unaligned_be32((const u32 *)(data + pos));
> 		be_crc = crc_ccitt_false(be_crc, (u8 *)&word, sizeof(word));
> 	}
> 
> 	printk("le_crc=0x%04x be_crc=0x%04x\n", le_crc, be_crc);
> 
> What you will find is that the two CRCs are _totally_ different - not
> just different in endian, but different in value as well. The endianness
> of the input data does not simply change the endianness of the resulting
> CRC, it will change the value.
> 
> So, returning a "BE CRC" has no bearing on whether the data passed to
> the CRC function needs to be in big endian order or not.
> 
> On the second point, as I have stated numerous times, and it seems I'm
> not getting anywhere with:
> 
> 
> 	u32 word;
> 	int i;
> 	u8 *p;
> 
> 	word = 0x01020304;
> 
> 	p = (u8 *)&word;
> 
> 	for (i = 0; i < sizeof(word); i++)
> 		printf("p[%d] = %02x\n", i, p[i]);
> 
> on little endian machines will print:
> 
> p[0] = 0x01
> p[1] = 0x02
> p[2] = 0x03
> p[3] = 0x04
> 
> but on big endian machines will print:
> 
> p[0] = 0x04
> p[1] = 0x03
> p[2] = 0x02
> p[3] = 0x01
> 
> The order in which you provide the bytes to a CRC function will change
> the CRC value. So, the endianness of the machine/CPU your code will be
> running on will change the resulting CRC.
> 
> Your code is buggy.
> 
> I've given you solutions to it, but you are very resistant to these
> suggestions.
> 
> I know endianness can be difficult to those who don't understand it,
> but I've described it numerous times, complete with code examples to
> show how things change - including for the above issue. It seems I'm
> demonstrably waiting my time because it's having very little effect.
> 
> Therefore, quite simply, NAK to this patch.
>

Sorry for getting you annoyed, wasn't my intention at all. Also wasn't
reistantant but more of trying to find a solution without falling back
to the raw shift, trying to keep them out of the function code. Anyway
on the the explaination on how this majestic thing works.

We verified and it's almost everything correct, just badly worded I
guess...(not referring to your explaination but what is currently
implemented and written in the driver comments)

The thing works this way:
1. Things are loaded to mailbox with the data regs. (LE order expected)
2. Internally the word is converted to BE
3. CRC is calculated in the just converted data (CRC calculated on BE
   word)
4. CRC is provided via the mailbox CRC regs in LE order.

We verified this by loading a word and comparing what was the CRC
returned and we observed it's bit match the CRC of the word with the bytes
swapped.

Given this sorted out and having a clear idea of what happens
internally.

Yes your suggested way of an u8 struct it's the only way to make the crc
function to work given the cast...

An alternative might be:
		crc = crc_ccitt_false_byte(crc, data + pos + 3);
		crc = crc_ccitt_false_byte(crc, data + pos + 2);
		crc = crc_ccitt_false_byte(crc, data + pos + 1);
		crc = crc_ccitt_false_byte(crc, data + pos);

but I think this is unreadable.

Also the CRC returned from the mailbox CRC has to be converted with
le16_to_cpu since it's LE and won't match on BE system. Am I wrong?

-- 
	Ansuel
