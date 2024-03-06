Return-Path: <linux-kernel+bounces-93324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6395872E03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E47C1C217D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AE17543;
	Wed,  6 Mar 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e8uy4wKq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAC1401F;
	Wed,  6 Mar 2024 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698800; cv=none; b=rd4TyPhGaHYbwV8Eig1u9CczxQRpsetz2gXqmlgg6v6zWZLBI5UJtjUew6mK2RB8tds2bwtHFlOnTNwSPuW0KWpjkcX6/sltIHiKMqXr05MdN9hx3DqrLR68yaa26hZE4Gqle0LANF7Ua+7QDyWxkLS/zOEMuGKON5JKwhSY1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698800; c=relaxed/simple;
	bh=guyMjWBilmr+SKtsz66bKiuRvqFJ0Uw8Q5qocq6R9NE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iknl+E1y5lET3ZQuVDFEEuOUf0YIU6Rmritle/pYGTYjY4CIvqkQk8fATTwVu8vSwQYWipMXg1qDr330CS4/atWf23oAxLMzXQgH/fPrpRg/RL82XgNeaPKMSDxnFd8WAX/b74MsWF3ANqcgunaUD5jGb+1AtzNJI7USXKbq/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e8uy4wKq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4261Osku007934;
	Wed, 6 Mar 2024 04:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=+jJUG3WXQsxnXUjJES4QD
	5LW4ystXLkNUtaRgiFQYE8=; b=e8uy4wKqrvBNANUk5AxDiEvav+l4wQOMaMG6P
	fP6bHKIyl8oInHGiVrf3Vod9pPg9vrSQ5PL6SZy74VC8Z37tqMSHCKuJ1O7hswmI
	PRAhuP5vyh/GVHkRKwosjfjNeh/Azu9hivbdQg65i4LC1Zmqi2Gt3eFtrcYNPkoQ
	hKvR8hT9//UF2NbLwvUxjIGxXmsYNblCvbmsLj4pB/F2kJ613ENnqV5jXrH5RP5y
	QzKHXLTmOIzT6RCZjZuwDcBQXu30S3cEEoH+0cGaydafSqUKhmnoEiN4/8ycY8vq
	0+eZPUTvy4zt/+6o3GrJZ3msKFGbOm24mRAKz8Dm02ZXml/fw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp6bv9fya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 04:19:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4264JmBo006981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 04:19:48 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 20:19:48 -0800
Date: Tue, 5 Mar 2024 20:19:47 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Linux regressions mailing list <regressions@lists.linux.dev>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>
Subject: Re: Lenovo ThinkPad X13s regerssions (was Re: Linux regressions
 report for mainline [2024-02-25])
Message-ID: <20240306041947.GG3213752@hu-bjorande-lv.qualcomm.com>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
 <Zd23ZKlNnDKPaU9I@hovoldconsulting.com>
 <83c6019f-9c6f-4ad1-87d5-e4f1bdaca93c@leemhuis.info>
 <ZecjcApvdZSGRysT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZecjcApvdZSGRysT@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WCvWePgfWp9HEd6RPmVtp6fRaffZN7gP
X-Proofpoint-ORIG-GUID: WCvWePgfWp9HEd6RPmVtp6fRaffZN7gP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_01,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060031

On Tue, Mar 05, 2024 at 02:51:44PM +0100, Johan Hovold wrote:
> [ +CC: Vinod, Bjorn, Abhinav ]
> 
> On Tue, Mar 05, 2024 at 10:33:39AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [dropping Linus from CC, we can add him back later when needed]
> > 
> > On 27.02.24 11:20, Johan Hovold wrote:
> > > On Sun, Feb 25, 2024 at 01:21:46PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> > > 
> > >> Johan Hovold also deals with multiple issues affecting Lenovo ThinkPad
> > >> X13s, but he send out patch series to fix some or all of those[1], so
> > >> with a bit of luck those issues will soon be fixed as well.
> > >> https://lore.kernel.org/lkml/ZctVmLK4zTwcpW3A@hovoldconsulting.com/
> > 
> > As 6.8 final might be just five days away, could you please help me out
> > with a short status update wrt. unresolved regressions from your side if
> > you have a minute? It's easy to get lost in all those issues. :-/ :-D
> 
> Heh. Indeed. It's been a rough cycle. :)
> 
> > >> [1]
> > >> https://lore.kernel.org/lkml/20240217150228.5788-1-johan+linaro@kernel.org/
> > > 
> > > This series addresses a use-after-free in the PMIC glink driver caused
> > > by DRM bridge changes in rc1 and which can result in the internal
> > > display not showing up on boot.
> > > 
> > > The DRM/SoC fixes here have now been merged to drm-misc for 6.8.
> > 
> > What about the others from that series? Can they wait till 6.9? Or are
> > they on track for 6.8?
> 
> Vinod, the PHY maintainer, just told me he will try to get them into
> 6.8.
> 
> > > But also with these fixes, there are still a couple of regressions
> > > related to the Qualcomm DRM runtime PM rework in 6.8-rc1. I'll send
> > > separate reports to track those.
> > 
> > Any decision yet if they are going to be reverted for now?
> >
> > Am I right assuming those would fix
> > https://lore.kernel.org/lkml/Zd3kvD02Qvsh2Sid@hovoldconsulting.com/
> > which did not get even a single reply?
> 
> That was the hope, but I've managed to trigger a reset on disconnect
> once also with the runtime PM series reverted.
> 
> One of the patches from that series has already been reverted (to fix
> the VT console hotplug regression) and there is some indication that
> that was sufficient to address the issue with hotplug not being detected
> in X/Wayland too. I'm waiting for confirmation from some users that have
> not been able to use their external displays at all since 6.8-rc1, but
> it does seem to fix the X/Wayland issues I could reproduce here.
> 

I bumped my X13s to v6.8-rc7 earlier today and took it for a spin.

I was successfully able to plug/unplug my main display both in fbcon and
Wayland (sway) a number of times, I was able to boot with external
display connected and have it show up in fbcon and then survive into
sway. I tried suspending (echo mem > /sys/power/state) and got back from
that state a few times without problems.

Mixing connection/disconnection with being in suspended state was less
successful and I was able to crash the machine twice here - but I can't
say this worked before... (As previously we would not have eDP after
suspending with external display).

So, things are looking much better with -rc7, but of course, my test
scope is limited.

Regards,
Bjorn

> But either way, the reset on disconnect is still there, and have since
> been reproduced by Bjorn also on another Qualcomm platform without a
> hypervisor so that we've now got a call stack. I've heard that Abhinav
> is looking into that, but I don't know if there's any chance to have a
> fix ready this week.
> 
> Johan

