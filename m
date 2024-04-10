Return-Path: <linux-kernel+bounces-137907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9B89E945
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172D7285459
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C7200D9;
	Wed, 10 Apr 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dFrBOjdy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52806168D0;
	Wed, 10 Apr 2024 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724915; cv=none; b=tmA51vWjREOg7KG3iTaXMv9wFF2JAAvoz96zk/BlhTQgA4FGfyatchuWhUD0I7MDe+v5rhVDG1zW5hpelY9nH6lnnKaxbTtm64V3iXFRZ4salqj8PMx/fE422GRpMkpUrAYjx5STJlAVlndnFO5WElCdDAIOmjwI9dsbt10zzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724915; c=relaxed/simple;
	bh=sWswXJyjBQ2nkPehb6b9OC8FpWgmJGhvn+kM9/2mJR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uW+JSiNqJ49k2I62ycuIaRIuVNMbBf8j6dXbWl2oT3bVh9yOWCBJhVPQqvk91m43PORMkpM7FAppbh1avvV8cIhX3W2gKpsYmw9S9JCvxFN0N0VqbiD1pmsnuwOjjN/ioA754f4WfIs6QJD1zwQVUBu6HNb1ch0kz+t4gs4FvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dFrBOjdy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A4YjSN032480;
	Wed, 10 Apr 2024 04:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=6bXVQP/
	MeTp7czzAt3VhgRTeKtkth59inoNPfKrnrMs=; b=dFrBOjdyR5pQFBNOnUvDqum
	NkjuTz+5d4YBdYGCBO0QbwCayMBnZAusrGGEKfjnLJD3vyiYyAXoEluHokAvEUu+
	+gyO4V3itdmllJ3BYVSGr2MgBeFdSwhBYG86zaFrcJ3o4E+unHecrqaBPhZNNEYp
	6F3apK0IdiQkrpbqCzSiFIh87UXGZTZy1+5k98SVItgLIb1V3GQKom1bIwxVrcF8
	mLF5yzxeYzBCcQlqru2zxu91Dvpm1DC4o0lU7jRZ/TaFGzpW4EgOvoEETVwfRICe
	/HBKF8FuhlEi5ZqL4TyoeE1MQ3YAhBhpJvf10c107CVrLZNiPO5SQxl5kHG6HDA=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdkv8g3r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43A4sMSD019647;
	Wed, 10 Apr 2024 04:54:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xayfm2ybr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:24 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43A4sO9x019669;
	Wed, 10 Apr 2024 04:54:24 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-atulpant-hyd.qualcomm.com [10.213.109.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43A4sOJn019667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:24 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3869597)
	id 5EB3F24ED9; Wed, 10 Apr 2024 10:24:23 +0530 (+0530)
From: Atul Pant <quic_atulpant@quicinc.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: Atul Pant <quic_atulpant@quicinc.com>, kernel@quicinc.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH 2/2] sched/idle: Add a description for play_idle_precise
Date: Wed, 10 Apr 2024 10:24:17 +0530
Message-Id: <20240410045417.3048209-3-quic_atulpant@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U7yqdkGZSK0GOvPgfZ2Kfn9OPH6130Zh
X-Proofpoint-GUID: U7yqdkGZSK0GOvPgfZ2Kfn9OPH6130Zh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=982 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100033

Since runtime accounting of any RT idle thread is prevented, add a
description about this function that it runs idle loops on a cpu
without these threads being preempted due to RT throttling.

Signed-off-by: Atul Pant <quic_atulpant@quicinc.com>
---
 kernel/sched/idle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5007b25c5bc6..7aaf3679f50a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -334,6 +334,11 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+/*
+ * This function runs idle loops on a cpu, whose policy is set as SCHED_FIFO.
+ * Despite being a rt thread, runtime for it is not accounted, thus preventing
+ * its preemption due to rt-throttling
+ */
 void play_idle_precise(u64 duration_ns, u64 latency_ns)
 {
 	struct idle_timer it;
-- 
2.25.1


