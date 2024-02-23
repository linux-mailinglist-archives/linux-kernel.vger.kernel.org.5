Return-Path: <linux-kernel+bounces-78628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC74861611
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCDC1C21B47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D886151;
	Fri, 23 Feb 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I5S+M6Rf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9985933;
	Fri, 23 Feb 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702784; cv=none; b=aq93YkAK1XLGkH2q/2yFTnVoS+EWAPwQv3NuQTlAyy2VP+vKLI3PcEEg4XjvQn8haPUtPaEnPgENitYsD8hqVC1R7Oe/Nl7CquEVUUOQ0umV2yh4FA4IrIkpNKKlFDmCn9Ym4I5eoUeqiGRlWKTF2TWGpoToQPGou17xoTsLli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702784; c=relaxed/simple;
	bh=Bh7hbPA2pcr3mgdNggsUQJwd3UKt27/rsubwwczdt2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=twinIAgT0rSZkbD8Fjh8nNiyVyixKpG5LKxjg4HhxPUskC5UfgSro15ggOnnN9TUE/AQ3ueG8jWD7J9DGIpRhTZq74RaALiAIwarDK9MXAdw3MA7gjiGI50ECXsTXCUlM/ECzd9bSSixReDjoCdsMruIQ3KLAD3mpJx+MgnSCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I5S+M6Rf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NEYfo0013056;
	Fri, 23 Feb 2024 15:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=XFL
	GLGr7l0kmpJUigyFMep8rypd1smZcrvTcwKTqVJw=; b=I5S+M6RfTD+3Ws6wvr2
	ayNtVrXbVPT2vg7eM8DulNMKVlH3KaqI52SUvt5KXtnEGXe66NE47UjaR+43qMFn
	j7mzrVE3JFhp7D9Wruyw5vcJkKAIc1DkrixGWvUbq6RvU7kgrbPySSTFTRzm4Qm9
	wsdz6PUVPf2TuQZ010lDQS+V9BqnhW2s7C82/5NAo2l8gzw8ytXKdIXDTbPlGxqt
	zXyY+o/bBGqUPhGAZuClGaj1T7SZ4/2zLbfD0g/dIppJUT2NRTIL/MFmX5UAcyE2
	/cu28BQosS63Au5aiaHSYZgFO7GoLi9B4Tt+7ovt0vIH1EVys5uujpTcLQ1DBOfA
	ODQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wew8c051p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:39:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NFdVFb029057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:39:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 07:39:31 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 23 Feb 2024 07:39:31 -0800
Subject: [PATCH] wifi: ath11k: constify MHI channel and controller configs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-mhi-const-wifi-ath11k-v1-1-51b9d42d2639@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADK82GUC/4WNQQ7CIBBFr9LM2jEMFUVX3sN0QYDKxBQUatU0v
 bvYC7h8L/nvz1B8Zl/g1MyQ/cSFU6xAmwZsMPHqkV1lkELuhJQSh8BoUywjvrhnNGMguqEzwhh
 x1G6vW6jbe/Y9v9fupascuIwpf9abiX72X3EiJNS9InUgsq1y58eTLUe7tWmAblmWL7VGI/G8A
 AAA
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pkx6RwKwzJvO0-VCFPk-7A6mA1abSfW8
X-Proofpoint-GUID: Pkx6RwKwzJvO0-VCFPk-7A6mA1abSfW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230112

Unlike the event configuration which can be modified by MHI, the
channel and controller configurations are expected to be const. And
since they are not modified locally, constify them to prevent runtime
modification.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index b53659145fcf..7f566d9106fc 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -20,7 +20,7 @@
 #define MHI_TIMEOUT_DEFAULT_MS	20000
 #define RDDM_DUMP_SIZE	0x420000
 
-static struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
+static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 	{
 		.num = 0,
 		.name = "LOOPBACK",
@@ -102,7 +102,7 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
 	},
 };
 
-static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
+static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
@@ -113,7 +113,7 @@ static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
 	.event_cfg = ath11k_mhi_events_qca6390,
 };
 
-static struct mhi_channel_config ath11k_mhi_channels_qcn9074[] = {
+static const struct mhi_channel_config ath11k_mhi_channels_qcn9074[] = {
 	{
 		.num = 0,
 		.name = "LOOPBACK",
@@ -195,7 +195,7 @@ static struct mhi_event_config ath11k_mhi_events_qcn9074[] = {
 	},
 };
 
-static struct mhi_controller_config ath11k_mhi_config_qcn9074 = {
+static const struct mhi_controller_config ath11k_mhi_config_qcn9074 = {
 	.max_channels = 30,
 	.timeout_ms = 10000,
 	.use_bounce_buf = false,
@@ -384,7 +384,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
 	struct mhi_controller *mhi_ctrl;
-	struct mhi_controller_config *ath11k_mhi_config;
+	const struct mhi_controller_config *ath11k_mhi_config;
 	int ret;
 
 	mhi_ctrl = mhi_alloc_controller();

---
base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
change-id: 20240222-mhi-const-wifi-ath11k-da0aa098d683


