Return-Path: <linux-kernel+bounces-99786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA8878D53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA21B2252D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84866C126;
	Tue, 12 Mar 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gH2Jahpy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453CEAD2C;
	Tue, 12 Mar 2024 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212387; cv=none; b=iOC4hS9LNYWdweOKcmTi7Cr/mmZSBkP7cA8fkSpz40g88RwTRlP91eD2omnRqIzyB0RJC3Q5ay/m36KE4TO5Wc9RbQAKZjR1shQPyXQGqrmqnigEegFjTKoTg89fnhh5BRyxjLBfmVcW6HfXvqmthNkvRcepVyUSx7Lt3LiEjkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212387; c=relaxed/simple;
	bh=CyGSZP1XOFjnHMrVIYDgFQRqx6joD5x/twTCbR4mCqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suS7gie/bOP/ET+iVwp5pYQkuKq4I8Z2PMbt0BsaWbwaTh+BViRgUsrEIBWqoWkGyXsD2ipnDCP2zokRzXaDkskZ+V15AxHRLTmuRkN953Nt9olXi36IBPfkCu85tO1z2fhrNWMeQGTAk6nv4yA1cpHO4vg/rFlIi0Nzj0cYZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gH2Jahpy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C1JvOG026568;
	Tue, 12 Mar 2024 02:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=qwgcKyxxNrM3hvUNTPSw
	czGQawYSanWFy86dPb/n5F0=; b=gH2Jahpy5Ut7TrPFOTWZke/l+1ZsvzE/Bmry
	QSbQZ5BPHL+EiFtoe/uR6K2uu4S9sShhhGt2/NdzCe/o1SrfgJ5Bkf2nLvS7XNIk
	Z2bEkASpX/saiT74Ldf4cIYxqXezTAB7D0Od2G5MduoUe4S73LOnTMGDw4YcbRV/
	fCow148Y+hgbTbF0EW0PcZROwv499WR31MF3MjV73tJ42aTd9eBAN+r2P/O+pUOz
	cXeZFhw767b0MkR4+HzZJuaK2tCnvLcrOJwsDQihucDXcsht/UxFPyA9GffF73Nw
	3Tli0vRJ5HxnsnewjlMltuBtrXOXq2kJV8d3yUSkIYk2Z7m8iQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wt2b0sq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 02:59:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C2xgJC032355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 02:59:42 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 19:59:36 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: update compatible name for match with driver
Date: Tue, 12 Mar 2024 10:58:06 +0800
Message-ID: <20240312025807.26075-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240312025807.26075-1-quic_tengfan@quicinc.com>
References: <20240312025807.26075-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZS8LC1ViQzyznfFkfQHcOwl9df3eT6v8
X-Proofpoint-GUID: ZS8LC1ViQzyznfFkfQHcOwl9df3eT6v8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_02,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120022

Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
to match the compatible name in sm4450 pinctrl driver.

Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
index bb08ca5a1509..bb675c8ec220 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
@@ -17,7 +17,7 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,sm4450-pinctrl
+    const: qcom,sm4450-tlmm
 
   reg:
     maxItems: 1
-- 
2.17.1


