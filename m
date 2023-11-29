Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44857FDCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjK2QTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjK2QTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:19:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4A213A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:17:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so65195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701274670; x=1701879470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y25gE7qRQbauuqchZstaaBAeEHIU4T0NaoXjYUJrRZA=;
        b=mYyasOpFy8QAkrn2PLQzOkpl/iuJSbL1vOx1s/OS26/3UmbsQL3I7N1hlf5ECym6Ee
         0BmiLLBACR1n+xCl8bLrDVF2CVfkpLDTZ9nKPsJ+4KKePw8U4On9aBC1yRHUthCROLii
         jZdxIRkKSVQu5yb0NqFVEhsLAMKpcAUs8yVC78HKlBRcytV4maGp7nNlThrma2PmNf6B
         QAKEkrr3a12mJadDfLKNhrjAs01RqQ7B6y3c5ixtlcGFDPGdblI178SRBLuk0V6G4Yg5
         DuG/M/S47mfQZHvaWcGyEq41Id41g1nU1bS8tkSSuih8VkF3ihA4hJwPGwgt51+PNTDf
         wkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274670; x=1701879470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y25gE7qRQbauuqchZstaaBAeEHIU4T0NaoXjYUJrRZA=;
        b=S4i/bPP4G3Z+i839JGRIivKS4pTkPac8b0R3K03OASkYpV3f+deaYh/5Ms7WctODSZ
         DdISMh5Vq40j0c55a0AwL7kGYMjn7vtASC/duXRGQ+IY9clGLm5RDRdlFyttTK6P8C8Z
         SLP18L1SnVKCXjUTqzEpcR0zQ88s7BPdBmb8BWc9WpK75afT5O94UWmLUHLx2G/cSZBq
         cfBteY9RTIE+Jgx2urHMlkk+PKuM3C571r7IQCs6jANM6VntYxYDF+fLi9oHC9xdQSNu
         zHtsNLclwn9ELOkjEaqNYxwYWdbpO24cUvzFy6+rZRHtF6KFk77CamGz8OD1KSj/wpyJ
         ZKBA==
X-Gm-Message-State: AOJu0YzrLMJhuZB/XFzSvfLqWM5klvrrqzNI5O5rWI+QxSSh6KTtEfUY
        CrMAk93HT6qnPVM5EkmzNglM9DODOXpgI7arqOY9Nw==
X-Google-Smtp-Source: AGHT+IE6Ts20gD1Fh17UCq7+Pbp+RtkGVtqiWTP7q3OE4Poo42tRXKTgYs+HJplU0rD3mD60aetjpvkIbRsItyBxD1A=
X-Received: by 2002:a05:600c:1d26:b0:40b:4221:4085 with SMTP id
 l38-20020a05600c1d2600b0040b42214085mr514618wms.1.1701274669916; Wed, 29 Nov
 2023 08:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com> <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
In-Reply-To: <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Nov 2023 08:17:38 -0800
Message-ID: <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ammy Yi <ammy.yi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:52=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-11-29 1:24 a.m., Ian Rogers wrote:
> > On Tue, Nov 28, 2023 at 12:39=E2=80=AFPM <kan.liang@linux.intel.com> wr=
ote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The below error can be triggered on a hybrid machine.
> >>
> >>  $ perf mem record -t load sleep 1
> >>  event syntax error: 'breakpoint/mem-loads,ldlat=3D30/P'
> >>                                 \___ Bad event or PMU
> >>
> >>  Unable to find PMU or event on a PMU of 'breakpoint'
> >>
> >> In the perf_mem_events__record_args(), the current perf never checks t=
he
> >> availability of a mem event on a given PMU. All the PMUs will be added
> >> to the perf mem event list. Perf errors out for the unsupported PMU.
> >>
> >> Extend perf_mem_event__supported() and take a PMU into account. Check
> >> the mem event for each PMU before adding it to the perf mem event list=
.
> >>
> >> Optimize the perf_mem_events__init() a little bit. The function is to
> >> check whether the mem events are supported in the system. It doesn't
> >> need to scan all PMUs. Just return with the first supported PMU is goo=
d
> >> enough.
> >>
> >> Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core one=
s")
> >> Reported-by: Ammy Yi <ammy.yi@intel.com>
> >> Tested-by: Ammy Yi <ammy.yi@intel.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
> >>  1 file changed, 14 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events=
.c
> >> index 954b235e12e5..3a2e3687878c 100644
> >> --- a/tools/perf/util/mem-events.c
> >> +++ b/tools/perf/util/mem-events.c
> >> @@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
> >>         return -1;
> >>  }
> >>
> >> -static bool perf_mem_event__supported(const char *mnt, char *sysfs_na=
me)
> >> +static bool perf_mem_event__supported(const char *mnt, struct perf_pm=
u *pmu,
> >> +                                     struct perf_mem_event *e)
> >>  {
> >> +       char sysfs_name[100];
> >>         char path[PATH_MAX];
> >>         struct stat st;
> >>
> >> +       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->=
name);
> >
> > Not sure if this is right. Looking at sysfs_name values:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/mem-events.c?h=3Dperf-tools-next#n23
> > "cpu/events/mem-loads" and "cpu/events/mem-stores", so won't pmu->name
> > never be used?
> > Is there a missed change to change the cpu to %s?
>
> There is a X86 specific perf_mem_events__ptr(), which uses the
> "%s/mem-loads,ldlat=3D%u/P" and "%s/events/mem-loads" for Intel platforms=
.
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/arch/x86/util/mem-events.c?h=3Dperf-tools-next#n20
> The pmu->name is used especially for the hybrid platforms.

Right, that seems wrong. For one thing we're losing the compiler's
format string argument checking, but hardcoding PMU names just seems
to be something that will keep needing maintenance. This patch set
looks to fix an Intel issue but in general it is increasing tech debt
(or at least churning it) that will need cleaning up to do something
with better error checking and more generic. perf_mem_event looks like
a bad abstraction and then there are the integers whose special values
hold meaning. Could this fix come with some cleanup? It wouldn't seem
wrong to me to add notions of memory events to the PMU abstraction. As
it stands this scnprintf looks wrong in non-Intel cases.

Thanks,
Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >>         scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> >>         return !stat(path, &st);
> >>  }
> >> @@ -120,7 +123,6 @@ int perf_mem_events__init(void)
> >>
> >>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> >>                 struct perf_mem_event *e =3D perf_mem_events__ptr(j);
> >> -               char sysfs_name[100];
> >>                 struct perf_pmu *pmu =3D NULL;
> >>
> >>                 /*
> >> @@ -136,12 +138,12 @@ int perf_mem_events__init(void)
> >>                  * of core PMU.
> >>                  */
> >>                 while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >> -                       scnprintf(sysfs_name, sizeof(sysfs_name), e->s=
ysfs_name, pmu->name);
> >> -                       e->supported |=3D perf_mem_event__supported(mn=
t, sysfs_name);
> >> +                       e->supported |=3D perf_mem_event__supported(mn=
t, pmu, e);
> >> +                       if (e->supported) {
> >> +                               found =3D true;
> >> +                               break;
> >> +                       }
> >>                 }
> >> -
> >> -               if (e->supported)
> >> -                       found =3D true;
> >>         }
> >>
> >>         return found ? 0 : -ENOENT;
> >> @@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport_hyb=
rid(struct perf_mem_event *e,
> >>                                                     int idx)
> >>  {
> >>         const char *mnt =3D sysfs__mount();
> >> -       char sysfs_name[100];
> >>         struct perf_pmu *pmu =3D NULL;
> >>
> >>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >> -               scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_nam=
e,
> >> -                         pmu->name);
> >> -               if (!perf_mem_event__supported(mnt, sysfs_name)) {
> >> +               if (!perf_mem_event__supported(mnt, pmu, e)) {
> >>                         pr_err("failed: event '%s' not supported\n",
> >>                                perf_mem_events__name(idx, pmu->name));
> >>                 }
> >> @@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_hybri=
d(struct perf_mem_event *e,
> >>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> >>                                  char **rec_tmp, int *tmp_nr)
> >>  {
> >> +       const char *mnt =3D sysfs__mount();
> >>         int i =3D *argv_nr, k =3D 0;
> >>         struct perf_mem_event *e;
> >>
> >> @@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **rec_=
argv, int *argv_nr,
> >>                         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NUL=
L) {
> >>                                 const char *s =3D perf_mem_events__nam=
e(j, pmu->name);
> >>
> >> +                               if (!perf_mem_event__supported(mnt, pm=
u, e))
> >> +                                       continue;
> >> +
> >>                                 rec_argv[i++] =3D "-e";
> >>                                 if (s) {
> >>                                         char *copy =3D strdup(s);
> >> --
> >> 2.35.1
> >>
