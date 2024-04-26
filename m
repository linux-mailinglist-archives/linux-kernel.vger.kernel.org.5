Return-Path: <linux-kernel+bounces-159532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B428B2FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D0FB22780
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F013A412;
	Fri, 26 Apr 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QBv3TZ7k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE213A3EB;
	Fri, 26 Apr 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110818; cv=none; b=nwk+xHOZsZ6xx2YNlyKy4L/WOlLgtaoDfmYc6K+Dt1bLE7sGyFdnrDM7xnjJp27Z1+6/N2/HWcRZaZm0tGH2f3FcePOnnQPI2sltcpSeyP6N6DYmnB1Xa3xxsXPl8xa7FRMFkHfPgNozvbv8AqsbrqF/DQroEkELoFcM7EPZxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110818; c=relaxed/simple;
	bh=fYZYhM90ZOghJXsmCvdMyR6vyGr8zbnxtkaiH+woRBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQtDwaGBqMcaFkyia8mgOVLHt81Sm2xCHNPr9sc5oBwpbZpZ0T2TO9igkDJKBy6cD+itjCYninZbFTKR9ziDK1pi3wqxHhq/EyARBrgcuksastQEq+adAt72bMYg8VFAxn6dXlbEqIwv2fIVWrzDgP6w3d9b06szWuBlgp9OG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QBv3TZ7k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5Ji0j013674;
	Fri, 26 Apr 2024 05:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=z5d2Nv4
	1ZA4brUUmtvK/zgXGl+RQxorA99ASbCkjfIE=; b=QBv3TZ7kma/HkhhBOVqtaRp
	uXeArH+qhZLPSIXCnPfn8M+cCFRnf79w9IgdkS4gu9TSxd0UopbZd+ehXcjVzZ0v
	4ZieL3eMByQVIoH6oMCWyNaU0b6/9bosYUIWkcGpkTmFP3z5aGDe5AhzodlApVoo
	ntwL0iLTqykJxD3K3peJ47lcw33SkBeI5B47IaUUUOu/NENBjTwRF5rVNtPxB2Re
	sLl/FVDrCODzbffAEI8KcPCvgddtEWHp1/fbx7JClAeED1y2tpu5ijqKsk2woO3q
	iYrzkCx0Uf6Ml7E9sWXuG4qub3sU7g9OONzuynCwJL+m5IDsk+kvzzjVvfz8Acg=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr611g6bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rTmI002289;
	Fri, 26 Apr 2024 05:53:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6smm8se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rTWY002272;
	Fri, 26 Apr 2024 05:53:29 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43Q5rTpQ002255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:29 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id 2977921381; Fri, 26 Apr 2024 11:23:28 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, jassisinghbrar@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lee@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/6] dt-bindings: mfd: qcom,tcsr: Add compatible for SDX75
Date: Fri, 26 Apr 2024 11:23:22 +0530
Message-Id: <20240426055326.3141727-3-quic_rohiagar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: q_qkxaJUDsqy3msfQp38ZTfKrfkWFwIl
X-Proofpoint-GUID: q_qkxaJUDsqy3msfQp38ZTfKrfkWFwIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=943
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260034

Document the qcom,sdx75-tcsr compatible.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index b97d77015335..c6bd14ec5aa0 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,sdm845-tcsr
           - qcom,sdx55-tcsr
           - qcom,sdx65-tcsr
+          - qcom,sdx75-tcsr
           - qcom,sm4450-tcsr
           - qcom,sm6115-tcsr
           - qcom,sm8150-tcsr
-- 
2.25.1


