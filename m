Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A07A44B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbjIRI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbjIRI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:29:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32AA99;
        Mon, 18 Sep 2023 01:28:59 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38I86P6P025592;
        Mon, 18 Sep 2023 08:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UL1+8gmPxouyw6k8cAgdpAHbmNWJPGN1+BZ4gjPiZpA=;
 b=sYLMg5JHs5EFXgqekGUxybwRBYFQPi8Fh0sR/wAcGKzqmSjmAP9rKyyrIoZlSd/8asX5
 U0nHCwi8Z9oSoOPQVLoOWyuIG1gpqMa6QF8j83SuDHvxgWJeqcOZcenyd6VAMXwMI7rk
 8pD3zSA+lSAHzB3Di0ZT2ZYAPTd/rwFJtUuGH1E901ju6D+WZ7NPe/dPeYlleB581X3p
 bPQdqWjpuGbgG+mA/z1qrKcCgMWf3PuPhWPPBOwj92C8VMBQ6DTQbTUTQcXjAZRpQ8Ku
 8eHl3vQVBYWg7YrEAslSeecLAPfKT0R81RWdS0jD3ePDEcseDgPT9E1tJ/6KL6srtCHy ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6h6dj4s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 08:28:51 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38I86ct1027355;
        Mon, 18 Sep 2023 08:28:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6h6dj4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 08:28:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38I6vJIM016841;
        Mon, 18 Sep 2023 08:28:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1ggjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 08:28:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38I8SkWK28508768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 08:28:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 753D020049;
        Mon, 18 Sep 2023 08:28:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F348520040;
        Mon, 18 Sep 2023 08:28:45 +0000 (GMT)
Received: from [9.171.25.42] (unknown [9.171.25.42])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 08:28:45 +0000 (GMT)
Message-ID: <521bbe73-ba4d-7f2f-fce5-3799ef78e603@linux.ibm.com>
Date:   Mon, 18 Sep 2023 10:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] perf jevent: fix core dump on software events on s390
To:     Namhyung Kim <namhyung@gmail.com>, Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, dengler@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
References: <20230913125157.2790375-1-tmricht@linux.ibm.com>
 <CAP-5=fUiHMRPVYhbQv-YM+EMKyBF6TEopea=PPX2thbtdmhGsg@mail.gmail.com>
 <CAM9d7cgbMZzJea_TJJ46AEhLentykmy8r6twC8bkkgXTNAMqgw@mail.gmail.com>
Content-Language: en-US
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAM9d7cgbMZzJea_TJJ46AEhLentykmy8r6twC8bkkgXTNAMqgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B5dGEdPcC1PCOts2svazHlwe83enfxYZ
X-Proofpoint-GUID: 7g4Q99XSlOHi5VLNVqxxtzlTAt6wSrsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_01,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180070
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/23 01:40, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Sep 14, 2023 at 6:14 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Wed, Sep 13, 2023 at 5:52 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> Running commands such as
>>>  # ./perf stat -e cs -- true
>>>  Segmentation fault (core dumped)
>>>  # ./perf stat -e cpu-clock-- true
>>>  Segmentation fault (core dumped)
>>>  #
>>>
>>> dump core. This should not happen as these events are defined
>>> even when no hardware PMU is available.
>>> Debugging this reveals this call chain:
>>>
>>>   perf_pmus__find_by_type(type=1)
>>>   +--> pmu_read_sysfs(core_only=false)
>>>        +--> perf_pmu__find2(dirfd=3, name=0x152a113 "software")
>>>             +--> perf_pmu__lookup(pmus=0x14f0568 <other_pmus>, dirfd=3,
>>>                                   lookup_name=0x152a113 "software")
>>>                  +--> perf_pmu__find_events_table (pmu=0x1532130)
>>>
>>> Now the pmu is "software" and it tries to find a proper table
>>> generated by the pmu-event generation process for s390:
>>>
>>>  # cd pmu-events/
>>>  # ./jevents.py  s390 all /root/linux/tools/perf/pmu-events/arch |\
>>>         grep -E '^const struct pmu_table_entry'
>>>  const struct pmu_table_entry pmu_events__cf_z10[] = {
>>>  const struct pmu_table_entry pmu_events__cf_z13[] = {
>>>  const struct pmu_table_entry pmu_metrics__cf_z13[] = {
>>>  const struct pmu_table_entry pmu_events__cf_z14[] = {
>>>  const struct pmu_table_entry pmu_metrics__cf_z14[] = {
>>>  const struct pmu_table_entry pmu_events__cf_z15[] = {
>>>  const struct pmu_table_entry pmu_metrics__cf_z15[] = {
>>>  const struct pmu_table_entry pmu_events__cf_z16[] = {
>>>  const struct pmu_table_entry pmu_metrics__cf_z16[] = {
>>>  const struct pmu_table_entry pmu_events__cf_z196[] = {
>>>  const struct pmu_table_entry pmu_events__cf_zec12[] = {
>>>  const struct pmu_table_entry pmu_metrics__cf_zec12[] = {
>>>  const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
>>>  const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
>>>  const struct pmu_table_entry pmu_events__test_soc_sys[] = {
>>>  #
>>>
>>> However event "software" is not listed, as can be seen in the
>>> generated const struct pmu_events_map pmu_events_map[].
>>> So in function perf_pmu__find_events_table(), the variable
>>> table is initialized to NULL, but never set to a proper
>>> value. The function scans all generated &pmu_events_map[]
>>> tables, but no table matches, because the tables are
>>> s390 CPU Measurement unit specific:
>>>
>>>   i = 0;
>>>   for (;;) {
>>>       const struct pmu_events_map *map = &pmu_events_map[i++];
>>>       if (!map->arch)
>>>            break;
>>>
>>>       --> the maps are there because the build generated them
>>>
>>>            if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
>>>                 table = &map->event_table;
>>>                 break;
>>>            }
>>>       --> Since no matching CPU string the table var remains 0x0
>>>       }
>>>       free(cpuid);
>>>       if (!pmu)
>>>            return table;
>>>
>>>       --> The pmu is "software" so it exists and no return
>>>
>>>       --> and here perf dies because table is 0x0
>>>       for (i = 0; i < table->num_pmus; i++) {
>>>               ...
>>>       }
>>>       return NULL;
>>>
>>> Fix this and do not access the table variable. Instead return 0x0
>>> which is the same return code when the for-loop was not successful.
>>>
>>> Output after:
>>>  # ./perf stat -e cs -- true
>>>
>>>  Performance counter stats for 'true':
>>>
>>>                  0      cs
>>>
>>>        0.000853105 seconds time elapsed
>>>
>>>        0.000061000 seconds user
>>>        0.000827000 seconds sys
>>>
>>>  # ./perf stat -e cpu-clock -- true
>>>
>>>  Performance counter stats for 'true':
>>>
>>>               0.25 msec cpu-clock #    0.341 CPUs utilized
>>>
>>>        0.000728383 seconds time elapsed
>>>
>>>        0.000055000 seconds user
>>>        0.000706000 seconds sys
>>>
>>>  # ./perf stat -e cycles -- true
>>>
>>>  Performance counter stats for 'true':
>>>
>>>    <not supported>      cycles
>>>
>>>        0.000767298 seconds time elapsed
>>>
>>>        0.000055000 seconds user
>>>        0.000739000 seconds sys
>>>
>>>  #
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>
>> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> I'll add this too, ok?
> 
> Fixes: 7c52f10c0d4d8 ("perf pmu: Cache JSON events table")
> 
> Thanks,
> Namhyung

Yep fine with me.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

