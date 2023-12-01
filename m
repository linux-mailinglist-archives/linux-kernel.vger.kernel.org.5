Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F417FFFFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbjLAANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjLAANg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:13:36 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8110FA;
        Thu, 30 Nov 2023 16:13:42 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DA245C0114;
        Thu, 30 Nov 2023 19:13:41 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 30 Nov 2023 19:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701389621; x=1701476021; bh=6hNLsCFhInh22vC2aH0mgObvwR0nMUCdEXP
        sUGEMxfE=; b=p4TuFmo2BFWKo6nUyzd0VhruEGR7APHOVeHa7t90HtYDDkV2GOs
        WbwD4W+8XGQHFzA6R46rClyZ9uhsApeYU9Bq3qCK8SOAbEH0ByqRIqlcdjEyI9+4
        LxyiFamBQFNzRhGxUmy0PggFnSiP6eH0bMoFtnjor0Jxw2KO97FXc0npahB0MDqx
        wVtXRagjRm3scqpbc//fDJ8vLhjMOfDqJZMpZvh8Osj9a5xJoo4qedI3SECKEzqX
        yA8wjoIYfNuFwD89mweOxyuhcxV/gxq5W004xEYCe92NUWczdo0+u8adnH67fqgD
        JuPP/kpRa3we6p4x8IrsfM+zUIO/TXvFjrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701389621; x=1701476021; bh=6hNLsCFhInh22vC2aH0mgObvwR0nMUCdEXP
        sUGEMxfE=; b=AseeZUAspHBmVT0quRu/fmAKonz1GQGNxx9/2hHz/DOFvlD86Tc
        WSxoaTL/yKw9O64tFfm+I9zOS/vN8FdAwKrKUw4CNwDfJdoBZWldSBgz96c2nGIN
        vY2YNoLDLYX7w7mlimXfIwhfCCcYIyc/MutJhgQLmFnoPvq2vu6oJ6dKfYFE+SKX
        ONJVmDmyPtN+tF8DkvxuvUlN1+2G2Fk1UigU4ZYt/r/1kXau4YGaldnbxInqe2sA
        31hYutAGc2pxbjhnU1B+qqeUd5UqVwQRv7TtXOj+4rjdH3iyCbdGSzlwgNZMRzis
        NYnIUgGwy+ZPjKej0V4+3mmgnqVNtNU3NKA==
X-ME-Sender: <xms:MyVpZQw2ntx0IWqZ6vY3aO4mFFcAiAA14kBj3WQIpjrUkVdxGCX8Uw>
    <xme:MyVpZUTn8Zb9Q9_7HNpgu9EoCv2v-XXBkp9RqYHSDu_topOjNK5WnZ3TFTo4xJcwJ
    oLZVPVRhWM4YgbI1BM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:NCVpZSXo1rzKGpJHv7ZxPno1MBaOYD2Sia_VXrTELi54hAb01HnBNQ>
    <xmx:NCVpZeiBEdnkjummF-m_JEt_ksJok2PYuBHIXWee_vrG2zVD9sGH7Q>
    <xmx:NCVpZSCETlUoggUjmk0WilrRDxcMTWhzWVeokfZC4speaHRiITcmEw>
    <xmx:NSVpZYSmELo37kFV8jvsaU641qYX83T-XPSkU4kw2zViepGpW62x-Q>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD1A836A0075; Thu, 30 Nov 2023 19:13:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1238-g6cccb1fa34-fm-20231128.002-g6cccb1fa
MIME-Version: 1.0
Message-Id: <bb13c070-bdfe-47ae-afed-a05e1e55bb94@app.fastmail.com>
In-Reply-To: <xbkplqgv4ipnofk7hp6ws2rkqk4fsjl3y72blcdephoiocolh7@7l5p5efe7yda>
References: <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
 <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
 <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
 <xbkplqgv4ipnofk7hp6ws2rkqk4fsjl3y72blcdephoiocolh7@7l5p5efe7yda>
Date:   Fri, 01 Dec 2023 00:13:22 +0000
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8830=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=887:16=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Nov 28, 2023 at 03:46:37PM +0000, Jiaxun Yang wrote:
[...]
>
>> I'd say the safest option is to use CKSEG0 or TO_CAC here,=20
>
> I would have agreed with you if MIPS didn't have that special
> _page_cachable_default variable which is undefined for some platforms
> and which might be re-defined during the boot-up process, and if
> MIPS64 didn't have ioremap_prot() always mapping to the uncached
> region.  But IMO updating ioremap_prot() currently seems more risky
> than just converting dmi_early_remap() to the uncached version
> especially seeing it won't change anything. MIPS64 always have IO
> remapped to the uncached region. MIPS32 won't be able to have cached
> mapping until VM is available, and paging and slabs are initialized.
> So on the early MIPS32 bootup stages ioremap_cache() wouldn't have
> worked anyway.

I really didn't get that, using CKSEG0 on 32bit system and TO_CAC
on 64bit system won't hurt.

Something like:
#ifdef CONFIG_64BIT
#define dmi_remap(x, l)		(void *)TO_CAC(x)
#else
#define dmi_remap(x, l)		(void *)CKSEG0(x)
#endif

Can help us avoid all the hassle. Since it always ensures we are
using same CCA to access DMI tables. We can always trust Config.K0
left by firmware in this case.

You may add some sanity check on 32 bit to avoid generating invalid
pointer. (And perhaps implement it as ioremap_early.....)=20

Thanks
--=20
- Jiaxun
