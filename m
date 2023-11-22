Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBD7F50F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjKVTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjKVTz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:55:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BE1B6;
        Wed, 22 Nov 2023 11:55:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so70817f8f.0;
        Wed, 22 Nov 2023 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700682921; x=1701287721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8DP9KVk6mValI/dA1cznavYkMvpY+SjIdXkTZZ0BtDo=;
        b=F86OWNlRddccjZf1h63a7ACkfUcm7ClO4K++PbfJ5cfaQ5+M+71bhv0bDVksY7sFK8
         I2aHGnafeKjbmkkNIYDJcWn3pK7BTF16mvVkoqMWIQBJd5WxgHfr73tK8idjg7x9vCSv
         mj/bZb+xUaQK8/07UlaIn00P0MbHvy4Joamwp3gMkz9BYAfA6ki7bpCD2ySINIkWs3FW
         ZWTw851qvaHqxOfWBbbuaaU76ZAUqg4fa8eAfDCKzmGZ6RjR5DZl8DM59cCpXV3YrwaV
         0hAL6BbWMwnAuCB1FHO+iRngEjnQYWPNP6Wpvv5v83XVt94U/t3GTrez7fFwdPgp99XB
         Vycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700682921; x=1701287721;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DP9KVk6mValI/dA1cznavYkMvpY+SjIdXkTZZ0BtDo=;
        b=gHUpkxzXw/DCtU9BAi1kbSn2Id3BwvpafEXg0QAE9Y+QWwIZBxErKfLQ+FqW+NTF6+
         6PjkUF1MEP2M/5ynitEtO4E62c6ddk4JCmw9Hd557vs0zvmmOoS4B0HBOivQ6kL8dCyX
         SibXS3hccP1VG1GP+okv3hpad1EFKBOGIyokXCFde9uHFDpIjy0oDrRcmn5LjlJJ6mae
         aURgFDlDTz4KbbvyE8zkysF/U0x1zz6/QQ7+HLq71cq+JjrzBL83TWKzOP/cZAduKF7n
         cACMV+gVd5NVnyliWCfEE68OZd5tEYyWGrvTvNagCW7FfJd0ghT8pV3vHnlWKTFzzwJe
         OEtQ==
X-Gm-Message-State: AOJu0Yy1J9r7Sn1Lhc074jsSayOREvTfqJ2yEnWjJCsxL0lsGHH9pcha
        I8tEmYYPwzC2o1yWc6UHT4w=
X-Google-Smtp-Source: AGHT+IGYZI9zshtvGYjf0KLQ1n9ZgRlfgrF23kgnbVUA590dy56IEIZVJE5Qg7gyjTyQID68Up/ejg==
X-Received: by 2002:a5d:6d8f:0:b0:32f:92f3:dbbb with SMTP id l15-20020a5d6d8f000000b0032f92f3dbbbmr2151294wrs.70.1700682920921;
        Wed, 22 Nov 2023 11:55:20 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d6d0c000000b003316be2df7fsm220226wrq.17.2023.11.22.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:55:20 -0800 (PST)
Message-ID: <655e5ca8.5d0a0220.119f1.0f01@mx.google.com>
X-Google-Original-Message-ID: <ZV5cpbsHaTPTGqBk@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 20:55:17 +0100
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
 <655e4025.df0a0220.50550.3d70@mx.google.com>
 <ZV5OPr5ee2x/yMCQ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV5OPr5ee2x/yMCQ@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:53:50PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 22, 2023 at 06:53:39PM +0100, Christian Marangi wrote:
> > On Wed, Nov 22, 2023 at 05:24:33PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Nov 22, 2023 at 06:08:13PM +0100, Christian Marangi wrote:
> > > > On further testing on BE target with kernel test robot, it was notice
> > > > that the endianness conversion for addr and CRC in fw_load_memory was
> > > > wrong and actually not needed. Values in define doesn't get converted
> > > > and are passed as is and hardcoded values are already in what the PHY
> > > > require, that is LE.
> > > > 
> > > > Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> > > > _swab32 instead, the word is taked from firmware and is always LE, the
> > > 
> > >                                taken
> > > 
> > > > mailbox will emit a BE CRC hence the word needs to be always swapped and
> > > > the endianness of the host needs to be ignored.
> > > 
> > > I'm not convinced. If the firmware is a bytestream (as most "files" are)
> > > then for val = get_unaligned((u32 *)ptr), where ptr is an array of u8:
> > > 
> > > ptr[0]	ptr[1]	ptr[2]	ptr[3]	val on LE	val on BE
> > > 0x01	0x02	0x03	0x04	0x04030201	0x01020304
> > > 
> > > So, endianness matters here, and I think as Jakub already suggested, you
> > > need to use get_unaligned_le32().
> > >
> > 
> > So they DO get converted to the HOST endian on reading the firmware from
> > an nvmem cell or a filesystem?
> 
> I don't like "converted". It's *not* a conversion. It's a fundamental
> property of accessing memory using different sizes of access.
> 
> As I attempted to explain above, if you have a file, and byte 0
> contains 0xAA, byte 1 of the file contains 0xBB, byte 2 contains
> 0xCC, and byte 3 contains 0xDD, then if you read that file byte by
> byte, you will get 0xAA, then 0xBB, then 0xCC and then 0xDD.
> 
> If you map that file into memory, e.g. in userspace, using mmap(),
> or allocating memory and reading four bytes into memory, and access
> it using bytes, then at offset 0, you will find 0xAA, offset 1 will
> be 0xBB, etc.
> 
> The problems with endianness start when you move away from byte
> access.
> 
> If you use 16-bit accessors, then, a little endian machine is defined
> that a 16-bit load from memory will result in the first byte being put
> into the LSB of the 16-bit value, and the second byte will be put into
> the MSB of the 16-bit value. So that would be 0xBBAA. However, on a big
> endian machine, a 16-bit load will result in the first byte being put
> into the MSB of the 16-bit value, and the second byte will be put into
> the LSB of that value - meaning the 16-bit value will be 0xAABB.
> 
> The second 16-bit value uses the next two bytes, and the order at which
> these two bytes are placed into the 16-bit value reflects the same as
> the first two bytes. So LE will be 0xDDCC and BE would be 0xCCDD.
> 
> The same "swapping" happens with 32-bit, but of course instead of just
> two bytes, it covers four bytes. On LE, a 32-bit access will give
> 0xDDCCBBAA. On BE, that will be 0xAABBCCDD.
> 
> Again, this is not to do with any kind of "conversion" happening in
> software. It's a property of how the memory subsystem inside the CPU
> works.
> 
> > Again this is really dumping raw data from the read file directly to the
> > mailbox. Unless phy_write does some conversion internally, but in that
> > case how does it know what endian is the PHY internally?
> 
> phy_write() does *no* conversion. The MDIO bus defines that a 16-bit
> register value will be transferred, and the MDIO bus specifies that
> bit 15 will be sent first, followed by subsequent bits down to bit 0.
> 
> The access to the hardware to make this happen is required to ensure
> that the value passed to phy_write() and read using phy_read() will
> reflect this. So, if one does this:
> 
> 	val = phy_read(phydev, 0);
> 
> 	for (i = 15; i >= 0; i--)
> 		printk("%u", !!(val & BIT(i)));
> 
> 	printk("\n");
> 
> This will give you the stream of bits in the _order_ that they appeared
> on the MDIO bus when phy_read() accessed. Doing the same with a value
> to be written will produce the bits in the same value that they will
> be placed on the MDIO bus.
> 
> So, this means that if the BMCR contains 0x1234 in the PHY, phy_read()
> will return 0x1234. Passing 0x1234 into phy_write() will write 0x1234
> in that register. The host endian is entirely irrelevant here.
>

Thanks a lot for the clarification. And sorry for misusing the word
conversion.

> > > I would make this explicit:
> > > 
> > > 		u8 crc_data[4];
> > > 
> > > 		...
> > > 
> > > 		/* CRC is calculated using BE order */
> > > 		crc_data[0] = word >> 24;
> > > 		crc_data[1] = word >> 16;
> > > 		crc_data[2] = word >> 8;
> > > 		crc_data[3] = word;
> > > 
> > > 		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
> > > 
> > > which will be (a) completely unambiguous, and (b) completely
> > > independent of the host endianness.
> > 
> > But isn't this exactly what is done with ___constant_swab32 ?
> > __swab32 should not change if the HOST is BE or LE.
> 
> Let try again to make this clear. If one has this code:
> 
> 		u32 word = 0x01020304;
> 		u8 *ptr;
> 		int i;
> 
> 		ptr = (u8 *)&word;
> 
> 		for (i = 0; i < 4; i++)
> 			printk(" %02x", ptr[i]);
> 		printk("\n");
> 
> Then, on a:
> - LE machine, this will print " 04 03 02 01"
> - BE machine, this will print " 01 02 03 04"
> 
> Now, if you look at the definition of crc_ccitt_false(), it is
> defined to do:
> 
>         while (len--)
>                 crc = crc_ccitt_false_byte(crc, *buffer++);
> 
> So, on a LE machine, this will feed the above bytes in the order of
> 0x04, 0x03, 0x02, 0x01 in a LE machine, and 0x01, 0x02, 0x03, 0x04
> on a BE machine.
> 

So it's really a problem of setting u8 in word and the order they are
read in the system.

Tell me if I'm wrong.

The first get_unaligned has to be changed to get_unaligned_le32 based on
how the data are treated from passing from an u8 to u32.

For LE this doesn't matter but for BE they needs to be swapped as this
is what mailbox expect.

For CRC. Would something like this work?

Define u8 crc_data[4];

*crc_data = (__force u32)cpu_to_be32(word);

crc = crc_ccitt_false(crc, crc_data, sizeof(word));

Using u8 array should keep the correct order no matter the endian and
cpu_to_be32 should correctly swap the word if needed. (in a BE HOST data
should already be in the right order and in LE has to be swapped right?)

> > The real question is if word is converted. (by either the read API on
> > reading the FW or by phy_write on writing the thing to mailbox) (the
> > test are done on a LE HOST)
> 
> There are no conversions - where a conversion I define as something
> that the software explicitly has to do rather than what the underlying
> machine hardware does.
> 
> > Our theory is that mailbox takes LE and internally converts to BE (as
> > the PHY is BE) but the CRC reg calculates the CRC out of the converted
> > data aka it does calculates the CRC from the BE data (converted
> > internally).
> 
> I think the talk about the endian-ness of the PHY is entirely
> unhelpful and is probably adding to confusion. The endian-ness of the
> PHY is *not* exposed to the host because the MDIO interface to the PHY
> is defined in terms of 16-bit register quantities, and bit 0 of the
> register will be bit 0 on the host irrespective of host endian.
> 

-- 
	Ansuel
