Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075C279EA79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbjIMOIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjIMOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1D19B1;
        Wed, 13 Sep 2023 07:08:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 027BB5C01DF;
        Wed, 13 Sep 2023 10:08:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 10:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694614124; x=1694700524; bh=zfvZBncMMU2YSvF8BUaOv/NK0XFFKo70iWy
        d6Cf7xKA=; b=mIsTU+Vay1BOgsSssEi9pxqX8d5xjC2FAs0wEWGO6ZUo2g7XGQ2
        tdveal2n+J7T+8kCLJa/w1DI6ggOWzeBtSHYCTw9BPHWy+oebP7+E7QhiFwrni3K
        oQUJjYaY7LZuftI86fVOooWFakp5Oa9wfA/FTfpNqZC/wrJI6Wd0PadD/lzwNfgz
        hVTsPrdiErVsIUtA5fVNRxU/NN+UrFnP1LyaI44V01KCgdJltDegaEgzmIY4urVx
        Gd8mHwiCSnXBV4v5ZWq+KLSZ6/nitS+h2OsrwXNpRz7Pl856YVBBObJhwJGGO4o0
        cxeWXfhV+ypMsBQoflNrghozpNlRZeCNqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694614124; x=1694700524; bh=zfvZBncMMU2YSvF8BUaOv/NK0XFFKo70iWy
        d6Cf7xKA=; b=CDD267g20qfHMUwkKynraI/D+GMQKjjYBbBkySm+B0gaYPgN31R
        c1wsnopuAmZw4zrVA+C1eHCxSCBaJP3Q6BWuDUHd1u4oj5C7+7+4aKWDEiSTySol
        poy5SA/ijkT7TKjLMqcilvyQRbgDWPoi0zkQwYpWKNfMRcHoiT1qeJKvFhf8tXjT
        CUGKuhS7rKEFVVuvO0corSteXY8xRsnb3xppaOVUZfssuZWD9Z1UzKsOpzKqzOU6
        9uKK6vqGZPNPPpDVhs2dEGvjilJEsbE3ynIrJmBFFEQQC2EbXDFjhwYgyUQ9vl6G
        bgwEqbo7kCsHCPkcmF/52Zm7ZY5pC9yy4Og==
X-ME-Sender: <xms:bMIBZamlhTi-8sXNxckLiMjxdz0sUVZA2AfbDWFBFn2eS47nD7lz_Q>
    <xme:bMIBZR17f7GU2-RLWWBTgNMfyK_mzX0nxXwnu7kmqhu1_RHTGZOeko-H6UD9QYIJF
    pRnsSjHJIu3wJqBWa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bMIBZYrR_7eUvsOPuQgj0_Hayh0rYpBTxAArvCpo4h8ukZwO4xC1OA>
    <xmx:bMIBZemfSUrrprzMjv_PzTxDBN679MuTpwvX6cODFVKm8ASMKuIzUg>
    <xmx:bMIBZY0wFHylEvtf6-B15yCAajVg2A2wliNxvg96kTuiXky5IzmuVA>
    <xmx:bMIBZbSqafD-EyKimLawZYZjVvncvzhMb_S5_ra_otgdU_JtEXDysA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48B49B60089; Wed, 13 Sep 2023 10:08:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
In-Reply-To: <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
References: <20230802184849.1019466-1-arnd@kernel.org>
 <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
Date:   Wed, 13 Sep 2023 16:08:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "Rich Felker" <dalias@libc.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 14:32, Geert Uytterhoeven wrote:
> On Wed, Aug 2, 2023 at 8:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> These functions were only used on the microdev
>> board that is now gone, so remove them to simplify
>> the ioport handling.
>>
>> This could be further simplified to use the generic
>> I/O port accessors now.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>> --- a/arch/sh/include/asm/io.h
>> +++ b/arch/sh/include/asm/io.h
>> @@ -181,7 +181,7 @@ static inline void pfx##out##bwlq##p(type val, un=
signed long port)  \
>>  {                                                                   =
   \
>>         volatile type *__addr;                                       =
   \
>>                                                                      =
   \
>> -       __addr =3D __ioport_map(port, sizeof(type));                 =
     \
>> +       __addr =3D (void __iomem *)sh_io_port_base + port;           =
     \
>
> Note that this adds unconditional users of sh_io_port_base, while
> sh_io_port_base is provided by arch/sh/kernel/ioport.c, which is
> currently only built if CONFIG_GENERIC_IOMAP=3Dn.
>
> This is not a problem yet, as the final part to enable GENERIC_IOMAP
> on SH never made it upstream.  However, Sato-san's series enables
> GENERIC_IOMAP for SH_DEVICE_TREE=3Dy builds, leading to a link failure.

Do you have a link to that series? I don't understand why you'd
want to enable GENERIC_IOMAP on sh, given that its PIO accesses
are always memory mapped in the end.

Is this needed for the trapped_io CF stuff?

       Arnd
