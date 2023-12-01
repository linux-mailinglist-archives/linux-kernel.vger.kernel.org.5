Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9B800A29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378663AbjLAL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378625AbjLAL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:58:51 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452681704;
        Fri,  1 Dec 2023 03:58:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8C3DB3200B3B;
        Fri,  1 Dec 2023 06:58:56 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 06:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701431936; x=1701518336; bh=8sJJAwW3fvcdkz9kiX5KI4PX0G+t1oYo33H
        a8laNn/c=; b=HPwSQPZpYheqxKo/cVLb2867b/LQN0msH+ibE5ne/gQuj5UVeNs
        02/1VeN5bSKLZ1k6cL/wXjekPMSmaptrI+dDSjQyreGxyNMYL8VyvFAUJshzObVR
        gkzKzhu02q0uTUrQIemEARitT5k31eHEGaRdYyU6CZq+PSlHO2CiveOT73RFQdsE
        tY74ABgcfoV+izsicdEaPk3jMLZzzz1tEDZrJjoX+pe8/um5i8EkRsVMZpr5IH8D
        bPcexuExOSX25wsOCtPjnVwc6JeW+SkCCAs+4W9IhvhtqBzmAKyD1XIC9mbfgEfF
        1kOC9i7fgUSBAjmtcH+NTwvqTFJoyQkomvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701431936; x=1701518336; bh=8sJJAwW3fvcdkz9kiX5KI4PX0G+t1oYo33H
        a8laNn/c=; b=S+j2lw6WlSWXH3SDKaNF89IiiJcBVpYtlfCTfsG7bazXs36sxAb
        JkaeWQrIyB40i942Yh0USSGoXHlqjpgp9+K2c9FXTdeYGWWo6etR3SmyDlP0WOlh
        yIwPur7uhfS7oxIcfGXX7htHwygTw/zIu5jn4jrWlG0rfZa7QOCpLHDqH6K27e3X
        aJvlQhW3B0m8Bcg6UqGJOxDqGvIpmP4z/gHsXc3kE+LL0N4DmXERcB4J8D5dV+iF
        GjcVvR3wy0MuK5xP3WNrf7bz2/Cuv7H0JfHMN8GIMFXuyCA4/j7qRCHWJL3tErKY
        ctl5mlTL3OBTOF3SCmJwY5rgj2ybVqSJ5zw==
X-ME-Sender: <xms:f8ppZWKKB_U6erSXSZZkxEpV82pgT4GF0Z7OM_kRXzSXtLto6tCWMQ>
    <xme:f8ppZeIT2PB1Dc70dQNl8XSuC7IaqlcUA9JwP6HtyD67rqD8Q_jMnjZ7VW4E3TdqE
    wQvv_Jz5bJqZAZfEtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeekleevffehtdeigfekfefhffdtudffvdeuvedtffet
    heeuiefhgfetleekleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:f8ppZWvblfWumeKsVl1LnF-jb1YmwTPU1faYssFn-BcWwjPcWb4sjA>
    <xmx:f8ppZbb6d4mAn1l9qF6xz7zNSD0gFyIWMOsZRMHZOppXIR5TQ7o6Vg>
    <xmx:f8ppZdYHYYPZddjRwXu-ReahHkXQV0NALYPBDX2cARAS_2F2w3tQHA>
    <xmx:gMppZeDaXA9FPY4-uPqsETBCn6OjzUqvu--UD3fPPuSMMcHNFn6tXA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD8A036A0075; Fri,  1 Dec 2023 06:58:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <ce132300-e2cc-4966-8dc8-35cf5f6d3f83@app.fastmail.com>
In-Reply-To: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
References: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
Date:   Fri, 01 Dec 2023 11:58:34 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] MIPS: Unify low-level debugging functionalities
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B410=E6=9C=8829=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8A=
=E5=8D=882:53=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,

Hi Thomas,

A gentle ping on this series :-)

I've got too much patch floating out there.

Thanks
- Jiaxun

>
> This is a attempt to bring all low-level debugging print functions
> together and provide a arm-like low-level debugging interface and
> a further function to debug early exceptions.
>
> The plan is to elimiate platform specific early_printk and
> cps-vec-ns16550 by debug_ll and earlycon.
>
> cps-vec-ns16550 is leave unchanged for now due to pending patch[1].
>
> Hope you'll find them handy :-)
>
> Happy hacking!
>
> Thanks
> Jiaxun
>
> [1]:=20
> https://lore.kernel.org/linux-mips/20231027221106.405666-6-jiaxun.yang=
@flygoat.com/
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (8):
>       MIPS: asm: Move strings to .rodata.str section
>       MIPS: debug: Implement low-level debugging functions
>       MIPS: debug: Hook up DEBUG_LL with early printk
>       MIPS: debug: Provide an early exception vector for low-level deb=
ugging
>       MIPS: debug_ll: Add Kconfig symbols for some 8250 uarts
>       MIPS: debug_ll: Implement support for Alchemy uarts
>       MIPS: debug_ll: Implement support for AR933X uarts
>       MIPS: zboot: Convert to use debug_ll facilities
>
>  arch/mips/Kconfig                        |  12 +-
>  arch/mips/Kconfig.debug                  | 212 ++++++++++++++++++++++=
+++++----
>  arch/mips/boot/compressed/Makefile       |   9 +-
>  arch/mips/boot/compressed/dbg.c          |  37 ------
>  arch/mips/boot/compressed/debug-vec.S    |   3 +
>  arch/mips/boot/compressed/debug.S        |   3 +
>  arch/mips/boot/compressed/decompress.c   |   6 +-
>  arch/mips/boot/compressed/head.S         |   6 +
>  arch/mips/boot/compressed/uart-16550.c   |  47 -------
>  arch/mips/boot/compressed/uart-alchemy.c |   7 -
>  arch/mips/boot/compressed/uart-ath79.c   |   2 -
>  arch/mips/boot/compressed/uart-prom.c    |   7 -
>  arch/mips/include/asm/asm.h              |   2 +-
>  arch/mips/include/debug/8250.S           |  60 +++++++++
>  arch/mips/include/debug/alchemy.S        |  46 +++++++
>  arch/mips/include/debug/ar933x.S         |  41 ++++++
>  arch/mips/include/debug/uhi.S            |  48 +++++++
>  arch/mips/kernel/Makefile                |   3 +
>  arch/mips/kernel/debug-vec.S             | 194 ++++++++++++++++++++++=
++++++
>  arch/mips/kernel/debug.S                 | 130 +++++++++++++++++++
>  arch/mips/kernel/early_printk.c          |  19 +++
>  arch/mips/kernel/head.S                  |   4 +
>  22 files changed, 750 insertions(+), 148 deletions(-)
> ---
> base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
> change-id: 20231028-mips_debug_ll-ef9cce16767b
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun
