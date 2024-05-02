Return-Path: <linux-kernel+bounces-165917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F58B935E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151BD1F2319E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D117C67;
	Thu,  2 May 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LOtZw5en"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A414F98;
	Thu,  2 May 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616496; cv=none; b=C1aV8gA2ElvLsEqUp5vYPP3scHKmGZAvoedi7Y4McOEefM3iTmsiPxY6abMB8ULGYPbgZOS9r2xdZZL47Of+3Dl8+J3gpJEqghVEL0zV79M2oB6oeVhsDWNZu3e3jH22MND/F3tyIq43ifHt2f97LvMMSVRDQUV5LeM9NlSyWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616496; c=relaxed/simple;
	bh=0SkoUc/gj2ccBJpeBBjFbDOe8ESeYkfD46hLfmF3o7s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHivfB5qeYrRxLNHG7tZ/+IfjhR3jkBTck5Zp4wHo9Lev/x577AoZVmAE182uV5JoIyf3vxbnONRrNTfjgm60/QtsVSxqUvJliAIHaEis0q8nEHhdpeSRnIcxdtEXVe0/OxVEWXuJco7s0KDVLyquAjSi2FlJDYckZ7sXvjYNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LOtZw5en; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4420xbLm002676;
	Thu, 2 May 2024 02:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=XkgoEJf0wa4jbau0oH/37
	Shhuh12JPc5AkUPCGbmRJQ=; b=LOtZw5en/66GLjJAShz6IQXkS8+/lZ6x2vXJr
	21dPuXEWaoJ8wRn6BIsMuTBj5nw+JKodiac26w5DI6SspNWDYgxZ2C6oSwSdrLZj
	KhzdWcLcO9iCGO6wnwncnnX7OgxCJYINB6yO05zeSPGFwn5w5Lihu3/eC12BOnfI
	5/R6QGt/9snFeBi+tpzqgrsT/+8Ew5YH/TARMEDcGgJvQW/KIiegVKLMu6JxyGNN
	M0X2P5Z4qSQs8l63cgwPCriacZA8kQ+h9rZG1hKXCYdHVTxfT2zXfjX4Mjns2Zy/
	I4dmF1K009GMdvaz5iRyFgeHbVPlFWJNo8ljGLz8AVysQaCSw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu71jauy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 02:21:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4422LHSh029273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 02:21:17 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 19:21:16 -0700
Date: Wed, 1 May 2024 19:21:16 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Florian Fainelli <florian.fainelli@broadcom.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Sebastian
 Reichel" <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "Satya Durga Srinivasu
 Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <20240501190823313-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <Zh5GWqt2oCNHdF_h@bogus>
 <48f366f5-4a17-474c-a8e3-6d79c9092d62@broadcom.com>
 <20240419123847.ica22nft3sejqnm7@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419123847.ica22nft3sejqnm7@bogus>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V901gX_zoIsSIZykcHNca33lKpbonAM7
X-Proofpoint-ORIG-GUID: V901gX_zoIsSIZykcHNca33lKpbonAM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405020008

On Fri, Apr 19, 2024 at 01:38:47PM +0100, Sudeep Holla wrote:
> On Wed, Apr 17, 2024 at 10:50:07AM -0700, Florian Fainelli wrote:
> > On 4/16/24 02:35, Sudeep Holla wrote:
> > > On Sun, Apr 14, 2024 at 12:30:23PM -0700, Elliot Berman wrote:
> > > > The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
> > > > reset types which could be mapped to the reboot argument.
> > > >
> > > > Setting up reboot on Qualcomm devices can be inconsistent from chipset
> > > > to chipset.
> > >
> > > That doesn't sound good. Do you mean PSCI SYSTEM_RESET doesn't work as
> > > expected ? Does it mean it is not conformant to the specification ?
> > >
> > > > Generally, there is a PMIC register that gets written to
> > > > decide the reboot type. There is also sometimes a cookie that can be
> > > > written to indicate that the bootloader should behave differently than a
> > > > regular boot. These knobs evolve over product generations and require
> > > > more drivers. Qualcomm firmwares are beginning to expose vendor
> > > > SYSTEM_RESET2 types to simplify driver requirements from Linux.
> > > >
> > >
> > > Why can't this be fully userspace driven ? What is the need to keep the
> > > cookie in the DT ?
> > >
> > >
> >
> > Using the second example in the Device Tree:
> >
> > mode-bootloader = <1 2>;
> >
> > are you suggesting that within psci_vendor_sys_reset2() we would look at the
> > data argument and assume that we have something like this in memory:
> >
> > const char *cmd = data;
> >
> > cmd[] = "bootloader 2"
> >
> > where "bootloader" is the reboot command, and "2" is the cookie? From an
> > util-linux, busybox, toybox, etc. we would have to concatenate those
> > arguments with a space, but I suppose that would be doable.
> >
> 
> Yes that was my thought when I wrote the email. But since I have looked at
> existing bindings and support in the kernel in little more detail I would say.
> So I am not sure what would be the better choice for PSCI SYSTEM_RESET2
> especially when there is some ground support to build.
> 
> So I am open for alternatives including this approach.

If we can't go with the DT approach, my preference would be to go with a
bootconfig and sysfs for controlling the mappings, although I don't
think userspace need/should control the mappings of cmd -> cookies.

I wanted to check if you are okay with proceeding with the reboot-mode
DT bindings approach unless we have some other better standard? If yes,
do you have any preference based on Konrad's comment [1]? I can send out
v3 with the couple comments from Dmitry and Krzysztof's addressed.

Thanks,
Elliot

[1]: https://lore.kernel.org/all/20240419123847.ica22nft3sejqnm7@bogus/

