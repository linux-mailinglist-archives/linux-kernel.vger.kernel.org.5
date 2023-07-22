Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A488675DD5C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGVQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGVQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:02:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5F1FDC;
        Sat, 22 Jul 2023 09:02:22 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MFektB010588;
        Sat, 22 Jul 2023 16:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=PVa97C7Cwh+xHF2v5DoyIDCIRmsajuhfvgcSIWJ/7hs=;
 b=hauexU/8NgPIoZqV/2BOBxGwfAX7091oxJwHnAVdCC2D+cZtYiDtbPwUtXMT4fd9KMJJ
 /udDbOqwaTg+FmPiyxKN0RnBC1WI4ZgNSwVCzTpYVJnt6IAUrRVubtngJSUlg8hTNb4A
 eDNzMHIgRJ/zwWUIl3MGVFPORPhNqjuagZaM7nDtHVK4xHvwlXZVN74rs+vVuV4NicP/
 nEa23iQ1530Pu0WBI3tnOiZGzpKoDo7/BJMxxvnny4ZEs02GNOvymOSUgK1L8Z+u1R00
 ATqxXV8wrWqakyYTBHBT0YOiamJIL1efrL4pw8bQMVEyt7KVb1xEYGQKoFHW1y/mrJPh TQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0gsqh2d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 16:02:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36MEwoLk029625;
        Sat, 22 Jul 2023 16:02:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6sn7yg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 16:02:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36MG2Ha946400194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 16:02:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B09F20043;
        Sat, 22 Jul 2023 16:02:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBB020040;
        Sat, 22 Jul 2023 16:02:16 +0000 (GMT)
Received: from osiris (unknown [9.171.82.123])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 22 Jul 2023 16:02:16 +0000 (GMT)
Date:   Sat, 22 Jul 2023 18:02:15 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.5-rc3
Message-ID: <20230722160215.7417-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vqmrvIlpibemFHpFKBJ0HNZRuCVWuIN3
X-Proofpoint-ORIG-GUID: vqmrvIlpibemFHpFKBJ0HNZRuCVWuIN3
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307220141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull a couple of s390 fixes for 6.5-rc3.

Thanks,
Heiko

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-3

for you to fetch changes up to 4cfca532ddc3474b3fc42592d0e4237544344b1a:

  s390/zcrypt: fix reply buffer calculations for CCA replies (2023-07-20 16:48:56 +0200)

----------------------------------------------------------------
s390 fixes for 6.5-rc3

- Fix per vma lock fault handling: add missing !(fault & VM_FAULT_ERROR)
  check to fault handler to prevent error handling for return values that
  don't indicate an error

- Use kfree_sensitive() instead of kfree() in paes crypto code to clear
  memory that may contain keys before freeing it

- Fix reply buffer size calculation for CCA replies in zcrypt device driver

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: fix reply buffer calculations for CCA replies

Sven Schnelle (1):
      s390/mm: fix per vma lock fault handling

Wang Ming (1):
      s390/crypto: use kfree_sensitive() instead of kfree()

 arch/s390/crypto/paes_s390.c          |  2 +-
 arch/s390/mm/fault.c                  |  2 ++
 drivers/s390/crypto/zcrypt_msgtype6.c | 33 +++++++++++++++++++++++----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index d29a9d908797..38349150c96e 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -103,7 +103,7 @@ static inline void _free_kb_keybuf(struct key_blob *kb)
 {
 	if (kb->key && kb->key != kb->keybuf
 	    && kb->keylen > sizeof(kb->keybuf)) {
-		kfree(kb->key);
+		kfree_sensitive(kb->key);
 		kb->key = NULL;
 	}
 }
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index dbe8394234e2..2f123429a291 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -421,6 +421,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	vma_end_read(vma);
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		if (likely(!(fault & VM_FAULT_ERROR)))
+			fault = 0;
 		goto out;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 67fd2ec9c5a1..e668ff5eb384 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1101,23 +1101,36 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 				      struct ica_xcRB *xcrb,
 				      struct ap_message *ap_msg)
 {
-	int rc;
 	struct response_type *rtype = ap_msg->private;
 	struct {
 		struct type6_hdr hdr;
 		struct CPRBX cprbx;
 		/* ... more data blocks ... */
 	} __packed * msg = ap_msg->msg;
+	unsigned int max_payload_size;
+	int rc, delta;
 
-	/*
-	 * Set the queue's reply buffer length minus 128 byte padding
-	 * as reply limit for the card firmware.
-	 */
-	msg->hdr.fromcardlen1 = min_t(unsigned int, msg->hdr.fromcardlen1,
-				      zq->reply.bufsize - 128);
-	if (msg->hdr.fromcardlen2)
-		msg->hdr.fromcardlen2 =
-			zq->reply.bufsize - msg->hdr.fromcardlen1 - 128;
+	/* calculate maximum payload for this card and msg type */
+	max_payload_size = zq->reply.bufsize - sizeof(struct type86_fmt2_msg);
+
+	/* limit each of the two from fields to the maximum payload size */
+	msg->hdr.fromcardlen1 = min(msg->hdr.fromcardlen1, max_payload_size);
+	msg->hdr.fromcardlen2 = min(msg->hdr.fromcardlen2, max_payload_size);
+
+	/* calculate delta if the sum of both exceeds max payload size */
+	delta = msg->hdr.fromcardlen1 + msg->hdr.fromcardlen2
+		- max_payload_size;
+	if (delta > 0) {
+		/*
+		 * Sum exceeds maximum payload size, prune fromcardlen1
+		 * (always trust fromcardlen2)
+		 */
+		if (delta > msg->hdr.fromcardlen1) {
+			rc = -EINVAL;
+			goto out;
+		}
+		msg->hdr.fromcardlen1 -= delta;
+	}
 
 	init_completion(&rtype->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
