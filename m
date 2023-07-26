Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7E763277
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjGZJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjGZJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:38:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87119A2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:38:11 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q9bikD015029;
        Wed, 26 Jul 2023 09:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SoYofsSQ3ZYhteD634BlJ89CumxmiI/eGtSFXLNkEn4=;
 b=RiDNMDIbP/pIiObx9LU6OX/p1TOFj1ExgVI+c9pNfbbIAGDAxyg4B4yOu4STIPr1hmMm
 kjFeKCL0ZjMvPStXf5O8nd3c3RDPW8Q8VKhYVJtvdMbL+GeboD2IvA4YAcNLI65+634l
 zLEB1kS+f5QDwejac+L/1Q82RiEhpSgfB1CgIdo9sdG4KzL6fIJPd9RcwLKN4t8J21db
 NGpKW09C8UaVK8lN3ypK0Zlg/WPoczDman7dqgmY2vhsw+QQsGCsrs3JXMBz5njR9U2G
 iZWzyqbef/nr2aNN0URW+KCRmPWw2U3mhRMy4tzXqJ6pk7M5Y5+uGBPvW6gzGpUBRxw6 oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s30w282jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:37:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36Q9bv7s016060;
        Wed, 26 Jul 2023 09:37:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s30w282hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:37:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8mMJs003624;
        Wed, 26 Jul 2023 09:37:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txk3hb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:37:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q9bs5i18285122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 09:37:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E24852004D;
        Wed, 26 Jul 2023 09:37:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A85FE2004E;
        Wed, 26 Jul 2023 09:37:51 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.179.15.237])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jul 2023 09:37:51 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, mgorman@suse.de
Subject: [RFC PATCH] sched/fair: Skip idle CPU search on busy system
Date:   Wed, 26 Jul 2023 15:06:12 +0530
Message-Id: <20230726093612.1882644-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HXHlIhn_VNCTSYEy09sfnCApQElA2qwD
X-Proofpoint-GUID: Tc2ZT_nucLg8jF9l306BkyfxXMEzzfTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is fully busy, there will not be any idle CPU's.
In that case, load_balance will be called mainly with CPU_NOT_IDLE
type. In should_we_balance its currently checking for an idle CPU if
one exist. When system is 100% busy, there will not be an idle CPU and
these idle_cpu checks can be skipped. This would avoid fetching those rq
structures.

This is a minor optimization for a specific case of 100% utilization.

.....
Coming to the current implementation. It is a very basic approach to the
issue. It may not be the best/perfect way to this.  It works only in
case of CONFIG_NO_HZ_COMMON. nohz.nr_cpus is a global info available which
tracks idle CPU's. AFAIU there isn't any other. If there is such info, we
can use that instead. nohz.nr_cpus is atomic, which might be costly too.

Alternative way would be to add a new attribute to sched_domain and update
it in cpu idle entry/exit path per CPU. Advantage is, check can be per
env->sd instead of global. Slightly complicated, but maybe better. there
could other advantage at wake up to limit the scan etc.

Your feedback would really help. Does this optimization makes sense?

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..903d59b5290c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10713,6 +10713,12 @@ static int should_we_balance(struct lb_env *env)
 		return 1;
 	}

+#ifdef CONFIG_NO_HZ_COMMON
+	/* If the system is fully busy, its better to skip the idle checks */
+	if (env->idle == CPU_NOT_IDLE && atomic_read(&nohz.nr_cpus) == 0)
+		return group_balance_cpu(sg) == env->dst_cpu;
+#endif
+
 	/* Try to find first idle CPU */
 	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
 		if (!idle_cpu(cpu))
--
2.31.1

