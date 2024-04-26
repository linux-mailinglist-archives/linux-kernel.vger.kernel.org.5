Return-Path: <linux-kernel+bounces-160778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636228B42CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0ACB21F33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB653A1CD;
	Fri, 26 Apr 2024 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GMB7FAU+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B434C8C;
	Fri, 26 Apr 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175069; cv=none; b=sZljz2SBNopdR8k/QhjQTx4nbvjZ491I0dE6dh35+P1XOT0dsdnbwgduVoVtc51NQTTg9qTPNpiAUG9eH8444DWO2K2A1fyS/vEV5zbCu+1dAdkkFLvgoACKV12AHIf0xwranBm6Nb4ucZGX/kuGbpkOchh0yDmqQfncS50Egfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175069; c=relaxed/simple;
	bh=VjnxGuvPOCHw/9I5pDPbvU2HDjwTkVBHsu9VkyFjC2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmXIMmt2/INgBWvorpDmln6E+uaC1WEJZOOxxW/TaAWBkWY7huM5LJXtafRaUmjtrf27BsDcYtKyJnywBuJLxsFI9QMi/zvNFTkNQqLjehopai0tDqiDJRPU+whajE4GznRSo7YQcciyYVm/gvE7RU/Cm7ftC8bf2T/m3KlMkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GMB7FAU+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QMEfta027231;
	Fri, 26 Apr 2024 23:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	qcppdkim1; bh=fvZQEOMEBMhpsqY4aqtd8hxe5+VAEhLT1fCgDKvfvvc=; b=GM
	B7FAU+45LCPYMJ/MUNgt+1RkhC271XUlinQSe+K54fnKLKN5Gm5o68AygFgTW2oy
	nMCnKpJVFgdYZL6OztEiWl7Og6suWcaeeSlab6xuR6IJwiWxm+R3yucII8XNZZmn
	oHH//bZOs//I/hUyrhjU4KjgngGdCEEs8EfJrOAmTjY/3VGT51wRP94qYQE3EP1b
	lI8B7ABr0T+GRgFwXHiqhZcjKuI94/R7/DMikixvs6ApyFfjhtwhnguyGfpdWhuq
	JDRrFbdI1jfb7zPzZCV3u3IbET1Mnhvi3GbB/OsNOWcYcwenRpIYDgxyRaD5vAqC
	URupSEslvpumLE2Bb6Rw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr88fhvmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 23:43:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QNhutm023766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 23:43:56 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 16:43:56 -0700
Date: Fri, 26 Apr 2024 16:43:54 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Brian Norris <computersforpeace@gmail.com>
CC: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jaiganesh Narayanan
	<njaigane@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain
 support
Message-ID: <Ziw8OrNS55AtyDkI@hu-bjorande-lv.qualcomm.com>
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
 <ZipGRl_QC_x83MFt@hovoldconsulting.com>
 <CAN8TOE_Vd9c2eYgomhu_ukofTeO9eK8Yhrtt-8BQckmJnGfj6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN8TOE_Vd9c2eYgomhu_ukofTeO9eK8Yhrtt-8BQckmJnGfj6w@mail.gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ifl1ivFekn3THFMt8QS6P6VNvuH_5K65
X-Proofpoint-GUID: Ifl1ivFekn3THFMt8QS6P6VNvuH_5K65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_20,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260167

On Fri, Apr 26, 2024 at 03:08:06PM -0700, Brian Norris wrote:
> Hi Johan, Bjorn,
> 
> On Thu, Apr 25, 2024 at 5:02 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Wed, Apr 24, 2024 at 08:45:31PM -0700, Bjorn Andersson wrote:
> > > When a GPIO is configured as OPEN_DRAIN gpiolib will in
> > > gpiod_direction_output() attempt to configure the open-drain property of
> > > the hardware and if this fails fall back to software emulation of this
> > > state.
> > >
> > > The TLMM block in most Qualcomm platform does not implement such
> > > functionality, so this call would be expected to fail. But due to lack
> > > of checks for this condition, the zero-initialized od_bit will cause
> > > this request to silently corrupt the lowest bit in the config register
> > > (which typically is part of the bias configuration) and happily continue
> > > on.
> 
> Apologies if I broke something here.

False alarm on the breakage part, I got lost in the software layers.

> Both the pinctrl subsystem and
> the wide world of diverse QCOM chips can be complicated beasts. I
> definitely could have missed things along the way. (And on first
> glance, it seems like you may have found one. I definitely did not
> consider the gpiod_direction_output() "emulation" behavior here when
> submitting this.)
> 
> But I can't tell based on subsequent conversation: are you observing a
> real problem, or is this a theoretical one that only exists if the
> gpiochip driver adds set_config() support?
> 

There is a problem that if a non-ipq4019 device where to be pinconf'ed
for open-drain, the outcome would be unexpected and I have a concern
that someone one day would implement set_config().

So, I'd like to fix this, but my argumentation is at least wrong.

> > > Fix this by checking if the od_bit value is unspecified and if so fail
> > > the request to avoid the unexpected state, and to make sure the software
> > > fallback actually kicks in.
> >
> > Fortunately, this is currently not a problem as the gpiochip driver does
> > not implement the set_config() callback, which means that the attempt to
> > change the pin configuration currently always fails with -ENOTSUP (see
> > gpio_do_set_config()).
> >
> > Specifically, this means that the software fallback kicks in, which I
> > had already verified.
> >
> > Now, perhaps there is some other path which can allow you to end up
> > here, but it's at least not via gpiod_direction_output().
> >
> > The msm pinctrl binding does not allow 'drive-open-drain' so that path
> > should also be ok unless you have a non-conformant devicetree.
> 
> The ipq4019 binding does:
> https://git.kernel.org/linus/99d19f5a48ee6fbc647935de458505e9308078e3
> 

Perhaps we could convert that to yaml?

> This is used in OpenWrt device trees.
> 

Thanks, I couldn't find a user, so this was helpful input for deciding
the path forward.

> > > It is assumed for now that no implementation will come into existence
> > > with BIT(0) being the open-drain bit, simply for convenience sake.
> > >
> > > Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")
> >
> > I guess hardware open-drain mode has never been properly tested on
> > ipq4019.
> 
> It was quite some time ago that I wrote and tested this, and per the
> above, I easily could have missed things. (Plus, the open drain
> configuration may not have much practical effect on the systems in
> question, so certain errors may not even be observable.)
> 
> But I do recall seeing the code in question activate. And inspection
> shows that the pinconf_apply_setting() -> ... msm_config_group_set()
> path is non-dead code here, for appropriate device trees.
> 

Thank you for taking a look, Brian. This was valuable input. I will
rework this to have a valid motivation - at least.

> I can try to fire up my development devices again and see what's up if
> that helps, but I won't have time to do that in the next few days.
> 

As my observation was incorrect, I don't think that is urgent.

Regards,
Bjorn

