Return-Path: <linux-kernel+bounces-118594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5488BD01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BAAB21C12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B91C2BE;
	Tue, 26 Mar 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ctcqXrim"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC547A52;
	Tue, 26 Mar 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443595; cv=none; b=An+i8LctJFUe7ZK++N5YsCatETY/p0JBtOCyKNlNv6X8ShIKAA0c9fdZCCa5VBjiaZeezQ/yC41/PN6g3fKYoaItaZY6k4rdWMaEVFtv/Ww/VAHQgrgK7/08qj2wllSI79vJWqCPYqR82zXqEZ8K9D6KEqPosgTr+vxzHyyTVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443595; c=relaxed/simple;
	bh=4uDjqygHv4DTuZmqzarwUnS5AROPK4sqXpSLqkeaM10=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdJrXeYyMka5Cjg7/QoaUKWcnRNH4l8J0EsUAJlWibzAGgTVVmKpebg5adC0zuW3zkuPtCnVsHZIFmdRFCQd04QMJJge9Jnm4k6AaFNzRttcciroXsS0cAvZve4rKS+6ydv/1Olm3rFd0KIgIUmoIW7LuBZPDMHsnadSYm250jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ctcqXrim; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q66XbV004610;
	Tue, 26 Mar 2024 08:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=SbrMPaH2oADH1vwWJwZWD
	SkzPzttEAqCuqJGgMzYDn4=; b=ctcqXrimT+81u4eT0KvX2YDhZ1BF6guYm1Z00
	g/VjpSfog8sJRHOr+tDqlPHinBO/0H6/q5H7szlP0GfDqWVhWRsA78xr36hlkfUj
	RfiDEnLIxFaxw622DuaOKHOtor5w7damxpnV5QyF11YbKPGCgNrc1CK/RpDOL/Cg
	M9zoGygykXpnuTQuVKvo1BHTBJjPm7OV/3Y9InNCFUhOCJlDC+5YpH4Oi97QSpNq
	mMBf90rWyeOCIhLI6VgFJ7blb6aSL4hqDyOgYiU1V1CrkSqWuHmHaTwvnbTxudzH
	wIi5A++bT0IdMcGDJy+qtRM28m7OeuCk1yP5ky2gRNuH4kMqw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rt80fm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:59:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q8xOTf009240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 08:59:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 01:59:19 -0700
Date: Tue, 26 Mar 2024 14:29:16 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <ZgKOZGDxqGD8dmAn@hu-varada-blr.qualcomm.com>
References: <20240325102036.95484-1-quic_varada@quicinc.com>
 <20240325102036.95484-3-quic_varada@quicinc.com>
 <4e7ff99f-f362-4d58-b2f0-ca2dc1fe4b55@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e7ff99f-f362-4d58-b2f0-ca2dc1fe4b55@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JNx53uo_Xs9A_D8dPCMbJA1vWSMfwqlj
X-Proofpoint-ORIG-GUID: JNx53uo_Xs9A_D8dPCMbJA1vWSMfwqlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=942 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260061

On Tue, Mar 26, 2024 at 07:49:00AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2024 11:20, Varadarajan Narayanan wrote:
> > Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
> > interfaces. This will be used by the gcc-ipq9574 driver
> > that will for providing interconnect services using the
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v2: Rename master slave macros
> >     Fix license identifier
>
> Both patches should be squashed. Header is parts of bindings and your
> previous patch adds the interconnects, doesn't it?
>
>
> > ---
> >  .../dt-bindings/interconnect/qcom,ipq9574.h   | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
> >
> > diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > new file mode 100644
> > index 000000000000..b7b32aa6bbb1
> > --- /dev/null
> > +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +#ifndef INTERCONNECT_QCOM_IPQ9574_H
> > +#define INTERCONNECT_QCOM_IPQ9574_H
> > +
> > +#define IPQ_APPS_ID			9574	/* some unique value */
>
> Why random unique values are bindings? Why this cannot be 0? Please
> explain how this is used by DTS and driver.

This 'id' is not used by the driver or DTS. It is a unique id that
is initialized for the node by the interconnect driver framework.
A random value was chosen such that it does not conflict with an
already existing node id. Chose 9574 based on this comment from
clk-cbf-msm8996.c

	/* Random ID that doesn't clash with main qnoc and OSM */
	#define CBF_MASTER_NODE 2000

> > +#define IPQ_NSS_ID			(IPQ_APPS_ID * 2)
>
> This does not seem right.

Doubled the NSS id so that APPS node ids dont clash.

Thanks
Varada

