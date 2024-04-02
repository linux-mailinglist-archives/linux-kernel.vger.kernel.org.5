Return-Path: <linux-kernel+bounces-127815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E765E895150
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC9228746E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663377F11;
	Tue,  2 Apr 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FqaMacyf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985D65BB7;
	Tue,  2 Apr 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055741; cv=none; b=ZLFoVEEYlwIIaHPIZjLYfrX968dXm2BWyak0Fs6bjdSjlluTJzi8Osn51Vk9avbdX0wGB/fCNBZp+hiXADnww5dUs8mfYXf1rUR08Kxa3WUhzfo+aIa2o1rKbrwIO3Vc29VVFxgC8Fidjsgix6auaE5Adq8dAVI50VmuWCMfZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055741; c=relaxed/simple;
	bh=/T8QiLAUltEloOxdzVBytB1dHViiHqqZ2ouF98lSHg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9ELntxm4rRymhpKLJbfGRSuAOUotf4qEshHRE3LAeGSmLkNAiVJxOQYTrZeAMXlY6OLFWfgnl8Od4afE7Jf9YKwVwilT3EMnvywXAk4HwWmiIEtgzc6MRSGsHgceVdEqag4e/eZAexxtHD5DuugzFLcsdtPvxeR8i0Gw8F1kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FqaMacyf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4325g5NH003009;
	Tue, 2 Apr 2024 11:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=iTMKg4XqWA7HYKpRnLW2D
	kVT8qk6FP4berfNhIn62LA=; b=FqaMacyfnlbzJqfPPIl6OGAz20WVbG8DYuS10
	q4uYA/hnsMNhdw2ZWIrtFgv/m8pUi5jMLwxkLPvc68TapB4wSqjROL6vLKw0rSHS
	EEHBqMeUsQ0t5HTxLxZoDN/84xMNIprTSNJijsLIzIU8Le6zvdOxFBr4X0ndgeGA
	kfN2R/TCSrh8VAfKGoxUP0YuX79O68vz0x3t1sS+6yvKIkG/DQOQ9vcitwBDN9zH
	iTnBVTSYvC/EbGuBxZsiVTuVd2ooOf0FT9yVmKtPefG50XlgVX0ouA4oIZRuq+7Q
	c8pLWTMd2DWNRTPbcFrTLJUwInTSEecvYWT+Lo/kdQBWrlUGQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8c2vgtrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 11:02:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432B2Eu2026808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 11:02:14 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 04:02:09 -0700
Date: Tue, 2 Apr 2024 16:32:05 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Message-ID: <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com>
 <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
 <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CE5VCo1GmHMGTc61r75_3N6ew_Wrcn3-
X-Proofpoint-GUID: CE5VCo1GmHMGTc61r75_3N6ew_Wrcn3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=911 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020080

On Tue, Apr 02, 2024 at 01:48:08PM +0300, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > Wrap icc_clk_register to create devm_icc_clk_register to be
> > > able to release the resources properly.
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > > v5: Introduced devm_icc_clk_register
> > > ---
> > >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> > >  include/linux/interconnect-clk.h |  4 ++++
> > >  2 files changed, 33 insertions(+)
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Wait. Actually,
>
> Unreviewed-by: me
>
> Please return int from devm_icc_clk_register instead of returning the pointer.

Wouldn't returning int break the general assumption that
devm_foo(), returns the same type as foo(). For example
devm_clk_hw_get_clk and clk_hw_get_clk return struct clk *?

Thanks
Varada

