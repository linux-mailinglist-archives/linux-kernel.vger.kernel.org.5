Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65937E5AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjKHQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKHQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:13:40 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486E819A5;
        Wed,  8 Nov 2023 08:13:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 74DAD3200902;
        Wed,  8 Nov 2023 11:13:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 08 Nov 2023 11:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1699460014; x=1699546414; bh=0qh1iZ3jKDiJ8NSUiOWwTNpMvm2IpPKmj3S
        VfM/sroI=; b=mzwvPx2MMSklPSTI2mY+01Bjj6GiUsncl5eMruB2A+Q2lgNdo7j
        osCsnpPpfzcib48fSnZrE6uu4evoZQutojly0gCNA87CNEwvPd9oIvhkMU4bOdP0
        3c5pktGsO4R56XbM739ICC2uelb5lY7/69F/hdTxPd6YFRxRda5PJG2JApSAn3Pw
        A6KBCNRf9FD3x1qQvt0pV6ZmQv8MEALFHiZXZyLRzOsLYN7OxRH8f3O01OBvHTjO
        bD/De+Nk0YgwhMO5QRncmukWBL4eOPOPiD/bY32mSPy9QqkBa5hHWOEG/UJJnOco
        4kxtNoASdEzCEECnySFQwZk+QGxpgztrmRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699460014; x=1699546414; bh=0qh1iZ3jKDiJ8NSUiOWwTNpMvm2IpPKmj3S
        VfM/sroI=; b=WUoWVwlT2xylumZyUCiVxQLnQoxSF61JtemwA4GAJQqCAOS21je
        Z2wsGNWowFzQZSmEgf9UYHlgIhyRQYvVD8yO4DGoaykWTt0XXtDZsx7w/yOLIGeF
        cjoIOL7hC/Tc8DSbpV/UnYFMbhJecKgQb/Ppykmlv85dypfjpWrgC1IolgBHB9FR
        tqF2/EM8FrypXryToi9ynd7gU1VRLZ4srf11FeGEaT3Lh3Gksd9AHPyTxppPllhX
        GUi45LlxKf/M4ATjE7dv2Mc61EcGZfRhhrM3yX0WUbHlCfNU9FZuSzQUG3s3bHbG
        YNoRzxlnYI0Xw7K9TW5oDGpsttmiB+08PBQ==
X-ME-Sender: <xms:rbNLZTMJ1qW9JD4zrOTzQBXq22EAhN42bOefI0-uqwxv4DGbVxIgpg>
    <xme:rbNLZd_YX-Xz3QeJBrOkAWO5rD_93xARl-PxR3t0huGpKTgJNnfT_pb-2CSBtT1y3
    oByx16Xg_CHGMzZfyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rrNLZSQJnA35frWHc7Kf6O8VfD5EfRlONr-ug1RSSbM1-m9-s_qpVA>
    <xmx:rrNLZXuoueW9iCNB4NJ1-7H1rmkOuUGdNWeZvYHA5HodZg2XfvrfQw>
    <xmx:rrNLZbcCE9VblTDWBtZ1s5ad7ruwEXognw_8sZfuFhczyWUB_LV0qA>
    <xmx:rrNLZS5vLRqqvNQRr5UUCoQjgk9pr00jrpwKMENNwGSH1JKvPRPZkw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1F94B60089; Wed,  8 Nov 2023 11:13:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <75a110d5-c544-44b3-8155-ddfadbe1bd88@app.fastmail.com>
In-Reply-To: <25173a48-529c-463b-88aa-2ee75dd604ff@gpxsee.org>
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
 <25173a48-529c-463b-88aa-2ee75dd604ff@gpxsee.org>
Date:   Wed, 08 Nov 2023 17:13:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Martin Tuma" <martin.tuma@digiteqautomotive.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023, at 16:17, Martin T=C5=AFma wrote:
>
> On 23. 10. 23 18:05, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> As this is just a regular device driver, it has no business force-ena=
bling
>> other drivers in the system, it should be entirely independent of the
>> implementation of the spi-nor layer or the specific DMA engine.
>>=20
>
> The drivers are required for IP cores that are used on the card (in th=
e=20
> FPGA). Without I2C_XILINX and XILINX_XDMA the card won't work at all.=20
> Without SPI_XILINX the access to the card's FLASH (used e.g. for FW=20
> changes) won't be possible.
>
> A change to "depend" instead of "select" is thus possible if it makes=20
> more sense to you, but removing it would make the module not compile o=
r=20
> not work at runtime (there is no symbol dependency to I2C_XILINX and=20
> SPI_XILINX, but both need to be present and are loaded using=20
> request_module() at runtime).

Sorry for the delay at getting back to you here.

I don't think there is a good answer here, though I normally
try to only list the minimal dependencies that are required
at build time. E.g. for on-chip devices we don't require the
use of a particular clock/irq/pin/gpio/... controller even if
we know exactly which of those are used on a given chip.

Since this is a PCI device, it's a bit different, so maybe
something like this would work to correctly document which
dependencies are required at build time vs run time:

--- a/drivers/media/pci/mgb4/Kconfig
+++ b/drivers/media/pci/mgb4/Kconfig
@@ -1,15 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_MGB4
        tristate "Digiteq Automotive MGB4 support"
-       depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MTD &=
& IIO
+       depends on VIDEO_DEV && PCI && I2C && SPI && MTD && IIO
        depends on COMMON_CLK
+       depends on XILINX_XDMA
+       depends on (I2C_XILINX && SPI_XILINX) || COMPILE_TEST
        select VIDEOBUF2_DMA_SG
        select IIO_BUFFER
        select IIO_TRIGGERED_BUFFER
-       select I2C_XILINX
-       select SPI_XILINX
-       select MTD_SPI_NOR
-       select XILINX_XDMA
        help
          This is a video4linux driver for Digiteq Automotive MGB4 grabb=
er
          cards.

     Arnd
