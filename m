Return-Path: <linux-kernel+bounces-60205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0A85016C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4A51C21CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECB210D;
	Sat, 10 Feb 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JlwpXcht"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881791FB3;
	Sat, 10 Feb 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527676; cv=none; b=Y5tPpORPUkI2S7Q9u013fcxMHpNrsw8E4Z+OQ/r5SYN1TQEADyGAsZCBlHfq2PleNLb8Sv0mR2z3YRvo2zJv8EWzaeRlfo+RqPtb8J7KzWUZWrP7FhXM6x0UTdeJYBpOj44EQGXCOoox90uuUG1J9jsW0l9SeGSfJaDzF2wcIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527676; c=relaxed/simple;
	bh=LPf6setH9WEOkCjciKfgUU5wH8txXxqhbaBTC04gmSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZI+KOb8jgSzk0AtGRdtugyQ74MuBnCNtd43V4AaIXVPnk+3Jv2EjWH7vt2NRt0hdJMpqHsdEdkTz9v5MChrtU7g3PHldm/TpNiTR857cluKOnN7jxne827wzII8WqMBHrbpq4qQAHXnbk78WN2fKnYz72t33fWmos1FG9n/7rmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JlwpXcht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41A18UF7017880;
	Sat, 10 Feb 2024 01:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IeTSwMc
	8UI7TSis9jWY58rowq+KOqu90WsRTs09DlDQ=; b=JlwpXcht8PHkVk2i8qt5EIh
	uUu5yqVBQbq68+nvD9VS3d2iVY/QtT0w1NBimcR79g+C8bq16T2Is8pG66Z6Xm8M
	IJYuAoYftCC8div5LmxBYF55L9mYRvxsJXaLc70vyzZyMRGcZBPfHV/AqqUDhbgh
	sT0j1I6gA169tG1+6x18kY0ClE/a4LgaMvNemGVmHWROgLSFJVdwveBArT6rSYIT
	rA1K1qlBg06zURms93aHAOcp8iP/CroZwftIJhfeSob2Aj5+ahBFFZADx/B17Tee
	ebpWKMqIpmMtF0f3Kj+Ynnr/iPNHpDuRsMa3NhLVl11UpKWmi8vwC/r77Wctsdw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5u2k8dng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 01:14:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A1ESAN016768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 01:14:28 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 17:14:26 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v2] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Fri, 9 Feb 2024 17:14:15 -0800
Message-ID: <20240210011415.3440236-1-quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jQU3TXkvaYKW6hh6zZD0x4D7LoWYTr8F
X-Proofpoint-GUID: jQU3TXkvaYKW6hh6zZD0x4D7LoWYTr8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=991 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100007

Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
introduced a new 4.1 if statement in llcc_update_act_ctrl() without
considering that ret might be overwritten. So, adding return value check
after Broadcast_OR register read in llcc_update_act_ctrl().

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

---
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


