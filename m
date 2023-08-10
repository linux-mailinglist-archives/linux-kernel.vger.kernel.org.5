Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704C7781F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHJUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHJUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD32706;
        Thu, 10 Aug 2023 13:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5932E63D08;
        Thu, 10 Aug 2023 20:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6027CC433C7;
        Thu, 10 Aug 2023 20:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691698232;
        bh=WRdoWe5wxBcJbkSsIlQzyIHKODWuaNuzM4NGwXznyvI=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=MmuCvwppqZhHVsoLkY6h+fnmdcPgrOteouLgDLQKC3o17bdbAIbivtkhpNdUIXDPQ
         PnWPxc33LlUxrJjG1sKX4iYxQENI+JPBw1/lhomq3wYDbGdmRceQ2TDLcFViTSlTet
         Ohs0P3rcVzPz1X7S6sEkMDi+gjtr4Bhw9JXsJO2K6vmL+sOs2/8iXtpA9jQl0wyF/7
         N4y7izKu/+X3vT6igmWgzJsXM1IMFTgEVzvyYPrUU4RIx5I8EntUQ1dNtpIzk+bz6v
         QJPsTwbTCjySlCDdGIRzq31Wxxr7L4U9vVTsD8fxD4zgNXjuRRFcoT3214mz2U21Ts
         /57cvt5Uoy5RQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 35FCA27C0054;
        Thu, 10 Aug 2023 16:10:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 16:10:31 -0400
X-ME-Sender: <xms:NkTVZLnao9RAItPUu_GILgQ8k4OilXKsCkyOCv7QA5I2sVqKSwiDkA>
    <xme:NkTVZO1yyBgzvsvahVOb6FWhsPtWflPC5CneFXrcIc1cPSym0RVQU9LLsx7ven7qA
    iS0WyF6KWpoj-7JYu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:NkTVZBo1dhTla8-r3ANxR1R2h_xSmYHQcwYGthiHXp8rDdpv8AUw1w>
    <xmx:NkTVZDlk5a7v0uEl1tG1JZgi6AOrM8eVTPoB8I486hVGUz66KsZENw>
    <xmx:NkTVZJ2mhp6ob6-yZ43lk1pUBJLo_0E5pACi60PRDlrNIU2aTCj2_w>
    <xmx:N0TVZGmSmMG4DdnQQa3PJGfnhvdEhBHprYtCBphWUFLa61dfKLKWVQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2E1CEB60089; Thu, 10 Aug 2023 16:10:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <786b2d02-f649-4c5f-ae9a-ed2228e4a3fb@app.fastmail.com>
In-Reply-To: <202308101209.45CF7C6F80@keescook>
References: <20230804071045.never.134-kees@kernel.org>
 <f34c11eb-89b5-48a5-bd24-c215083575a5@app.fastmail.com>
 <202308101209.45CF7C6F80@keescook>
Date:   Thu, 10 Aug 2023 22:10:08 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: ptrace: Restore syscall skipping and restart while tracing
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, at 21:32, Kees Cook wrote:
> On Wed, Aug 09, 2023 at 09:47:24PM +0200, Arnd Bergmann wrote:
>
>> If the local_restart code has to store the syscall number
>> for an EABI-only kernel, wouldn't it have to also do this
>> for a kernel with OABI-only or OABI_COMPAT support?
>
> This is the part I wasn't sure about. Initially I was thinking it didn't
> matter because it's only a problem for a seccomp tracer, but I realize
> it might be exposed to a PTRACE tracer too. I was only able to test with
> EABI since seccomp is disabled for OABI_COMPAT.
>
> Anyway, syscall restart is done this way:
>
>         movlt   scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
>
> Can a EABI call restart an OABI syscall? I think so?

There are very few differences between oabi and eabi syscalls, I
think it basically comes down to 

 - the syscall number, and register in which it is passed to the kernel
 - a few syscalls that exist for OABI backward compatibility and were
   deprecated before EABI was added
 - a few syscalls that pass a struct with different alignment rules
 - epoll_wait() uses a runtime check for the output format

It also seems like the __NR_restart_syscall path is only relevant
for syscalls using restart_block for restarting, and that means
it's only poll(), futex(), nanosleep(), clock_nanosleep() and their
time64 counterparts. All of these are handled by the same entry
points for OABI and EABI, i.e. there is no overlap with the
exceptions above. Crucially, epoll does not use restart_block,
unlike poll().

> So maybe we just need to add:
>
> 	str     scno, [tsk, #TI_ABI_SYSCALL]    @ store scno for syscall restart
>
> after that instead of moving it like I did originally?

Yes, I think that works!

For pure EABI and pure OABI kernels, this just does the right thing,
storing a plain __NR_restart_syscall in the field without an ABI
marker. For an OABI compat task running on an EABI kernel, it will
call the EABI version of restart_syscall(), but that is exactly
the same as the OABI version, as shown above.

    Arnd
