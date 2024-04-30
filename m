Return-Path: <linux-kernel+bounces-164356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BF78B7CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1721C230FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7D5179206;
	Tue, 30 Apr 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a1n7U23K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368E173322;
	Tue, 30 Apr 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494107; cv=none; b=mVGK7g6G2MQrZmV4z24J6LVjETIWcpx48h3Jb7WUJnG1bAGLTfrBWF8Qvw21PZFV3UuYTZIR7da36Ia6KSbDA/v3KwRI77SreWFG4ZvW2QRpg1IhuJj68dGOCkQ2a5xSTYdTPXFtYYCMAdlrpm8qD737NtrRWV8OJcJl6H4OMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494107; c=relaxed/simple;
	bh=kC+inNy7rgg3VVM4Ehb7zNBl3I+G2cUvaDXz263Qxcw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=p5XW/1sZ/tCBlTUIHWUCEKkHOaZIRCX79J3rOGE286hEyqqnbpwpSRUTEq6UVvLQ9NiYkLtKfgsTxYuz7X7BqZIUGErGa7uNO0m3LokhtoI7MdEg/fxLVZcbj+g9QDmh6ABJdl6z+anGM/r75X0XR6NWOMGMxrdueEFYPwsfSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a1n7U23K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UC8beA027011;
	Tue, 30 Apr 2024 16:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=wDr8dzJLpaiP
	P1TFmJF3Q6ce8I4MPRSecRkI20be+cg=; b=a1n7U23KhNq0raaHzPE0kgd/qJi6
	x8VmR1mJ1cdiaV8cjH2XwW+mEItW14WfMn/ZKebjfr5oyRg7dw1HIArPRbO9YQVu
	xQqaSKCFDlD4EyLOS/oCu2KKlnrrcC93TNSOFaFRdhgv8PFzkbzfgJtfOVgFqsRt
	aIeDIzPOsTYVTKtpjmpd+FAqtJ4FaIg7tsjBLYyUnI1Och3adhwEUsEV34X9h63W
	F8ke5gp73cM1ckXfYa0k714nj20LZOc0B5dVgTpkaD2bhjeSXQmWVshqkw1t+Kbd
	/wF4hTOT1/YAbQSp7DJamh4m8KGMiDBUPB7iv0+xsR0HYGu/Ot7+qb8hJw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtfys411r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:21:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UGLYu1025510;
	Tue, 30 Apr 2024 16:21:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1dqe-1;
	Tue, 30 Apr 2024 16:21:34 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UGLX2I025504;
	Tue, 30 Apr 2024 16:21:33 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UGLXk8025502;
	Tue, 30 Apr 2024 16:21:33 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 638E02287; Tue, 30 Apr 2024 21:51:32 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Qiang Yu <quic_qianyu@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: qcom: sa8775p: add support for x4 EP PCIe controller
Date: Tue, 30 Apr 2024 21:51:25 +0530
Message-Id: <1714494089-7917-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ikTmId_na6_5At1CtcZhguBiwEjZqFG4
X-Proofpoint-ORIG-GUID: ikTmId_na6_5At1CtcZhguBiwEjZqFG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1011 suspectscore=0 mlxlogscore=618
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300117
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series updates PHY and add EP PCIe node in dtsi file for
ep pcie1 controller that supports gen4 and x4 lane width.

Dependency for Patch 2
----------------------

Depends on: 
https://lore.kernel.org/all/1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com/

V1 -> V2:
- Added Reviewed-by tag in patch 1
- Fixed indentation in patch 2
- Fixed merged conflict on patch 2 and rebased on top of v6.9-rc6
- link to v1: https://lore.kernel.org/all/1699362294-15558-1-git-send-email-quic_msarkar@quicinc.com/

Mrinmay Sarkar (2):
  phy: qcom-qmp-pcie: add x4 lane EP support for sa8775p
  arm64: dts: qcom: sa8775p: Add ep pcie1 controller node

 arch/arm64/boot/dts/qcom/sa8775p.dtsi    | 47 ++++++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c |  9 +++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.7.4


