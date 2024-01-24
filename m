Return-Path: <linux-kernel+bounces-37686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D113883B3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735B0B2170A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE701353F2;
	Wed, 24 Jan 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CK9J0d7C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5091350F4;
	Wed, 24 Jan 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131424; cv=none; b=a5vyX9RDXXojZllYwjl65xYF3VP4HL2yfevWMUNtRFEnJWYaLRXzqP2eU4YNCTE8bkwcYGJkyzLgmnjjZlOvIcKBjensY5RtuEr5XCKJhHpBU0rYoASD6Tc6ZDclih1eCFpYPcCxjUrTiTwuBHWd4regLn7VxbTpw2Qe38puO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131424; c=relaxed/simple;
	bh=yyw2wTBAUi65i4ZHKK9kqJJWvPudrQSeVdORmsL63CU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPeSGCwYq1rj4mr79I+ZJKgqOgEvIRsZQ9z00RKUWG6tk6vdgB4uXbon7LLBUcI+tbQItANitji0p5HnjTlq+Rhfq5QhKy3fesHJTDvhDrfgC3DfVYmkZ7fnmyoIfnON6oS+6iAtbCVKTdO0Fq3K44CcAD1ePdOhqD9ac+P63SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CK9J0d7C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OK8BCK011436;
	Wed, 24 Jan 2024 21:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=lEu9IuU4bGL5BCly4Dnyc
	ngQdVk/sa1XqqPwqrVMMI0=; b=CK9J0d7CIztBWGgb+6OoOhovZZMX2z5S+A1A1
	IdVAiXmAEMzNqZ6IkoF7/Mzp91HxVeekCJR6Z8oHGnC6D3YrlCZJFJxy9UcnEd8b
	h91Fk0qI0z9Dw7t1gTWgG8MZsm/+VlagR8rjfuZNCLJwbHRe1GFtPwurHr/hDIb8
	0pRHinnDdQQij7AtIO077fm5Zda4eZoSXtFzAM/dbc3vSxnEDRN0nX2QjCED2EJ9
	2F5raurBtt5+L3WL9WVRGBfpoVB9pDvQb9zPwxD5/KoP27+z16nQtc0qHYH+71eL
	iGmKa/EAMlcGuWDqoOZoDge76bk4EWWSwTTGYUmFVKjZ1Ljpg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu99b04u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 21:23:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OLNY1S011669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 21:23:34 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 13:23:34 -0800
Date: Wed, 24 Jan 2024 13:23:33 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 4/8] soc: qcom: rpmhpd: Drop SA8540P gfx.lvl
Message-ID: <20240124212333.GI2936378@hu-bjorande-lv.qualcomm.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
 <20240123-sa8295p-gpu-v3-4-d5b4474c8f33@quicinc.com>
 <CAPDyKFqre9Y0XOn5Xig3zbiqR0FQJ+cvK0VXMZRbtt0NsSE4+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqre9Y0XOn5Xig3zbiqR0FQJ+cvK0VXMZRbtt0NsSE4+w@mail.gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zWGghweUU2-EPaZhnWMy7rfUWrenPxPX
X-Proofpoint-ORIG-GUID: zWGghweUU2-EPaZhnWMy7rfUWrenPxPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_10,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401240155

On Wed, Jan 24, 2024 at 10:36:34AM +0100, Ulf Hansson wrote:
> On Wed, 24 Jan 2024 at 05:25, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >
> > On SA8295P and SA8540P gfx.lvl is not provdied by rpmh, but rather is
> > handled by an external regulator (max20411). Drop gfx.lvl from the list
> > of power-domains exposed on this platform.
> >
> > Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> I assume you are picking this via your tree? If not, please tell me if I should.
> 

That sounds good, thanks.

> Before applying, please amend the prefix of commit message header to
> be "pmdomain: ..."
> 

Thanks for noticing, I will update accordingly.

Regards,
Bjorn

> Kind regards
> Uffe
> 
> > ---
> >  drivers/pmdomain/qcom/rpmhpd.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> > index 3078896b1300..27a73ff72614 100644
> > --- a/drivers/pmdomain/qcom/rpmhpd.c
> > +++ b/drivers/pmdomain/qcom/rpmhpd.c
> > @@ -217,7 +217,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
> >         [SC8280XP_CX] = &cx,
> >         [SC8280XP_CX_AO] = &cx_ao,
> >         [SC8280XP_EBI] = &ebi,
> > -       [SC8280XP_GFX] = &gfx,
> >         [SC8280XP_LCX] = &lcx,
> >         [SC8280XP_LMX] = &lmx,
> >         [SC8280XP_MMCX] = &mmcx,
> >
> > --
> > 2.25.1
> >

