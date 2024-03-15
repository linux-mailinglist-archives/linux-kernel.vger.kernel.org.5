Return-Path: <linux-kernel+bounces-104450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72E87CE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BECD281A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D4528E05;
	Fri, 15 Mar 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PG0ZuEFQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484082577C;
	Fri, 15 Mar 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509096; cv=none; b=AXtqwJMX9RcVHS1xC5yFsdpNi5SNK28zvWaUovbcjd6hs6+lVRoyKFOQxqVkRpQESGV0Ffr1rPUXL/Licv6/LghCgOYe6vy7UPbeI5IHHkePI83Uvbt6NKn+tbSaeYXC8YaO2R0ymqnEWT1R0c7bHXsfcgGX88YxXmRWiTW8ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509096; c=relaxed/simple;
	bh=3OvIJgX2Z3ssQlYadNpDLe9VAvQdGUrGfsyDarOqmng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/4P/swi+NLQoci1bC1H8Msy7wLbvce/EokvTARhdAkv3iMlj5vOsd2Au7Cs9GyOnrAN0RONXlxNk6v2m6RqJkx1xsfq+dPjLaBUlim+AqDcE9vpexKtzfMe131wIP326cK2bBuuwpeWuI1BwmPh9MovVYJtRHzeryGz3hsDZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PG0ZuEFQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FCjHeJ017733;
	Fri, 15 Mar 2024 13:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=tT8B/kd
	UHkC46V7YhLl5lhQXDDvT9Jmv/Vgr4h24VN0=; b=PG0ZuEFQSlRUNOsMygaGEbG
	31ibMrDsFBSz16LXP/ql2wFcS2upE6ZC+po89zAef6qXuOOXbEkXoDHNPIJxCpsA
	/W2d/NOLxdbtw0NR1OJb6tg4xw0Ntr3SvpywW1ysf/Xk4fGF1W5U0/7U42eItQuG
	xCT/OVwN4Pp/CTwwPg1ashjw+fnYoDnAS/Xxd2R/5igQzTGOV+KPAd8Y0jUzbFsQ
	qzG/uqI8Axyzd3K0UyYP2dktkW7YOEIopEHie7w4XScyaIOyhGmyod7L9lGB+R99
	n2jbVExPvJyhMYlk2jzz3b0BbOicftAdID7pBMRqSdKfPlX7Slvo/Ja0Vqdaheg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv9yq987p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:24:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42FDOdwT022423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:24:39 GMT
Received: from hu-rjendra-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 06:24:36 -0700
From: Rajendra Nayak <quic_rjendra@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <abel.vesa@linaro.org>, <quic_sibis@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: Fix the compatible for cluster idle states
Date: Fri, 15 Mar 2024 18:54:23 +0530
Message-ID: <20240315132423.2422484-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SehvGgjt0_tc9Hh5mjLgjGHbwB6eM-iw
X-Proofpoint-GUID: SehvGgjt0_tc9Hh5mjLgjGHbwB6eM-iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=695 clxscore=1011 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403150108

The compatible's for the cluster/domain idle states of x1e80100
are wrong, fix it.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 8e517f76189e..6b40082bac68 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -284,7 +284,7 @@ CLUSTER_C4: cpu-sleep-0 {
 
 		domain-idle-states {
 			CLUSTER_CL4: cluster-sleep-0 {
-				compatible = "arm,idle-state";
+				compatible = "domain-idle-state";
 				idle-state-name = "l2-ret";
 				arm,psci-suspend-param = <0x01000044>;
 				entry-latency-us = <350>;
@@ -293,7 +293,7 @@ CLUSTER_CL4: cluster-sleep-0 {
 			};
 
 			CLUSTER_CL5: cluster-sleep-1 {
-				compatible = "arm,idle-state";
+				compatible = "domain-idle-state";
 				idle-state-name = "ret-pll-off";
 				arm,psci-suspend-param = <0x01000054>;
 				entry-latency-us = <2200>;
-- 
2.34.1


