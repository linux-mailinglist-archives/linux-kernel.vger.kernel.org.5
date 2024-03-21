Return-Path: <linux-kernel+bounces-110281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F352885C92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A16C282F53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747108627F;
	Thu, 21 Mar 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oBKDKkH3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F651E879;
	Thu, 21 Mar 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036267; cv=none; b=RUN/U7OXRfQjungU32Wted7uMEoVwa/oAb5SAYIIgj8VPYHSKZvtZq6o3t+7VS++xkyO7bBoTqsjBwDILb5IssHx2W4nmCjhSL3brE+qaCeToN9HnBOpJcmoKQWdMEBV5nsMY642pW5wRJ98z8UY5Gpx9IN2SQ+/zTJwKgEbUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036267; c=relaxed/simple;
	bh=NcoABh9qQqWyHeyP/BJpH8RDi7iEiqb/AKOW3kyJ7Hk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enr9cjIK/XHfqpvKswRRpQZG8xQaFAXHEQpTtLhRfI0zPRd7J2x2s7NWFT1zbZQIacZl0nNe9OFLcIy6rD8Ec2JyOB8CoNDst2JFXAf4EAyZvWwa4mQcZOc8XWsLlBwG+ioWRBMmDgoEa8YNkC9V1wAnOohvaf8fOlJvjjCdzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oBKDKkH3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LFOW30010746;
	Thu, 21 Mar 2024 15:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=FRj4LVlZr5NDfUAqAPS+X
	NAuH+YYahtbNBB1SbEdMAM=; b=oBKDKkH38UMpT2lFxBJvGBHAI7ipNAdSu7t7d
	xYezGRKPqmIGRvI9X+rvP5942Kq9O6LQ7V5NpoaxzaMH53PFRZP2Yvf34mUpiL8F
	Mb+MCyUa2LCAU2UtYIA9BzaVVRcbq21eqd0V6XCaC7Aw22UgNWhOidTKpSgCuBkn
	iYygFm7MNNdAOcuLjMZA4HSHMyZFqyXVVYxMgIo7NSC8VtcjqcxkfMuWnEpJsr2G
	CW01W4OGJbcKRHzS5ma7EdsfzsLU64Jc5MN5d8MdMAdeqIWqbmn/sOQNQVhem/SO
	U5RAwycD/5U8avMp2SDcN/u+OLLEuKVpxlDTtm6sMkosKlNfA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0f1nhd6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:50:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LFovDG006831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 15:50:57 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 08:50:53 -0700
Date: Thu, 21 Mar 2024 21:20:49 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Rob Herring <robh@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <ZfxXWaNzJoai6VpV@hu-varada-blr.qualcomm.com>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
 <20240321043149.2739204-2-quic_varada@quicinc.com>
 <20240321143549.GA1679970-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240321143549.GA1679970-robh@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S01h8yhEomAX6KFUw1hiZzgJAvomdgE-
X-Proofpoint-ORIG-GUID: S01h8yhEomAX6KFUw1hiZzgJAvomdgE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210115

On Thu, Mar 21, 2024 at 09:35:49AM -0500, Rob Herring wrote:
> On Thu, Mar 21, 2024 at 10:01:48AM +0530, Varadarajan Narayanan wrote:
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
>
> Where did you come up with GPL-2.0+? Every other qcom interconnect
> header is GPL-2.0-only. Is your employer okay with GPLv3 AND after?

Oops. Will fix it in the next version.

Thanks
Varada

