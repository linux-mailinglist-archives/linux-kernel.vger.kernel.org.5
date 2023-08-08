Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B67749D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHHUFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjHHUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:05:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F3A98F1C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:24:27 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378I8tUm008305;
        Tue, 8 Aug 2023 18:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RwxWVPovUTrynx4nS40Hobl7eTIRsO9WiIooWGadRD8=;
 b=E8rPCtinXwTiaZyA7fsJahUe66Rr1maqAYdVysw2ktDJoXWL1vm6FRaw8cVBj8Aj5bWk
 HWjaS+GBiwVgzwNWzS8GV2lQ0YdNdD1EugMJ5Fs6M2vcLSHiBj2mOUKhCpPhRpxHe+rs
 A/KIQNEg4OqGF4PFwTQIm1XkP6xHWSp4lgFsIWKuQ2M2ZP92RNyMytUNymU2YA8w1Ldo
 4EbcXYvGvyZlu2dlguqiT2Sai4sdp5POBmcIX5SqwBgPqCrREZUlrOnmK6P5aQ0/cM9e
 lz9F25wnfBp8anJu7QVPxFsVqxh2BJwpT2p0K0PdtZJhLnuAf+sS+1c63ZA7XYp04sly Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbthbrn79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:24:01 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378IMXHX028373;
        Tue, 8 Aug 2023 18:24:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbthbrn5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:24:01 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378H6p89030348;
        Tue, 8 Aug 2023 18:23:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn93by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 18:23:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378INvXT61538642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 18:23:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA9DE2004D;
        Tue,  8 Aug 2023 18:23:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE2BA20040;
        Tue,  8 Aug 2023 18:23:55 +0000 (GMT)
Received: from Jinghaos-MacBook-Pro.watson.ibm.com (unknown [9.31.97.28])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  8 Aug 2023 18:23:55 +0000 (GMT)
From:   Jinghao Jia <jinghao@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH] x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h
Date:   Tue,  8 Aug 2023 14:23:53 -0400
Message-Id: <20230808182353.76218-1-jinghao@linux.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Haf3KT5VJsNnnRuXpR_26GbrteF6NtWW
X-Proofpoint-ORIG-GUID: 9fTVryxRpRWyi659nsfnmMTtdf8SLO_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxlogscore=705 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUILD_VDSO macro was incorrectly spelled as BULID_VDSO in
asm/linkage.h. This causes the !defined(BULID_VDSO) directive to always
evaluate to true.

Correct the spelling to BUILD_VDSO.

Fixes: bea75b33895f ("x86/Kconfig: Introduce function padding")
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
---
 arch/x86/include/asm/linkage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 0953aa32a324..97a3de7892d3 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -21,7 +21,7 @@
 #define FUNCTION_PADDING
 #endif
 
-#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BULID_VDSO)
+#if (CONFIG_FUNCTION_ALIGNMENT > 8) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 # define __FUNC_ALIGN		__ALIGN; FUNCTION_PADDING
 #else
 # define __FUNC_ALIGN		__ALIGN
-- 
2.41.0

