Return-Path: <linux-kernel+bounces-150601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EF8AA184
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105851F213E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D1177980;
	Thu, 18 Apr 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h4KKn1zH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F6168B06;
	Thu, 18 Apr 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462789; cv=none; b=G6cUAiP2cdfaNWmiA+y4gTc6mX/UN+QxauswLdZOJoyKEbYrEOa1L6ZxrHL4uDTe2rzjsIh22RnFaOvRYXCF0nrybDVe4xxwYMYAYVHoB/nDBA5oJm5wjV29aoNSyywq5HHEWrS6cg2WRC1DqsvtoKnHVtIWxvIM+aUg/txVy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462789; c=relaxed/simple;
	bh=mxsmswwSv3MlubdkJSAH9bBgma7I297X5/cGzKeLz7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn4cwjPyaMPL1gZTFftODQL5Ee2Uu+R072lvuPKMJGQ13lQMv1JCmq/N2A0uxDgWKJhhQbGv7WuJTQ/WhqGSo2nd9npoabrxCjaTuDj90tguL2VMXwSTlkC6OTMDgE7zPMYxOYeVQl7hyAckuB+PC9QjUuGY9H3XR0WJVINw7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h4KKn1zH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I6JJvP031164;
	Thu, 18 Apr 2024 17:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=bnrzjQhNziNHAvrM2jWXW
	X33bItHGVrnqHoeBXEuOnY=; b=h4KKn1zHYpvv7htN4StCfL5fe2OlUeJkwh7Wc
	EiqzKzeL2mNkdWc+1lVCkjgm47r0p/ZXFrBuQGtox8V0zfEfn4K/VSnMBnQ5WJK3
	yTorHf1eEZybGd9zy47lXEcV6+gYnmICz15uvkw+zWyUIT7kRwEURoscz4UPcxpl
	GEfqI9qR64syFJNJKvAIDrPU5F/XrbJ4hKb3O8Ur70jre3z2W1MrKmWf5oq+23vU
	t20abfRdTv7DKuM0JI+4WFiETwMl8BnhaqqZ7IN/TXCKy2vPicAcagbvyH0MVtUH
	a8Z4WVACBjDpP0YiXufCD/I46wvn7AYY8HcHkuRDgRJWMvBXg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx51hm2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 17:52:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IHqq6o025795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 17:52:52 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 10:52:51 -0700
Date: Thu, 18 Apr 2024 10:52:51 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
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
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <20240418104330754-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <Zh5GWqt2oCNHdF_h@bogus>
 <20240417140957985-0700.eberman@hu-eberman-lv.qualcomm.com>
 <fda6e9f8-5c86-4e8f-a40b-986708e1b03b@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fda6e9f8-5c86-4e8f-a40b-986708e1b03b@broadcom.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8EQdvq8Szf_dUbX10ikuEb4a6WYUrCe_
X-Proofpoint-GUID: 8EQdvq8Szf_dUbX10ikuEb4a6WYUrCe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_16,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180128

On Wed, Apr 17, 2024 at 03:01:00PM -0700, Florian Fainelli wrote:
> On 4/17/24 14:54, Elliot Berman wrote:
> > On Tue, Apr 16, 2024 at 10:35:22AM +0100, Sudeep Holla wrote:
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
> > 
> > I was motivating the reason for using SYSTEM_RESET2. How to set the PMIC
> > register and IMEM cookie can change between chipsets. Using
> > SYSTEM_RESET2 alows us to abstract how to perform the reset.
> > 
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
> > 
> > As Dmitry pointed out, this information isn't discoverable. I suppose
> > we could technically use bootconfig or kernel command-line to convey the
> > map although I think devicetree is the right spot for this mapping.
> > 
> > - Other vendor-specific bits for PSCI are described in the devicetree.
> >    One example is the suspend param (e.g. the StateID) for cpu idle
> >    states.
> > - Describing firmware bits in the DT isn't unprecedented, and putting
> >    this information outside the DT means that other OSes (besides Linux)
> >    need their own way to convey this information.
> > - PSCI would be the odd one out that reboot mode map is not described in
> >    DT. Other reboot-mode drivers specify the mapping in the DT. Userspace
> >    that runs with firmware that support vendor reset2 need to make sure
> >    they can configure the mapping early enough.
> 
> FWIW, I read Sudeep's response as being specifically inquiring about the
> 'cookie' parameter, do you see a need for that to be in described in the DT
> or could that just be an user-space parameter that is conveyed through the
> reboot system call?

Ah, I had thought the ask was for the reboot type as well as the cookie.
We don't do this for hardware-based reboot mode cookies and I didn't see
why we should ask userspace to do something different for PSCI.
It seems to me that SYSTEM_RESET2 fits nicely with the existing design
for reboot-mode bindings.


