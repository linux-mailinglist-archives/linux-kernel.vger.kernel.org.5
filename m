Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A247DB9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjJ3Mez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Mey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:34:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6BB9C;
        Mon, 30 Oct 2023 05:34:51 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UCW9JR005780;
        Mon, 30 Oct 2023 12:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CJ9Sm+9ucm9IkyAPlsmr2psZhZpVK51rKnzFI3R4NpA=;
 b=k0SOxiNOkdhNEVbWW95O8xBTnh2SRK1tc1d5ztbjGmvuAMtIYuYMRABalUHxQfcqDQsw
 y+8KgCbJW9sNd3/2OaB0TQyg6wS9DyroAXqvsnfZunBVTKeJrcIs4QCUfsOyofkW5AsN
 tv33tLcQdrUYirrPll11E0JI8zNW6IIFooAwJSWom8G+b+2NzyklXdAyelV1kkkI1X5H
 AEcB9ch9q2wAcU+6hR9Avur3KMMnnsUMVGwKd+RQbIiO5bm7L/sv6xtyBpT+IyWNk4mK
 Dv5sWK9SgD3ucYf1eAGcxYhivettZ2Bix1xFxEu7X3nLsbKEch584K1zya/EQTBKbWJ0 4A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ck18223-23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 12:34:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UBQAqQ020321;
        Mon, 30 Oct 2023 12:28:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0y94se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 12:28:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UCSdE112583516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 12:28:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 657C420043;
        Mon, 30 Oct 2023 12:28:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BBDA20040;
        Mon, 30 Oct 2023 12:28:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 12:28:39 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, iii@linux.ibm.com, namhyung@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Adjust test case perf record offcpu profiling tests for s390
Date:   Mon, 30 Oct 2023 13:28:29 +0100
Message-Id: <20231030122829.17741-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OH8MuM4IriNcxBn2xprRwo4HFe1Zc9Tt
X-Proofpoint-GUID: OH8MuM4IriNcxBn2xprRwo4HFe1Zc9Tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 using linux-next the test case
    87: perf record offcpu profiling tests
fails. The root cause is this command

 # ./perf  record --off-cpu -e dummy -- ./perf bench sched messaging -l 10
 # Running 'sched/messaging' benchmark:
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.231 [sec]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.077 MB perf.data (401 samples) ]
 #

It does not generate 800+ sample entries, on s390 usually around 40[1-9],
sometimes a few more, but never more than 450. The higher the number
of CPUs the lower the number of samples.

Looking at function chain
  bench_sched_messaging()
  +--> group()
the senders and receiver threads are created. The senders and receivers
call function ready() which writes one bytes and wait for a reply using
poll system() call.

As context switches are counted, the function ready() will trigger
a context switch when no input data is available after the write
system call. The write system call does not trigger context switches
when the data size is small. And writing 1000 bytes (10 iterations with
100 bytes) is not much and certainly won't block.

Each process waits for poll, so it should be more than 400 events.
Note that read and write will not necessarily result in waits,
in particular in a situation where the writers run first.

Lower the number of expected context switches to 400 to succeed on
s390.

Output before:
 # ./perf test offcpu
 86: perf record offcpu profiling tests        : FAILED!
 #

Output after:
 # ./perf test offcpu
 86: perf record offcpu profiling tests        : Ok
 #

Fixes: 831d06c8d1b3 ("perf test: Add a basic offcpu profiling test")
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index a1ef8f0d2b5c..565e40a881d6 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -79,7 +79,7 @@ test_offcpu_child() {
   fi
   # each process waits for read and write, so it should be more than 800 events
   if ! perf report -i ${perfdata} -s comm -q -n -t ';' --percent-limit=90 | \
-    awk -F ";" '{ if (NF > 3 && int($3) < 800) exit 1; }'
+    awk -F ";" '{ if (NF > 3 && int($3) < 400) exit 1; }'
   then
     echo "Child task off-cpu test [Failed invalid output]"
     err=1
-- 
2.41.0

