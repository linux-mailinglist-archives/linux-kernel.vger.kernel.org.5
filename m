Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9917B8571
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbjJDQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjJDQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:38:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C40C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:37:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so3918014a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696437475; x=1697042275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCnkz3Hx46eh1hBNoQcDIxdcoEaIAvjMCWlF6E5v+RY=;
        b=J6M9nFeT8HN8TBRMKSfMGLz+wEYhl092iH58UeOR0u2/S6rJSTDfSdn7muJfr9teZq
         mUGTqt/vRpY4oNIDDomDsXEs62RyAJSrtVFhdAAOp++ZVrpnwPTJeXa5/rISK4Fxr2Bm
         Ig/A9JPKTjIlXm4BNdRLFHLRFhiNDxocad3G9IV4FSesg8SQfzEozhk05pVxcr6kMBgG
         uiYlXXwCymr1QKE+DbyOrV/5W0Knm7G9i9Xr/vuVrOO5fybNiRgfB6uvyS/vdYdBE84g
         TQi/LZaPJdGyl5L/HPOYog8CGdY/aIuQIB0fBmSjFxebqhOrEQn6AChbJDqD7T475Ww4
         Medw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437475; x=1697042275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCnkz3Hx46eh1hBNoQcDIxdcoEaIAvjMCWlF6E5v+RY=;
        b=eyZVxXU4G8DOn7t5+LmpjrkE1iRFCTt18HOofRF4smuRMpVgHLQCPIQxaof/QJ75WO
         B00TWybGx0Y/AnAFKUkho95WXFyQkF61QOWUmFlG9Azz0vij6V1XuV+/9dJj8CqsaQo5
         70iZIk2nXIBhQIaDd7Ev8WwEOMQ9w4vPW9lHzxiwqBogmkOzSYjxwzmnX6nZaf9/t+QS
         Gds58+fA8R0h5nWFEdvXeSvRcYP73xR0NPejCcw9rKiXPlwZnJ5hBrn7evALmFqY1xoj
         Yc9s5ltYOM1puCa1bUOvkcsVLlSdRP5RsIMgypWE2D6QtaWzRb3qI+5NjPOZVbNP7YS+
         PYZA==
X-Gm-Message-State: AOJu0YzDXzOlEjUVp4zMPCulbhqqj0IJ/sEuhOJrbsgl17PfrQfgqp0M
        Nl2Y6/gTgFI2VQZqh3WuvI0=
X-Google-Smtp-Source: AGHT+IEX5htyiuNpq5McYRPRe7HNmuS1twftKS/PuJWBn8TjJl6KPLOjPmHSPI1qbNPhX+Xsycv9Sg==
X-Received: by 2002:a05:6402:6d4:b0:533:4c67:c911 with SMTP id n20-20020a05640206d400b005334c67c911mr2639090edy.19.1696437474993;
        Wed, 04 Oct 2023 09:37:54 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id f11-20020a056402160b00b00532eba07773sm110900edv.25.2023.10.04.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:37:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 18:37:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZR2U4DLycLT5xFH6@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004145137.86537-5-ubizjak@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> The percpu code mostly uses inline assembly. Using segment qualifiers
> allows to use C code instead, which enables the compiler to perform
> various optimizations (e.g. propagation of memory arguments). Convert
> percpu read and write accessors to C code, so the memory argument can
> be propagated to the instruction that uses this argument.
> 
> Some examples of propagations:
> 
> a) into sign/zero extensions:
> 
>  110b54:       65 0f b6 05 00 00 00    movzbl %gs:0x0(%rip),%eax
>  11ab90:       65 0f b6 15 00 00 00    movzbl %gs:0x0(%rip),%edx
>  14484a:       65 0f b7 35 00 00 00    movzwl %gs:0x0(%rip),%esi
>  1a08a9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax
>  1a08f9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax
> 
>  4ab29a:       65 48 63 15 00 00 00    movslq %gs:0x0(%rip),%rdx
>  4be128:       65 4c 63 25 00 00 00    movslq %gs:0x0(%rip),%r12
>  547468:       65 48 63 1f             movslq %gs:(%rdi),%rbx
>  5474e7:       65 48 63 0a             movslq %gs:(%rdx),%rcx
>  54d05d:       65 48 63 0d 00 00 00    movslq %gs:0x0(%rip),%rcx

Could you please also quote a 'before' assembly sequence, at least once
per group of propagations?

Ie. readers will be able to see what kind of code generation changes
result in this kind of text size reduction:

>    text    data     bss     dec     hex filename
> 25508862        4386540  808388 30703790        1d480ae vmlinux-vanilla.o
> 25500922        4386532  808388 30695842        1d461a2 vmlinux-new.o

Thanks,

	Ingo
