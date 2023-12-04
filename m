Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B4803E04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjLDTDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjLDTDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:03:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7C8F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:03:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so1651a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716599; x=1702321399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3patIUasVYl44OnkTW8tZ5hoP9CKgx51bwg6aa1ps2o=;
        b=dc+9PuTLb2jHcvB4hEzVyQCGkX/aD0XumWkuUrb7oSh7b4Fkoy3NpvV4WhKv9/kSYV
         HXWSWrFEyPqZj1lat7+pj/nNzTpWD3fMaluk+6Azw6qtz/LZ29+tmAHEmRqb2ELtBXw5
         rpUIhpdShPBgXUPpd1KkfOixNsq+1f7IxSPoWucyOt1jcoyRi0I290+zdvR4WZsoeAXi
         fkblXM1/tvl/XFCmXG7/UK8kzyqcEkYXUpnE4xXSy6T5sq81XYT641+ca2lUGIUQOKk3
         Wm0d5K6mN/LM8l24Dcd+UDrIQIRt+Iyb23QpnQWq/XDS4JzKvcaAWbZkoBhmqa3/tgGV
         XC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716599; x=1702321399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3patIUasVYl44OnkTW8tZ5hoP9CKgx51bwg6aa1ps2o=;
        b=NxPeQreVDr8N2BRK5Ci3gA+bO+GdtX/x26XXDgjosFM0dF4oHOyvB4fQLpA/3kMv42
         XxdnFgnUOZ7ARFADhEIcpzJddOR3xAtie+b6vX6TVpQLNe0m78C+fiXDTWITmz9xfCzg
         8Tdb473uZ4EUSRSjk3yx9sNZpeirajMZT+Gk442dz+hNw2PXPXKrmx/AVKS2AYvMKgcH
         308nNZRcppIYQywRab7TvQ75i9FDqlSeaKJ5b4X8agpg733GxJcjRxTkkHe7/1Xum0jO
         CuwGJN6ozdVlkmXEAOKXyh1uZvMg1i56I2h6Py1SDDdvFGuWRSJ4m3nFDIpa7qcpC/lI
         kHJg==
X-Gm-Message-State: AOJu0Yx0Y0trEYFHlmsinUiFzY/TM9FRPBx4pKQy25QQuxGIwhwWatEl
        p3pi09tS4txTgkPNE667NjnM0KXxvfTs1lLSGym0BQ==
X-Google-Smtp-Source: AGHT+IHpFP4IwRHSnWAcYG/jbBNlaN2sY1FYbD0QjhIdOW7/Z248wZPfkm9Gu2K33fIFIHTef2G1343PdDfnyw7fTR0=
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr320455edb.0.1701716599146; Mon, 04 Dec
 2023 11:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com> <20231201021550.1109196-3-ilkka@os.amperecomputing.com>
In-Reply-To: <20231201021550.1109196-3-ilkka@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 11:03:07 -0800
Message-ID: <CAP-5=fWKjRORSVh65cm+RMknS_-K=XQC2ew1VVaakvoX1X6CKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf vendor events arm64: AmpereOne: Rename
 BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT
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
> The documentation wrongly called the event as BPU_FLUSH_MEM_FAULT and now
> has been fixed. Correct the name in the perf tool as well.
>
> Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU ev=
ents")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-d=
ef.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.js=
on
> index 88b23b85e33c..879ff21e0b17 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
> @@ -110,7 +110,7 @@
>      {
>          "PublicDescription": "Flushes due to memory hazards",
>          "EventCode": "0x121",
> -        "EventName": "BPU_FLUSH_MEM_FAULT",
> +        "EventName": "GPC_FLUSH_MEM_FAULT",
>          "BriefDescription": "Flushes due to memory hazards"
>      },
>      {
> --
> 2.41.0
>
