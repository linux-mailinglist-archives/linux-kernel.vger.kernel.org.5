Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6D7F85C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjKXWEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXWEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:04:07 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E77127;
        Fri, 24 Nov 2023 14:04:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C23F5C017F;
        Fri, 24 Nov 2023 17:04:10 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 24 Nov 2023 17:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700863450; x=1700949850; bh=3UtEYHzWi0cxnEeCsISUpA7msvYeRg40USl
        PBvQDAxw=; b=A+OmL5iuR0zReaEYJ15GjQZg4vyIFXItuIFwm5dyiW5T4gkg5vB
        O3y1vEmDpFw4XObQBw8S+hZRpzogyJyTFmhG2+30qmPo4cAzhli//p7Xo0xlYdm1
        HAyMt5+hPPBYMAmiaiJ28TApebpiNxFRXs4GB7HBWyVtBQUMvcn/4s/jVsg/IWws
        XssMoqNkkSUyZUh627dVqhMVg53/fr4mKmvapK+ChgQrurZJBfS4Yc7m/1MQYKc6
        sidfB5JX2x1DmjiQdvNNzsevqfIMP6hcV70YbnA+hZB2vgAekGpuscafQCq3EtT3
        dsfKyA/+zzMUAho0X0+YX3mWlJOpbjr74Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700863450; x=1700949850; bh=3UtEYHzWi0cxnEeCsISUpA7msvYeRg40USl
        PBvQDAxw=; b=twOj/8Jcx0NWHjeF1j6wOPWK7iooNT5JJaNkH43/2QPNogNn/tb
        7JlN9Jgl7OH0//175OqqtGkvZXNETNHDVrjnRTE2dYC2aRe8NS3cBxfRS3TkrgxS
        q9RHfaYXLVDlKtbRO1wccGQQV2UIDnVyL9C45hhb0IlJbfkJO8g+JknA9uHVVwVY
        PnwjCl/fo6dt0YHUl1yy0R1NvLc243cufFp0E0HkrrOwy4AAt69IbDeA1D9IcSv0
        CjrzG+GgyJXkCwAwh2nx0r7aclfam9EFjZ41h4zMGoX7okhqfPOQ8VnxZ9/rU30z
        sSKm3gGHvGJK1CTFz/SuqgqFbC1X6DA4MiA==
X-ME-Sender: <xms:2R1hZeEP-Qfu_lD44kF0vynJRv_jOkRp0wK31dkeBQcDh6VMArK7aQ>
    <xme:2R1hZfUEsjLpj2O6_O2FfsC02yiQuWRn8zKsLKb16P3l1xqfj1ZCOAIHkvRvrHXxN
    W-oMKMGiEjfnWlMH4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
    jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:2R1hZYKSfIWn3srG8g6clC1T-aBuI_9Dy4LS8Fjp_HUYvl4PupGy1g>
    <xmx:2R1hZYGZZtLwimW36tNIPwr80vH8poDSidykKLzWJ5r7mHHsMl19Xg>
    <xmx:2R1hZUUGyWDk5U_RlDqNGfgQFao_DevH2gcEuZkc4RMYG8Qx9imfVg>
    <xmx:2h1hZZW_hIY8W3fNySOV5R3_nIwDz8z16cSKf7eYADPCHKObnO6CuA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0886F36A0075; Fri, 24 Nov 2023 17:04:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
In-Reply-To: <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
Date:   Fri, 24 Nov 2023 22:03:49 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8824=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=886:52=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Nov 23, 2023 at 05:33:31PM +0000, Jiaxun Yang wrote:
>>=20
[...]
>> Actually dmi_setup() is called before cpu_cache_init().
>
> To preliminary sum the discussion, indeed there can be issues on the
> platforms which have DMI initialized on the cached region. Here are
> several solutions and additional difficulties I think may be caused by
> implementing them:

Thanks for such detailed conclusion!
I'd prefer go solution 1, with comments below.
>
> 1. Use unmapped cached region utilization in the MIPS32 ioremap_prot()
> method.
> This solution a bit clumsy than it looks on the first glance.
> ioremap_prot() can be used for various types of the cachability
> mapping. Currently it's a default-cacheable CA preserved in the
> _page_cachable_default variable and Write-combined CA saved in
> boot_cpu_data.writecombine. Based on that we would have needed to use
> the unmapped cached region utilized for the IO-remaps called with the
> "_page_cachable_default" mapping flags passed only. The rest of the IO
> range mappings, including the write-combined ones, would have been
> handled by VM means. This would have made the ioremap_prot() a bit
> less maintainable, but still won't be that hard to implement (unless I
> miss something):
> --- a/arch/mips/mm/ioremap.c
> +++ b/arch/mips/mm/ioremap.c
>         /*
> -        * Map uncached objects in the low 512mb of address space usin=
g KSEG1,
> -        * otherwise map using page tables.
> +        * Map uncached/default-cached objects in the low 512mb of add=
ress
> +        * space using KSEG1/KSEG0, otherwise map using page tables.
>          */
> -       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr) &&
> -           flags =3D=3D _CACHE_UNCACHED)
> -               return (void __iomem *) CKSEG1ADDR(phys_addr);
> +       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr)) {
> +               if (flags =3D=3D _CACHE_UNCACHED)
> +                       return (void __iomem *) CKSEG1ADDR(phys_addr);
> +               else if (flags =3D=3D _page_cachable_default)
> +                       return (void __iomem *) CKSEG0ADDR(phys_addr);
> +       }
>
> Currently I can't figure out what obvious problems it may cause. But
> It seems suspicious that the cacheable IO-mapping hasn't been
> implemented by the unmapped cacheable region in the first place. In
> anyway this solution looks more dangerous than solution 2. because it
> affects all the MIPS32 platforms at once.

I just made a quick grep in tree, and it seems like we don't have much
user of ioremap_cache (as well as ioremap_uc/wc) here so I think it is
a safe assumption.

>
> 2. Convert dmi_remap_early() to ioremap_uc() (actually just ioremap()
> as noted by Arnd).
> As Jiaxun correctly noted this may cause problems on the platforms
> which don't flush caches before jumping out to the kernel. Thomas said
> that kernel flushes the caches early on boot, but Jiaxun noted that
> it's still done after early DMI setup. So the issue with solution 2 is
> that the setup_arch() method calls dmi_setup() before it flushes the
> caches by means of the cpu_cache_init() method. I guess it can be
> fixed just by moving the dmi_setup() method invocation to be after the
> cpu_cache_init() is called. This solution looks much less invasive
> than solution 1.

I recall Tiezhu made dmi_setup() here for reasons. The first reason is t=
hat
DMI is placed at memory space that is not reserved, so it may get clobbe=
red
after mm is up. The second is we may have some early quirks depends on D=
MI
information.

Thanks.
>
> So what do you think? What solution do you prefer? Perhaps
> alternative?
>
> -Serge(y)
>
>>=20
>> Thanks
>> >
>> > Thomas.
>> >
>> > --=20
>> > Crap can work. Given enough thrust pigs will fly, but it's not nece=
ssarily a
>> > good idea.                                                [ RFC1925=
, 2.3 ]
>>=20
>> --=20
>> - Jiaxun

--=20
- Jiaxun
