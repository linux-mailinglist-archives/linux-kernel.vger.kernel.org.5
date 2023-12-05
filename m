Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8DD80528F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442262AbjLELYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442130AbjLELXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:23:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B08191;
        Tue,  5 Dec 2023 03:21:50 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5B7P3o025760;
        Tue, 5 Dec 2023 11:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=k3AnvZmH8JookOF1Ep2XVz5VowNTY/XJSZw/im3u2Rc=;
 b=AnMEu6Uw2+bN+ZYGGM9KY7lkmts1BwzCAOJIXHnSBGIC3ySDjmFp2+//aLHEY5TEcci1
 KF4p8jSfMEdAxa+1whq8cm2NNr93NUpmd2HesP1OLQh5qD09un4BXIJ6+Hi5ILEhAUIm
 TuwRY3nrRCzCzoi4p2ivID3Ngnq3hh2Q5NfGYS7LGB6c4FK/guHNe4kJCsce05o3UcK9
 TIXINsSPtE3pIdSlj56v8pH9BviPcs0jlKj9x+PRSbyVQ4yCibIN10G+QDZB3Oj5NQ8s
 a004hJ9/oWspShpNs/my1RR1KamYPNAsJXQtdX3F7Tg6TFoUHSN46Bs8Z2BH7E2FPwpp aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut2q50cug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 11:21:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B5B8Ydw029997;
        Tue, 5 Dec 2023 11:21:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut2q50cty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 11:21:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5AqJvx009153;
        Tue, 5 Dec 2023 11:21:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urgdkx4pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 11:21:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5BLGKC1180160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 11:21:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 559FA2004B;
        Tue,  5 Dec 2023 11:21:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C29A20040;
        Tue,  5 Dec 2023 11:21:13 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.218])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 11:21:13 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [RFC PATCH v2] perf evsel: Fallback to task-clock when not system
 wide
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231121000420.368075-1-irogers@google.com>
Date:   Tue, 5 Dec 2023 16:51:01 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Message-Id: <CFCEDA00-D3CB-450A-B9E5-AA5D7CEEA1CE@linux.vnet.ibm.com>
References: <20231121000420.368075-1-irogers@google.com>
To:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y94NZ3bwejvBGxk6-bnDNEEew4rlaNAB
X-Proofpoint-GUID: xDp52yQioe6nfnYThBJWS5jVoswwbaK3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_06,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21-Nov-2023, at 5:34=E2=80=AFAM, Ian Rogers <irogers@google.com> wrote:
>=20
> When the cycles event isn't available evsel will fallback to the
> cpu-clock software event. task-clock is similar to cpu-clock but only
> runs when the process is running. Falling back to cpu-clock when not
> system wide leads to confusion, by falling back to task-clock it is
> hoped the confusion is less.
>=20
> Pass the target to determine if task-clock is more appropriate. Update
> a nearby comment and debug string for the change.
>=20
> ---
> v2. Use target__has_cpu as suggested by Namhyung.
> https://lpc.events/event/17/contributions/1556/
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> tools/perf/builtin-record.c |  2 +-
> tools/perf/builtin-stat.c   |  2 +-
> tools/perf/builtin-top.c    |  2 +-
> tools/perf/util/evsel.c     | 18 ++++++++++--------
> tools/perf/util/evsel.h     |  3 ++-
> 5 files changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8ec818568662..d8bb59511fdd 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1350,7 +1350,7 @@ static int record__open(struct record *rec)
> evlist__for_each_entry(evlist, pos) {
> try_again:
> if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
> - if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
> + if (evsel__fallback(pos, &opts->target, errno, msg, sizeof(msg))) {

Hi Ian

Tested this with perf record and I could find the code fallback to using ta=
sk-clock

./perf record -v ls
Warning:
The cycles event is not supported, trying to fall back to task-clock

But in case of =E2=80=9Cperf stat=E2=80=9D, in my environment, found that t=
he code path won't invoke =E2=80=9Cevsel__fallback=E2=80=9D.

Snippet for builtin-stat.c
            if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
            errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
            errno =3D=3D ENXIO) {
                if (verbose > 0)
                        ui__warning("%s event is not supported by the kerne=
l.\n",
                                    evsel__name(counter));
                counter->supported =3D false;
                /*
                 * errored is a sticky flag that means one of the counter's
                 * cpu event had a problem and needs to be reexamined.
                 */
                counter->errored =3D true;

                if ((evsel__leader(counter) !=3D counter) ||
                    !(counter->core.leader->nr_members > 1))
                        return COUNTER_SKIP;
        } else if (evsel__fallback(counter, &target, errno, msg, sizeof(msg=
))) {
                if (verbose > 0)
                        ui__warning("%s\n", msg);
                return COUNTER_RETRY;

So if the perf_event_open returns ENOENT, we won=E2=80=99t do a fallback in=
 builtin-stat.c
Should we address cycles differently here ? Any comments ?

Thanks
Athira
>=20=20=20
> if (verbose > 0)
> ui__warning("%s\n", msg);
> goto try_again;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a3af805a1d57..d8e5d6f7a87a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -653,7 +653,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
> if ((evsel__leader(counter) !=3D counter) ||
>    !(counter->core.leader->nr_members > 1))
> return COUNTER_SKIP;
> - } else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
> + } else if (evsel__fallback(counter, &target, errno, msg, sizeof(msg))) {
> if (verbose > 0)
> ui__warning("%s\n", msg);
> return COUNTER_RETRY;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..1e42bd1c7d5a 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1044,7 +1044,7 @@ static int perf_top__start_counters(struct perf_top=
 *top)
>    perf_top_overwrite_fallback(top, counter))
> goto try_again;
>=20
> - if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
> + if (evsel__fallback(counter, &opts->target, errno, msg, sizeof(msg))) {
> if (verbose > 0)
> ui__warning("%s\n", msg);
> goto try_again;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a5da74e3a517..532f34d9fcb5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2853,7 +2853,8 @@ u64 evsel__intval_common(struct evsel *evsel, struc=
t perf_sample *sample, const
>=20
> #endif
>=20
> -bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msg=
size)
> +bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
> +     char *msg, size_t msgsize)
> {
> int paranoid;
>=20
> @@ -2861,18 +2862,19 @@ bool evsel__fallback(struct evsel *evsel, int err=
, char *msg, size_t msgsize)
>    evsel->core.attr.type   =3D=3D PERF_TYPE_HARDWARE &&
>    evsel->core.attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES) {
> /*
> - * If it's cycles then fall back to hrtimer based
> - * cpu-clock-tick sw counter, which is always available even if
> - * no PMU support.
> + * If it's cycles then fall back to hrtimer based cpu-clock sw
> + * counter, which is always available even if no PMU support.
> *
> * PPC returns ENXIO until 2.6.37 (behavior changed with commit
> * b0a873e).
> */
> - scnprintf(msg, msgsize, "%s",
> -"The cycles event is not supported, trying to fall back to cpu-clock-tic=
ks");
> -
> evsel->core.attr.type   =3D PERF_TYPE_SOFTWARE;
> - evsel->core.attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
> + evsel->core.attr.config =3D target__has_cpu(target)
> + ? PERF_COUNT_SW_CPU_CLOCK
> + : PERF_COUNT_SW_TASK_CLOCK;
> + scnprintf(msg, msgsize,
> + "The cycles event is not supported, trying to fall back to %s",
> + target__has_cpu(target) ? "cpu-clock" : "task-clock");
>=20
> zfree(&evsel->name);
> return true;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index f19ac9f027ef..efbb6e848287 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -460,7 +460,8 @@ static inline bool evsel__is_clock(const struct evsel=
 *evsel)
>       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
> }
>=20
> -bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msg=
size);
> +bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
> +     char *msg, size_t msgsize);
> int evsel__open_strerror(struct evsel *evsel, struct target *target,
> int err, char *msg, size_t size);
>=20
> --=20
> 2.43.0.rc1.413.gea7ed67945-goog
>=20

