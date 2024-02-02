Return-Path: <linux-kernel+bounces-49074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B6846591
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B0A1F23A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B2C155;
	Fri,  2 Feb 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AEFmz3wU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CA8BED;
	Fri,  2 Feb 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838540; cv=none; b=QQcS4hpKMxucRH2vsQVBetyZsH+Ui+SjwTxrLioEO4qYg92gJcD/PynWm+AP3kqgInTB4VnoK9hAWlx+60Uw0wYm6iU7C9inrAKa+e54q1xCEh2VxzwNYrraHi8Moi3ZPYD0ols4267ysY+IS3uOx/muG5ISgPm4gj0N0x5SVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838540; c=relaxed/simple;
	bh=gW4MhsWKgnrV0MWLgY1KwNTmPiN5rKAzTznnQ80tRSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eBps6cTYJjZ4vhTxggvN8aSoRjhI6rPwaZ7x/e57PG+Y7+eOKfMs0kuOQ4jueG3aTnX7uClC6V7bP6O61dJabPXrtltzx+/iL8Ebc03kpbqo7z3xIqz59ixXka3mPA1iaNtpA/OEVExM+fS4NaIyiH0dPjZdeeUKtE6geSw90rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AEFmz3wU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121caew025491;
	Fri, 2 Feb 2024 01:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=qfBOkfPzPc+LRVy3VtHCZAQg+VPtonGAka6/GiikkEc=; b=AE
	Fmz3wUG0lIk64CYnACvQpEwbz6+zzt9lYTgHuPhZlqNj1LADDhUkZtUcXxQH2fV+
	KoIrne0v04SnrUUNCMcYBIbwjfgkSFSIg52OhA4/XZMeXB60MMJiFfaehmX1b0pN
	m8m0v8gIMSx3MTWhy8XrOFzAz9KMAuH4/uhxDdyB5tJQNr4kFAEW6nFVEZcaUnGL
	lNPPzlwFPiuhY/w2brQCmTmiYUmBYQ4FZqTHTmpkIqIoix2oIWmEc6KxyUfveUb+
	csaA5573d7TrOsoWzveRkQK1y3JR1/3wDXbkHgOQd8IgZZbmpn7RMZRH+EjD8J1V
	WcO5V6JvhuJSLUvJxffQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwjg0f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 01:48:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4121mqV5003112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 01:48:52 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 17:48:52 -0800
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>
CC: <neil.armstrong@linaro.org>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH 0/2] interconnect: qcom: ACV enable_mask fixes
Date: Thu, 1 Feb 2024 17:48:04 -0800
Message-ID: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mGi2LD7B-CegqP3BHrEE2L-7m6Cz5IEP
X-Proofpoint-ORIG-GUID: mGi2LD7B-CegqP3BHrEE2L-7m6Cz5IEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 phishscore=0 mlxlogscore=591
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020010

A couple small fixes for targets using incorrect ACV enable_masks.

Mike Tipton (2):
  interconnect: qcom: sm8650: Use correct ACV enable_mask
  interconnect: qcom: x1e80100: Add missing ACV enable_mask

 drivers/interconnect/qcom/sm8650.c   | 2 +-
 drivers/interconnect/qcom/x1e80100.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1


