Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A075169C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGMDGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjGMDF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:05:58 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805F1BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:05:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403b622101bso104551cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689217555; x=1691809555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAdeA2B+EW+ai0RGsbG6q+tZPOctUxCkhZFz9cywSIU=;
        b=pLhhkWNglQtkg9ky9otWlEd9blp2NpoSOnt2/hc1Gl+53Rwi1dNyRcArNNVyuzbMjL
         q/7i6iEmgQnXZGr5jw/AA94Uj3DxNUahClwXYGtVhAryvJyEVuofaLpaI+Hp7stRGe54
         guXkN5fkJZFRLp5FYaMiBdQs6YDTLNVi4hU3JvIzWqhTPjcVZoXWwHT/1tQJCoepf8XT
         Fhp8LU7YczbWpJ2QDOCczR2Gp4eyi32TDiitsiY17ucTM6Ht9lvaM73Ddy4vsXuNq72d
         B6/zyJBteuSQ5tUUqyqNLhtojE/zszTcXuUaHYeyXHO7xGKz3N/NYXCVhjUHbkg1srG5
         O5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217555; x=1691809555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAdeA2B+EW+ai0RGsbG6q+tZPOctUxCkhZFz9cywSIU=;
        b=hRs5zgAeu2ncSvh/AjZ+PwYnR4DLqoKSGhZ5t+zJwA1ayyjbLnlp3S4MQFfltqBYhK
         Z78lcbrj38VS3jjY1CB86TP+LHhmxXgIzGMcI5gqw/6IipyS0PT+4h/bsZq0Fv1Wv1GR
         u3Acut8rRZCpoaj+XNH5kPBhMN54i82BtPicZ3HEX1pTz5ouYgdl4N8oHkaIm6d93Nzi
         lUCqlOIyBrrS32W3mLh8XsIL8W60kLkwZhit2PZlDcCcQSElYm2oCfz3ekrHwp/v7jSh
         Kh5SOvj+GkuZKwDsM0cSAlWSa/rjQgCmMD5NIkb+c4Qnydt29naeTJIN2n/g1tVGERmk
         163w==
X-Gm-Message-State: ABy/qLbtsb11Ela9rkuFE846EXYFO2PIouWSxk0SGQG8iVvEpXyOU2XC
        uzPRnlrh0ce0aEXsrTaHF735tyW28YezWi1o10fcfA==
X-Google-Smtp-Source: APBJJlE0tFVp3Q0Xcug15BBkfjbEN/aIulnDt8Wb7YzP0+ZLPpAcM6G0JoMLliqT/PJhJAs2dY6yOf2SA5YIxu/gjok=
X-Received: by 2002:a05:622a:1054:b0:3f8:175a:4970 with SMTP id
 f20-20020a05622a105400b003f8175a4970mr489084qte.18.1689217555220; Wed, 12 Jul
 2023 20:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230712083037.4081444-1-tmricht@linux.ibm.com>
 <20230712083037.4081444-2-tmricht@linux.ibm.com> <CAP-5=fW3M-RaOF=3wBzyimc1oZwJ9cPndRsvVs0fG9=B+D0FoQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW3M-RaOF=3wBzyimc1oZwJ9cPndRsvVs0fG9=B+D0FoQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 20:05:44 -0700
Message-ID: <CAP-5=fU-NUZFboVHnM03rR_773WDZ36T+ES5W4PoZSgUP7i7DQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix broken feature check for clang due to C++
 standard and changed library packaging
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 8:02=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jul 12, 2023 at 1:35=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > Perf build auto-detects features and packages already installed
> > for its build. This is done in directory tools/build/feature. This
> > directory contains small sample programs. When they successfully
> > compile the necessary prereqs in form of libraries and header
> > files are present.
> >
> > Such a check is also done for clang. And this check fails.
> >
> > Fix this and update to the latest C++ standard and use the
> > new library provided by clang (which contains new packaging)
> > see this link for reference:
> >  https://fedoraproject.org/wiki/Changes/Stop-Shipping-Individual-Compon=
ent-Libraries-In-clang-lib-Package
> >
> > Output before:
> >  # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
> >         ll test-clang.make.output
> >  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
> >                 > test-clang.make.output 2>&1 -std=3Dgnu++14 \
> >         -I/usr/include          \
> >         -L/usr/lib64            \
> >         -Wl,--start-group -lclangBasic -lclangDriver    \
> >           -lclangFrontend -lclangEdit -lclangLex        \
> >           -lclangAST -Wl,--end-group                    \
> >         -lLLVM-16       \
> >                         \
> >         > test-clang.make.output 2>&1
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
> >         cat test-clang.make.output
> >  g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
> >          > test-clang.make.output 2>&1 -std=3Dgnu++17     \
> >         -I/usr/include          \
> >         -L/usr/lib64            \
> >         -Wl,--start-group -lclang-cpp -Wl,--end-group   \
> >         -lLLVM-16       \
> >                         \
> >         > test-clang.make.output 2>&1
> >  #
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
> Tested-by: Ian Rogers <irogers@google.com>

Ah, presumably obsolete to:
https://lore.kernel.org/linux-perf-users/20230712083037.4081444-1-tmricht@l=
inux.ibm.com/

Thanks,
Ian



> Thanks!
> Ian
>
> > ---
> >  tools/build/feature/Makefile | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index f8db69654791..0b4a6e43c5cc 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -353,12 +353,10 @@ $(OUTPUT)test-llvm-version.bin:
> >                 > $(@:.bin=3D.make.output) 2>&1
> >
> >  $(OUTPUT)test-clang.bin:
> > -       $(BUILDXX) -std=3Dgnu++14                                 \
> > +       $(BUILDXX) -std=3Dgnu++17                                 \
> >                 -I$(shell $(LLVM_CONFIG) --includedir)          \
> >                 -L$(shell $(LLVM_CONFIG) --libdir)              \
> > -               -Wl,--start-group -lclangBasic -lclangDriver    \
> > -                 -lclangFrontend -lclangEdit -lclangLex        \
> > -                 -lclangAST -Wl,--end-group                    \
> > +               -Wl,--start-group -lclang-cpp -Wl,--end-group   \
> >                 $(shell $(LLVM_CONFIG) --libs Core option)      \
> >                 $(shell $(LLVM_CONFIG) --system-libs)           \
> >                 > $(@:.bin=3D.make.output) 2>&1
> > --
> > 2.41.0
> >
