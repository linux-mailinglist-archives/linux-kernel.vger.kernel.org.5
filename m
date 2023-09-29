Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CEC7B3756
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjI2PyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjI2PyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:54:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62475195;
        Fri, 29 Sep 2023 08:54:09 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TFaxEZ016531;
        Fri, 29 Sep 2023 15:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=FpOS0CfhsyNwYKSlCFfHo6DyS8mMS3VqYkj6R6+zbTQ=;
 b=AgX2AzaAjWN5x85X1wv/4//T/zgwc1gUt9AJkFXBU0Om8aPo9lfRJxUKWF2RSgqj5/q4
 vwAhnu8cCUylUtbnSI32VanAHKHYprzBT99qxVqB1Bx1z3MSUwMttPA3lS7KyR4XjYMa
 Qs9c57ni5KAuGVqw8XhrMosbJ5c9x1DrwGy5VEA8HK+C7w1auNUZARHdo5piwKt1BF7h
 cv7M8LE6ROCvgZ21q6N/toFI+FiOM4IOfCKbygMR25dHCeXxljOIDRCBFEka6HonoLiO
 FzrWDey3Jc7VJXfbpFh7a38XuoHOX6vRfjkXl0uXg3PdW+K/WoqGXvq3FQU9Y5zw4Q12 dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3te0nya4kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:43 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TFbUmb020204;
        Fri, 29 Sep 2023 15:53:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3te0nya4jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TEflEa008143;
        Fri, 29 Sep 2023 15:53:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taar05y23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TFrc8r16974344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 15:53:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 179C020040;
        Fri, 29 Sep 2023 15:53:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CA7C20043;
        Fri, 29 Sep 2023 15:53:33 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.6.110])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 15:53:33 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        qperret@google.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org, bsegall@google.com, linux-eng@arm.com
Subject: [PATCH v5 0/2] sched: EAS changes for EM complexity and sysctl
Date:   Fri, 29 Sep 2023 21:22:07 +0530
Message-Id: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IodrdHRxQqRsP9EunSL7l4JS5J2Nr4xb
X-Proofpoint-ORIG-GUID: 82YN9GrhRdThizGyjxPHgZA1qtzTO2JV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 mlxlogscore=764
 mlxscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Brief:
[PATCH v5 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
Since the EAS complexity was greatly reduced, bigger platforms can
handle EAS. To reflect this improvement, remove the EAS complexity check.

[PATCH v5 2/2] sched/topology: change behaviour of sysctl sched_energy_aware
based on the platform
Depending on the platform sysctl will either enable/disable EAS and NOP
in case if EAS is not supported.

Patchset contains these two patches. Second patch depends on the first
patch to be applied first.

v4->v5:
sched_is_eas_possible missed handling of case when EM complexity was high.
Dietmar suggested that there was work done already which removes these
checks. Since it makes sched_is_eas_possible cleaner, picked up that
patch along with v4 and made it as a patchset.
Instead of using first CPU in cpu_active_mask, doing a simple loop across
all CPU in cpu_active_mask to check if there is any asymmetric CPU
capacities since it was breaking EAS capabilities over CPUSET islands.
v3->v4:
valentin suggested it would be better to consider simpler approach that
was mentioned in v2. It is a standard approach to keep the knob visible
but change how read and write are handled. Did that and Refactored the
code to use a common function in build_perf_domains and in sysctl handler.
v2->v3:
Chen Yu and Pierre Gondois both pointed out that if platform becomes
capable of EAS later, this patch was not allowing that to happen.
Addressed that by using a variable to indicate the sysctl change
and re-worded the commit message with desired behaviour,
v1->v2:
Chen Yu had pointed out that this will not destroy the perf domains on
architectures where EAS is supported by changing the sysctl.
[v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/
[v2] Link: https://lore.kernel.org/lkml/20230901065249.137242-1-sshegde@linux.vnet.ibm.com/
[v3] Link: https://lore.kernel.org/lkml/20230913114807.665094-1-sshegde@linux.vnet.ibm.com/
[v4] Link: https://lore.kernel.org/lkml/20230926100046.405188-1-sshegde@linux.vnet.ibm.com/

Pierre Gondois (1):
  sched/topology: Remove EM_MAX_COMPLEXITY limit

Shrikanth Hegde (1):
  change behaviour of sysctl sched_energy_aware based on the platform

 Documentation/admin-guide/sysctl/kernel.rst |   3 +-
 Documentation/scheduler/sched-energy.rst    |  29 +---
 kernel/sched/topology.c                     | 151 ++++++++++----------
 3 files changed, 82 insertions(+), 101 deletions(-)

--
2.39.3

