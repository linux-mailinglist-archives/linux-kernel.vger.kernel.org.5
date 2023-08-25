Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7146D787EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjHYEOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241060AbjHYEON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:14:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F231FE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:14:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40c72caec5cso176291cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936850; x=1693541650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKfe9hj3CSEjPgT+xs+Xkj5Dyaeh49hojcs26VEawjg=;
        b=gH7vRW4dFyzhoVPyRya43rZBxxCwpPn8Iat8xoj2VFbHeOSypyM9N5OYJV83OrG28M
         TjFtsKTERG6CyHpGa0ygjDQNsMdbABDnhBr30dT2zNW6eZtKn6GYa8K/iAPCuB755zSg
         IjnODLEy6wccewRHS/TTiw4CiAvslzHJSKM44BTH6EDFde5CsWaLg6C4ogDj2OdyDUzo
         N8NqIu1XqnObYim9JuGyztXHXPDpTa3+bDO73rwcsYV2gMATH8SDv3GnvKtrXwuJACrZ
         1JHy1AvQrYS3AxoNuy44xXcM448aNa1FcfuRMm1w2Q2KoCVLKDo6Xaxfk19M3NKhH+go
         otLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936850; x=1693541650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKfe9hj3CSEjPgT+xs+Xkj5Dyaeh49hojcs26VEawjg=;
        b=K2YRSkq5tQvoxByS9Dn1LbneI1X6KFrIJ/zkJKGODL6J8p7Yudxk+19gatgxCDtwzU
         /a0kJDuzephc0Dhol6XXpsYHVvLoul3tc1qOCn66nRW10PGFTOd0glCdpC8vMnadqhr7
         T6tyqTblTyHIAb7RmQhZiTk5VzqWnfhX5Ow+DvOuIfGv9Hf607YcaDhxjy84xu5HP31g
         Y725Qrk99/dgkzE4XLlpcgGsrAQAuqDiL9r2m/BguRlKS6iGTWIQWg0NoEqLmXR6XDtq
         O14WKWzCm5usJTd5VB7+1v3eTh4X9GtIY5H+jZHopC8thKKTRv8bDFnYlcIPnit+xW7X
         v1+w==
X-Gm-Message-State: AOJu0YyEecs51lLLPwSvvFexBCfF6Wwn/lLF4FuFXUt1+hZpnE+cWm4r
        4AhahdTVZKtTv2hu95MpgGxMplmJLWt4cth6pALHQg==
X-Google-Smtp-Source: AGHT+IHqa8ysBCGVGYZ/HNb8fmiyrV4qlgLt5JjJ0Wd1AyaVpqKq/oOWW8ppOiBft+z80j/uU9XdLgZaqxeOyHweoDk=
X-Received: by 2002:a05:622a:1a99:b0:403:ac9c:ac2f with SMTP id
 s25-20020a05622a1a9900b00403ac9cac2fmr96191qtc.17.1692936850440; Thu, 24 Aug
 2023 21:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-9-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-9-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:13:58 -0700
Message-ID: <CAP-5=fU3-iuHd6Yd6SGtffZr92eMN3nb0NRM40KmqKPxKZobHA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] perf vendor events: Add JSON metrics for Arm CMN
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 1:36=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Add JSON metrics for Arm CMN. Currently just add part of CMN PMU
> metrics which are general and compatible for any SoC with CMN-ANY.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  | 74 ++++++++++++++++=
++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.j=
son
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json b/t=
ools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
> new file mode 100644
> index 0000000..64db534
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
> @@ -0,0 +1,74 @@
> +[
> +       {
> +               "MetricName": "slc_miss_rate",
> +               "BriefDescription": "The system level cache miss rate.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"

Here a ';' is used as a separator, but for "Unit" ',' is used as a
separator. Is there a reason for the inconsistency?

Thanks,
Ian

> +       },
> +       {
> +               "MetricName": "hnf_message_retry_rate",
> +               "BriefDescription": "HN-F message retry rate indicates wh=
ether a lack of credits is causing the bottlenecks.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "sf_hit_rate",
> +               "BriefDescription": "Snoop filter hit rate can be used to=
 measure the snoop filter efficiency.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "mc_message_retry_rate",
> +               "BriefDescription": "The memory controller request retrie=
s rate indicates whether the memory controller is the bottleneck.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "rni_actual_read_bandwidth.all",
> +               "BriefDescription": "This event measure the actual bandwi=
dth that RN-I bridge sends to the interconnect.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "rni_actual_write_bandwidth.all",
> +               "BriefDescription": "This event measures the actual write=
 bandwidth at RN-I bridges.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "rni_retry_rate",
> +               "BriefDescription": "RN-I bridge retry rate indicates whe=
ther the memory controller is the bottleneck.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flit=
s_total",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       },
> +       {
> +               "MetricName": "sbsx_actual_write_bandwidth.all",
> +               "BriefDescription": "sbsx actual write bandwidth.",
> +               "MetricGroup": "cmn",
> +               "MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "434*;436*;43c*;43a*"
> +       }
> +]
> --
> 1.8.3.1
>
