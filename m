Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1D7F4B90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbjKVPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjKVPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:50:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497ED5E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:49:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BADBC433D9;
        Wed, 22 Nov 2023 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700668179;
        bh=BYCJA3x5TTAbbQPMEAHdhxb9CpYziBSEh7qg5KYFc3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lf41l0og8Tssr/hb/ubSBpyXsbiBnPgG2tAw23ddfqRwz1CZu59t60YaMYFHd8bRo
         8iLpKtrocyaGbjEHRv4usmFfoRkieMPxaEUIlXxPhWmvy6QEByllSsydUjXkWK830b
         o3jHhP7F1ioMa2Q+Nxwy7Bpem4ZYprHsFuTIYVYWq+/yWnkJ81xXBKJz+MqMeNarcX
         2rVGUTJGdLOEngFCjMvoNtpm9shzVCPsFgNhFOZtMfwH1S0avG5tuSRA4ZdCACJ8s0
         I4ydnXS2p4dHVC7dnvadHyP/eaEqAg+Jy9xt2mgoScn8uKLm/G1MguQEqc9iUtVctN
         PXqAqIzofO9Fg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b844357f7cso223197b6e.1;
        Wed, 22 Nov 2023 07:49:39 -0800 (PST)
X-Gm-Message-State: AOJu0YzZn/unQrMzkRqSwR+Ksnhd4Xrg0HYh06nFHVvaKpVDZWjwotcf
        X6tXNuxkur9fnNNTdFN9r40VEroxKXix5hbGdQc=
X-Google-Smtp-Source: AGHT+IGTa6C9d+mB8rUW3KBSbfG6/zDIsmWbZmbmj2c74lexp3YXviv1PGHzD95lJw6SS5pitC5dIey5qGrQgDzlQ+w=
X-Received: by 2002:a05:6870:cb97:b0:1e9:919d:83ec with SMTP id
 ov23-20020a056870cb9700b001e9919d83ecmr3553401oab.28.1700668178329; Wed, 22
 Nov 2023 07:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com>
In-Reply-To: <20231118025748.2778044-1-mmaurer@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Nov 2023 00:49:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQt8fy5+vSwpd1aXfzjzeZ5hiyW7EW9SW7pbG2eTJZAOA@mail.gmail.com>
Message-ID: <CAK7LNAQt8fy5+vSwpd1aXfzjzeZ5hiyW7EW9SW7pbG2eTJZAOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] MODVERSIONS + RUST Redux
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 11:58=E2=80=AFAM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> The goal of this patch series is to allow MODVERSIONS and RUST to be
> enabled simultaneously. The primary issue with doing this at the moment
> is that Rust uses some extremely long symbol names - for those
> unfamiliar with Rust, it may be helpful to think of some of the mangled
> C++ names you may have seen in binaries in the past.
>
> Previously, Gary Guo attempted to accomplish this by modifying the
> existing modversion format [1] to support variable-length symbol names.
> This was unfortunately considered to be a potential userspace break
> because kmod tools inspect this kernel module metadata. Masahiro Yamada
> suggested [2] that this could instead be done with a section per-field.
> This gives us the ability to be more flexible with this format in the
> future, as a new field or additional information will be in a new
> section which userspace tools will not yet attempt to read.
>
> In the previous version of this patchset, Luis Chamberlain suggested [3]
> I move validation out of the version checking and into the elf validity
> checker, and also add kernel-docs over there. I found
> elf_validity_cached_copy to be fairly dense and difficult to directly
> describe, so I refactored it into easier to explain pieces. In the
> process, I found a few missing checks and added those as well. See
> [PATCH 2/5] for more details. If this is too much, I'm more than happy
> to drop this patch from the series in favor of just adding the
> kernel-doc to the original code, but figured I'd offer it up in case the
> added clarity and checks were valuable.
>
> [1] https://lore.kernel.org/lkml/20230111161155.1349375-1-gary@garyguo.ne=
t/
> [2] https://lore.kernel.org/lkml/CAK7LNATsuszFR7JB5ZkqVS1W=3DhWr9=3DE7bTf=
+MvgJ+NXT3aZNwg@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/ZVZNh%2FPA5HiVRkeb@bombadil.infradead.or=
g/





I want to know why this is useful.


To clarify my question, let me first explain
what the modversion is.



In C, a function callee and callers must agree
with the interface of the function.


This is usually done by having a function prototype
in a header file.


Say, we have a function declaration

    int foo(int x, int y);

in include/linux/foo.h


Then, the C file that defines foo() and all C files
that call it must include <linux/foo.h> so that
argument mismatch can be detected.




Same for EXPORT_SYMBOL; the symbol provider and consumers
must agree with the interface of exported symbols.

In the kernel, however, there is no promise for in-kernel ABI
compatibility across different kernel versions.
The kernel only promises the compatibility of the userspace interface.


To load modules, by principle, vmlinux and modules must have
the same version.

To slightly loosen the limitation, CONFIG_MODVERSIONS was
introduced; when it is enabled, you can load a module
as long as all the prototypes of exported symbols match.

To do this, we need to encode information about prototypes.


This is done by a tool called genksyms (scripts/genksyms/genksyms).



Say, we have this code:


int foo(int x, int y)
{
     // genksyms does not care about
     // the function body.
}
EXPORT_SYMBOL(foo);


Genksyms parses the code and computes a CRC value for 'foo'.
Genksyms is only interested in the function name and its prototype.

It sees

   int foo(int, int)

and it transforms it into a CRC.


Any change to the prototype results in a
different CRC, so the module subsystem
can check the interface compatibility
before loading a module.


It is obvious that this is impossible for Rust source
because scripts/genksyms/genksyms is only able to
parse C code.


Then, what is happening here?

See rust/exports.c


  #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym=
)


The global scope symbols in Rust (i.e. 'pub) are automatically
exported, and all of them are visible as 'int' variables
from C world.


Genksyms will see this code:

  extern int foo;
  EXPORT_SYMBOL_GPL(foo);

Of course, this is not a true prototype.
The real signature on the Rust side might be:

  fn foo(x: i32, y: i32) -> i32


So, even if you enable CONFIG_MODVERSIONS,
nothing is checked for Rust.
Genksyms computes a CRC from "int foo", and
the module subsystem confirms it is a "int"
variable.

We know this check always succeeds.

Why is this useful?






> Matthew Maurer (5):
>   export_report: Rehabilitate script
>   modules: Refactor + kdoc elf_validity_cached_copy
>   modpost: Extended modversion support
>   rust: Allow MODVERSIONS
>   export_report: Use new version info format
>
>  arch/powerpc/kernel/module_64.c |  25 +-
>  init/Kconfig                    |   1 -
>  kernel/module/internal.h        |  18 +-
>  kernel/module/main.c            | 663 +++++++++++++++++++++++++-------
>  kernel/module/version.c         |  43 +++
>  scripts/export_report.pl        |  17 +-
>  scripts/mod/modpost.c           |  37 +-
>  7 files changed, 642 insertions(+), 162 deletions(-)
>
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>


--
Best Regards





Masahiro Yamada
