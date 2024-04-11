Return-Path: <linux-kernel+bounces-139694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF618A0690
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111271C22517
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559B13B789;
	Thu, 11 Apr 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U2UqyohN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771E23BF;
	Thu, 11 Apr 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805339; cv=none; b=jtFV9HNj28A4w2ud+lRBLswPy8lSfANTolU6mt/CLIst4KepGKAkniHYALLdUzuPXiEARotYRs1yS8eS/g1t4eWfpxnPbiYahrU9SuqkBQ9q90/2HlRIY/oHzM+3C483nksnL6DyardDfsZn7p7tCzA1kjfiA+/OsKDcUyeSqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805339; c=relaxed/simple;
	bh=k7bJjv4Czmo4cxqrTSoKS1JJYI9xhBsbNr58H6WlT6E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=q/1gZ9AjgSyoc9hqPse1TTFx91iQvaln0hTb5tCm5Vup+YSsfcrSqDc+C6TNPbABu/czYqO2ShsytfFRTG7LPnlUPJOqYhvfZ2ehNFHQ4vQGSAA3R1Gf8WwQOJ560928QWiurWTiwTRDSx9wxe7akZW6S29HiaF+SqQoJwKEjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U2UqyohN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B2LGsb009463;
	Thu, 11 Apr 2024 03:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=t51WvI2Qx262
	LLAouhMk5thtN1jp3w0RJoVx+37/Lik=; b=U2UqyohNkguJ1c0fRCeOhFqIGpWx
	28USloHb6pcjo24BcE6HDOLg4fghRowCVQSNrkn4NS81Clo34N3i542zv7qpUSQq
	xkTA2gIxEfDVnfqp3pLU54Qfxb+lTV98qa2hJIyz/0eI3yXmWIFrlo1NnE8+4xSa
	jaPbV+ct7JpG6pjQK3AL1wT+89bPIYEage1HpJUa1HHRTwWnsHs45sP2vVdHK3d0
	siwR99FPd17dsc8kGsDIWuReuSNGyPQMHugxqSbwaPNOMv6VpSTi3Ghg3UGxDMg9
	GxY5bx3n/ObJACUxO7GmL4o6/XoYSz8DILRfDY3H+OXaaCoQkvHhNEi5FQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdrkpbgss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 03:15:34 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43B3FW2M018361;
	Thu, 11 Apr 2024 03:15:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xayfkm15r-1;
	Thu, 11 Apr 2024 03:15:32 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43B3FWWa018354;
	Thu, 11 Apr 2024 03:15:32 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43B3FWt9018352;
	Thu, 11 Apr 2024 03:15:32 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id AEE4F5ADE; Thu, 11 Apr 2024 11:15:31 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 0/2] Add sysfs entry to EDL mode
Date: Thu, 11 Apr 2024 11:15:27 +0800
Message-Id: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5rf8oENyhlxQRjD4OekFLk_UZHJ211rj
X-Proofpoint-ORIG-GUID: 5rf8oENyhlxQRjD4OekFLk_UZHJ211rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=639 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110022
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add EDL sysfs entry for mhi controller that provides edl_trigger callback.
Add mhi_pci_generic_edl_trigger for qualcomm sdx55,sdx65 and sdx75 as
edl_trigger callback.

v1->v2:
1. Move all process needed by qualcomm sdx55,sdx65,sdx75 to enter EDL into
   mhi_pci_generic_edl_trigger() as the callback to edl_trigger.

2. MHI stack creates EDL sysfs entry to invoke edl_trigger callback so
   that devices need different mechanism to enter EDL can provide its own
   edl_trigger callabck .

Qiang Yu (2):
  bus: mhi: host: Add sysfs entry to force device to enter EDL
  bus: mhi: host: pci_generic: Add edl callback to enter EDL

 drivers/bus/mhi/host/init.c        | 35 ++++++++++++++++++++++++++
 drivers/bus/mhi/host/pci_generic.c | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/mhi.h                |  1 +
 3 files changed, 86 insertions(+)

-- 
2.7.4


