Return-Path: <linux-kernel+bounces-77667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EFB8608A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCD4283BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DECABA2B;
	Fri, 23 Feb 2024 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="horjrIZ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BE8BF9;
	Fri, 23 Feb 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653636; cv=none; b=lijAWZhV+MKfE3rHUU1oLdtKAY/5PGgqZ+uo6pEXPCNWr9Fwk1mYIzHGLJvVq9VFa3wFty1q8H2jqK2gxNdKW7pYmGd3zOtdzwvb5CDgyI9/4cx47gGgPV2TL1K4rpOHqNm3nQUvt3j+W4rdrPcVzSZzDJFMOOuxytd/1lVe3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653636; c=relaxed/simple;
	bh=OJDfnVJSg3jkeSoz4vJPLXupTf+um5nChVNJXpHzJfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gKxPjtMTYWPHfaVsP5wjHZDNU60pxMzqwaWiU4+sS4oF0ixflBLEcN0z/dAbSC/MIgMxZtBFNlx7dVbXhsMlyrvsuOpYi7iSPC6rOuPiyqdRniHIwOo4Xarcr+nQHinKU6cxtgU+sp07ILK0KxpyB+gcgojW3tw+Hxjntzb5ASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=horjrIZ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N1Rfsu030093;
	Fri, 23 Feb 2024 02:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=M51
	KKqBp/vj9yqdyEByL4qmhSGQ5SSE2/FALZr/2vME=; b=horjrIZ3DGlFEP6oNQ+
	isqDK1Plt2fILZ7bF64WJuYi30WUAeK5jyhlnwqaFqfXnz6YuvEudh3GsLW5tPO0
	nL0T3Jsa6JuG0dm2Vsew4MeWR9PrqWfb6diSJcLMvpbRQXvDsfKWdzp9NbtBJpGj
	ccugXveZtDM+EoHq4Rp1VonzTbtcN9E7KAyc2H9aNGQxFnSJa0ZoDalZw5GRn28y
	mxeIU7y46Yf9CuIlGlirBFMdq/qlHJ6eCast3aObpPXBdherDIZ3RIZFddSXE6Gc
	vw394uB1kJA1eQs6Dgnh9GkrOIx13MZz5Iw+X+a+4H6XkZNBHoCtXBeaFDIpLHns
	7Gg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weg88r78q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 02:00:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N20QO4026888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 02:00:26 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 18:00:23 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 22 Feb 2024 18:00:23 -0800
Subject: [PATCH] bus: mhi: host: pci_generic: constify
 modem_telit_fn980_hw_v1_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-mhi-const-bus-mhi-host-pci_generic-v1-1-d4c9b0b0a7a5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADb812UC/x3NQQqDQAxA0atI1g1orFB6lSLFZjJOFp2RiUpBv
 HuDy7f5/wCTqmLwbA6osqtpyY7u1gCnKc+CGtxALd1bIsJvUuSSbcXPZpdScSys71myxxiHEOI
 jdn3oBwYPLVWi/q7JazzPP1fnHwB0AAAA
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FLXGPFSrDFmU3YGFzCT0QbfwhRLjxrMC
X-Proofpoint-GUID: FLXGPFSrDFmU3YGFzCT0QbfwhRLjxrMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=967
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230012

MHI expects the controller configs to be const, and all of the other ones
in this file already are, so constify modem_telit_fn980_hw_v1_config.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index cd6cd14b3d29..51639bfcfec7 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -538,7 +538,7 @@ static struct mhi_event_config mhi_telit_fn980_hw_v1_events[] = {
 	MHI_EVENT_CONFIG_HW_DATA(2, 2048, 101)
 };
 
-static struct mhi_controller_config modem_telit_fn980_hw_v1_config = {
+static const struct mhi_controller_config modem_telit_fn980_hw_v1_config = {
 	.max_channels = 128,
 	.timeout_ms = 20000,
 	.num_channels = ARRAY_SIZE(mhi_telit_fn980_hw_v1_channels),

---
base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
change-id: 20240222-mhi-const-bus-mhi-host-pci_generic-5ddf8f13d35c


