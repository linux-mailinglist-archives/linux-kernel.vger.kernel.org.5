Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087A27B9F00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJEOQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjJEOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:14:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58EE8A41
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 01:22:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b29186e20aso119802066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696494164; x=1697098964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jQQJxd6dOB2gxdXeC98PsArnKEuy3fLi6y1AP5DJ+c=;
        b=gK7ntby56CRoLWkn5EinG0LNoL6l0bmwNTHvKSlosVIWTFm45yqj9IWzjEmNxDDclQ
         xIy3pzmolVkHv5HoF01bPoC4nFW1UqnpSi9MIsBOleebGRpbUIHrFKupdbxMl1RiiJMK
         nV7tq4MEKtRn/AAOXTRnfbSkTQLSlDT/aSQXHLBL2rNl4cguf7GQVCyZaPPahFhVJ9hf
         5u37KxuQN0CWuumxn2PnsZFqsdleLaLTZaNWLECMbWnspmowdM0ZUATijjOHlSVrrrvl
         QTWki8Bfjx4rr1DTjEji8Dc1bZg7K0Bg1fU7wmJziwoTZMfOIl+R/K6j0ueB+cIkZQ2j
         RtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696494164; x=1697098964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jQQJxd6dOB2gxdXeC98PsArnKEuy3fLi6y1AP5DJ+c=;
        b=NbSADK39A+cIvzsJFcDaofAjeMUqjKMuMGHSlaVIuDqWa0Jj+Xh7/vz8ZVIBAIV9Fe
         puARUQ3TsmEAmRYRdOychS677QiDL7J39L1WhmZGwKxTdQ+5ghd7cJ4KYoXrZblvUanz
         FxgMMOcyOClMtsMtnF5LuyARjfHDQnJbWD4+Hz/g9rd2JgkFG5NLgA3MRMERsDov3chZ
         28N7yNQi3NzMa+2trxH7g7Iw9sJkNTUDjYzNYXgXFNIO7tVt6+9i2ERdBRgAp4TIHstE
         BCoQHCoAjmn5dW0im3F4vfLHZGDrdMHKHKrUNuLUPnTynL8z4eG49yFbxEkjKZkgIs7/
         8ofQ==
X-Gm-Message-State: AOJu0YweZhIRXogJRd9bKZGj3v6LFg2gmDTKc87GR10Szoc7I1sbFi4Y
        bkHRLKJOq4pJiK5n6AFREa8=
X-Google-Smtp-Source: AGHT+IE0ByjZ7iW1woTnwon2tTZN0fCI39g2pOv5ZI23/vs5+lkPFgHdqD+2ZKx82w6eicN0Aq0/ZQ==
X-Received: by 2002:a17:906:73d1:b0:9b6:4b5d:7758 with SMTP id n17-20020a17090673d100b009b64b5d7758mr4648863ejl.68.1696494164009;
        Thu, 05 Oct 2023 01:22:44 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id y23-20020a1709064b1700b009aa292a2df2sm753275eju.217.2023.10.05.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:22:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Oct 2023 10:22:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
Message-ID: <ZR5yTecBhCFsVOtQ@gmail.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721161018.50214-1-brgerst@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Brian Gerst <brgerst@gmail.com> wrote:

> This patch set cleans up the tests done to determine if a fast syscall
> return instruction can be used to return to userspace.  It converts the
> code to C, and refactors existing code to be more readable.
> 
> v2:
>  - Fix shift value for canonical RIP test and use
>    __is_canonical_address()
> 
> Brian Gerst (6):
>   x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
>   x86/entry/64: Convert SYSRET validation tests to C
>   x86/entry/compat: Combine return value test from syscall handler
>   x86/entry/32: Convert do_fast_syscall_32() to bool return type
>   x86/entry/32: Remove SEP test for SYSEXIT
>   x86/entry/32: Clean up syscall fast exit tests
> 
>  arch/x86/entry/common.c          | 99 +++++++++++++++++++++-----------
>  arch/x86/entry/entry_32.S        |  2 +-
>  arch/x86/entry/entry_64.S        | 68 +---------------------
>  arch/x86/entry/entry_64_compat.S | 12 ++--
>  arch/x86/include/asm/syscall.h   |  6 +-
>  5 files changed, 77 insertions(+), 110 deletions(-)

Ok, so I've applied patches #1, #3, #4 and #5 to tip:x86/entry,
(ie. skipped #2 & #6 for now), as they look correct and are good
improvements. None of these four patches depend on the skipped
patches in some way I missed, correct?

As for #2, I looked at the before/after disassembly, and the new
C code in do_syscall_64() looked suboptimal on x86-64 defconfig,
if I was reading it right.

Mind re-evaluating that, and if you still think the C conversion
is a good idea, mind putting a before/after analysis of the
generated instructions into the changelog? This is our primary
system call return path after all.

Thanks,

	Ingo
