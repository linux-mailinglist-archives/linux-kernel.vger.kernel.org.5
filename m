Return-Path: <linux-kernel+bounces-138292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F189EF61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02281C20F07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA87158215;
	Wed, 10 Apr 2024 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kz3TN6Vn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BC8F4E;
	Wed, 10 Apr 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743379; cv=none; b=lXnmlGZ7PfFW9vvXDG4Jc4jqDK3coS5UwC972sU6IwcZXOK7lhEqH9Re/RiwsFs3magnx0dnlOq5YceIGAs25nXkL+icGZCu4XZsvmqOdmDjy4V7/AQtNqfkmVAW5GVvhkBXHyS+vS4l5W4tmoueu/s+a6oVExQzPhHxo1N7zxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743379; c=relaxed/simple;
	bh=I//1R7EBrIo1jeneN/N16Nl+/LKo1Zfm1h1eEhx61W4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DliBER2oGnVTz3IsMQVp+ttpk6kMlop9BgMMC+27p/18YNxqtr4VBg4SZbeDwbwlW12WLwqjpGvfP1wmJyhX6KVe2kfsOCVi6IH8l7rW88U1VAag5lW5vmQ9KcAsLRS5vMtC1Gp8W3cdCtfdHE0p5h0ngQzCzbGl6HOyCljXqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kz3TN6Vn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A3dB9g030919;
	Wed, 10 Apr 2024 10:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=7n1nNdXnhWgfzt2lbMu/j
	n10wjb7ejFR65QwI3cMGSg=; b=kz3TN6VnvsjAa0DoIGXIfmFTiPJmYkLzxqawN
	nAhwGDujzP3RpQUQ9NDUe+380wjuH9sG3niP2RsiHN4jVnZsA2GM1bp73oHqWskD
	ms8cwbNzy2U6AKDfMmtCZJF3Ou2hKt9S9p+TyYeIRlRYzvIo7dEvOzHoPBFeMoNM
	XPXTRmBHkR9sUwQC61LXOJn54HYQOa7Sy/ohaiov1P52c30MCU/6dOdsY6lmwoNW
	C2XTZVmHqahRNgLlE2/kJV2sUjjrT9QpMwebIwfr6IC17WX1wPGY0vfcHpv5HWzY
	//gNQ1ds+aqchg5IxhrfjEakVfnIfPmah/qtiqeiPfjfv5D6Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xddqvknn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:02:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AA2fwp025330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:02:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 03:02:36 -0700
Date: Wed, 10 Apr 2024 15:32:32 +0530
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
Message-ID: <ZhZjuCkJrtPbwtS/@hu-varada-blr.qualcomm.com>
References: <20240403104220.1092431-1-quic_varada@quicinc.com>
 <20240403104220.1092431-2-quic_varada@quicinc.com>
 <58c9b754-b9a7-444d-9545-9e6648010630@kernel.org>
 <Zg5q6mnWtK6hmPBT@hu-varada-blr.qualcomm.com>
 <ZhTxFVDH0xTSkw7r@hu-varada-blr.qualcomm.com>
 <1ec401be-11cb-416a-9eae-d72ea8acf06f@kernel.org>
 <ZhUghsa5Do5m7wrX@hu-varada-blr.qualcomm.com>
 <a0173a13-5f20-4e24-8417-afce5fdbda0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0173a13-5f20-4e24-8417-afce5fdbda0e@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eK1ahQbNGaEkxgXfumr3wmISdLuR_s7S
X-Proofpoint-GUID: eK1ahQbNGaEkxgXfumr3wmISdLuR_s7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100072

On Tue, Apr 09, 2024 at 02:20:12PM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2024 13:03, Varadarajan Narayanan wrote:
> > On Tue, Apr 09, 2024 at 11:45:51AM +0200, Krzysztof Kozlowski wrote:
> >> On 09/04/2024 09:41, Varadarajan Narayanan wrote:
> >>> On Thu, Apr 04, 2024 at 02:25:06PM +0530, Varadarajan Narayanan wrote:
> >>>> On Wed, Apr 03, 2024 at 04:59:40PM +0200, Krzysztof Kozlowski wrote:
> >>>>> On 03/04/2024 12:42, Varadarajan Narayanan wrote:
> >>>>>> Add interconnect-cells to clock provider so that it can be
> >>>>>> used as icc provider.
> >>>>>>
> >>>>>> Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> >>>>>> interfaces. This will be used by the gcc-ipq9574 driver
> >>>>>> that will for providing interconnect services using the
> >>>>>> icc-clk framework.
> >>>>>>
> >>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>> ---
> >>>>>> v7:
> >>>>>> Fix macro names to be consistent with other bindings
> >>>>>> v6:
> >>>>>> Removed Reviewed-by: Krzysztof Kozlowski
> >>>>>> Redefine the bindings such that driver and DT can share them
> >>>>>>
> >>>>>> v3:
> >>>>>> Squash Documentation/ and include/ changes into same patch
> >>>>>>
> >>>>>> qcom,ipq9574.h
> >>>>>> 	Move 'first id' to clock driver
> >>>>>>
> >>>>>> ---
> >>>>>>  .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
> >>>>>>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 87 +++++++++++++++++++
> >>>>>>  2 files changed, 90 insertions(+)
> >>>>>>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> >>>>>> index 944a0ea79cd6..824781cbdf34 100644
> >>>>>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
> >>>>>> @@ -33,6 +33,9 @@ properties:
> >>>>>>        - description: PCIE30 PHY3 pipe clock source
> >>>>>>        - description: USB3 PHY pipe clock source
> >>>>>>
> >>>>>> +  '#interconnect-cells':
> >>>>>> +    const: 1
> >>>>>> +
> >>>>>>  required:
> >>>>>>    - compatible
> >>>>>>    - clocks
> >>>>>> diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..0b076b0cf880
> >>>>>> --- /dev/null
> >>>>>> +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> >>>>>> @@ -0,0 +1,87 @@
> >>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>>>>> +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> >>>>>> +#define INTERCONNECT_QCOM_IPQ9574_H
> >>>>>> +
> >>>>>> +#define ICC_ANOC_PCIE0		0
> >>>>>> +#define ICC_SNOC_PCIE0		1
> >>>>>> +#define ICC_ANOC_PCIE1		2
> >>>>>> +#define ICC_SNOC_PCIE1		3
> >>>>>> +#define ICC_ANOC_PCIE2		4
> >>>>>> +#define ICC_SNOC_PCIE2		5
> >>>>>> +#define ICC_ANOC_PCIE3		6
> >>>>>> +#define ICC_SNOC_PCIE3		7
> >>>>>> +#define ICC_SNOC_USB		8
> >>>>>> +#define ICC_ANOC_USB_AXI	9
> >>>>>> +#define ICC_NSSNOC_NSSCC	10
> >>>>>> +#define ICC_NSSNOC_SNOC_0	11
> >>>>>> +#define ICC_NSSNOC_SNOC_1	12
> >>>>>> +#define ICC_NSSNOC_PCNOC_1	13
> >>>>>> +#define ICC_NSSNOC_QOSGEN_REF	14
> >>>>>> +#define ICC_NSSNOC_TIMEOUT_REF	15
> >>>>>> +#define ICC_NSSNOC_XO_DCD	16
> >>>>>> +#define ICC_NSSNOC_ATB		17
> >>>>>> +#define ICC_MEM_NOC_NSSNOC	18
> >>>>>> +#define ICC_NSSNOC_MEMNOC	19
> >>>>>> +#define ICC_NSSNOC_MEM_NOC_1	20
> >>>>>> +
> >>>>>> +#define ICC_NSSNOC_PPE		0
> >>>>>> +#define ICC_NSSNOC_PPE_CFG	1
> >>>>>> +#define ICC_NSSNOC_NSS_CSR	2
> >>>>>> +#define ICC_NSSNOC_IMEM_QSB	3
> >>>>>> +#define ICC_NSSNOC_IMEM_AHB	4
> >>>>>> +
> >>>>>> +#define MASTER_ANOC_PCIE0		(ICC_ANOC_PCIE0 * 2)
> >>>>>> +#define SLAVE_ANOC_PCIE0		((ICC_ANOC_PCIE0 * 2) + 1)
> >>>>>
> >>>>> Which existing Qualcomm platform has such code?
> >>>>
> >>>> Existing Qualcomm platforms don't use icc-clk. They use icc-rpm
> >>>> or icc-rpmh. clk-cbf-msm8996.c is the only driver that uses icc-clk.
> >>>>
> >>>> The icc_clk_register automatically creates master & slave nodes
> >>>> for each clk entry provided as input with the node-ids 'n' and
> >>>> 'n+1'. Since clk-cbf-msm8996.c has only one entry, it could just
> >>>> define MASTER_CBF_M4M and SLAVE_CBF_M4M with 0 and 1 and avoid these
> >>>> calculations.
> >>>>
> >>>> However, ipq9574 gives an array of clock entries as input to
> >>>> icc_clk_register. To tie the order/sequence of these clock
> >>>> entries correctly with the node-ids, this calculation is needed.
> >>>>
> >>>>> This is the third time I am asking for consistent headers. Open
> >>>>> existing, recently added headers and look how it is done there. Why?
> >>>>> Because I am against such calculations and see no reason for them.
> >>>>
> >>>> Apologies. Regret that I have to trouble you.
> >>>>
> >>>> In this ipq9574 case, have to reconcile between the following
> >>>> feedbacks.
> >>>>
> >>>> 1. https://lore.kernel.org/linux-arm-msm/fe40b307-26d0-4b2a-869b-5d093415b9d1@linaro.org/
> >>>>    We could probably use indexed identifiers here to avoid confusion:
> >>>>    [ICC_BINDING_NAME] = CLK_BINDING_NAME
> >>>>
> >>>> 2. https://lore.kernel.org/linux-arm-msm/95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org/
> >>>>    Are these supposed to be in a dt-binding header?
> >>>>
> >>>> 3. https://lore.kernel.org/linux-arm-msm/031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org/
> >>>>    Do you use them as well in the DTS?
> >>>>
> >>>> Having the defines (with the calculations) seemed to to comply
> >>>> with the above three feedbacks.
> >>>>
> >>>> Please let me know if this can be handled in a different way that
> >>>> would be consistent with other Qualcomm platforms.
> >>>
> >>> Krzysztof,
> >>>
> >>> Is this ok? Can I post a new version addressing other review comments?
> >>
> >> I don't understand and you did not answered before, why you have to do
> >> it differently than all other Qualcomm interconnect providers. Maybe the
> >> code here needs it, maybe not, but I don't see any argument proving this.
> >
> > Other Qualcomm interconnect providers use the icc-rpm.
> >
> > 	1. The SoC specific interconnect providers have control
> > 	   over the master/slave id-numbers and is hard coded.
> >
> > 	2. These id-numbers are used by the RPM firmware.
> >
> > IPQ9574 uses icc-clk.
> >
> > 	1. The ipq9574 specific interconnect provider doesn't
> > 	   have control over the master/slave id-numbers. The
> > 	   icc-clk framework auto generates it in the order of
> > 	   the clock entries given as input.
>
> Okay, so what happens if icc-clk way of generating them changes a bit?
> It can change, why not, driver implementation is not an ABI.
>
> >
> > 	2. These auto-generated id-numbers have to be correctly
> > 	   tied to the DT nodes. Else, the relevant clocks may
> > 	   not get enabled.
>
> Sorry, I don't get, how auto generated ID number is tied to DT node.
> What DT node?

I meant the following usage for the 'interconnects' entry of the
consumer peripheral's node.

	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
			      ^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^
			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
			      ^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^

> > Since ICC-CLK creates two ids per clock entry (one MASTER_xxx and
> > one SLAVE_xxx), using those MASTER/SLAVE_xxx macros as indices in
> > the below array would create holes.
> >
> > 	static int icc_ipq9574_hws[] = {
> > 		[MASTER_ANOC_PCIE0] = GCC_ANOC_PCIE0_1LANE_M_CLK,
> > 		[MASTER_SNOC_PCIE0] = GCC_SNOC_PCIE0_1LANE_S_CLK,
> > 		[MASTER_ANOC_PCIE1] = GCC_ANOC_PCIE1_1LANE_M_CLK,
> > 		[MASTER_SNOC_PCIE1] = GCC_SNOC_PCIE1_1LANE_S_CLK,
> > 		. . .
> > 	};
> >
> > Other Qualcomm drivers don't have this issue and they can
> > directly use the MASTER/SLAVE_xxx macros.
>
> I understand, thanks, yet your last patch keeps adding fake IDs, means
> IDs which are not part of ABI.
>
> >
> > As the MASTER_xxx macros cannot be used, have to define a new set
> > of macros that can be used for indices in the above array. This
> > is the reason for the ICC_BINDING_NAME macros.
>
> Then maybe fix the driver, instead of adding something which is not an
> ABI to bindings and completely skipping the actual ABI.

Will remove the ICC_xxx defines from the header. And in the
driver will change the declaration as follows. Will that be
acceptable?

	static int icc_ipq9574_hws[] = {
		[MASTER_ANOC_PCIE0 / 2] = GCC_ANOC_PCIE0_1LANE_M_CLK,
		[MASTER_SNOC_PCIE0 / 2] = GCC_SNOC_PCIE0_1LANE_S_CLK,
		[MASTER_ANOC_PCIE1 / 2] = GCC_ANOC_PCIE1_1LANE_M_CLK,
		[MASTER_SNOC_PCIE1 / 2] = GCC_SNOC_PCIE1_1LANE_S_CLK,
		[MASTER_ANOC_PCIE2 / 2] = GCC_ANOC_PCIE2_2LANE_M_CLK,
		[MASTER_SNOC_PCIE2 / 2] = GCC_SNOC_PCIE2_2LANE_S_CLK,
		[MASTER_ANOC_PCIE3 / 2] = GCC_ANOC_PCIE3_2LANE_M_CLK,
		[MASTER_SNOC_PCIE3 / 2] = GCC_SNOC_PCIE3_2LANE_S_CLK,
		[MASTER_SNOC_USB / 2] = GCC_SNOC_USB_CLK,
		[MASTER_ANOC_USB_AXI / 2] = GCC_ANOC_USB_AXI_CLK,
		[MASTER_NSSNOC_NSSCC / 2] = GCC_NSSNOC_NSSCC_CLK,
		[MASTER_NSSNOC_SNOC_0 / 2] = GCC_NSSNOC_SNOC_CLK,
		[MASTER_NSSNOC_SNOC_1 / 2] = GCC_NSSNOC_SNOC_1_CLK,
		[MASTER_NSSNOC_PCNOC_1 / 2] = GCC_NSSNOC_PCNOC_1_CLK,
		[MASTER_NSSNOC_QOSGEN_REF / 2] = GCC_NSSNOC_QOSGEN_REF_CLK,
		[MASTER_NSSNOC_TIMEOUT_REF / 2] = GCC_NSSNOC_TIMEOUT_REF_CLK,
		[MASTER_NSSNOC_XO_DCD / 2] = GCC_NSSNOC_XO_DCD_CLK,
		[MASTER_NSSNOC_ATB / 2] = GCC_NSSNOC_ATB_CLK,
		[MASTER_MEM_NOC_NSSNOC / 2] = GCC_MEM_NOC_NSSNOC_CLK,
		[MASTER_NSSNOC_MEMNOC / 2] = GCC_NSSNOC_MEMNOC_CLK,
		[MASTER_NSSNOC_MEM_NOC_1 / 2] = GCC_NSSNOC_MEM_NOC_1_CLK,
	};

Thanks
Varada

