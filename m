Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A646756A23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGQRY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGQRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87582BD;
        Mon, 17 Jul 2023 10:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1D161193;
        Mon, 17 Jul 2023 17:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249E2C433C8;
        Mon, 17 Jul 2023 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689614665;
        bh=o+WgjDKzf9AD9b+kUzQGRClRYLlDB82OkTDYfv6a3Yk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=U55TcGyi7YmJyhzLOTZnjrFVWw0H3+af918Yjk8mPHfHD/clSDnn9R44JznF10IRH
         Z8KK+n6r0jSrVIOFXY3K9zEUwgWJJmDl6U+xcWuKBgzWtStxy8DJ8vdgvW6lkDoW7B
         HjBUxuU9UxtzkC9l5ApN5DKkzBCr1VsqK7wmYWuXqa2OawFE6M2Oq9WP6fcTzeqAS1
         oQr1aLD/6waYS1NoUdY5C7XFt1xXn2X7vRDexou/Ye3pmNVTURfyjeGdd/9YrFIH9l
         MqvAuz5uF3yGQhNR2S/bV8TY4Zn4vPj0wIo0nVHW6MMTPN4UGDgaMVOo3Hl1Lknk4t
         QarZtUu8s3ucw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0594A27C0054;
        Mon, 17 Jul 2023 13:24:22 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 17 Jul 2023 13:24:23 -0400
X-ME-Sender: <xms:RXm1ZG1tVKd235OTAKjb7YgspTMPR-qImOZNagZiOwv_r996Wpl_EA>
    <xme:RXm1ZJGhtMeEyJx0NHmpmxK7orhG2xuLUV7eaWrGF_5mvemHNiGzAxoeoH8wHPKOx
    Be-_jfsguKQ7NGLhQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:RXm1ZO5oHfgOl5d-JsrWsEmT0wZ8c7lpn-wGY1Pk1MKOwuxnVn3prQ>
    <xmx:RXm1ZH3tFnXsbSmPTR9ONplP-mkjz9Tn9-KQt1DQXW36vSF4M5jnmA>
    <xmx:RXm1ZJEwoQUXW2HC-hvtBktlwQpPz6VjPtqSmOfmC010d9JGpLVfQw>
    <xmx:Rnm1ZFKtTGUhG1K7QB02N33IARC_1h22efMRZVMJvVFaIkzEJg1UPw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D060531A0064; Mon, 17 Jul 2023 13:24:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <d305b437-9eef-42da-821e-67365aad520b@app.fastmail.com>
In-Reply-To: <CAPhsuW4pDkd7rCWRM6938ve36rfhGxyu=8t1-GjcKnNajofpQA@mail.gmail.com>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-3-rppt@kernel.org>
 <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com>
 <20230618080027.GA52412@kernel.org>
 <a17c65c6-863f-4026-9c6f-a04b659e9ab4@app.fastmail.com>
 <20230625161417.GK52412@kernel.org> <ZJmFFmexl_1GUhIL@FVFF77S0Q05N>
 <CAPhsuW4pDkd7rCWRM6938ve36rfhGxyu=8t1-GjcKnNajofpQA@mail.gmail.com>
Date:   Mon, 17 Jul 2023 10:23:56 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Song Liu" <song@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>
Cc:     "Mike Rapoport" <rppt@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Helge Deller" <deller@gmx.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Kent Overstreet" <kent.overstreet@linux.dev>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Puranjay Mohan" <puranjay12@gmail.com>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Will Deacon" <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jun 26, 2023, at 10:48 AM, Song Liu wrote:
> On Mon, Jun 26, 2023 at 5:31=E2=80=AFAM Mark Rutland <mark.rutland@arm=
.com> wrote:
>>
> [...]
>> >
>> > So the idea was that jit_text_alloc() will have a cache of large pa=
ges
>> > mapped ROX, will allocate memory from those caches and there will be
>> > jit_update() that uses text poking for writing to that memory.
>> >
>> > Upon allocation of a large page to increase the cache, that large p=
age will
>> > be "invalidated" by filling it with breakpoint instructions (e.g in=
t3 on
>> > x86)
>>
>> Does that work on x86?
>>
>> That is in no way gauranteed for other architectures; on arm64 you ne=
ed
>> explicit cache maintenance (with I-cache maintenance at the VA to be =
executed
>> from) followed by context-synchronization-events (e.g. via ISB instru=
ctions, or
>> IPIs).
>
> I guess we need:
> 1) Invalidate unused part of the huge ROX pages;
> 2) Do not put two jit users (including module text, bpf, etc.) in the
> same cache line;
> 3) Explicit cache maintenance;
> 4) context-synchronization-events.
>
> Would these (or a subset of them) be sufficient to protect us from tor=
n read?

Maybe?  #4 is sufficiently vague that I can't really interpret it.

I have a half-drafted email asking for official clarification on the rul=
es that might help shed light on this.  I find that this type of request=
 works best when it's really well written :)

>
> Thanks,
> Song
