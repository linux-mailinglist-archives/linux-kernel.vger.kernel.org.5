Return-Path: <linux-kernel+bounces-158395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8098B1F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C233281CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C301E502;
	Thu, 25 Apr 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oil/HACv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CA15E89;
	Thu, 25 Apr 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041107; cv=none; b=UKxXu1wIhHScb6PQCxSBezKkjD/r/OSvSbCO2QLRzu52LxriQ7oTcwU46i5jdMPn4ZGkrYCSixPGmKtpy9TU63SERqpCdiFPiaYsWd/6FOKCLZceObMKfXmt/P0nNwGBcfGFQBob34cdce+sSFUuBzOHA8b+eIH9+OZpuiaMhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041107; c=relaxed/simple;
	bh=5FdZJhSLV3YBJY0uIGY+p0noTEWh+ncuTr2qm2UWf60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/RyI+ay25b5ggsbxggcXRxafCiZ28uIlhnC/wL0Fm47omG8DsekyRO4XD1Fm1fUNgk6TC8Vw2SMzoLE2GhQidMBUTR/8wFkjnqNkEmC+tdSus+DwJgSnRiIJuN0hvL5J3TF6km3WGmNthokOIFaXTjQjQueCYz6Fwsau34b/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oil/HACv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6kEV4025830;
	Thu, 25 Apr 2024 10:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=5FdZJhSLV3YBJY0uIGY+p
	0noTEWh+ncuTr2qm2UWf60=; b=Oil/HACvl+C3Fq4wBV03pBaSFW8J2hqg3NBS2
	UH3nFwIGyjvdQzCE3n1wJY+gtRSvcCbLBX619DMGa3frsuBMHXDHAu1rnFtrTBTZ
	RVaQoFoT8MqYyXgp8SfitKWKwieLjxl5cZEb9ndRGRNyqKtMsJalj4XH72e1Ny3C
	dUaMxfqUDpB/Lf7vMrZeZTkxzWo9zjvoUW1dII5lZUYsVQcRPMDOv9NbjoQ1mtOx
	ewtdlslKBlPfDJl/YkIBc/OJojUW6EbSWNNAdWpWb33eBCodiAfnVsNLC/NRmRvh
	JQA5zYI3UyOpkDbmeeuV8YF628uFBAwczBW25AnRXtp5HwjPA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenmt2db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:31:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PAV8Am011510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 10:31:09 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 03:31:04 -0700
Date: Thu, 25 Apr 2024 16:00:58 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] clk: qcom: common: Add interconnect clocks support
Message-ID: <Ziow4mfCnRiLAFNe@hu-varada-blr.qualcomm.com>
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-5-quic_varada@quicinc.com>
 <5e2682bc-88cf-4aca-9e7d-205f4cfca989@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e2682bc-88cf-4aca-9e7d-205f4cfca989@linaro.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qAFLsJ1UusYmjjunlgfeFTOBUbJZJmHU
X-Proofpoint-ORIG-GUID: qAFLsJ1UusYmjjunlgfeFTOBUbJZJmHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_10,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=633 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250076

On Tue, Apr 23, 2024 at 01:05:16AM +0200, Konrad Dybcio wrote:
>
>
> On 4/18/24 11:23, Varadarajan Narayanan wrote:
> > Unlike MSM platforms that manage NoC related clocks and scaling
> > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > clocks and there is no NoC scaling.
> >
> > However, there is a requirement to enable some NoC interface
> > clocks for accessing the peripheral controllers present on
> > these NoCs. Though exposing these as normal clocks would work,
> > having a minimalistic interconnect driver to handle these clocks
> > would make it consistent with other Qualcomm platforms resulting
> > in common code paths. This is similar to msm8996-cbf's usage of
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
>
> One more thing that we don't seem to have squared out is how to handle
> .sync_state. We can just jerryrig icc_sync_state in here, but I'm not
> sure how that goes with some floating ideas of clk_sync_state that have
> been tried in the past

Ok. Will add that and post a new version.

Thanks
Varada

