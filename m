Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D37A2B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjIOXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjIOXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:40:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F1211E;
        Fri, 15 Sep 2023 16:40:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79ac0d271b4so44607539f.1;
        Fri, 15 Sep 2023 16:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694821252; x=1695426052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO9FWXF4sW0O2zZEyRretZrMgBHOH2O0kUFn014rSMs=;
        b=C8b6KSmazj+mCDqrEE5RFaOC4Z8DmD45Sr5XdYAbO/hfDbxpvh55PO/p4jYte5Rrbp
         CAWPNLbT7OX49e+h3FVZzLx5m5m8c/wrukxGCQbnMVN0u4UPwaxjKTJZKmenhueoVR1k
         Jv4E5OEzKy9n+ZAzBv8htHxpoQHHCwB0UHPJz9rkbw30C/T5d3JLPOdqRchOqIRIC/mJ
         tZm8Zqx6X7JVYO18q+0NmB3H+ey3/Trojgd4OJkZjol4sW+Hgk+WGrUMSQE34ex9kvlA
         61dHreuLqA00Gdqy0qntHFbcY1YpR6WmtGgGWn2nNJWnCEhZUCUzHu6Q0euNlx7T9ai4
         kB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821252; x=1695426052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO9FWXF4sW0O2zZEyRretZrMgBHOH2O0kUFn014rSMs=;
        b=QYFF4DG+eadZNPGviPcPquXSekBQ5zNPlS3vcBpUK4b/Crx8zlGwu9EENT/P1giZDE
         Dn/rY/UN5m37y1ZLpywgPydTw83kkchZACEE9JTimbixYVIsUh1UKvZ2ANQlUz0R0APn
         UetutL9Ad6PXm9ErK3Lez3/4PiE63TwdhJ1g3SzaOLuVaavaVeWZNS/B5SSNOoVE++7j
         WRjX60BNMKVCU14VOUeomlHOp7nLdZE24MB52YNfaUUab9tA7CBI4JFTQuGL73hzoazL
         J39are9Z1ma9uttH8798j7EWbmY4Snnw4OxRk84WCxpHX1Is3KDcRhjLCd8CJBQvdwdX
         /VWw==
X-Gm-Message-State: AOJu0YztJr5mbaD4v5W/e68bjZQ+DcEfmzKMCJJ6M5A4zxTDhmNATsAc
        aLNXal0SuHOQHuUSti27t5YtGoKFkS5uq+EcNsU=
X-Google-Smtp-Source: AGHT+IF12SUvYWI+8jdWScsnqk4oXrhiTK4VkFBJRTWeEpkNAI0ZRDiJaAFILrXncaT4cn0S3KdvsfsNaHFa0k9zLN8=
X-Received: by 2002:a6b:4001:0:b0:794:ed2b:2520 with SMTP id
 k1-20020a6b4001000000b00794ed2b2520mr3049414ioa.15.1694821252316; Fri, 15 Sep
 2023 16:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230913125157.2790375-1-tmricht@linux.ibm.com> <CAP-5=fUiHMRPVYhbQv-YM+EMKyBF6TEopea=PPX2thbtdmhGsg@mail.gmail.com>
In-Reply-To: <CAP-5=fUiHMRPVYhbQv-YM+EMKyBF6TEopea=PPX2thbtdmhGsg@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 15 Sep 2023 16:40:41 -0700
Message-ID: <CAM9d7cgbMZzJea_TJJ46AEhLentykmy8r6twC8bkkgXTNAMqgw@mail.gmail.com>
Subject: Re: [PATCH] perf jevent: fix core dump on software events on s390
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, dengler@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 14, 2023 at 6:14=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Sep 13, 2023 at 5:52=E2=80=AFAM Thomas Richter <tmricht@linux.ibm=
.com> wrote:
> >
> > Running commands such as
> >  # ./perf stat -e cs -- true
> >  Segmentation fault (core dumped)
> >  # ./perf stat -e cpu-clock-- true
> >  Segmentation fault (core dumped)
> >  #
> >
> > dump core. This should not happen as these events are defined
> > even when no hardware PMU is available.
> > Debugging this reveals this call chain:
> >
> >   perf_pmus__find_by_type(type=3D1)
> >   +--> pmu_read_sysfs(core_only=3Dfalse)
> >        +--> perf_pmu__find2(dirfd=3D3, name=3D0x152a113 "software")
> >             +--> perf_pmu__lookup(pmus=3D0x14f0568 <other_pmus>, dirfd=
=3D3,
> >                                   lookup_name=3D0x152a113 "software")
> >                  +--> perf_pmu__find_events_table (pmu=3D0x1532130)
> >
> > Now the pmu is "software" and it tries to find a proper table
> > generated by the pmu-event generation process for s390:
> >
> >  # cd pmu-events/
> >  # ./jevents.py  s390 all /root/linux/tools/perf/pmu-events/arch |\
> >         grep -E '^const struct pmu_table_entry'
> >  const struct pmu_table_entry pmu_events__cf_z10[] =3D {
> >  const struct pmu_table_entry pmu_events__cf_z13[] =3D {
> >  const struct pmu_table_entry pmu_metrics__cf_z13[] =3D {
> >  const struct pmu_table_entry pmu_events__cf_z14[] =3D {
> >  const struct pmu_table_entry pmu_metrics__cf_z14[] =3D {
> >  const struct pmu_table_entry pmu_events__cf_z15[] =3D {
> >  const struct pmu_table_entry pmu_metrics__cf_z15[] =3D {
> >  const struct pmu_table_entry pmu_events__cf_z16[] =3D {
> >  const struct pmu_table_entry pmu_metrics__cf_z16[] =3D {
> >  const struct pmu_table_entry pmu_events__cf_z196[] =3D {
> >  const struct pmu_table_entry pmu_events__cf_zec12[] =3D {
> >  const struct pmu_table_entry pmu_metrics__cf_zec12[] =3D {
> >  const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
> >  const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
> >  const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
> >  #
> >
> > However event "software" is not listed, as can be seen in the
> > generated const struct pmu_events_map pmu_events_map[].
> > So in function perf_pmu__find_events_table(), the variable
> > table is initialized to NULL, but never set to a proper
> > value. The function scans all generated &pmu_events_map[]
> > tables, but no table matches, because the tables are
> > s390 CPU Measurement unit specific:
> >
> >   i =3D 0;
> >   for (;;) {
> >       const struct pmu_events_map *map =3D &pmu_events_map[i++];
> >       if (!map->arch)
> >            break;
> >
> >       --> the maps are there because the build generated them
> >
> >            if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> >                 table =3D &map->event_table;
> >                 break;
> >            }
> >       --> Since no matching CPU string the table var remains 0x0
> >       }
> >       free(cpuid);
> >       if (!pmu)
> >            return table;
> >
> >       --> The pmu is "software" so it exists and no return
> >
> >       --> and here perf dies because table is 0x0
> >       for (i =3D 0; i < table->num_pmus; i++) {
> >               ...
> >       }
> >       return NULL;
> >
> > Fix this and do not access the table variable. Instead return 0x0
> > which is the same return code when the for-loop was not successful.
> >
> > Output after:
> >  # ./perf stat -e cs -- true
> >
> >  Performance counter stats for 'true':
> >
> >                  0      cs
> >
> >        0.000853105 seconds time elapsed
> >
> >        0.000061000 seconds user
> >        0.000827000 seconds sys
> >
> >  # ./perf stat -e cpu-clock -- true
> >
> >  Performance counter stats for 'true':
> >
> >               0.25 msec cpu-clock #    0.341 CPUs utilized
> >
> >        0.000728383 seconds time elapsed
> >
> >        0.000055000 seconds user
> >        0.000706000 seconds sys
> >
> >  # ./perf stat -e cycles -- true
> >
> >  Performance counter stats for 'true':
> >
> >    <not supported>      cycles
> >
> >        0.000767298 seconds time elapsed
> >
> >        0.000055000 seconds user
> >        0.000739000 seconds sys
> >
> >  #
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

I'll add this too, ok?

Fixes: 7c52f10c0d4d8 ("perf pmu: Cache JSON events table")

Thanks,
Namhyung
