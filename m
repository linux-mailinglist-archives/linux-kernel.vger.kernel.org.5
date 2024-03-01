Return-Path: <linux-kernel+bounces-89154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8C86EB49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA71C22AD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7958AA4;
	Fri,  1 Mar 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HC0dNcrz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13958233;
	Fri,  1 Mar 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328972; cv=none; b=YmhZhq1swwDLKg7U5GbbISr+W8vqmV69NeLmIq4s3Ugr0CD5cD48jvH+x7nc6Lvw0jOANJXg/L25rcYjMEvot50VxPhCTc7zaD9j99YA0U6aAqtvFmrRl93e+8a1kdUZ2IYYiVks8I3dkahgJlmE7bNxKvqKbKOx3i43MJaE7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328972; c=relaxed/simple;
	bh=0az1VC4sD/n4/GO8CNZ8u5Vg3XPjNeGY9Kyii+2If+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZhWHMFpF+cnKUDayZTM5qQzh2uGtUTYOmYa/i8qIW9Fl3ZYOkszfrfHUfyJj1DiRDFMq0C2wHJ35XYHijmmfcm74h/EjPJpvv+Vz5FZD71QjeZRtKWWiwPrkDfl3n/aJsPZXCqDZQUx1ekTDYAijHvUUQaRWCAoz/5MiJXMqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HC0dNcrz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421KnpE7010522;
	Fri, 1 Mar 2024 21:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=xdrEsoDH1wlMg499jUGmzc1UwnuvbPZGoH8tSZVaIO4=; b=HC
	0dNcrzeUoW2/k8hsoXtdHEnDOqyFfIIwK5Zh458sGAWzqPbbt4xbY0VRxH7GcTpk
	JNag1FpENP/Y5uTSBeGUJcNO11UxSvs1oYLOVdlkbuJ6y9sKKiJlXYPS29QY5Qqh
	uZ5DIDxVbC7gWrec+b8zInq73HSkWcl+PY/E1lzGK2VgG3jDC/vyu07CSExhL+SL
	/jbHRMAwTz6Fktmag50gJBml+JvITxc5ApgKVNU74MGkf1LM1EZsuvNEAJ3ebSpa
	2yIXgcQS8okOcEhVas00CUmAiJpigBjceUVpm5hvYU8E9TcGzr1a29vVNR9Bc95G
	fKhpuyqRp8LVxPhOdGZA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wk9mf21cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 21:36:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421La5HS012836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 21:36:05 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 13:36:04 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Add DWC31 version 2.00a controller
Date: Fri, 1 Mar 2024 13:35:54 -0800
Message-ID: <20240301213554.7850-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VYFQhl0C6CqHyCnB2qkfQgEWL2b73SnP
X-Proofpoint-GUID: VYFQhl0C6CqHyCnB2qkfQgEWL2b73SnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=892 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010179

Add revision value for identifying DWC31 version 2.00a based controllers.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df544ec730d2..f3bbbc1947bd 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1259,6 +1259,7 @@ struct dwc3 {
 #define DWC31_REVISION_170A	0x3137302a
 #define DWC31_REVISION_180A	0x3138302a
 #define DWC31_REVISION_190A	0x3139302a
+#define DWC31_REVISION_200A	0x3230302a
 
 #define DWC32_REVISION_ANY	0x0
 #define DWC32_REVISION_100A	0x3130302a

