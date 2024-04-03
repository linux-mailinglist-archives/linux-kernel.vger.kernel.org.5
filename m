Return-Path: <linux-kernel+bounces-129598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B172896D02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF01C26664
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DED143865;
	Wed,  3 Apr 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UbBbnanI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8F136674;
	Wed,  3 Apr 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141069; cv=none; b=tuFtn8rM2VgAKWmm3Ys6pSNCq+ia1wzesqMdQW6q1zjvnLvFMAk9F4Hqq+0G+lsYEoUi+c6jOIMHIE3TGotuGe4HvJ69bwucO5es+qOzS4EOn65eJkbDLr/tKy5pHvTdoG3eKJOOwhabu61S0m2woCyOlJfJ4TqWNXH1ZMFKwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141069; c=relaxed/simple;
	bh=G8yYzb4bH382K5cAZ8WYPN+tPG2XPoQcoJ98SS0UuqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTl6ficv/z7C9nhaal0YP7p58LLeaVHkEBZFzJl6W9WMmyWO3+/y5b3J6fksJvYrMhCte05l6skvaSKuBa/3t3jQ40nu6Js4mlj4ZujPRFR9vAlebfQzf/VrFVcz5/z72xMcbw3osFshuSHWPmGWs91vx/eNuJiEJiypmkKWg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UbBbnanI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4339w2W6024001;
	Wed, 3 Apr 2024 10:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=zXvMpXPiE678AdxOhY/ii
	dMD3WTsnnVZPX/wSxQze3o=; b=UbBbnanIzx0WJ9pmLun/7HX5MQBmgSvMNOhi4
	IZ6NlauKeF+RMgsqY1SBHWg/DlF1cMV3fe+yKLwr2ypICzCQQ4oWpOadVA/AoT9o
	A58PytNJEHfVsqcfkYxQsn994grz180kB4kUOg9PGJVngo/Q1Ta1Eg7EMrpJAkaw
	rptUoEyx8YS8+4iQAjP1NAlkqtDK9of354z1uVEna007kxLGnzM2V2aXsmkccNnh
	On9D8MtADglqIh3FO0aXbPuPRezgHODaAJqemq2Omt1JvxLOJEnKLLn5quxhacHZ
	0INksA5MPgigJUFjJ84yShxluXyWYvBR68S07fe6/zM1HaA3Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw899t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:44:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433AiMfh016294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:44:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:44:18 -0700
Date: Wed, 3 Apr 2024 16:14:14 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <Zg0y/pihFpqU3v6m@hu-varada-blr.qualcomm.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-2-quic_varada@quicinc.com>
 <1a6fccd3-452c-423f-b73e-cef5f9d01633@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a6fccd3-452c-423f-b73e-cef5f9d01633@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k7ycNh9ZqvOdxgEBzoJVFehihnn-Yjlh
X-Proofpoint-ORIG-GUID: k7ycNh9ZqvOdxgEBzoJVFehihnn-Yjlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=698
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030074

On Wed, Apr 03, 2024 at 09:09:15AM +0200, Krzysztof Kozlowski wrote:
> On 02/04/2024 12:34, Varadarajan Narayanan wrote:
> > +#define ICC_NSSNOC_NSSCC	10
> > +#define ICC_NSSNOC_SNOC_0	11
> > +#define ICC_NSSNOC_SNOC_1	12
> > +#define ICC_NSSNOC_PCNOC_1	13
> > +#define ICC_NSSNOC_QOSGEN_REF	14
> > +#define ICC_NSSNOC_TIMEOUT_REF	15
> > +#define ICC_NSSNOC_XO_DCD	16
> > +#define ICC_NSSNOC_ATB		17
> > +#define ICC_MEM_NOC_NSSNOC	18
> > +#define ICC_NSSNOC_MEMNOC	19
> > +#define ICC_NSSNOC_MEM_NOC_1	20
> > +
> > +#define ICC_NSSNOC_PPE		0
> > +#define ICC_NSSNOC_PPE_CFG	1
> > +#define ICC_NSSNOC_NSS_CSR	2
> > +#define ICC_NSSNOC_IMEM_QSB	3
> > +#define ICC_NSSNOC_IMEM_AHB	4
> > +
> > +#define MASTER(x)	((ICC_ ## x) * 2)
> > +#define SLAVE(x)	(MASTER(x) + 1)
>
> You already received comment to make your bindings consistent with other
> Qualcomm bindings. Now you repeat the same mistake.
>
> No, that is neither consistent nor greppble.

Sorry. Have restored the naming and posted v7.
Kindly take a look.

Thanks
Varada

