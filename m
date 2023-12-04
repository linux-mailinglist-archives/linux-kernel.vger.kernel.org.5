Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C30803DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjLDTCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjLDTCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:02:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8BD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:02:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so1561a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716565; x=1702321365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnoJZxBn1akD3gBCNkqO7z5LOL/dfRt0CuzJTV9dCbw=;
        b=JvJP4NWsKj0O7gE005WcS6i+sTehVWFs3icoKuIbizjUCu5W0XFNTN5FwuXDER/7MG
         YRjAUaSIac9lB9Nq20YWg5Yf+zrlg96TApS7a2HI8wWnnvhqyKXPKsNvEleHpBI1IIjg
         1KQIXj/MCK2RRrYmO7dCzASBYBiatlMxMQs72GTwKKdSaBpj7I0AugiyRkB/cHjcv6GA
         Ym4zMXlasAQjKDJ5oYKoBoikS4yN6rg/KbIrUOk+aRFZ7/8CWp44Kj73p80NvlUISTGI
         ULljNJB6thX07sNnYw1SSJy+ZXTbvWYxfBCll+GP4N4LqAUu1YNxL+SlKPsDw+ggbaSt
         hlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716565; x=1702321365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnoJZxBn1akD3gBCNkqO7z5LOL/dfRt0CuzJTV9dCbw=;
        b=YhA20RcPVL+OE3xEvLW0/Mr83qx9HKL1Qf77ZtGfVuUGcbECEMclOwOCfP8+c+gZew
         0k/pOFCMH53Unhjwt4+6dX06Dl3D9pjdICmh5coo6iwIjBXMCq/qMCzcRcQCLQtc46PQ
         C6FJsa1+LoOy+Th59p85aKKqUAQcV70jiBy4/J4c6Isvnc6zDUaYU9rEaov8KHHOwqU8
         WMus0S9GIaJzoWJTHCh54b8JlCjknYRwOeqEhMks5oQyhiixKXcQfLjOCjIEeVOkNnNI
         cRwxGKzGz2WnKVLhIl4GuIoIX9Q2rn9i9T904qF6FWq7WddPGMNz7FGIirWjszuL4Sk7
         uFig==
X-Gm-Message-State: AOJu0Ywarxs95QAZAji5o+QCS6PPEH0XneuPiJwE3Ppk7A3SDticpQoE
        iLRNdVC+lNorIKw8k+u0GMwd6b26Z91vGhsvr3mGuA==
X-Google-Smtp-Source: AGHT+IFxsasyFnZBa9FnFBZicp3ls17foaY1ghbcUf3bVZalwL2VxAoGT930UO0RuiQyMiLRdsXUo8UFlYeQ2dGQeTM=
X-Received: by 2002:a50:aade:0:b0:54a:ee8b:7a8c with SMTP id
 r30-20020a50aade000000b0054aee8b7a8cmr414091edc.0.1701716564523; Mon, 04 Dec
 2023 11:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com> <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 11:02:31 -0800
Message-ID: <CAP-5=fWr0bmqZjyYiBuMuCD+sPCULmF_q7hU4J8ouvcvwb5Z6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf vendor events arm64: AmpereOne: Add missing
 DefaultMetricgroupName fields
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 6:16=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> AmpereOne metrics were missing DefaultMetricgroupName from metrics with
> "Default" in group name resulting perf to segfault. Add the missing
> field to address the issue.
>
> Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics=
")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Sorry, I just stumbled across this and sent a fix too.
https://lore.kernel.org/lkml/20231204182330.654255-1-irogers@google.com/
The patches are identical so I'd suggest taking this one and the first
patch in my changes.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.js=
on b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> index e2848a9d4848..afcdad58ef89 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -231,6 +231,7 @@
>          "MetricName": "slots_lost_misspeculation_fraction",
>          "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #sl=
ots))",
>          "BriefDescription": "Fraction of slots lost due to misspeculatio=
n",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>          "ScaleUnit": "1percent of slots"
>      },
> @@ -238,6 +239,7 @@
>          "MetricName": "retired_fraction",
>          "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
>          "BriefDescription": "Fraction of slots retiring, useful work",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>         "ScaleUnit": "1percent of slots"
>      },
> --
> 2.41.0
>
