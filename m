Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845627E8106
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjKJSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345300AbjKJSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:18:08 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AD772AA;
        Thu,  9 Nov 2023 22:30:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3B8D83200AE3;
        Fri, 10 Nov 2023 01:30:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 01:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699597842; x=1699684242; bh=hX
        qqY4BWR14neNf2OWhT/hoES7tg7nkHkI39Wk4fnR4=; b=AY+Eyy9+TUI2gFefVm
        OQ2F+8oM4FfGiO6xnl65YXS3uHvP9rtPE8qRzIHpPJbPl8CF7V9cR7SnjJDuGx0W
        I0BfJQKvddhepAG9h6Lpg99YGKa7/DaTH11t4n/nDaryAY08+jc71UiNKbgxl3EJ
        JoSpwiluGAgxn9TuseqhcaMdHR3tMMx8OqZ96zVHGM+zQ1nuAtGE/fEU6DaQf5SL
        sfie5yeHfkWU6ozEjZL/0haGXFXv6FG9mzo2Pkhafqj88hr1XQLGaBRmmgqk1fbM
        n75g+U6f4zMEBhIV930lAbRqYUv2BD+AfgdqXscMvnQnE+JhGHJxdnQ7/vmh6mN+
        e23Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699597842; x=1699684242; bh=hXqqY4BWR14ne
        Nf2OWhT/hoES7tg7nkHkI39Wk4fnR4=; b=FL4aOef4wrn+mcyjJq2E/ZO3fCQVo
        M/MT7NCE29j0g7qW2Q8h1puyq1dWOLY1JM2CmmpEJ0tKBw8cOYi4zRmGB9T6JneP
        CLG62qgARHN4F2r5y+wBgiZCHuOwhyQ3pm6kKNoDN7o3SeCFncHv10C2bphgFVqy
        KgthlZWeFLYsGw5JM/DctoVueEumEgRcleNfu0KBGrq0nyG5h10gAHwvAS8I7XPi
        QEEgNzaocUjV0EicCwV0Vxywfu+QY6khpk0mUVUZz1pOcCdWf5q+jTXQfHVsFFdC
        MFHSWbukx561a0ms34MO7juCuoNGzZ5D5UDbhf5msu/yHki82fsLSkUpA==
X-ME-Sender: <xms:EM5NZd0ZO5Keau_3lae8xWi_VQl_vF0AtX3RJT3glfwO6bSWgp94RA>
    <xme:EM5NZUGtGCJoujiCpk1rmVeeK9S3-E7Vd_uootXFoAbYL9340BuifPLl_GbRpYdMp
    hXLrAGzHqgPROMraxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Ec5NZd6Cdr1B5-_seQjypiAD77jU0p_usS1DQ9sE_NVRr_anxaKgcA>
    <xmx:Ec5NZa2YlJLASmHePpYoiFhGCJgcvHB9qT9WXegouv0MidmFx2vG2Q>
    <xmx:Ec5NZQE0MOxHxwSJwsqIUEkDZEyqoeh3hoGlJ7LlWxJoL8foGy_bXA>
    <xmx:Es5NZeMOC-xWrCco4yoZufFoPvP4nkYgbIxaKBSTkxqIdWzy6E_bqg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA3AEB60089; Fri, 10 Nov 2023 01:30:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <5e0966cd-7fa6-4217-a92e-d4a73b6b8bd6@app.fastmail.com>
In-Reply-To: <87h6lu8ed8.fsf@mail.lhotse>
References: <20231108125843.3806765-18-arnd@kernel.org>
 <202311090843.b8ISrsV1-lkp@intel.com> <87h6lu8ed8.fsf@mail.lhotse>
Date:   Fri, 10 Nov 2023 07:30:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "kernel test robot" <lkp@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Matt Turner" <mattst88@gmail.com>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, guoren <guoren@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Geoff Levand" <geoff@infradead.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023, at 04:40, Michael Ellerman wrote:

> As pointed out by Arnd this is due to there being two symbols that
> control the gelic_udbg.c code.
>
> I don't see the need for PS3GELIC_UDBG, without PPC_EARLY_DEBUG_PS3GELIC
> it just causes gelic_udbg.c to be built, but never called.
>
> The diff below fixes the error AFAICS.
>
> I can just fold it in if you're happy with that Arnd.

Yes, looks good to me, please do.

    Arnd
