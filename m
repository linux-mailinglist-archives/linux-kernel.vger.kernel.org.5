Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5576F60E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHCXRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHCXR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:17:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA130C4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:17:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686c06b806cso1077099b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691104646; x=1691709446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAX8/BAoKRR9bpEyT2pUxkYfnwIbAbYh0zgu7kZ+rdo=;
        b=M3JW4qbzHMtiBaVV+XfFBn1fsvKda9lPpptkVIw8hZm/FUU95/wvAXWV+n7Bo0xrSN
         XpQeyyNevHkjeS8VMIGwQK+EdGDhSk/5ZTxmG6HHRdjV3/sPQ5JPcl3IQlrdDxc145c7
         ZTaNF/CEIIPTHkwJu1goZt4kjifTLnNJR9x+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104646; x=1691709446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAX8/BAoKRR9bpEyT2pUxkYfnwIbAbYh0zgu7kZ+rdo=;
        b=NAafIN1WWCwuZpKG1ciRHze8E22diztHDAB22YmVSDewWmKW5c3KeS57iV+GcuR5f4
         WnNmWzumfbqY6IFLvdp+hS+K6m6iSwaybOte9S8T1UUJ9uLM1wnYOAK9GRTz5YRopFjV
         knZ1viErzto2hSocNpfTd0/SHfwjTp4NL2PjJb9DlInYC+YcKFuSSSkRJNM7frQANtII
         Lk1SoLxLIzoxgUYfTDmnlqATvDemExMVtjbpqEOQDSMfQxoGdJUqOdNWxyybOjNV0Uel
         R4NsERRXMtHn0RcD3MIHCph0dOcTa0997LIxVEXqEJdY3iRSGKUbmkWFXIMkso3zAHF6
         zqEQ==
X-Gm-Message-State: AOJu0YysjCfr6z96JraRjg6+pWo35vL+cEV0nW2eJw4btohQVjj38glO
        DQhps0JizCS0Cs3Ipet7bvT+hQ==
X-Google-Smtp-Source: AGHT+IEj4C/z2qsGxkJgyRwpjg3NqlxZEdhHZ0f66XagZ0cXhYhmwUvu1RZI32U+pelJi/n6ndb3KA==
X-Received: by 2002:a05:6a00:150d:b0:686:254c:9d4e with SMTP id q13-20020a056a00150d00b00686254c9d4emr108098pfu.14.1691104646559;
        Thu, 03 Aug 2023 16:17:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u19-20020a62ed13000000b00653fe2d527esm360174pfh.32.2023.08.03.16.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:17:25 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:17:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        yj.chiang@mediatek.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 04/10] ARM: syscall: always store
 thread_info->abi_syscall
Message-ID: <202308031551.034F346@keescook>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726141141.2839385-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 04:11:35PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The system call number is used in a a couple of places, in particular
> ptrace, seccomp and /proc/<pid>/syscall.

*thread necromancy*

Hi!

So, it seems like the seccomp selftests broke in a few places due to
this change (back in v5.15). I really thought kernelci.org was running
the seccomp tests, but it seems like the coverage is spotty.

Specifically, the syscall_restart selftest fails, as well as syscall_errno
and syscall_faked (both via seccomp and PTRACE), starting with this patch.

> The last one apparently never worked reliably on ARM for tasks that are
> not currently getting traced.
> 
> Storing the syscall number in the normal entry path makes it work,
> as well as allowing us to see if the current system call is for OABI
> compat mode, which is the next thing I want to hook into.
> 
> Since the thread_info->syscall field is not just the number any more, it
> is now renamed to abi_syscall. In kernels that enable both OABI and EABI,
> the upper bits of this field encode 0x900000 (__NR_OABI_SYSCALL_BASE)
> for OABI tasks, while normal EABI tasks do not set the upper bits. This
> makes it possible to implement the in_oabi_syscall() helper later.
> 
> All other users of thread_info->syscall go through the syscall_get_nr()
> helper, which in turn filters out the ABI bits.

While I've reproducing the bisect done by mediatek, I'm still poking
around in here to figure out what's gone wrong. There was a recent patch
to fix this, but it looks like it's not complete:
https://lore.kernel.org/all/20230724121655.7894-1-lecopzer.chen@mediatek.com/

With the above applied, syscall_errno and syscall_faked start working
again, but not the syscall_restart test.

> Note that the ABI information is lost with PTRACE_SET_SYSCALL, so one
> cannot set the internal number to a particular version, but this was
> already the case. We could change it to let gdb encode the ABI type along
> with the syscall in a CONFIG_OABI_COMPAT-enabled kernel, but that itself
> would be a (backwards-compatible) ABI change, so I don't do it here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Another issue of note, which may just be "by design" for arm32, is that
an invalid syscall (or, at least, a negative syscall) results in SIGILL,
rather than a errno=ENOSYS failure. This seems to have been true at least
as far back as v5.8 (where this was cleaned up for at least arm64 and
s390). There was a seccomp test added for it in v5.9, but it has been
failing for arm32 since then. :(

I mention this because the behavior of the syscall_restart test looks
like an invalid syscall: on restart a SIGILL is caught instead of the
syscall correctly continuing.

Anyway, I'll keep debugging this, but figured I'd mention it in case
anyone else had been seeing issues in here.

-Kees

-- 
Kees Cook
