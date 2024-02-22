Return-Path: <linux-kernel+bounces-76740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867985FBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0FB1F2494A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCA14C5AA;
	Thu, 22 Feb 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XAhG3C6l"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120A14A09F;
	Thu, 22 Feb 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614291; cv=none; b=RMnf7qWZTL/W0UhBhbtUJC5zIhlQEahmnGY4d2tqc0t20mM9yregfLfRwrmlXUJ0y61YgPoS4T1AG7Ima5EM+8KqucMEe0EkD9EAGDz5bh3i3Wwc5nWwcWRrKDgNMfz5WIQZxK4nP8YYSEKff9eaipdvkKqG7Y28fYix+cQIyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614291; c=relaxed/simple;
	bh=tLdgo1sCtJ0emV13YZ9Zs1IhgApVirrJo8aoC37yYq8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR+x7JcKKqBJJ9rZtoYlZEUc+pFVWSO8VXbjn05Z0e0lGFu36DtBylhOz/EFpxlK2paIYFhgK/zEBpIJTXOeJj1pPw7Aqraj/vBAywEndymRFJE7ALl3r0IIinaGWnFqIBkvq4yER/gHxmYy5YnS1e/p+Xj+9A6lJ+ai3Q10u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XAhG3C6l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M7iWuK024680;
	Thu, 22 Feb 2024 15:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=Q41hDQ++x7HXRNek8ydp2
	FcmEDLeuAZTGmbaK9Fam8g=; b=XAhG3C6lKi+6qZ19iMOchCk/0cDyANDay/Q3Y
	lEh8TvwZ5UBwIJDY4wWs/HPpeo0BtMaSCWpf1YtcmNTYR2paWzQJ8xZ7zJIGD3WU
	0ORyEvIkCr7kUttnOOf8UIYCis3PE5mYLsctdmyHZGlAJC5EqHPz01wDzdFkMnjP
	pH8OloFfPgKn7AvFEwdUkxRNYm+qOIiIrbuRaC26myhT3SgAttt/CKF6Ja7zd+n2
	r5DP0NGSVvadR4pltqz0hCetClweaVc8Zb5moe5iQyI9rS7xXX2y+CAli8elJk9F
	DJi1U+HtbCWt1e7olBrRK7Xyomu/1amnNjH9/wSLOYzruf08A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24ah67a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:04:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MF4Oqx032174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:04:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 07:04:24 -0800
Date: Thu, 22 Feb 2024 07:04:23 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson
	<dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
Message-ID: <20240222150423.GI2936378@hu-bjorande-lv.qualcomm.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
 <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org>
 <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
 <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org>
 <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cohb87XPDhqkiAa09wtNUJyEMXFtcRPd
X-Proofpoint-ORIG-GUID: Cohb87XPDhqkiAa09wtNUJyEMXFtcRPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220120

On Thu, Feb 22, 2024 at 11:46:26AM +0200, Dmitry Baryshkov wrote:
> On Thu, 22 Feb 2024 at 11:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> >
> >
> > On 2/22/24 10:04, Dmitry Baryshkov wrote:
> > > On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > >>
> > >>
> > >>
> > >> On 2/22/24 00:41, Dmitry Baryshkov wrote:
> > >>> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> > >>>>
> > >>>> The max frequency listed in the DPU opp-table is 506MHz, this is not
> > >>>> sufficient to drive a 4k@60 display, resulting in constant underrun.
> > >>>>
> > >>>> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
> > >>>> fix this.
> > >>>
> > >>> I think we might want to keep this disabled for ChromeOS devices. Doug?
> > >>
> > >> ChromeOS devices don't get a special SoC
> > >
> > > But they have the sc7280-chrome-common.dtsi, which might contain a
> > > corresponding /delete-node/ .
> >
> > What does that change? The clock rates are bound to the
> > SoC and the effective values are limited by link-frequencies
> > or the panel driver.
> 
> Preventing the DPU from overheating? Or spending too much power?
> 

Perhaps I'm misunderstanding the implementation then, are we always
running at the max opp? I thought the opp was selected based on the
current need for performance?

Regards,
Bjorn

> -- 
> With best wishes
> Dmitry

