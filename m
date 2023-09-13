Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F479E857
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbjIMMw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbjIMMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438701BC9;
        Wed, 13 Sep 2023 05:52:15 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCnSN7018886;
        Wed, 13 Sep 2023 12:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=E0zARhDZbaDg3CggwhVYRBWdci5AOK6H4f5dxa6OpLk=;
 b=GeXWhSnHLh69CbaFh+9RBFn36gB60vOFRuY77+89zfgyfMB4wNjW4NNhJMKnCEPSVPnX
 CjrKDjVQ3B2jRmtuZeOWRmqGdS+TXwFQJpeel5HDFxeTbfR3wxpx2vM4lWWJ/4k2phtG
 C1pvbI0rAF/7bt607S/KArkQ+3+6/B6vSdnP2uJ6zABzTb6RgpalnwtwCvfj8Pa5Z6IB
 bKXxTsl2IbnNa1ffIraB4CoL0rJ+YP57yjMPdVmVShlparyfFXqRwIvGsSIqc6RoJmz4
 n9U0U38jtepvSFe4FnreqTUnrwX77N8c2nyK4XdRbJ4+ScQyD98ZQVH0lLq3EJTyy7z3 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3dasrcje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 12:52:12 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DCh1mc030324;
        Wed, 13 Sep 2023 12:52:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3dasrchy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 12:52:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBJgDm002410;
        Wed, 13 Sep 2023 12:52:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158karsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 12:52:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38DCq8rf40043130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 12:52:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 683212004B;
        Wed, 13 Sep 2023 12:52:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 082A220040;
        Wed, 13 Sep 2023 12:52:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Sep 2023 12:52:07 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, irogers@google.com,
        dengler@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf jevent: fix core dump on software events on s390
Date:   Wed, 13 Sep 2023 14:51:57 +0200
Message-Id: <20230913125157.2790375-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SKDvXtND-Dl8lnfG6fbqUxQe1xpIb_fQ
X-Proofpoint-ORIG-GUID: 4kgzq8EjvkxZTv_oqssvd1laGMOHsN-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_06,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running commands such as
 # ./perf stat -e cs -- true
 Segmentation fault (core dumped)
 # ./perf stat -e cpu-clock-- true
 Segmentation fault (core dumped)
 #

dump core. This should not happen as these events are defined
even when no hardware PMU is available.
Debugging this reveals this call chain:

  perf_pmus__find_by_type(type=1)
  +--> pmu_read_sysfs(core_only=false)
       +--> perf_pmu__find2(dirfd=3, name=0x152a113 "software")
            +--> perf_pmu__lookup(pmus=0x14f0568 <other_pmus>, dirfd=3,
                                  lookup_name=0x152a113 "software")
                 +--> perf_pmu__find_events_table (pmu=0x1532130)

Now the pmu is "software" and it tries to find a proper table
generated by the pmu-event generation process for s390:

 # cd pmu-events/
 # ./jevents.py  s390 all /root/linux/tools/perf/pmu-events/arch |\
        grep -E '^const struct pmu_table_entry'
 const struct pmu_table_entry pmu_events__cf_z10[] = {
 const struct pmu_table_entry pmu_events__cf_z13[] = {
 const struct pmu_table_entry pmu_metrics__cf_z13[] = {
 const struct pmu_table_entry pmu_events__cf_z14[] = {
 const struct pmu_table_entry pmu_metrics__cf_z14[] = {
 const struct pmu_table_entry pmu_events__cf_z15[] = {
 const struct pmu_table_entry pmu_metrics__cf_z15[] = {
 const struct pmu_table_entry pmu_events__cf_z16[] = {
 const struct pmu_table_entry pmu_metrics__cf_z16[] = {
 const struct pmu_table_entry pmu_events__cf_z196[] = {
 const struct pmu_table_entry pmu_events__cf_zec12[] = {
 const struct pmu_table_entry pmu_metrics__cf_zec12[] = {
 const struct pmu_table_entry pmu_events__test_soc_cpu[] = {
 const struct pmu_table_entry pmu_metrics__test_soc_cpu[] = {
 const struct pmu_table_entry pmu_events__test_soc_sys[] = {
 #

However event "software" is not listed, as can be seen in the
generated const struct pmu_events_map pmu_events_map[].
So in function perf_pmu__find_events_table(), the variable
table is initialized to NULL, but never set to a proper
value. The function scans all generated &pmu_events_map[]
tables, but no table matches, because the tables are
s390 CPU Measurement unit specific:

  i = 0;
  for (;;) {
      const struct pmu_events_map *map = &pmu_events_map[i++];
      if (!map->arch)
           break;

      --> the maps are there because the build generated them

           if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
                table = &map->event_table;
                break;
           }
      --> Since no matching CPU string the table var remains 0x0
      }
      free(cpuid);
      if (!pmu)
           return table;

      --> The pmu is "software" so it exists and no return

      --> and here perf dies because table is 0x0
      for (i = 0; i < table->num_pmus; i++) {
	      ...
      }
      return NULL;

Fix this and do not access the table variable. Instead return 0x0
which is the same return code when the for-loop was not successful.

Output after:
 # ./perf stat -e cs -- true

 Performance counter stats for 'true':

                 0      cs

       0.000853105 seconds time elapsed

       0.000061000 seconds user
       0.000827000 seconds sys

 # ./perf stat -e cpu-clock -- true

 Performance counter stats for 'true':

              0.25 msec cpu-clock #    0.341 CPUs utilized

       0.000728383 seconds time elapsed

       0.000055000 seconds user
       0.000706000 seconds sys

 # ./perf stat -e cycles -- true

 Performance counter stats for 'true':

   <not supported>      cycles

       0.000767298 seconds time elapsed

       0.000055000 seconds user
       0.000739000 seconds sys

 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index a7e88332276d..72ba4a9239c6 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -991,7 +991,7 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
                 }
         }
         free(cpuid);
-        if (!pmu)
+        if (!pmu || !table)
                 return table;
 
         for (i = 0; i < table->num_pmus; i++) {
-- 
2.41.0

