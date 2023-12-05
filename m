Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696B804887
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbjLEEZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEEZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:25:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0F83
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:25:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso4194a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 20:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701750333; x=1702355133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgAMRXqQYaDBV6wyGUZmXuMtTS9bHHBbShJFrMu8R94=;
        b=YT2hWwDkCsSBKNE+L3cHL3odpQ/ysz3p1n0KHksRmx0c9wisK0f2kffYTjeEN3GFVx
         PxEbsOQAZWIVRsnkFU2xu1XfjGTL/6uPsJmrE60HZD8tx0PRA3EZjSgt7oJXLI8XfFId
         +pa365/hEKGsdndv7dYaU4677e3dK1WEfrMZnKHXlLM+50ssxj7OFKhC47JiWfJijUTe
         ZYeRFNo4WFUAdjuPgtGWjFCs004vB0zLHi2IZ4uIwsbO5+frcCg+H9V4EeKY+qDOVCcg
         hXkfpXdqzFUtbL387dvLw68Iv8NLk9AZ94G+7QTob0mnQHWUIkHEZaKtbDpySBB0+sgh
         H2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701750333; x=1702355133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgAMRXqQYaDBV6wyGUZmXuMtTS9bHHBbShJFrMu8R94=;
        b=V4DOsyhnJUcTdZtWpK5IHQMcmdr1pPc7MSarRtjJlFg283hdowCkTU/hzb1a0v1Jo+
         hSGtysP2NjfCa+CCY/630yWw+Zhym3EvblQJwNYvMM7jp8ruBbG7QHotw2M2rX0H4/0Y
         fl9ZjBZDK/nfdeazrEWAaRV9+nGcoQmo0eMQAUkxAie6JIb8XDGF2zbs632m3OCG4wCy
         tAOX2xCPefIc5cvuq3jP5dZNNSo3pUZOBpV1KoMmi6vNYoSt9JTa6ZaoilL+qU2DAu6f
         KDAfi3mQ4uedWaqnLpU6NMaNl+A67D8HcQ5lYzzZSsYC+JReRm9tFCWrD3+CNHHCleCv
         q61w==
X-Gm-Message-State: AOJu0YxnFA4art2YwAhuPQLPb1U35lWRy0d/IubdEQmQGdhxHvlOh3vO
        r+BOjTXOqlxzXAexhfGrKNunGIuV0Zfx+yDM0im11Q==
X-Google-Smtp-Source: AGHT+IG1Y+SWJHsHsHJOwW1bKr3R8/Za5N4Jl0wjRHmEmgTElx2KScn7AGso+1h60y3mkkHPPuEMnYtymTYPk0maEV8=
X-Received: by 2002:a50:cc82:0:b0:54b:8f42:e3dc with SMTP id
 q2-20020a50cc82000000b0054b8f42e3dcmr490832edi.2.1701750332278; Mon, 04 Dec
 2023 20:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
In-Reply-To: <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 20:25:20 -0800
Message-ID: <CAP-5=fUBGLPdFn4EfwoAamQ=5nX3LOM1v8LZk2ExEDckm+6fhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 4, 2023 at 7:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Mon, Dec 4, 2023 at 2:45=E2=80=AFPM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
> >
> >
> >
> > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > A metric is default by having "Default" within its groups. The defaul=
t
> > > metricgroup name needn't be set and this can result in segv in
> > > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > > that assume it has a value when there is a Default metric group. To
> > > avoid the segv initialize the value to "".
> > >
> > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Thanks! I was going to look for the bug but got pulled to other
> > tasks. The patch looks good to me and I tested it successfully on
> > AmpereOne.
> >
> >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com=
>
>
> Looks like it needs to go through perf-tools for v6.7.
> Ian, do you think this one is enough?

From a user's pov the json fix is nicer as otherwise perf stat output
for the relevant metrics lacks a heading on the left. This fix is
smaller. I'm easy about which to take :-)

Thanks,
Ian

> Thanks,
> Namhyung
