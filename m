Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223667FAC46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjK0VIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0VIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:08:48 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677219D;
        Mon, 27 Nov 2023 13:08:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F5F35C004E;
        Mon, 27 Nov 2023 16:08:54 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Mon, 27 Nov 2023 16:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701119334; x=1701205734; bh=O7eAZBa/VWWZ/OXR3VR79aB+uaJ9c4U23L/
        jIs+R/4I=; b=OqM1IvhywGfmb7/kGPg8aPxMlu17gR4i5CH9/cqoelecohlYpCR
        /c1Og9aPbItY0RcGuLHayz3h1Mmo51jLTPjledQBGtv7CLQBdtOywUqY3ebesdjh
        w/KgFo9dTiMaWYN65I0ofo05JauvgXGn59f0x6BjzkONfKGyBzpoP6Owy4rButba
        YVA2NRJuSEI+ePvSTkdk4V3idMP6d5l57axFknSG3n+MRxRmc87fsZGMrocrGevy
        /MeOyX413+ioZH7CnQns3dUBQU3yBOoOltb1i1Bs48iNWsKwZ5C/U8Hijrfe7CMb
        C4yY9q8rs0vcpj0rd2e2wARn3LeaEBpgmgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701119334; x=1701205734; bh=O7eAZBa/VWWZ/OXR3VR79aB+uaJ9c4U23L/
        jIs+R/4I=; b=oMtl2vfZKze5RZUv5gkgqJtSL34cqE0nGLzcTGh1dlkFMyNcSYs
        Bps/C/1fM/uMFwg+7atKxp9YinmkIQnzIQ5L29wxAxcacsEwETBDMiC+7amaMbXT
        PceJaJx609MSuf4COEB7azsvh2zagVy0aAxxbTd5fEDm+SsxdCnuiukTrLAIc5Hn
        jnQBi7Pnnqoc6nOi1St+ZKNFQ5wg0gZ3nvuguKV/5wG25Vy5TtwQEmhCCO3Zz+Pl
        J/0YHmxFPThmKOyyza8A75mNqp2TMRHiaRXfmdOKg6SydW+V9YjkKHvYmaEsR516
        lZMKyhcGMuVTBXXq6C7CIE+DsQiVzHXmL7w==
X-ME-Sender: <xms:ZQVlZUlkX5naVSJjUG7a5LlzcDZJbVDTVFLUDiRTQzRwOh8zZmCl8w>
    <xme:ZQVlZT1l-Qo5NEm1acyCQ5WNAgEYgQUNyvojv0R5DW-zh-a0ZgHuuGFQi13uhgHQw
    AZvRlfHcAPUJGxA138>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
    jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ZQVlZSpBwe7Fy4oIQ2uXsQhMR5CRgwHNgR54NHNaXbDK9orhjPgNyg>
    <xmx:ZQVlZQnnbwzhN-1wZLF_yUzVW9q5knGrwaXAd-cJJ9OiR9ANyTdk7A>
    <xmx:ZQVlZS05x9tCsC-yoi2q9V77LnxkssFNeWR1RtT6Yw9mPHuSgl2kdg>
    <xmx:ZgVlZd3C112C-1ZDvi2fs0EzyPbh9HLTILc8Uw5-MetAtKrB_0ao3w>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 14CA836A0075; Mon, 27 Nov 2023 16:08:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
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
Date:   Mon, 27 Nov 2023 21:08:11 +0000
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8827=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=884:23=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
[...]
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
> agree with that. But that's not the point in this case,
>
> A bit later you also noted:
>
> On Fri, Nov 24, 2023 at 10:34:49PM +0000, Jiaxun Yang wrote:
>> A nip, _page_cachable_default is set in cpu_cache_init() as well. We'd
>> better move it to cpu-probe.c, or give it a reasonable default value.
>
> Right. Thanks. To be honest I haven't noticed that before your
> message. _page_cachable_default is indeed initialized in the
> cpu_cache_init() method, several steps after it would be used in the
> framework of dmi_remap_early(). On the other hand ioremap_cache() is
> defined as ioremap_prot() with the _page_cachable_default variable
> passed. So my code will still correctly work unless
> _page_cachable_default is pre-initialized with something other than
> zero. On the other hand we can't easily change its default value
> because it will affect and likely break the r3k (CPU_R3000) and Octeon
> based platforms, because it's utilized to initialize the
> protection-map table. Of course we can fix the r3k_cache_init() and
> octeon_cache_init() methods too so they would get the
> _page_cachable_default variable back to zero, but it will also make
> things around it more complicated.
>
> Also note, moving the _page_cachable_default initialization to the
> earlier stages like cpu_probe() won't work better because the field
> value may get change for instance in the framework of the smp_setup()
> function (see cps_smp_setup()).
>
> So after all the considerations above this solution now looks even
> clumsier than before.( Any idea how to make it better?

I think the best solution maybe just use CKSEG0 to setup map here.

Btw I was thinking about 64 bit here, I thought for 64bit we would
just embedded prot into XKPHYS, however I quickly figure out
ioremap_cache was never implemented properly on 64-bit system,
so does ioremap_wc.

> u64 base =3D (flags =3D=3D _CACHE_UNCACHED ? IO_BASE : UNCAC_BASE);

Which is always uncached mapping.

>>=20
[...]
>
> Note the memory might be clobbered even before dmi_setup() for
> instance by means of the early_memtest() method. In anyway it would be
> better if the system booloader would have already reserved the DMI
> memory (in DTB) or it would have been done by the platform-specific
> plat_mem_setup() method.

Unfortunately, too many machines are shipped with those badly designed
firmware. We rely on dmi_setup code to scan and preserve dmi table from
random location in memory.

>
>> The second is we may have some early quirks depends on DMI
>> information.
>
> Which quirks do you mean to be dependent in between the current
> dmi_setup() call place and the cpu_cache_init() method invocation?

I think we don't have any for now.

--=20
- Jiaxun
