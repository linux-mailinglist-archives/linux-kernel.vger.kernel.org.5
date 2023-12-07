Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822AC807E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443153AbjLGBZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442036AbjLGBZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:25:14 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E70D4ECA;
        Wed,  6 Dec 2023 17:23:39 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 670B25C00A4;
        Wed,  6 Dec 2023 20:22:07 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 20:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701912127; x=1701998527; bh=7yABB6tw1NhELwxCFkAM3G6hbihCudob0wd
        ZkRFYHT8=; b=UXG5U8G5mrSji73MNOV06fEgfnLQge3pzavPqi6NyVil+bZM0NT
        IwKYJkXg2azvrr4SWmwu4oFUPG1sPxCYpVgsFreOROjXWG+UocLdBEgMLu7Snsff
        +RRYfVH0Ag3VCaG7WjgNdBtCCWPcv+RLXJKmNMXq3s2GzFR1kkUUpjWLChcvNiEm
        OudAvHUeYWN3wu65cCvqf3omsnaENbxuPynwjbSuszjz3LueMBCfx3cU4fYnHnFD
        H9mxXDdhSgZn+5mLsvyL+Kj+ecO/8EUjXKoinbCOFbi/LQypD/40ADzoRa+RU7vz
        2wcMHji2Y0kOGaPKV4hAFWxOGncQWI/55ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701912127; x=1701998527; bh=7yABB6tw1NhELwxCFkAM3G6hbihCudob0wd
        ZkRFYHT8=; b=FA3hlhIvv/0YvU3lBKgigY56SS3Oprf+x825gqxV5xhSzYgChZ8
        auKPbdzKktukw/0iw2LffHWAhtx+5gE91I8fByxOse0XGBu1ueTNwvsnELoq/r3H
        dD0HVzvHdsoPNDVUVSSR+PStI4lRqk6y1hV+F7Xok3mURaqpUnYZQ6/NFGezuVrp
        ySkWpO1RLAw2jQKjLObayz63jrxIzImc/vZkwyngS62OHIHNohPTNBEPY8LzeBaB
        6aG5L46zZYWyz23jZIKjF9kPLaAIx6XYR4RF73JVa+Ac3On5VZ95NKGw33HarJeZ
        YenFtOJUoKHIWVjOlM2gUIm65CXkqu+YESg==
X-ME-Sender: <xms:PR5xZWzw3-00DcV31e4_BinHR67q9FRk0FN0B2Saq1jTyJ2QQUrw_w>
    <xme:PR5xZSSC4A3Z0sm-Kk4NvG9Oz4BEWRwnBFTsezKOaTzeDvkFOyYnHpYWXfHmhHdy5
    z8JoR5Pp6TtMTR29KU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:PR5xZYUZFMZNVt8D8FSzGc6K_wQ1Bq0K0Idmu7tM1z4GrTg8jwhcKg>
    <xmx:PR5xZcjH-4aPIi-pJApztAxNGoYMFqLAeQHg93XpUbJq0JxsSUCUew>
    <xmx:PR5xZYCEVYeV7O06d9uqfrTTEvseK-hfgjidFpiBneqi1VGNWH6o6Q>
    <xmx:Px5xZX4u29WvImTimkJQK95PNVSo8nq-vsb9u9xxLC01_SMcmXOccg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D316E36A0075; Wed,  6 Dec 2023 20:22:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <40b5e438-22f4-43e5-9663-db44dd402a35@app.fastmail.com>
In-Reply-To: <c10194f2-097f-4455-9932-19961edbf990@infradead.org>
References: <202312041909.lwhcU35R-lkp@intel.com>
 <5f1caaf8-1edf-444a-b017-c4d08e52213b@infradead.org>
 <f712a65b-4984-46e8-bd43-1309b5cd41f0@app.fastmail.com>
 <c10194f2-097f-4455-9932-19961edbf990@infradead.org>
Date:   Thu, 07 Dec 2023 01:21:48 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "kernel test robot" <lkp@intel.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: pm.c:undefined reference to `i8042_command'
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



=E5=9C=A82023=E5=B9=B412=E6=9C=886=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8B=E5=8D=885:26=EF=BC=8CRandy Dunlap=E5=86=99=E9=81=93=EF=BC=9A
> On 12/5/23 22:52, Arnd Bergmann wrote:
>> On Wed, Dec 6, 2023, at 06:24, Randy Dunlap wrote:
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>    mips64el-linux-ld: arch/mips/loongson2ef/lemote-2f/pm.o: in func=
tion `setup_wakeup_events':
>>>>>> pm.c:(.text+0x118): undefined reference to `i8042_command'
>>>>>> mips64el-linux-ld: pm.c:(.text+0x154): undefined reference to `i8=
042_command'
>>>
>>>
>>> How do we feel about this?
>>> I suppose that an ARCH or mach or board should know what it requires.
>>>
>>>
>>> ---
>>>  arch/mips/loongson2ef/Kconfig |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff -- a/arch/mips/loongson2ef/Kconfig b/arch/mips/loongson2ef/Kcon=
fig
>>> --- a/arch/mips/loongson2ef/Kconfig
>>> +++ b/arch/mips/loongson2ef/Kconfig
>>> @@ -40,6 +40,9 @@ config LEMOTE_MACH2F
>>>  	select ARCH_HAS_PHYS_TO_DMA
>>>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>>>  	select ARCH_MIGHT_HAVE_PC_SERIO
>>> +	select INPUT
>>> +	select SERIO
>>> +	select SERIO_I8042
>>>  	select BOARD_SCACHE
>>>  	select BOOT_ELF32
>>=20
>> I think it's bad style to force-select an optional subsystem.
>> How about making the entire file optional? It seems that there
>> are already __weak functions in its place.
>
> Yes, I agree in general.
>
> Hopefully the maintainer will opine your suggestion.
> Jiaxun?

LGTM, PM is not an essential function here.
Arnd, do you mind making it a patch?

Thanks
- Jiaxun

>
> Thanks.
>
>>=20
>> --- a/arch/mips/loongson2ef/lemote-2f/Makefile
>> +++ b/arch/mips/loongson2ef/lemote-2f/Makefile
>> @@ -8,5 +8,6 @@ obj-y +=3D clock.o machtype.o irq.o reset.o dma.o ec_=
kb3310b.o
>>  #
>>  # Suspend Support
>>  #
>> -
>> +ifdef CONFIG_SERIO_I8042
>>  obj-$(CONFIG_SUSPEND) +=3D pm.o
>> +endif
>>=20
>>      Arnd
>
> --=20
> ~Randy

--=20
- Jiaxun
