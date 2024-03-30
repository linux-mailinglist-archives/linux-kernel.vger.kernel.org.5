Return-Path: <linux-kernel+bounces-125690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97017892AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32092B21999
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B286374D9;
	Sat, 30 Mar 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VReKCeJA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF32BE6F;
	Sat, 30 Mar 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797451; cv=none; b=OgfaGFU51IcfvciMiR9/Njs7IoOUDl71CRGzTxF6FNvfyFyfgeeinNjY7bFOJUEtVCO3DGMq+uo8WHlfUAhyP3Zsi/FEj6sY+q5Sg66LbV/JJk72lFW1DqEE4zTpPNI7xndJjgciJkbzBSduvJ+NFC33cE//CRDcusYUaqslsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797451; c=relaxed/simple;
	bh=1+FLZf8NhvSoHU8Nxo8s7Kl4QOIlI88wna7RvTeNLVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJZMgKX2/nrQ7851t+Howa7UW0hfjuTgK00DozM8QHv4s9y35SROBXiitosrB1NSxXvEpaJnifUal0Nbrz8zRRghZ524BVCua25TycBX+F40A37oFblzwVnu3DmvYCQovyS1v4KNUNnHRroYYRB/ndPRfCxsDmzhErkgcSVtyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VReKCeJA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42UB2ird009029;
	Sat, 30 Mar 2024 11:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=3TKL+TXri2fej1BIbvxO9
	46yNIpK8+nMHxirlzT443g=; b=VReKCeJArHG2CwWfu+MDFuGBDqW5DAYZaUgRU
	sy94CSQ6sqvaf7UBDhsQIeIEGS7eLNe+jg7TWr/LTVQZSTBe8SWGKHLFVR4O1/dJ
	OAgLWdSOIPIySRHtaFrCSnL49kLEL1D4Ph63+AOtZo4TIu4DLkL8WLJPN0vhhxo1
	J3IZbZAxmWrjSCrqAjdJ2eMYyYCWWzj4Q2oNGnPsVGh+h/TDt4krhzJgRgA/sRVZ
	GmxFKNZnVi0ZbmmnLQxqf11gKtn/nv6lwg3YVKP6KqxQ9TxWlnx01E69t0buVifp
	F88boLkzLemuhnGF9c6LC7w8b2/fBDIC5NFkxbxnpdSD0z8xA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6bwx0pht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 11:17:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42UBHMAm008748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Mar 2024 11:17:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 30 Mar 2024 04:17:18 -0700
Date: Sat, 30 Mar 2024 16:47:14 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Stephen Boyd <sboyd@kernel.org>, <andersson@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mturquette@baylibre.com>, <quic_anusha@quicinc.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
Message-ID: <Zgf0uia7Wbj1y2zg@hu-varada-blr.qualcomm.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
 <20240328075936.223461-5-quic_varada@quicinc.com>
 <95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org>
 <ZgaeGZL7QXh75aSA@hu-varada-blr.qualcomm.com>
 <031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org>
 <Zgfbs5SFN2cA0gSK@hu-varada-blr.qualcomm.com>
 <5570c921-0103-4e92-be9a-da9c1b7cbd79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5570c921-0103-4e92-be9a-da9c1b7cbd79@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tbBmwQ2gj3N-Y0uKE7iNBCDhhfSpYCBc
X-Proofpoint-ORIG-GUID: tbBmwQ2gj3N-Y0uKE7iNBCDhhfSpYCBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-30_07,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=865 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403300092

On Sat, Mar 30, 2024 at 11:28:09AM +0100, Krzysztof Kozlowski wrote:
> On 30/03/2024 10:30, Varadarajan Narayanan wrote:
> > On Fri, Mar 29, 2024 at 01:10:03PM +0100, Krzysztof Kozlowski wrote:
> >> On 29/03/2024 11:55, Varadarajan Narayanan wrote:
> >>>>> +
> >>>>> +enum {
> >>>>> +       ICC_ANOC_PCIE0,
> >>>>> +       ICC_SNOC_PCIE0,
> >>>>> +       ICC_ANOC_PCIE1,
> >>>>> +       ICC_SNOC_PCIE1,
> >>>>> +       ICC_ANOC_PCIE2,
> >>>>> +       ICC_SNOC_PCIE2,
> >>>>> +       ICC_ANOC_PCIE3,
> >>>>> +       ICC_SNOC_PCIE3,
> >>>>> +       ICC_SNOC_USB,
> >>>>> +       ICC_ANOC_USB_AXI,
> >>>>> +       ICC_NSSNOC_NSSCC,
> >>>>> +       ICC_NSSNOC_SNOC_0,
> >>>>> +       ICC_NSSNOC_SNOC_1,
> >>>>> +       ICC_NSSNOC_PCNOC_1,
> >>>>> +       ICC_NSSNOC_QOSGEN_REF,
> >>>>> +       ICC_NSSNOC_TIMEOUT_REF,
> >>>>> +       ICC_NSSNOC_XO_DCD,
> >>>>> +       ICC_NSSNOC_ATB,
> >>>>> +       ICC_MEM_NOC_NSSNOC,
> >>>>> +       ICC_NSSNOC_MEMNOC,
> >>>>> +       ICC_NSSNOC_MEM_NOC_1,
> >>>>> +};
> >>>>
> >>>> Are these supposed to be in a dt-binding header?
> >>>
> >>> Since these don't directly relate to the ids in the dt-bindings
> >>> not sure if they will be permitted there. Will move and post a
> >>> new version and get feedback.
> >>
> >> You can answer this by yourself by looking at your DTS. Do you use them
> >> as well in the DTS?
> >
> > I can use them in the DTS. The icc-clk framework automatically
> > creates master and slave nodes as 'n' and 'n+1'. Hence I can have
> > something like this in the dt-bindings include file
> >
> > 	#define ICC_ANOC_PCIE0		0
> > 	#define ICC_SNOC_PCIE0		1
> > 		.
> > 		.
> > 		.
> > 	#define ICC_NSSNOC_MEM_NOC_1	20
> >
> > 	#define MASTER(x)	((ICC_ ## x) * 2)
> > 	#define SLAVE(x)	(MASTER(x) + 1)
>
> I don't understand this or maybe I misunderstood the purpose of this
> define. It does not matter if you "can" use something in DT. The
> question is: do you use them.

Yes. It will be used fot the pcie nodes. These defines are for
specifying the endpoints. The icc driver identifies a path that
can connect these endpoints. The peripheral drivers' DT nodes
will make use of these defines.

> >> It's a pity we see here only parts of DTS, instead of full interconnect
> >> usage.
> >
> > Unfortunately cannot include the pcie dts changes with this
> > patch, but you can refer to them at https://lore.kernel.org/linux-arm-msm/20230519090219.15925-5-quic_devipriy@quicinc.com/
> >
> > The above macros will be used in the pcie node as follows
> >
> > pcie0: pci@28000000 {
> > 	compatible = "qcom,pcie-ipq9574";
> > 	. . .
> > 	interconnects = <&gcc MASTER(ANOC_PCIE0) &gcc SLAVE(ANOC_PCIE0)>,
> > 			<&gcc MASTER(SNOC_PCIE0) &gcc SLAVE(SNOC_PCIE0)>;
> > 	interconnect-names = "pcie-mem", "cpu-pcie";
>
> Then why did you add header which is not used?

Since they are a part of the interconnect driver. The peripherals
that use the interconnects will make use of them to specify the
endpoints. After changing per Boyd's comments, the header will
be used from gcc driver. Will post a new version. Kindly review
that.

Thanks
Varada

> I will respond there...
>
> Best regards,
> Krzysztof
>

