Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605287F7E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjKXSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:32:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E81FC9;
        Fri, 24 Nov 2023 10:32:55 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOI37Ou022263;
        Fri, 24 Nov 2023 18:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=ACDVC3s4ekodUb5H2n3lUAfe5hP46nio9gVyBK2cy6A=;
 b=p7O48oLwjSJHlUoLI885ugUdp3xcVlofrYiOpGNwSHfwHwJqOpqGcQDcmec5W8qq8GEY
 czNZVAJF58S0M2AjLG9WyvoC6kzONKLQi2Zh/YLa5Dzle5pNHveVe6aSH1bxpkeTCLaY
 B7Z9CWRSD7LAtUSZt86Ygj2u7Y6uvnHSn7VG0znZTS80+W9eQH24O6aO1qz0s+FZHQb4
 ZuWBYpqPyIYf/mMY2gLn+U5+sKWByTTj5vGGp7d/tEUNF6+oIsE9XbFeZV6nwW1FsEth
 tsF33KnqgthtM0cREs23jcHdv4+p76nBPeK45fNlQ4aNQvEX6kL9j1QoYnaZOhtiVTdT yA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uk0s08m9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 18:32:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOF9VHN027825;
        Fri, 24 Nov 2023 17:32:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ktqdbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 17:32:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AOHWJjJ6357534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 17:32:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C74020040;
        Fri, 24 Nov 2023 17:32:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0936220043;
        Fri, 24 Nov 2023 17:32:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Nov 2023 17:32:18 +0000 (GMT)
Date:   Fri, 24 Nov 2023 18:32:17 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.7-rc3
Message-ID: <ZWDeIR0PFAqvYgmU@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I5xRwTZLTVdMyjB2K7J4v2sUm6Q6f3z8
X-Proofpoint-GUID: I5xRwTZLTVdMyjB2K7J4v2sUm6Q6f3z8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311240144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull s390 changes for 6.7-rc3.

Please note the update to scripts/checkstack.pl concerns
s390-specific part only.

Thank you,
Alexander

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-3

for you to fetch changes up to aab1f809d7540def24498e81347740a7239a74d5:

  scripts/checkstack.pl: match all stack sizes for s390 (2023-11-22 15:06:23 +0100)

----------------------------------------------------------------
s390 updates for 6.7-rc3

- Remove unnecessary assignment of the performance event last_tag.

- Create missing /sys/firmware/ipl/* attributes when kernel is
  booted in dump mode using List-directed ECKD IPL.

- Remove odd comment.

- Fix s390-specific part of scripts/checkstack.pl script that only
  matches three-digit numbers starting with 3 or any higher number
  and skips any stack sizes smaller than 304 bytes.

----------------------------------------------------------------
Heiko Carstens (2):
      s390: remove odd comment
      scripts/checkstack.pl: match all stack sizes for s390

Mikhail Zaslonko (1):
      s390/ipl: add missing IPL_TYPE_ECKD_DUMP case to ipl_init()

Thomas Richter (1):
      s390/pai: cleanup event initialization

 arch/s390/include/asm/processor.h  |  1 -
 arch/s390/kernel/ipl.c             |  1 +
 arch/s390/kernel/perf_pai_crypto.c | 11 +++++------
 arch/s390/kernel/perf_pai_ext.c    |  1 -
 scripts/checkstack.pl              |  3 +--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index dc17896a001a..c15eadbb9983 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -228,7 +228,6 @@ typedef struct thread_struct thread_struct;
 	execve_tail();							\
 } while (0)
 
-/* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
 struct seq_file;
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index cc364fce6aa9..ba75f6bee774 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -666,6 +666,7 @@ static int __init ipl_init(void)
 						&ipl_ccw_attr_group_lpar);
 		break;
 	case IPL_TYPE_ECKD:
+	case IPL_TYPE_ECKD_DUMP:
 		rc = sysfs_create_group(&ipl_kset->kobj, &ipl_eckd_attr_group);
 		break;
 	case IPL_TYPE_FCP:
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 77fd24e6cbb6..39a91b00438a 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -279,12 +279,6 @@ static int paicrypt_event_init(struct perf_event *event)
 	if (IS_ERR(cpump))
 		return PTR_ERR(cpump);
 
-	/* Event initialization sets last_tag to 0. When later on the events
-	 * are deleted and re-added, do not reset the event count value to zero.
-	 * Events are added, deleted and re-added when 2 or more events
-	 * are active at the same time.
-	 */
-	event->hw.last_tag = 0;
 	event->destroy = paicrypt_event_destroy;
 
 	if (a->sample_period) {
@@ -318,6 +312,11 @@ static void paicrypt_start(struct perf_event *event, int flags)
 {
 	u64 sum;
 
+	/* Event initialization sets last_tag to 0. When later on the events
+	 * are deleted and re-added, do not reset the event count value to zero.
+	 * Events are added, deleted and re-added when 2 or more events
+	 * are active at the same time.
+	 */
 	if (!event->hw.last_tag) {
 		event->hw.last_tag = 1;
 		sum = paicrypt_getall(event);		/* Get current value */
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index 8ba0f1a3a39d..e7013a2e8960 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -260,7 +260,6 @@ static int paiext_event_init(struct perf_event *event)
 	rc = paiext_alloc(a, event);
 	if (rc)
 		return rc;
-	event->hw.last_tag = 0;
 	event->destroy = paiext_event_destroy;
 
 	if (a->sample_period) {
diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 84f5fb7f1cec..d83ba5d8f3f4 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -97,8 +97,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 		#   11160:       a7 fb ff 60             aghi   %r15,-160
 		# or
 		#  100092:	 e3 f0 ff c8 ff 71	 lay	 %r15,-56(%r15)
-		$re = qr/.*(?:lay|ag?hi).*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})
-		      (?:\(\%r15\))?$/ox;
+		$re = qr/.*(?:lay|ag?hi).*\%r15,-([0-9]+)(?:\(\%r15\))?$/o;
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
