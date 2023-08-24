Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA378697D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbjHXIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbjHXIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:05:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D1198E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:05:02 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O81TSp028258;
        Thu, 24 Aug 2023 08:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IgtOcm4rENQZENZQzaZU/dkds05wpAQNREcodI3KFSI=;
 b=T0DMmliK7mD6izN+s0K/Iz8gI0j0p+V4kePnQQun0mRKorg3ED6OBHUCDW9h/R0LQwe7
 b6pHXshKQnJIG0Z53PnqWeSvlq4w7mXpyqXUIawNxlfZecKIxrlwPFCVdEHwr7g1MAnQ
 I/ZTHrgweJxbB0PXmNiVoLK1URMrmMMG70kK1BQjt73iiLDjwuv9JByMwylRlnS9722J
 Fl4BIEfez5Kw/x8Et0t8SwvNdz7Q6sAJKApIc+E17B2JajTGYyG/Cz6wz+n3cdz0Y4Bw
 CsBNJdFalMV+Vhs4O/Zy0SNrPsUYLTrvAeiQSzcOSmHQ/TwJFW/2cQ/SCW5/wdtoPu1/ PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp3b5g2d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:04:21 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37O83f0w004023;
        Thu, 24 Aug 2023 08:04:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sp3b5g2c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:04:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37O7C4SZ010383;
        Thu, 24 Aug 2023 08:04:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21swdj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:04:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37O84H0w17236520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 08:04:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7BDD2004B;
        Thu, 24 Aug 2023 08:04:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65FA20071;
        Thu, 24 Aug 2023 08:04:15 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 24 Aug 2023 08:04:15 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     peterz@infradead.org, vincent.guittot@linaro.org, mingo@redhat.com
Cc:     sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        mingo@kernel.org, lukasz.luba@arm.com, claudio@evidence.eu.com
Subject: [PATCH] sched/Documentation: Modify the knob to base_slice_ns
Date:   Thu, 24 Aug 2023 13:33:42 +0530
Message-Id: <20230824080342.543396-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xqUf3Ny6UkcKsEQh173Polmb_CP_6zEP
X-Proofpoint-GUID: qwg08eDKWlEtP4yxoiuGGUSC5dwQaHtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_05,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After committing scheduler to EEVDF, since
commit e4ec3318a17f ("sched/debug: Rename sysctl_sched_min_granularity
to sysctl_sched_base_slice") sysctl has been changed. In the documentation
its mentioned that its one of the central tunable available for feed into
the scheduler. This changes the doc as well.

Fixes: e4ec3318a17f ("sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice")
Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 Documentation/scheduler/sched-design-CFS.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index 03db55504515..f68919800f05 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -94,7 +94,7 @@ other HZ detail.  Thus the CFS scheduler has no notion of "timeslices" in the
 way the previous scheduler had, and has no heuristics whatsoever.  There is
 only one central tunable (you have to switch on CONFIG_SCHED_DEBUG):

-   /sys/kernel/debug/sched/min_granularity_ns
+   /sys/kernel/debug/sched/base_slice_ns

 which can be used to tune the scheduler from "desktop" (i.e., low latencies) to
 "server" (i.e., good batching) workloads.  It defaults to a setting suitable
--
2.31.1

