Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474A752E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjGMXtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjGMXtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:49:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5C6270D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:49:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401d1d967beso141721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689292183; x=1691884183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf9eZzWTd6bCo2iXJG8qXItCRIW3JnWJx3nH8jBZutg=;
        b=SJjfzpaKzFbBuDyqlrE/ipmpMRjo7y1qKInpFfEOEaoB3yIWinzJE+x2gVM5ExTzt1
         C5c0bIZ4JpSOGDsK1amFVlCr8Q/5H7BQjTdDuWXcPNyPgM6L2BUNuNaElskXTOJK0PTk
         ZrhyPL53FpXpX/UEO/b970w3OxxN0FkRp0A8dp3HTpat7PWIJRi4tqRzvYRbOYasVCzW
         6v8DlBlD+ssptEa0XcDlqETnKBk+GVuyaHbh0R1mzhgT2G1MmfRwhYvFqStLu9Gy5Pij
         jpJGyFb57KdIbzVqgmHKFQqPMo5ie5+fAUl0Cxau2gr+2v7E3055eKZ7FgX7m8tOWR+e
         Eeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689292183; x=1691884183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf9eZzWTd6bCo2iXJG8qXItCRIW3JnWJx3nH8jBZutg=;
        b=dNmDp9HTAJzV/+FGVgsQ6hkfzfohSO/dR6Y7C1BVc65Uf/LyJgn1wKO595Qj1NZgy2
         wk/On7cSo8JbpbmaiDXCthuv0lkjvPr58j57xMrsSLru7GmTysQw9HlC3FGUjn4ACcRK
         iOeC6oSTICOTlb7xiDHeZIPQQeIrxBCpT92yKBcYxaT9FOSP8iwQ1hGYI5Q5MdV0koq2
         No2P9Pys5EZBSKp0K3OdPznSgZ841AIdohWmPAcXLBJ9ygXiHxBJt5+LbxJGEvLtofhz
         ntR8einXC0KumbAz5QeZomz1r8Irv7uc60t84T/HJgg9GokxIJbEaaUw3bNdky2zd19O
         YCfw==
X-Gm-Message-State: ABy/qLZWe2eRFOK+ofZfVAAKFQeFFYXJV/Ywufs+a/ibSDsYQoqGfHlO
        Pf+o6/XsW/fDUfqz3nlsPPJme19ywwVC6c105aQMrg==
X-Google-Smtp-Source: APBJJlGftfREFmdHrV6IExA64KVjl5xkgorvIdPr8XG1tV1oKh4LXNSAfN5cK6N1tNbLJPQIEagQX+mNOZkqNLSvp5A=
X-Received: by 2002:ac8:5acf:0:b0:3f8:5b2:aef0 with SMTP id
 d15-20020ac85acf000000b003f805b2aef0mr825420qtd.24.1689292183189; Thu, 13 Jul
 2023 16:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230713111930.1636612-1-tmricht@linux.ibm.com>
In-Reply-To: <20230713111930.1636612-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Jul 2023 16:49:31 -0700
Message-ID: <CAP-5=fXSrR5bqHRP=rGoMeWE+beZT36JTXctGP7tawjjx=m6Hw@mail.gmail.com>
Subject: Re: [PATCH v2] perf build: Support llvm and clang support compiled in
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 4:19=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf build suports llvm and clang support compiled in.
> Test case 56 builtin clang support provides a test case
> which is always skipped.
>
> Link perf with the latest llvm and clang libraries and
> enable this test case.
>
> Use 'make LIBCLANGLLVM=3D1' to include this support.
>
> V2: Add Library patch before -lclang-cpp
>
> Output before:
>  # ./perf test 56
>  56: builtin clang support                  :
>  56.1: builtin clang compile C source to IR : Skip (not compiled in)
>  56.2: builtin clang compile C source to ELF object: \
>                                         Skip (not compiled in)
>
> Output after:
>  # ./perf test 56
>  56: builtin clang support                          :
>  56.1: builtin clang compile C source to IR         : Ok
>  56.2: builtin clang compile C source to ELF object : Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Jiri Olsa <jolsa@kernel.org>

Build tested with LLVM 14 and 15 using:
BUILD_BPF_SKEL=3D1 LIBCLANGLLVM=3D1 LLVM_CONFIG=3Dllvm-config-14
BUILD_BPF_SKEL=3D1 LIBCLANGLLVM=3D1 LLVM_CONFIG=3Dllvm-config-15

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 2 +-
>  tools/perf/Makefile.perf   | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0609c19caabd..a90af438261c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -325,7 +325,7 @@ CORE_CFLAGS +=3D -Wall
>  CORE_CFLAGS +=3D -Wextra
>  CORE_CFLAGS +=3D -std=3Dgnu11
>
> -CXXFLAGS +=3D -std=3Dgnu++14 -fno-exceptions -fno-rtti
> +CXXFLAGS +=3D -std=3Dgnu++17 -fno-exceptions -fno-rtti
>  CXXFLAGS +=3D -Wall
>  CXXFLAGS +=3D -fno-omit-frame-pointer
>  CXXFLAGS +=3D -ggdb3
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 097316ef38e6..158a0733fc9d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -426,10 +426,7 @@ EXTLIBS :=3D $(call filter-out,$(EXCLUDE_EXTLIBS),$(=
EXTLIBS))
>  LIBS =3D -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whol=
e-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>
>  ifeq ($(USE_CLANG), 1)
> -  CLANGLIBS_LIST =3D AST Basic CodeGen Driver Frontend Lex Tooling Edit =
Sema Analysis Parse Serialization
> -  CLANGLIBS_NOEXT_LIST =3D $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_=
CONFIG) --libdir)/libclang$(l))
> -  LIBCLANG =3D $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l=
).so))
> -  LIBS +=3D -Wl,--start-group $(LIBCLANG) -Wl,--end-group
> +  LIBS +=3D -L$(shell $(LLVM_CONFIG) --libdir) -lclang-cpp
>  endif
>
>  ifeq ($(USE_LLVM), 1)
> --
> 2.41.0
>
