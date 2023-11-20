Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0A7F1E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjKTUs4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 15:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:48:54 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A8D2;
        Mon, 20 Nov 2023 12:48:50 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c210e34088so2400386a12.2;
        Mon, 20 Nov 2023 12:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700513329; x=1701118129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLACAszJAsDeK07wyfvEz6u3BDeunNq6zbMUiAuxf0E=;
        b=A10hVPw9mQD8NCYDOwlRZVNFeUqHvFZExfTIhcwWVuTtAg6Nc0D6bCJLK7HGtxyxvM
         TBcNFghjCN8y4y4UsIJ4pJQj4zmd5p8JxOx9gNeDFCAjd05GLm3c8KV28xk6CfuI0PBy
         hMqLD1PhKO31aQrLRV2goC+T8F7eFG6ZMMFDAp2AhbGfTa/peIhBAVPCBoKv4HVYoh7v
         oM5o+rE+Qqi87V82VTllu15Ij+Du/7cXvsvzCJmIX/OWkd2LsKTnsT6Dozchkrkd4Jl9
         Y87tu0a/9SmlWsq+N5sTe3UsnKYXqExW4kzfwX8cBCobdMcxP5TwR+mzPuIVu6tL+vzr
         zcnw==
X-Gm-Message-State: AOJu0Yx92rmzrf2SMLSRD9L5rmMcVcczucppHB/DBZC+OGqD6QKaiPKW
        qDrZtLL9LAbEYr/BbzsN2j3MjZlhmRXGR8P+XfE=
X-Google-Smtp-Source: AGHT+IHywMwLFnWqSkjrlIFC80pbu6VrGJfN+mUb07oSvHQbrBOCZAsTklCHMyBM/aeS0v3kXbPfBpmEekRrnV8UFe8=
X-Received: by 2002:a17:90b:4c06:b0:280:e2e1:f955 with SMTP id
 na6-20020a17090b4c0600b00280e2e1f955mr9229635pjb.35.1700513329510; Mon, 20
 Nov 2023 12:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20231113102327.695386-1-james.clark@arm.com>
In-Reply-To: <20231113102327.695386-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 20 Nov 2023 12:48:38 -0800
Message-ID: <CAM9d7cj=nF_Vq7dPkOGvYd1G0nFOffiCoyZQ=hx1hco-0_ZMBw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Use existing config value for objdump path
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yonghong Song <yhs@fb.com>, Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 13, 2023 at 2:23 AM James Clark <james.clark@arm.com> wrote:
>
> There is already an existing config value for changing the objdump path,
> so instead of having two values that do the same thing, make perf test
> use annotate.objdump as well.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Documentation/perf-config.txt | 8 ++------
>  tools/perf/tests/builtin-test.c          | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 16398babd1ef..379f9d7a8ab1 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -251,7 +251,8 @@ annotate.*::
>                 addr2line binary to use for file names and line numbers.
>
>         annotate.objdump::
> -               objdump binary to use for disassembly and annotations.
> +               objdump binary to use for disassembly and annotations,
> +               including in the 'perf test' command.
>
>         annotate.disassembler_style::
>                 Use this to change the default disassembler style to some other value
> @@ -722,11 +723,6 @@ session-<NAME>.*::
>                 Defines new record session for daemon. The value is record's
>                 command line without the 'record' keyword.
>
> -test.*::
> -
> -       test.objdump::
> -               objdump binary to use for disassembly and annotations.
> -
>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 113e92119e1d..b8c21e81a021 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -518,7 +518,7 @@ static int run_workload(const char *work, int argc, const char **argv)
>  static int perf_test__config(const char *var, const char *value,
>                              void *data __maybe_unused)
>  {
> -       if (!strcmp(var, "test.objdump"))
> +       if (!strcmp(var, "annotate.objdump"))
>                 test_objdump_path = value;
>
>         return 0;
> --
> 2.34.1
>
