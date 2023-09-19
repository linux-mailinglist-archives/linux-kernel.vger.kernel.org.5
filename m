Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71A47A6860
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjISPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjISPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:53:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79EA1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:53:00 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41761e9181eso428521cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695138780; x=1695743580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nsBUVYDFNOxgJdETsIwWFClz7Q5uuGgP6zIRpvMQ70=;
        b=jFXMigqQz/YyR1YirujrfayK2k7wilalOv4NcbDgj62FCDamTU2O8yCBI5Ik2/cPKJ
         +lDGc4R6F6CmwCwngnZx0p00RgvT3FE5s5yAdPTFJSUmaFZk0tGmTYjNlhRL4HiDjRfM
         gI52j0dgvyKQ6xMwDBjc1cwNPWSvDJG+uCe1BvaY60/dfmwu0AyXfUVko4Tu4J9nIFKd
         bJrR7f1IAxXKdRVEQwwImArXOjbx3DlwM4RfK2BaaFvcs6WsRtk1s1MDzK9621LNVmRm
         c873088/GGWH8EV9IclYdNi3H1Fe8ineVbbxomQqmsG8a5LVlE9d/TOMXfm0TOdWHfdA
         ljCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138780; x=1695743580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nsBUVYDFNOxgJdETsIwWFClz7Q5uuGgP6zIRpvMQ70=;
        b=W50DCCmWVnln+eEKdLJ2oC8eZXzC+yWyRvzX+6d62gaqn3vpXAQjxmh9BRyIaC9Mpb
         yQKuGNvPDtnQfTrXXqHX0BUPhWhoN2WMw/M2KtI3rDDCJaCuRG0W2BGuBpKaFw6zCN9h
         EnGSji2dxYUxr/TY9+fsX2o+ZSm5ssK7GNGsDR7Aik2/fBs45uf47br0OHa13pMU3hRL
         Cj83vXVU82uMCM2QbW5HBOpyZgFtBMaL9NaexD7f1QK/mwRvspXH1Ixhd8WI6ZvshSmx
         N1o344ptC5SHn5zbkb8RmqAJ7pfoB4abtFy0ZGz4UpeFQ/QoTJm8hIYMVDDulix0Tx+m
         YXZA==
X-Gm-Message-State: AOJu0Ywvi4txASB26FGmg5vEB6q9m+tFU2cRa+wxAWqJd//xcuZW4rr7
        6Z/sZ03p3fBJiz75sxHQ6N/f0iJHvtQytjLEdS8q1w==
X-Google-Smtp-Source: AGHT+IFlMvLJGZKXJoc7RUu3qT8PIIJ7oTPxBXbyAB45pOagXviu3Nn6H2lhJ+/IWQtixCbS9riI0KpsSSfFnqS6k4I=
X-Received: by 2002:ac8:4e4b:0:b0:417:9144:9567 with SMTP id
 e11-20020ac84e4b000000b0041791449567mr324953qtw.0.1695138779698; Tue, 19 Sep
 2023 08:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230919080929.3807123-1-xu.yang_2@nxp.com>
In-Reply-To: <20230919080929.3807123-1-xu.yang_2@nxp.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Sep 2023 08:52:47 -0700
Message-ID: <CAP-5=fX46xYdE2bheU+LhW2Joce+De42=d-XqBuFS9F-CPsQsg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: fix no member named 'entries' issue
To:     Xu Yang <xu.yang_2@nxp.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 19, 2023 at 1:04=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> The struct "pmu_events_table" has been changed after commit
> 2e255b4f9f41 (perf jevents: Group events by PMU, 2023-08-23).
> So there doesn't exist 'entries' in pmu_events_table anymore.
> This will align the members with that commit. Othewise, below
> errors will be printed when run jevent.py:
>
> pmu-events/pmu-events.c:5485:26: error: =E2=80=98struct pmu_metrics_table=
=E2=80=99 has no member named =E2=80=98entries=E2=80=99
>  5485 |                         .entries =3D pmu_metrics__freescale_imx8d=
xl_sys,
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks Xu! I wasn't able to repeat the failure but the fix looks good
to me. Is the failure caused by adding new imx8dxl metrics? I'd like
to make sure we have testing coverage so this doesn't happen again.
I'm trying:
$ make -C tools/perf O=3D/tmp/perf JEVENTS_ARCH=3Dall
Could you confirm that this make command was broken without your fix
plus the metric changes you've done?

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index a7e88332276d..af15fa2cadbd 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -764,8 +764,8 @@ static const struct pmu_sys_events pmu_sys_event_tabl=
es[] =3D {
>        continue
>      _args.output_file.write(f"""\t{{
>  \t\t.metric_table =3D {{
> -\t\t\t.entries =3D {tblname},
> -\t\t\t.length =3D ARRAY_SIZE({tblname})
> +\t\t\t.pmus =3D {tblname},
> +\t\t\t.num_pmus =3D ARRAY_SIZE({tblname})
>  \t\t}},
>  \t\t.name =3D \"{tblname}\",
>  \t}},
> --
> 2.34.1
>
