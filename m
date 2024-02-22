Return-Path: <linux-kernel+bounces-75873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21B85F01F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2095A1F2187F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F83A17743;
	Thu, 22 Feb 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R9GPLgHw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A0101EC;
	Thu, 22 Feb 2024 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573663; cv=none; b=I0ffA+7LPpL1bbUwxrpaZHD+oAh0SpqQ/nCtgd1N3iq6nswKWeZRqhgB8q7HaHmC2aOZJCJVOcIFjw3RaYW9HQ8iUxmipF1luCmaTzJeld+KKm+dDVSmpDcpi+Sy8dCepJZQ1Xim7Dstv/AcOD0ewrxBq2m2ni773MXh7wTz1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573663; c=relaxed/simple;
	bh=jyJEJt0Gb7xRr2ZCKsJm0pArk9maOscFxfGHDjAtGP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/3swkDoK30ukHstiKk0S4sqbnKSmtiGx73H9uRkENqFqNYc9rbEmppRt8a9j5624tJgYFftZTX2B+dWyP9hAwpYwjV+KcvamJd2D3ZEPQovBiuynvC52x4Z20qKC+C4HSxUxNGl/9ew0T/YgfkhclLP/3IuZHhr9iv/OJpOO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R9GPLgHw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M2O8kb011995;
	Thu, 22 Feb 2024 03:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=eDNTkxcHK8plyFVQIo0K3
	Vc2/DHgtYP/CygcJBKgdl0=; b=R9GPLgHwLvriz1c4UtZl5rumczEcPCq8wLaoJ
	uyQv2toYMG2h/Iq/splVfkr6NtVdQT3U5oiQoAr9Lc9SuiaFmlkjcJ8jfx+EaNYa
	giq6hm8cTmfFYiUXGdMM7R5bEQSL9l9XAjjGCh15cbuC3ZyIIpqxd6YT6xroTXKA
	wWcyaKB38lmaLZYBs8ti/e3Kh4FWjsKJL9njgjgSEcgKJHeAsHnqLoVWHyFjB4em
	bXTxPGRapLuwiJmHViLgn2+KyulPKd9rzC2eTlJkb609AlBNvwlvKiGVAS2HDLPt
	OFUx+vIWalt1a5gsK+ySugZ1NlJhlmmSajDQJXyAgpVpDLsdA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpjn8yhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 03:47:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M3lTSe032716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 03:47:29 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 21 Feb 2024 19:47:28 -0800
Date: Wed, 21 Feb 2024 19:47:27 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>,
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/9] drm/msm/dp: Add DP support to combo instance in
 SC7280
Message-ID: <20240222034727.GG2936378@hu-bjorande-lv.qualcomm.com>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-1-dc0964ef7d96@quicinc.com>
 <CAA8EJprXXjvanBU_HGv7X_dS3nyZ867AsvKj5+S3pnWcpsk1ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJprXXjvanBU_HGv7X_dS3nyZ867AsvKj5+S3pnWcpsk1ug@mail.gmail.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fpyEr63T8GuH8aGAsoLyFlBRtvJqLjDR
X-Proofpoint-GUID: fpyEr63T8GuH8aGAsoLyFlBRtvJqLjDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220027

On Thu, Feb 22, 2024 at 01:38:45AM +0200, Dmitry Baryshkov wrote:
> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >
> > When upstreamed the SC7280 DP controllers where described as one being
> > DP and one eDP, but they can infact both be DP or eDP.
> >
> > Extend the list of DP controllers to cover both instances, and rely on
> > the newly introduced mechanism for selecting which mode they should
> > operate in.
> >
> > Move qcom,sc7280-edp to a dedicated list, to ensure existing DeviceTree
> > will continue to select eDP.
> >
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 7b8c695d521a..1792ba9f7259 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -129,7 +129,12 @@ static const struct msm_dp_desc sc7180_dp_descs[] = {
> >  };
> >
> >  static const struct msm_dp_desc sc7280_dp_descs[] = {
> > -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> > +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
> > +       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },
> 
> I think we need to keep .connector_type here, don't we?
> 

No, Abel removes the need for that in his patches - and while that logic
is slightly broken in the RFC I think it looks good.

Regards,
Bjorn

> > +       {}
> > +};
> > +
> > +static const struct msm_dp_desc sc7280_edp_descs[] = {
> >         { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
> >         {}
> >  };
> > @@ -182,7 +187,7 @@ static const struct msm_dp_desc x1e80100_dp_descs[] = {
> >  static const struct of_device_id dp_dt_match[] = {
> >         { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
> >         { .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
> > -       { .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
> > +       { .compatible = "qcom,sc7280-edp", .data = &sc7280_edp_descs },
> >         { .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
> >         { .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
> >         { .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
> >
> > --
> > 2.25.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry

