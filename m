Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101877836E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjHJWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:07:19 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F40128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:07:18 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3492e05be7cso23195ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691705238; x=1692310038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aluvHDRByGNNDaSNSGZTBrI1PCu1IS2vHH7drDMeXMo=;
        b=O5WOos64AEFan/sd6CK+w6zp9XUr4hfkOs73N2iQl4GwN8cYDtWCstWXzD/xDmlTSM
         se4Ndhb24NLc2DjT/7f1sbBwLnNR1c6ZmhC++UXeEQWEYqw9DJW3CZXHws1p+JQouOve
         V/+W/pHKWDugRH0PFfidlu6J+Db5jvQ6EqrNZRHX2GB5+pB3xCxz4u0zhp/iYelLgkr0
         tgicCMFI1LdB9+x3IWZCcK2UJ9mdD1oxeA7tiHu+CmigQK0H1IZjVuc1unHy2TX4FGyb
         rOTZw+4610e3GwlFGQ65BvJFJx1Ak11y5idjZ5qBfJPBP6cu26IXSOv4sj/yEfa6CYAp
         qqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705238; x=1692310038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aluvHDRByGNNDaSNSGZTBrI1PCu1IS2vHH7drDMeXMo=;
        b=OpN5OZfCZmcCbeOx2Govmp9Jbk50B0p7yVHYyNRJOtH352kCWWOaj4ngv4a2kBj7o3
         N2ZYPask0LK8a0FPo9V5aJp8Lg8NFe1qFdYxFokRv1MTB24E4LV3P1YZhfnGwtqafGG4
         FVdqnr0Z9Dj+9TtJT+7oAvbaN4qzHqTlQxQnbiO1KD6zHsL76jAnKsRo2kI9ilQ+KZ29
         ZdzZ4QAGnwSpiMGwNnbGQUCJjjQTaTcPt134TMBkYZRoVIBMauY2dMxJXzQPU5OdmmvU
         QKe9ItVdoaAtX4dBB2vCOCj35U8FevYWpFxi5dJ9VJs1VDqm5WBQU6pTDosyxzbdZQ8x
         GygQ==
X-Gm-Message-State: AOJu0Ywo29P2QedE2v873SYgpSiiVoFpSW0XqgWnYPysaNV5UG2E1R2x
        HgmhzuxMX+l2HW2I6domyuv6fuf2COFmvuWX4WPL5Zv/z9RqJuJmCRBxCqLL
X-Google-Smtp-Source: AGHT+IFDL+TfDeXb9KtUBUaYqM4JxMDgapXt4frF6nwQhqAShn/Ft9pBMlqDRC3GKWwYDQcWfkMGfsJqoxJvwW8l6pI=
X-Received: by 2002:a05:6e02:160a:b0:348:8674:6706 with SMTP id
 t10-20020a056e02160a00b0034886746706mr109307ilu.10.1691705237793; Thu, 10 Aug
 2023 15:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230725150347.3479291-1-tmricht@linux.ibm.com> <ZMpoB1bYk+KfTDJA@kernel.org>
In-Reply-To: <ZMpoB1bYk+KfTDJA@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 15:07:05 -0700
Message-ID: <CAP-5=fUk4=4FNj6=zVKaoELL7duL-DzyRp1cAPQSYhFSKV1kow@mail.gmail.com>
Subject: Re: [PATCH 1/2 Resend] perf build: Update feature check for clang and llvm
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 2, 2023 at 7:28=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Tue, Jul 25, 2023 at 05:03:46PM +0200, Thomas Richter escreveu:
> > Perf build auto-detects features and packages already installed
> > for its build. This is done in directory tools/build/feature. This
> > directory contains small sample programs. When they successfully
> > compile the necessary prereqs in form of libraries and header
> > files are present.
> >
> > Such a check is also done for llvm and clang. And the checks fail.
> >
> > Fix this and update to the latest C++ standard and use the
> > new library provided by clang (which contains new packaging)
> > see this link for reference:
> >  https://fedoraproject.org/wiki/Changes/Stop-Shipping-Individual-Compon=
ent-Libraries-In-clang-lib-Package
> >
> > Output before:
> >  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
> >       ll test-clang.make.output
> >  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
> >               > test-clang.make.output 2>&1 -std=3Dgnu++14 \
> >       -I/usr/include          \
> >       -L/usr/lib64            \
> >       -Wl,--start-group -lclangBasic -lclangDriver    \
> >         -lclangFrontend -lclangEdit -lclangLex        \
> >         -lclangAST -Wl,--end-group                    \
> >       -lLLVM-16       \
> >                       \
> >       > test-clang.make.output 2>&1
> >  make: *** [Makefile:356: test-clang.bin] Error 1
> >  -bash: ./test-clang.bin: No such file or directory
> >  -rw-r--r--. 1 root root 252041 Jul 12 09:56 test-clang.make.output
> >  #
> >
> > File test-clang.make.output contains many lines of unreferenced
> > symbols.
> >
> > Output after:
> >  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
> >       cat test-clang.make.output
> >  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
> >        > test-clang.make.output 2>&1 -std=3Dgnu++17     \
> >       -I/usr/include          \
> >       -L/usr/lib64            \
> >       -Wl,--start-group -lclang-cpp -Wl,--end-group   \
> >       -lLLVM-16       \
> >                       \
> >       > test-clang.make.output 2>&1
> >  #
>
> Thanks, tested and applied. Added some notes about needing to have
> 'llvm-devel' and 'clang-devel' installed to do the tests.
>
> - arnaldo
>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Note, the libllvm and clang support was needed for BPF events which I
propose removing in:
https://lore.kernel.org/lkml/20230810184853.2860737-1-irogers@google.com/
(Sorry, forgot to add Thomas to the to/cc line of those changes).

Thanks,
Ian

> > ---
> >  tools/build/feature/Makefile | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 2cd6dbbee088..3184f387990a 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -340,7 +340,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
> >       $(BUILD)
> >
> >  $(OUTPUT)test-llvm.bin:
> > -     $(BUILDXX) -std=3Dgnu++14                                 \
> > +     $(BUILDXX) -std=3Dgnu++17                                 \
> >               -I$(shell $(LLVM_CONFIG) --includedir)          \
> >               -L$(shell $(LLVM_CONFIG) --libdir)              \
> >               $(shell $(LLVM_CONFIG) --libs Core BPF)         \
> > @@ -348,17 +348,15 @@ $(OUTPUT)test-llvm.bin:
> >               > $(@:.bin=3D.make.output) 2>&1
> >
> >  $(OUTPUT)test-llvm-version.bin:
> > -     $(BUILDXX) -std=3Dgnu++14                                 \
> > +     $(BUILDXX) -std=3Dgnu++17                                 \
> >               -I$(shell $(LLVM_CONFIG) --includedir)          \
> >               > $(@:.bin=3D.make.output) 2>&1
> >
> >  $(OUTPUT)test-clang.bin:
> > -     $(BUILDXX) -std=3Dgnu++14                                 \
> > +     $(BUILDXX) -std=3Dgnu++17                                 \
> >               -I$(shell $(LLVM_CONFIG) --includedir)          \
> >               -L$(shell $(LLVM_CONFIG) --libdir)              \
> > -             -Wl,--start-group -lclangBasic -lclangDriver    \
> > -               -lclangFrontend -lclangEdit -lclangLex        \
> > -               -lclangAST -Wl,--end-group                    \
> > +             -Wl,--start-group -lclang-cpp -Wl,--end-group   \
> >               $(shell $(LLVM_CONFIG) --libs Core option)      \
> >               $(shell $(LLVM_CONFIG) --system-libs)           \
> >               > $(@:.bin=3D.make.output) 2>&1
> > --
> > 2.41.0
> >
>
> --
>
> - Arnaldo
