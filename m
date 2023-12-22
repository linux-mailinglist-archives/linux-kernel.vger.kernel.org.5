Return-Path: <linux-kernel+bounces-9339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353A81C450
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944DEB21718
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D88F6F;
	Fri, 22 Dec 2023 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eON17ve6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52ED8F49;
	Fri, 22 Dec 2023 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM3uEvN011619;
	Fri, 22 Dec 2023 04:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=qK5
	D8UP4RDy5ZkloOfi0ToTYDtDmEy/6oK9zKhgi3yc=; b=eON17ve6RrtvHoONJKc
	M3Pa3rqQMGa8wgpnDN8/bRiU8ci4mcFklRf/MWfmDyO68msihJNqruS7MJDQvkmg
	kWVgKEGQqunT20f2saMX+h2WHRMRdgxlQ39dnNW/M2OJAv5MvpXU2rzH2eHraGRf
	787UJ/emlbzh4iaZ7VjLa48ztiOooHFOhhoMivMtS0Q8NqySvKmx1FDNS+SzM/wu
	K6Vqq8Gvd65g1U1misaFA6NbE/ZtLg35Z/tqABOd1JVyZn+lf/pvff0n5QO4R+6r
	+Q2CR7/5gQQ0cUpmPAFsgRBaNT172efMLWW6W5AJFtV1yFXrI+pL4sgmF1eFUxCf
	/DA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v51u087ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:47:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM4lHZu015195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:47:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 20:47:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 21 Dec 2023 20:47:16 -0800
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SC8280XP camera clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231221-enable-sc8280xp-camcc-v1-1-2249581dd538@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANMUhWUC/x2NQQqDQAwAvyI5N+CmxWq/UnrIxqiBbSq7WATx7
 116nIFhDiiaTQs8mgOyfq3YxyuESwOysM+KNlYGaukaiAKqc0yKRXrq231F4bcIDt0QSSbS23i
 H2kYuijGzy1Jr31Kqcs062f6fPV/n+QPjk8+9fAAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703220436; l=1041;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=06hL3yhc3xnstQwS0EMzv4WqBfn7XbuGk00+jR8MkYc=;
 b=55GV2W++l7f37IUS3YgrQ3lta0kZ6YQiFgoNaUgjJq13hJqXEe0jj/NviaZ+rrEbWqhXpq8h41mW
 Im73tzZKAMYo2d/yEiL8XtUt+r7aglUSOkTy34v2XqDpZHbELyLE
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ESTXOShoYtwimei3FtQ09QFtqqxA02BM
X-Proofpoint-ORIG-GUID: ESTXOShoYtwimei3FtQ09QFtqqxA02BM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=755 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220030

With the camera clock controller added to the DeviceTree of SC8280XP the
interconnect providers no longer reaches sync_state, resulting in a
noticeable reduction in battery life.

Enable the camera clock controller (as a module) to avoid this, and
hopefully soon provide some level of camera support.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ef1061089548..e5ce6d08006e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1256,6 +1256,7 @@ CONFIG_QCM_GCC_2290=y
 CONFIG_QCM_DISPCC_2290=m
 CONFIG_QCS_GCC_404=y
 CONFIG_SA_GCC_8775P=y
+CONFIG_SC_CAMCC_8280XP=m
 CONFIG_SC_DISPCC_8280XP=m
 CONFIG_SA_GPUCC_8775P=m
 CONFIG_SC_GCC_7180=y

---
base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
change-id: 20231221-enable-sc8280xp-camcc-969b2cf2e4d7

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


