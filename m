Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67C7CB5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjJPVuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjJPVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:50:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5F5AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:50:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso3337494b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697493006; x=1698097806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSyp/Bip5iNls5WLJYDt4GXcuxprjReCLiVejQ3FJcM=;
        b=K/AHbuQ51AirGRKcddjJ4UHjO1yUhNCXWNQj+iHSaNMThGyxkpPya1BmNEgFiy1hpa
         ILBC44Jmb7N0R9VMjwBS3hZCk++eeZKd0FQLJu+xT4VdvKhDszLBw0qBsi37rvLTsyKX
         9sHop3rEmRV8bHn7kUak0YpJBKqRzT/H1tSGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697493006; x=1698097806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSyp/Bip5iNls5WLJYDt4GXcuxprjReCLiVejQ3FJcM=;
        b=LkAI2GkWHqt6gJwd3m5WX+Qxx9VY6XBxN1jZJl0A/YbLmTXbEGuLUi5JLfteOjxxGv
         fpn53HEUhJsVpU3Gc7Sn9GUkThvbjhr6M4VLGxTHUVstsfNU46oBmtBok8RuieMUahsv
         O0+pLbU1UfSVHsaT64515FfsfigujCoZ066KkxoOS0V0vlMDivYrzxFmpSiT3xts3WhW
         CbQg8Firhfh74Y5nErlsNoBLslxcBzKmnEpF2JeikcV6YxIj00Gtecruw8WX9HKDBWYV
         kAe6qkxCgirnGqnMXEuWDyEQbmU5WYBbStWGW5LWjdLjPid99pat+icq8JHr9mPGX3hI
         AtBw==
X-Gm-Message-State: AOJu0YzsoeBsonb2vzKqZvZjVMP/Sy5O+cs7PZ4Rux9FJ2A+sKNnUsHz
        I8FwetM33Hy8ZkfshTu3ZTbJc8nYiyGgQrLzjX8=
X-Google-Smtp-Source: AGHT+IGejCV830CbXRzDCi2Z5qW1DlJaLYLYYKh04MVkP5xwcYrBuRosZiSq0L/FyPCidbDEycVFtw==
X-Received: by 2002:a05:6a00:22d0:b0:6be:5e64:babb with SMTP id f16-20020a056a0022d000b006be5e64babbmr504934pfj.18.1697493006180;
        Mon, 16 Oct 2023 14:50:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m16-20020a6562d0000000b005b1bf3a200fsm88589pgv.1.2023.10.16.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:50:05 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:50:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org
Subject: Re: [RESEND PATCH] uapi: increase MAX_ARG_STRLEN from 128K to 6M
Message-ID: <202310161439.BEA904AEE8@keescook>
References: <20231016212507.131902-1-slyich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016212507.131902-1-slyich@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:25:07PM +0100, Sergei Trofimovich wrote:
> Before the change linux allowed individual execve() arguments or
> environment variable entries to be only as big as 32 pages.
> 
> Histroically before b6a2fea3931 "mm: variable length argument support"
> MAX_ARG_STRLEN used to be full allowed size `argv[] + envp[]`.
> 
> When full limit was abandoned individual parameters were still limited
> by a safe limit of 128K.
> 
> Nowadays' linux allows `argv[]+envp[]` to be as laerge as 6MB (3/4
> `_STK_LIM`).

See bprm_stack_limits() for the details, but yes, 3/4 _STK_LIM tends to
be the max, unless the rlim_stack is set smaller.

> Some build systems like `autoconf` use a single environment variable
> to pass `CFLAGS` environment variable around. It's not a bug problem
> if the argument list is short.
> 
> But some packaging systems prefer installing each package into
> individual directory. As a result that requires quite long string of
> parameters like:
> 
>     CFLAGS="-I/path/to/pkg1 -I/path/to/pkg2 ..."
> 
> This can easily overflow 128K and does happen for `NixOS` and `nixpkgs`
> repositories on a regular basis.

That's ... alarming. What are you doing currently to work around this?

> 
> Similar pattern is exhibited by `gcc` which converts it's input command
> line into a single environment variable (https://gcc.gnu.org/PR111527):
> 
>   $ big_100k_var=$(printf "%0*d" 100000 0)
> 
>   # this works: 200KB of options for `printf` external command
>   $ $(which printf) "%s %s" $big_100k_var $big_100k_var >/dev/null; echo $?
>   0
> 
>   # this fails: 200KB of options for `gcc`, fails in `cc1`
>   $ touch a.c; gcc -c a.c -DA=$big_100k_var -DB=$big_100k_var
>   gcc: fatal error: cannot execute 'cc1': execv: Argument list too long
>   compilation terminated.
> 
> I would say this 128KB limitation is arbitrary.
> The change raises the limit of `MAX_ARG_STRLEN` from 32 pakes (128K
> n `x86_64`) to the maximum limit of stack allowed by Linux today.
> 
> It has a minor chance of overflowing userspace programs that use
> `MAX_ARG_STRLEN` to allocate the strings on stack. It should not be a
> big problem as such programs are already are at risk of overflowing
> stack.
> 
> Tested as:
>     $ V=$(printf "%*d" 1000000 0) ls
> 
> Before the change it failed with `ls: Argument list too long`. After the
> change `ls` executes as expected.
> 
> WDYT of abandoning the limit and allow user to fill entire environment
> with a single command or a single variable?

Changing this value shouldn't risk any vma collisions, since exec is
still checking the utilization before starting the actual process
replacement steps (see bprm->argmin).

It does seem pathological to set this to the full 6MB, though, since
that would _immediately_ get rejected by execve() with an -E2BIG, but
ultimately, there isn't really any specific limit to the length of
individual strings as long as the entire space is less than
bprm->argmin.

Perhaps MAX_ARG_STRLEN should be removed entirely and the kernel can
just use bprm->argmin? I haven't really looked at that to see if it's
sane, though. It just feels like MAX_ARG_STRLEN isn't a meaningful
limit.

-Kees

> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
> ---
>  include/uapi/linux/binfmts.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> index c6f9450efc12..4e828515a22e 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -8,11 +8,11 @@ struct pt_regs;
>  
>  /*
>   * These are the maximum length and maximum number of strings passed to the
> - * execve() system call.  MAX_ARG_STRLEN is essentially random but serves to
> - * prevent the kernel from being unduly impacted by misaddressed pointers.
> + * execve() system call.  MAX_ARG_STRLEN is as large as Linux allows new
> + * stack to grow.  Currently it's `_STK_LIM / 4 * 3 = 6MB` (see fs/exec.c).
>   * MAX_ARG_STRINGS is chosen to fit in a signed 32-bit integer.
>   */
> -#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
> +#define MAX_ARG_STRLEN (6 * 1024 * 1024)
>  #define MAX_ARG_STRINGS 0x7FFFFFFF
>  
>  /* sizeof(linux_binprm->buf) */
> -- 
> 2.42.0
> 

-- 
Kees Cook
