Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6503F7FBA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjK1MmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjK1MmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:42:09 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C010DC;
        Tue, 28 Nov 2023 04:42:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 830725C015A;
        Tue, 28 Nov 2023 07:42:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 07:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1701175334; x=1701261734; bh=Ue6oReQLoZ5Oz8hCPsHTLUlG6EjRwmqut/I
        46LFQnpk=; b=xv5DXXzqPoGR20U+yXYQPN2++85NxKAgeM/vF6pFQNuDkC0wBPW
        Yq+pnW45hZjQNbnyE3nOdKIjoJCsgR4QBn+d/+GuuoR/pts468sgBSCvVl8906d+
        3CbPa0sVI5a54PaRKBeCTzWUekfNbx60CnuWd3CyoLf8ROv5lxj/WsfKJPbkI4YQ
        YLwmpTUM5MIPqj8FvkwNr2WR4a9wLw2dKdRl8p84/B3he+JfKBpR5OVjxbQNnuYR
        MubfJCxk5BfCzy1E7+uLPh8fsfk08vRc65I+4ZzLYySiSjiwFgee4hebHLNL575i
        HegOUsGzTU/2ZUoxf2nCE89p/oZ4P/RcgwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701175334; x=1701261734; bh=Ue6oReQLoZ5Oz8hCPsHTLUlG6EjRwmqut/I
        46LFQnpk=; b=CS+dsxwk8PJI5KpTR1LLt4P/a76kqkvG6LmdCkVC5ME7ucKQcAy
        IATnEs5LUhkc/SYVEIxJAc0eM8nNuw9TH99tr3Q8XcLK3aoeR9t9/fXzZYnyUcRA
        ld3ic+aTVTaU4MVdm6yXNjCyjS+LjCfrOdjhr4KlcyPVshu3QfkdhZNu7uWm5gVR
        0j2SUbPzHhLoXU6OytgZbfxWAwuYCEEDeLxEn2XMMNZdxYYNF7YDjOQLfSHdOOWB
        WxwPIaiMmFLJL+HLagGVv+BPT7E/PLkaOj7WlIliaWvV2z3cEF4989wULiAHDDAl
        HR0SiqzCTWoO5LPO7D0VaFpiOBnSu3tjgtQ==
X-ME-Sender: <xms:JOBlZUbsAsiYofOGBUmO3Hlz87VtnWvlpN8So4SDnbOXnqK9GUpd1g>
    <xme:JOBlZfaZA5Z1_sNrISFrPCtovu1EJzw-tdcx4l-15zoY-_nqsEuYQLOO0E7A_dYRM
    Rix7xq5vLnJG0CLBU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JOBlZe_pA1ZeeH9E0uiSNI7FpTJLDLKOLwTCVAfXmhr9mX5DwnktkQ>
    <xmx:JOBlZerADlPP31FQjRkZnDTBGXVDHP3mUT5iLlJt4VhtMb_s_ev1qA>
    <xmx:JOBlZfojlp7_Au0EjMcJ2m3c-28RIQ0hkwP7Q89TpQ7_PbRIidtgLQ>
    <xmx:JuBlZfbdil0sdfTt-NP-8WB-demoaN5LJ7X6DOP7yOuH_Ijd_8TZlw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96C34B6008D; Tue, 28 Nov 2023 07:42:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <c1c0a409-902e-4609-ae84-8939226b4fa0@app.fastmail.com>
In-Reply-To: <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
References: <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
Date:   Tue, 28 Nov 2023 13:41:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>
Cc:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023, at 17:23, Serge Semin wrote:
> On Fri, Nov 24, 2023 at 10:03:49PM +0000, Jiaxun Yang wrote:
>> =E5=9C=A82023=E5=B9=B411=E6=9C=8824=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88=
 =E4=B8=8B=E5=8D=886:52=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
>> > On Thu, Nov 23, 2023 at 05:33:31PM +0000, Jiaxun Yang wrote:
>> >>=20
>> [...]
>> >> Actually dmi_setup() is called before cpu_cache_init().
>> >
>> > To preliminary sum the discussion, indeed there can be issues on the
>> > platforms which have DMI initialized on the cached region. Here are
>> > several solutions and additional difficulties I think may be caused=
 by
>> > implementing them:
>>=20
>> Thanks for such detailed conclusion!
>> I'd prefer go solution 1, with comments below.
>> >
>> > 1. Use unmapped cached region utilization in the MIPS32 ioremap_pro=
t()
>> > method.
>> > This solution a bit clumsy than it looks on the first glance.
>> > ioremap_prot() can be used for various types of the cachability
>> > mapping. Currently it's a default-cacheable CA preserved in the
>> > _page_cachable_default variable and Write-combined CA saved in
>> > boot_cpu_data.writecombine. Based on that we would have needed to u=
se
>> > the unmapped cached region utilized for the IO-remaps called with t=
he
>> > "_page_cachable_default" mapping flags passed only. The rest of the=
 IO
>> > range mappings, including the write-combined ones, would have been
>> > handled by VM means. This would have made the ioremap_prot() a bit
>> > less maintainable, but still won't be that hard to implement (unles=
s I
>> > miss something):
>> > --- a/arch/mips/mm/ioremap.c
>> > +++ b/arch/mips/mm/ioremap.c
>> >         /*
>> > -        * Map uncached objects in the low 512mb of address space u=
sing KSEG1,
>> > -        * otherwise map using page tables.
>> > +        * Map uncached/default-cached objects in the low 512mb of =
address
>> > +        * space using KSEG1/KSEG0, otherwise map using page tables.
>> >          */
>> > -       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr) &&
>> > -           flags =3D=3D _CACHE_UNCACHED)
>> > -               return (void __iomem *) CKSEG1ADDR(phys_addr);
>> > +       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr)) {
>> > +               if (flags =3D=3D _CACHE_UNCACHED)
>> > +                       return (void __iomem *) CKSEG1ADDR(phys_add=
r);
>> > +               else if (flags =3D=3D _page_cachable_default)
>> > +                       return (void __iomem *) CKSEG0ADDR(phys_add=
r);
>> > +       }
>> >
>> > Currently I can't figure out what obvious problems it may cause. But
>> > It seems suspicious that the cacheable IO-mapping hasn't been
>> > implemented by the unmapped cacheable region in the first place. In
>> > anyway this solution looks more dangerous than solution 2. because =
it
>> > affects all the MIPS32 platforms at once.
>>=20
>> I just made a quick grep in tree, and it seems like we don't have much
>> user of ioremap_cache (as well as ioremap_uc/wc) here so I think it is
>> a safe assumption.
>
> I wouldn't say there aren't much users. ioremap_wc() and it's
> devm-version is widely utilized in the GPU and network and some other
> subsystems. ioremap_cache() isn't widespread indeed. In anyway even a
> single user must be supported in safely calling the method if it's
> provided by the arch-code, otherwise the method could be considered as
> just a bogus stub to have the kernel successfully built. I bet you'll
> agree with that. But that's not the point in this case.

ioremap_wc() is useful for mapping PCI attached memory such as frame
buffers, but ioremap_cache() is generally underspecified because the
resulting pointer is neither safe to dereference nor to pass into
readl()/writel()/memcpy_fromio() on all architectures.

There was an effort to convert the remaining ioremap_cache() calls
into memremap() a few years ago, not sure if that's still being worked
on but it would be the right thing to do.

     Arnd
