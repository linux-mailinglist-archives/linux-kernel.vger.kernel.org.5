Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B547767D11
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjG2IFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjG2IFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEE3C30
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5F760A50
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 08:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CECC433C8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690617899;
        bh=gCGqzEybAhG4L2ceSgPliqsVQDGJ+XyMbNfv/tBjtNs=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Z6k6zVQLADvf8PGUEN0vehhe+oC2HJL97wOuiTpFkuNJfJSoh94ZZg8ZeRGHTgIUU
         HFy0uoguca6ajb5/RMRgI4s21FNv54xDp6GXqdi5+bbQQKKVNyMPDPZ67hSNnK1JNj
         Mn9IzykPG7qkmRVKXBUbET4JHcJD533O6KEu3vrZ8dxDDVRdbci46j2PpIIgLBhgSJ
         lMCaP8RKKZqAQWyYr/aH7uv8XjncKdmjJUKcbUlzxGLvyOGUwMxolITGqjIyIVyfMW
         yPxayzhYgnm5wey6h9gdydHH7b1Hs0SSH8uJ/UIASCn4Zr451Wgf0AImxkPTBAOMug
         cUXJ9nZt7u0Yw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id A933527C0054;
        Sat, 29 Jul 2023 04:04:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Jul 2023 04:04:58 -0400
X-ME-Sender: <xms:KsjEZPNR-UhnVCqta9SHwRe1Qu5LUvZ2rXQBkwUiQwzxTopFCF8Jag>
    <xme:KsjEZJ9Swp_dcyZGvTyqykb-js1qzBRNU8HOKmmodCWufk50VgWD6lW4iOrcnkmxM
    10EJ5bddfB6d2uIVPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    khgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedvveeigfetudegveeiledvgf
    evuedvgfetgeefieeijeejffeggeehudegtdevheenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehk
    vghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KsjEZORf7J_p80wAvuQX30fSsYQdlTeK7NR1xwoyhTcnhRm6q1uwaQ>
    <xmx:KsjEZDsY39gawhEX48g9Q_N9SAQr-W0Cb3ETqs-vCvDOvZyH5oeLRg>
    <xmx:KsjEZHcXaoN7cJn0tfTH2HrLRY_wndeF5KCxRioqDE9XgqOL3k2JSg>
    <xmx:KsjEZPHPrMW_LRbkS2i2ekcqSeRcAmahnR2bKEHqCHMO9owbv8APOA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6DD30B60089; Sat, 29 Jul 2023 04:04:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <fc2b139b-909b-46d7-abbc-7ab287c9d06d@app.fastmail.com>
In-Reply-To: <ef413a40-ddc4-4d23-bc56-23b7095ffc83@app.fastmail.com>
References: <20230726145740.1765323-1-arnd@kernel.org>
 <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
 <ef413a40-ddc4-4d23-bc56-23b7095ffc83@app.fastmail.com>
Date:   Sat, 29 Jul 2023 10:04:38 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>, guoren <guoren@kernel.org>
Cc:     "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: fix old style declaration in module.c
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023, at 09:06, Arnd Bergmann wrote:
> On Sat, Jul 29, 2023, at 06:59, Guo Ren wrote:

> I'd like to enable a few warning options (-Wextra, -Wrestrict,
> -Wmissing-prototypes, ...) in the Kbuild for 6.6, but the Makefile
> changes will probably go through the Kbuild tree or linux-mm,
> and the fixes for existing warnings can just take their normal way.

I just checked my log files again and I now see that there
are actually a number of -Wmissing-prototype warnings as well:

csky/kernel/signal.c:255:17: error: no previous prototype for 'do_notify_resume' [-Werror=missing-prototypes]
csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
csky/kernel/traps.c:150:15: error: no previous prototype for 'do_trap_unknown' [-Werror=missing-prototypes]
csky/kernel/traps.c:152:15: error: no previous prototype for 'do_trap_zdiv' [-Werror=missing-prototypes]
csky/kernel/traps.c:154:15: error: no previous prototype for 'do_trap_buserr' [-Werror=missing-prototypes]
csky/kernel/traps.c:157:17: error: no previous prototype for 'do_trap_misaligned' [-Werror=missing-prototypes]
csky/kernel/traps.c:168:17: error: no previous prototype for 'do_trap_bkpt' [-Werror=missing-prototypes]
csky/kernel/traps.c:187:17: error: no previous prototype for 'do_trap_illinsn' [-Werror=missing-prototypes]
csky/kernel/traps.c:210:17: error: no previous prototype for 'do_trap_fpe' [-Werror=missing-prototypes]
csky/kernel/traps.c:220:17: error: no previous prototype for 'do_trap_priv' [-Werror=missing-prototypes]
csky/kernel/traps.c:230:17: error: no previous prototype for 'trap_c' [-Werror=missing-prototypes]
csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototype for '__vdso_clock_gettime64' [-Werror=missing-prototypes]
csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototype for '__vdso_clock_getres' [-Werror=missing-prototypes]
csky/kernel/setup.c:104:34: error: no previous prototype for 'csky_start' [-Werror=missing-prototypes]
csky/kernel/ptrace.c:320:16: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
csky/kernel/ptrace.c:336:17: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]

I missed these as I was first looking at everything except
-Wmissing-prototypes that I want to enable. Can you perhaps
help out and create a fix for these yourself?

       Arnd
