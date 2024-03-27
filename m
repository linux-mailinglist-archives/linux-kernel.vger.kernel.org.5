Return-Path: <linux-kernel+bounces-120548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573D88D936
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9361299EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49E33993;
	Wed, 27 Mar 2024 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lxAMyTdo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B71EB2C;
	Wed, 27 Mar 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528357; cv=none; b=SIhB6vozTqnNdwqyM4rxtlT9OP/odk1Ebp1lK5wyWvGB4mkIjxCtYW9QhMvt2MLznjrKPcNHdyw7CBMaIMUsPDckFoNUh+FiBIEyaiHzphwTfdpdJ+HfNLlrMPVMQnL8LKJxpstmFO0w9ZNBfV93ZIPoKm4KBV79SVV9/PHD9Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528357; c=relaxed/simple;
	bh=+e1bLci2+S1wtwonBr0GglprXIyIVN25Nj4MKcFoSzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZRxKtqj3igrucSJVdKWOXDqird31EU1ceYrNYXjSDhL9S7fI3g7Uq2XN6Xa3N6IbAirPHYV9bFFryN2h5MHPVRbAoB6Dija2roOpzWW356nu29FPuJt2aam9Q7pyFCIQaKFuKj27fZwo3aUmAlip7MQDdNJR8jEIKxozuu1jEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lxAMyTdo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R8NvKW021642;
	Wed, 27 Mar 2024 08:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=1UyOPhjrwvDWtFv0/b3/
	55B+b1d7TKnArQ2vtkFV23E=; b=lxAMyTdocswqbffjaR5p1YLVPPNVZDNNdSw2
	c/PjjQUy9CdVyCBpurIfC8Ds5av2PcqSBnjLJlgJd8WdwGeFcjPCTi1RzZ/Hs+3s
	i+xH5KDiW44Ud/OZ37/zDcEZpe8CB0J5YjKzvD++Qt2aS8IA+ilda1/7zKQSO8wX
	lKfUmwbQ2ehFT5t68zIIlJyDaCGpVuaZYC/Pf9f/YmBM12Mofli7CsiULTUMKflp
	EUXjaGuyV6TTRqKhKYW8WCq7AJmh8V9P9WoHXLm43tVa3JOtjJHUJOR1I65rufsq
	EbKvKQH6dqm9PTtfxHQYlNyNb+5hRLuCgHPlUbRYA25zvw2B7A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x478394kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 08:32:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42R8WIEE031578;
	Wed, 27 Mar 2024 08:32:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3x1r5m3mv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 08:32:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42R8WHjj031572;
	Wed, 27 Mar 2024 08:32:17 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42R8WH5F031571;
	Wed, 27 Mar 2024 08:32:17 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id 497335006A9; Wed, 27 Mar 2024 14:02:16 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v1 RESEND] slimbus: stream: Add null pointer check for client functions
Date: Wed, 27 Mar 2024 14:02:14 +0530
Message-Id: <20240327083214.29443-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qnJx_78JeXJclkiP7BM7X7bTqfhdiOFX
X-Proofpoint-ORIG-GUID: qnJx_78JeXJclkiP7BM7X7bTqfhdiOFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270057

There is a possible scenario where client driver is calling
slimbus stream APIs in incorrect sequence and it might lead to
invalid null access of the stream pointer in slimbus
enable/disable/prepare/unprepare/free function.

Fix this by checking validity of the stream before accessing in
all function API’s exposed to client.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 drivers/slimbus/stream.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..c5a436fd0952 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -202,10 +202,16 @@ static int slim_get_prate_code(int rate)
 int slim_stream_prepare(struct slim_stream_runtime *rt,
 			struct slim_stream_config *cfg)
 {
-	struct slim_controller *ctrl = rt->dev->ctrl;
+	struct slim_controller *ctrl;
 	struct slim_port *port;
 	int num_ports, i, port_id, prrate;
 
+	if (!rt || !cfg) {
+		pr_err("%s: Stream or cfg is NULL, Check from client side\n", __func__);
+		return -EINVAL;
+	}
+
+	ctrl = rt->dev->ctrl;
 	if (rt->ports) {
 		dev_err(&rt->dev->dev, "Stream already Prepared\n");
 		return -EINVAL;
@@ -358,9 +364,15 @@ int slim_stream_enable(struct slim_stream_runtime *stream)
 {
 	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
 				3, SLIM_LA_MANAGER, NULL);
-	struct slim_controller *ctrl = stream->dev->ctrl;
+	struct slim_controller *ctrl;
 	int ret, i;
 
+	if (!stream) {
+		pr_err("%s: Stream is NULL, Check from client side\n", __func__);
+		return -EINVAL;
+	}
+
+	ctrl = stream->dev->ctrl;
 	if (ctrl->enable_stream) {
 		ret = ctrl->enable_stream(stream);
 		if (ret)
@@ -411,12 +423,18 @@ int slim_stream_disable(struct slim_stream_runtime *stream)
 {
 	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
 				3, SLIM_LA_MANAGER, NULL);
-	struct slim_controller *ctrl = stream->dev->ctrl;
+	struct slim_controller *ctrl;
 	int ret, i;
 
+	if (!stream) {
+		pr_err("%s: Stream is NULL, Check from client side\n", __func__);
+		return -EINVAL;
+	}
+
 	if (!stream->ports || !stream->num_ports)
 		return -EINVAL;
 
+	ctrl = stream->dev->ctrl;
 	if (ctrl->disable_stream)
 		ctrl->disable_stream(stream);
 
@@ -448,6 +466,11 @@ int slim_stream_unprepare(struct slim_stream_runtime *stream)
 {
 	int i;
 
+	if (!stream) {
+		pr_err("%s: Stream is NULL, Check from client side\n", __func__);
+		return -EINVAL;
+	}
+
 	if (!stream->ports || !stream->num_ports)
 		return -EINVAL;
 
@@ -476,8 +499,14 @@ EXPORT_SYMBOL_GPL(slim_stream_unprepare);
  */
 int slim_stream_free(struct slim_stream_runtime *stream)
 {
-	struct slim_device *sdev = stream->dev;
+	struct slim_device *sdev;
+
+	if (!stream) {
+		pr_err("%s: Stream is NULL, Check from client side\n", __func__);
+		return -EINVAL;
+	}
 
+	sdev = stream->dev;
 	spin_lock(&sdev->stream_list_lock);
 	list_del(&stream->node);
 	spin_unlock(&sdev->stream_list_lock);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation


