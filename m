Return-Path: <linux-kernel+bounces-136381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA689D374
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C7B23725
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD6C7D09A;
	Tue,  9 Apr 2024 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IVYYXrvP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B997C08C;
	Tue,  9 Apr 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648491; cv=none; b=fHZhOItXbtT1/DcLvHeLoAe/VzkuCRtHZPZ1+8l1leaIZcHKcugzEjCpP3hmc3IE++aSg9f2Mlc5ouNWAwG4VWn9JWCh+jtrqL9sEe/rGrVGJR/hSSKN/LUaoGUWFFJl+02sM0DpQck2FuIaoyKHHB2KnBdh2q2eMYXkCpZ79Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648491; c=relaxed/simple;
	bh=qMNrYLcuTY0pcgmZ0oT4n3METKTvJFHYohP4nDiM5ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGIZG4ujOmL97hRpFKE9RKslhcpzw3Gb8IJTdr75+hRLk7u/XLYeSTxtzXZn71aXOP6iY5fT0tcYhKA+nO0tIbf9L11QC1tBaQJFqC+gmv99PYeF7gvr36V1JfOOqXpHkcVLx3vwhzb0hEMORQZ34Gg4Wc0BRi73E0HMLZWqpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IVYYXrvP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4395v44J015779;
	Tue, 9 Apr 2024 07:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=i7mg2+0qg5EYWIcF/cedn
	xPv4Hbi1GnnfcsddO0JF3M=; b=IVYYXrvPToDfiYMqlQ8MV7lIFzzYYt1v9sWEY
	M+csaggOosSIJoGWvwXBiIvRn6yry4fESuFQkuFLp5LnoE4W2cQd2n0Us/whgxEg
	LDOKtAc2a0MRXpT1OgtAXO1x875ml2xe0i+JL2JpVBPrDhCvjgFOE2s9Tq4hg7vs
	rdORL/6L/zLIsRDdd/C1tqkHk9F8izQYDVmNYdWkfOwu/HQ49ZsFZxI9XKFzrPPD
	Y0N6Rbxx6RrTBrTktwLIFjDx2OfvOK+t+DC94Y2uj0RuyxxqME4Cngx4cklpFaK4
	yiSb/78QfXqRMPwN/TyhoLb+q34rurFbUcpvxW28J4oteMWCw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xctku0mpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 07:41:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4397fI58008865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 07:41:18 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 00:41:13 -0700
Date: Tue, 9 Apr 2024 13:11:09 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <ZhTxFVDH0xTSkw7r@hu-varada-blr.qualcomm.com>
References: <20240403104220.1092431-1-quic_varada@quicinc.com>
 <20240403104220.1092431-2-quic_varada@quicinc.com>
 <58c9b754-b9a7-444d-9545-9e6648010630@kernel.org>
 <Zg5q6mnWtK6hmPBT@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zg5q6mnWtK6hmPBT@hu-varada-blr.qualcomm.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X0oE9rg-_pP8JjZ2Qo1L9J-UbrPQ4iuz
X-Proofpoint-GUID: X0oE9rg-_pP8JjZ2Qo1L9J-UbrPQ4iuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_04,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090047

On Thu, Apr 04, 2024 at 02:25:06PM +0530, Varadarajan Narayanan wrote:
> On Wed, Apr 03, 2024 at 04:59:40PM +0200, Krzysztof Kozlowski wrote:
> > On 03/04/2024 12:42, Varadarajan Narayanan wrote:
> > > Add interconnect-cells to clock provider so that it can be
> > > used as icc provider.
> > >
> > > Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> > > interfaces. This will be used by the gcc-ipq9574 driver
> > > that will for providing interconnect services using the
> > > icc-clk framework.
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > > v7:
> > > Fix macro names to be consistent with other bindings
> > > v6:
> > > Removed Reviewed-by: Krzysztof Kozlowski
> > > Redefine the bindings such that driver and DT can share them
> > >
> > > v3:
> > > Squash Documentation/ and include/ changes into same patch
> > >
> > > qcom,ipq9574.h
> > > 	Move 'first id' to clock driver
> > >
> > > ---
> > >  .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
> > >  .../dt-bindings/interconnect/qcom,ipq9574.h   | 87 +++++++++++++++++++
> > >  2 files changed, 90 insertions(+)
> > >  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> > > index 944a0ea79cd6..824781cbdf34 100644
> > > --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> > > @@ -33,6 +33,9 @@ properties:
> > >        - description: PCIE30 PHY3 pipe clock source
> > >        - description: USB3 PHY pipe clock source
> > >
> > > +  '#interconnect-cells':
> > > +    const: 1
> > > +
> > >  required:
> > >    - compatible
> > >    - clocks
> > > diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > > new file mode 100644
> > > index 000000000000..0b076b0cf880
> > > --- /dev/null
> > > +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > > @@ -0,0 +1,87 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> > > +#define INTERCONNECT_QCOM_IPQ9574_H
> > > +
> > > +#define ICC_ANOC_PCIE0		0
> > > +#define ICC_SNOC_PCIE0		1
> > > +#define ICC_ANOC_PCIE1		2
> > > +#define ICC_SNOC_PCIE1		3
> > > +#define ICC_ANOC_PCIE2		4
> > > +#define ICC_SNOC_PCIE2		5
> > > +#define ICC_ANOC_PCIE3		6
> > > +#define ICC_SNOC_PCIE3		7
> > > +#define ICC_SNOC_USB		8
> > > +#define ICC_ANOC_USB_AXI	9
> > > +#define ICC_NSSNOC_NSSCC	10
> > > +#define ICC_NSSNOC_SNOC_0	11
> > > +#define ICC_NSSNOC_SNOC_1	12
> > > +#define ICC_NSSNOC_PCNOC_1	13
> > > +#define ICC_NSSNOC_QOSGEN_REF	14
> > > +#define ICC_NSSNOC_TIMEOUT_REF	15
> > > +#define ICC_NSSNOC_XO_DCD	16
> > > +#define ICC_NSSNOC_ATB		17
> > > +#define ICC_MEM_NOC_NSSNOC	18
> > > +#define ICC_NSSNOC_MEMNOC	19
> > > +#define ICC_NSSNOC_MEM_NOC_1	20
> > > +
> > > +#define ICC_NSSNOC_PPE		0
> > > +#define ICC_NSSNOC_PPE_CFG	1
> > > +#define ICC_NSSNOC_NSS_CSR	2
> > > +#define ICC_NSSNOC_IMEM_QSB	3
> > > +#define ICC_NSSNOC_IMEM_AHB	4
> > > +
> > > +#define MASTER_ANOC_PCIE0		(ICC_ANOC_PCIE0 * 2)
> > > +#define SLAVE_ANOC_PCIE0		((ICC_ANOC_PCIE0 * 2) + 1)
> >
> > Which existing Qualcomm platform has such code?
>
> Existing Qualcomm platforms don't use icc-clk. They use icc-rpm
> or icc-rpmh. clk-cbf-msm8996.c is the only driver that uses icc-clk.
>
> The icc_clk_register automatically creates master & slave nodes
> for each clk entry provided as input with the node-ids 'n' and
> 'n+1'. Since clk-cbf-msm8996.c has only one entry, it could just
> define MASTER_CBF_M4M and SLAVE_CBF_M4M with 0 and 1 and avoid these
> calculations.
>
> However, ipq9574 gives an array of clock entries as input to
> icc_clk_register. To tie the order/sequence of these clock
> entries correctly with the node-ids, this calculation is needed.
>
> > This is the third time I am asking for consistent headers. Open
> > existing, recently added headers and look how it is done there. Why?
> > Because I am against such calculations and see no reason for them.
>
> Apologies. Regret that I have to trouble you.
>
> In this ipq9574 case, have to reconcile between the following
> feedbacks.
>
> 1. https://lore.kernel.org/linux-arm-msm/fe40b307-26d0-4b2a-869b-5d093415b9d1@linaro.org/
>    We could probably use indexed identifiers here to avoid confusion:
>    [ICC_BINDING_NAME] = CLK_BINDING_NAME
>
> 2. https://lore.kernel.org/linux-arm-msm/95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org/
>    Are these supposed to be in a dt-binding header?
>
> 3. https://lore.kernel.org/linux-arm-msm/031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org/
>    Do you use them as well in the DTS?
>
> Having the defines (with the calculations) seemed to to comply
> with the above three feedbacks.
>
> Please let me know if this can be handled in a different way that
> would be consistent with other Qualcomm platforms.

Krzysztof,

Is this ok? Can I post a new version addressing other review comments?

Thanks
Varada

