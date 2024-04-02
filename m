Return-Path: <linux-kernel+bounces-127743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23489504E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1961A1F26D65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668479DD5;
	Tue,  2 Apr 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XieKtHxR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EE79B9C;
	Tue,  2 Apr 2024 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054084; cv=none; b=XREhhCUfOYpN9uRzcfPAcgGzeE6j0Ao81KXoEAvECEE/NwnZY8tl6fohfuJXYlFpHXtFR7nSMQEb3WmAr7+IiKGzJb9DYQ2K535qj+wKfKjzyc6+Xha4s/yUlbSx+2tvkMe8OTp8QUYaEgvB3h7h3XL9mkP6F4gFoYUKY1OTgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054084; c=relaxed/simple;
	bh=UK5tqz/yJW+raSfi/Vs6WOqf/KWWgFrcK3SYjYT0FQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P78iCKWeqXsKFlQQMqakJKLRe0OhDMFawXEAhh1ec/LqTSkqtCoJifOg/0M9rvbmywPUBsFYxOLZ9hKD+1HPApSCnAhvThWm9vo0Tc3A5qrmZE7cDM9glEL/odPuzMiLzZmFclVBmuyGt2OOiZoXsVwkDj9D0K9rrdocEAczG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XieKtHxR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4325RL0f008482;
	Tue, 2 Apr 2024 10:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=pm1ddIko4xELmIhctBa5jgXT+YGO6UN92PjbQsy34nU=; b=Xi
	eKtHxRg4h3XuToqAL/sZGzDhdBUKBO8NwPuMfEuPnnrr+4PUlDcVmwl+lmAUx0Sz
	HpcmFuU0LFkLw/SJ2UXbwC++NR7JRAlqBEMecZNRn3FzZLTv9pkJQ9oIvOhxySno
	iyLniKau2rxZdMJf/l0CSRt6eQzVJAoye8rOlMcdEjj01pWnSLJolxP6ado4nJsb
	t8GYjO8lJpVqpEh3Q7byWR5LTeYsjYUNJMka3wS6hnDCwqUElc0hDLn7GyX14zFq
	1/32El5sSe9Cml2jO9oMfKDrtOfTmWm+NsTKNDMdAvkaD24ppv1m/+gG/+1XOjL6
	4WyIvE8NJGBLb8VEVGlQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x85h8hbhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:34:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432AYZ54022056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:34:35 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 03:34:30 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_varada@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH v6 2/6] interconnect: icc-clk: Remove tristate from INTERCONNECT_CLK
Date: Tue, 2 Apr 2024 16:04:02 +0530
Message-ID: <20240402103406.3638821-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402103406.3638821-1-quic_varada@quicinc.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RHLt1x75LZT-uKFCCcmhCB_22Gpz9Ymu
X-Proofpoint-GUID: RHLt1x75LZT-uKFCCcmhCB_22Gpz9Ymu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=849
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404020076

drivers/clk/qcom/common.c uses devm_icc_clk_register under
IS_ENABLED(CONFIG_INTERCONNECT_CLK). However, in kernel bot
random config build test, with the following combination

	CONFIG_COMMON_CLK_QCOM=y
		and
	CONFIG_INTERCONNECT_CLK=m

the following error is seen as devm_icc_clk_register is in a
module and being referenced from vmlinux.

	powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
	>> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'

Hence, ensure INTERCONNECT_CLK is not selected as a module.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404012258.MFriF5BV-lkp@intel.com/
Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/interconnect/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 5faa8d2aecff..f44be5469382 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -16,7 +16,6 @@ source "drivers/interconnect/qcom/Kconfig"
 source "drivers/interconnect/samsung/Kconfig"
 
 config INTERCONNECT_CLK
-	tristate
 	depends on COMMON_CLK
 	help
 	  Support for wrapping clocks into the interconnect nodes.
-- 
2.34.1


