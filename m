Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B47600F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGXVP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGXVPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:15:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A7F1AA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:15:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-766fd5f9536so325845185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690233319; x=1690838119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4rysK55oB8iprX5PsN92lskw7NnrBKRNpCCq0EizyQ=;
        b=1BXELcHUXg/+rCkwfBoa14IfiR2Q6aqU9PgFbw47oz0uC3np3HFNCaFz7ScGSD5/Mq
         DQ2deQyYa6L8MreNAP/kbkznCiJ5lVuxnhfnrHFfd7TilrEZNfgf05J4hKAWXPiFXCKp
         w2saThXCYP65xSFqvvNKuNizMsmiRJkbU1CrPzPT6jgiRpEfH5PpOv1qTdGsIVNhCvAe
         Gntw2xb1FeAwbgsih7FPFGkyqFi3TaKSwJrgCjzW3MJ1FEezE8GysHleA1+80rYFJBqh
         nI1ugr89BQt/oT26XVioNDLE/paobBJMMPO2VpTFOpV8yTf+D95fnySZsTO0RH7SoWAV
         YxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233319; x=1690838119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4rysK55oB8iprX5PsN92lskw7NnrBKRNpCCq0EizyQ=;
        b=B+lK4Jr5vjtjhsWixgbZhT1n0SrhiSfZCwT2fLjQ7noQCVzXBjvz963zmWte5In2Ai
         RZK2XI4MfYOwZnCvRUfna7FXOlq0O6kCJQvLSI1H1WtC+xNF3yg8IgvVEQr2qD7Nf3UQ
         cml3M8Xp9t9grckeInrY4MOu/ibaSL4jmbikODpoE2UGtWGpxoxfb20PleTlzYVRuxYC
         XhtyX6N1+Vk9fg9tFJF+gXCCFPQP1dn8Xo46TufiPdPGOtJdwK/PnaXG765bDd4LayO+
         DRah244kfSeNyzbqUDCLOpUaTjA8HkPsq9oE84/f9/Fp+PhVIzOObQ2EVgMiX99Gemau
         FWtg==
X-Gm-Message-State: ABy/qLacQOtWajBOry/GcP0HRgWHW3wgq1iNwpJo3Kea3qmGwJdw577E
        FwgSxFJ3yQXR/tK6C1yX/nfEV89sKM7X8ZdOuXtkyA==
X-Google-Smtp-Source: APBJJlGzkKPEZS/cCDJEywZijBo4Ycb4UpPFNxCPqzb5sG8S3hNQy1Vf6sw4+I8SpcgyjWOXfG3YKaJb/rNkKkoJIKU=
X-Received: by 2002:a0c:facf:0:b0:635:e4ed:b6c9 with SMTP id
 p15-20020a0cfacf000000b00635e4edb6c9mr949080qvo.24.1690233319030; Mon, 24 Jul
 2023 14:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 14:15:07 -0700
Message-ID: <CAKwvOd=12eSPyc5ZRgm8NPMJYjj13QOxcnHtv_Y7Ws-zffyUrA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
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

On Mon, Jul 24, 2023 at 1:12=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add a build flag, LTO=3D1, so that perf is built with the -flto
> flag. Address some build errors this configuration throws up.

Hi Ian,
Thanks for the performance numbers. Any sense of what the build time
numbers might look like for building perf with LTO?

Does `-flto=3Dthin` in clang's case make a meaningful difference of
`-flto`? I'd recommend that over "full LTO" `-flto` when the
performance difference of the result isn't too meaningful.  ThinLTO
should be faster to build, but I don't know that I've ever built perf,
so IDK what to expect.
--=20
Thanks,
~Nick Desaulniers
