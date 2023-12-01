Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6251800E29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379332AbjLAPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379312AbjLAPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:11:36 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99299DF;
        Fri,  1 Dec 2023 07:11:39 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 26A6F5C0074;
        Fri,  1 Dec 2023 10:11:37 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 10:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701443497; x=1701529897; bh=4/nHC1n36ZRohrH97sK4NTzYkpz1AEDEk5q
        SQRNbDpw=; b=M0kwCK5PODM/2YOWYeij2ndRc8ouCshzi8Tl/PsVsd4y5OWGMso
        XpswzNxwP6PZXY1APedcjhWZIKq21U4GWnpSgYprg0mYrfIC6GzXbXnYJ5cndqaC
        a4zlTeZofE6LzfgeAsZnb2gqTcR+8iSyHmXeoF7VS9q6CqwwIZ3LZRGDpIJbUCsp
        uvC+P4hIKP1pszzGiqw7k70EVIsBgO9lNMjqyFlcreo9jyKQJNsZ7SFNfGvG/6a2
        7WfExSh6coXzFIEFhxNJYjvw0aedeHlzPzUovehe9CI5FJUiQI5nDIvYMA1nPxl1
        w6GYtD9/2GY13CRHR6g7x2KTue19BJRKOOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701443497; x=1701529897; bh=4/nHC1n36ZRohrH97sK4NTzYkpz1AEDEk5q
        SQRNbDpw=; b=OGHwpSUuDec00hWSf2v74nIyFFAafTg7S7b0hsNGiIOYxSbxPB3
        gE2vPMsTb0dCQv9QMWcnwTLAp9aLebKi1ma1Uj7PZXkf02HnH5jnfOlIwzTWKZES
        OZwdhnL0XJM7ETj0Yajp0ZSmS2QTie181YArYVwbAPHZWF00AdKvzOe9xZDf+IBQ
        5d8iUCtTcV0xZUQltYOTWtVvrYvBNLExS1xUam9OlDG04O8kYA9VBbNC7amPa0v2
        coNTEP5A1dzP/9ud0O5HyU/+HArC/Dnz6UtTo4fZvZY8d7mRjgsfdC3MWIlc92ce
        L9C47Agh0g/uuAxzO45XEaz3qyFIBV3eybA==
X-ME-Sender: <xms:pvdpZTg7xWyG0ZY-hrelh630n1Nf49ghZhVx3UN3MXFBqAJ6wmUQSQ>
    <xme:pvdpZQCjxPIumSkx4fG5vsOhnTF84aKUNlxfbL8vcPsYozTSGFJqYC8oJVUsCRZwt
    jFTBeKk5SrUrLGqQSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:pvdpZTG_i0NATGFXA0nu9BaL8658hjjcKYRfAeYElUf7qHAB2hiV1Q>
    <xmx:pvdpZQTaVVRp6W8SHMsVGSq8LTh0Ou8Y8TZbVgEufqrjKPSj3V3DxQ>
    <xmx:pvdpZQwwYboNFU9cTp2PvSOsrj7sBuXaW9n_Rq2hvAsCWBaKyzCQfw>
    <xmx:qfdpZcDkHHyARCzh_J9XCw0S2wHpIbF57EEXFUk8mptUvk3cR7LYSA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F41B436A0075; Fri,  1 Dec 2023 10:11:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <f883ed8d-7140-40af-9ebb-cefbd4c40f9d@app.fastmail.com>
In-Reply-To: <fqwkkyt253uvdaj6qlsu67b25qj35ongh4rbxzgzuwnykl36hi@xinsnpcltpgx>
References: <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
 <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
 <2148a67f-bd4f-432e-aa0d-c914a4bd5e0d@app.fastmail.com>
 <xbkplqgv4ipnofk7hp6ws2rkqk4fsjl3y72blcdephoiocolh7@7l5p5efe7yda>
 <bb13c070-bdfe-47ae-afed-a05e1e55bb94@app.fastmail.com>
 <fqwkkyt253uvdaj6qlsu67b25qj35ongh4rbxzgzuwnykl36hi@xinsnpcltpgx>
Date:   Fri, 01 Dec 2023 15:10:13 +0000
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



=E5=9C=A82023=E5=B9=B412=E6=9C=881=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8B=E5=8D=882:54=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Dec 01, 2023 at 12:13:22AM +0000, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82023=E5=B9=B411=E6=9C=8830=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88=
 =E4=B8=8B=E5=8D=887:16=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
>> > On Tue, Nov 28, 2023 at 03:46:37PM +0000, Jiaxun Yang wrote:
>> [...]
>> >
>> >> I'd say the safest option is to use CKSEG0 or TO_CAC here,=20
>> >
>> > I would have agreed with you if MIPS didn't have that special
>> > _page_cachable_default variable which is undefined for some platfor=
ms
>> > and which might be re-defined during the boot-up process, and if
>> > MIPS64 didn't have ioremap_prot() always mapping to the uncached
>> > region.  But IMO updating ioremap_prot() currently seems more risky
>> > than just converting dmi_early_remap() to the uncached version
>> > especially seeing it won't change anything. MIPS64 always have IO
>> > remapped to the uncached region. MIPS32 won't be able to have cached
>> > mapping until VM is available, and paging and slabs are initialized.
>> > So on the early MIPS32 bootup stages ioremap_cache() wouldn't have
>> > worked anyway.
>>=20
>
>> I really didn't get that, using CKSEG0 on 32bit system and TO_CAC
>> on 64bit system won't hurt.
>>=20
>> Something like:
>> #ifdef CONFIG_64BIT
>> #define dmi_remap(x, l)		(void *)TO_CAC(x)
>> #else
>> #define dmi_remap(x, l)		(void *)CKSEG0(x)
>> #endif
>>=20
>> Can help us avoid all the hassle. Since it always ensures we are
>> using same CCA to access DMI tables. We can always trust Config.K0
>> left by firmware in this case.
>
> Please note my only concern is about dmi_early_remap(), not
> dmi_remap(). The later one can be safely left backended by the
> ioremap_cache() method because at the stage it's utilized MIPS32
> version of ioremap_prot() will be able to create any mapping it's
> requested to. The dmi_early_remap() function is called very early with
> no paging or VM or even cache stuff initialized. So currently AFAICS
> it just doesn't work on _all_ _MIPS32_ platform, because
> ioremap_prot() relies on VM and slab being available to have any
> cacheable mapping, which aren't at the moment of the dmi_setup()
> function invocation. Seeing the ioremap_cache() is just a stub on
> MIPS64 which always performs the uncached mapping, it will be
> completely safe to just convert dmi_early_remap() to ioremap() with
> no risk to beak anything. dmi_early_remap() semantics won't be
> actually changed, it will work as before on MIPS64 and will be fixed
> on MIPS32. This (AFAICS) is a completely safe fix of the problem with
> just a few affected platforms around.
>

The only platform enabled DMI in upstream kernel is Loongson64, which
I'm perfectly sure that the mapping for DMI tables *should* be Cached.
It is an accident that ioremap_cache is misused here, so I'm proposing
to replace it with CKSEG0/TO_CAC. Also as per MIPS UHI spec, all the
data passed from bootloader to firmware should lay in KSEG0, please
let me know if your platform is an exception here.

Using ioremap_cache at dmi_early_remap does not sound safe to me as well.
What if DMI code tried to remap something beyond KSEG range at this plac=
e?

The safest option here is just bypassing ioremap framework, which does
not give you any advantage but only burden.

I'll propose a patch later.
--=20
- Jiaxun
