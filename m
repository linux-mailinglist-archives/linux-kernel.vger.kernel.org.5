Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CC76D733
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjHBSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjHBSwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:52:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B602C1FF3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:52:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso1763525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691002326; x=1691607126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e52Aik7+FekPE4EeT0gUdOPtk6uJBw/P3h7TeG+ZQTM=;
        b=WfVLnk4FWXPNM0WW627hTSTpm7C1QI/GaOlJ/IVv7BwfSgJZ1fD4ypk5OZ8R4EARS8
         CSrHuK7ypa5A+bPWY7otmO7cd8gXEJ6oH8W7EpMd/T7W1knurhj8U/6aodvbqWV3Ztvy
         RGw+qHxhDKdzspoRfTT326Svc/BjrRc2YFlcO/qpICZ2gsdzQlEf3rE/caVy55R8yUmX
         EWZKiBE+y501N0kpmXdMBFH38U2FoYKpAcQMNEb5K2rmcmrHJb/y1JxNpJ8a7wIbb76m
         FGC1n5C8fy/vs4Nq5jKJsUKG+AEaEx9rFb8B+AIzmU4qZ5gYWug1jbhFhWKIYg6fQfJU
         iJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002326; x=1691607126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e52Aik7+FekPE4EeT0gUdOPtk6uJBw/P3h7TeG+ZQTM=;
        b=BEUM3UNcBgeQJLkigrr850ymN6HKWszaD6JG4lM01UeGm2WpQoXLvsFDwrh8i1srLc
         l1Gt0o4SCgj4jD4LiYB+5bjhI0MkDnqfu7aYsDiL0mVYJjB7kJ7SPIMD/hAO13K14G6e
         jCC0cAhnMB4pqyrkFBdD5yNkymR4Im1U4q326ljo726F6KZo7yhulVF7o9ecX2CU3Cud
         Wy6daR5PRXHBK+IcNCTmJlyo7cc8uaCSfsWiULj7gcTpruaTuJuxYcx6Q5ZkJLBg/FN9
         DaLk9ap4L2jS+sTbJIlj1V2bPNOdJWd8/rOmW4X2jXNII7ChbgHHMLSXsuvtUm2l26uY
         UgKg==
X-Gm-Message-State: ABy/qLaKGqUx1PmVfpia+H9za06u+yhQLD8a31NIDQihERs0tR0r/0Os
        iQCiecQRTa+FAmRHLTngrZQ3vtvZ5ynZMTBOW9Twpw==
X-Google-Smtp-Source: APBJJlFGJmuh9G19C0lrt8whk0BOd6695zMBbC3wUwduITvwBCYcOoVfLa4zq2ZnVZjsm9Lnt615gAFmoBX8dXCD6VU=
X-Received: by 2002:a7b:c3d5:0:b0:3fb:b34f:6cd6 with SMTP id
 t21-20020a7bc3d5000000b003fbb34f6cd6mr5624229wmj.41.1691002326042; Wed, 02
 Aug 2023 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230802150712.3583252-1-elver@google.com> <20230802110303.1e3ceeba5a96076f723d1d08@linux-foundation.org>
In-Reply-To: <20230802110303.1e3ceeba5a96076f723d1d08@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Aug 2023 20:51:29 +0200
Message-ID: <CANpmjNNZ7sRLxCFF0jTZvOK6s-=Z=DOAy8uz=B-i22GEnhNjbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Compiler attributes: Introduce the __preserve_most
 function attribute
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 20:03, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  2 Aug 2023 17:06:37 +0200 Marco Elver <elver@google.com> wrote:
>
> > [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> > convention of a function. The preserve_most calling convention attempts
> > to make the code in the caller as unintrusive as possible. This
> > convention behaves identically to the C calling convention on how
> > arguments and return values are passed, but it uses a different set of
> > caller/callee-saved registers. This alleviates the burden of saving and
> > recovering a large register set before and after the call in the
> > caller."
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most
> >
> > Use of this attribute results in better code generation for calls to
> > very rarely called functions, such as error-reporting functions, or
> > rarely executed slow paths.
> >
> > Introduce the attribute to compiler_attributes.h.
>
> That sounds fairly radical.  And no changes are needed for assembly
> code or asm statements?

The callee in this case is supposed to save the registers and restore
them. If the caller (such as in asm) redundantly saves the registers
as well, this would be safe although redundant. That being said, there
are no plans to call functions marked with the attribute from asm.
Only issue would be if someone implements such a function in asm with
a C decl with the attribute - but also, there are no plans to do this.

I'll need to spin a v2 to always add notrace: one way this can go
wrong if something inserts itself between the callers and callee, such
as tracing would.
