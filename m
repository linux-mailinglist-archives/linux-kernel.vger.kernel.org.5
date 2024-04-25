Return-Path: <linux-kernel+bounces-158620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE668B231F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EC11C21BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C890149DE2;
	Thu, 25 Apr 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="boLIi6R+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43741494D1;
	Thu, 25 Apr 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052888; cv=none; b=g45d/bJWS++AymiPaa3ytPMdGtrgzZDuoORYl5lg8gjgOFpTTYZEXPSL3hLA5zJJjbPc6MjdefPh+DAtMi26nf4hcK+k8iXhFL+D4Cr0GPeRemlJEJK48UgdVqOqIdndBGIIRsUCiLHisH8Sl6b93Vuhj2Bi3V1gNJm0zi9XgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052888; c=relaxed/simple;
	bh=VVDERpYPM9KQxilgs5G//sA0Lmaf+Mjj63KOyRayoYA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knl2qqPhwvcorxkmwa9RVZnlSTCpFZLQPx6vaQJqMHyg3+Qlzl/UxwVSL8DfilychZVAdgc9G2A0H1nimxaQBGIfezXbwxX+73dPwuAXWqiAzHZl39tsX5xZlCMmg2YsYp29ecpWJpJ3THQPCUiFEIBx+ZyevGVj8n133qUZ3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=boLIi6R+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9x6BW001380;
	Thu, 25 Apr 2024 13:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=WDD9ufnAdqz8oMuirK7+5
	QxXew2z3pBpsyZ1Jwjt7L0=; b=boLIi6R+6EfAd0ae5YFqCZ81/Hcff19XR94gu
	iRsxQV1cj1qWjqclIGYpAeEZja6LSsJkRF5rNT8MzrdzmGPrHzL1i05N+UkikQ3X
	0+89IcHIvmiXoJ20jRXLqu4Ee2xQLX3EexEe174jlZlD3PposanJIvn/mzMcUNO/
	QZGN4KTJw35jC5TYBfB/scxiPv6KXGhxAO0mbmQvR79s3yaSUlaK2sx5I+/4alyv
	i/GSMof8oBYZns6RLweS8+DgpyTgq2REasrVjSVsOXf0CjTaUdceHHbplgqvrv+6
	P7d4ZWtoGbuBEo6ND8TqrAVkRIG+8n2l/QHvaTCG57coyc53Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0wgtwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:47:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PDlRlJ019865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:47:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 06:47:27 -0700
Date: Thu, 25 Apr 2024 06:47:26 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Jaiganesh Narayanan <njaigane@codeaurora.org>,
        Doug Anderson
	<dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain
 support
Message-ID: <Zipe7u/9ajRXa81U@hu-bjorande-lv.qualcomm.com>
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
 <ZipGRl_QC_x83MFt@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZipGRl_QC_x83MFt@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dadqXKE7q0Kd3I_QQxoWGIW_xYmiAZfD
X-Proofpoint-GUID: dadqXKE7q0Kd3I_QQxoWGIW_xYmiAZfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250100

On Thu, Apr 25, 2024 at 02:02:14PM +0200, Johan Hovold wrote:
> On Wed, Apr 24, 2024 at 08:45:31PM -0700, Bjorn Andersson wrote:
> > When a GPIO is configured as OPEN_DRAIN gpiolib will in
> > gpiod_direction_output() attempt to configure the open-drain property of
> > the hardware and if this fails fall back to software emulation of this
> > state.
> > 
> > The TLMM block in most Qualcomm platform does not implement such
> > functionality, so this call would be expected to fail. But due to lack
> > of checks for this condition, the zero-initialized od_bit will cause
> > this request to silently corrupt the lowest bit in the config register
> > (which typically is part of the bias configuration) and happily continue
> > on.
> > 
> > Fix this by checking if the od_bit value is unspecified and if so fail
> > the request to avoid the unexpected state, and to make sure the software
> > fallback actually kicks in.
> 
> Fortunately, this is currently not a problem as the gpiochip driver does
> not implement the set_config() callback, which means that the attempt to
> change the pin configuration currently always fails with -ENOTSUP (see
> gpio_do_set_config()).
> 

You're right. I was convinced that I implemented set_config() and got
lost in the indirections.

> Specifically, this means that the software fallback kicks in, which I
> had already verified.
> 

I thought you did, and found this strange.

> Now, perhaps there is some other path which can allow you to end up
> here, but it's at least not via gpiod_direction_output().
> 
> The msm pinctrl binding does not allow 'drive-open-drain' so that path
> should also be ok unless you have a non-conformant devicetree.
> 

Looking at it again, I believe you're right and this is currently dead
code, waiting to screw us over once someone opens up the code path I
thought I fixed...

> > It is assumed for now that no implementation will come into existence
> > with BIT(0) being the open-drain bit, simply for convenience sake.
> > 
> > Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")
> 
> I guess hardware open-drain mode has never been properly tested on
> ipq4019.
> 

I see no other explanation. Perhaps there were additional changes in the
downstream tree where that change came from.

> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
> >  drivers/pinctrl/qcom/pinctrl-msm.h | 3 ++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index aeaf0d1958f5..329474dc21c0 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -313,6 +313,8 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
> >  			*mask |= BIT(g->i2c_pull_bit) >> *bit;
> >  		break;
> >  	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > +		if (!g->od_bit)
> > +			return -EOPNOTSUPP;
> 
> I believe this should be -ENOTSUPP, which the rest of the driver and
> subsystem appear to use.
> 

Both error codes are used in across gpio/pinctrl subsystems. I first
went ENOTSUPP but folded, perhaps too easily, when checkpatch told me
EOPNOTSUPP was better.


I'm leaning towards us reverting the ipq4019 patch, rather than try
complete the patch, but will give this some more thought before spinning
v2.

Thank you,
Bjorn

> >  		*bit = g->od_bit;
> >  		*mask = 1;
> >  		break;
> 
> Johan

