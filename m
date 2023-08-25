Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C316E787F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjHYF0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHYFZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:25:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA61FE3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:25:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34cabf65ee8so113215ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692941152; x=1693545952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbdGy0NmHQroxMMpjOSAleHrdCZ6MJ+r3ixMQrh1nmk=;
        b=tnZE8XBXKivLRJkdILuCf1Eetego414ME4erJjEJipSKdJAiQWnKKl9iNI7qjM5EcO
         PlHG9Q+gGd+mLt/UtIXePpcYrzDzWHIWsKBDEIlcM+ZAVoK0PqR2xdjJfHx0n+t8yqWp
         Wl/m4HZ7lKy4oDXBrQhhuAt77fXwbdMFNlYpOprtN9ceLx3htENxWc+vfdrhUdHDozjO
         D1urDRk5LSqZhgoi5eiOko9hYUGZuYkjC3J+ruq8qA9MSr0DCJNQeTy5+p8WD8RJAmWn
         W2d8bQ+DkGAue+aBCFXW7g8VOOi4CfWulbX4Rwbzxmk5Bm9ETAxDnDMgyJ+P2BVEYACJ
         mr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692941152; x=1693545952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbdGy0NmHQroxMMpjOSAleHrdCZ6MJ+r3ixMQrh1nmk=;
        b=e5utO5r8mwDYeCase+RLszJpRwUpv0Bdv/7bv+hKYXSg2p34pO6dSn/HMVomopU13T
         LxBhk84fEDGXivP+K2tCD5Fy3wm1pWokR3JhkU90vGz2mENqa/QZAUpFqyZk0D/NVnHn
         sENx/2WtHe53Jw1G3BoxVhqgirdJ47bLmYSDLAUYlMVnHd1HvJFMHmTwNfrWmTgYuiEJ
         SEKQ8DF0K/04n6/mANxnwvN3VEbhwTfFjBE3SiqYr1VQrSiBqfblQJEvOmbdbqWVTEmQ
         kud609tss2ZhG6kI5ftiadNWIjpGyaHtxjhTpkCTGa+q1KY+JcjmWv0HfFxuEFU+rRuQ
         fkKw==
X-Gm-Message-State: AOJu0YyaSbJ2u1fbC1pBt5Izuv/SR1LmKiEvCuUJMdhVmNlDXPGzH5Ew
        +ZgdjWvq0Ax6jtVweO70upLloPOlD9fVSZkRci2FCA==
X-Google-Smtp-Source: AGHT+IFwPeXziNWN3JhhxvfmXcT4+Bs8t2ebj8nQzybID13kwUqfImpxSn69Clr1+0HvL3kZ0R6ZBvtLvfXtrmSPNgs=
X-Received: by 2002:a05:6e02:b2d:b0:349:432c:329a with SMTP id
 e13-20020a056e020b2d00b00349432c329amr98119ilu.23.1692941152104; Thu, 24 Aug
 2023 22:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230821012734.18241-1-yangjihong1@huawei.com> <20230821012734.18241-8-yangjihong1@huawei.com>
In-Reply-To: <20230821012734.18241-8-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 22:25:40 -0700
Message-ID: <CAP-5=fUwkL7c0kSR5YRTDDEJmNweMx3U1Xfxovvs5-MFc2WJwg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] perf test: Add perf_event_attr test for record
 selected CPUs exclude_user
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 6:30=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> If all (non-dummy) evsel have exclude_user, system_wide sideband is not
> needed. Add this test scenario.
>
> Test result:
>
>   # ./perf test list 2>&1 | grep 'Setup struct perf_event_attr'
>    17: Setup struct perf_event_attr
>   # ./perf test 17 -v
>    17: Setup struct perf_event_attr                                    :
>   --- start ---
>   test child forked, pid 720198
>   <SNIP>
>   running './tests/attr/test-record-C0-all-kernel'
>   <SNIP>
>   test child finished with 0
>   ---- end ----
>   Setup struct perf_event_attr: Ok
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../perf/tests/attr/test-record-C0-all-kernel | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tools/perf/tests/attr/test-record-C0-all-kernel
>
> diff --git a/tools/perf/tests/attr/test-record-C0-all-kernel b/tools/perf=
/tests/attr/test-record-C0-all-kernel
> new file mode 100644
> index 000000000000..2d7549277c1e
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-C0-all-kernel
> @@ -0,0 +1,32 @@
> +[config]
> +command =3D record
> +args    =3D --no-bpf-event --all-kernel -C 0 kill >/dev/null 2>&1
> +ret     =3D 1
> +
> +[event:base-record]
> +cpu=3D0
> +
> +# no enable on exec for CPU attached
> +enable_on_exec=3D0
> +
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
> +# + PERF_SAMPLE_CPU added by -C 0
> +sample_type=3D65927
> +
> +# Dummy event handles mmaps, comm and task.
> +mmap=3D0
> +comm=3D0
> +task=3D0
> +
> +# exclude_user for all-kernel option
> +exclude_user=3D1
> +
> +[event:system-wide-dummy]
> +
> +# system_wide is not need for all (non-dummy) events have exclude_user
> +cpu=3D0
> +
> +# exclude_user for all-kernel option
> +exclude_user=3D1
> +exclude_kernel=3D0
> --
> 2.30.GIT
>
