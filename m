Return-Path: <linux-kernel+bounces-137906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014389E943
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF0F2852BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA21802E;
	Wed, 10 Apr 2024 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WhYfVjFS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989911713;
	Wed, 10 Apr 2024 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724915; cv=none; b=Hp4PQ7GmjOrAiwKmekAns+0ku8nTwVChSNaHs8IzSitBnI79KiOFjkFyYYrkRCEYfH3U6iftU42nlU9/xCzilhaiT12TKw66GMiPzNKe9mZITwNKR0rJqeJQJUH9Y+Lj33P97tDDKkBwrtqBByFxjXCkUmtXFihh9GLpNBPEoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724915; c=relaxed/simple;
	bh=EymDDOM4U7Eq9581iU4DK9ZxodSx0ThuWFQ3yOhEpM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzud5mfJNMUfIHAmtNVolUT8KnRDF78MwwarTZDCxI5v4n3zxE8VtHX2/nWz5UMZJmpx+V9HKEsaXi6mygvFRYF4SoqrNlQYAvY4axvMoup7rxjqbq8VJw59v4Ke2OTpzjgFLPdVFIZr295516gj16h9dao4pqnI2wDSIPLOJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WhYfVjFS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A32v1G009559;
	Wed, 10 Apr 2024 04:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=zrLyM2KDpJlv26X+wZ35
	AVRZebtf4oNSrtFPpgKuyHI=; b=WhYfVjFSbsltcgTfwwH2BUFpp+ZKv6XVJlgw
	/FzfkNv9ou2OoaTScLKJCoUM6/23DaTodD6hDs3j26U7HUSW2uDeRh2cxCvW4KNx
	wWIMolTB0xe0U9jmGaO2TcuhhEVzQ8iebPf6kEu6W8Wu4zSNQub4Rp581CQLiLst
	vZop5zwsb5qFm46WSXVXZqS8p8OMr4zWubWtnPR6snkgLJWwIlMmUJefVivrIsTi
	One92XrghZwWLtzSsdZDvhyZ4Gv/R+QmKQla6O+Q2MtvsAVkCgfa6eD0Zv4Vt6Ce
	2mABUDaQhyzALtpbq6HHfwL+U0ATMQjvuMTXnrfB9cup5tU1VQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xddqvhr20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:26 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43A4sMSC019647;
	Wed, 10 Apr 2024 04:54:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xayfm2ybb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43A4sMwl019641;
	Wed, 10 Apr 2024 04:54:22 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-atulpant-hyd.qualcomm.com [10.213.109.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43A4sM1F019638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:54:22 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3869597)
	id D70CF24ED9; Wed, 10 Apr 2024 10:24:20 +0530 (+0530)
From: Atul Pant <quic_atulpant@quicinc.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc: Atul Pant <quic_atulpant@quicinc.com>, kernel@quicinc.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Date: Wed, 10 Apr 2024 10:24:15 +0530
Message-Id: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: yti_1A-0u2cUFOxd5_yFR6TJcaMsZZIQ
X-Proofpoint-GUID: yti_1A-0u2cUFOxd5_yFR6TJcaMsZZIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=837
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100034

We are trying to implement a solution for thermal mitigation by using
idle injection on CPUs.  However we face some limitations with the
current idle-inject framework. As per our need, we want to start
injecting idle cycles on a cpu for indefinite time (until the
temperature/power of the CPU falls below a threshold). This will allow
to keep the hot CPUs in the sleep state until we see improvement in
temperature/power. If we set idle duration to a large value or have an
idle-injection ratio of 100%,  then the idle-inject RT thread suffers
from RT throttling. This results in the CPU exiting from the sleep state
and consume some power.

To solve this limitation, we propose a solution to disable RT-throttling
whenever idle-inject threads run. We achieve this by not accounting the
runtime for the idle-inject threads.

Atul Pant (2):
  sched/rt: Disable runtime accounting for idle threads with SCHED_FIFO
    policy
  sched/idle: Add a description for play_idle_precise

 kernel/sched/idle.c | 5 +++++
 kernel/sched/rt.c   | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1


