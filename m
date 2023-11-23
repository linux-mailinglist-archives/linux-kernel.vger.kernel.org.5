Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F37F6250
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjKWPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbjKWPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:07:27 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD4D53;
        Thu, 23 Nov 2023 07:07:33 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D34533200A4E;
        Thu, 23 Nov 2023 10:07:31 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 23 Nov 2023 10:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700752051; x=1700838451; bh=X/lvfODLkYobGVtfoM+oBWnEQdkIpHU91tC
        LuqhExcI=; b=t0o7gR2dKbPVO1diBMkzttpAPS2FZmFRwLCUtWNHFWhCGG50LoP
        idbbRaBFlg5lRkgh9fyF4CCRpaJCzM8z6jl/YwczPmg6KF0Hfr9NHEdAjIumnMpU
        /7hxUbvB3km+Ow1/O0YvkLCffbZS4mZtPQfW1Afj4hCVr5jbSahNzlV0Rm8i20ty
        Q6DEz3TVHRNhCdJVBajXpNVzjK0jyhQ31pWToLmHD+HlP87+WOBo1lZ4FTRTWcR5
        m38pOhBYBbVSPX3TUUpyZ4GQuOLRuQcjVvRHO8EVtA3qQ+WxPZsoP6BpVuAS56hD
        ni0iH017biH8q9dMuR4TxlbuPaKNyvTLJCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700752051; x=1700838451; bh=X/lvfODLkYobGVtfoM+oBWnEQdkIpHU91tC
        LuqhExcI=; b=Mg9KPeaG4Nx/8L0mF8C6G4ngmewDvngpBHcBH+sxMi/4qGulgyM
        +JgAF+7nzekrOixh8g4WQIaNAh4HnDuheQY8zDd3lCsFDpgY0OhL0Vn1HfsFffVR
        dF7aPWinRyb/2bJAthouaGekpPbOq0c6QiqjPb6kLPhd6/PUleaVM6biwIFR4pWb
        H4puBJ4aJDMEq1/0W8fs8yWReibJZ2cn3u6MEBHtcK047Czbv5wcfGXXhdtaYLMZ
        X2nmenpuK7Q392ddctKK5IiGyZiEvNUpLygnM/huhnkl+LcBOZzqPTksYJVQEROk
        6xjDhYcTRrT2UgRSoGvrek4fB8QRLXULjbQ==
X-ME-Sender: <xms:sGpfZc-RJ4Kj7LQyhCU7aSl2ieBbGLgQItyLcR7K6EjybboN6DbSMA>
    <xme:sGpfZUsroyytWJdp7638wDG2Wksmsxk7dJOhDGUPY4HFPZans5IjGTFrDtfTQ-9br
    wPQvVW1-6P_TVxGIS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:sGpfZSAp44TPdZTCwqOWTajN1IU1KPZeCUThJWTl-6AKklnQ5Z0LDA>
    <xmx:sGpfZceuDpqqMr3TeZ_iRUymRUN3AooAvfd1QFrFQ-kGzd9-MWn_3A>
    <xmx:sGpfZRP5_raJD8_ABfI_mscWlDMAxTlUenK8j2nOST6Ry6VId1Q9wQ>
    <xmx:s2pfZSsMXXuh0yP0VrCUKFlhGjuHPPvDKsP04XjJCNVJrsIrD9r-zA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F5F236A0075; Thu, 23 Nov 2023 10:07:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
In-Reply-To: <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
Date:   Thu, 23 Nov 2023 15:07:09 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "Serge Semin" <fancer.lancer@gmail.com>,
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8823=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=8812:29=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=
=BC=9A
> On Thu, Nov 23, 2023 at 12:13:11PM +0000, Jiaxun Yang wrote:
>> > Ok. Thanks for the heads up. I'll fix the patch to be using ioremap=
()
>> > in v2. ioremap_uc() is just an macro-alias of ioremap() on MIPS.
>>=20
>> Perhaps we need to fix ioremap_cache so it can give a KSEG1 address?
>
> KSEG0 ?

Ah yes it's KSEG0.

>
>> AFAIK for Loongson DMI is located at cached memory so using ioremap_uc
>> blindly will cause inconsistency.
>
> why ?

Firmware sometimes does not flush those tables from cache back to memory.
For Loongson systems (as well as most MTI systems) cache is enabled by
firmware.

Thanks.
>
> Thomas.
>
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not necessa=
rily a
> good idea.                                                [ RFC1925, 2=
.3 ]

--=20
- Jiaxun
