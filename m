Return-Path: <linux-kernel+bounces-149270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0BA8A8E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7C61F21AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0413A25E;
	Wed, 17 Apr 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R9CkucTj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3212E1DE;
	Wed, 17 Apr 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390928; cv=none; b=Wa+IWGgcHn53cNMNAKxgOBQsgAHDl4CWib8cwPY/vTZ/Dg/75RrWL/B64wmR9E+hsk0mi2jbI77z9Vz48OH6ifIZOuQNh7rIjAx8GqFn3ZFtDQMfmesaYDQWUp2N8RDX5MTDzqSEl9XjrJbdDeHBR6PQeyaTPh4M7jrfXLVL99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390928; c=relaxed/simple;
	bh=ev4z2iRO1kF+bMaP55rRGKH6OK9Jeje9YeGmXIt+15g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJlFzAfQ9/cO7HZPvG35hAN0SfVWMCYKgD+FIvZwZB4jTodrMCoV1Xi7wYj/Igv8Ejbxsgj+Z9w7a2RxJMGiNMN/v8Le5/4jnTXUhP+AAvEDg8+fGHd4cQ7YFrQB77CkR2BEFohWIWCh8yJpSWhPkcBM+XRPNL2D0gBGTXXOLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R9CkucTj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HLSujJ016011;
	Wed, 17 Apr 2024 21:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=TDIAnHm/ZUhSuPlUruXFm
	A+SpAnGyjShzKLJ5rfhgtk=; b=R9CkucTjyCITUuWsyhAuUdunoCJCAiMlyGV3e
	mGr3/PoGdVF2ayXNRRglagEmhe3daC22jhL2L2yiM7SFQM+ZJ4O5jIp5MjIl06LC
	JKqSqDXVsvExdyllvHCfZc41Ge13iTcnsjq1ptr3RYpinYDIpCL5voD8arn7WPhz
	++v2JF02IvloWwx3nKXLyNUDUP98IAoG+4whaRnn1a6zCt8XLsnlGBaiNnpz2sup
	5Nz/CS1gftLURBMutCLa+CHKnml/OXgf5+mpKDsMQT5WccgwfJ73gsLV/go5Qqdo
	KfDEvghRESRSCW731UaSqT2OxFkL5t8tsZuJGFCr1eUUZbzAA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8auth2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 21:55:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HLsggm015445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 21:54:42 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 14:54:41 -0700
Date: Wed, 17 Apr 2024 14:54:41 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Message-ID: <20240417140957985-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <Zh5GWqt2oCNHdF_h@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zh5GWqt2oCNHdF_h@bogus>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fj2qyuwf4HChIqXQIWRk-MgKV3h44KJW
X-Proofpoint-GUID: Fj2qyuwf4HChIqXQIWRk-MgKV3h44KJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=846 clxscore=1011 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170156

On Tue, Apr 16, 2024 at 10:35:22AM +0100, Sudeep Holla wrote:
> On Sun, Apr 14, 2024 at 12:30:23PM -0700, Elliot Berman wrote:
> > The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
> > reset types which could be mapped to the reboot argument.
> >
> > Setting up reboot on Qualcomm devices can be inconsistent from chipset
> > to chipset.
> 
> That doesn't sound good. Do you mean PSCI SYSTEM_RESET doesn't work as
> expected ? Does it mean it is not conformant to the specification ?
> 

I was motivating the reason for using SYSTEM_RESET2. How to set the PMIC
register and IMEM cookie can change between chipsets. Using
SYSTEM_RESET2 alows us to abstract how to perform the reset.

> > Generally, there is a PMIC register that gets written to
> > decide the reboot type. There is also sometimes a cookie that can be
> > written to indicate that the bootloader should behave differently than a
> > regular boot. These knobs evolve over product generations and require
> > more drivers. Qualcomm firmwares are beginning to expose vendor
> > SYSTEM_RESET2 types to simplify driver requirements from Linux.
> >
> 
> Why can't this be fully userspace driven ? What is the need to keep the
> cookie in the DT ?

As Dmitry pointed out, this information isn't discoverable. I suppose
we could technically use bootconfig or kernel command-line to convey the
map although I think devicetree is the right spot for this mapping.

- Other vendor-specific bits for PSCI are described in the devicetree.
  One example is the suspend param (e.g. the StateID) for cpu idle
  states.
- Describing firmware bits in the DT isn't unprecedented, and putting
  this information outside the DT means that other OSes (besides Linux)
  need their own way to convey this information.
- PSCI would be the odd one out that reboot mode map is not described in
  DT. Other reboot-mode drivers specify the mapping in the DT. Userspace
  that runs with firmware that support vendor reset2 need to make sure
  they can configure the mapping early enough.

Thanks,
Elliot


