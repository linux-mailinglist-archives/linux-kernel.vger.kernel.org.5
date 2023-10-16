Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0EA7CB14B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjJPR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjJPR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:26:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45BA1;
        Mon, 16 Oct 2023 10:26:53 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GHOpeB021184;
        Mon, 16 Oct 2023 17:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=o+Kw7AkFBUqu4G87+p/cOB0TKj3ONszE/dyGQkGlzzY=;
 b=tulW20O4KeUMIchPGNgxHvRAVT8ME0/zTopfCCyLVFwh6GAKFYoT29iDWIDmTXmOTfoN
 SrzMy9GrnQpYkhp6fGygLkSbYrC9OIoXO6GmIDl80YqqnoAKtACAj4uYVUcr9QuKUcdJ
 40SAD3+j5c5qj0V4cw30lvDFMKfeVvGO7/mYMNLulR1DtYYXdOyWb7mf5/roVeux900n
 iTCIMirzaQvZWW8wcrtgD+SqnS6CBEUcvczQ3YZeSICVuI7vcyVGmdWnCU14U4aaohhu
 miclL7PemjGghOfjqqzEHQqN5sgvvzfVezbzf7gXsOS5OnJ2ajg4uYUZuL9CYdLr5W4z jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts9j506f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 17:26:43 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GHOssd021393;
        Mon, 16 Oct 2023 17:26:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts9j504eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 17:26:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39GFWkws020105;
        Mon, 16 Oct 2023 17:25:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6amtcar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 17:25:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39GHParY19595892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 17:25:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F79F20049;
        Mon, 16 Oct 2023 17:25:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2EE820040;
        Mon, 16 Oct 2023 17:25:34 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.114.201])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Oct 2023 17:25:34 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231016044225.1125674-1-namhyung@kernel.org>
Date:   Mon, 16 Oct 2023 22:55:22 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB151D91-2EC1-442F-BC48-40B9CEF3D660@linux.vnet.ibm.com>
References: <20231016044225.1125674-1-namhyung@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bpPIbSAjXmCWT5W0GLZ8TZF1Zw5HV2QN
X-Proofpoint-GUID: hp-gTe_rwGwLniVpR7WYiJSUWGlkIPdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 16-Oct-2023, at 10:12 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> The -G/--cgroups option is to put sender and receiver in different
> cgroups in order to measure cgroup context switch overheads.
>=20
> Users need to make sure the cgroups exist and accessible.
>=20
>  # perf stat -e context-switches,cgroup-switches \
>> taskset -c 0 perf bench sched pipe -l 10000 > /dev/null
>=20
>   Performance counter stats for 'taskset -c 0 perf bench sched pipe -l =
10000':
>=20
>              20,001      context-switches
>                   2      cgroup-switches
>=20
>         0.053449651 seconds time elapsed
>=20
>         0.011286000 seconds user
>         0.041869000 seconds sys
>=20
>  # perf stat -e context-switches,cgroup-switches \
>> taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
>=20
>   Performance counter stats for 'taskset -c 0 perf bench sched pipe -l =
10000 -G AAA,BBB':
>=20
>              20,001      context-switches
>              20,001      cgroup-switches
>=20
>         0.052768627 seconds time elapsed
>=20
>         0.006284000 seconds user
>         0.046266000 seconds sys
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Hi Namhyung,

I tried V3 on top of perf-tools-next=20

# ./perf stat -e context-switches,cgroup-switches taskset -c 0 perf =
bench sched pipe -l 10000 -G AAA,BBB > /dev/null
no access to cgroup /sys/fs/cgroup/perf_event/AAA
cannot open sender cgroup: AAA
 Usage: perf bench sched pipe <options>

    -G, --cgroups <SEND,RECV>
                          Put sender and receivers in given cgroups

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l =
10000 -G AAA,BBB':

                 2      context-switches                                 =
                    =20
                 0      cgroup-switches                                  =
                    =20

       0.007291460 seconds time elapsed

       0.007438000 seconds user
       0.000000000 seconds sys


I created AAA and BBB
mkdir /sys/fs/cgroup/perf_event/AAA
mkdir /sys/fs/cgroup/perf_event/BBB

Got the results below:

./perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench =
sched pipe -l 10000 -G AAA,BBB > /dev/null

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l =
10000 -G AAA,BBB':

             20002      context-switches                                 =
                    =20
             19999      cgroup-switches                                  =
                    =20

       0.120063986 seconds time elapsed

       0.001716000 seconds user
       0.065995000 seconds sys


Thanks
Athira


> ---
> tools/perf/Documentation/perf-bench.txt |  19 ++++
> tools/perf/bench/sched-pipe.c           | 118 +++++++++++++++++++++++-
> 2 files changed, 134 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf-bench.txt =
b/tools/perf/Documentation/perf-bench.txt
> index ca5789625cd2..8331bd28b10e 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -124,6 +124,14 @@ Options of *pipe*
> --loop=3D::
> Specify number of loops.
>=20
> +-G::
> +--cgroups=3D::
> +Names of cgroups for sender and receiver, separated by a comma.
> +This is useful to check cgroup context switching overhead.
> +Note that perf doesn't create nor delete the cgroups, so users should
> +make sure that the cgroups exist and are accessible before use.
> +
> +
> Example of *pipe*
> ^^^^^^^^^^^^^^^^^
>=20
> @@ -141,6 +149,17 @@ Example of *pipe*
>         Total time:0.016 sec
>                 16.948000 usecs/op
>                 59004 ops/sec
> +
> +% perf bench sched pipe -G AAA,BBB
> +(executing 1000000 pipe operations between cgroups)
> +# Running 'sched/pipe' benchmark:
> +# Executed 1000000 pipe operations between two processes
> +
> +     Total time: 6.886 [sec]
> +
> +       6.886208 usecs/op
> +         145217 ops/sec
> +
> ---------------------
>=20
> SUITES FOR 'syscall'
> diff --git a/tools/perf/bench/sched-pipe.c =
b/tools/perf/bench/sched-pipe.c
> index a960e7a93aec..88d20a34adb2 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -10,7 +10,9 @@
>  * Ported to perf by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
>  */
> #include <subcmd/parse-options.h>
> +#include <api/fs/fs.h>
> #include "bench.h"
> +#include "util/cgroup.h"
>=20
> #include <unistd.h>
> #include <stdio.h>
> @@ -19,6 +21,7 @@
> #include <sys/wait.h>
> #include <string.h>
> #include <errno.h>
> +#include <fcntl.h>
> #include <assert.h>
> #include <sys/time.h>
> #include <sys/types.h>
> @@ -31,6 +34,7 @@ struct thread_data {
> int nr;
> int pipe_read;
> int pipe_write;
> + bool cgroup_failed;
> pthread_t pthread;
> };
>=20
> @@ -40,9 +44,55 @@ static int loops =3D LOOPS_DEFAULT;
> /* Use processes by default: */
> static bool threaded;
>=20
> +static struct cgroup *cgrp_send =3D NULL;
> +static struct cgroup *cgrp_recv =3D NULL;
> +
> +static int parse_two_cgroups(const struct option *opt __maybe_unused,
> +     const char *str, int unset __maybe_unused)
> +{
> + char *p =3D strdup(str);
> + char *q;
> + int ret =3D -1;
> +
> + if (p =3D=3D NULL) {
> + fprintf(stderr, "memory allocation failure");
> + return -1;
> + }
> +
> + q =3D strchr(p, ',');
> + if (q =3D=3D NULL) {
> + fprintf(stderr, "it should have two cgroup names: %s", p);
> + goto out;
> + }
> + *q =3D '\0';
> +
> + cgrp_send =3D cgroup__new(p, /*do_open=3D*/true);
> + if (cgrp_send =3D=3D NULL) {
> + fprintf(stderr, "cannot open sender cgroup: %s", p);
> + goto out;
> + }
> +
> + /* skip ',' */
> + q++;
> +
> + cgrp_recv =3D cgroup__new(q, /*do_open=3D*/true);
> + if (cgrp_recv =3D=3D NULL) {
> + fprintf(stderr, "cannot open receiver cgroup: %s", q);
> + goto out;
> + }
> + ret =3D 0;
> +
> +out:
> + free(p);
> + return ret;
> +}
> +
> static const struct option options[] =3D {
> OPT_INTEGER('l', "loop", &loops, "Specify number of loops"),
> OPT_BOOLEAN('T', "threaded", &threaded, "Specify threads/process based =
task setup"),
> + OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
> +     "Put sender and receivers in given cgroups",
> +     parse_two_cgroups),
> OPT_END()
> };
>=20
> @@ -51,12 +101,71 @@ static const char * const =
bench_sched_pipe_usage[] =3D {
> NULL
> };
>=20
> +static int enter_cgroup(struct cgroup *cgrp)
> +{
> + char buf[32];
> + int fd, len, ret;
> + pid_t pid;
> +
> + if (cgrp =3D=3D NULL)
> + return 0;
> +
> + if (threaded)
> + pid =3D syscall(__NR_gettid);
> + else
> + pid =3D getpid();
> +
> + snprintf(buf, sizeof(buf), "%d\n", pid);
> + len =3D strlen(buf);
> +
> + /* try cgroup v2 interface first */
> + if (threaded)
> + fd =3D openat(cgrp->fd, "cgroup.threads", O_WRONLY);
> + else
> + fd =3D openat(cgrp->fd, "cgroup.procs", O_WRONLY);
> +
> + /* try cgroup v1 if failed */
> + if (fd < 0)
> + fd =3D openat(cgrp->fd, "tasks", O_WRONLY);
> +
> + if (fd < 0) {
> + char mnt[PATH_MAX];
> +
> + printf("Failed to open cgroup file in %s\n", cgrp->name);
> +
> + if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") =3D=3D =
0)
> + printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
> +       mnt, cgrp->name);
> + return -1;
> + }
> +
> + ret =3D write(fd, buf, len);
> + close(fd);
> +
> + if (ret !=3D len) {
> + printf("Cannot enter to cgroup: %s\n", cgrp->name);
> + return -1;
> + }
> + return 0;
> +}
> +
> static void *worker_thread(void *__tdata)
> {
> struct thread_data *td =3D __tdata;
> int m =3D 0, i;
> int ret;
>=20
> + if (td->nr)
> + ret =3D enter_cgroup(cgrp_send);
> + else
> + ret =3D enter_cgroup(cgrp_recv);
> +
> + if (ret < 0) {
> + td->cgroup_failed =3D true;
> + return NULL;
> + }
> + td->cgroup_failed =3D false;
> +
> for (i =3D 0; i < loops; i++) {
> if (!td->nr) {
> ret =3D read(td->pipe_read, &m, sizeof(int));
> @@ -112,9 +221,7 @@ int bench_sched_pipe(int argc, const char **argv)
> }
> }
>=20
> -
> if (threaded) {
> -
> for (t =3D 0; t < nr_threads; t++) {
> td =3D threads + t;
>=20
> @@ -128,7 +235,6 @@ int bench_sched_pipe(int argc, const char **argv)
> ret =3D pthread_join(td->pthread, NULL);
> BUG_ON(ret);
> }
> -
> } else {
> pid =3D fork();
> assert(pid >=3D 0);
> @@ -147,6 +253,12 @@ int bench_sched_pipe(int argc, const char **argv)
> gettimeofday(&stop, NULL);
> timersub(&stop, &start, &diff);
>=20
> + cgroup__put(cgrp_send);
> + cgroup__put(cgrp_recv);
> +
> + if (threads[0].cgroup_failed || threads[1].cgroup_failed)
> + return 0;
> +
> switch (bench_format) {
> case BENCH_FORMAT_DEFAULT:
> printf("# Executed %d pipe operations between two %s\n\n",
> --=20
> 2.42.0.655.g421f12c284-goog
>=20

