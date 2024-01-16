Return-Path: <linux-kernel+bounces-28341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2482FD14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96438292033
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6022319;
	Tue, 16 Jan 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="edYH7d1y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EE1D695
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443758; cv=none; b=HSlVwDBmcn0vhRVllc61zsnFzvGLzmmXb8MJx5BU/ZwG3pfp8jM17FnLLpP3Yg7hLNL8T2TQXuNg77dLnfkmmoKHNovTuzaTDU00cEqBftlT6rpudj4YKdw16HijkYJKqfDPJ6zOgxNSW8gEQHfYzaVu0J/MWS0ZlZWaQbbaOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443758; c=relaxed/simple;
	bh=sbxLU4K44Nbc78E8GhhYwOgfUA4LM4PzvW498gGHVXk=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=sJgiOJ2RniSw+zrNM9zX4hOaPXjcVfdQfLzKyVuBhoN4plh8mtT5t/NIA0Xgiy9/OPw05AR6OzqBW4xLJKsGNGL1Po1E5rTFGkgcYCovuObPqxIx5256llWQ8lvAyuNbB+WqA1lqqab57CRCDu900rTnhW6YTheTBvKiyi7rqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=edYH7d1y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GLL1mZ026373;
	Tue, 16 Jan 2024 22:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=7AV5VoHdOHUZxO
	DEMYQjLyEgyVUtFRZTLR40V2UbT/A=; b=edYH7d1yeTvorFTi2KppjnBohU9xe3
	vB8XUACyV75xtxEnI1DfuA0cqdWKWk7zSk3xmI2A7mwZ3z58D9iEfEdW6o5hSlyB
	hI9c8D5CGQkgF7oUni3goYhSQRkYUxE7hvImHEDfyAmfMTIYMNP9Bg4JJGJjm91Y
	X7qaGctHtvHZy4EAh3eLwrZ0ohKonSm60tKJilH7TyYXO5++SIK1J83goyj4abek
	kDl3kHfGp7QVu8UlFyqX30bHhmfi8wVb/mr0qECLtrZiV6CPY6ewxbCJ9Wi5noCb
	WiemmXR9E/KOZiG6z2+UUlTiIRnb86PTn+SSkFOxGqtGzigzeBgVV2IA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnvbj2c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:22:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GMMOVM031751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:22:24 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 14:22:23 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH RFC 0/4] Support for Simulated Panels
Date: Tue, 16 Jan 2024 14:22:03 -0800
Message-ID: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIwBp2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwMj3awq3ZLU4hLd4sxc3YLEvNQcXXPDZEOTRFMzc0OzVCWgvoKi1LT
 MCrCZ0UpBbs5KsbW1AH85X/hoAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg
	<sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <quic_abhinavk@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705443743; l=1781;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=sbxLU4K44Nbc78E8GhhYwOgfUA4LM4PzvW498gGHVXk=;
 b=Iiu5CRgKl4sCyrzbXTiUzle3E6Qau88ltJzDaSZL10ByoX4rjplNQLaDypmUyEjLdCzVRZ0nG
 3lo1c+EHTA4AHFzJl7ZTZu2NSqx8efNkVXGyUNHawQrRcYvolcHYi8O
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZoCCy9smX5TsYNCWEwZdheKzq5GFiTjw
X-Proofpoint-ORIG-GUID: ZoCCy9smX5TsYNCWEwZdheKzq5GFiTjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=793 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160176

This series introduces a simulated MIPI DSI panel.

Currently, the only way to validate DSI connectors is with a physical
panel. Since obtaining physical panels for all possible DSI configurations
is logistically infeasible, introduce a way for DSI drivers to simulate a
panel.

This will be helpful in catching DSI misconfiguration bugs and catching
performance issues for high FPS panels that might not be easily
obtainable.

For now, the simulated panel driver only supports setting customized
modes via the panel_simlation.mode modparam. Eventually, we would like
to add more customizations (such as configuring DSC, dual DSI, etc.).

---
Jessica Zhang (4):
      drm/panel: add driver for simulated panel
      drm/dsi: Add API to register simulated DSI panel
      drm/panel: Introduce simulated panel bridge API
      drm/msm/dsi: Add simulated panel support

 drivers/gpu/drm/bridge/panel.c           |  24 +++++
 drivers/gpu/drm/drm_mipi_dsi.c           |  30 +++++++
 drivers/gpu/drm/drm_panel.c              |  33 +++++++
 drivers/gpu/drm/msm/dsi/dsi.c            |   4 +
 drivers/gpu/drm/msm/dsi/dsi_host.c       |   9 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c    |   8 +-
 drivers/gpu/drm/panel/Kconfig            |   9 ++
 drivers/gpu/drm/panel/Makefile           |   1 +
 drivers/gpu/drm/panel/panel-simulation.c | 147 +++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h                 |   1 +
 include/drm/drm_mipi_dsi.h               |   1 +
 include/drm/drm_panel.h                  |   1 +
 12 files changed, 266 insertions(+), 2 deletions(-)
---
base-commit: 9ba3471618f1ab8df2f2689a34a505a72e05760a
change-id: 20240102-jz-test-sim-panel-71c14a56716e

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>


