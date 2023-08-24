Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B580078776B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbjHXSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbjHXSDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:03:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E221BD9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:03:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d37b541a2so1811147b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692900201; x=1693505001;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jylpqBSq6UZhDtJHaP/6cFTqfJ1I/2o5dmapcGZqzGk=;
        b=E1FcvBcvo1zP1Vdi0KwRwEi4XcKZj2/NFp52Hpeo3fA/EOMBpFgAU04ap1h+EiJzIO
         YDmoI/iJcKnWCiURI93udUFg04oDjRjV5TKetnMYZdncataXHWrDUThf7ZAt2yXv8435
         4CcW4YJtDEUZA9j1Hdr0uSenajyWJGANqc+05EPJvPSZfkErZBkh/k70pWmVQqIR0vxt
         rFhDm9Dyn4at7lRQuYDAqBkhx97LspiHznYimCqZymj1I+8jKeeX6wG9HRReRgx6cUdc
         HB8gMTQfZ6COrsPz29W6oUdbcMzaS4iy53e13a4aEo/Mosl1DYV2b30RgXbFSPe7p5x4
         bFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900201; x=1693505001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jylpqBSq6UZhDtJHaP/6cFTqfJ1I/2o5dmapcGZqzGk=;
        b=jVZ2Abzpq1XkTce+d1l2/lUhfkIna0x+50ePrvsWMVDrF115aGHsprJ05vIvfmFUP2
         OiBXTCVVvVlE9+ncKgNUbV1y6N91gCc9lhnjnXZEyacggSvf8x6krKzwziAUdXyXhRuH
         SWGZhIPKZIXChuEiQn2rKxgd5C7ooXMpAOTODp5nxK7+FdwjUJNQKjR/zsP4fk9jqkXN
         Jke+gLlQyFxwb6rL0Ouxuvgd5DHOWd4BT7FCSRDxQWtAJaWDi+6m2jz9LH03aXGvC/DK
         RvNUJXAqu7mj9VyCnYjxFYh0YwESdCoEImNoyfaBu+Pae3hazup8oIt8DWr4JReEoLDI
         +jaQ==
X-Gm-Message-State: AOJu0Yymch9wueGXCDUiE4L34nLg3sN7mGdVczgxKG+HA2P1tk3MQIqz
        7BXwi5x0vYZGTCV6GrlhXGaFp69Lc4/mTh5X8ow=
X-Google-Smtp-Source: AGHT+IGDTvjBhTEjTSJ+jxTsdrlcA5pLuf1/WRjn/S7zeKMOvitmcknjEYYJppddGEudEVAhJ3cf8i90mlLIl7TEptE=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:63f7:38ec:c0bd:8830])
 (user=ndesaulniers job=sendgmr) by 2002:a25:c752:0:b0:d6b:1a89:6673 with SMTP
 id w79-20020a25c752000000b00d6b1a896673mr217374ybe.5.1692900201401; Thu, 24
 Aug 2023 11:03:21 -0700 (PDT)
Date:   Thu, 24 Aug 2023 11:03:17 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGSb52QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMT3ZT85GLdZEPzRNOUVPM0QwNjJaDSgqLUtMwKsDHRsbW1AIR2Jcx WAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692900199; l=7833;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=yaDjW5hOI5gJGOMZ1DsDzpbL5Z3k3IDsA7FrJwcxAdM=; b=6OoJ7R8CkuDjqnXjQysK58Kb5Piqi7H/nHRIVfhdlo6v+c7ImybKTufIPhYohUbYmUpG/dahd
 9/vUqbUHgtjD7Ucxf0/2rRwHPB8uTmjizRlYvGdyr2Yrr+yquGSVi89
X-Mailer: b4 0.12.3
Message-ID: <20230824-docs-v1-1-67e061278b8f@google.com>
Subject: [PATCH] Documentation/llvm: refresh docs
From:   ndesaulniers@google.com
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent fixes for an embargoed hardware security vulnerability failed to
link with ld.lld (LLVM's linker).  [0]  To be fair, our documentation
mentions ``CC=clang`` foremost with ``LLVM=1`` being buried "below the
fold."

We want to encourage the use of ``LLVM=1`` rather than just
``CC=clang``. Make that sugguestion "above the fold" and "front and
center" in our docs.

While here, the following additional changes were made:
- remove the bit about CROSS_COMPILE setting --target=, that's no longer
  true.
- Add ARCH=loongarch to the list of maintained targets (though we're
  still working on getting defconfig building cleanly at the moment;
  we're pretty close).
- Promote ARCH=riscv from being Maintained to being Supported. Android
  is working towards supporting RISC-V, and we have excellent support
  from multiple companies in this regard.
- Note that the toolchain distribution on kernel.org has been built with
  profile data from kernel builds.

Link: https://github.com/ClangBuiltLinux/linux/issues/1907 [0]
---


Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/kbuild/llvm.rst | 102 +++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index c3851fe1900d..00b26a0a6bf1 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -25,50 +25,38 @@ objects <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM
 that supports C and the GNU C extensions required by the kernel, and is
 pronounced "klang," not "see-lang."
 
-Clang
------
-
-The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
-``CC=`` should be set when selecting a config and during a build. ::
-
-	make CC=clang defconfig
+Building with LLVM
+------------------
 
-	make CC=clang
-
-Cross Compiling
----------------
+Invoke ``make`` via::
 
-A single Clang compiler binary will typically contain all supported backends,
-which can help simplify cross compiling. ::
-
-	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
+	make LLVM=1
 
-``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
-``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``. For
-example: ::
+to compile for the host target. For cross compiling::
 
-	clang --target=aarch64-linux-gnu foo.c
+	make LLVM=1 ARCH=arm64
 
-LLVM Utilities
+The LLVM= argument
 --------------
 
-LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
-The full list of supported make variables::
+LLVM has substitutes for GNU binutils utilities. They can be enabled
+individually. The full list of supported make variables::
 
 	make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
 	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
 	  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
 
-To simplify the above command, Kbuild supports the ``LLVM`` variable::
-
-	make LLVM=1
+``LLVM=1`` expands to the above.
 
 If your LLVM tools are not available in your PATH, you can supply their
 location using the LLVM variable with a trailing slash::
 
 	make LLVM=/path/to/llvm/
 
-which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc.
+which will use ``/path/to/llvm/clang``, ``/path/to/llvm/ld.lld``, etc. The
+following may also be used::
+
+	PATH=/path/to/llvm:$PATH make LLVM=1
 
 If your LLVM tools have a version suffix and you want to test with that
 explicit version rather than the unsuffixed executables like ``LLVM=1``, you
@@ -78,31 +66,46 @@ can pass the suffix using the ``LLVM`` variable::
 
 which will use ``clang-14``, ``ld.lld-14``, etc.
 
-``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
-``LLVM=1``. If you only wish to use certain LLVM utilities, use their respective
-make variables.
+To support combinations of out of tree paths with version suffixes, we
+recommend::
+
+	PATH=/path/to/llvm/:$PATH make LLVM=-14
 
-The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
-disable it.
+``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
+``LLVM=1``. If you only wish to use certain LLVM utilities, use their
+respective make variables.
 
-Omitting CROSS_COMPILE
-----------------------
+The same value used for ``LLVM=`` should be set for each invocation of ``make``
+if configuring and building via distinct commands. ``LLVM=`` should also be set
+as an environment variable when running scripts that will eventually run
+``make``.
 
-As explained above, ``CROSS_COMPILE`` is used to set ``--target=<triple>``.
+Cross Compiling
+---------------
 
-If ``CROSS_COMPILE`` is not specified, the ``--target=<triple>`` is inferred
-from ``ARCH``.
+A single Clang compiler binary (and corresponding LLVM utilities) will
+typically contain all supported backends, which can help simplify cross
+compiling especially when ``LLVM=1`` is used. If you use only LLVM tools,
+``CROSS_COMPILE`` becomes unnecessary.
 
-That means if you use only LLVM tools, ``CROSS_COMPILE`` becomes unnecessary.
+As an example, for a target like ``ARCH=s390`` which does not yet have
+``ld.lld`` support, you could invoke ``make`` via::
 
-For example, to cross-compile the arm64 kernel::
+	make LLVM=1 LD=ld.bfd CROSS_COMPILE=s390x-linux-gnu-
 
-	make ARCH=arm64 LLVM=1
+``CROSS_COMPILE`` is not used to prefix the Clang compiler binary (or
+corresponding LLVM utilities), but it will be for any GNU toolchain utilities.
+This example will invoke ``s390x-linux-gnu-ld.bfd`` as the linker, so ensure
+that is reachable in your ``$PATH``.
 
-If ``LLVM_IAS=0`` is specified, ``CROSS_COMPILE`` is also used to derive
-``--prefix=<path>`` to search for the GNU assembler and linker. ::
+The LLVM_IAS= argument
+-----------------
 
-	make ARCH=arm64 LLVM=1 LLVM_IAS=0 CROSS_COMPILE=aarch64-linux-gnu-
+Clang can assemble assembler code. You can pass ``LLVM_IAS=0`` to disable this
+behavior and have Clang invoke the system assembler instead (or the assembler
+based on ``CROSS_COMPILE``). ``CROSS_COMPILE`` is necessary when ``LLVM_IAS=0``
+is set when cross compiling in order to set ``--prefix=`` for the compiler to
+find the corresponding non-integrated assembler.
 
 Supported Architectures
 -----------------------
@@ -135,14 +138,17 @@ yet. Bug reports are always welcome at the issue tracker below!
    * - hexagon
      - Maintained
      - ``LLVM=1``
+   * - loongarch
+     - Maintained
+     - ``LLVM=1``
    * - mips
      - Maintained
      - ``LLVM=1``
    * - powerpc
      - Maintained
-     - ``CC=clang``
+     - ``LLVM=1``
    * - riscv
-     - Maintained
+     - Supported
      - ``LLVM=1``
    * - s390
      - Maintained
@@ -171,9 +177,11 @@ Getting Help
 Getting LLVM
 -------------
 
-We provide prebuilt stable versions of LLVM on `kernel.org <https://kernel.org/pub/tools/llvm/>`_.
-Below are links that may be useful for building LLVM from source or procuring
-it through a distribution's package manager.
+We provide prebuilt stable versions of LLVM on `kernel.org
+<https://kernel.org/pub/tools/llvm/>`_. These have been optimized with profile
+data for building Linux kernels. Below are links that may be useful for
+building LLVM from source or procuring it through a distribution's package
+manager.
 
 - https://releases.llvm.org/download.html
 - https://github.com/llvm/llvm-project

---
base-commit: 93f5de5f648d2b1ce3540a4ac71756d4a852dc23
change-id: 20230824-docs-c17a5de7f103

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

