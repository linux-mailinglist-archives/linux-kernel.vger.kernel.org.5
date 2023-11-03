Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7137E0769
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377087AbjKCRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjKCRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:30:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700B184;
        Fri,  3 Nov 2023 10:30:17 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3H9W3n005481;
        Fri, 3 Nov 2023 17:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NxvAOzhg827pv6avDli2bC+1p13rvYlgHvqhDgIz0KU=;
 b=XHF3Ao6SPCyr4CsYGzSuBOVE6yrGqh9o8STa7VDgwOhFAkDuFes00RnjlUyrhPrtuJpV
 gsp2gbMn1aAkgxnC05IuDAB3OBd2zbpQPWkPuRg30RvURwQPzxgLRunMFx10KIJh/xf1
 2ZhJWJuml6xlp0sNLCGJBt7TO2Clb1ooRuQI2HMdrWeSRN7drt+N7tjHVy4KpwGRLdsL
 jGRMl5iaUxML6MLkQpwzi5aqFhW6ZS3lZnLSmhRr7T1yQC2jWpcb8sE0zblfajSCWW3t
 vmF4Mfm0xmVDj2AnRJBV4N30pceYaU0/59mus3ug3FvIRwkUrsn9XWlQkajIs5SdTf5n Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u55100kyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 17:30:16 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3HMJph022109;
        Fri, 3 Nov 2023 17:30:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u55100kyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 17:30:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3FPOVm011389;
        Fri, 3 Nov 2023 17:30:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1eukq4ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 17:30:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3HUAQa36503890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 17:30:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BFE92004E;
        Fri,  3 Nov 2023 17:30:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B92EB2004B;
        Fri,  3 Nov 2023 17:30:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 17:30:09 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Michael Mueller <mimu@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] KVM: s390: vsie: Fix STFLE interpretive execution identification
Date:   Fri,  3 Nov 2023 18:30:05 +0100
Message-Id: <20231103173008.630217-2-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103173008.630217-1-nsg@linux.ibm.com>
References: <20231103173008.630217-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FIu8Gbxl_-q1aLPaEfkkKn_pD6qvy3Ys
X-Proofpoint-GUID: cOAEU8HiC1LlMHHaNfDydcMjYdNJVRRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_16,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STFLE can be interpretively executed.
This occurs when the facility list designation is unequal to zero.
Perform the check before applying the address mask instead of after.

Fixes: 66b630d5b7f2 ("KVM: s390: vsie: support STFLE interpretation")
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 61499293c2ac..d989772fe211 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -988,9 +988,10 @@ static void retry_vsie_icpt(struct vsie_page *vsie_page)
 static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	__u32 fac = READ_ONCE(vsie_page->scb_o->fac) & 0x7ffffff8U;
+	__u32 fac = READ_ONCE(vsie_page->scb_o->fac);
 
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
+		fac = fac & 0x7ffffff8U;
 		retry_vsie_icpt(vsie_page);
 		if (read_guest_real(vcpu, fac, &vsie_page->fac,
 				    sizeof(vsie_page->fac)))
-- 
2.39.2

