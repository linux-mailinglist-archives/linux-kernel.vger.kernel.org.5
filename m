Return-Path: <linux-kernel+bounces-137905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412589E941
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE44A1F2384F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141110A3E;
	Wed, 10 Apr 2024 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DyBHstwL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5EB1095C;
	Wed, 10 Apr 2024 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724911; cv=none; b=Vq0bQuOTMTy7XIagm97ZbEy7Mt5wA+p1z2xDzP5ayHVR0Kq+VPB0KZa8V0XiODoYYXLD/eEblX+ubBtjvgwEToLGTsFINAwkh2iKEYEipPTbuQSg/EFsxKNUr1E0DyfqKzHGJ47UqQb3EPsTGJDtKad94u6//TG0HXHOxFO4A7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724911; c=relaxed/simple;
	bh=yK8f1jxgs495YTTLvbM/C7XA1mY/3/19W61ulgiWL/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKslkIZ2ljn/0h7wXyVwtEhCO0zBluIgt7nOysbzO6hbI/iDGMmmLz9CToKXjjb4NwWAi5FdDFSApz5GwpXSlyAGtrJIS5z66jcsfE/OjGJFBWNW83df0MudODoL7M9djmwIDDxboDbnvK1N0Bmacb7deR4MsxNCEyDxMGP91yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DyBHstwL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A2QLfX008440;
	Wed, 10 Apr 2024 04:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=XrVSXz+
	m7FPVYUyZI8pEtJeMZrOr8S8k3iyBAYboSvs=; b=DyBHstwLu7gFxQCDv1+CPfl
	5tTfLy/mkOKU4bEGJf65xrPFadWJCLJrTqCvVxa21nTrhaMWME5kxfGyP7V4Usym
	QQsfVZier39wjtJ7UfAUvdt4Doff7j3EEwtVlEz5mXhnjgdZP2vCOK1Q7fIjwim2
	2lsHORjGYZm/Eco00m8/S29INwEBR0JOAIa1ZSCq7FLxZNckO67caqX6NfKXjnhV
	bContcuI7nDutTSdtMQXdkM3x0hwdYRWILjoKAmDaDi7R8I5CmPP+HGOaF5b05J0
	OPbTI6zytv3bOR0GrYugRZ9PCI8Z3hbT/dVTw87TWcDQ1GQPCjC/BnaMtvkvvog=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdh6qgwcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:26 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43A4sNqs019658;
	Wed, 10 Apr 2024 04:54:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xayfm2ybg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:23 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43A4sNJS019652;
	Wed, 10 Apr 2024 04:54:23 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-atulpant-hyd.qualcomm.com [10.213.109.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43A4sM67019651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:23 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3869597)
	id E292124EF9; Wed, 10 Apr 2024 10:24:21 +0530 (+0530)
From: Atul Pant <quic_atulpant@quicinc.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: Atul Pant <quic_atulpant@quicinc.com>, kernel@quicinc.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH 1/2] sched/rt: Disable runtime accounting for idle threads with SCHED_FIFO policy
Date: Wed, 10 Apr 2024 10:24:16 +0530
Message-Id: <20240410045417.3048209-2-quic_atulpant@quicinc.com>
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
X-Proofpoint-GUID: uZ-cX8wRYDdJstkfkFu54lXR_P_62BxA
X-Proofpoint-ORIG-GUID: uZ-cX8wRYDdJstkfkFu54lXR_P_62BxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=969 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100033

To prevent the throttling of RT idle threads, like the idle-inject
threads, skip accounting of runtime for these threads.

Signed-off-by: Atul Pant <quic_atulpant@quicinc.com>
---
 kernel/sched/rt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4ac36eb4cdee..d20999270e75 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1075,7 +1075,9 @@ static void update_curr_rt(struct rq *rq)
 		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 		int exceeded;
 
-		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
+		if (sched_rt_runtime(rt_rq) != RUNTIME_INF &&
+				!(curr->policy == SCHED_FIFO &&
+					curr->flags & PF_IDLE)) {
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
 			exceeded = sched_rt_runtime_exceeded(rt_rq);
-- 
2.25.1


