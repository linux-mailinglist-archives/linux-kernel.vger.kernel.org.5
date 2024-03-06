Return-Path: <linux-kernel+bounces-93308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F68872DEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94012890BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745921757A;
	Wed,  6 Mar 2024 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JOueeAsb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91811CAB;
	Wed,  6 Mar 2024 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698263; cv=none; b=mhuxIOx0IQAaBnKVBnqCVltFVuMpSACZSyb0SDWkB9nubQpjwM6HmqKSPDqVcafVboAqIQfA61PkXd5zc5oDlWdtS1BWLRgcY9dlb2kejtNl+lioUP8SBWCO/Ydqib15Nh+e4Qwgf3YpGmp6Bth7kH9/kwiyM0YlZAjRLExDQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698263; c=relaxed/simple;
	bh=S9DmT5mbKevtdyCyu03W73/UmaI2YtzpBqpj8eqny4E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm7aI8sAXoEUu1tu9ODJ3ewR08YZzzRgxCtLfxan5D2A+U+3SlOV9hkwQVVVGZotROLk5BEsF8xjLrJeukvLkzjO0To1AxMGQIurp7AXpS8FFifdD4x7Y9+hcTY3fJ8dBzXMMQX1llN7URKd7bsB6QGlDfHrbxkbT0zqi0/wf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JOueeAsb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4263n1p2010382;
	Wed, 6 Mar 2024 04:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=MbQLqOy/1i1A0JTlWj1D9
	9Do3QPkV+3w1+MR0O4wfvc=; b=JOueeAsbF+QSP++q1cfs4WWbbzLLRUA6zLaZd
	JosrRH8sVttX64Axe+5fqydWrzCyw9fH6GRAFnRKm9bR2Ol+L0ICImBhHTxFuVN6
	Y21MKUww+XUqLQpGyqKfJ1vBx1Uz3WgTiD2wYlCVBXrRTDX9I4Kg33p2WEEu8Vbs
	mDXM4MaG9TneXQ5YP0kzcJ4uCIXNzLW6/n5x93HMlMGNcup7j/1fYEgAiUfzxbh3
	xRS9OXL5zuOeLeTEIsnEvfqPZ+cunGd7V28LHzbPAR94L3PAcRPhgNa23IK1n6sy
	me0z6hGnJxMAwG0zGMmed94i1OjL/iC/GXMFmOVXR0s5yPoxA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpgwmr12e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 04:10:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4264AuLH008316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 04:10:56 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 20:10:56 -0800
Date: Tue, 5 Mar 2024 20:10:55 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Message-ID: <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
 <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: twA3sY1JSaS8_0RTxw2pyPQOlKZ86bAz
X-Proofpoint-ORIG-GUID: twA3sY1JSaS8_0RTxw2pyPQOlKZ86bAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_01,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=530
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060031

On Tue, Mar 05, 2024 at 10:15:19PM +0100, Konrad Dybcio wrote:
> 
> 
> On 3/4/24 14:14, Gabor Juhos wrote:
> > There are several functions which are calling qcom_scm_bw_enable()
> > then returns immediately if the call fails and leaves the clocks
> > enabled.
> > 
> > Change the code of these functions to disable clocks when the
> > qcom_scm_bw_enable() call fails. This also fixes a possible dma
> > buffer leak in the qcom_scm_pas_init_image() function.
> > 
> > Compile tested only due to lack of hardware with interconnect
> > support.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
> > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > ---
> 
> Taking a closer look, is there any argument against simply
> putting the clk/bw en/dis calls in qcom_scm_call()?

We shouldn't do this because the clk/bw en/dis calls are only needed in
few SCM calls.

Thanks,
Elliot


