Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D179F7B8F57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbjJDV26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJDV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:28:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF129E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 14:28:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so304090f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696454932; x=1697059732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOrt1OMVcS1GeLKT3xwXjNRDdAC0gAN5SlUNcwokFVQ=;
        b=hfKUdWQpCkK8hp1wReD/7E0G/btiaxAHehm5tIwGlBThGXVtDcUK1M7ilKimVX1tNk
         gpvhX32opr6aCo4Vp2vrqs0kZid8rf7DFVRBuut3equpbYZTn91D/OebKiqy3bLFhjzJ
         qK3G+sNibsDl4uupwEqe1RzzffIAlu7GeKe44ZxMV/O4wxDXvTn8Z3cuX2tcPlxUGOP1
         VDUG3AqMrC1yr792hp51Wx0Wb6AwKLn0OTyX2jfkIcDSIC2+OQOM0Lkwea+Hd6YFafX5
         Tn3/BaPLqgs4ss+BI0Oo9TGJsQLNXednQ7gvhBcutVEKNKFtDQ7hRRBxhtw4Qj39My5I
         ANcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696454932; x=1697059732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOrt1OMVcS1GeLKT3xwXjNRDdAC0gAN5SlUNcwokFVQ=;
        b=EHWnFCoULAwFleRALe8NtkeNNqfTWwWz/zHmxMDxaNV3UhSmX08aIUMKiRnWOsz0q3
         hqdcXDW78eZqwhQrdYXQymZo0ZOCkDUOQhX1QDZnzebF1FKun0X+QCOt39LzwgAVhdtn
         ZkMcSdK7MIgDgu/ZyBZjV8w70kxDCbVNK5/RxGa70OBzKDZnawch17hQv3NMAudfTzIM
         IJGM9v9sp4dECzhp+B4zWsz5lnlPKVC/XWr/SUwxsAEKdecjf21Sz3sI6E0aPCb1RNJd
         X86f0yTH6lP5RhUYDJs1O/wy9gz97r0slxe8jsn5LQysUQxamDdtnAV0hEjyzO44wWU5
         ZO2Q==
X-Gm-Message-State: AOJu0YxKXhLQ0vPNxU8v7Pue3DR/nXwicTN07canpvs0wNg9/+S71UjL
        AtVjQCsdEMxxC/VoOLnLPHJ55IYqJpCZrA==
X-Google-Smtp-Source: AGHT+IEg8xPRmGiNWfEyS+qHPHYhvBnEcmfHeFveJut9mgFThXgBbAGTCVoYkJT4lzylzsCNTY+ncw==
X-Received: by 2002:adf:fe0d:0:b0:31f:e5cf:6724 with SMTP id n13-20020adffe0d000000b0031fe5cf6724mr3306067wrr.46.1696454932284;
        Wed, 04 Oct 2023 14:28:52 -0700 (PDT)
Received: from nz.home (host86-139-202-110.range86-139.btcentralplus.com. [86.139.202.110])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d628c000000b003233a31a467sm96273wru.34.2023.10.04.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:28:51 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id CFB46113E8E960; Wed,  4 Oct 2023 22:28:50 +0100 (BST)
Date:   Wed, 4 Oct 2023 22:28:50 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] uapi: increase MAX_ARG_STRLEN from 128K to 6M
Message-ID: <ZR3ZEniQLzzRKwqP@nz>
References: <20230924193005.1721655-1-slyich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924193005.1721655-1-slyich@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 08:30:05PM +0100, Sergei Trofimovich wrote:
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
> 
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
> 
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>

Ping.

Also +CC: Andrew Morton <akpm@linux-foundation.org>
in case mm tree is a reasonable place for this change.

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

  Sergei
