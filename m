Return-Path: <linux-kernel+bounces-164015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD48B7723
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22729B23280
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B0173322;
	Tue, 30 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d5vgrh8H"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAC171E5E;
	Tue, 30 Apr 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483844; cv=none; b=VKU18nTrYY8/h8Vc+cRWfgqpUQQ3prpqs28Mx/1N2/4VqiZDX2LxujZUxnYImAqB36qpNjMvUyMIC8uxM3h2bzjdSMj1gr37LZopWTt6I5Ng8Z3Dvan+5CvEILbn92mmA8g3usU6VmECEFqkdMYR6UuZWeMk0fghy8bQeb9VTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483844; c=relaxed/simple;
	bh=+/1tN74/bcXEEiuu36KR17bXWEe+wNBm6G8d+3mw18Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nHRj74NyWD/JW9VFRZ56t5vh3vXNfwEIiX6073M6rD+j2DnF0DD9xQK1pejuIxIE+G9Zy98KoNcCefp0QMMDsrbXyGQgA4/x1H+1hjJL2gtyAOvZ8htE5Oe1SvD9Y8+xSgQuZDmThd+JIJA7wziM50MlCnq/Vq4pSguF0eBSAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d5vgrh8H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U9WOlX020866;
	Tue, 30 Apr 2024 13:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=iJ/iCYNZw53Gea
	ZCBTYgmIqnPwEEmiM8LeOnCeGWci0=; b=d5vgrh8H8xrIqT9t0FhwNEHsrrMJqp
	zfx6vSM+Z6RV7RcwmxyMyB3+KhCdAl6qgDpSkcCS14iV8CRrt3WebVGrmQLC/Gmy
	tUX4XI8tLMnLrY79T1EwhO4k0yazmRCgdoY6Z3Q3rwt3jPE4lUJLjwqnwI2Ny1Ct
	7RjI1SsW3oVnm5dwCWFmgQvtnrQH7R5V+XYJrqSQwmY1Z84vhLcUEdL7j3jmuRjO
	1vB2Xl5Gz8vp4UAbAy3DyxQ1iKjRlXLqGPENgBJUTCC2+bFj8tVHLQr0tUzDjAFU
	bx8kTaNUJ6L8AB8DP0XO9ZJRUgkhwC87Xhzbek7ZEBnJvtYt2H32lqgQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtm3ujfva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 13:30:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UDUR0Z021832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 13:30:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 06:30:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: ath11k: fix ioremap() leak
Date: Tue, 30 Apr 2024 06:30:19 -0700
Message-ID: <20240430-ce-unmap-v1-0-e468328f95d9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvyMGYC/0WNQQ6CMBAAv0L27Jq2FCSe/Ifh0NZF9kDBFoiG8
 HdbEuNxksnMBpECU4RrsUGglSOPPoE8FeB645+E/EgMSigttLqgI1z8YCYsRSmobKyR1kLSp0A
 dv4/UvU1sTSS0wXjX58Bg4kwhiz3HeQyfY7nKrP/qzb++ShRIpLvKirqr6vr2Wtixd2c3DtDu+
 /4FcKC4U7sAAAA=
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5v578cXIOiMblMVsysOFuOUqx15A15z4
X-Proofpoint-GUID: 5v578cXIOiMblMVsysOFuOUqx15A15z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_07,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=564 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300094

smatch flagged the following issue:

drivers/net/wireless/ath/ath11k/ahb.c:1218 ath11k_ahb_probe() warn: 'ab->mem_ce' from ioremap() not released on lines: 1218.

Fix it by refactoring the ioremap and iounmap code and then calling the
unmap in the ath11k_ahb_probe() error path.

---
Jeff Johnson (2):
      wifi: ath11k: refactor CE remap & unmap
      wifi: ath11k: unmap the CE in ath11k_ahb_probe() error path

 drivers/net/wireless/ath/ath11k/ahb.c | 57 +++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 19 deletions(-)
---
base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
change-id: 20240427-ce-unmap-3030e38ba1bb


