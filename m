Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064237F5280
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbjKVVWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjKVVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:22:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A680101;
        Wed, 22 Nov 2023 13:22:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso1185725e9.3;
        Wed, 22 Nov 2023 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700688129; x=1701292929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=08+Ie0dqV25MoF956/ME1tRmF8esam1I+2PyZxe5M6U=;
        b=ldaQOuwXdap2awxFs6E338fh4OUN5ESBToEh1WLjz4wkNuCenOKIyZBIwdRgP4xAfW
         i20Sw8x1nQf5XXFPpSnpWMOEDROnwYXZpHbX9PFJndDZv/cNHnhFA5TBoYrD3bU/6HiW
         rwyUQ+oocsM6ZEHPjj0ndpc1IpfDZMd2CWsEsB5qxopVz/qViPoOtxhxUDT0XqRU4WRX
         /ZUEsVjacQm+Ivlhp/eQE1ulT5uajsnGMoF2oI0mZIKmX5VmlurwO9DdmhZ/d2C8O5/R
         nABhiKYDezM2kgdi+ZM9WCOamIgJxfFPDhnKFp2rj4wedHNP4g8yI4NVks8PazCRiGmf
         vNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700688129; x=1701292929;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08+Ie0dqV25MoF956/ME1tRmF8esam1I+2PyZxe5M6U=;
        b=DKYWvzlUdMSOgcEdCuD81EhMSML5JskxdyKmwAicr29OyI5TLQE/cmnxG4omR/C5dY
         4pnABwLA0yPR8yVNvEJiIH60i9uAkg1b1yc0FhfbSkbSreMVfxUCwGI2hCk9lWfRPv/v
         sQ/9KqewYPwn5NTVqEUWaJF5HkQFNee8U5p2Ll4Jz7ruDmZVlY2nms+bKrIiFEB7asOz
         pcylOwv7nSQuDjcfkuQBfx/D2DvMmB4uTa0rONch68azyQxi883L+9ZWNXJ2DXcQd1Q1
         FLwe/5LWCgidWz32IskPusInWyWaviSJIQ4dkWf1yiplZtVCCpowsCxOmmEOTY2uOk3X
         vJmg==
X-Gm-Message-State: AOJu0Yx0UtL+PinO16OsaajYAw/ft/RCA7j3B/EZ0yfgZtgTMlpN8v4T
        BzPP7jK+3y2y6fG8fBEm1kE=
X-Google-Smtp-Source: AGHT+IHH2PF2PFJlr/swMotqXlA/cM9/0OJO4DJ5jXChRxnwx9MhPU4lyFIrejfmhajvrIPij48wDA==
X-Received: by 2002:a05:600c:a002:b0:408:4120:bad2 with SMTP id jg2-20020a05600ca00200b004084120bad2mr2870622wmb.9.1700688128348;
        Wed, 22 Nov 2023 13:22:08 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003fc16ee2864sm522874wmq.48.2023.11.22.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:22:08 -0800 (PST)
Message-ID: <655e7100.050a0220.e85ad.24f4@mx.google.com>
X-Google-Original-Message-ID: <ZV5uIiqSR1CFN2IN@Ansuel-xps.>
Date:   Wed, 22 Nov 2023 22:09:54 +0100
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
 <655e5ca8.5d0a0220.119f1.0f01@mx.google.com>
 <ZV5jrF6+e3ClCmX6@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV5jrF6+e3ClCmX6@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:25:16PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 22, 2023 at 08:55:17PM +0100, Christian Marangi wrote:
> > On Wed, Nov 22, 2023 at 06:53:50PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Nov 22, 2023 at 06:53:39PM +0100, Christian Marangi wrote:
> > > > On Wed, Nov 22, 2023 at 05:24:33PM +0000, Russell King (Oracle) wrote:
> > > > > On Wed, Nov 22, 2023 at 06:08:13PM +0100, Christian Marangi wrote:
> > > > > > On further testing on BE target with kernel test robot, it was notice
> > > > > > that the endianness conversion for addr and CRC in fw_load_memory was
> > > > > > wrong and actually not needed. Values in define doesn't get converted
> > > > > > and are passed as is and hardcoded values are already in what the PHY
> > > > > > require, that is LE.
> > > > > > 
> > > > > > Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
> > > > > > _swab32 instead, the word is taked from firmware and is always LE, the
> > > > > 
> > > > >                                taken
> > > > > 
> > > > > > mailbox will emit a BE CRC hence the word needs to be always swapped and
> > > > > > the endianness of the host needs to be ignored.
> > > > > 
> > > > > I'm not convinced. If the firmware is a bytestream (as most "files" are)
> > > > > then for val = get_unaligned((u32 *)ptr), where ptr is an array of u8:
> > > > > 
> > > > > ptr[0]	ptr[1]	ptr[2]	ptr[3]	val on LE	val on BE
> > > > > 0x01	0x02	0x03	0x04	0x04030201	0x01020304
> > > > > 
> > > > > So, endianness matters here, and I think as Jakub already suggested, you
> > > > > need to use get_unaligned_le32().
> > > > >
> > > > 
> > > > So they DO get converted to the HOST endian on reading the firmware from
> > > > an nvmem cell or a filesystem?
> > > 
> > > I don't like "converted". It's *not* a conversion. It's a fundamental
> > > property of accessing memory using different sizes of access.
> > > 
> > > As I attempted to explain above, if you have a file, and byte 0
> > > contains 0xAA, byte 1 of the file contains 0xBB, byte 2 contains
> > > 0xCC, and byte 3 contains 0xDD, then if you read that file byte by
> > > byte, you will get 0xAA, then 0xBB, then 0xCC and then 0xDD.
> > > 
> > > If you map that file into memory, e.g. in userspace, using mmap(),
> > > or allocating memory and reading four bytes into memory, and access
> > > it using bytes, then at offset 0, you will find 0xAA, offset 1 will
> > > be 0xBB, etc.
> > > 
> > > The problems with endianness start when you move away from byte
> > > access.
> > > 
> > > If you use 16-bit accessors, then, a little endian machine is defined
> > > that a 16-bit load from memory will result in the first byte being put
> > > into the LSB of the 16-bit value, and the second byte will be put into
> > > the MSB of the 16-bit value. So that would be 0xBBAA. However, on a big
> > > endian machine, a 16-bit load will result in the first byte being put
> > > into the MSB of the 16-bit value, and the second byte will be put into
> > > the LSB of that value - meaning the 16-bit value will be 0xAABB.
> > > 
> > > The second 16-bit value uses the next two bytes, and the order at which
> > > these two bytes are placed into the 16-bit value reflects the same as
> > > the first two bytes. So LE will be 0xDDCC and BE would be 0xCCDD.
> > > 
> > > The same "swapping" happens with 32-bit, but of course instead of just
> > > two bytes, it covers four bytes. On LE, a 32-bit access will give
> > > 0xDDCCBBAA. On BE, that will be 0xAABBCCDD.
> > > 
> > > Again, this is not to do with any kind of "conversion" happening in
> > > software. It's a property of how the memory subsystem inside the CPU
> > > works.
> > > 
> > > > Again this is really dumping raw data from the read file directly to the
> > > > mailbox. Unless phy_write does some conversion internally, but in that
> > > > case how does it know what endian is the PHY internally?
> > > 
> > > phy_write() does *no* conversion. The MDIO bus defines that a 16-bit
> > > register value will be transferred, and the MDIO bus specifies that
> > > bit 15 will be sent first, followed by subsequent bits down to bit 0.
> > > 
> > > The access to the hardware to make this happen is required to ensure
> > > that the value passed to phy_write() and read using phy_read() will
> > > reflect this. So, if one does this:
> > > 
> > > 	val = phy_read(phydev, 0);
> > > 
> > > 	for (i = 15; i >= 0; i--)
> > > 		printk("%u", !!(val & BIT(i)));
> > > 
> > > 	printk("\n");
> > > 
> > > This will give you the stream of bits in the _order_ that they appeared
> > > on the MDIO bus when phy_read() accessed. Doing the same with a value
> > > to be written will produce the bits in the same value that they will
> > > be placed on the MDIO bus.
> > > 
> > > So, this means that if the BMCR contains 0x1234 in the PHY, phy_read()
> > > will return 0x1234. Passing 0x1234 into phy_write() will write 0x1234
> > > in that register. The host endian is entirely irrelevant here.
> > >
> > 
> > Thanks a lot for the clarification. And sorry for misusing the word
> > conversion.
> > 
> > > > > I would make this explicit:
> > > > > 
> > > > > 		u8 crc_data[4];
> > > > > 
> > > > > 		...
> > > > > 
> > > > > 		/* CRC is calculated using BE order */
> > > > > 		crc_data[0] = word >> 24;
> > > > > 		crc_data[1] = word >> 16;
> > > > > 		crc_data[2] = word >> 8;
> > > > > 		crc_data[3] = word;
> > > > > 
> > > > > 		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
> > > > > 
> > > > > which will be (a) completely unambiguous, and (b) completely
> > > > > independent of the host endianness.
> > > > 
> > > > But isn't this exactly what is done with ___constant_swab32 ?
> > > > __swab32 should not change if the HOST is BE or LE.
> > > 
> > > Let try again to make this clear. If one has this code:
> > > 
> > > 		u32 word = 0x01020304;
> > > 		u8 *ptr;
> > > 		int i;
> > > 
> > > 		ptr = (u8 *)&word;
> > > 
> > > 		for (i = 0; i < 4; i++)
> > > 			printk(" %02x", ptr[i]);
> > > 		printk("\n");
> > > 
> > > Then, on a:
> > > - LE machine, this will print " 04 03 02 01"
> > > - BE machine, this will print " 01 02 03 04"
> > > 
> > > Now, if you look at the definition of crc_ccitt_false(), it is
> > > defined to do:
> > > 
> > >         while (len--)
> > >                 crc = crc_ccitt_false_byte(crc, *buffer++);
> > > 
> > > So, on a LE machine, this will feed the above bytes in the order of
> > > 0x04, 0x03, 0x02, 0x01 in a LE machine, and 0x01, 0x02, 0x03, 0x04
> > > on a BE machine.
> > > 
> > 
> > So it's really a problem of setting u8 in word and the order they are
> > read in the system.
> 
> Correct.
> 
> > The first get_unaligned has to be changed to get_unaligned_le32 based on
> > how the data are treated from passing from an u8 to u32.
> 
> Yes.
> 
> I'm going to use the term "bytestream", abbreviated to just stream, to
> represent the firmware that you are going to upload, because that's
> essentially what all files are.
> 
>  the first byte of the stream to appear in bits 7:0 of
>    VEND1_GLOBAL_MAILBOX_INTERFACE6
> 
>  the second byte of the stream to appear in bits 15:8 of
>    VEND1_GLOBAL_MAILBOX_INTERFACE6
> 
>  the third byte of the stream to appear in bits 7:0 of
>    VEND1_GLOBAL_MAILBOX_INTERFACE5
> 
>  the forth byte of the stream to appear in bits 15:8 of
>    VEND1_GLOBAL_MAILBOX_INTERFACE5
> 
> and this to repeat over subsequent groups of four bytes in the stream.
> 
> This will be achieved by reading the stream using 32-bit little endian
> accesses using get_unaligned_le32(), and then as you are already doing,
> splitting them up into two 16-bit quantities.
> 
> > For LE this doesn't matter but for BE they needs to be swapped as this
> > is what mailbox expect.
> 
> Correct.
> 
> > For CRC. Would something like this work?
> > 
> > Define u8 crc_data[4];
> > 
> > *crc_data = (__force u32)cpu_to_be32(word);
> 
> That won't do what you want, it will only write the first byte.
>

Right I'm stupid...

Just an example, the correct way would have been...

u8 crc_data[4];
u32 *crc_word;
u32 word;

crc_word = (u32 *)crc_data;
*crc_word = (__force u32)cpu_to_be32(word);

crc = crc_ccitt_false(crc, crc_data, sizeof(word));

> > crc = crc_ccitt_false(crc, crc_data, sizeof(word));
> 
> The point of explicitly assigning each byte is to ensure that it's
> obvious that we'll get the right result. If we try to write a 32-bit
> value, then we're getting right back into the "how does _this_ CPU
> map a 32-bit value to indivudual bytes" endianness problem.
> 
> The advantage of writing it out as bytes into a u8 array is that from
> a code readability point of view, it's all laid out in plain sight
> exactly which part of the 32-bit value ends up where and the order in
> which the crc function is going to read those bytes - and it is
> independent of whatever the endianess of the host architecture.
> 

It's just that I would really love to have a way to skip the shift
maddness. If the code above is correct really don't know what is
better... probably yours... just I don't like those shift.

I wonder... can't I reuse get_unaligned_be32((const u32 *)(data + pos));
???

> > Using u8 array should keep the correct order no matter the endian and
> > cpu_to_be32 should correctly swap the word if needed. (in a BE HOST data
> > should already be in the right order and in LE has to be swapped right?)
> 
> If you are absolutely certain that each group of four bytes in the
> source bytestream need to be provided to the CRC function in the
> reverse order to which they appear in the file.
> 

-- 
	Ansuel
