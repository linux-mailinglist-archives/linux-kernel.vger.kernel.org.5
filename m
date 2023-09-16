Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C537A2DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 06:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjIPEL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 00:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjIPELK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 00:11:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95941BD2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 21:11:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-414ba610766so163501cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 21:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694837463; x=1695442263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syTDTrshUF5SFirABmARqauR5mR8y8+dKSQEBJXASCc=;
        b=DipMFQ5iyOXfIKKtybDHdegJofxAKHO8xRVszxHetZD9PEZc8xFPaiUzI8kdF/8GAq
         gXK834NDZp1aaGoii/xfPtdKlwyuMzMSNoSWwyp5MpDWDH9/YLNuZI6qHxTIgKFcGQK/
         h7qlXyMoHDDfgfUVUqEDB83TCjmz01EMnSKaVQ7CYtddR6cq02ucmMhvW2682BjpukqM
         w2nzHoyQnEZGzOjfpTVQQ8n7npGkyDW1hsIhGpOQERXBC4TA9sw/Jjl77OldPT0zVItc
         SwApCFJnqiChHW4vhQ8/S2Tj0GlmI6eHMcACIiQj7q0rIO+BQM5HKPWgsJhvi1UoyDGf
         xe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694837463; x=1695442263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syTDTrshUF5SFirABmARqauR5mR8y8+dKSQEBJXASCc=;
        b=KGJK7m085hl3yi6qvUbwj7/KMQ2rH7Z9sNJO7rG/aOjeE4rwgtBHJQ0yPh9SuTLm8Y
         SG1TbLSNplhJoXuMWMWaKKnOlVKDAGAlwmKYhRmZrxOyTwROohReFhjsZtkKvMOWPCaZ
         bI3YT3z6E7Y5aT/mgqUjjIU5yK7PHQyK1/Wo5RRNJpBdOza7vOqZb/pVILK0qK6SY+Rj
         gneHjOvhdjoyipb2XtPdppbhXaI5i/b9LWEUifC4a8LT3xK+31o4DjkvSU5lDwLufPKh
         SisEIQz0q+bcs3CasknMFhYUEYFV59Np3saFPdRm/MBa3opS0820czul7tObuOf0qByc
         tOBQ==
X-Gm-Message-State: AOJu0YxVu81BFZrwkYNKZbebDgk8tnwOtCa3NEwv1BFOm1knTyfgjO6u
        Eu32YdvNYfPNpQ00XxQyk1/zw8W/W/aeqY3Avv8Uaw==
X-Google-Smtp-Source: AGHT+IEFr9/Jdf++WS9NWYi5suUReUcZVbq3rmqVj9sYy4hKYUE5GVufGEQc18lhEJ/8wBowIi3gVch7ZnsNg1UplO0=
X-Received: by 2002:a05:622a:1104:b0:403:e1d1:8b63 with SMTP id
 e4-20020a05622a110400b00403e1d18b63mr152321qty.24.1694837463307; Fri, 15 Sep
 2023 21:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230913125157.2790375-1-tmricht@linux.ibm.com>
 <CAP-5=fUiHMRPVYhbQv-YM+EMKyBF6TEopea=PPX2thbtdmhGsg@mail.gmail.com> <CAM9d7cgbMZzJea_TJJ46AEhLentykmy8r6twC8bkkgXTNAMqgw@mail.gmail.com>
In-Reply-To: <CAM9d7cgbMZzJea_TJJ46AEhLentykmy8r6twC8bkkgXTNAMqgw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Sep 2023 21:10:50 -0700
Message-ID: <CAP-5=fUXgC7QPk+NqeKFds54do70iePaXC5F8nLC6oWPLC50yg@mail.gmail.com>
Subject: Re: [PATCH] perf jevent: fix core dump on software events on s390
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, dengler@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:40=E2=80=AFPM Namhyung Kim <namhyung@gmail.com> w=
rote:
>
> Hello,
>
> On Thu, Sep 14, 2023 at 6:14=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Sep 13, 2023 at 5:52=E2=80=AFAM Thomas Richter <tmricht@linux.i=
bm.com> wrote:
> > >
> > > Running commands such as
> > >  # ./perf stat -e cs -- true
> > >  Segmentation fault (core dumped)
> > >  # ./perf stat -e cpu-clock-- true
> > >  Segmentation fault (core dumped)
> > >  #
> > >
> > > dump core. This should not happen as these events are defined
> > > even when no hardware PMU is available.
> > > Debugging this reveals this call chain:
> > >
> > >   perf_pmus__find_by_type(type=3D1)
> > >   +--> pmu_read_sysfs(core_only=3Dfalse)
> > >        +--> perf_pmu__find2(dirfd=3D3, name=3D0x152a113 "software")
> > >             +--> perf_pmu__lookup(pmus=3D0x14f0568 <other_pmus>, dirf=
d=3D3,
> > >                                   lookup_name=3D0x152a113 "software")
> > >                  +--> perf_pmu__find_events_table (pmu=3D0x1532130)
> > >
> > > Now the pmu is "software" and it tries to find a proper table
> > > generated by the pmu-event generation process for s390:
> > >
> > >  # cd pmu-events/
> > >  # ./jevents.py  s390 all /root/linux/tools/perf/pmu-events/arch |\
> > >         grep -E '^const struct pmu_table_entry'
> > >  const struct pmu_table_entry pmu_events__cf_z10[] =3D {
> > >  const struct pmu_table_entry pmu_events__cf_z13[] =3D {
> > >  const struct pmu_table_entry pmu_metrics__cf_z13[] =3D {
> > >  const struct pmu_table_entry pmu_events__cf_z14[] =3D {
> > >  const struct pmu_table_entry pmu_metrics__cf_z14[] =3D {
> > >  const struct pmu_table_entry pmu_events__cf_z15[] =3D {
> > >  const struct pmu_table_entry pmu_metrics__cf_z15[] =3D {
> > >  const struct pmu_table_entry pmu_events__cf_z16[] =3D {
> > >  const struct pmu_table_entry pmu_metrics__cf_z16[] =3D {
> > >  const struct pmu_table_entry pmu_events__cf_z196[] =3D {
> > >  const struct pmu_table_entry pmu_events__cf_zec12[] =3D {
> > >  const struct pmu_table_entry pmu_metrics__cf_zec12[] =3D {
> > >  const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
> > >  const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
> > >  const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
> > >  #
> > >
> > > However event "software" is not listed, as can be seen in the
> > > generated const struct pmu_events_map pmu_events_map[].
> > > So in function perf_pmu__find_events_table(), the variable
> > > table is initialized to NULL, but never set to a proper
> > > value. The function scans all generated &pmu_events_map[]
> > > tables, but no table matches, because the tables are
> > > s390 CPU Measurement unit specific:
> > >
> > >   i =3D 0;
> > >   for (;;) {
> > >       const struct pmu_events_map *map =3D &pmu_events_map[i++];
> > >       if (!map->arch)
> > >            break;
> > >
> > >       --> the maps are there because the build generated them
> > >
> > >            if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > >                 table =3D &map->event_table;
> > >                 break;
> > >            }
> > >       --> Since no matching CPU string the table var remains 0x0
> > >       }
> > >       free(cpuid);
> > >       if (!pmu)
> > >            return table;
> > >
> > >       --> The pmu is "software" so it exists and no return
> > >
> > >       --> and here perf dies because table is 0x0
> > >       for (i =3D 0; i < table->num_pmus; i++) {
> > >               ...
> > >       }
> > >       return NULL;
> > >
> > > Fix this and do not access the table variable. Instead return 0x0
> > > which is the same return code when the for-loop was not successful.
> > >
> > > Output after:
> > >  # ./perf stat -e cs -- true
> > >
> > >  Performance counter stats for 'true':
> > >
> > >                  0      cs
> > >
> > >        0.000853105 seconds time elapsed
> > >
> > >        0.000061000 seconds user
> > >        0.000827000 seconds sys
> > >
> > >  # ./perf stat -e cpu-clock -- true
> > >
> > >  Performance counter stats for 'true':
> > >
> > >               0.25 msec cpu-clock #    0.341 CPUs utilized
> > >
> > >        0.000728383 seconds time elapsed
> > >
> > >        0.000055000 seconds user
> > >        0.000706000 seconds sys
> > >
> > >  # ./perf stat -e cycles -- true
> > >
> > >  Performance counter stats for 'true':
> > >
> > >    <not supported>      cycles
> > >
> > >        0.000767298 seconds time elapsed
> > >
> > >        0.000055000 seconds user
> > >        0.000739000 seconds sys
> > >
> > >  #
> > >
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> I'll add this too, ok?
>
> Fixes: 7c52f10c0d4d8 ("perf pmu: Cache JSON events table")

Looks good, thanks!
Ian

> Thanks,
> Namhyung
