Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69107B79D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbjJDIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjJDIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:14:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEACB0;
        Wed,  4 Oct 2023 01:14:19 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3947ieTT011703;
        Wed, 4 Oct 2023 08:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6wG+CAtIPo9jgqQLO5mIdbva2aNMLf22M0rB+4CtlYk=;
 b=tH3Yrlr6pQ7/HE0aoAIRmWXqr83aGemwPVi7gxvjAZm7dMG2SeEA27NrQcVQuKWmwPoN
 5f6/vM+zmrPyWRg6mb79QfTFzXWA6OPGpeb4Ab+nJr4YZLLwAiOWusLx8yiATBcwrvAJ
 YIBllgV7VVKWaDTPEtHb+zeehL1OLxUqX0OEhbHCBSqY4dJJOnS7jLCrd94UKNhW13Nu
 Nudfq0xalzrY/AoCIySMtFpY8FwQQR4Lu5p1nhAdeaXwVwVDC33Z/grEn7qFMooH5u9T
 CdiiBXVMDyOzks9ItaLz66EQ+meqBd1LoTWA4lInHXPNBrAoVV29eOHJEECA6nNHeqRU BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th3f49fba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 08:13:45 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3947gRoV006247;
        Wed, 4 Oct 2023 08:13:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th3f49fb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 08:13:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3947GjaW025043;
        Wed, 4 Oct 2023 08:13:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcya2pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 08:13:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3948Df2618547268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 08:13:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A0F20040;
        Wed,  4 Oct 2023 08:13:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC95E2004D;
        Wed,  4 Oct 2023 08:13:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.116.168])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Oct 2023 08:13:39 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH][next] perf: fix spelling mistake "parametrized" ->
 "parameterized"
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAP-5=fXO6+Cgvo4BmC9fgL70FY+ciPjRVR5qghxYBR3VSB7WNQ@mail.gmail.com>
Date:   Wed, 4 Oct 2023 13:43:28 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-Id: <6929FC3F-06F4-45D1-96D4-0ABF86EA8698@linux.vnet.ibm.com>
References: <20231003074911.220216-1-colin.i.king@gmail.com>
 <CAP-5=fXO6+Cgvo4BmC9fgL70FY+ciPjRVR5qghxYBR3VSB7WNQ@mail.gmail.com>
To:     Ian Rogers <irogers@google.com>, colin.i.king@gmail.com
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EUb2hcIaI2GPCHb0IB-fHt_ukS24SjOc
X-Proofpoint-GUID: l5qlavOLMhoQ30ZRDfGi_hiR-yPfDrjN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310040049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 04-Oct-2023, at 6:37 AM, Ian Rogers <irogers@google.com> wrote:
>=20
> On Tue, Oct 3, 2023 at 12:49=E2=80=AFAM Colin Ian King <colin.i.king@gmai=
l.com> wrote:
>>=20
>> There are spelling mistakes in comments and a pr_debug message. Fix them.
>>=20
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>=20
> + Athira Rajeev
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@li=
nux.vnet.ibm.com>>

Thanks
Athira
>=20
> Thanks,
> Ian
>=20
>> ---
>> tools/perf/tests/parse-events.c        | 4 ++--
>> tools/perf/tests/shell/stat_all_pmu.sh | 2 +-
>> 2 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-ev=
ents.c
>> index f78be21a5999..e52f45c7c3d1 100644
>> --- a/tools/perf/tests/parse-events.c
>> +++ b/tools/perf/tests/parse-events.c
>> @@ -2549,7 +2549,7 @@ static int test__pmu_events(struct test_suite *tes=
t __maybe_unused, int subtest
>>                        if (strchr(ent->d_name, '.'))
>>                                continue;
>>=20
>> -                       /* exclude parametrized ones (name contains '?')=
 */
>> +                       /* exclude parameterized ones (name contains '?'=
) */
>>                        n =3D snprintf(pmu_event, sizeof(pmu_event), "%s%=
s", path, ent->d_name);
>>                        if (n >=3D PATH_MAX) {
>>                                pr_err("pmu event name crossed PATH_MAX(%=
d) size\n", PATH_MAX);
>> @@ -2578,7 +2578,7 @@ static int test__pmu_events(struct test_suite *tes=
t __maybe_unused, int subtest
>>                        fclose(file);
>>=20
>>                        if (is_event_parameterized =3D=3D 1) {
>> -                               pr_debug("skipping parametrized PMU even=
t: %s which contains ?\n", pmu_event);
>> +                               pr_debug("skipping parameterized PMU eve=
nt: %s which contains ?\n", pmu_event);
>>                                continue;
>>                        }
>>=20
>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/s=
hell/stat_all_pmu.sh
>> index c77955419173..d2a3506e0d19 100755
>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>> @@ -4,7 +4,7 @@
>>=20
>> set -e
>>=20
>> -# Test all PMU events; however exclude parametrized ones (name contains=
 '?')
>> +# Test all PMU events; however exclude parameterized ones (name contain=
s '?')
>> for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+=
[[:space:]]//g'); do
>>   echo "Testing $p"
>>   result=3D$(perf stat -e "$p" true 2>&1)
>> --
>> 2.39.2
>>=20

