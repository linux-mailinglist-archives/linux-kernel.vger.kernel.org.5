Return-Path: <linux-kernel+bounces-12238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83781F1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECD31C225F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854147F66;
	Wed, 27 Dec 2023 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P3WGgsZm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87447F46;
	Wed, 27 Dec 2023 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BRJvPqN020877;
	Wed, 27 Dec 2023 20:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=2quQCISfmXXvAuqhivENf
	6jVOT6ATrMLLpI3zefedDI=; b=P3WGgsZmFDboyy/qfXtOfJRWdAk/62UUyJI/s
	A+1eyQVCLWWWVq4wsAlkcd3YNo0b4nIoyqp6+Hrj73Jrzcg4fQ2ka7+l2X062EXR
	GKphQ60yjRXQRz+DkDD5z2PrF1O2SZcLyEupgN3u9V68fMm58vJ1qNx2pMg9dZwD
	KRSY+jlDS1uAevifo6aZQk+ijLIfouObj1TvvzLpeoLpmhOEWzWySL72G0ZP0DLr
	pc8EjbUPIlglsMFh3fdEPdVvT0uzoHmmXHeWhUGZNBKIOQOIkmIwSFiOrvMwlxM5
	D0kkfRUEw2nVC8ekl29SMlw+9przf000taPcpDr/UMqN7n1Nw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v8grt14t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 20:21:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BRKLWsr007498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 20:21:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Dec 2023 12:21:32 -0800
Date: Wed, 27 Dec 2023 12:21:30 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sa8295p-adp: Enable GPU
Message-ID: <20231227202130.GA1315173@hu-bjorande-lv.qualcomm.com>
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
 <20231220-sa8295p-gpu-v2-7-4763246b72c0@quicinc.com>
 <4a1c18e3-39c8-4070-ae55-b1148b3dc65b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a1c18e3-39c8-4070-ae55-b1148b3dc65b@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: inYKcTRVZQYCScIFDOT_tCHeQ41FmRKx
X-Proofpoint-ORIG-GUID: inYKcTRVZQYCScIFDOT_tCHeQ41FmRKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=701 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312270149

On Wed, Dec 27, 2023 at 02:09:47AM +0100, Konrad Dybcio wrote:
> On 22.12.2023 05:39, Bjorn Andersson wrote:
> > With the necessary support in place for supplying VDD_GFX from the
> > MAX20411 regulator, enable the GPU clock controller, GMU, Adreno SMMU
> > and the GPU on the SA8295P ADP.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> [...]
> 
> > +&gpucc {
> > +	vdd-gfx-supply = <&vdd_gfx>;
> > +	status = "okay";
> > +};
> Already enabled
> 

No, we're disabling these in sa8540p.dtsi, so they need to be re-enabled
here.

I don't remember if it's because the attempt to bring up gfx.lvl or if
it's the attempt to operate the GPU components without adequate VDD_GFX,
that is causing the issue...but either way, we don't survive boot.


It's possible that we could move the max20411 up to sa8540p.dtsi to
avoid the intermediate disable, but I'm not confident that it's "part of
the platform"...

Regards,
Bjorn

> > +
> > +&gmu {
> > +	status = "okay";
> > +};
> > +
> > +&gpu {
> > +	status = "okay";
> > +
> > +	zap-shader {
> > +		memory-region = <&gpu_mem>;
> > +		firmware-name = "qcom/sa8295p/a690_zap.mbn";
> > +	};
> > +};
> > +
> > +&gpu_smmu {
> > +	status = "okay";
> > +};
> Already enabled
> 
> 
> Konrad

