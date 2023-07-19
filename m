Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488FE759079
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGSIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGSIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:41:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC19FC;
        Wed, 19 Jul 2023 01:41:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso66209835e9.1;
        Wed, 19 Jul 2023 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689756111; x=1692348111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLmQ24YixAEZPKW7aPylZWyBEWNRZEvazunJcAkAC9w=;
        b=DmO8zd8ktLDrYIG3mwVdbuRtG8SjqJgfGiwwFu9X1zxvFTTeEtO0gcSImcbz8889Ch
         KSFk49EIQM/VtA1jh8+7KzlMGdarcgf+cD4PN+QpWaahUcd8/grTGnXj6/KfVZGjA6lB
         SVuQgHQDK8Ep1lSufFbOzBeft4aXLOnbkNdqJvatSGcLksVe6ioFzpECU4bMB0KuohP/
         u9SpjYO5IqR345jj2wDGQzPoXvvNf4pjymNngx+bu5uqFdDILZwhGbSpa2DXTTM7dMj7
         S0JnmmytUKXIvnCK4JOIwHpT7wSxqYlu1+oADnfLFeghGnX2HMwHgmfmZyjJNdRc8JEc
         /h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756111; x=1692348111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLmQ24YixAEZPKW7aPylZWyBEWNRZEvazunJcAkAC9w=;
        b=bhFzh/EPUrov6XdyK9tJYRGcoce9HwYd4tSX3+I81Cox98L981MzS2PmQtN1AJVmYU
         5FebkfxC8ZLbj6LI4hWvPiwpbr5sSGoxlLwB96Tc3AVRkApU90nW7kjHjvD/G2s2FZEi
         4YE1NxdPNYqGIi4xAMyvW12SlU8Kni7zWP1uCCQNcvhYcrvVbxPo9CNsRBOHAgSOcF2y
         JrWXlitQdAD6Knt489aUBLoLNDc5WROdLR8M+1f5drglV2rwaZxPFIjaO39KXyAvRsad
         z74zAb53dtpS70dm9Y2H69c4O2iCPLFRfT4OPu8Fa88tOR7aAsz2LKFM3Tkn25xKjK4X
         BoeQ==
X-Gm-Message-State: ABy/qLayyca1Ao9p99ShVn09ozf/FFUCmGnTxPkSSBOuKCGEHoRBetSD
        qjkYFDVv2rbp+gYGwFm6Hfu5uBCPzuGam7LFSVw=
X-Google-Smtp-Source: APBJJlH5+woZbgzbveFUzX2WYljqawmBN/szdxtw/UazZM1DUFHtUpv5VgubshMErax9SxbXJZaM5C4Sb9ubQeIY+4Q=
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e643:1225 with SMTP id
 f13-20020a7bcd0d000000b003fbe6431225mr1534391wmj.13.1689756111466; Wed, 19
 Jul 2023 01:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221219055431.22596-1-ashimida.1990@gmail.com> <20230325081117.93245-1-ashimida.1990@gmail.com>
In-Reply-To: <20230325081117.93245-1-ashimida.1990@gmail.com>
From:   Dan Li <ashimida.1990@gmail.com>
Date:   Wed, 19 Jul 2023 16:41:39 +0800
Message-ID: <CAE+Z0PEJ_Nidzz6kY5uJrKtFSQGDdBTae_8+A1pTKW6HSV3veQ@mail.gmail.com>
Subject: Re: [RFC/RFT,V2 0/3] Add compiler support for Kernel Control Flow Integrity
To:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Embarrassingly, due to personal reasons, I may not be able to complete
the series of patches on the forward side of GCC CFI for the time being.

Please forgive me for not realizing that I should have sent this help
email a long time ago :(

This topic has been delayed for a long time, and I would be very grateful
if someone can help complete this series of patches.

BTW, please let me know if there are more groups I can cc for help.

Thanks!
Dan.

On Sat, 25 Mar 2023 at 16:11, Dan Li <ashimida.1990@gmail.com> wrote:
>
> This series of patches is mainly used to support the control flow
> integrity protection of the linux kernel [1], which is similar to
> -fsanitize=kcfi in clang 16.0 [2,3].
>
> Any suggestion please let me know :).
>
> Thanks, Dan.
>
> [1] https://lore.kernel.org/all/20220908215504.3686827-1-samitolvanen@google.com/
> [2] https://clang.llvm.org/docs/ControlFlowIntegrity.html
> [3] https://reviews.llvm.org/D119296
>
> Signed-off-by: Dan Li <ashimida.1990@gmail.com>
>
> ---
> Dan Li (3):
>   [PR102768] flag-types.h (enum sanitize_code): Extend sanitize_code to
>     64 bits to support more features
>   [PR102768] Support CFI: Add basic support for Kernel Control Flow
>     Integrity
>   [PR102768] aarch64: Add support for Kernel Control Flow Integrity
>
>  gcc/asan.h                    |   4 +-
>  gcc/c-family/c-attribs.cc     |  10 +-
>  gcc/c-family/c-common.h       |   2 +-
>  gcc/c/c-parser.cc             |   4 +-
>  gcc/cfgexpand.cc              |  26 ++++++
>  gcc/cgraphunit.cc             |  34 +++++++
>  gcc/combine.cc                |   1 +
>  gcc/common.opt                |   4 +-
>  gcc/config/aarch64/aarch64.cc | 166 ++++++++++++++++++++++++++++++++++
>  gcc/cp/typeck.cc              |   2 +-
>  gcc/doc/invoke.texi           |  36 ++++++++
>  gcc/doc/tm.texi               |  27 ++++++
>  gcc/doc/tm.texi.in            |   8 ++
>  gcc/dwarf2asm.cc              |   2 +-
>  gcc/emit-rtl.cc               |   1 +
>  gcc/emit-rtl.h                |   4 +
>  gcc/final.cc                  |  24 ++++-
>  gcc/flag-types.h              |  67 +++++++-------
>  gcc/gimple.cc                 |  11 +++
>  gcc/gimple.h                  |   5 +-
>  gcc/opt-suggestions.cc        |   2 +-
>  gcc/opts.cc                   |  26 +++---
>  gcc/opts.h                    |   8 +-
>  gcc/output.h                  |   3 +
>  gcc/reg-notes.def             |   1 +
>  gcc/target.def                |  38 ++++++++
>  gcc/toplev.cc                 |   4 +
>  gcc/tree-cfg.cc               |   2 +-
>  gcc/tree.cc                   | 144 +++++++++++++++++++++++++++++
>  gcc/tree.h                    |   1 +
>  gcc/varasm.cc                 |  26 ++++++
>  31 files changed, 627 insertions(+), 66 deletions(-)
>
> --
> 2.17.1
>
