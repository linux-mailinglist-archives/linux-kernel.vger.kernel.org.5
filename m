Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F87A5639
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjIRXef convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:34:34 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4390;
        Mon, 18 Sep 2023 16:34:29 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-792717ef3c9so173617339f.3;
        Mon, 18 Sep 2023 16:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080068; x=1695684868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1MBG/8N9ID9Y0dMkemv1pUiIymtv+KnT7vt9Hz75SY=;
        b=ATORJRhTw7/OLHXa1tdqIKHKDx23LXCuxqXcMYXqJ70qhpm98ZvcbujVI37tbUYFKl
         QTWpC7jehFwy396EkfmFUr/Ier4NtH1/jgsYjjJjdpDiie68SLB5xqfJyd+5H4TLeqye
         EsqnqHCEOpiVk+MOaPJFC/8JvbE4G29bo0xtH/dJce0hAh+WzCHF7fMl2Q6uZPF0OrWz
         xVC+tYqt5CUbaHXPjidJdvhuYQk0jARIyPHjfcq5enM1Gdnv7wJbMZt2iBs7L2shRDt5
         OeSkJdcJby6J4WHl1ReeUJR1w7VMuIJQNMBkb8c3A6RwoX1MW/vPuYg8HvK1+A/pb1XT
         QIFA==
X-Gm-Message-State: AOJu0YwyagtdJQXfsSwHXUJRQ1/8FzqPp0Ajg5hBHrygFoiL4aOKDryJ
        sbmBF1IlAfXgjoarSOCe+my6QzwfEBUJj/3Z8cY=
X-Google-Smtp-Source: AGHT+IENDcI36OKlfzNhoW5wTDYOUEabYwAmoc5KA3TD2VnDcnrdeWPmnWNMf+HNeHS4KrAhQiK//mxJu+9t8Oavno4=
X-Received: by 2002:a6b:e009:0:b0:798:2415:1189 with SMTP id
 z9-20020a6be009000000b0079824151189mr13620379iog.12.1695080068237; Mon, 18
 Sep 2023 16:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com> <20230914211948.814999-5-irogers@google.com>
In-Reply-To: <20230914211948.814999-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 18 Sep 2023 16:34:16 -0700
Message-ID: <CAM9d7ci3JPZ8ABamXUCRrAEV3jE=twPLSByOU_LC8LdzPedP2w@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf test: Ensure EXTRA_TESTS is covered in build test
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Sep 14, 2023 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
>
> Add to run variable.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/make | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index a3a0f2a8bba0..d9945ed25bc5 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -138,6 +138,7 @@ endif
>  run += make_python_perf_so
>  run += make_debug
>  run += make_nondistro
> +run += make_extra_tests

I'm curious why it's missed.. I couldn't find a commit to delete it.
Maybe due to an incorrect resolution of a merge conflict?

Thanks,
Namhyung


>  run += make_no_bpf_skel
>  run += make_gen_vmlinux_h
>  run += make_no_libperl
> --
> 2.42.0.459.ge4e396fd5e-goog
>
