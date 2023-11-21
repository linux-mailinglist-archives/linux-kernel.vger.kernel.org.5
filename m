Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED47F38F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjKUWIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjKUWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:08:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826451BDC;
        Tue, 21 Nov 2023 14:07:42 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLvAQh004984;
        Tue, 21 Nov 2023 22:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kILyw5cdgjGn5/bq6lT/7Km7hA/yuzYatpUTfjRHTeA=;
 b=hqOXpP1f8bIGOr1YO9BRUraMEl5g8iU7mn8EU+j2zTP1uV7APlwaCpZWKUJ9Ct8/llaV
 7rlzRI9OTk0SCsaIeUaAGCKhg8BY7L28c+HZiX0gWbxmaTWNwBuUOMj6h9a140X7lDIC
 yRmGUD+ppugcOSROrCcn8TeHHS95xgDX997TJoxr9VnJDRLn3ocfVihoFBYFGKFltpIM
 Ltbh5FkXrBYqoXXpwYLTihebF4Vpdf97BWJ8vxd2u+Zd/mSWhIsJYn4/kZYTwv7sD2bM
 9W+l4RTTQgKxdp2TQRKAJICLIRsk9QyekGVINNIxWsEtyWTjKpa8sLK5/mftAYTR2uoP 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn8asq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:07:25 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALM0867014409;
        Tue, 21 Nov 2023 22:07:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn8arn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:07:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLnHT6007594;
        Tue, 21 Nov 2023 22:02:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knuq1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALM2Kne18416300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 22:02:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DED620065;
        Tue, 21 Nov 2023 22:02:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D486F2005A;
        Tue, 21 Nov 2023 22:02:18 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.23.98])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Nov 2023 22:02:18 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 09/33] kmsan: Introduce kmsan_memmove_metadata()
Date:   Tue, 21 Nov 2023 23:01:03 +0100
Message-ID: <20231121220155.1217090-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121220155.1217090-1-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YLZAtK1TpMNezhFcBC9jhFUedsl6RBkF
X-Proofpoint-ORIG-GUID: o6c7zDwWcv-L2Rb3-jDw-jClXErr2uGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to manually copy metadata in order to describe the effects
of memmove()-like logic in uninstrumented code or inline asm. Introduce
kmsan_memmove_metadata() for this purpose.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/kmsan-checks.h | 14 ++++++++++++++
 mm/kmsan/hooks.c             | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
index c4cae333deec..5218973f0ad0 100644
--- a/include/linux/kmsan-checks.h
+++ b/include/linux/kmsan-checks.h
@@ -61,6 +61,17 @@ void kmsan_check_memory(const void *address, size_t size);
 void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 			size_t left);
 
+/**
+ * kmsan_memmove_metadata() - Copy kernel memory range metadata.
+ * @dst: start of the destination kernel memory range.
+ * @src: start of the source kernel memory range.
+ * @n:   size of the memory ranges.
+ *
+ * KMSAN will treat the destination range as if its contents were memmove()d
+ * from the source range.
+ */
+void kmsan_memmove_metadata(void *dst, const void *src, size_t n);
+
 #else
 
 static inline void kmsan_poison_memory(const void *address, size_t size,
@@ -77,6 +88,9 @@ static inline void kmsan_copy_to_user(void __user *to, const void *from,
 				      size_t to_copy, size_t left)
 {
 }
+static inline void kmsan_memmove_metadata(void *dst, const void *src, size_t n)
+{
+}
 
 #endif
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index eafc45f937eb..4d477a0a356c 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -286,6 +286,17 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 }
 EXPORT_SYMBOL(kmsan_copy_to_user);
 
+void kmsan_memmove_metadata(void *dst, const void *src, size_t n)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	kmsan_enter_runtime();
+	kmsan_internal_memmove_metadata(dst, (void *)src, n);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_memmove_metadata);
+
 /* Helper function to check an URB. */
 void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {
-- 
2.41.0

