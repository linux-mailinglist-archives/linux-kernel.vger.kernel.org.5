Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7397EC2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjKOMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjKOMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:51:24 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7AE122;
        Wed, 15 Nov 2023 04:51:20 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCjnVs031670;
        Wed, 15 Nov 2023 12:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4qA5GmaLa+DXGP5sGQVRqL71vYDH1BLSkmB+4VfMGro=;
 b=T1GzNkMB4mINdt2xkiIUqEdFD/HtH/E9GXb1YDbIo1u/MeUK4N8qXPJOjvi8F1cLih10
 CndZ6IYh/PUSuexAr1HGuHXhwgXeYVEfqURg/iPwolKEGoLK6FXHq0GdCyqa4IX/yss0
 D1uqFNbHdPvQrgWLu2dMzJrI/b1PYHKE8+mXdYSWaC57d8eAGX8xn2/JXpfkEkMvAdzS
 B0cYKyG0TA+rPDsyL/hSS111hUciE+abI+CxlYTsHl3lY+ryGbrW5+S1168gFtXPEjVK
 Ev0qZGUDThuhC4hjvmi3kh0fP5jx2kZwyv3kBxf5J1u9hX6nCXvA53YeMKG+ci+S4eTX 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucx94g4vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:51:18 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFCjnso031688;
        Wed, 15 Nov 2023 12:51:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucx94g4v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:51:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCYGB9001920;
        Wed, 15 Nov 2023 12:51:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayfc6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:51:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFCpBVJ4063846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 12:51:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA68620040;
        Wed, 15 Nov 2023 12:51:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 986C42004B;
        Wed, 15 Nov 2023 12:51:11 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 12:51:11 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Subject: [GIT PULL v1 1/2] KVM: s390: vsie: fix wrong VIR 37 when MSO is used
Date:   Wed, 15 Nov 2023 13:51:10 +0100
Message-ID: <20231115125111.28217-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115125111.28217-1-imbrenda@linux.ibm.com>
References: <20231115125111.28217-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZvBPf3Xn29TuU7fDIGECsKqtNJLIE2nj
X-Proofpoint-ORIG-GUID: y1k0J25N1ejyUe-2XIRg5FnxKE_iio80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_11,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the host invalidates a guest page, it will also check if the page
was used to map the prefix of any guest CPUs, in which case they are
stopped and marked as needing a prefix refresh. Upon starting the
affected CPUs again, their prefix pages are explicitly faulted in and
revalidated if they had been invalidated. A bit in the PGSTEs indicates
whether or not a page might contain a prefix. The bit is allowed to
overindicate. Pages above 2G are skipped, because they cannot be
prefixes, since KVM runs all guests with MSO = 0.

The same applies for nested guests (VSIE). When the host invalidates a
guest page that maps the prefix of the nested guest, it has to stop the
affected nested guest CPUs and mark them as needing a prefix refresh.
The same PGSTE bit used for the guest prefix is also used for the
nested guest. Pages above 2G are skipped like for normal guests, which
is the source of the bug.

The nested guest runs is the guest primary address space. The guest
could be running the nested guest using MSO != 0. If the MSO + prefix
for the nested guest is above 2G, the check for nested prefix will skip
it. This will cause the invalidation notifier to not stop the CPUs of
the nested guest and not mark them as needing refresh. When the nested
guest is run again, its prefix will not be refreshed, since it has not
been marked for refresh. This will cause a fatal validity intercept
with VIR code 37.

Fix this by removing the check for 2G for nested guests. Now all
invalidations of pages with the notify bit set will always scan the
existing VSIE shadow state descriptors.

This allows to catch invalidations of nested guest prefix mappings even
when the prefix is above 2G in the guest virtual address space.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Tested-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20231102153549.53984-1-imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 02dcbe82a8e5..8207a892bbe2 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -587,10 +587,6 @@ void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
 
 	if (!gmap_is_shadow(gmap))
 		return;
-	if (start >= 1UL << 31)
-		/* We are only interested in prefix pages */
-		return;
-
 	/*
 	 * Only new shadow blocks are added to the list during runtime,
 	 * therefore we can safely reference them all the time.
-- 
2.41.0

