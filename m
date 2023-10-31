Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0ED7DCCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjJaMVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjJaMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:21:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD04A9;
        Tue, 31 Oct 2023 05:21:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485A7C433D9;
        Tue, 31 Oct 2023 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698754870;
        bh=PBJz/BrjrQ+BZWJuJDf0iAVLoQB4EhQcSVaeUL/zAL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fvw0pBvBFfSYJREjnnEiNmfvMc2qyBHx2wcaC5c7TD5UqvhGCfjF4UduWgvpg09LE
         FtyW2AVvu5qPxE98BVJOQVtXQW405pkmtLkM9JQC4N6QKdKMZALUH8fkAjmVwJB+bq
         0snZ6s/36uo3k8JzSICVJtF+GmNozU4whl13hFQFBLRPRdsKUYDlasmvXf90/I4NMT
         QeQagMaIOD4xb4hGfMP8++TtkUwONADA10chh3TihRO9EB8dBHE7E/KNlOxbvxI50J
         4WZQZi6yQKx18lGeg4kKo8/e76h0ivZQL6NcBI1JHZKSrgmWQw3k2jQz3bEsOdaiFU
         5yhWNsN4hNQpQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce291b5df9so3228531a34.2;
        Tue, 31 Oct 2023 05:21:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8UvjZskDqgrKlMr2QlqVTuOIKW+gU8DxAsFtTsk3cRacFH+JA
        1PdemYCnwe7gsfImy4Kp9wvcelzvpG6s+J9CEmY=
X-Google-Smtp-Source: AGHT+IETEqf6YuW6AZkjv2RszmF+Xdrmt0agc3TBW1ydRAf2ID8dNZyLgzeiGbWZk0+6LpAYjLgxTmoPzKqG8md0kgY=
X-Received: by 2002:a05:6870:b003:b0:1d0:f5bd:6d2 with SMTP id
 y3-20020a056870b00300b001d0f5bd06d2mr16369247oae.38.1698754869614; Tue, 31
 Oct 2023 05:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231031102111.32142-1-jirislaby@kernel.org> <20231031112558.GAZUDkRrkEStZqDnz4@fat_crate.local>
In-Reply-To: <20231031112558.GAZUDkRrkEStZqDnz4@fat_crate.local>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Oct 2023 21:20:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS+Ej9q7Tw7Op8J27KUeFUEg6VvytWm6SXd1qB-ocUJ8A@mail.gmail.com>
Message-ID: <CAK7LNAS+Ej9q7Tw7Op8J27KUeFUEg6VvytWm6SXd1qB-ocUJ8A@mail.gmail.com>
Subject: Re: [PATCH] x86: Let AS_WRUSS depend on X86_64
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 8:26=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> + linux-kbuild@vger.kernel.org
>
> On Tue, Oct 31, 2023 at 11:21:11AM +0100, Jiri Slaby (SUSE) wrote:
> > Since commit 18e66b695e78 ("x86/shstk: Add Kconfig option for shadow
> > stack"), AS_WRUSS is set even in 32-bit .configs. It is due to how
> > Kbuild works. .config is not considered during make oldconfig (and othe=
r
> > make *config), so standard (64-bit) gcc is invoked from 'as-instr'
> > Kbuild tests.



I do not mind either way.

Please note "depends on X86_64" cannot prevent gcc
from running here.

$(as-instr,wrussq %rax$(comma)(%rbx)) is replaced with 'y'
while parsing the Kconfig files.

I want to change it in the future, but that is how Kconfig works now.

You don't save the cost of running the compiler.







> And such gcc indeed reports that wruss is supported, so
> > AS_WRUSS=3Dy is set.
> >
> > Provided the wruss instruction is 64-bit only (and used in pure 64-bit
> > X86_USER_SHADOW_STACK), it has little sense to have AS_WRUSS=3Dy set on
> > 32-bit.
> >
> > Therefore, make the whole test dependent on X86_64 to ensure it's set
> > only on 64-bit.
> >
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Borislav Petkov (AMD) <bp@alien8.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Pengfei Xu <pengfei.xu@intel.com>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86@kernel.org
> > ---
> >  arch/x86/Kconfig.assembler | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> > index 8ad41da301e5..a5b5241711e3 100644
> > --- a/arch/x86/Kconfig.assembler
> > +++ b/arch/x86/Kconfig.assembler
> > @@ -27,5 +27,6 @@ config AS_GFNI
> >
> >  config AS_WRUSS
> >       def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
> > +     depends on X86_64
> >       help
> >         Supported by binutils >=3D 2.31 and LLVM integrated assembler
> > --
> > 2.42.0
> >
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



--=20
Best Regards
Masahiro Yamada
