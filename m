Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C136C7A57E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjISD2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjISD2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:28:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2236E95
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B327C433CA;
        Tue, 19 Sep 2023 03:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695094105;
        bh=pZggQ60AuJITow/YiIvrlV3FwI2hImVOIwYTooLc/kk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=UdCk2gRciQGMMzDNdwBndu7mJq0IlT3p0jG904SONrzShXfXmz1jm7Jl2ygP8fjhm
         AbphpoNDbrXF6TBqjO5/VGq9vl8zprZYuoz0kAt5+rrGqpqptqOiUpcKiaTkX/d87B
         czBM7vreI0fjIKMWHUpA0K2YiR4To9jfyoqjZNPFYnEFCR+doUYgu+Nizg8+Xn7G3T
         vWV2CC8s9+UN4UdUEi/NVmQ6CvtjuX44s7qjFb3Ad93MNrY7vkuH8+YPbfDm+ZgpEI
         07c9BsELkMmFLBsbbMY/r/HhX3r3Ch+gBcQSnEwUD3jmC5fz/mTCvA4wXbOnsJXjmQ
         xwNKeFtMnz/CA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0C89B27C0054;
        Mon, 18 Sep 2023 23:28:24 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 18 Sep 2023 23:28:24 -0400
X-ME-Sender: <xms:VxUJZdGK2Ol-Jgx3Pn1P4QYvek5cXm5SEgIwyCbh7FMCNCa01UsyvA>
    <xme:VxUJZSX9jJyQEK-XIxr-KdXIMW2vQR_UbkDAmor8PWm-mfcmi8nrwSM2VDZtdwv9l
    yWN65voQxa-R7suEYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepveffgfevhfeiteduueetgeevvdevudevteefveffudeiveefuddt
    leeitdeludfgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:VxUJZfJe875Aczt77edOeKmiipcpyJwAmZ549Nyt6jvUI6YKMAoyqg>
    <xmx:VxUJZTFF6JyL8oLVcUmkvM8m3eR_7T7IEUef_8R0vYUc0z9ER87RAw>
    <xmx:VxUJZTVAfwCNTXHRgB-n5lHjO-NtHfx2TC-w891q5YVu48r8jnGABA>
    <xmx:WBUJZTQUzX7Bndi47KsiTBD8Qa0Roo3AQxJqZKmUHhPojfv4tULYZQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0BCF31A0064; Mon, 18 Sep 2023 23:28:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <b2967925-0a57-4a19-8657-3d9f4da83a20@app.fastmail.com>
In-Reply-To: <20230817121513.1382800-1-jackmanb@google.com>
References: <20230817121513.1382800-1-jackmanb@google.com>
Date:   Mon, 18 Sep 2023 20:28:02 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Brendan Jackman" <jackmanb@google.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Lai Jiangshan" <laijs@linux.alibaba.com>, yosryahmed@google.com,
        reijiw@google.com, oweisse@google.com
Subject: Re: [PATCH RESEND] x86/entry: Don't write to CR3 when restoring to kernel CR3
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023, at 5:15 AM, Brendan Jackman wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Skip resuming KERNEL pages since it is already KERNEL CR3
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>
> While staring at paranoid_exit I was confused about why we had this CR3
> write, avoiding it seems like a free optimisation. The original commit
> 21e94459110252 ("x86/mm: Optimize RESTORE_CR3") says "Most NMI/paranoid
> exceptions will not in fact change pagetables" but I didn't't understand
> what the "most" was referring to. I then discovered this patch on the
> mailing list, Andy said[1] that it looks correct so maybe now is the
> time to merge it?

I did?

Looking at the link, I think I was saying that the opposite patch (*always* flush) looked okay.

>
> Note there's another patch in [1] as well, the benefit of that one is
> not obvious to me though.
>
> We've tested an equivalent patch in our internal kernel.
>
> [1] https://lore.kernel.org/lkml/20200526043507.51977-3-laijs@linux.alibaba.com/
> -- >8 --
>  arch/x86/entry/calling.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index f6907627172b..b2458685d56e 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -236,14 +236,13 @@ For 32-bit we have the following conventions - 
> kernel is built with
>  .macro RESTORE_CR3 scratch_reg:req save_reg:req
>  	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
> 
> -	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
> -
>  	/*
> -	 * KERNEL pages can always resume with NOFLUSH as we do
> -	 * explicit flushes.
> +	 * Skip resuming KERNEL pages since it is already KERNEL CR3.
>  	 */
>  	bt	$PTI_USER_PGTABLE_BIT, \save_reg
> -	jnc	.Lnoflush_\@
> +	jnc	.Lend_\@

I don't get it.  How do you know that the actual loaded CR3 is correct?

I'm willing to believe that there is some constraint in the way the kernel works such that every paranoid entry will, as part of its execution, switch CR3 to kernel *and leave it like that* *and that this will be the _same_ kernel CR3 that was saved*.  But I'm not really convinced that's true.  (Can we schedule in a paranoid entry?  Probably not.  What about the weird NMI paths?  What if we do something that switches to init mm?  Hmm -- doing that in a paranoid context is probably not a brilliant idea.)

Maybe it is true, and maybe a convincing argument could be made.  But that seems like a lot of thinking and fragility for an optimization that seems pretty minor.

--Andy
