Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B07758D83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGSGOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjGSGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:14:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C91BFF;
        Tue, 18 Jul 2023 23:13:57 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J5dAsk008428;
        Wed, 19 Jul 2023 06:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OroTwiE3L5F6o5GLw2nOdN4LfHMbtV6QCCW5huuiG94=;
 b=SvQQNJydPgl1zqZr1cG+cdn2Lpy//tr8HTe1qqMqFr9LLbQaKpnO8tvHQ06813Xoxpq9
 9gPDc2TdTYcmr5cjzwuJhjmS8D4iQaBQp4xXspfl2HLwD4RTz40tIWke1ns+POlcXglT
 VosQFwrak096ppo/iz6vbQHyU/IZIW/a3aTEyiPmMJwXjJF+xPUpjbdByic8wu5HCOXp
 5eenAdmc3oW6l5tC8VfM+HEz2LnHh259yVKr36oTaAIRt73aMpIas9cF8WPtXP7Gsbew
 dfWULpjWqvI0XTXDrFmram4pokJ7RYDAESFWZUjDPhL51Ak0RQSdy4eEe67iYMljWuq3 aQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx86f2g0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:13:48 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36J2XqCA031282;
        Wed, 19 Jul 2023 06:13:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jny75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:13:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36J6DiPS60096806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 06:13:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C479820043;
        Wed, 19 Jul 2023 06:13:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF4FD2004B;
        Wed, 19 Jul 2023 06:13:38 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.119.126])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jul 2023 06:13:37 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH v3 06/10] docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document affinity_domain_via_virtual_processor sysfs interface file
Date:   Wed, 19 Jul 2023 11:42:27 +0530
Message-Id: <20230719061231.631410-7-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230719061231.631410-1-kjain@linux.ibm.com>
References: <20230719061231.631410-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XVlqES-HLbrs28icTcyP1SSwciSdZLe_
X-Proofpoint-ORIG-GUID: XVlqES-HLbrs28icTcyP1SSwciSdZLe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add details of the new hv-gpci interface file called
"affinity_domain_via_virtual_processor" in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-hv_gpci    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
index 9e81de18142f..5ee33218be83 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
@@ -144,3 +144,35 @@ Description:	admin read only
 			   more information.
 
 		* "-EFBIG" : System information exceeds PAGE_SIZE.
+
+What:		/sys/devices/hv_gpci/interface/affinity_domain_via_virtual_processor
+Date:		July 2023
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	admin read only
+		This sysfs file exposes the system topology information by making HCALL
+		H_GET_PERF_COUNTER_INFO. The HCALL is made with counter request value
+		AFFINITY_DOMAIN_INFORMATION_BY_VIRTUAL_PROCESSOR(0xA0).
+
+		* This sysfs file will be created only for power10 and above platforms.
+
+		* User needs root privileges to read data from this sysfs file.
+
+		* This sysfs file will be created, only when the HCALL returns "H_SUCCESS",
+		  "H_AUTHORITY" or "H_PARAMETER" as the return type.
+
+		  HCALL with return error type "H_AUTHORITY" can be resolved during
+		  runtime by setting "Enable Performance Information Collection" option.
+
+		* The end user reading this sysfs file must decode the content as per
+		  underlying platform/firmware.
+
+		Possible error codes while reading this sysfs file:
+
+		* "-EPERM" : Partition is not permitted to retrieve performance information,
+			    required to set "Enable Performance Information Collection" option.
+
+		* "-EIO" : Can't retrieve system information because of invalid buffer length/invalid address
+			   or because of some hardware error. Refer to getPerfCountInfo documentation for
+			   more information.
+
+		* "-EFBIG" : System information exceeds PAGE_SIZE.
-- 
2.39.3

