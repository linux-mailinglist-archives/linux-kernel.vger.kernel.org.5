Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAC7E1D15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKFJQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:16:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FFCC;
        Mon,  6 Nov 2023 01:16:49 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A69GOuL022631;
        Mon, 6 Nov 2023 09:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0/Q0Ge0wOeHrnYI00dxrJo5eTA+PZ3BAJJf6HaX7Wcg=;
 b=bbG5cgglIc2ObLAOWbYBEp4TEp3gzacdMrhS6JOVAAyHgD9j7Gp9yCiiH3lQi7thU6Pi
 5jmzKbdBHQeBQQbagutiJMyf2bxoMcnvUFkIEzmBl+bzSxpwj84utDsdWcsVA32KbD29
 swaVZUOFl1dbafq5V49nWpINDFGyU+NIlMLWSKjmuzLirKHGR+i85P5AdR12Aeld4fUM
 YsAnZNv3z/OmrGxXTkYnzpzfDfUpsy84lLDW9cLvTcD34NSTW7IPoJnZBt9FZURSuQli
 p1dvjJwSZ4pwaKTaF64E/3iY+dnMUJ7RtQlD4QSklLC/kq/th0vIkQHY3Jw5N/ISIOgj CQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6uj0kcjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:16:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A68S0Mj025671;
        Mon, 6 Nov 2023 09:16:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619n86xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:16:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A69GZRV16646790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 09:16:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFF3220040;
        Mon,  6 Nov 2023 09:16:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1EB720043;
        Mon,  6 Nov 2023 09:16:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 09:16:35 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2 PING] perf test: Adjust test case perf record offcpu profiling tests for s390
Date:   Mon,  6 Nov 2023 10:16:27 +0100
Message-Id: <20231106091627.2022530-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W1dcv77m9a-K-07oadxRDNJvgd-oxPik
X-Proofpoint-GUID: W1dcv77m9a-K-07oadxRDNJvgd-oxPik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

The 400+ context switch on s390 occur when the some receiver/sender
threads call ready() and wait for the response from function
bench_sched_messaging() being kicked off.

Lower the number of expected context switches to 400 to succeed on
s390.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index a1ef8f0d2b5c..67c925f3a15a 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -77,9 +77,9 @@ test_offcpu_child() {
     err=1
     return
   fi
-  # each process waits for read and write, so it should be more than 800 events
+  # each process waits at least for poll, so it should be more than 400 events
   if ! perf report -i ${perfdata} -s comm -q -n -t ';' --percent-limit=90 | \
-    awk -F ";" '{ if (NF > 3 && int($3) < 800) exit 1; }'
+    awk -F ";" '{ if (NF > 3 && int($3) < 400) exit 1; }'
   then
     echo "Child task off-cpu test [Failed invalid output]"
     err=1
-- 
2.41.0

