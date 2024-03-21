Return-Path: <linux-kernel+bounces-109877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0A8856F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF451F213A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F645646D;
	Thu, 21 Mar 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jwoJyvK7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B730537EE;
	Thu, 21 Mar 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015052; cv=none; b=FkSbb3xlWF19iVyS3VANVLX3rOKG5h9J3U9Wy7ks3HKsHgosjHkBkfFXY46QjDTJkRPeiT7YxcWXBg17pLK04sSWpOfysgjuiQWu/tcmD9wSaLSSzGVjsvcJSZNhr4tXCBzVb/JrpSnLGpmwCvIUF7pDFTkc42vitJDphcO5iWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015052; c=relaxed/simple;
	bh=ngQahxHlpBaX3jfWU9mfhKy5tX98kiPeSjHQ0x+mPp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGXgotS7vSkH8PYQBNc5hiCedo7j0m4ChwYo4hhv14coi9nKiMx2CcvWLpkpSXfE8EBK5p7QkH0l98MqGXgYBb66SRB7d6dz5CpXFvCJVT2iig3FoUxjS848XpGpKl7dJJDxseZhoqmYLVcz7H3QW3rHUzzhmXPd21teFF4z/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jwoJyvK7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L654kM025563;
	Thu, 21 Mar 2024 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=dxkqT3U/WCFhUtra5/hI+
	/dDnis7vzANk8176O+OmvE=; b=jwoJyvK7sndr8IrRSIky+t5c/lFDjKs+Zab4u
	6QDpOQe/ksjmIbNDP4LBbYhK/H+86Osu9j8A4K/W0g5YoBG+1Kq2H38/mVmppC8o
	ud65nlAi6fLsiIVaL7oQmhoa9zm7y54gxSpFTpT5W1e3ITgH80s2Gtrb5cEih9HR
	P/wQs+GqA4AfBQps3l64mpVL5Ur8VLGx0Oe1wMDsWn7K07gW+9fRIIM/dFgQrgdq
	6ROvc8n+rvWYRowj4hxBOi6RnPP5PZFStn0ODnxOlGN+kumj/ql27IXVJ9/L25Wq
	BTMLYB2eajecUHlcnyR8XgcaQxJQfgETn11VKIZabbNLrkGhw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fa7gf38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:57:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L9vPTY019027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 09:57:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 02:57:20 -0700
Date: Thu, 21 Mar 2024 15:27:10 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <ZfwEdtZoTH0/vPD5@hu-varada-blr.qualcomm.com>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-2-quic_varada@quicinc.com>
 <9e50c5fe-cb4c-4c3b-bff7-4492b24a5291@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e50c5fe-cb4c-4c3b-bff7-4492b24a5291@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: spDNa0BATrxTq2iljEnF-hxDKTkzJAvq
X-Proofpoint-ORIG-GUID: spDNa0BATrxTq2iljEnF-hxDKTkzJAvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210068

On Thu, Mar 21, 2024 at 08:23:01AM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2024 05:31, Varadarajan Narayanan wrote:
> > Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> > interfaces. This will be used by the gcc-ipq9574 driver
> > that will for providing interconnect services using the
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> >
> > diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > new file mode 100644
> > index 000000000000..96f79a86e8d2
> > --- /dev/null
> > +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> > +#define INTERCONNECT_QCOM_IPQ9574_H
> > +
> > +#define IPQ_APPS_ID			9574	/* some unique value */
> > +#define IPQ_NSS_ID			(IPQ_APPS_ID * 2)
> > +
> > +#define IPQ_ANOC_PCIE0_1_MAS		0
> > +#define IPQ_ANOC_PCIE0_1_SLV		1
>
> Please use style matching rest of mainline code. There is no IPQ in the
> name of interconnect. Open recent SM8650 or similar and see.

Ok. Will update and post the next version.

Thanks
Varada

