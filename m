Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04F7C5F26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjJKVdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:33:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973289E;
        Wed, 11 Oct 2023 14:32:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso570197a12.3;
        Wed, 11 Oct 2023 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697059977; x=1697664777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgILceheKqLDcrQ8Md1C0WGKCCTkWPoSxOmfrQfUe7M=;
        b=LZ3MCA38Y/QGbl2VDUxvgDf5evagrT6J2sfnxeAmHkY19sfQ3QFeB8I2L2zUFSuOhc
         8IDZFxbspRruXk/M6YHcW0bUcFEuncGGUtytZVo6Tl9ygqfWy2PrCYUv3UnqF5qsMa4O
         b1pVlxK8wuIiIGWpgNhtCqY8Rs3dMSHoncRL7Bxo7R6mgEHg6so5SGm+TsXZWFKeI7xk
         4HglL6JGQqb4XyL49ODuoHad8UJB3LcyhcL6pV3tuCTD+O7aQG7htkehnsYwkZe0QdOf
         LQPAQsJTItNE8Rn/NYSMIK9PNQp8svcibvDF+mT+Y+zel695LSU2f4Pf4YXUzl6VcJw9
         G5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059977; x=1697664777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgILceheKqLDcrQ8Md1C0WGKCCTkWPoSxOmfrQfUe7M=;
        b=fUqXC97fDQR4buJItRiN+hMFVXUMcBg9WBaq1IUsfTuwDO5Tgd9LC+QiVQEuD492dy
         gcHHdwHPKWX5pfskRcOqdtSij1yQsaH3K9Py47uV+L/OUMEtmiZndvfueWY36QXMXvPh
         C/of+6qWrh5OUNdPI7RWoV+alGYVkT26b/LlFqiQPKbx0d3tb08yCg8AaKwXNkoJLxl/
         yLQavtpXr49xgEe9VfgKDxPItgHMR7kbf2axo/GwCF/IWlcBNipCnvjGnT1QFUuZ+jDL
         GsJQ/XlgfbrofkRr/zE/ZsyxahrIiQ1IsYIOZBv8MMfSfrhs+OudOo3doC/UdfkYanuo
         0Jdw==
X-Gm-Message-State: AOJu0YwFuXIGeVGaoGUE7A72UpH8ANKlMKDA7EBwhwhoPfMML/gHRcFb
        rBfo3p5us7v2ZNBBgyVF09Ys6Ertp2Y=
X-Google-Smtp-Source: AGHT+IHROiD9c1fQoFylzcx03/lxRGRjXOJ+h9nk5PoQ4SwSh2kzd4ruyHRzB7xSFhP//1f+Xr/gog==
X-Received: by 2002:aa7:d70b:0:b0:523:387d:f5f1 with SMTP id t11-20020aa7d70b000000b00523387df5f1mr20919807edq.24.1697059976998;
        Wed, 11 Oct 2023 14:32:56 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id eg42-20020a05640228aa00b0053daf92f0easm1783507edb.97.2023.10.11.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:32:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Oct 2023 23:32:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <ZScUhud9eqKIQJjC@gmail.com>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
 <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
 <20231011175407.GG6307@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011175407.GG6307@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 11, 2023 at 10:21:06AM -0600, Jens Axboe wrote:
> > On 10/9/23 8:16 AM, Jens Axboe wrote:
> > > On 10/9/23 8:13 AM, Peter Zijlstra wrote:
> > >> On Mon, Oct 09, 2023 at 11:00:19AM +0200, Arnd Bergmann wrote:
> > >>> On Mon, Oct 9, 2023, at 10:48, Peter Zijlstra wrote:
> > >>>> On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
> > >>>>> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
> > >>>>> index 5d05ab716a74,b1865f9bb31e..000000000000
> > >>>>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> > >>>>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> > >>>>> @@@ -492,4 -492,6 +492,7 @@@
> > >>>>>   560	common	set_mempolicy_home_node		sys_ni_syscall
> > >>>>>   561	common	cachestat			sys_cachestat
> > >>>>>   562	common	fchmodat2			sys_fchmodat2
> > >>>>>  -563	common	futex_wake			sys_futex_wake
> > >>>>>  -564	common	futex_wait			sys_futex_wait
> > >>>>>  -565	common	futex_requeue			sys_futex_requeue
> > >>>>>  +563	common	map_shadow_stack		sys_map_shadow_stack
> > >>>>> ++564	common	futex_wake			sys_futex_wake
> > >>>>> ++565	common	futex_wait			sys_futex_wait
> > >>>>> ++566	common	futex_requeue			sys_futex_requeue
> > >>>>
> > >>>> So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
> > >>>> Alpha does not follow the unistd order and meh.
> > >>>
> > >>> Let's not make it worse for now. All the numbers since the
> > >>> introduction of the time64 syscalls are offset by exactly 120
> > >>> on alpha, and I'd prefer to keep it that way for the moment.
> > >>>
> > >>> I still hope to eventually finish the conversion of all architectures
> > >>> to a single syscall.tbl for numbers >400, and if that happens before
> > >>> the end of alpha, a different ordering would just be extra pain.
> > >>
> > >> Fair enough; should we look at rebase those futex patches for this? (bit
> > >> of a pain as that would also mean rebasing block)
> > > 
> > > From my point of view, this isn't a huge problem if we do it now. The
> > > io_uring-futex branch is a separate branch and I have nothing on top of
> > > it, so I could easily just re-pull your updated branch and rebase my
> > > changes on top.
> > > 
> > >> Or do we want to keep this fixup in the merge resolution and make sure
> > >> Linus is aware?
> > > 
> > > If you're OK with it, I'd say let's rebase and save ourselves the
> > > trouble at merge time.
> > 
> > Peter, what's the verdict - do you want to rebase it, or leave it as-is?
> 
> Ah, I looked into doing this, but tip/locking/core has since grown a
> bunch of patches and has a merge commit -- I talked to Ingo yesterday
> and he proposed just queueing a fix on top instead of doing a full
> rebase.
> 
> Ingo, that still your preferred solution?

Yeah, that would be the best solution IMO - it's not like there's any real 
prospect of someone bisecting futex2 patch-enablement commits on Alpha ... 
and the bisection distance isn't particularly large either in any case.

[ This would also document the very real historic conflict between these 
  numbers, as it happened. ]

Thanks,

	Ingo
