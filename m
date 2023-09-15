Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A127A22F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjIOPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjIOPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:50:07 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B692105;
        Fri, 15 Sep 2023 08:49:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3DA855C017D;
        Fri, 15 Sep 2023 11:49:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 15 Sep 2023 11:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694792996; x=1694879396; bh=dpwVB3lD/aiImh0hE2EWGFv+6Vhj1x0vioh
        vXWOOU5A=; b=NfLQ4W31pMO8GlVfcOfFIDHyG6dI5YF7Ld2vPBUF9ux6dQRb/iu
        mXZ3fmY4qYhZriv9sMrb1OSG8wy5liAjsTf+r9Hyt+IMnMMNazexruACDO27UEET
        kRfwOvzte584qka3xmh/WVsjvY4EDfccg07dVPqlWYqVeBT7HZPckQ/Fu8gVtExA
        02opGgGPISPar/V5FaRfd7MV8vJGTAg5bwn0UlLystAH0jFa1OICSbn8fipNr5Lx
        /LqTVi+vCHh6C+QfOdsmzyYqd4A4G1j9LJNd7YD5pxCpQG7wsm6yCuKeN6nLFNKX
        IuBvjSAoA3LcAv2n5Am1Oy6zEXoLy4RTlAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694792996; x=1694879396; bh=dpwVB3lD/aiImh0hE2EWGFv+6Vhj1x0vioh
        vXWOOU5A=; b=HKnbloQU1VSTccpNbE1a3nhB/ArsoCJqzJDkCkPZVJeIUr+mz45
        +buxm3P08nGo5Sj7RzXcUhK1gPpLnACJMTux9GH1qf9wov6xXnM20rM/OwJ451dR
        9EiBpihjPCMYEjNJdkE34o1Hz/SvG2Q3AHkQdAV3E3LFkRKJUWsZ31IMgpfVrnki
        IxRHJV0Raf/CMxBb4CIyikYzG+XibbDkarFhvwVPhkb4DfVAONlqu+rQ3HSmxIt0
        p/oeGiOGVuid2np4fQrDbWTex4X3izTNFQigE0FzUB5vgFPePxXQ8Rm0csvx9Z2L
        todm/INuZIJ4HkrXdFWwGC066nIvzHeXQTg==
X-ME-Sender: <xms:I30EZUQ1ee7uztWcF9bI1KP-7DbIQ_kjrAw9S051MLcIIZZwu7ED3Q>
    <xme:I30EZRziHMq9V9d1kjespXijDlR1YIeG6HBG51sfcDyGwNJeNDWxviaIWfVel2eLM
    uz2_mwoQeAXYRUK9Xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:I30EZR3GobLkagyT1KT1UhuNGvZ9vZC7VJ4LKJk2t36x75jVYyV9sw>
    <xmx:I30EZYDUfnRP74gWnXABcXf7-GhCKJ6K1bpLR5VliNUcMdBmOgs9Sg>
    <xmx:I30EZdg-L68zRe6ACM3Y0ilTfxptdNyRoEb9QxOfHUH2YA1fePRXFA>
    <xmx:JH0EZdfqSCiAbfcvuMOqvnGPBc4Qr-jkhYn7LLgVqkUeUIf9ffAarQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BB664B60089; Fri, 15 Sep 2023 11:49:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <d2f5cdc1-4bff-4f1d-a7b2-38eee6a6a86d@app.fastmail.com>
In-Reply-To: <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
References: <20230802184849.1019466-1-arnd@kernel.org>
 <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
 <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
 <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
 <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
 <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
Date:   Fri, 15 Sep 2023 17:49:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "Rich Felker" <dalias@libc.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023, at 17:41, Geert Uytterhoeven wrote:
> On Wed, Sep 13, 2023 at 4:30=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Wed, Sep 13, 2023, at 16:13, Geert Uytterhoeven wrote:
>>
>> Right, it looks like the GENERIC_IOMAP part if gone from that
>> series, and I also see that the PCI host bridge does not actually
>
> No, 02/30 still enables it.

Ok.

>> map the port I/O window. That's usually fine because very few
>> drivers actually need it, and it also means that there should be
>> no need for GENERIC_IOMAP or the simpler alternative.
>>
>> The first version probably only did it accidentally, which is a
>> common mistake, and I think the ones for hexagon, m68k, and
>> mips can probably be removed as well with some simplifiations.
>
> When not selecting GENERIC_IOMAP in v2, the build fails with:
>
> sh4-linux-gnu-ld: lib/devres.o: in function `pcim_iomap_release':
> devres.c:(.text+0x234): undefined reference to `pci_iounmap'

Odd, that one is provided based on CONFIG_GENERIC_PCI_IOMAP
and should be provided by common code, despite the similar
naming this is unrelated to CONFIG_GENERIC_IOMAP.

    Arnd
