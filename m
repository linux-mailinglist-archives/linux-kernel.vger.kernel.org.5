Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0A787F36
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbjHYFXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjHYFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:23:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278591FE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:23:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40a47e8e38dso107291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692940991; x=1693545791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPtybhiqchWiyAtwBr9z+TbjcNikPgcMysmwOQUd7QY=;
        b=W0+o1bAmDaX3vHWAB0XNKY+lJtyuWBNYdzroYXSOlSxfe5h/Cyf3qeVm/XDFW3WiXI
         r+a0JliMVCFHUPRIDdSQIEMNUKtsfy6L1X/Q+++h9fY18cm1rScp3tQ9x2rW4q7FM6Tq
         Mpt9TQNZkyABGHD3PISgfvzV9Yqj3SfnRfTU9HgVGlHiaBhGV1xGb53USPE41Y+EKhRV
         h3LpIpG5+K1Tc8emGxFD0hXc5Rlyb9izKVelGz3zSWrMBSxek90yb5eTAIRQzFxJEOjw
         DuhLQzKl4ECg5V+QMXvILoe9UFYVhNMOi8MOwvqOKkcwleH6YV5tJLbX54P9NeeJ+lIm
         3Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692940991; x=1693545791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPtybhiqchWiyAtwBr9z+TbjcNikPgcMysmwOQUd7QY=;
        b=QZGz45X3+075I/wpIxdogaX6BGT21tQjARObhaxWY1Y0mC4vbW5oCnNutqaO3JFm4v
         mJi3C5TR0bM2D9u6R9v5JqZmMF6Li7Sa61eYApCtWVyFzCfpMBw/pezmK9I0ocRUe3TU
         Ny5y+Srqkiit5ju8ENQvPap+tBhDv8UB5/QfZ0uanoDMP48CXcA/3iQey/kR0HeLjba4
         GyiZY+4OPkC0AiH79ys4zvTpExRMMmVdZnFMNj/3CySbLq48LIE1Zbe3uSdWc4xFAwlq
         3agy0M0luADoPWwP1JhYIoV4I9TdDGwLxf+r0xRKpf/CRQHFxQit5tVmUIAXBxMRP0QK
         h3jQ==
X-Gm-Message-State: AOJu0Yz1gk9eqwS0IwcmLhJFMXrSehXiDmbGg5lirMn6ZUGh4Hr5638W
        lZlG2e5Yrl0xuU3lanvygnRz4oyW4uvI4FYbvRqr2Q==
X-Google-Smtp-Source: AGHT+IFOdrfP2IEfWI1nC1Y7GnNhql7Ltd6coR06pzDDS33UxBR9XVaqu9tforQG+61tn9brCeGDydoBHZi1ZwGiiIU=
X-Received: by 2002:a05:622a:1355:b0:3f0:af20:1a37 with SMTP id
 w21-20020a05622a135500b003f0af201a37mr117260qtk.15.1692940991147; Thu, 24 Aug
 2023 22:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-6-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-6-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 22:22:59 -0700
Message-ID: <CAP-5=fWK=vd4H6_SHpDw4rMN4eODSM5hmBY=rJ5F9fQMq-HcUg@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] perf test: Update base-record & system-wide-dummy
 attr expected values for test-record-C0
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 6:30=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> 1. Because a dummy sideband event is added to the sampling of specified
>    CPUs. When evlist contains evsel of different sample_type,
>    evlist__config() will change the default PERF_SAMPLE_ID bit to
>    PERF_SAMPLE_IDENTIFICATION bit.
>    The attr sample_type expected value of base-record and system-wide-dum=
my
>    in test-record-C0 needs to be updated.
>
> 2. The perf record uses evlist__add_aux_dummy() instead of
>    evlist__add_dummy() to add a dummy event.
>    The expected value of system-wide-dummy attr needs to be updated.
>
> The perf test result is as follows:
>
>   # ./perf test list  2>&1 | grep 'Setup struct perf_event_attr'
>    17: Setup struct perf_event_attr
>   # ./perf test 17
>    17: Setup struct perf_event_attr                                    : =
Ok

Will the kernel test robot complain about the previous patches
breaking this test? It may be best to update the test while changing
the behavior in those patches.

Thanks,
Ian


> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/tests/attr/system-wide-dummy | 14 ++++++++------
>  tools/perf/tests/attr/test-record-C0    |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/a=
ttr/system-wide-dummy
> index 2f3e3eb728eb..a1e1d6a263bf 100644
> --- a/tools/perf/tests/attr/system-wide-dummy
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -9,8 +9,10 @@ flags=3D8
>  type=3D1
>  size=3D136
>  config=3D9
> -sample_period=3D4000
> -sample_type=3D455
> +sample_period=3D1
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER
> +sample_type=3D65671
>  read_format=3D4|20
>  # Event will be enabled right away.
>  disabled=3D0
> @@ -18,12 +20,12 @@ inherit=3D1
>  pinned=3D0
>  exclusive=3D0
>  exclude_user=3D0
> -exclude_kernel=3D0
> -exclude_hv=3D0
> +exclude_kernel=3D1
> +exclude_hv=3D1
>  exclude_idle=3D0
>  mmap=3D1
>  comm=3D1
> -freq=3D1
> +freq=3D0
>  inherit_stat=3D0
>  enable_on_exec=3D0
>  task=3D1
> @@ -32,7 +34,7 @@ precise_ip=3D0
>  mmap_data=3D0
>  sample_id_all=3D1
>  exclude_host=3D0
> -exclude_guest=3D0
> +exclude_guest=3D1
>  exclude_callchain_kernel=3D0
>  exclude_callchain_user=3D0
>  mmap2=3D1
> diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr=
/test-record-C0
> index 317730b906dd..198e8429a1bf 100644
> --- a/tools/perf/tests/attr/test-record-C0
> +++ b/tools/perf/tests/attr/test-record-C0
> @@ -10,9 +10,9 @@ cpu=3D0
>  enable_on_exec=3D0
>
>  # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> -# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
> +# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
>  # + PERF_SAMPLE_CPU added by -C 0
> -sample_type=3D455
> +sample_type=3D65927
>
>  # Dummy event handles mmaps, comm and task.
>  mmap=3D0
> --
> 2.30.GIT
>
