Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6720A7CC955
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjJQRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjJQQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:59:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506DED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:59:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so2856588b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697561994; x=1698166794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8F1UdIngC4vnyCLK3EqRafpf+LMFRngQaqPKzU0Jzo=;
        b=X58ze307t1605cQ7MIHayf+xXg1o618cYN6FXrC1/edZUZxKDuhPN5uv4WkSM29auu
         LgpgA1hYeiTJ3w8rRzFDG3xCtMLQgkVTlwbES+uQRfUxjz2xBWzxa0L5Mva9YeUSvBvG
         WnVEKkkYAK54pq8UkPgHzb1pz2RGcLeNUQa+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561994; x=1698166794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8F1UdIngC4vnyCLK3EqRafpf+LMFRngQaqPKzU0Jzo=;
        b=UgtSuMriApqiXAOKI+asTsgp/PL4uHRedKaFyiEoLQKQVrdlQ2r1xryt5zyj+ucAKL
         lPZ++5N072WAfScJZDmTYRU76BJP5cOhEUSBMwYgXzpV+yEuJ0FPGmWDewJPHWMdBErq
         nhpR/vPhq8hsQXymBo0WiXAO1R50e0XgT6aZ0NeaXl5mHPlXFjEZx60NdwxcYDOtN/dP
         pmVlLHaA3+ytB8P5Jf/fbcYLnVpDfNbyxE0SbieOjGoFulOUnK6+1/zR8f28fM4Y2kqo
         MrQ0eeqMeyDcETt1ohQ0u0IYSibMNTPbl48Xiuo1aqzYOEYoxNBWPYJnXPeEkQBKEPeW
         NYzg==
X-Gm-Message-State: AOJu0YzJRJr4DRUd4KHPteQQZySiIjNejXWfErTeBNEWRbd8hq/Ipwru
        13sumfC0lW8FrO8Hk2I5oisTeg==
X-Google-Smtp-Source: AGHT+IG6W4hgvGPyQk9HyU8a3OI89HiiQNoqDs7LZWa1NayZGlQuwkBq/thcBBgiM8kc7RQsNaeUqA==
X-Received: by 2002:a05:6a21:3d85:b0:157:e4c6:766a with SMTP id bj5-20020a056a213d8500b00157e4c6766amr2419600pzc.41.1697561993806;
        Tue, 17 Oct 2023 09:59:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001c755810f89sm1828088plc.181.2023.10.17.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:59:53 -0700 (PDT)
Date:   Tue, 17 Oct 2023 09:59:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org
Subject: Re: [RESEND PATCH] uapi: increase MAX_ARG_STRLEN from 128K to 6M
Message-ID: <202310170957.DF7F7FE9FA@keescook>
References: <20231016212507.131902-1-slyich@gmail.com>
 <202310161439.BEA904AEE8@keescook>
 <20231016233318.2b41ae06@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016233318.2b41ae06@nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:33:18PM +0100, Sergei Trofimovich wrote:
> On Mon, 16 Oct 2023 14:50:05 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, Oct 16, 2023 at 10:25:07PM +0100, Sergei Trofimovich wrote:
> > > Before the change linux allowed individual execve() arguments or
> > > environment variable entries to be only as big as 32 pages.
> > > 
> > > Histroically before b6a2fea3931 "mm: variable length argument support"
> > > MAX_ARG_STRLEN used to be full allowed size `argv[] + envp[]`.
> > > 
> > > When full limit was abandoned individual parameters were still limited
> > > by a safe limit of 128K.
> > > 
> > > Nowadays' linux allows `argv[]+envp[]` to be as laerge as 6MB (3/4
> > > `_STK_LIM`).  
> > 
> > See bprm_stack_limits() for the details, but yes, 3/4 _STK_LIM tends to
> > be the max, unless the rlim_stack is set smaller.
> > 
> > > Some build systems like `autoconf` use a single environment variable
> > > to pass `CFLAGS` environment variable around. It's not a bug problem
> > > if the argument list is short.
> > > 
> > > But some packaging systems prefer installing each package into
> > > individual directory. As a result that requires quite long string of
> > > parameters like:
> > > 
> > >     CFLAGS="-I/path/to/pkg1 -I/path/to/pkg2 ..."
> > > 
> > > This can easily overflow 128K and does happen for `NixOS` and `nixpkgs`
> > > repositories on a regular basis.  
> > 
> > That's ... alarming. What are you doing currently to work around this?
> 
> We usually try to stay under the threshold. When the problem arises due
> to organic growth of inputs over time we either suffer build failures
> without any reasonable workarounds or if the change was recent and
> inflated command line options we revert the change and add hacks into
> other places (like patching `gcc` directly to apply the
> transformations).
> 
> Longer term it would be nice for `gcc` to allow unbounded output via
> response files, but it will take some time to sort out as current flags
> rewriting expands all flags and response files into a single huge
> variable and hits the 128K limit:
> 
>     https://gcc.gnu.org/pipermail/gcc/2023-October/242641.html
> 
> Medium term dropping kernel's arbitrary small limit (this change) sounds
> like the simplest solution.
> 
> > > 
> > > Similar pattern is exhibited by `gcc` which converts it's input command
> > > line into a single environment variable (https://gcc.gnu.org/PR111527):
> > > 
> > >   $ big_100k_var=$(printf "%0*d" 100000 0)
> > > 
> > >   # this works: 200KB of options for `printf` external command
> > >   $ $(which printf) "%s %s" $big_100k_var $big_100k_var >/dev/null; echo $?
> > >   0
> > > 
> > >   # this fails: 200KB of options for `gcc`, fails in `cc1`
> > >   $ touch a.c; gcc -c a.c -DA=$big_100k_var -DB=$big_100k_var
> > >   gcc: fatal error: cannot execute 'cc1': execv: Argument list too long
> > >   compilation terminated.
> > > 
> > > I would say this 128KB limitation is arbitrary.
> > > The change raises the limit of `MAX_ARG_STRLEN` from 32 pakes (128K
> > > n `x86_64`) to the maximum limit of stack allowed by Linux today.
> > > 
> > > It has a minor chance of overflowing userspace programs that use
> > > `MAX_ARG_STRLEN` to allocate the strings on stack. It should not be a
> > > big problem as such programs are already are at risk of overflowing
> > > stack.
> > > 
> > > Tested as:
> > >     $ V=$(printf "%*d" 1000000 0) ls
> > > 
> > > Before the change it failed with `ls: Argument list too long`. After the
> > > change `ls` executes as expected.
> > > 
> > > WDYT of abandoning the limit and allow user to fill entire environment
> > > with a single command or a single variable?  
> > 
> > Changing this value shouldn't risk any vma collisions, since exec is
> > still checking the utilization before starting the actual process
> > replacement steps (see bprm->argmin).
> > 
> > It does seem pathological to set this to the full 6MB, though, since
> > that would _immediately_ get rejected by execve() with an -E2BIG, but
> > ultimately, there isn't really any specific limit to the length of
> > individual strings as long as the entire space is less than
> > bprm->argmin.
> > 
> > Perhaps MAX_ARG_STRLEN should be removed entirely and the kernel can
> > just use bprm->argmin? I haven't really looked at that to see if it's
> > sane, though. It just feels like MAX_ARG_STRLEN isn't a meaningful
> > limit.
> 
> Removing the limit entirely in favour of 'bprm->argmin' sounds good.
> I'll try to make it so and will send v2.
> 
> What should be the fate of userspace-exported `MAX_ARG_STRLEN` value in
> that case? Should it stay `(PAGE_SIZE * 32)`? Should it be removed
> entirely? (a chance of user space build failures).
> 
> If we are to remove it entirely what should be the reasonable limit in
> kernel for other subsystems that still use it?
> 
>     fs/binfmt_elf.c: len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
>     fs/binfmt_elf_fdpic.c: len = strnlen_user(p, MAX_ARG_STRLEN);
>     fs/binfmt_flat.c: len = strnlen_user(p, MAX_ARG_STRLEN);
>     kernel/auditsc.c: len_full = strnlen_user(p, MAX_ARG_STRLEN) - 1;
> 
> Keeping it at an "arbitrary" 6MB limit looked safe :)

Yeah, I think leaving MAX_ARG_STRLEN totally unchanged but adjust where
it is used only for the ELF loader is probably the least risky thing to
do here.

-Kees

> 
> > -Kees
> > 
> > > 
> > > CC: Andrew Morton <akpm@linux-foundation.org>
> > > CC: Eric Biederman <ebiederm@xmission.com>
> > > CC: Kees Cook <keescook@chromium.org>
> > > CC: linux-mm@kvack.org
> > > CC: linux-kernel@vger.kernel.org
> > > Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
> > > ---
> > >  include/uapi/linux/binfmts.h | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> > > index c6f9450efc12..4e828515a22e 100644
> > > --- a/include/uapi/linux/binfmts.h
> > > +++ b/include/uapi/linux/binfmts.h
> > > @@ -8,11 +8,11 @@ struct pt_regs;
> > >  
> > >  /*
> > >   * These are the maximum length and maximum number of strings passed to the
> > > - * execve() system call.  MAX_ARG_STRLEN is essentially random but serves to
> > > - * prevent the kernel from being unduly impacted by misaddressed pointers.
> > > + * execve() system call.  MAX_ARG_STRLEN is as large as Linux allows new
> > > + * stack to grow.  Currently it's `_STK_LIM / 4 * 3 = 6MB` (see fs/exec.c).
> > >   * MAX_ARG_STRINGS is chosen to fit in a signed 32-bit integer.
> > >   */
> > > -#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
> > > +#define MAX_ARG_STRLEN (6 * 1024 * 1024)
> > >  #define MAX_ARG_STRINGS 0x7FFFFFFF
> > >  
> > >  /* sizeof(linux_binprm->buf) */
> > > -- 
> > > 2.42.0
> > >   
> > 
> > -- 
> > Kees Cook
> 
> 
> -- 
> 
>   Sergei

-- 
Kees Cook
