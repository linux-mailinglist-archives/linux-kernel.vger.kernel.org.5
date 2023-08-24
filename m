Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE1787994
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbjHXUs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbjHXUsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:48:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DC1993
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:48:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d4ddbcbbaacso288105276.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692910126; x=1693514926;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0yJZryWMYeO3ru4SL2etFZxtb/uTR0NYnDC6wqAIp0=;
        b=O5lPfwxP2ZX5jRGZtkaXjoT01H5GZ0XSxuBn6tH/X6Eqc9pJ76hJE1kD86PTMk1ST6
         8a5RMLvAcD0wH6ztd12HemFXEaxCCZxqESTRS+g0K8q+BDz9KUMW8vDVowHPv2C1gHpF
         +cJ+sGBPRaB4phgQNWNLZjWGi5tuowVrTp/xey1jD/oLwUTKaBOs7WCiDQZwZPKDcsfm
         PFebf5R2z/yVO03WpAePC/zYGH6tc4Y/uJxMbQNvGqlWuGWqCwpERL0EBDp/2EmK3cic
         XtizBsVi1mzhQ7rpheyzqKRrH1TixpnXkyREJNr4cwfGmm0eLuqAyfA6Ze02loN9wpgQ
         YdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692910126; x=1693514926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0yJZryWMYeO3ru4SL2etFZxtb/uTR0NYnDC6wqAIp0=;
        b=Y9hqXCqdbV00iRrcycV54K6greGV+Pgnk9GkUmuv8fMlUZK0KaGw7enur0as6zD0rO
         UatRbX+p0BzzFfvvUyR3+lTiE+g8il0pNGR29VPVp4h4JKgiIj4MF8f2kce2dRpWYdfr
         JjQc3uW2nJh5JWgpaxfo6vveTistfjb+B0x+OM59piblIshLpEmdOO65I9phVSlAdBc+
         fefQtc+i3nHVdgPfbczxfQk6XEbEJ6a63ZaC4OnbLvPZiRvVvblLkRFpicwP89T4pQgQ
         VBrvtKJmrTyJ5HqF9bexpAcmjRwA1rMp8tyZR6TjfmsCnle86JMEMeJpvMCc+Lkj0H0/
         frug==
X-Gm-Message-State: AOJu0YzjvxFWNS7sJBtxKBjtbCw3MgfN+XWsRpYS/2ArEZROVDQVQkBE
        SmsUn+zhB4TAQxSPX/8XLnd8MHZeN8dyeulrIGg=
X-Google-Smtp-Source: AGHT+IHSSvrHDyjia7HhrvF+NQ3tP9byLcqc5+0hCYuVncXYTIcVK7jaYqoyK5t55SBOOuPSFQPjEC5/8v9cDVOwv7Y=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:63f7:38ec:c0bd:8830])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:290:b0:d48:c04:f256 with
 SMTP id v16-20020a056902029000b00d480c04f256mr264462ybh.11.1692910126508;
 Thu, 24 Aug 2023 13:48:46 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:48:43 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACrC52QC/13MQQ7CIBCF4as0sxbDUC3ElfcwXVQYKIl2GjBE0
 3B3sUuX/8vLt0GmFCnDpdsgUYk58tJCHTqw87QEEtG1BiVVL406Ccc2C4t6OjvSHmUP7bom8vG 9M7ex9Rzzi9NnVwv+1j+goEAxaJIDKm3uxl8Dc3jQ0fITxlrrF25UWUaZAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692910124; l=8692;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=tF1NWDJnkZ9aR4MO1fxhjTI93RQpM0ZUl3wqcpY3mfQ=; b=RwPBFc3vurwU8C0ZNuw/kt5+Fi47JNw4+LMM4uD5X2F3Kqo9o3U1G3+rwNVyOeuAsmSnfsqtg
 w4kxoYGWLrFDA9cZ39ON8h8rVoSU6SFjdF2RPXbp4D0skkbHGU3lWeK
X-Mailer: b4 0.12.3
Message-ID: <20230824-docs-v2-1-848abf651184@google.com>
Subject: [PATCH v2] Documentation/llvm: refresh docs
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
        autolearn=ham autolearn_force=no version=3.4.6
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
``CC=clang``. Make that suggestion "above the fold" and "front and
center" in our docs.

While here, the following additional changes were made:
- remove the bit about CROSS_COMPILE setting --target=, that's no longer
  true.
- Add ARCH=loongarch to the list of maintained targets (though we're
  still working on getting defconfig building cleanly at the moment;
  we're pretty close).
- Bump ARCH=powerpc from CC=clang to LLVM=1 status.
- Promote ARCH=riscv from being Maintained to being Supported. Android
  is working towards supporting RISC-V, and we have excellent support
  from multiple companies in this regard.
- Note that the toolchain distribution on kernel.org has been built with
  profile data from kernel builds.

Link: https://github.com/ClangBuiltLinux/linux/issues/1907 [0]
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
- Commit message changes:
  - Put SOB tag above the fold.
  - Mention PPC change in commit message.
  - Fix typos in commit message.
  - Add Nathan's RB tag to commit message.
- Fix kernel doc warnings
- Reword s390 example under `The LLVM= argument`.
- Reword and add examples to `The LLVM_IAS= argument`.
- Link to v1: https://lore.kernel.org/r/20230824-docs-v1-1-67e061278b8f@google.com
---
 Documentation/kbuild/llvm.rst | 115 +++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 47 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index c3851fe1900d..1bfcadc41e7d 100644
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
-
-	make CC=clang
-
-Cross Compiling
----------------
+Building with LLVM
+------------------
 
-A single Clang compiler binary will typically contain all supported backends,
-which can help simplify cross compiling. ::
+Invoke ``make`` via::
 
-	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
+	make LLVM=1
 
-``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
-``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``. For
-example: ::
+to compile for the host target. For cross compiling::
 
-	clang --target=aarch64-linux-gnu foo.c
+	make LLVM=1 ARCH=arm64
 
-LLVM Utilities
---------------
+The LLVM= argument
+------------------
 
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
@@ -78,31 +66,59 @@ can pass the suffix using the ``LLVM`` variable::
 
 which will use ``clang-14``, ``ld.lld-14``, etc.
 
+To support combinations of out of tree paths with version suffixes, we
+recommend::
+
+	PATH=/path/to/llvm/:$PATH make LLVM=-14
+
 ``LLVM=0`` is not the same as omitting ``LLVM`` altogether, it will behave like
-``LLVM=1``. If you only wish to use certain LLVM utilities, use their respective
-make variables.
+``LLVM=1``. If you only wish to use certain LLVM utilities, use their
+respective make variables.
 
-The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
-disable it.
+The same value used for ``LLVM=`` should be set for each invocation of ``make``
+if configuring and building via distinct commands. ``LLVM=`` should also be set
+as an environment variable when running scripts that will eventually run
+``make``.
 
-Omitting CROSS_COMPILE
-----------------------
+Cross Compiling
+---------------
+
+A single Clang compiler binary (and corresponding LLVM utilities) will
+typically contain all supported back ends, which can help simplify cross
+compiling especially when ``LLVM=1`` is used. If you use only LLVM tools,
+``CROSS_COMPILE`` or target-triple-prefixes become unnecessary. Example::
+
+	make LLVM=1 ARCH=arm64
 
-As explained above, ``CROSS_COMPILE`` is used to set ``--target=<triple>``.
+As an example of mixing LLVM and GNU utilities, for a target like ``ARCH=s390``
+which does not yet have ``ld.lld`` or ``llvm-objcopy`` support, you could
+invoke ``make`` via::
 
-If ``CROSS_COMPILE`` is not specified, the ``--target=<triple>`` is inferred
-from ``ARCH``.
+	make LLVM=1 ARCH=s390 LD=s390x-linux-gnu-ld.bfd \
+	  OBJCOPY=s390x-linux-gnu-objcopy
 
-That means if you use only LLVM tools, ``CROSS_COMPILE`` becomes unnecessary.
+This example will invoke ``s390x-linux-gnu-ld.bfd`` as the linker and
+``s390x-linux-gnu-objcopy``, so ensure those are reachable in your ``$PATH``.
+
+``CROSS_COMPILE`` is not used to prefix the Clang compiler binary (or
+corresponding LLVM utilities) as is the case for GNU utilities when ``LLVM=1``
+is not set.
+
+The LLVM_IAS= argument
+----------------------
 
-For example, to cross-compile the arm64 kernel::
+Clang can assemble assembler code. You can pass ``LLVM_IAS=0`` to disable this
+behavior and have Clang invoke the corresponding non-integrated assembler
+instead. Example::
 
-	make ARCH=arm64 LLVM=1
+	make LLVM=1 LLVM_IAS=0
 
-If ``LLVM_IAS=0`` is specified, ``CROSS_COMPILE`` is also used to derive
-``--prefix=<path>`` to search for the GNU assembler and linker. ::
+``CROSS_COMPILE`` is necessary when cross compiling and ``LLVM_IAS=0``
+is used in order to set ``--prefix=`` for the compiler to find the
+corresponding non-integrated assembler (typically, you don't want to use the
+system assembler when targeting another architecture). Example::
 
-	make ARCH=arm64 LLVM=1 LLVM_IAS=0 CROSS_COMPILE=aarch64-linux-gnu-
+	make LLVM=1 ARCH=arm LLVM_IAS=0 CROSS_COMPILE=arm-linux-gnueabi-
 
 Supported Architectures
 -----------------------
@@ -135,14 +151,17 @@ yet. Bug reports are always welcome at the issue tracker below!
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
@@ -171,9 +190,11 @@ Getting Help
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

