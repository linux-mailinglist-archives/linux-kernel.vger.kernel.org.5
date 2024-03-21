Return-Path: <linux-kernel+bounces-109844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2773885668
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6C6282AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B504E1D5;
	Thu, 21 Mar 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ePSFgGTy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7D2C6BB;
	Thu, 21 Mar 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013171; cv=none; b=ewPl9hfrf7jHWAvJt7gFY2P9m3zzqsFjGjj/6HGkXUl3FuJswbitzC2yZYfCKzOA7+DWv6wlRM8gJRr21YM/gc+I+WVkzjp9nWkbIa+R2Z+5TltPoxn0KqMk8k/jtAaX5w1D8h0KNiLsYbiXIRR8CprsVlo8N1Rih6x0kgysanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013171; c=relaxed/simple;
	bh=PlwojYEi6pzpwOgwySUmkgmcNKbny4X/LINyRO/qUdg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dL3zqI2EpuOMBBwmdfju/o+L5Jd7Tak0LQG8Q6Q4M0FE1VOsjyt811poRZoJZN5WJdvGyqNp7s3GQH2QeUnPSSKPW+BvaZK45MCSqAfvzFQTE+XW5JL+kACk8VJOYjbqcKRyQIOYBfYmTeAMaPjgrvZQZamnzgFi0KuHB7QZJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ePSFgGTy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6Y13Q026350;
	Thu, 21 Mar 2024 09:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=oMwXO0z
	PVmYR5tmzhdeivtbshlrazKGqDzHgj+QVUFg=; b=ePSFgGTyIP5Ad5Sji0VOOpf
	2jvYmOVqe1Az4GMBHNI+b0SjGVdg34EG2rTQFl1XdHEPFz0kx4mTnGia6HkRoM1j
	ChyCZTnf9KxSvB/2tSSmmRWhFxIBAiUR7Q4Pbzu86FVgD4CGX6zftoGOco6ZGn2c
	5e7XYmAL492OwX952Q/K0z3hU/ho2Z/jz88xC5li8ht+N+NmszkDiBXAACSP/RPg
	syxA7sWN6+OeZa74YZrijRwQTy8YWbMxDhAX9L820CnDH4YRTFj6Tv8ZBHzorC6R
	Opq/YYiSfoCemx5+glzZ3L4kGEiOArhqE9YNNrjDZZovXDnOR0oyhQLgRGZgevg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fqxgb82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:26:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L9Q0Gx014554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:26:00 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 02:25:55 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH V2 RESEND 0/6] Add support for videocc and camcc on SM8650
Date: Thu, 21 Mar 2024 14:55:23 +0530
Message-ID: <20240321092529.13362-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: cqkittiQ6jZQXccZFv4QU-qzkGe91f8j
X-Proofpoint-GUID: cqkittiQ6jZQXccZFv4QU-qzkGe91f8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210064

Add support for video and camera clock controllers on Qualcomm SM8650
platform.

This is a RESEND of V2 series.
Link to V2: https://lore.kernel.org/all/20240220135121.22578-1-quic_jkona@quicinc.com/

Changes in V2:
 - Updated commit text for videocc dt-bindings patch as Krzysztof suggested
 - Moved videocc XO clk ares to a separate patch and added fixes tag as per
   review comments
 - Inverted the logic in videocc probe to add new SM8650 specific videocc
   clocks based on SM8650 compatible string as Dmitry suggested
 - Used module_platform_driver() for SM8650 camcc driver
 - Updated driver name from cam_cc-sm8650 to camcc-sm8650 as Bryan suggested
 - Used qcom_branch_set_clk_en() helper to enable clocks in camcc sm8650 probe
 - Added Krzysztof and Bryan Reviewed-by tags to dt-bindings and camcc patches
   received in V1
 - Link to V1: https://lore.kernel.org/linux-kernel/20240206113145.31096-1-quic_jkona@quicinc.com/T/

Jagadeesh Kona (6):
  dt-bindings: clock: qcom: Add SM8650 video clock controller
  clk: qcom: videocc-sm8550: Add support for videocc XO clk ares
  clk: qcom: videocc-sm8550: Add SM8650 video clock controller
  dt-bindings: clock: qcom: Add SM8650 camera clock controller
  clk: qcom: camcc-sm8650: Add SM8650 camera clock controller driver
  arm64: dts: qcom: sm8650: Add video and camera clock controllers

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    3 +
 .../bindings/clock/qcom,sm8450-videocc.yaml   |    4 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   28 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8650.c               | 3591 +++++++++++++++++
 drivers/clk/qcom/videocc-sm8550.c             |  154 +-
 .../dt-bindings/clock/qcom,sm8450-videocc.h   |    8 +-
 include/dt-bindings/clock/qcom,sm8650-camcc.h |  195 +
 9 files changed, 3986 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8650.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h

-- 
2.43.0


