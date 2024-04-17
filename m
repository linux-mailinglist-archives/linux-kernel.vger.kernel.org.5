Return-Path: <linux-kernel+bounces-149206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C58A8D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6379FB23EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3D4597B;
	Wed, 17 Apr 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V0xSyOOE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE71E869;
	Wed, 17 Apr 2024 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386638; cv=none; b=teZMjJEMtNzjgBgful4youM4QZjANXzguVQE9jOm3PQX5j7PZ4hOjPCV0xAmivEiJnODpHWcUXDBuPCgXWstmsZD4LOGbX2SUs3AQmG+G05AiN3MsP/IQ/IcmUCV11pqMX0xfCVxs5a7xU0tfzlX62ANOQ/faCzLsTxH+IEgQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386638; c=relaxed/simple;
	bh=RFdfTPrCdo5JYtaH5+c+QBleeNATgkNP4Fi/PekgmDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYwdNA+RPs/9dt3ELbyEUaLzSPn8W3Jdg0G4X8B/DvHpNRVWDs6Ka8i4aW5TLPjDpWFgJO8yfuecL0PVBs8meINCtjR8ETIxAfB9r2bAoIc6UvTaNw9lroushSDXjU+8Yg4qOmu2P4HokJqOLqm4zLzhoKmDLXnNAq1BQaravyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V0xSyOOE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H9RBw8032455;
	Wed, 17 Apr 2024 20:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=bksAM5LfzRPTnZK1CiAZW
	4aNgo3gG+ERZSqsHHRU/n0=; b=V0xSyOOEQvde8PhCrhO2/bd5wrMVo4CSv0ERX
	LUdgjM4F6+wyb5xLJYEsFexL8chuXOJqJShJ1Lhf2ykBJC+jViSmFKF1znm+kZbu
	LhORgBJfCKqd4gsHS29W+rs8voY/9ikruSu7/SUdsOoAB7MZItl0TxFKiPetlWFU
	QPgAr8PI2ZA5R7pDIsTmESjzONEmK4gSjM/6rBnByegpBes04piMcV13baTSXzIw
	5oA1/Ug2WmJ1ybSGWWHweodTWdlbRG1Rv/cKgOQEYyFC/lbUJK7j5eTTu4GjYNGP
	7Djo0v6iDnsO5rU3CpPsbeWSo6Mm9039se8ZVurib24M6CfEg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjbt5styg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:43:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HKhohQ026373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:43:50 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 13:43:49 -0700
Date: Wed, 17 Apr 2024 13:43:48 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 1/5] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
Message-ID: <ZiA0hOkpGVlVFp5u@hu-bjorande-lv.qualcomm.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
 <20240417132856.1106250-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417132856.1106250-2-quic_sibis@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gjCqTYrt6LHKxzh41xzT_8GeSONsXMtQ
X-Proofpoint-GUID: gjCqTYrt6LHKxzh41xzT_8GeSONsXMtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=807 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170146

On Wed, Apr 17, 2024 at 06:58:52PM +0530, Sibi Sankar wrote:
> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
> controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
> * Pickup Rb from Dimitry.
> 
>  .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> new file mode 100644
> index 000000000000..491b0a05e630
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
> +
> +maintainers:
> +  - Sibi Sankar <quic_sibis@qti.qualcomm.com>

That doesn't look like the correct domain.

Regards,
Bjorn

