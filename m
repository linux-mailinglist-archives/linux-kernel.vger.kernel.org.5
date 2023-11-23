Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C329E7F657F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbjKWRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:33:48 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC61AB0;
        Thu, 23 Nov 2023 09:33:54 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E7AD53200A81;
        Thu, 23 Nov 2023 12:33:52 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 23 Nov 2023 12:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700760832; x=1700847232; bh=27SDTQSVNSOteu3KKkKr7JW9siSN9Q+1UTF
        B8KAZ5YA=; b=acJmjms2lNSKCid+/n/CTUSeUKdjClGGB7LXwCChe77TE9MID9T
        P9gI3N8gQUA7tIK/vZiQrzEIVhc7ys27xnbx/IiVOP7lcAuthNpIr6mUdj9nGqeF
        CkDtA3CJrZXrlNeUnqt0bM9zg4LVC8uBlzcmp30d8JzyR4D5bTj7mqvG6h0pzTAj
        XQXZPEMSZ0XtQibWSwduuf2164/PEgT1+eC5eqR6yOgj/wDU2HGoJlzTmk9B5vq2
        bt5PB6/U9IK6YHxUvuKbAxa4v4BhgIEIpt044s9vchnRooWrzCECqfNXTJfGRCvI
        dBP4/gmHc8vVv8g8PMJYHAeJGfDEx+/S7/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700760832; x=1700847232; bh=27SDTQSVNSOteu3KKkKr7JW9siSN9Q+1UTF
        B8KAZ5YA=; b=cOcqtAYo5IgG5pzOd6Su/JTI1FCQ95828mAhmzWcWPfE+RfTbTv
        wkKl14OMnwW+1dgzeHIxZGCAEAqq+5gMz6uYuoRshLDhtLdarHNd6KSIHHqAdiwT
        RLPAlGXohmPbG07t+ruKfA6If+53e6xq83vDtTCTFfrgG5A94DeSLZXpkRh4HAq3
        Oab+WmpLS9sgDp9Q4UlBsxdDWVIsRzXYNSgkfcKJuUNv/OMtdfhtJDGJJLZ0sEX8
        WaXiMeYMPtZzdUMscbEwj/jbEKH4EGW8KjasdgwVpf/KAcVUNbzST7r7gtDrqprT
        Sy1htvBdI1+CGBcp0QNEUqg61FpErd4T0lw==
X-ME-Sender: <xms:_4xfZaaZrXowojPdLLPl2xLeof_QdLOYDkIMhW2FhG1_D2-X_H4h0g>
    <xme:_4xfZdar8xTBmPB-mAxqpqE9KJCfZdMQEMPDYLAEgribhQbqzkRpmsh8Pq8tWo6w_
    FrcGszupBeut9cb0DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
    jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_4xfZU_GyswmJ7J3KM_M9aNMJ0K1BgWdnPlEp71HceVr75J93xblCg>
    <xmx:_4xfZcrVOPi8D20MitBkesxiY7y3n2rGTycn5KhejTwATT6Rv2VlXQ>
    <xmx:_4xfZVpHwj62HaJ7BUMWpcksMl4jiBAdgZvqL52XBsZUOIi1mNK5Rg>
    <xmx:AI1fZdaDbogwNbZpA2Vd1hJ3xC2sD6N8O4Sr6BeN6X3c3HwjyoM4Sw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8719736A0075; Thu, 23 Nov 2023 12:33:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
In-Reply-To: <ZV94rifAIF2p9Nej@alpha.franken.de>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
Date:   Thu, 23 Nov 2023 17:33:31 +0000
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8823=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=884:07=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Nov 23, 2023 at 03:07:09PM +0000, Jiaxun Yang wrote:
>>=20
[...]
>
> the problem with all 32bit unmapped segments is their limitations in
> size. But there is always room to try to use unmapped and fall back
> to mapped, if it doesn't work. But I doubt anybody is going to
> implement that.

Yep, I guess fallback should be implemented for ioremap_cache as well.

>
>> >> AFAIK for Loongson DMI is located at cached memory so using iorema=
p_uc
>> >> blindly will cause inconsistency.
>> >
>> > why ?
>>=20
>> Firmware sometimes does not flush those tables from cache back to mem=
ory.
>> For Loongson systems (as well as most MTI systems) cache is enabled by
>> firmware.
>
> kernel flushes all caches on startup, so there shouldn't be a problem.

Actually dmi_setup() is called before cpu_cache_init().

Thanks
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
