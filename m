Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3852A7E7F81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjKJRy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjKJRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:27 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC939743;
        Fri, 10 Nov 2023 06:37:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 056B43200A3E;
        Fri, 10 Nov 2023 09:37:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 09:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1699627045; x=1699713445; bh=rcShLJQwdFk7RsRNeX/c7tzR8HZJvtQVuGp
        bMnSXorU=; b=ejl4Mjlp2pQSGeExypcwTNxzCQO8IJu70TTC8Kj7iX5mlgA2I+1
        Ah0nlJrsJ+kEXHNgFfNOdUsXDBk6IIkkVMpD/aIt1xhb+OCdFXTfaFEnLEV3Uyir
        oKMbSXn3coiZqkAmaNAfIHujPXMfEdLN6+XxhgEopiF8K7xPyU7maQwK1MRsTptl
        a10LC73nvkcbN7fdpfyZJ1piKNsrXnCGtF1zk+B+G3KJtXzuH4RXlC41MKVF/Qpa
        Lod7rCIdQNETyDAXP12nF7honJUFTO9cDbYeW/KglyVj5+h09j95Fea/7c8lWqN9
        RjJNVlaigDJZXxroIiXIuqb0KM6KMeqjtJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699627045; x=1699713445; bh=rcShLJQwdFk7RsRNeX/c7tzR8HZJvtQVuGp
        bMnSXorU=; b=mkAJRz8ihbAnP7FL8q5xk6+4rmo+5X2GNjdExNJVd4CG+PAeZ5j
        K/udUAelOOksx18MGauQCOFHy+6TyiQTKkAJWQFGFtsxYCwgx03jN0UWzfJB04Lj
        TdwjqvhROdFn489Q0hslUQf1FgelecTaTLMH9chvoAVhiiomYYl6z5Z1pHD++1IP
        AAsjFy+/eqveHRD9IXx1lSoBPx/rqJFlCOqRMp6hhGd3hNwthVLv3PuWNgA64dog
        2h3U/ReK7n7Cs81T8NNtOVenpA8ehUGqLjmm/PE0waH7bajbatzVkMwwZWY52HIy
        ySVoN6Nsq80VSn98i0E9R3AEfRHncLdtWgA==
X-ME-Sender: <xms:JEBOZd6CwVfUWQj_21-V4Dki7JL9gUN0AlGZinej3FgM5zfNai0UiQ>
    <xme:JEBOZa5IlqnsuEOQE6fz4i6ZkfRlVgnhwc2ONHZADJOZ9QxwKEv6ioi2wHzN_aMK-
    sd6wQm7XCQ24dPGhfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JEBOZUeeERb75L_fGrTXVE81bjnNfxtcUnyJf31mJ1iyWZFFwcmOuw>
    <xmx:JEBOZWKaC_rdROcG14Lll1CUt5xfi_e10sk8_B8YBhUB8Oz4_sANMA>
    <xmx:JEBOZRKMQG6h6D6YnqZzLSYUbvNnaXhf2VTprYNF5li_r3bdvSDB9A>
    <xmx:JUBOZeFqg4kUEj6SC61u-1UOR1NmzwY1Dk9NDTRLTqeftbFBpxOe3Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C643AB60089; Fri, 10 Nov 2023 09:37:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <2c56410f-2762-4b3c-b37e-e8db75d30560@app.fastmail.com>
In-Reply-To: <49c002db-fb3e-4e2c-adb4-0be05d4b27e6@gpxsee.org>
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
 <25173a48-529c-463b-88aa-2ee75dd604ff@gpxsee.org>
 <75a110d5-c544-44b3-8155-ddfadbe1bd88@app.fastmail.com>
 <49c002db-fb3e-4e2c-adb4-0be05d4b27e6@gpxsee.org>
Date:   Fri, 10 Nov 2023 15:37:04 +0100
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023, at 19:33, Martin T=C5=AFma wrote:
> On 08. 11. 23 17:13, Arnd Bergmann wrote:
>> On Fri, Oct 27, 2023, at 16:17, Martin T=C5=AFma wrote:
>>> On 23. 10. 23 18:05, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>
> On SoCs you probably get a kernel configuration that is missing some=20
> feature but still boots up when you do not select/depend on the exact=20
> controller, but in the case of the mgb4 PCIe card you get a driver tha=
t=20
> does not work at all (The SPI_XILINX dependency could theoretically be=20
> made configurable, but you would lose the ability to flash the correct=20
> FW for the current HW module and the access to the card's serial numbe=
r.=20
> I2C and XDMA are crucial.).

My point was that we do this all the time for things that are
essential: if your clock controller or the irqchip have
no driver, then the camera device won't work, but neither
would anything else.

So in a SoC setting, you really just need to enable all
the drivers for devices on that chip through the .config.

>> Since this is a PCI device, it's a bit different, so maybe
>> something like this would work to correctly document which
>> dependencies are required at build time vs run time:
>>=20
>> --- a/drivers/media/pci/mgb4/Kconfig
>> +++ b/drivers/media/pci/mgb4/Kconfig
>> @@ -1,15 +1,13 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   config VIDEO_MGB4
>>          tristate "Digiteq Automotive MGB4 support"
>> -       depends on VIDEO_DEV && PCI && I2C && DMADEVICES && SPI && MT=
D && IIO
>> +       depends on VIDEO_DEV && PCI && I2C && SPI && MTD && IIO
>>          depends on COMMON_CLK
>> +       depends on XILINX_XDMA
>> +       depends on (I2C_XILINX && SPI_XILINX) || COMPILE_TEST
>>          select VIDEOBUF2_DMA_SG
>>          select IIO_BUFFER
>>          select IIO_TRIGGERED_BUFFER
>> -       select I2C_XILINX
>> -       select SPI_XILINX
>> -       select MTD_SPI_NOR
>> -       select XILINX_XDMA
>>          help
>>            This is a video4linux driver for Digiteq Automotive MGB4 g=
rabber
>>            cards.
>>=20
>
> My motivation when using "select" was to help people using "make=20
> menuconfig" to get the module selected/configured as they will usually=20
> not know that there are some Xilinx IP cores used that need separate=20
> drivers and the menuconfig GUI simply hides the mgb4 option making it=20
> almost impossible just from the menus to find out what has to be selec=
ted.
>
> But when there are reasons, why to chose "depends on" (like various=20
> configurations, tests or the "readability" of the dependencies) than I=
'm=20
> ok with your patch proposal.

The main reason to use 'depends on' over 'select' here is that
mixing the two is a common source of dependency loops that end
up breaking the build. As a rule of thumb, I would use 'select'
only for symbols that others already select, or that are hidden
from visibility.

      Arnd
