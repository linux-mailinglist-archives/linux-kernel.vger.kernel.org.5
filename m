Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63B47566F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGQO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjGQO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:59:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62AB9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:59:15 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HEhtPL008059;
        Mon, 17 Jul 2023 14:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LmURygZlBrerhkIVoF5heWa/27Y6FcJVGdZwY+PeiMw=;
 b=oWla03hKzYHhu3RzVI4y8jqMf3YO/YPF2aEOnFaxqMW5Nq7E3cgWXgptNq4Gf3uSQw7O
 jHaT85AmGRku86XxQlUfAAzBIuwSmnedl0HcyQx1+8FLFVGeyiSEg6zWVR0BJtMrCMFj
 ad5SZu/f04eUny7iTkqQDiX81+82a2zo7jhpH6DW8dkcYSa++JR6i79jVfsclCmScvKp
 8TmyBW5qUCMuR/3I3qmGWJ7MQAIQesyuwVgd2rjNjX+tNL6+q5f7eR2LngqDpVJNXd3U
 Ldgsof2OmgokPzz3Lne4S08aBtmcFwmPFx8pXoYEUTDyRekQpIy2hvg9DC4LPFBha/CQ Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw77y123r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 14:58:50 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36HEiNDE011834;
        Mon, 17 Jul 2023 14:58:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw77y1233-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 14:58:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36HDwFPW007605;
        Mon, 17 Jul 2023 14:58:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j04tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 14:58:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HEwkmH44695898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 14:58:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 379E320049;
        Mon, 17 Jul 2023 14:58:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 464DF20040;
        Mon, 17 Jul 2023 14:58:40 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.2.235])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 14:58:40 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     peterz@infradead.org, tim.c.chen@linux.intel.com
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hdanton@sina.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, sshegde@linux.vnet.ibm.com,
        v-songbaohua@oppo.com, vincent.guittot@linaro.org,
        vschneid@redhat.com, x86@kernel.org, yangyicong@hisilicon.com,
        yu.c.chen@intel.com
Subject: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
Date:   Mon, 17 Jul 2023 20:28:23 +0530
Message-Id: <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tTlXGqcHP_YJuXzdxvOaoIeYaVLpk4S8
X-Proofpoint-ORIG-GUID: JtuPYtP2yaSaEIORV3zR3973jtzx-1xD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_11,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

For SMT4, any group with more than 2 tasks will be marked as
group_smt_balance. Retain the behaviour of group_has_spare by marking
the busiest group as the group which has the least number of idle_cpus.

Also, handle rounding effect of adding (ncores_local + ncores_busy)
when the local is fully idle and busy group has more than 2 tasks.
Local group should try to pull at least 1 task in this case.

Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 932e7b78894a..9502013abe33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9532,7 +9532,7 @@ static inline long sibling_imbalance(struct lb_env *env,
 	imbalance /= ncores_local + ncores_busiest;

 	/* Take advantage of resource in an empty sched group */
-	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	if (imbalance <= 1 && local->sum_nr_running == 0 &&
 	    busiest->sum_nr_running > 1)
 		imbalance = 2;

@@ -9720,6 +9720,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		break;

 	case group_smt_balance:
+		/* no idle cpus on both groups handled by group_fully_busy below */
+		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
+			if (sgs->idle_cpus > busiest->idle_cpus)
+				return false;
+			if (sgs->idle_cpus < busiest->idle_cpus)
+				return true;
+			if (sgs->sum_nr_running <= busiest->sum_nr_running)
+				return false;
+		}
+		break;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
--
2.31.1

