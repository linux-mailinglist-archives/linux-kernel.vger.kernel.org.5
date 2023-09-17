Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D57A33D5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjIQF2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 01:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjIQF2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:28:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB31A3;
        Sat, 16 Sep 2023 22:28:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79ac0d271b4so76716039f.1;
        Sat, 16 Sep 2023 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694928492; x=1695533292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6IDBKrhfRPJH/ez+XxZO7kY7frB+RTYIZ5shrc8xVs=;
        b=HuOnffDB0aB3YxY/ENbA9cTX9fzYzHghGtHlBmgDWcJ3TJz5O2vRosWJWszWwSA1A7
         A/g6zcSxA7mC6J6xPbm/WZ9+liFMK3ULOo12ZvCcEv1IvPf2gPhQlHM3DpcfiNBuLw7l
         KrOsTF64Rbl/wPiqWXidGylzRi+IkWmBOg6+pN4awQu38WICw1tFP6iYuaj9GwzN2axS
         UlZ9qqauCRxcmYubhVwB6aP6MRjkTJcbUlMM+9h4gdPnGOD1u2paKM2gRQKrbz6fKuIx
         uwcXZGRF4eT1FkqK9N3CJdo/xYdredL/EyPLKcYfZBGoKPjTfbKJApLUD1XP29E03HAy
         3ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928492; x=1695533292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6IDBKrhfRPJH/ez+XxZO7kY7frB+RTYIZ5shrc8xVs=;
        b=R/hBCpQaIJaQZtyH0aVkx2Sp2xFq4DWDVhR1fkmFH2m7PDj+XHjZoTHQIlDIZJbXHL
         /Ra1PbHetbSUGXuFJBetdVr9DXvq39Dqh0J1vbHhdM0+PjVBfkCfqkZmVE8Dt7rI75ML
         yOh1w82NOKd33zTBztMDaDym2eP7WHEiCSQ/2z+HpRYF9j4WYS4POWlHgUVU7xRv13IR
         uP9/I/DxQ0nqFQCRB7L04NWHDAWLIdZxFDBlOWI7cEzUp+PGTlT6C60QD8bMu8jS26Of
         Kz946TLa1gfgeo1++UtkiEVE93+tH+LCgKn5Sn84zj0SCkbA9XjS2iBep0Un2aIinwGK
         9GfQ==
X-Gm-Message-State: AOJu0Yz5XhpwrqW9lMkALufKyV2DeuaYAlwGIBeE2bzKbx9lcxI0n4ds
        iLsk6rpiu2CYBRib+hFosy2RQf+tPR2nzSTfrMo=
X-Google-Smtp-Source: AGHT+IE32NkLvFiyd4rnVrgZ8uF3dliwkTVN3xQMjuBRv5nGT90K9JUdskEerE63bdygLZclQCp+FOE5qwT8FNUm7bI=
X-Received: by 2002:a5e:aa0c:0:b0:798:2665:8939 with SMTP id
 s12-20020a5eaa0c000000b0079826658939mr6351889ioe.20.1694928492101; Sat, 16
 Sep 2023 22:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230913125157.2790375-1-tmricht@linux.ibm.com>
 <CAP-5=fUiHMRPVYhbQv-YM+EMKyBF6TEopea=PPX2thbtdmhGsg@mail.gmail.com>
 <CAM9d7cgbMZzJea_TJJ46AEhLentykmy8r6twC8bkkgXTNAMqgw@mail.gmail.com> <CAP-5=fUXgC7QPk+NqeKFds54do70iePaXC5F8nLC6oWPLC50yg@mail.gmail.com>
In-Reply-To: <CAP-5=fUXgC7QPk+NqeKFds54do70iePaXC5F8nLC6oWPLC50yg@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Sat, 16 Sep 2023 22:28:00 -0700
Message-ID: <CAM9d7cjzkQ_5oKv9RJtx1QPBuR8fSjrZy_USKqt6G5WC+p_uqg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 9:11=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Sep 15, 2023 at 4:40=E2=80=AFPM Namhyung Kim <namhyung@gmail.com>=
 wrote:
> >
> > Hello,
> >
> > On Thu, Sep 14, 2023 at 6:14=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Wed, Sep 13, 2023 at 5:52=E2=80=AFAM Thomas Richter <tmricht@linux=
.ibm.com> wrote:
> > > >
> > > > Running commands such as
> > > >  # ./perf stat -e cs -- true
> > > >  Segmentation fault (core dumped)
> > > >  # ./perf stat -e cpu-clock-- true
> > > >  Segmentation fault (core dumped)
> > > >  #
> > > >
> > > > dump core. This should not happen as these events are defined
> > > > even when no hardware PMU is available.
> > > > Debugging this reveals this call chain:
> > > >
> > > >   perf_pmus__find_by_type(type=3D1)
> > > >   +--> pmu_read_sysfs(core_only=3Dfalse)
> > > >        +--> perf_pmu__find2(dirfd=3D3, name=3D0x152a113 "software")
> > > >             +--> perf_pmu__lookup(pmus=3D0x14f0568 <other_pmus>, di=
rfd=3D3,
> > > >                                   lookup_name=3D0x152a113 "software=
")
> > > >                  +--> perf_pmu__find_events_table (pmu=3D0x1532130)
> > > >
> > > > Now the pmu is "software" and it tries to find a proper table
> > > > generated by the pmu-event generation process for s390:
> > > >
> > > >  # cd pmu-events/
> > > >  # ./jevents.py  s390 all /root/linux/tools/perf/pmu-events/arch |\
> > > >         grep -E '^const struct pmu_table_entry'
> > > >  const struct pmu_table_entry pmu_events__cf_z10[] =3D {
> > > >  const struct pmu_table_entry pmu_events__cf_z13[] =3D {
> > > >  const struct pmu_table_entry pmu_metrics__cf_z13[] =3D {
> > > >  const struct pmu_table_entry pmu_events__cf_z14[] =3D {
> > > >  const struct pmu_table_entry pmu_metrics__cf_z14[] =3D {
> > > >  const struct pmu_table_entry pmu_events__cf_z15[] =3D {
> > > >  const struct pmu_table_entry pmu_metrics__cf_z15[] =3D {
> > > >  const struct pmu_table_entry pmu_events__cf_z16[] =3D {
> > > >  const struct pmu_table_entry pmu_metrics__cf_z16[] =3D {
> > > >  const struct pmu_table_entry pmu_events__cf_z196[] =3D {
> > > >  const struct pmu_table_entry pmu_events__cf_zec12[] =3D {
> > > >  const struct pmu_table_entry pmu_metrics__cf_zec12[] =3D {
> > > >  const struct pmu_table_entry pmu_events__test_soc_cpu[] =3D {
> > > >  const struct pmu_table_entry pmu_metrics__test_soc_cpu[] =3D {
> > > >  const struct pmu_table_entry pmu_events__test_soc_sys[] =3D {
> > > >  #
> > > >
> > > > However event "software" is not listed, as can be seen in the
> > > > generated const struct pmu_events_map pmu_events_map[].
> > > > So in function perf_pmu__find_events_table(), the variable
> > > > table is initialized to NULL, but never set to a proper
> > > > value. The function scans all generated &pmu_events_map[]
> > > > tables, but no table matches, because the tables are
> > > > s390 CPU Measurement unit specific:
> > > >
> > > >   i =3D 0;
> > > >   for (;;) {
> > > >       const struct pmu_events_map *map =3D &pmu_events_map[i++];
> > > >       if (!map->arch)
> > > >            break;
> > > >
> > > >       --> the maps are there because the build generated them
> > > >
> > > >            if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > > >                 table =3D &map->event_table;
> > > >                 break;
> > > >            }
> > > >       --> Since no matching CPU string the table var remains 0x0
> > > >       }
> > > >       free(cpuid);
> > > >       if (!pmu)
> > > >            return table;
> > > >
> > > >       --> The pmu is "software" so it exists and no return
> > > >
> > > >       --> and here perf dies because table is 0x0
> > > >       for (i =3D 0; i < table->num_pmus; i++) {
> > > >               ...
> > > >       }
> > > >       return NULL;
> > > >
> > > > Fix this and do not access the table variable. Instead return 0x0
> > > > which is the same return code when the for-loop was not successful.
> > > >
> > > > Output after:
> > > >  # ./perf stat -e cs -- true
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >                  0      cs
> > > >
> > > >        0.000853105 seconds time elapsed
> > > >
> > > >        0.000061000 seconds user
> > > >        0.000827000 seconds sys
> > > >
> > > >  # ./perf stat -e cpu-clock -- true
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >               0.25 msec cpu-clock #    0.341 CPUs utilized
> > > >
> > > >        0.000728383 seconds time elapsed
> > > >
> > > >        0.000055000 seconds user
> > > >        0.000706000 seconds sys
> > > >
> > > >  # ./perf stat -e cycles -- true
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >    <not supported>      cycles
> > > >
> > > >        0.000767298 seconds time elapsed
> > > >
> > > >        0.000055000 seconds user
> > > >        0.000739000 seconds sys
> > > >
> > > >  #
> > > >
> > > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > I'll add this too, ok?
> >
> > Fixes: 7c52f10c0d4d8 ("perf pmu: Cache JSON events table")
>
> Looks good, thanks!
> Ian

Applied to perf-tools, thanks!

Namhyung
