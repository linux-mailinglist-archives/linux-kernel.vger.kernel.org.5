Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2011D7CF5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbjJSKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjJSKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:52:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D911F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:52:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4626A1F88B;
        Thu, 19 Oct 2023 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697712746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QpIy/RTUlzS5m0v5JYCmLVvG8ZLB5o2VoYwjMduXzG8=;
        b=UFTds98fre9xAAk4LYP0ojQT9dICphovGKc+CtcYLSaPKrQWQx5MVLsqEaagjGk0GeKi00
        vdUAEna7ahED15Xses+xsjBCpC3JooTZALeQ3iiDlnc31VjyzHkGJuM9r7p6wtVasUNSai
        iw9IQFJEayUA9jNkU0tif1akSC36cw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697712746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QpIy/RTUlzS5m0v5JYCmLVvG8ZLB5o2VoYwjMduXzG8=;
        b=pDTHfyhClmgvWfXOlaipVUP2nou1GgWvffDtvm5whgXnY4xz7LBiiUEPiO1vEAguVovjM0
        5u4Qa6vL6DhNnNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28F411357F;
        Thu, 19 Oct 2023 10:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H3zyB2oKMWVlCAAAMHmgww
        (envelope-from <aporta@suse.de>); Thu, 19 Oct 2023 10:52:26 +0000
Date:   Thu, 19 Oct 2023 12:52:25 +0200
From:   Andrea della Porta <aporta@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement
 optional at boot
Message-ID: <ZTEKabxNdegsbxyv@apocalypse>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, Kees Cook <keescook@chromium.org>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <20231018122729.GA18556@willie-the-truck>
 <da4985cd-43db-4957-b841-7b8f6bf8f885@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4985cd-43db-4957-b841-7b8f6bf8f885@app.fastmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:44 Wed 18 Oct     , Arnd Bergmann wrote:
> On Wed, Oct 18, 2023, at 14:27, Will Deacon wrote:
> > Hi,
> >
> > On Wed, Oct 18, 2023 at 01:13:18PM +0200, Andrea della Porta wrote:
> >> Aarch32 compatibility mode is enabled at compile time through
> >> CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
> >> (for both processes and syscalls) be enabled at boot time using
> >> a kernel parameter. Also, it provides a mean for distributions 
> >> to set their own default without sacrificing compatibility support,
> >> that is users can override default behaviour through the kernel
> >> parameter.
> >
> > I proposed something similar in the past:
> >
> > https://lkml.kernel.org/linux-fsdevel/20210916131816.8841-1-will@kernel.org/
> >
> > bu the conclusion there (see the reply from Kees) was that it was better
> > to either use existing seccomp mechanisms or add something to control
> > which binfmts can be loaded.
> 
> Right, I was going to reply along the same lines here: x86 is
> a bit of a special case that needs this, but I believe all the
> other architectures already guard the compat syscall execution
> on test_thread_flag(TIF_32BIT) that is only set by the compat
> binfmt loader.

Are you referring to the fact that x86 can switch at will between 32- and 64-
bit code?

Regarding the TIF_32BIT flag, thanks for the head-up. I still believe though
that this mechanism can somehow break down in the future, since prohibiting
32 bit executable loading *and* blocking 32 bit compat syscall are two
separate path of execution, held together by the architecture prohibiting
to switch to A32 instructions by design. Breaking the first rule and embedding 
wisely crafted A32 instruction in an executable is easy, while the difficult
part is finding some 'reentrancy' to be able to do the execution state switch,
as pinted out in https://lore.kernel.org/lkml/ZTD0DAes-J-YQ2eu@apocalypse/.
I agree it's highly speculative and not something to be concerned right
now, it's just a head up, should the need arise in the future.

> Doing the reverse is something that has however come up in the
> past several times and that could be interesting: In order to
> run userspace emulation (qemu-user, fex, ...) we may want to
> allow calling syscalls and ioctls for foreign ABIs in a native
> task, and at that point having a mechanism to control this
> capability globally or per task would be useful as well.
> 
> The compat mode (arm32 on arm64) is the easiest case here, but the
> same thing could be done for emulating the very subtle architecture
> differences (x86-64 on arm64, arm64 on x86_64, arm32 on x86-compat,
> or any of the above on riscv or  loongarch).
> 
>      Arnd

Really interesting, Since it's more related to emulation needs (my patch
has another focus due to the fact that A64 can execute A32 natively),
I'll take a look at this separately.

Andrea 
