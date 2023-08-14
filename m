Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5822677C38B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjHNWg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjHNWgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:36:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5AAB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:36:14 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so58971cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692052573; x=1692657373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C4m61aAlyTvnZ9ddi6Qehi7I8S64IaXUtfMsyvoqcA=;
        b=7lhpUtdqt/Xs7OI04RuTGLkbIWh7/yAb6a0IuFX9hkWkZuDOARGZQP2Gpm2Lfv/oJR
         zBm+zmtOpuDyrw9DA+3B0x9ZGIdoE9Z95a6o3eXZwUx5r1vCOcIJwNwg/tMgb0N7IdNh
         4ThIvIUkXO3WTdXk1vudwjS3C3fhbJJZsNbFhwlES+WmJ2cdP+3qZ3oFICjmgpMNZDjp
         Il7bT9yl6JG4sThxj6Rs2ZsPl2WWS5+ql4BozfEjGcpHgwedeJGn5jPeAV3m6+j1Zfmr
         9iTj3jjj7PnNpbFGlZijcNrmilYiT+l+fukiwrN4V1FwYaLhFb4eotjYsXfc/cLXr7IW
         N/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052573; x=1692657373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C4m61aAlyTvnZ9ddi6Qehi7I8S64IaXUtfMsyvoqcA=;
        b=QJTwB/PPNaKrtCl+D8jD3RN/LIu7Tj5CRwRuOyunK+0i5y11tBk0QrbBpDhtWPGQsK
         q19cvfInAOjnJ8+eZsSFxZHd023jWcZ90C3IlNx7tfEJkBCYfyjF5+CQh+d2iCrr7g7i
         jGGIStm/V4HY78NRAq0WmVLWJ82lB3znnoLrnj8LJN+tavwJh7ukgdiuEUrefvilWOXS
         +CN1/oAyRm3Ies5dIXmsRntHSO1PA9gL0wSjW8hTLGfcFPoBAL5l8s68YZedQXNnOzBI
         /rIYf/UrETKr8Ui9DNILY1Xu8XXaVmUX72EYgIpxtPR4X88X2psKHu3n3mXfya3I348N
         3Urg==
X-Gm-Message-State: AOJu0YxG8L3omwps1gnhfDK35CW1C3zqjVp9vwDQuvOGo0s9QXv5KDkq
        2IhkyvYnntkxZp1jWFQy3SPS3zwKsRb6wCOTdFESgg==
X-Google-Smtp-Source: AGHT+IFgvtOxDbhWw1QDSy67l3m6qzzvvgJ8g0QuFwDdn4jcXkZuSbNV5gomHHV5ysls30V6ggWNWM56UbY48qVTW8A=
X-Received: by 2002:a05:622a:18a1:b0:403:b242:3e30 with SMTP id
 v33-20020a05622a18a100b00403b2423e30mr717216qtc.1.1692052573398; Mon, 14 Aug
 2023 15:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com> <1691394685-61240-7-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1691394685-61240-7-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 15:36:02 -0700
Message-ID: <CAP-5=fWyLQrYt=LVS9SoxsuZuR5fmRaNOn+v8qxdYa6WH7WmMA@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] perf jevents: Add support for Arm CMN PMU aliasing
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 12:51=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Currently just add aliases for part of Arm CMN PMU events which
> are general and compatible for any SoC and CMN-ANY.
>
> "Compat" value "434*;436*;43c*;43a*" means it is compatible with
> all CMN600/CMN650/CMN700/Ci700, which can be obtained from
> commit 7819e05a0dce ("perf/arm-cmn: Revamp model detection").
>
> The arm-cmn PMU events got from:

nit: The use of the words "events" and "aliases" can be confusing -
aliases isn't specific as there may be a notion of other aliases like
for PMU names. I think in the code base we should avoid to use
"aliases" and just use "events".

Thanks,
Ian

> [0] https://developer.arm.com/documentation/100180/0302/?lang=3Den
> [1] https://developer.arm.com/documentation/101408/0100/?lang=3Den
> [2] https://developer.arm.com/documentation/102308/0302/?lang=3Den
> [3] https://developer.arm.com/documentation/101569/0300/?lang=3Den
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     | 266 +++++++++++++++=
++++++
>  tools/perf/pmu-events/jevents.py                   |   1 +
>  2 files changed, 267 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tool=
s/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> new file mode 100644
> index 0000000..e54036c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> @@ -0,0 +1,266 @@
> +[
> +       {
> +               "EventName": "hnf_cache_miss",
> +               "EventIdCode": "0x1",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts total cache misses in first l=
ookup result (high priority).",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_slc_sf_cache_access",
> +               "EventIdCode": "0x2",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of cache accesses in f=
irst access (high priority).",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_cache_fill",
> +               "EventIdCode": "0x3",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts total allocations in HN SLC (=
all cache line allocations to SLC).",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_pocq_retry",
> +               "EventIdCode": "0x4",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of retried requests.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_pocq_reqs_recvd",
> +               "EventIdCode": "0x5",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of requests that HN re=
ceives.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_sf_hit",
> +               "EventIdCode": "0x6",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of SF hits.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_sf_evictions",
> +               "EventIdCode": "0x7",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of SF eviction cache i=
nvalidations initiated.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_dir_snoops_sent",
> +               "EventIdCode": "0x8",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of directed snoops sen=
t (not including SF back invalidation).",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_brd_snoops_sent",
> +               "EventIdCode": "0x9",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of multicast snoops se=
nt (not including SF back invalidation).",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_slc_eviction",
> +               "EventIdCode": "0xa",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of SLC evictions (dirt=
y only).",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_slc_fill_invalid_way",
> +               "EventIdCode": "0xb",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of SLC fills to an inv=
alid way.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_mc_retries",
> +               "EventIdCode": "0xc",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of retried transaction=
s by the MC.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_mc_reqs",
> +               "EventIdCode": "0xd",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of requests that are s=
ent to MC.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hnf_qos_hh_retry",
> +               "EventIdCode": "0xe",
> +               "Type": "0x5",
> +               "BriefDescription": "Counts number of times a HighHigh pr=
iority request is protocolretried at the HN=E2=80=91F.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_s0_rdata_beats",
> +               "EventIdCode": "0x1",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of RData beats (RVALID and RR=
EADY) dispatched on port 0. This event measures the read bandwidth, includi=
ng CMO responses.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_s1_rdata_beats",
> +               "EventIdCode": "0x2",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of RData beats (RVALID and RR=
EADY) dispatched on port 1. This event measures the read bandwidth, includi=
ng CMO responses.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_s2_rdata_beats",
> +               "EventIdCode": "0x3",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of RData beats (RVALID and RR=
EADY) dispatched on port 2. This event measures the read bandwidth, includi=
ng CMO responses.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_rxdat_flits",
> +               "EventIdCode": "0x4",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of RXDAT flits received. This=
 event measures the true read data bandwidth, excluding CMOs.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_txdat_flits",
> +               "EventIdCode": "0x5",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of TXDAT flits dispatched. Th=
is event measures the write bandwidth.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_txreq_flits_total",
> +               "EventIdCode": "0x6",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of TXREQ flits dispatched. Th=
is event measures the total request bandwidth.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "rnid_txreq_flits_retried",
> +               "EventIdCode": "0x7",
> +               "Type": "0xa",
> +               "BriefDescription": "Number of retried TXREQ flits dispat=
ched. This event measures the retry rate.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "sbsx_txrsp_retryack",
> +               "EventIdCode": "0x4",
> +               "Type": "0x7",
> +               "BriefDescription": "Number of RXREQ flits dispatched. Th=
is event is a measure of the retry rate.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "sbsx_txdat_flitv",
> +               "EventIdCode": "0x5",
> +               "Type": "0x7",
> +               "BriefDescription": "Number of TXDAT flits dispatched fro=
m XP to SBSX. This event is a measure of the write bandwidth.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "sbsx_arvalid_no_arready",
> +               "EventIdCode": "0x21",
> +               "Type": "0x7",
> +               "BriefDescription": "Number of cycles the SBSX bridge is =
stalled because of backpressure on AR channel.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "sbsx_awvalid_no_awready",
> +               "EventIdCode": "0x22",
> +               "Type": "0x7",
> +               "BriefDescription": "Number of cycles the SBSX bridge is =
stalled because of backpressure on AW channel.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "sbsx_wvalid_no_wready",
> +               "EventIdCode": "0x23",
> +               "Type": "0x7",
> +               "BriefDescription": "Number of cycles the SBSX bridge is =
stalled because of backpressure on W channel.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_txrsp_retryack",
> +               "EventIdCode": "0x2a",
> +               "Type": "0x4",
> +               "BriefDescription": "Number of RXREQ flits dispatched. Th=
is event is a measure of the retry rate.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_arvalid_no_arready",
> +               "EventIdCode": "0x2b",
> +               "Type": "0x4",
> +               "BriefDescription": "Number of cycles the HN-I bridge is =
stalled because of backpressure on AR channel.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_arready_no_arvalid",
> +               "EventIdCode": "0x2c",
> +               "Type": "0x4",
> +               "BriefDescription": "Number of cycles the AR channel is w=
aiting for new requests from HN-I bridge.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_awvalid_no_awready",
> +               "EventIdCode": "0x2d",
> +               "Type": "0x4",
> +               "BriefDescription": "Number of cycles the HN-I bridge is =
stalled because of backpressure on AW channel.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_awready_no_awvalid",
> +               "EventIdCode": "0x2e",
> +               "Type": "0x4",
> +               "BriefDescription": "Number of cycles the AW channel is w=
aiting for new requests from HN-I bridge.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_wvalid_no_wready",
> +               "EventIdCode": "0x2f",
> +               "Type": "0x4",
> +               "BriefDescription": "Number of cycles the HN-I bridge is =
stalled because of backpressure on W channel.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "EventName": "hni_txdat_stall",
> +               "EventIdCode": "0x30",
> +               "Type": "0x4",
> +               "BriefDescription": "TXDAT valid but no link credit avail=
able.",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 9c0f63a..bfdfb67 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -272,6 +272,7 @@ class JsonEvent:
>            'DFPMC': 'amd_df',
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
> +          'arm_cmn': 'arm_cmn',
>        }
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>
> --
> 1.8.3.1
>
