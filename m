Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE937DC02E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjJ3TAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Oct 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjJ3TAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:00:38 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02BDB;
        Mon, 30 Oct 2023 12:00:35 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso4834332b3a.3;
        Mon, 30 Oct 2023 12:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692435; x=1699297235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hotmwLNWfZIOI71jmodI5J3pb3/x688ktpGXbF2+9Qg=;
        b=NoCUx7UvyRHDK9JPM5bTymMVDaTD/Po0fdArKWM29WiRzGtHM9YLSbuy6gXsN7VxWq
         qWqEMoubDQntumblIEBMmW+8lmJs3XhA/LAzbQw/dZB62NCbphOQyQI25/FLu7ARfomp
         iY4QQ0PfiBTuE6Fbztl1SfPQYeIITyTWo8RaHeTW0JB5csWxhXuIBrnqPlOjW+TW8OrN
         R3nf9Xc0086pYfTf7htLNzeEyszKJBqDjV2aULmZ6OqOhXhc//78zzrDyb52Of2EPEsS
         rD7mIlF0DdwXZ8p+2h0oQwsithncxmSyF9TjYTOITcfNSa96+8soJ48BHegnxLNU+Gz4
         F3Iw==
X-Gm-Message-State: AOJu0Yxp1MKPXCL4VvRpY5j45T2jXAlA2WVkDZWpGfR6xdLSQXaztzzI
        tZRTeka1GHbgxY0FcJuQHFzakMCUUn+SoK32vI4=
X-Google-Smtp-Source: AGHT+IHxvcQYqxvtaR4Wef4SHRJ6n5Dv0uoom04l6WxPXUIx5qkTRLh8T9JXMxeDAq0PoRYsuSUxgq4J0sI3+ZKXmMs=
X-Received: by 2002:a05:6a20:8f0f:b0:17b:8016:6f79 with SMTP id
 b15-20020a056a208f0f00b0017b80166f79mr13979449pzk.3.1698692435310; Mon, 30
 Oct 2023 12:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com> <e05d01dd-dd6f-4bb6-857f-3458b9b7159d@linux.intel.com>
In-Reply-To: <e05d01dd-dd6f-4bb6-857f-3458b9b7159d@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Oct 2023 12:00:24 -0700
Message-ID: <CAM9d7cg=y8mAQVMh7-Q6nt_Oj2Tif2+NZx0hxJnPPKHc9BAWYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] perf vendor events intel: Update
 alderlake/alderlake events to v1.23
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:16 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2023-10-25 8:31 p.m., Ian Rogers wrote:
> > Update alderlake and alderlaken events from v1.21 to v1.23 adding the
> > changes from:
> > https://github.com/intel/perfmon/commit/8df4db9433a2aab59dbbac1a70281032d1af7734
> > https://github.com/intel/perfmon/commit/846bd247c6e04acc572ca56c992e9e65852bbe63
> >
> > The tsx_cycles_per_elision metric is updated from PR:
> > https://github.com/intel/perfmon/pull/116
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks Ian. The whole patch series looks good to me.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Applied to perf-tools-next, thanks!
