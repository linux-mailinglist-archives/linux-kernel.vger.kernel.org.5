Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6E772508
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjHGNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjHGNID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:08:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E541735
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:07:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso7065987e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691413677; x=1692018477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/4R25p4daYUTehiyP/H6NfDF6hC+5JyB6EXsqzz6/k=;
        b=CZsy0pok8t9/vlnLGm4O8VdNxEk0CcQX2MtFvzA2zSKcr8mMAe0DHTmVORe3TDmzNw
         NlF98o2pOwjM3gbhA2QBbnDzxhJUiV/U14l+nq8StfHXCTZfVHlYP9ZlKqXusZ0MlNLC
         SK3ueVaMMD7GEHVsMwmSnVoS7V8McfsYWRjgqBM+Dqysuzn0htMOI8pLZIeMOL9V8kOk
         GfsDu5bZ2tVfFVCrEahlI24fLYcd2yhZRD9SE6+P+EWGV2iJoZJ7auhrzdCqn5PTf3VO
         EflwubvyoVGschLEAI4Xekv7e/Ols84VsR0+dEphPPzqt92Kz0IAjzB3qzrSudUbP8jb
         92KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413677; x=1692018477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/4R25p4daYUTehiyP/H6NfDF6hC+5JyB6EXsqzz6/k=;
        b=lt/ULVoyq0QxIsjdnGNpm66JZ1nVM5T0Dvr+eIwqMwPCllkanaFR6iwYP0DHmViSIP
         MwgfI7i0E/pZ7wS8oLmm5h20OmijXN4/Dm7Ls1ShvQ4qE4nxHP+q7joVj7Jfw+F4kviN
         lZR5SqLeTDQij2queRG6HM2HtPp2RK7vcopc8HhzEMNVsxNrnJBKqp6MCRA8lhYlujz1
         lKr2ppBXXcStBLHfCBWV5HXWMNvmfOrdg+TfjQC2Fxxc6oL9Q0ogwNeTuWQgf4augWR8
         a0K3T90AHHh7ykdZOlS+pkU0FEfUhUuSGCdWM8XN9buh22P4JbzLJEZtaDa2DR2bP5qB
         NgdA==
X-Gm-Message-State: AOJu0YwskT1Rf9Gva2l5Xzo6h9tnI7wR8PGEwDJAj5EdTQTjl23rc9xd
        wuQrtCZDDJ+VuA8W1wM4YGbOZeCIC39AEX3RSJgYtJi91umrEf12Urk=
X-Google-Smtp-Source: AGHT+IG88guCru7RMnods2FuhCiVzsW89iZtW1ovHWdm8V/bf9L2PO5Zpf2azd4F+0e536gG22KOf2XlazGJw24fQoo=
X-Received: by 2002:a05:6512:358b:b0:4fd:d4b4:faba with SMTP id
 m11-20020a056512358b00b004fdd4b4fabamr5211620lfr.51.1691413677214; Mon, 07
 Aug 2023 06:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230804090621.400-1-elver@google.com> <87il9rgjvw.fsf@oldenburg.str.redhat.com>
 <CANpmjNN4h2+i3LUG__GHha849PZ3jK=mBoFQWpSz4jffXB4wrw@mail.gmail.com> <87pm3zf2qi.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87pm3zf2qi.fsf@oldenburg.str.redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Aug 2023 15:07:20 +0200
Message-ID: <CANpmjNMoxZYZQNyZcnci_rC6d6X4WKpS+fX9goaBdGCJFPjUNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 at 14:37, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Marco Elver:
>
> > Good idea. I had already created
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899, and we need
> > better spec to proceed for GCC anyway.
>
> Thanks for the reference.
>
> >> Doesn't this change impact the kernel module ABI?
> >>
> >> I would really expect a check here
> >>
> >> > +#if __has_attribute(__preserve_most__)
> >> > +# define __preserve_most notrace __attribute__((__preserve_most__))
> >> > +#else
> >> > +# define __preserve_most
> >> > +#endif
> >>
> >> that this is not a compilation for a module.  Otherwise modules built
> >> with a compiler with __preserve_most__ attribute support are
> >> incompatible with kernels built with a compiler without that attribute.
> >
> > That's true, but is it a real problem? Isn't it known that trying to
> > make kernel modules built for a kernel with a different config (incl.
> > compiler) is not guaranteed to work? See IBT, CFI schemes, kernel
> > sanitizers, etc?
> >
> > If we were to start trying to introduce some kind of minimal kernel to
> > module ABI so that modules and kernels built with different toolchains
> > keep working together, we'd need a mechanism to guarantee this minimal
> > ABI or prohibit incompatible modules and kernels somehow. Is there a
> > precedence for this somewhere?
>
> I think the GCC vs Clang thing is expected to work today, isn't it?

I, personally, wouldn't bet on it. It very much depends on the kernel
config used.

> Using the Clang-based BPF tools with a GCC-compiled kernel requires a
> matching ABI.

BPF is a different story altogether, and falls more into the category
of user space to kernel ABI, which the kernel has strong guarantees
on.

> The other things you listed result in fairly obvious breakage, sometimes
> even module loading failures.  Unconditional crashes are possible as
> well.  With __preserve_most__, the issues are much more subtle and may
> only appear for some kernel/module compielr combinations and
> optimization settings.  The impact of incorrectly clobbered registers
> tends to be like that.

One way around this would be to make the availability of the attribute
a Kconfig variable. Then externally compiled kernel modules should do
the right thing, since they ought to use the right .config when being
built.

I can make that change for v3.
