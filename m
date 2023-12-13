Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA3810E11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjLMJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjLMJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:52:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E083;
        Wed, 13 Dec 2023 01:52:40 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7h5SR015245;
        Wed, 13 Dec 2023 09:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0pyNFVC6WcNT2p2h6XzxKodMSyrGQykAB7x097ed/aE=;
 b=Wlbb+iohROWx+HuQgvHBUwCz6Zl2/ax7aaR+jnqWHPLXfKqWl00HiJichhcWJO8Af4i9
 +48DtUu2Pif8URzrAW4qoFq29qrwYeBxerZmuT4z/fFLn3q19PrIJgJOSbGWCdiDcmcx
 vivY9P1sjeBzBQ2KM/rOOo6XGGcdXxTEHHXEjFqIXnBIFg8jqBgpNHXC4P7uBOIbomFc
 OknLfJyKkI8EtqgVC/DHT+lskGqGG1Uk56/766+CIGB1WLdjA0FAKd16vLnmrl8Bc5zC
 wGFc63edqkv/RUBbWu3xSopFr86VnTzqNBI327dVI/mj/B0KLQiIb7mlr9XjTxU7TrD+ PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy8f8bmmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 09:52:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD8kLkQ010855;
        Wed, 13 Dec 2023 09:52:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy8f8bmkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 09:52:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD92Kle028248;
        Wed, 13 Dec 2023 09:52:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xyqyeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 09:52:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BD9qBDV13501046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 09:52:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4262E2004D;
        Wed, 13 Dec 2023 09:52:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314E720040;
        Wed, 13 Dec 2023 09:52:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.218])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Dec 2023 09:52:08 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH V2 0/5] Clean up perf mem
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZXIrtcYkvpA8Uwj1@kernel.org>
Date:   Wed, 13 Dec 2023 15:21:56 +0530
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        john.g.garry@oracle.com, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>, yuhaixin.yhx@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Message-Id: <DC029166-B60F-4E90-833D-F43818A3C54B@linux.vnet.ibm.com>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <ZXIrtcYkvpA8Uwj1@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xpxXoDffwPPHUhMBRFQsaBP1J-1Nki4W
X-Proofpoint-ORIG-GUID: TQZQL8IMVmt3wO2plg2NGOajuTE47EVS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_02,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 08-Dec-2023, at 2:01=E2=80=AFAM, Arnaldo Carvalho de Melo <acme@kernel=
.org> wrote:
>=20
> Em Thu, Dec 07, 2023 at 11:23:33AM -0800, kan.liang@linux.intel.com escre=
veu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>=20
>> Changes since V1:
>> - Fix strcmp of PMU name checking (Ravi)
>> - Fix "/," typo (Ian)
>> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
>> - Fold the header removal patch into the patch where the cleanups made.
>>  (Arnaldo)
>> - Add reviewed-by and tested-by from Ian and Ravi
>=20
> It would be good to have a Tested-by from people working in all the
> architectures affectes, like we got from Ravi for AMD, can we get those?
>=20
> I'm applying it locally for test building, will push to
> perf-tools-next/tmp.perf-tools-next for a while, so there is some time
> to test.
>=20
> ARM64 (Leo?) and ppc, for PPC... humm Ravi did it, who could test it now?
Hi Arnaldo, Ravi

Looking into this for testing on powerpc. Will update back.

Thanks
Athira
>=20
> - Arnaldo
>=20
>> As discussed in the below thread, the patch set is to clean up perf mem.
>> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.=
intel.com/
>>=20
>> Introduce generic functions perf_mem_events__ptr(),
>> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
>> ARCH specific ones.
>> Simplify the perf_mem_event__supported().
>>=20
>> Only keeps the ARCH-specific perf_mem_events array in the corresponding
>> mem-events.c for each ARCH.
>>=20
>> There is no functional change.
>>=20
>> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
>> etc. But I can only test it on two Intel platforms.
>> Please give it try, if you have machines with other ARCHs.
>>=20
>> Here are the test results:
>> Intel hybrid machine:
>>=20
>> $perf mem record -e list
>> ldlat-loads  : available
>> ldlat-stores : available
>>=20
>> $perf mem record -e ldlat-loads -v --ldlat 50
>> calling: record -e cpu_atom/mem-loads,ldlat=3D50/P -e cpu_core/mem-loads=
,ldlat=3D50/P
>>=20
>> $perf mem record -v
>> calling: record -e cpu_atom/mem-loads,ldlat=3D30/P -e cpu_atom/mem-store=
s/P -e cpu_core/mem-loads,ldlat=3D30/P -e cpu_core/mem-stores/P
>>=20
>> $perf mem record -t store -v
>> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
>>=20
>>=20
>> Intel SPR:
>> $perf mem record -e list
>> ldlat-loads  : available
>> ldlat-stores : available
>>=20
>> $perf mem record -e ldlat-loads -v --ldlat 50
>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D50/}:P
>>=20
>> $perf mem record -v
>> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D30/}:P -e c=
pu/mem-stores/P
>>=20
>> $perf mem record -t store -v
>> calling: record -e cpu/mem-stores/P
>>=20
>> Kan Liang (5):
>>  perf mem: Add mem_events into the supported perf_pmu
>>  perf mem: Clean up perf_mem_events__ptr()
>>  perf mem: Clean up perf_mem_events__name()
>>  perf mem: Clean up perf_mem_event__supported()
>>  perf mem: Clean up is_mem_loads_aux_event()
>>=20
>> tools/perf/arch/arm64/util/mem-events.c   |  36 +----
>> tools/perf/arch/arm64/util/pmu.c          |   6 +
>> tools/perf/arch/powerpc/util/mem-events.c |  13 +-
>> tools/perf/arch/powerpc/util/mem-events.h |   7 +
>> tools/perf/arch/powerpc/util/pmu.c        |  11 ++
>> tools/perf/arch/s390/util/pmu.c           |   3 +
>> tools/perf/arch/x86/util/mem-events.c     |  99 ++----------
>> tools/perf/arch/x86/util/pmu.c            |  11 ++
>> tools/perf/builtin-c2c.c                  |  28 +++-
>> tools/perf/builtin-mem.c                  |  28 +++-
>> tools/perf/util/mem-events.c              | 181 +++++++++++++---------
>> tools/perf/util/mem-events.h              |  15 +-
>> tools/perf/util/pmu.c                     |   4 +-
>> tools/perf/util/pmu.h                     |   7 +
>> 14 files changed, 233 insertions(+), 216 deletions(-)
>> create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>> create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>>=20
>> --=20
>> 2.35.1
>>=20
>=20
> --=20
>=20
> - Arnaldo


