Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E007F863B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKXWep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjKXWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:34:43 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0D810FB;
        Fri, 24 Nov 2023 14:34:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B2D45C0166;
        Fri, 24 Nov 2023 17:34:47 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 24 Nov 2023 17:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700865287; x=1700951687; bh=cITV9NLe1Pev7AShBkoPVTITzs2wGg66LfU
        zxkV4dXM=; b=nAweOz3YwxiIka2d6mBZi72XfvT5fH4r2Kvp5bjWDssH5B7/WQG
        rWiH/RAOnu6iEeBIC/xYOWuMHfmjl+wnwMMy7nKVWkmbCzZmxH3vDuiohM420y8f
        e/8cfeh1yasAJK377PKz9Lb+dbjKJdcm/0KchHKL0+y3G3JGj0kNwlBtadiR5ZKK
        3QfYr1NwntuSTFY1MIG8eF4BlQsSFGJRiyRxYKv2ryw/O0utvFQZtFITVOUaEfn+
        lQWEanNIC8n/jkTzuoPcwNohWDAq8Lk5LOZERTNWN4jjSWxSf/p/aWD5zobK+qXJ
        znrMZgMIgOSnUR0twQVz1M9D6R0K8J9FPow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700865287; x=1700951687; bh=cITV9NLe1Pev7AShBkoPVTITzs2wGg66LfU
        zxkV4dXM=; b=puCY3FCl1l9FvNkLfYz8HwXlbCtsSO2dTM/iWlQar5cBvJG0LxX
        aboAkH81lwqsw5AsOLtP/mW7ljddsSmAjpxkzxSqR1npeMOzf6ycDL8/VmxLR0T8
        crXqUyFqioArjymhfniTSWNTGTgXYWdpKfCtFpi9DkWtnhVh6/OudQeHpkTKSjLO
        5btgHs04lbsNLTh+uh+H6st73KSvJleGOLrSpXTQsR3XdjfHHb600HDZuZJ/Tdj5
        gyVoF6sB1pcdcHVTXhbdivIYJcSz7HvgbAGhcw2mJ9g6dQMACcskQO4tZD1Xf3M+
        gTD27hVfjnXLiLQQjHGyNPLmbtGtKdspd3Q==
X-ME-Sender: <xms:BiVhZeZiSB-I_EzpPEQq_lTAkJ1dfnWPyrDZvU420HWToRzUzR8GaQ>
    <xme:BiVhZRbcqkIAuKT-cpfZWGEY6VznW954HVpc1FqUh7MhVq5zC1P_tOeyaQq57D9vZ
    J-5LFarcXp0eqhVznk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:BiVhZY_RI9QOa7r3b2KOMLYJuIP0KfQMES-lkT-2KT_wpiU7JDHrig>
    <xmx:BiVhZQogPvi0sj2ULCi0NKu4Wp3VXnc-_jzPbtfikeC_Q0hi2BQobw>
    <xmx:BiVhZZpkuPS0SK9F9HkSeqcGksmiClcyJevUusVKycb69nZopSB95g>
    <xmx:ByVhZRYMckm-pDYFfCiUlGOaeaoXydTXGvPO3wbch1k8zryO85P_pQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9237536A0075; Fri, 24 Nov 2023 17:34:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <7040f3a6-64f4-4110-9bf6-e65db85ea034@app.fastmail.com>
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
Date:   Fri, 24 Nov 2023 22:34:28 +0000
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
>>=20
>> =E5=9C=A82023=E5=B9=B411=E6=9C=8823=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88=
 =E4=B8=8B=E5=8D=884:07=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=
=BC=9A
>> > On Thu, Nov 23, 2023 at 03:07:09PM +0000, Jiaxun Yang wrote:
>> >>=20
>> [...]
>> >
>> > the problem with all 32bit unmapped segments is their limitations in
>> > size. But there is always room to try to use unmapped and fall back
>> > to mapped, if it doesn't work. But I doubt anybody is going to
>> > implement that.
>>=20
>> Yep, I guess fallback should be implemented for ioremap_cache as well.
>>=20
>> >
>> >> >> AFAIK for Loongson DMI is located at cached memory so using ior=
emap_uc
>> >> >> blindly will cause inconsistency.
>> >> >
>> >> > why ?
>> >>=20
>> >> Firmware sometimes does not flush those tables from cache back to =
memory.
>> >> For Loongson systems (as well as most MTI systems) cache is enable=
d by
>> >> firmware.
>> >
>> > kernel flushes all caches on startup, so there shouldn't be a probl=
em.
>>=20
>> Actually dmi_setup() is called before cpu_cache_init().
>
> To preliminary sum the discussion, indeed there can be issues on the
> platforms which have DMI initialized on the cached region. Here are
> several solutions and additional difficulties I think may be caused by
> implementing them:
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
A nip, _page_cachable_default is set in cpu_cache_init() as well. We'd
better move it to cpu-probe.c, or give it a reasonable default value.

Thanks
--=20
- Jiaxun
