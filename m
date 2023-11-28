Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3248B7FC1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbjK1Pq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346059AbjK1Pq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:46:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8810CA;
        Tue, 28 Nov 2023 07:47:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E73785C01AB;
        Tue, 28 Nov 2023 10:46:57 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 28 Nov 2023 10:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701186417; x=1701272817; bh=vQ2DpM/PgnVcF0UkIV4NW3voay3Ssm0FPmS
        eIIJAMzQ=; b=EwToAO3VFs+JL4f3zp125iNCKmBpnz9Rtd5S3ATvpNIxrrjOGdd
        HeXXhc1bYQ15IZRYtOQiC0T/6J5Rff3RTYzPPQitwOmfRO+624cK9MlgOStYYRrx
        MkxDXPFQ+aPrDgQJnyDQp4DTfxrMawTTGT4sShXgrzbZOprA4Ib5VeGYu3eB07OJ
        I+qDLX7repSisScrW6pM94bBAp/AX9viq2faN7SKUuuAkHiTXNraJ0/6P6iJeXnO
        NBkNaa9MJiJRfoPc9hDuoZR0ZJPtHkWOzs7qBCL/RT1qbW5Mf1gMfDcTs/P4aqx+
        djxJ3m+akqjLmIbb0LkqNvMaUjD6Az/3mIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701186417; x=1701272817; bh=vQ2DpM/PgnVcF0UkIV4NW3voay3Ssm0FPmS
        eIIJAMzQ=; b=uj/ia7ZObmuU9t+KLKPaQRcYi6+y4krZxl8PvB1ODVSbLQXyUPY
        pHF71eJu272E89Ilvh8GOaVd0P1sbBWZpNxWfq/LVj/tNz2VjZDCTO9Qg9FVnMF8
        JqTG6MMzhnhQb637cX1x9Lzc5al8JfHD7wwJ5EafNOnfo7LL5krM09SAecz4SIRP
        fyJQC0Wx60j902L5vYuInt1tgafLVj2i3swVR6OGOESddtla8UY9vUBJwW+W5lyK
        RgscyL46lg7LPt1Z0It01P+pZ7FdxWZwzPyDFLksO/nLNKCkBszhAp8tPZTnhUl7
        OUvl6Kj1TRyLSQY2gUZD11NpizCPQqkfaWw==
X-ME-Sender: <xms:cAtmZT868MyLQcyaJkV4Z3hNmwOdjgxXAhEP5_fuE0FKOAylzaWi8A>
    <xme:cAtmZfuCp7Khgv0-06NuLpEwO86_BPrL8QivMV6Movr3qLKIm3Sr00JaRuge-XJxE
    MNqDIerHU4-Kla-kk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:cAtmZRCfxPEot79W_Qng72g064LfB0EGhQmZojuJsZD_clZJI7UIOg>
    <xmx:cAtmZfeFQ1-YT6912JkFLLMvpNwcsCDXsNO39OR7fcqIbDsOvVqvjA>
    <xmx:cAtmZYO4EyiRTcLnCqIeiL7BJZtMsq7yKaCBJwlv1UJHcRZX4OMXzA>
    <xmx:cQtmZdt1NS09rr4NiIzhz4dusles9XjNcYdmhGZuRpBJDVSQq498qg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9EE0236A0075; Tue, 28 Nov 2023 10:46:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
In-Reply-To: <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
References: <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
 <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
Date:   Tue, 28 Nov 2023 15:46:37 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Serge Semin" <fancer.lancer@gmail.com>
Cc:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Yinglu Yang" <yangyinglu@loongson.cn>,
        "Alexey Malahov" <Alexey.Malahov@baikalelectronics.ru>,
        "Aleksandar Rikalo" <aleksandar.rikalo@syrmia.com>,
        "Aleksandar Rikalo" <arikalo@gmail.com>,
        "Dragan Mladjenovic" <dragan.mladjenovic@syrmia.com>,
        "Chao-ying Fu" <cfu@wavecomp.com>, "Marc Zyngier" <maz@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mips: dmi: Fix early remap on MIPS32
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8828=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8A=E5=8D=8811:34=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Nov 27, 2023 at 09:08:11PM +0000, Jiaxun Yang wrote:
[...]
>
> Indeed. Thanks for pointing that out. In the last days several times I
> was looking at that line and for some reason UNCAC_BASE seemed as
> CAC_BASE to me.) Based on what both IO_BASE and UNCAC_BASE are defined
> as of the uncached region anyway, then it should be safe for any
> currently supported MIPS64 (including the Loongson's) to use ioremap()
> in place of dmi_early_remap(). So basically my current patch in the
> subject won't change the method semantics. Let's not to try to fix a
> problem which doesn't exist then, and keep the patch as is especially
> seeing that the alternatives might still cause some troubles. Will you
> be ok with that?

I'd say the safest option is to use CKSEG0 or TO_CAC here, but I'm fine
with ioremap as long as the semantic remains uncached on Loongson.

Thanks.
>
> -Serge(y)
>
>>=20
[...]
--=20
- Jiaxun
