Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFF7996E2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbjIIIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbjIIIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:35:58 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E810F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:35:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8C06358095D;
        Sat,  9 Sep 2023 04:35:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 04:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694248551; x=1694255751; bh=/6rKnVZuaQJqceJBO1nvMva4Alknr21qWzV
        fQShw7o8=; b=deGTSdrDeWLRxhPvkNMlSr3BVSX/GrgJAUxaVI65CAGORnQAwxj
        +z8+yf76ydss2TsIzEqCHcUuAgDQuO3JLGS5LC1RV1FCEqCTKZbHib2QpxdK9JXQ
        iVnG431yOb4um46DBkXK6abY1ZkKw8UlCNHqZVA+l0l6NKY7JdHQgItKF2JkSamJ
        R60m0vgautenuNnpzFODEYUf4Gprly1GoUivW+/mgbp1B3pYGK9cyQdyseAqnN91
        DQOBfZv0XB2NEBhLpgg/IrP0l0J2pRpMtCw/jlwxRvsjc8ogD+a3VhFV8AO2EVJg
        q8tgznvo2F3/enz2KlGSyckpHWib28OBCEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694248551; x=1694255751; bh=/6rKnVZuaQJqceJBO1nvMva4Alknr21qWzV
        fQShw7o8=; b=Bx/fxaD3bUFVcuJgK6+PzMjTMAYNAlt8dZbkTjN7avYb6xgw1kH
        1Bn57adjgOeS+/+BwhmOHCqg7UBtfrOK5xShDUJr3O48LfbYq1279Q/UQIN9UcDP
        go+LpoxoCGIXF9C71brJjzeU+Zf46tmvu2t/I2Jatj/u7NXR/PrgLtjxglipp8Hf
        /N5FTpIsG9A1gUTnYtgW8lrClnYtybcgcSDsN3O9OJjrksx9eoZdOfhs3pVLtO1+
        wKPMVhZ1ktIKV//NsAcL3j5aLgeek45P5AO3Oy+BcGjxV8JfAYHxGbYrIYlv6UTC
        IBj78nFUgZ2gMTkQ9KSsLXWNv12/Qv+/u0w==
X-ME-Sender: <xms:Zy78ZISAy1FnoHdJYiK_jQUYTVc45g54EPwYmOxcid5-dNAd5054zQ>
    <xme:Zy78ZFxswuLGm0xsBkWJLtNDahxqKQI0PmS_65ynEJq-gNZshOilFq8FGQnaQv5sa
    _2NRjgwClQNJ7BYfBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Zy78ZF0jU97R3RVLQHQOyuhuvwuy3qDwz8kBhst50lMGKd8ZNH1I_g>
    <xmx:Zy78ZMAIy9_9j262RCNuM3rJNR6DiVAPQRJdNlOEjbHYSuremfL_1Q>
    <xmx:Zy78ZBj-koAGcxocUcpd_g1I9xVx_LF4IBsaZ-TxucCie_Va6XWk8g>
    <xmx:Zy78ZJjFT6S-wZv6ZjVxEzgsLZyOr-UVDJeFo_5ohUhhfyq25ygtbA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4FAB7B60089; Sat,  9 Sep 2023 04:35:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <c7afaff5-61bb-4723-a3db-b040698dfa21@app.fastmail.com>
In-Reply-To: <CAMuHMdU8HMSgxAPFUSoCnKDs=y8T9w+5K+sTMUzmi37=ynH5FQ@mail.gmail.com>
References: <cover.1694093327.git.geert@linux-m68k.org>
 <5406d0829d8204841c8cb8d265ca91a52cd22d2d.1694093327.git.geert@linux-m68k.org>
 <6e46156f-5a81-d245-63cd-8091605deee1@linux-m68k.org>
 <CAMuHMdU8HMSgxAPFUSoCnKDs=y8T9w+5K+sTMUzmi37=ynH5FQ@mail.gmail.com>
Date:   Sat, 09 Sep 2023 10:35:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Finn Thain" <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Philip Blundell" <philb@gnu.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Joshua Thompson" <funaho@jurai.org>,
        "Sam Creasey" <sammy@sammy.net>,
        "Laurent Vivier" <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/52] m68k: apollo: Replace set but not used variable by
 READ_ONCE()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023, at 08:51, Geert Uytterhoeven wrote:
>
> On Fri, Sep 8, 2023 at 1:37=E2=80=AFAM Finn Thain <fthain@linux-m68k.o=
rg> wrote:
>> On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:
>> > --- a/arch/m68k/apollo/config.c
>> > +++ b/arch/m68k/apollo/config.c
>> > @@ -146,13 +146,11 @@ void __init config_apollo(void)
>> >
>> >  irqreturn_t dn_timer_int(int irq, void *dev_id)
>> >  {
>> > -     volatile unsigned char x;
>> > -
>> >       legacy_timer_tick(1);
>> >       timer_heartbeat();
>> >
>> > -     x =3D *(volatile unsigned char *)(apollo_timer + 3);
>> > -     x =3D *(volatile unsigned char *)(apollo_timer + 5);
>> > +     READ_ONCE(*(volatile unsigned char *)(apollo_timer + 3));
>> > +     READ_ONCE(*(volatile unsigned char *)(apollo_timer + 5));
>> >
>> >       return IRQ_HANDLED;
>> >  }
>> >
>>
>> I believe the volatile cast is redundant here, as READ_ONCE does that.
>
> Yes it does.  I didn't drop the volatile out of fear of introducing
> some higher W-level warning about casting away volatility, but upon
> closer look, the apollo_timer definition itself does not use volatile.

I think ideally you'd want apollo_timer or IO_BASE to be marked __iomem
and passed to readb() instead. OTOH, I don't think anyone actually
cares about apollo, so your version is probably good enough.

     Arnd
