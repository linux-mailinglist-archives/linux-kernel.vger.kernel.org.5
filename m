Return-Path: <linux-kernel+bounces-159536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E648B2FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E290284903
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAA613AD22;
	Fri, 26 Apr 2024 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cWttIxOq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9D13A276;
	Fri, 26 Apr 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110820; cv=none; b=ZfY3lUcTcJJu4etJOdaGPKwWQY8Fo6D54oJUy57wJ959dtxoYS2hVnyuOkwrNR3VKsMJtk6sao1FsyYtxxQ3ZlPcgNducfZVfjlO+GfTUU+zWeu5UB14wdc/JXS0slxit5OkqJBpZwAsIEjfU+XgLntvwg6HlX5DwX5xNOC0CPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110820; c=relaxed/simple;
	bh=mrBd8ODAIL19DBCo2Zx0mfRuU/nKMplSmVRBskt/cwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAXV5PhremLvavZ6uEwvYY1rrPzhhRDw4qMeZ1UoxHgvEvDt5Y59GujtwHTifppFUJlXPJ7FvlWNh4IrFzuC1Phtm/zxGR258dUnf1gyZjTae4fyilO5hvHFpp7jwPErvtLrc07ydtYs/C2RsQ0TUMTKesapaOpfeGfUgtY4A/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cWttIxOq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5JBjB013416;
	Fri, 26 Apr 2024 05:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=FBcRhBn
	ogMAnKmZOpJbqTF0+KC/G+Yb9iGb32WGIS8M=; b=cWttIxOqJ7JrFxtHFAm67dj
	PzMIgSHQ0EOhOpFNiTmBX9Dvj36MPBFMjLmEp745nuTr8r54LaV8V7vUurnQHZYr
	9cvgu9IoITWVc8nAJ5p6hmCLTqo6kckuMz2GNp1qzqVOa66rth6Q4YpNfgSk29mr
	K6eNPHnNYViqANgoTXfisPFG+FaAzfsh8NDmefEycSh7JYNmPdS8ZDK+LyQ19EhN
	cGlrdBYprKL9XGe2Wbo+892tYM+KAtjeQJWx9HFXkD9H9uE3EVVHCDSKs4fapi8n
	9UXSIWeodC6THEbxTTiHaV82j5EdMO74MhFYWAk6fcTnb7lbLvwkczFzzRZPiMw=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr611g6bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rT0d002280;
	Fri, 26 Apr 2024 05:53:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6smm8s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rT7T002259;
	Fri, 26 Apr 2024 05:53:29 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43Q5rS4M002252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:29 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id E2AB62135C; Fri, 26 Apr 2024 11:23:27 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, jassisinghbrar@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lee@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/6] dt-bindings: mailbox: qcom-ipcc: Document the SDX75 IPCC
Date: Fri, 26 Apr 2024 11:23:21 +0530
Message-Id: <20240426055326.3141727-2-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4szGW7ZV0wubfIBPB5TSijb2HhCSjbka
X-Proofpoint-GUID: 4szGW7ZV0wubfIBPB5TSijb2HhCSjbka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=904
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260034

Document the Inter-Processor Communication Controller on the SDX75 Platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index 8f004868aad9..05e4e1d51713 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,sa8775p-ipcc
           - qcom,sc7280-ipcc
           - qcom,sc8280xp-ipcc
+          - qcom,sdx75-ipcc
           - qcom,sm6350-ipcc
           - qcom,sm6375-ipcc
           - qcom,sm8250-ipcc
-- 
2.25.1


