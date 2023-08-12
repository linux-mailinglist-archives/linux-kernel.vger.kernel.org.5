Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9F779DF8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjHLHqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:46:32 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF33419A4;
        Sat, 12 Aug 2023 00:46:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 208215C0107;
        Sat, 12 Aug 2023 03:46:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 03:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691826395; x=1691912795; bh=1R5ctzAAcNQB2V3jKP5T5hiyB+DhvFuEPAC
        bmvPmK50=; b=nutKGvY0eL724xeuBxbBKl0Lec4UQ/Xr1efX8oPnh3bNyR0UoNO
        v9Q12UKvjSXBbu1l17dDf0VeRYYb0vXDtpXo+AhMNW17vQtsq/L75I7dqtD19i0N
        P2ntguCjM5MM5W0/YwsFakxFRPMgy6XlaEG0LWeJEDrFEA9qQSznAvNUZUs4FcQl
        u1KIoMb6ZAn1VXGb8/MFetNgd1tsG3uefwtHIyOPFoGuUqIdHJvyXo82DM5U5I+x
        SPfb5zRu50Gk1rEvEQqHRDYprHdMe/b7Ve1FKBVrNBpX+174T3eSodjhwVRxQr+q
        c5l3rdBpbLYcpZEg9Ol1rHUpmPW5dpzQw1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691826395; x=1691912795; bh=1R5ctzAAcNQB2V3jKP5T5hiyB+DhvFuEPAC
        bmvPmK50=; b=diWSONk0HiGIuLezERYrIYMjKKhl3BQP8CTGfYdlqm4QtJLGRCv
        PVGdgm7W7PrF92/cjijSeY/GwmlJoby0jMMcilXK0FDsjx3hQpnBkLTPgwxpZJ+8
        Rms2gABVgt74xlWLBeh32YC5FAFJhTwGwxXiaGscO8F4aeCzB79rfxBSdKu95G62
        0bOtEeKhGJr4tnc+AszIZCae7zHYXbYdE/tAx+NuCWDXAT9+b4rDI6hUl+YuKTPE
        DUkZb7Jm5s5UIELgg398zJrI1ehkCOpVgKk0t1wu85St3q90PMrP4xayfvVmfxvB
        +mq87fa4hw3scj5WO9Ui/nn56oPhDcKaGTw==
X-ME-Sender: <xms:2DjXZGrcm1nooPaeGiP_UR05ZxqRL9hT_gakPrOkql5l1NX68WDWDQ>
    <xme:2DjXZEoxEpXce4Bb4Ao9Rhr3HkWqwjDkZ13jaDMd53AjmuBmZmMAaQwV4yXcSNcKO
    kJpNn__j4mWyHyartc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2DjXZLPQn2TqVIgyW6-tQwUG8P8Lw73P-zLqJCOCzSQ_OIuJtfkxzQ>
    <xmx:2DjXZF4adFG0j0n9wRWuI42R43VpsvtE7VWE70ehnMhOYpN_4lUYCQ>
    <xmx:2DjXZF5yCw1jmpp8FFpxkysER-4QrzZer5AK3I-Pc5hFGAMvs80Gpw>
    <xmx:2zjXZJoaKMbDInL_qMZSv86qcrRWO5LB4IgX5rtggdWg9zUAfOpMGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E936CB60089; Sat, 12 Aug 2023 03:46:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <3a1c5033-5ce2-4d0b-91be-3b612512f53c@app.fastmail.com>
In-Reply-To: <CAK7LNARfEmFk0Du4Hed19eX_G6tUC5wG0zP+L1AyvdpOF4ybXQ@mail.gmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-16-arnd@kernel.org>
 <CAK7LNARfEmFk0Du4Hed19eX_G6tUC5wG0zP+L1AyvdpOF4ybXQ@mail.gmail.com>
Date:   Sat, 12 Aug 2023 09:46:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Qing Zhang" <zhangqing@loongson.cn>,
        "Donglin Peng" <pengdonglin@sangfor.com.cn>,
        "Qi Hu" <huqi@loongson.cn>, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 15/17] arch: fix asm-offsets.c building with -Wmissing-prototypes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023, at 00:12, Masahiro Yamada wrote:
> On Sat, Aug 12, 2023 at 3:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> When -Wmissing-prototypes is enabled, the some asm-offsets.c files fa=
il
>> to build, even when this warning is disabled in the Makefile for norm=
al
>> files:
>>
>> arch/sparc/kernel/asm-offsets.c:22:5: error: no previous prototype fo=
r 'sparc32_foo' [-Werror=3Dmissing-prototypes]
>> arch/sparc/kernel/asm-offsets.c:48:5: error: no previous prototype fo=
r 'foo' [-Werror=3Dmissing-prototypes]
>>
>> Address this by making use of the same trick we have on other archite=
ctures,
>> renaming the unused global function to main(), which has an implicit
>> prototype.
>
>
> main() only works for one function call, but
> there are some cases where splitting the code
> into some functions makes the code cleaner.

Right, I went with main() as that is already used on a couple
of architectures.

>> On loongarch, there are many functions in this file, so the trick does
>> not work, adding explicit declarations works around it in a slightly
>> more ugly way but is the best I could come up with here.
>
> I do not like repeating the function names.
>
> Could you try "static + __used" as in
> arch/x86/kernel/asm-offsets.c ?

Sure, that should work, I had not noticed x86 doing it like this
and I agree it's slightly nicer.

In this case, Thomas Bogendoerfer already merged my patch for MIPS
in 6.5. The loongarch file I change here is a copy of the same file,
so we probably want them to stay consistent, either keeping my
change for now, or reworking mips along the same lines.

    Arnd
