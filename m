Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E427F5ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbjKWMNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345243AbjKWMNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:13:31 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDA199;
        Thu, 23 Nov 2023 04:13:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E9B033200AD3;
        Thu, 23 Nov 2023 07:13:32 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 23 Nov 2023 07:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700741612; x=1700828012; bh=bqTTK97AMSpZYhD615Hms/vz78ad6/G8f6h
        LgVljG2E=; b=Mn6gZel2hDy2U4uSAOinnxIYhsA32Dx/zcfQZ4OrQb3O8oSTi1+
        RUthCgCiYT7gNz5tzurx9Z87nMFqnK7kjKPd/O7A5VUOH7O92vmI1ln5y+yL6CIB
        cn4iAH4KievCDLgXVP8VJO0Sp1lPkiv2DQ9RPkiIGR2xMVPbD18FIF8QF/eVBYEZ
        E508qNeUGUzFJlMVl8VMZ5y82gOT+pSUBF+b+wOShNWv26Po99N/3NjEaT/VI6eo
        neB+0Pe9fmBD9t0w/U5rGKrgTLYPloArKChr+A5oIpgky3v8KtIMQHT809fHTBdI
        aJMQSzFYBRMf/uFzt5lkbePGW0D3GOnkrqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700741612; x=1700828012; bh=bqTTK97AMSpZYhD615Hms/vz78ad6/G8f6h
        LgVljG2E=; b=CWiHG2HCNR3PUb8Zber+487Gm0pSObixAc5WZjphYBU74QjOaX6
        qpMCQUi//ILgW0v/HBj7dEJVID3N67HAEZ8tA9qUcTOcFIn13mWjYYpsxY07/6Wt
        WHT03CR9vosF04wKel8cNgdALy1dXE7iavfb3IIRANiosvwvsndx93E3RfkoYy1C
        EWbFh3xVD7smkjkYxNuI7vDw/4GfNI7okhTTwIUGYTR2E+bGKRslVeOOLBoYhQKb
        y6x0ym88zjmHXSBT9vKXaC4B2wgUpxS2XcXr55TmWuP9EC1UMtG5YLLM0iIEyowW
        9lLW6y2Yj8heNz/f4LyyIog6j8Sy6roYQTg==
X-ME-Sender: <xms:60FfZay4e70_6RGnkS871rITuaJIl2ckwUu52XNbTdVD2y-fyEyR_Q>
    <xme:60FfZWRFHoS33fQA1vb56UHjrTyUmFMm6UU2MlhV7WFZvRYFWj49Nr1rhv4EN1IDm
    FonS-oWMADMnuuNWrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:60FfZcW7yxrzsBn8TlhRKH-cya1ihhj9bIuJs3jBgnnx6kfewA-KxQ>
    <xmx:60FfZQhd8afvL4fAh3eG0g9LmMQIChgU1DB4OBy2E5VaI6HwQeKD4w>
    <xmx:60FfZcCQ_UomU--4eeyinEfzfvXBZdlL9qdjNLrITwz-hgD2xFQwCw>
    <xmx:7EFfZaRw49s2rdQCFi9_saUGyFFcxQ6Yy3ymEngrsxGUT6X0si9Xqg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9E2B336A0075; Thu, 23 Nov 2023 07:13:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
In-Reply-To: <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
Date:   Thu, 23 Nov 2023 12:13:11 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8823=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8A=E5=8D=889:32=EF=BC=8CSerge Semin=E5=86=99=E9=81=93=EF=BC=9A
> Hi Arnd
>
> On Wed, Nov 22, 2023 at 08:35:01PM +0100, Arnd Bergmann wrote:
>> On Wed, Nov 22, 2023, at 19:23, Serge Semin wrote:
>> > dmi_early_remap() has been defined as ioremap_cache() which on MIPS=
32 gets
>> > to be converted to the VM-based mapping. DMI early remapping is per=
formed
>> > at the setup_arch() stage with no VM available. So calling the
>> > dmi_early_remap() for MIPS32 causes the system to crash at the earl=
y boot
>> > time. Fix that by converting dmi_early_remap() to the uncached rema=
pping
>> > which is always available on both 32 and 64-bits MIPS systems.
>> >
>> > Fixes: be8fa1cb444c ("MIPS: Add support for Desktop Management Inte=
rface (DMI)")
>> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>> > ---
>> >  arch/mips/include/asm/dmi.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/mips/include/asm/dmi.h b/arch/mips/include/asm/dm=
i.h
>> > index 27415a288adf..525aad1572d1 100644
>> > --- a/arch/mips/include/asm/dmi.h
>> > +++ b/arch/mips/include/asm/dmi.h
>> > @@ -5,7 +5,7 @@
>> >  #include <linux/io.h>
>> >  #include <linux/memblock.h>
>> >=20
>> > -#define dmi_early_remap(x, l)		ioremap_cache(x, l)
>> > +#define dmi_early_remap(x, l)		ioremap_uc(x, l)
>>=20
>
>> Please don't use ioremap_uc() in new code, we are in the (long)
>> process of removing it from the kernel for everything except
>> x86-32, and it already returns NULL on most of them.
>>=20
>> Would the normal ioremap() work for you here? It seems to
>> do the same thing as ioremap_uc() on mips and a couple of=20
>> other architectures that have not yet killed it off.
>
> Ok. Thanks for the heads up. I'll fix the patch to be using ioremap()
> in v2. ioremap_uc() is just an macro-alias of ioremap() on MIPS.

Perhaps we need to fix ioremap_cache so it can give a KSEG1 address?
AFAIK for Loongson DMI is located at cached memory so using ioremap_uc
blindly will cause inconsistency.

Thanks
- Jiaxun

>
> -Serge(y)
>
>>=20
>>    Arnd

--=20
- Jiaxun
