Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C77E636A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjKIFuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIFub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:50:31 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC201AE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:50:28 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A95laqM015407;
        Thu, 9 Nov 2023 05:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bHyL6okkDp866tGDyts+4ZwUO2BZULAwm3vpcD27fnI=;
 b=R9es98gj2fJEc1VoQxOi3XMOGZkf0dQcG5VyiQ2PDjyqZSX9kqUIg4OQOgOv+jHW4cNi
 QNbJ8wc6wWDAguzNVZgqa9i7dRNsqjxZ3ZXHonVCwqARfDOqYyDgFUAWcjN+xlOYN8xP
 26CD+bCTFuGvve9CvKuDEj5EbfMrze/JD2CTN7sS3fRL2ccOyTgXhS99iPvAYezJromT
 c9SwpTwKZdBY+BvKF0E7QV4NKK6KE4QME4Q3qDVKH1lD3hiaeQWul/AgofFAcYHvsltp
 oZMHtcj2rRxst8iO+9hyCk2Dn3gWPoH2wR5Us78oFpi+rqwSUJY8aJRmS1WY6Hx55MvG EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8s201f54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:50:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A95m67i017253;
        Thu, 9 Nov 2023 05:50:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8s201f49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:50:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A94q1Vq003455;
        Thu, 9 Nov 2023 05:50:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w221tcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:50:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A95o3wB45154562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 05:50:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E8F22004B;
        Thu,  9 Nov 2023 05:50:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25BB20040;
        Thu,  9 Nov 2023 05:50:00 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.109.198.19])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Nov 2023 05:50:00 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: [PATCH v4 2/5] powerpc/smp: Disable MC domain for shared processor
Date:   Thu,  9 Nov 2023 11:19:30 +0530
Message-ID: <20231109054938.26589-3-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d__swH62mFofZ5W_nx6tsbQ9U4diNO5m
X-Proofpoint-ORIG-GUID: IAxiS1Dffz73V5XPc8YLGawJW0p5s6vC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_04,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like L2-cache info, coregroup information which is used to determine MC
sched domains is only present on dedicated LPARs. i.e PowerVM doesn't
export coregroup information for shared processor LPARs. Hence disable
creating MC domains on shared LPAR Systems.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 69a3262024f1..1dae4e9ba42d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1052,6 +1052,10 @@ static struct cpumask *cpu_coregroup_mask(int cpu)
 
 static bool has_coregroup_support(void)
 {
+	/* Coregroup identification not available on shared systems */
+	if (is_shared_processor())
+		return 0;
+
 	return coregroup_enabled;
 }
 
-- 
2.31.1

