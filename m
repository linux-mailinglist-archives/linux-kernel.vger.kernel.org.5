Return-Path: <linux-kernel+bounces-62194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B0851CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983281F220E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BDD405FE;
	Mon, 12 Feb 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OT8S7QNM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E223FE24;
	Mon, 12 Feb 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762933; cv=none; b=g32SiPHAJ+nXnXEBjPAoikBgjwxrnr0gF4STYvg/vczRqSet4Ebv5F2Rv66DDPUSDYlftnDumcSs5GaIfb29gA/qWxEY5nDhCWIen5WOllJEri4jLEwYQvrEQP5kU9YbZwnXGx0ktjzEhvndrwZKD9+HQa0GMWIBjI500t84mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762933; c=relaxed/simple;
	bh=U/7Lj3FWbjI2GjLaSoK/nsKWyLH6E74rVAh9DUsfCWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LPPsutqwtqVwBYFGox7UXyUJ5MgfTYUp+oNZmVTaLaQdFQv0mDc35De9zpvEpJVfdrAcjKBFZ7aMZ8DXSXIwdXUVlcmeYx35gJpe7c5rWCGjChonnBhVw768p/Rgt+ZJiwLq08O+41jsoRjL3mTOTP13tuQFABIA0k7wtJIMV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OT8S7QNM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CCZTOL021818;
	Mon, 12 Feb 2024 18:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=GS9jj+f
	pf7KW1J3SmhSNAEWkbpmxAkYxeZmABJ8VC8g=; b=OT8S7QNMjhq1nu5Xihb2fXL
	N0U0Mi+WDYo8ukNkuO4D0GK5DeMyTPmK8fbOuE1fRk9ytyMq1pXQ6E32Tjsl92Zn
	pBn1bTZ9DIQGZJ2Qlbukhb3pSM3pJ9N/uPqPNb2hs9oByPRuf/wDdR1Ms4WaTC1N
	mxk06pS5GEhiuleeWOgdfCw0Hqp2PDZQEh4qQVKM/XTNkdS45/njKf9Ngo+OT8E/
	07hg0g9+i0E5ieYSxVoNSl9A6JxvUoxWUK+zHoIShz30Ch52MExsbB6t6uGlt3ux
	dakPt9P14C53+YQoYYYhx/ujTTAEOO32vCqcotUNJxj5u7B32KaokZsqrFG3JsA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gs1h7vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:35:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CIZRn9002336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:35:27 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 10:35:25 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v3] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Mon, 12 Feb 2024 10:35:15 -0800
Message-ID: <20240212183515.433873-1-quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TfFY2h6r_-O0FiK6uGWN5bkyufH-d0kP
X-Proofpoint-ORIG-GUID: TfFY2h6r_-O0FiK6uGWN5bkyufH-d0kP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120142

Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
introduced a new 4.1 if statement in llcc_update_act_ctrl() without
considering that ret might be overwritten. So, add return value check
after Broadcast_OR register read in llcc_update_act_ctrl().

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

---
Changes in v3:
- Bunched Fixes tag with other tags.
- Modified commit message.
- Link to v2: https://lore.kernel.org/all/20240210011415.3440236-1-quic_uchalich@quicinc.com/

Changes in v2:
- Referenced right commit to be fixed in the commit message.
- Added Elliot's R-B tag.
- Modified commit message to better explain problem statement.
- Link to v1: https://lore.kernel.org/all/20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com/

---
 drivers/soc/qcom/llcc-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4ca88eaebf06..cbef0dea1d5d 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+	if (ret)
+		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
 		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
-- 
2.25.1


