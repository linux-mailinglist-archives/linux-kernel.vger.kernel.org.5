Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB738800120
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjLABjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLABje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:39:34 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE3610FC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:39:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso3791a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701394777; x=1701999577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W7uBrHgrZxccbgeiWrjico6sL2HB9xoyfVd95MNJBY=;
        b=eWEj2ptkoEn3rIBufL3ozyoxd/J/UvpCPVJrvq4vfgdrFqbBe9cIin0nlSLUxReZVG
         wX04IxkbxkNkE/5J0zxeOYYjU89KfKd47xHH1qh/NCT43kmWlhjzz6AkAYVFmHmQq6cj
         z6Lv6scyYaI5R/xGMrdjdwwkmRBEHZddtCLSXu9eXCjN41p9VV6NpqmEQn5oI0oFRWRx
         cAI234H2XUN0IqKpffoBhGBxrNA9eRL9j98DrSOlIHHDrtdh6/w7PWMbQdb+7N8q8bvz
         9DBmypIYdHDNkBZlrPVmB8Ra9gbZkWgjYHjszYbacjYrj4frgauSgAObcNFljBCzCBvL
         eOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701394777; x=1701999577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W7uBrHgrZxccbgeiWrjico6sL2HB9xoyfVd95MNJBY=;
        b=CLqQGAQgrWhJeDPaXKWy4raxoYcurSmrTKl+cU75SFFIdCGkcA0L8GH0eR29my2C/Z
         H9zbIWmek1oeMFO5/NSwzNGoc7aRN+X3kCuzxShHt+oJV3lNVXEZVbZ9XEirR8s38xAc
         MWw8drQsJzYRPMoh1qj7xGcQQgvQyI9PfKNWvE+4cl8c0E7FZ4Se5wE/0bSrMl4eUhDx
         ObxyhnS4MACKP4xTg/GvZcz0JAK5pvFEYt7I7q4zHjaQK/cUsMrmfe2WydJSPQVVxnDI
         nUQNOUxIlG7SfLRE8YB9801YEG/crPk1QCo9zXhXsnvrMYChbnCehW1vPQhCUmdkDGin
         trrQ==
X-Gm-Message-State: AOJu0Yw8HYxmAR7Z1aG1cDgBiR58focql79A2sIDbW+RDn4aeHYclPQK
        nmEhv3jct5P5Cu1F+kkzQmvGy4O/pfW0ipu/iYfmbA==
X-Google-Smtp-Source: AGHT+IGeXU7GAMJTsdrcW0yrpXIG0rhuk5F8vQawv8+o8Y6yWx/tvGHuw/iYtiwKsTSmlgkbZmxa+qaWiYn3l+Cwe44=
X-Received: by 2002:a50:d547:0:b0:54c:384b:e423 with SMTP id
 f7-20020a50d547000000b0054c384be423mr19703edj.5.1701394777495; Thu, 30 Nov
 2023 17:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20231024001636.890236-1-jmattson@google.com> <20231024001636.890236-2-jmattson@google.com>
 <ZTcO8M3T9DGYrN2M@google.com> <ZWjwV7rQ9i2NCf5A@google.com>
In-Reply-To: <ZWjwV7rQ9i2NCf5A@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Nov 2023 17:39:25 -0800
Message-ID: <CALMp9eSwtVZQ_aeQ0itT7O5fDNznA2vQ0zT32VkyZS2-Q6eYZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Use a switch statement in __feature_translate()
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:28=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Oct 23, 2023, Sean Christopherson wrote:
> > On Mon, Oct 23, 2023, Jim Mattson wrote:
> > > The compiler will probably do better than linear search.
> >
> > It shouldn't matter, KVM relies on the compiler to resolve the translat=
ion at
> > compile time, e.g. the result is fed into reverse_cpuid_check().
> >
> > I.e. we should pick whatever is least ugly.
>
> What if we add a macro to generate each case statement?  It's arguably a =
wee bit
> more readable, and also eliminates the possibility of returning the wrong=
 feature
> due to copy+paste errors, e.g. nothing would break at compile time if we =
goofed
> and did:
>
>         case X86_FEATURE_SGX1:
>                 return KVM_X86_FEATURE_SGX1;
>         case X86_FEATURE_SGX2:
>                 return KVM_X86_FEATURE_SGX1;
>
> If you've no objection, I'll push this:

:barf:

Um, okay.

> --
> Author: Jim Mattson <jmattson@google.com>
> Date:   Mon Oct 23 17:16:36 2023 -0700
>
>     KVM: x86: Use a switch statement and macros in __feature_translate()
>
>     Use a switch statement with macro-generated case statements to handle
>     translating feature flags in order to reduce the probability of runti=
me
>     errors due to copy+paste goofs, to make compile-time errors easier to
>     debug, and to make the code more readable.
>
>     E.g. the compiler won't directly generate an error for duplicate if
>     statements
>
>             if (x86_feature =3D=3D X86_FEATURE_SGX1)
>                     return KVM_X86_FEATURE_SGX1;
>             else if (x86_feature =3D=3D X86_FEATURE_SGX2)
>                     return KVM_X86_FEATURE_SGX1;
>
>     and so instead reverse_cpuid_check() will fail due to the untranslate=
d
>     entry pointing at a Linux-defined leaf, which provides practically no
>     hint as to what is broken
>
>       arch/x86/kvm/reverse_cpuid.h:108:2: error: call to __compiletime_as=
sert_450 declared with 'error' attribute:
>                                           BUILD_BUG_ON failed: x86_leaf =
=3D=3D CPUID_LNX_4
>               BUILD_BUG_ON(x86_leaf =3D=3D CPUID_LNX_4);
>               ^
>     whereas duplicate case statements very explicitly point at the offend=
ing
>     code:
>
>       arch/x86/kvm/reverse_cpuid.h:125:2: error: duplicate case value '36=
1'
>               KVM_X86_TRANSLATE_FEATURE(SGX2);
>               ^
>       arch/x86/kvm/reverse_cpuid.h:124:2: error: duplicate case value '36=
0'
>               KVM_X86_TRANSLATE_FEATURE(SGX1);
>               ^
>
>     And without macros, the opposite type of copy+paste goof doesn't gene=
rate
>     any error at compile-time, e.g. this yields no complaints:
>
>             case X86_FEATURE_SGX1:
>                     return KVM_X86_FEATURE_SGX1;
>             case X86_FEATURE_SGX2:
>                     return KVM_X86_FEATURE_SGX1;
>
>     Note, __feature_translate() is forcibly inlined and the feature is kn=
own
>     at compile-time, so the code generation between an if-elif sequence a=
nd a
>     switch statement should be identical.
>
>     Signed-off-by: Jim Mattson <jmattson@google.com>
>     Link: https://lore.kernel.org/r/20231024001636.890236-2-jmattson@goog=
le.com
>     [sean: use a macro, rewrite changelog]
>     Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 17007016d8b5..aadefcaa9561 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -116,20 +116,19 @@ static __always_inline void reverse_cpuid_check(uns=
igned int x86_leaf)
>   */
>  static __always_inline u32 __feature_translate(int x86_feature)
>  {
> -       if (x86_feature =3D=3D X86_FEATURE_SGX1)
> -               return KVM_X86_FEATURE_SGX1;
> -       else if (x86_feature =3D=3D X86_FEATURE_SGX2)
> -               return KVM_X86_FEATURE_SGX2;
> -       else if (x86_feature =3D=3D X86_FEATURE_SGX_EDECCSSA)
> -               return KVM_X86_FEATURE_SGX_EDECCSSA;
> -       else if (x86_feature =3D=3D X86_FEATURE_CONSTANT_TSC)
> -               return KVM_X86_FEATURE_CONSTANT_TSC;
> -       else if (x86_feature =3D=3D X86_FEATURE_PERFMON_V2)
> -               return KVM_X86_FEATURE_PERFMON_V2;
> -       else if (x86_feature =3D=3D X86_FEATURE_RRSBA_CTRL)
> -               return KVM_X86_FEATURE_RRSBA_CTRL;
> +#define KVM_X86_TRANSLATE_FEATURE(f)   \
> +       case X86_FEATURE_##f: return KVM_X86_FEATURE_##f
>
> -       return x86_feature;
> +       switch (x86_feature) {
> +       KVM_X86_TRANSLATE_FEATURE(SGX1);
> +       KVM_X86_TRANSLATE_FEATURE(SGX2);
> +       KVM_X86_TRANSLATE_FEATURE(SGX_EDECCSSA);
> +       KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
> +       KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
> +       KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
> +       default:
> +               return x86_feature;
> +       }
>  }
>
>  static __always_inline u32 __feature_leaf(int x86_feature)
>
