Return-Path: <linux-kernel+bounces-104303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0987CBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F101C223A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D21B7E2;
	Fri, 15 Mar 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l6nDnYbQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340B19470;
	Fri, 15 Mar 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501091; cv=none; b=CPEJD1T7ePAXL0v46gGWcBdSg9F3O6ItQddXfHnPOKtjXz+xHlMUOYuHgK0ULEpnQrIk/qgFTcCGiJmLoO14fX4P5DBY3QcGqAEY66mhaR263GusOOoIO4MScGjLTMeYGNFU8QiNimGY+HAsBCWbJxoJ0/nawVXQqHaOg8FC0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501091; c=relaxed/simple;
	bh=Vf+L7jw0hVdyWsY+RKzSYBH+cZo3YYxSFHIk7xqh0xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QmU+PZWlXUGdCBodN67ay/BiSPHH4bNjyA5MpmgORkVdf2ruMs5AhKJVaBYuu8Pa6WzviXcn43/ErjGy9rP0xnktVm2GJEj3gVjAsDbhD8feemhxyKm8ByYyKVav2rdILkma/XSN/JDQpmriIc0OWVblAGe9MTvs1VrBXBCMfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l6nDnYbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FArCZp030651;
	Fri, 15 Mar 2024 11:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=vs5TCj9
	Ay0TpFIyW+xfHqr89guPUxIhI8SgimdQNQUo=; b=l6nDnYbQN1jcABMM+HJ+fMI
	FJfhdK7eOA+cXqGP+OQ9gRNjTIshALP1gkE40j7JqN+ilvbVVHKP7VxxWdpOB/ev
	AnCvi0YAGLhMtv1TcqAsJZ8HUZD+80WLicQNxhdVJVZHBpfAq52Iq6zgcI02G0/U
	sQ7u+PavAIYjxwsnTMAd/lDlSziF6bC1HhUsDoHuAkztEeeFJiqFIfe57DSGAVuF
	FDVHaYLmPd5miL2DjdP9Q2UShWncfR7SGWIuRhJBOVmfsWJipGEXwE3VcSdgn3QQ
	l+YugzHXOcsfpnfBRT92gt4rm+PWqp5expyVsAqZ09YE11b/NzJOXm8Njx0+G6w=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wva0912w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 11:11:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42FBBA2t025931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 11:11:10 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 04:11:03 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia" <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>, Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V5 0/5] PM: domains: Add control for switching back and forth to HW control
Date: Fri, 15 Mar 2024 16:40:41 +0530
Message-ID: <20240315111046.22136-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: 9zRqU3ZyzwdigTryvmfD36Jwfw1omQAC
X-Proofpoint-ORIG-GUID: 9zRqU3ZyzwdigTryvmfD36Jwfw1omQAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403150091

This series adds support for dev_pm_genpd_set_hwmode() and dev_pm_genpd_get_hwmode() APIs
and support in gdsc provider drivers to register respective callbacks and venus consumer
driver example using above API to switch the power domain(GDSC) to HW/SW modes dynamically
at runtime.

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


