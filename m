Return-Path: <linux-kernel+bounces-143774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E88A3D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6360028233A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F54654D;
	Sat, 13 Apr 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JQu8t4a6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2345BE1;
	Sat, 13 Apr 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021693; cv=none; b=sG8A4C5hQcDy7+I2gFgaZK6+xPJ5D+c7zCoOsqaY39ctXr42Fnj0KNO1q2X7BBnpu7U9ygL42vSwqR6sog8WLvrgYACrwCEwtJSGGOG67+xdzeFaNHTnDm5ZsXONzV2u4w8mussveeKjhS2uT87vsqZYXnmCLTpsf/Ng9r5a6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021693; c=relaxed/simple;
	bh=yEWjbDnznVC6vT4NO/Xj3JDq3tC38KjlGRoMlOKXXps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z8gHuB+xB9Y67wFlcx7/QBr86ZfHbUCqN7flFo4hjkLQtTQcrE66rVqp7VQJXIBNiw8nBguZBBXyE7bWxlJQK8V5v6af8eXjzvAtw0W8EgaHDrM48LWamX/jjfo/CRW0LRdbLYfWw6SOcrd30vUP+hhFNPTBufxJKc9W6GBPUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JQu8t4a6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DF8N9f030225;
	Sat, 13 Apr 2024 15:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=v1nRL8Z
	DfgPlt89U1eI5XAv4EMOC/gfGb5BYwBW6vPk=; b=JQu8t4a655UPNQQ8dGlTmJP
	oQ9mY2FKlsgjA8ZrFGG9G9gnU1WOdagMFN1FjvjAdU/MJ38/a6PA3S14I3gWG1Hb
	C+brhU03ryywUQxJu8DLtVwr/hZ3BVDxkUUcwc/1ILZeppcClqEt6JOg2P5yvsQx
	fuw1bvSdpRu0KIcgFLJRdT2v6u+m3limXExyI5tanwWfxHjXxCnLVwvT8TGBzSpf
	Q4XrVcY0uOI9K8QHHem5vdxNtqKUs8W234VL8nLQIvHgNzHyoKcN0ZGgV3xcridd
	Wyx2HTEamHfdjKf90GR0h9xksqjm7FwrYjmonR9qyQFfER1ZLB+zNjqaDlbmaFQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfh2crnw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43DFL8uV007731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 15:21:08 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 13 Apr 2024 08:21:00 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
Subject: [PATCH V5 RESEND 0/5] PM: domains: Add control for switching back and forth to HW control
Date: Sat, 13 Apr 2024 20:50:08 +0530
Message-ID: <20240413152013.22307-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FAzFLGXG3OsMsDAkOAIwv7xrlrnCVhrp
X-Proofpoint-GUID: FAzFLGXG3OsMsDAkOAIwv7xrlrnCVhrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130113

This series adds support for dev_pm_genpd_set_hwmode() and dev_pm_genpd_get_hwmode() APIs
and support in gdsc provider drivers to register respective callbacks and venus consumer
driver example using above API to switch the power domain(GDSC) to HW/SW modes dynamically
at runtime.

This is resend of V5 series, added R-By tags received in V5 for 1st & 2nd patches.

Link to V5: https://lore.kernel.org/all/20240315111046.22136-1-quic_jkona@quicinc.com/

Changes in V5:
- Updated 1st patch as per V4 review comments to synchronize the initial HW mode state by
  invoking ->get_hwmode_dev()callback in genpd_add_device()
- With above change, SW cached hwmode will contain correct value initially, and it will be
  updated everytime mode is changed in set_hwmode, hence updated dev_pm_genpd_get_hwmode()
  to just return SW cached hwmode in 1st patch
- Updated commit text for 1st, 3rd, 4th and 5th patches
- Updated 3rd and 5th patches as per review comments received on V4 series
- Added R-By tags received in older series to 1st and 2nd patches

Previous series:
V4: https://lore.kernel.org/all/20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org/
V3: https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/ 
V2: https://lore.kernel.org/lkml/20230816145741.1472721-1-abel.vesa@linaro.org/
V1: https://lore.kernel.org/all/20230628105652.1670316-1-abel.vesa@linaro.org/

Abel Vesa (1):
  PM: domains: Add the domain HW-managed mode to the summary

Jagadeesh Kona (3):
  clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
  clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
  venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on
    V6

Ulf Hansson (1):
  PM: domains: Allow devices attached to genpd to be managed by HW

 drivers/clk/qcom/gdsc.c                       | 37 +++++++++
 drivers/clk/qcom/gdsc.h                       |  1 +
 drivers/clk/qcom/videocc-sc7280.c             |  2 +-
 drivers/clk/qcom/videocc-sm8250.c             |  4 +-
 .../media/platform/qcom/venus/pm_helpers.c    | 39 ++++++----
 drivers/pmdomain/core.c                       | 78 ++++++++++++++++++-
 include/linux/pm_domain.h                     | 17 ++++
 7 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.43.0


