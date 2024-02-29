Return-Path: <linux-kernel+bounces-87636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93886D6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59CC284129
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258574C0E;
	Thu, 29 Feb 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SyoVmo1h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465974BED;
	Thu, 29 Feb 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245469; cv=none; b=eyrrrEUNndindHVlX9/DLgXvDmZcf9hoqUJLnztVuzNW6lXQCeKWpK3B1Z7VdBWJCCdPiV+fx/WoQn8IfcOoHBohxpjCPNEgWKM2z+4hWS+sJ4WNEDtVeaiN3Bo1TPdC1sym4EQ8sBeGXw5KZTcMG8lPi0j8+VM9UWhepwRhibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245469; c=relaxed/simple;
	bh=0jwd/jJz9F7HyDfXNZKIQyTdhdaG+2S7SxpZB0qD6OI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7kvH2sKoXDADw6d/UE9Tbg8g9bRkcwtAezYMYplpqW+qcs76VsEBx9YT5mZrNVLe8TsX/A+sJkY6Hk9TQGQPhPF2q8/k7Y9nOVwtMiFmNkgAbJL7dMFBpZynDFxdh9yFOis10JUjdsVHzzUEnt/VCi3U1eOlVY80Y4Imp+o1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SyoVmo1h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TLls8D009650;
	Thu, 29 Feb 2024 22:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=OtqW1XZXFcuupLJ9seJDX
	buTAWyH7zHudvWRXGce+gE=; b=SyoVmo1harXCR7en4JVVG10pO4Pv6cwwRNf2o
	Pguv0A/JONB/mOudHWLOt0ggxQFISbRwgX0SPs35Zf7JAelJvRR0gLGDkHVrn4VQ
	FEvhe+dKiFzg6TzxwXpYl1bUhEnrNdvhK1LPGZyrxo7KhIjt87O+nHQvVv3thMPC
	4gHKU+Qt7kMiTdy+FWCCZBXjMOW85PeWEioSz4mVZz9XT+uaonCSTLpGr0ZS7p10
	IKolXiAt4WWxjDNUONnbHNitISGi6DICUCTUQI249OUiQnAWn3ip0y8xHdxmZ2Ya
	JNcmksT9OI+01iYxCIV0QgUUwIo1Fcu/01dZ06LV9XNmfcDlg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjycdgktv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 22:24:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TMO5Hl000407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 22:24:05 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 14:24:04 -0800
Date: Thu, 29 Feb 2024 14:24:03 -0800
From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<quic_c_gdjako@quicinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robdclark@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_sukadev@quicinc.com>,
        <quic_pdaly@quicinc.com>, <quic_sudaraja@quicinc.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: iommu: Add Qualcomm TBU bindings
Message-ID: <20240229222347.GA918@hu-cgoldswo-sd.qualcomm.com>
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
 <20240226172218.69486-2-quic_c_gdjako@quicinc.com>
 <b6215fcd-29fc-4495-999f-b7b03b36c087@linaro.org>
 <70095e04-eaec-4323-b2ac-2d4d366763d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70095e04-eaec-4323-b2ac-2d4d366763d5@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OXH1O4Jm_oC6uUujkc43pumk01oZDJUg
X-Proofpoint-ORIG-GUID: OXH1O4Jm_oC6uUujkc43pumk01oZDJUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290175

On Thu, Feb 29, 2024 at 10:09:34PM +0200, Georgi Djakov wrote:
> Hi Krzysztof,
> 
> On 29.02.24 19:53, Krzysztof Kozlowski wrote:
> >On 26/02/2024 18:22, Georgi Djakov wrote:
> >>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>+%YAML 1.2
> >>+---
> >>+$id: http://devicetree.org/schemas/iommu/qcom,tbu.yaml#
> >>+$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>+
> >>+title: Qualcomm TBU (Translation Buffer Unit)
> >>+
> >>+maintainers:
> >>+  - Georgi Djakov <quic_c_gdjako@quicinc.com>
> >>+
> >>+description:
> >>+  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
> >>+  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
> >>+  debug features to trace and trigger debug transactions. There are multiple TBU
> >>+  instances with each client core.
> >>+
> >>+properties:
> >>+  compatible:
> >>+    const: qcom,qsmmuv500-tbu
> >
> >Why we don't have SoC specific compatibles? If that's for SDM845, then
> >it should be qcom,sdm845-tbu or qcom,sdm845-qsmmuv500-tbu
> >
> 
> Because they should be all compatible (as registers). Adding a SoC compatible
> might get overly-specific, but i can also see the benefits in that, so ok will
> do it!
> 

Hi Krzysztof,

JFYI that the TBUs are used on our mobile SoCs going up until the SoC
we commercialized in early 2022, Snapdragon 8 Gen 1. Including SDM845
there are three more premium tier SoCs using TBUs plus all of their
value-tier derivatives.  There will also be prior generation premium
tier SoCs along with their derivatives that use the TBU as well. Does
it make sense to have a target-specific compatible string given this? 

Thanks,

Chris.


