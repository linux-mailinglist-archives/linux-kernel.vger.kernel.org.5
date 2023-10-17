Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE97CBD13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjJQIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjJQIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:08:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54193;
        Tue, 17 Oct 2023 01:08:18 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H84aLv000859;
        Tue, 17 Oct 2023 08:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=QIF7c2z5SMaUpGNE5OZQpDexMR/6W7EPkEtl2ghgegk=;
 b=RS7/o0E2EFCSoBAUIJ96T/hGrG4+CwKXc/9x++q0HF71ABkd3XF/YVzBFBLF5naDxcxZ
 yHGnQ7k0C0WR7YyOYMxadusS0116x2lMJYXGLpszDHxu4krRg2R9l3YFREsQ3IJwLaVO
 C68KVjHE05dDvBYkgtBfqlXrSY7dADGgOlMLZgPu44qn5+4ws4iwATduGVqxbnVm455p
 N5urQ046yM+/6Y794O5orS0Qg97T1A/DdFC3+Nfo2yZNd/nRyeVeVWDQA4JpGWLdFCQn
 LY9uh22SXt0jekJpt9UrHBq8vbkdn7qfEC89A8hAVe+GQB+iLsHgac+CGqUCeOCDeqK2 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tspedg8v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 08:08:06 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39H84u16002302;
        Tue, 17 Oct 2023 08:07:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tspedg771-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 08:07:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39H7K9Zx012949;
        Tue, 17 Oct 2023 08:07:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py79kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 08:07:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39H873To24838762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 08:07:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA9020043;
        Tue, 17 Oct 2023 08:07:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 156032004B;
        Tue, 17 Oct 2023 08:07:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.214.47])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Oct 2023 08:07:00 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZS1Y5PhXhp384ynY@kernel.org>
Date:   Tue, 17 Oct 2023 13:36:49 +0530
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6B30B31-80DC-4EB0-A111-B92CD99DD75F@linux.vnet.ibm.com>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com> <ZS1Y5PhXhp384ynY@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ryNQzz0UKdRtBIH4P1Cd3mfN3g9GKnV
X-Proofpoint-GUID: VBlYgYdGEQE3W6GJc8pBdHnmRMIDlg-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 16-Oct-2023, at 9:08 PM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Mon, Oct 16, 2023 at 11:35:35AM +0200, Ingo Molnar escreveu:
>>=20
>>=20
>> * Namhyung Kim <namhyung@kernel.org> wrote:
>>=20
>>> + /* try cgroup v2 interface first */
>>> + if (threaded)
>>> + fd =3D openat(cgrp->fd, "cgroup.threads", O_WRONLY);
>>> + else
>>> + fd =3D openat(cgrp->fd, "cgroup.procs", O_WRONLY);
>>> +
>>> + /* try cgroup v1 if failed */
>>> + if (fd < 0)
>>> + fd =3D openat(cgrp->fd, "tasks", O_WRONLY);
>>> +
>>> + if (fd < 0) {
>>> + char mnt[PATH_MAX];
>>> +
>>> + printf("Failed to open cgroup file in %s\n", cgrp->name);
>>> +
>>> + if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") =3D=3D =
0)
>>> + printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
>>> +        mnt, cgrp->name);
>>=20
>> Ok, this works too I suppose.
>>=20
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>=20
> I'm not getting that:
>=20
> [root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> no access to cgroup /sys/fs/cgroup/AAA
> cannot open sender cgroup: AAA
> Usage: perf bench sched pipe <options>
>=20
>    -G, --cgroups <SEND,RECV>
>                          Put sender and receivers in given cgroups
> [root@five ~]#
>=20
> Its better now as it bails out, but it is not emitting any message =
that
> helps with running the test, well, there is that /sys/fs/cgroup/AAA
> path, lemme try doing a mkdir:
>=20
> [root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> no access to cgroup /sys/fs/cgroup/BBB
> cannot open receiver cgroup: BBB
> Usage: perf bench sched pipe <options>
>=20
>    -G, --cgroups <SEND,RECV>
>                          Put sender and receivers in given cgroups
> [root@five ~]#
>=20
> [root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> [root@five ~]#
>=20
> It seems to be bailing out but doesn't run the test nor emits any
> warning.

In the =E2=80=9Cparse_two_cgroups=E2=80=9D function itself it checks for =
:

cgrp_send =3D cgroup__new(p, /*do_open=3D*/true);
        if (cgrp_send =3D=3D NULL) {
                fprintf(stderr, "cannot open sender cgroup: %s", p);
                goto out;
        }

And we fail here since the cgroup is not created. May be we can add the =
Hint or warning in here ?


Thanks
Athira

>=20
> I'm using v3. I'll try to debug it a bit.
>=20
> - Arnaldo


