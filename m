Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6627999DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjIIQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjIIOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:07:42 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243FCC1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 07:07:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id B28DA2B000C2;
        Sat,  9 Sep 2023 10:07:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 10:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694268454; x=1694275654; bh=AltuPP/LqeE6uAGSGb8FseNo9A60IhA1lu+
        5xb2VAGk=; b=SRu7W0JjHy+7J3xJg2yylV229CcXGC7Q/Bu4wJue4kpMxLRjuiv
        /rm1kimQQrokMtdw5dgKtV03MOINzLOzdhYM65eqc7PfbGeanAuZOweu521VuNRs
        5y3wqWg4FU2M4ihkriVavUZG5xIl78x66XgSIukGrkX+NmLVVvj1NPKrC/BYIYd+
        YyJE/jnx8l2l2jdv7lfh8VevJpk9lW9YsXJW8HCnalJQAK5AgMY9j1SR3PnUtH+E
        o6PFJ3kkc6aQwKCQvkUJhEwH7nqpopW7QxA9uxKV3ZEp0VidPqRnWe0INKRckD3l
        NuRkJP1s2iUHAsozJWqoe8oRfw45bDV09vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694268454; x=1694275654; bh=AltuPP/LqeE6uAGSGb8FseNo9A60IhA1lu+
        5xb2VAGk=; b=r5XrJ3oAFxBgLmziT3FzAZd3H9GdEbpzF7Y0ZtIU7KYycyFhTO2
        jVT7DB3yH0vvg7NLQSXRo3kWh7vY1dDWq82QS4+uRyaAMugHOcov1Ibba1/0D9yo
        7WdblTVlu2/4kopg+Uo267t/Po0WZQs7ywVyiv2yG3UlKe/GnLClWv9dVeYg3wVI
        uc0xXIjGiooEIB0k+KOdh8TijccKU3aEYeGxehiRxzeR9Qkir43CsDeydgerkCis
        Erk0x8gm/wruGajNXy831rQLBHAc/pvcSYEsyxoifw9tL1YaBvs8DJ6dgqPvLlTV
        dVgCA8+ihM/UGFTUOXUaNdybJKW0QBoVZKA==
X-ME-Sender: <xms:JXz8ZCl2rnah069ySds2jAb9v_x_dEZabHp4pX80D5AUeaZE0TZlyw>
    <xme:JXz8ZJ1BMwoeAY2o-maKy1lT-AMR52vPR8C8vCEn-pibE-rm60RKxvuU3nX4GZNnx
    tia74_Eqx1mjXjN6IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeelfefgueeviefgudduueefueffkeelleeijeelkefgudfgueelledtuddu
    ieegvdenucffohhmrghinhepghhouggsohhlthdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JXz8ZApW4v7BgzReF-anvTJLf0emao3RaWXzDrywo8UIRFKJm9d40g>
    <xmx:JXz8ZGkKxyHwBzln8_bHyERy_Yihk92t-qHvQCzyS9Se0bIUZtbztA>
    <xmx:JXz8ZA2JKRhSHUzEfjEL4b-EMyI0D_PedhmfRNWNcxjaxE2Adi7uGg>
    <xmx:Jnz8ZBltFIuxlG-Do68QNuFy22OdtF-z8F8wfmM1PvL86HYMkMULu_tsWO8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D0E3B60089; Sat,  9 Sep 2023 10:07:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <76998b95-827a-4e71-8782-0990b204fcfa@app.fastmail.com>
In-Reply-To: <CAMuHMdWs0QbRQZCXZ2Gycqb7jjsjUZMp7_h2mVWxR1zrjCL1Og@mail.gmail.com>
References: <cover.1694093327.git.geert@linux-m68k.org>
 <64ea8cf65a4318fbf8c91cb3062d90a2555007c4.1694093327.git.geert@linux-m68k.org>
 <2545f40a-0c59-491d-895f-4a7975faaedc@app.fastmail.com>
 <CAMuHMdWs0QbRQZCXZ2Gycqb7jjsjUZMp7_h2mVWxR1zrjCL1Og@mail.gmail.com>
Date:   Sat, 09 Sep 2023 16:07:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org,
        "Finn Thain" <fthain@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Philip Blundell" <philb@gnu.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Joshua Thompson" <funaho@jurai.org>,
        "Sam Creasey" <sammy@sammy.net>,
        "Laurent Vivier" <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/52] m68k: emu: Mark version[] __maybe_unused
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 9, 2023, at 14:12, Geert Uytterhoeven wrote:
> Hi Arnd,
>
> On Sat, Sep 9, 2023 at 10:28=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Thu, Sep 7, 2023, at 15:41, Geert Uytterhoeven wrote:
>> > When building with W=3D1:
>> >
>> >     m68k/arch/m68k/emu/nfeth.c:42:19: warning: =E2=80=98version=E2=80=
=99 defined but
>> > not used [-Wunused-const-variable=3D]
>> >        42 | static const char version[] =3D
>> >         |                   ^~~~~~~
>> >
>> > Fix this while obeying the wishes of the original copyright holders=
 by
>> > marking version[] with __maybe_unused.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> That will just drop it from the object file, maybe it should
>> instead be marked "__used" ?
>
> Given it's been like this since the beginning, I guess it never showed
> up in the object file anyway...

Older compilers used to keep unused variables, and all versions
still do when building with -O0 instead of the usual -O2.

I can see on godbolt.org that gcc-1.27 did not have that optimization
yet, while gcc-4.1 had it, but I haven't found any versions between
those. I vaguely remember us throwing out the version strings from
most kernel files a long time ago, possibly that was triggered by
gcc no longer putting them into the object any more, but I can't
find a reference for that.

What I can see is that a lot of old network drivers have version
strings like this one, but they are actually printed from the
probe function, and lost their __devinitdata annotation in the past.

      Arnd
