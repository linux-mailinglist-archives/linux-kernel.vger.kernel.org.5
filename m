Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381578783B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbjHXSta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbjHXStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:49:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC11BEC;
        Thu, 24 Aug 2023 11:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9C6654B0;
        Thu, 24 Aug 2023 18:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834FC433C8;
        Thu, 24 Aug 2023 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692902952;
        bh=94vHtzPsl9oXrZlsH6lhNF4M/HFIYPrHAJF+1ksp+4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lo2p0YLEphwm81d0oEgKNUMWoi9EGZKDjywJpM0QIYalPJJPssihFctVwmeYRtJ5Q
         18geKR2i7iFshvzeQVl3PmzfSDe2tZOYPPMhqJHSqv6YeW2euZ28hFnCXOnCA5GyCe
         QiuSBID5B3QcMnq9Eezlfj/+vieaWvjfJ60Nes9EXBBVAyulrogt3jGS8s9miJasD2
         /OQDMaLT5IYVxI7xnoQ7JpTz8fzD8PZUr13TMxQ6U/uz3krBbzSK6ZrZmoLRfo4tvv
         lBfjrQTj15G66QHjXqP9lzHlouSZOcsBiKFpo46yKreAMW1hz9f8bWxtw9QJOskzWk
         lfsi1MFba79TA==
Date:   Thu, 24 Aug 2023 11:49:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     ndesaulniers@google.com
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Tom Rix <trix@redhat.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Documentation/llvm: refresh docs
Message-ID: <20230824184910.GA2015748@dev-arch.thelio-3990X>
References: <20230824-docs-v1-1-67e061278b8f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-docs-v1-1-67e061278b8f@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:03:17AM -0700, ndesaulniers@google.com wrote:
> Recent fixes for an embargoed hardware security vulnerability failed to
> link with ld.lld (LLVM's linker).  [0]  To be fair, our documentation
> mentions ``CC=clang`` foremost with ``LLVM=1`` being buried "below the
> fold."
> 
> We want to encourage the use of ``LLVM=1`` rather than just
> ``CC=clang``. Make that sugguestion "above the fold" and "front and
> center" in our docs.
> 
> While here, the following additional changes were made:
> - remove the bit about CROSS_COMPILE setting --target=, that's no longer
>   true.
> - Add ARCH=loongarch to the list of maintained targets (though we're
>   still working on getting defconfig building cleanly at the moment;
>   we're pretty close).
> - Promote ARCH=riscv from being Maintained to being Supported. Android
>   is working towards supporting RISC-V, and we have excellent support
>   from multiple companies in this regard.
> - Note that the toolchain distribution on kernel.org has been built with
>   profile data from kernel builds.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1907 [0]
> ---
> 
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Nit: Your signed-off-by ended up below the fold, was it in your cover
letter commit rather than your actual commit?

Aside from the relatively minor comments below, this looks like a really
good improvement to the documentation to me. It feels like it is more
targeting users or non-kbuild folks now, which I think is great.

I trust you to address my comments as you see fit, so please carry
forward:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  Documentation/kbuild/llvm.rst | 102 +++++++++++++++++++++++-------------------
>  1 file changed, 55 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index c3851fe1900d..00b26a0a6bf1 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -25,50 +25,38 @@ objects <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM
>  that supports C and the GNU C extensions required by the kernel, and is
>  pronounced "klang," not "see-lang."
>  
> -Clang
> ------
> -
> -The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
> -``CC=`` should be set when selecting a config and during a build. ::
> -
> -	make CC=clang defconfig
> +Building with LLVM
> +------------------
>  
> -	make CC=clang
> -
> -Cross Compiling
> ----------------
> +Invoke ``make`` via::
>  
> -A single Clang compiler binary will typically contain all supported backends,
> -which can help simplify cross compiling. ::
> -
> -	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
> +	make LLVM=1
>  
> -``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
> -``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``. For
> -example: ::
> +to compile for the host target. For cross compiling::
>  
> -	clang --target=aarch64-linux-gnu foo.c
> +	make LLVM=1 ARCH=arm64
>  
> -LLVM Utilities
> +The LLVM= argument
>  --------------

I see a few new kernel-doc warnings from not adjusting the underlines to
match the new length of the title:

  Documentation/kbuild/llvm.rst:40: WARNING: Title underline too short.

  The LLVM= argument
  --------------
  Documentation/kbuild/llvm.rst:40: WARNING: Title underline too short.

  The LLVM= argument
  --------------
  Documentation/kbuild/llvm.rst:102: WARNING: Title underline too short.

  The LLVM_IAS= argument
  -----------------
  Documentation/kbuild/llvm.rst:102: WARNING: Title underline too short.

  The LLVM_IAS= argument
  -----------------

>  
> -LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
> -The full list of supported make variables::
> +LLVM has substitutes for GNU binutils utilities. They can be enabled
> +individually. The full list of supported make variables::
>  
>  	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>  	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>  	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
>  
> -To simplify the above command, Kbuild supports the ``LLVM`` variable::
> -
> -	make LLVM=1
> +``LLVM=1`` expands to the above.
>  
>  If your LLVM tools are not available in your PATH, you can supply their
>  location using the LLVM variable with a trailing slash::
>  
>  	make LLVM=/path/to/llvm/
>  
> -which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
> +which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc. The
> +following may also be used::
> +
> +	PATH=/path/to/llvm:$PATH make LLVM=1
>  
>  If your LLVM tools have a version suffix and you want to test with that
>  explicit version rather than the unsuffixed executables like ``LLVM=1``, you
> @@ -78,31 +66,46 @@ can pass the suffix using the ``LLVM`` variable::
>  
>  which will use ``clang-14``, ``ld.lld-14``, etc.
>  
> -``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
> -``LLVM=1``. If you only wish to use certain LLVM utilities, use their respective
> -make variables.
> +To support combinations of out of tree paths with version suffixes, we
> +recommend::
> +
> +	PATH=/path/to/llvm/:$PATH make LLVM=-14
>  
> -The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
> -disable it.
> +``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
> +``LLVM=1``. If you only wish to use certain LLVM utilities, use their
> +respective make variables.
>  
> -Omitting CROSS_COMPILE
> -----------------------
> +The same value used for ``LLVM=`` should be set for each invocation of ``make``
> +if configuring and building via distinct commands. ``LLVM=`` should also be set
> +as an environment variable when running scripts that will eventually run
> +``make``.
>  
> -As explained above, ``CROSS_COMPILE`` is used to set ``--target=<triple>``.
> +Cross Compiling
> +---------------
>  
> -If ``CROSS_COMPILE`` is not specified, the ``--target=<triple>`` is inferred
> -from ``ARCH``.
> +A single Clang compiler binary (and corresponding LLVM utilities) will
> +typically contain all supported backends, which can help simplify cross
> +compiling especially when ``LLVM=1`` is used. If you use only LLVM tools,
> +``CROSS_COMPILE`` becomes unnecessary.
>  
> -That means if you use only LLVM tools, ``CROSS_COMPILE`` becomes unnecessary.
> +As an example, for a target like ``ARCH=s390`` which does not yet have
> +``ld.lld`` support, you could invoke ``make`` via::
>  
> -For example, to cross-compile the arm64 kernel::
> +	make LLVM=1 LD=ld.bfd CROSS_COMPILE=s390x-linux-gnu-

This should probably have ARCH=s390?

> -	make ARCH=arm64 LLVM=1
> +``CROSS_COMPILE`` is not used to prefix the Clang compiler binary (or
> +corresponding LLVM utilities), but it will be for any GNU toolchain utilities.
> +This example will invoke ``s390x-linux-gnu-ld.bfd`` as the linker, so ensure
> +that is reachable in your ``$PATH``.

I like the example as I feel like it addresses some of the fear I have had
around recommending LLVM=1 as the initial build suggestion but 'LLVM=1
LD=ld.bfd CROSS_COMPILE=s390x-linux-gnu-' does not compose as you describe here
because $(LD) is not prefixed with $(CROSS_COMPILE) anywhere in Makefile. The
non-$(LLVM) default assignment of $(LD) is '$(CROSS_COMPILE)ld' and that is
overridden by 'LD=ld.bfd' on the command line.

In other words, this should be

  make ARCH=s390 LLVM=1 LD=s390x-linux-gnu-ld.bfd

and have the note about CROSS_COMPILE prefixing any GNU toolchain utilities
removed. It should problably have OBJCOPY and OBJDUMP too, as those are
required due to https://github.com/ClangBuiltLinux/linux/issues/859 and
https://github.com/ClangBuiltLinux/linux/issues/1530.

> -If ``LLVM_IAS=0`` is specified, ``CROSS_COMPILE`` is also used to derive
> -``--prefix=<path>`` to search for the GNU assembler and linker. ::
> +The LLVM_IAS= argument
> +-----------------
>  
> -	make ARCH=arm64 LLVM=1 LLVM_IAS=0 CROSS_COMPILE=aarch64-linux-gnu-
> +Clang can assemble assembler code. You can pass ``LLVM_IAS=0`` to disable this
> +behavior and have Clang invoke the system assembler instead (or the assembler
> +based on ``CROSS_COMPILE``). ``CROSS_COMPILE`` is necessary when ``LLVM_IAS=0``
> +is set when cross compiling in order to set ``--prefix=`` for the compiler to
> +find the corresponding non-integrated assembler.

Thanks a lot for documenting this behavior, it is one of the most common
issues I run into myself (adding LLVM_IAS=0 without CROSS_COMPILE) and
maybe this note will be what I need in order to remember :)

>  Supported Architectures
>  -----------------------
> @@ -135,14 +138,17 @@ yet. Bug reports are always welcome at the issue tracker below!
>     * - hexagon
>       - Maintained
>       - ``LLVM=1``
> +   * - loongarch
> +     - Maintained
> +     - ``LLVM=1``
>     * - mips
>       - Maintained
>       - ``LLVM=1``
>     * - powerpc
>       - Maintained
> -     - ``CC=clang``
> +     - ``LLVM=1``
>     * - riscv
> -     - Maintained
> +     - Supported
>       - ``LLVM=1``
>     * - s390
>       - Maintained
> @@ -171,9 +177,11 @@ Getting Help
>  Getting LLVM
>  -------------
>  
> -We provide prebuilt stable versions of LLVM on `kernel.org <https://kernel.org/pub/tools/llvm/>`_.
> -Below are links that may be useful for building LLVM from source or procuring
> -it through a distribution's package manager.
> +We provide prebuilt stable versions of LLVM on `kernel.org
> +<https://kernel.org/pub/tools/llvm/>`_. These have been optimized with profile
> +data for building Linux kernels. Below are links that may be useful for

Maybe make a note of why this matters? ", which should lower kernel
build times compared to non-optimized LLVM toolchains."?

Cheers,
Nathan
