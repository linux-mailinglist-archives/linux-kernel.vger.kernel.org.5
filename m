Return-Path: <linux-kernel+bounces-29152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C68309B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6235F1F22190
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97F21A10;
	Wed, 17 Jan 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXHsUFqu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C68219F1;
	Wed, 17 Jan 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505199; cv=none; b=dcGezV75UKZVOndlE/gdUJ/zu0Eg1RNEyue+j/0yK0rOQ/wQvRWHDnBaDW3ho4ndn7rx1gVlZb5HSkyGSsIdH81lrPhfEuwioiKyMi96VSfSfk/fbOUl6CttXciDODMOg5tXeBhgBijQa74LvZDWQkQJ/yPeUb59l/82LCv20wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505199; c=relaxed/simple;
	bh=xAKMrhuiOukQEKS5pJ7/xw71Z9SHcT0YAv7W09qM11Q=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=AQO4cTMKOBalrqL6jWvR5MGTlT51kmciqevtUEbgdZEH4gPZ8h+hrL3mTkjlyHbdAWH28JyEqLE/iKlq0bvmcaSMiA+OT6/ocTZA3eBEyFFCqRGBwUlSvEASxvdjajAkCYPB/RvYq/Cu5nlT81sXx3Yqtos2ZyAVD9qB7raKp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXHsUFqu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8m6Yw010290;
	Wed, 17 Jan 2024 15:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lqcZoRCRAGlCFSFZQ18HYf55C6lUN1QWW7BD4CzZ8SA=; b=aX
	HsUFquQ7zWim5EAjjnief79OxjVFjrnAbErXMVPMst4Vspq7dZVjFvi3ny7HvNRL
	YS1dIviKZqwzNGI7bUM+QkR3QVGDBSz673dJMP4ojMhXyudDy6hzMexflckWA7Ab
	laOnAzB1WFbOg26vG29g13O5cRmAh4Lta4tuxcMouACqQJ1bLbKaVxCgrFV5cHqh
	je6NDNBfVDwaeb01k5XhGzsfWwEoLfVMuZUlBAxo+MAJPTcMl3F9jfK1IZQOb3XA
	aG4nZiQ6l2RJ8wWk+Bm2FA9iiY02ymvMBJF29of78DsHM/eyF7r8Izv58PK1xk2N
	vGgr5MawQGDkGAKO4K4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6qxhdeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:25:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFPqss004679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:25:52 GMT
Received: from [10.253.79.191] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:25:41 -0800
Message-ID: <a7356a9b-fc55-4efc-9266-0cef21730d97@quicinc.com>
Date: Wed, 17 Jan 2024 23:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jie Luo <quic_luoj@quicinc.com>
Subject: Re: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
To: Christian Marangi <ansuelsmth@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ryazanov.s.a@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110142428.52026d9e@kernel.org>
 <5ec26378-a5ff-4de3-b69e-806e36907db6@quicinc.com>
 <65a17d68.050a0220.cf6ea.e78b@mx.google.com>
Content-Language: en-US
In-Reply-To: <65a17d68.050a0220.cf6ea.e78b@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2qgt36U1wFrD4gIUJ3HcrKsz2ZtWJbOK
X-Proofpoint-ORIG-GUID: 2qgt36U1wFrD4gIUJ3HcrKsz2ZtWJbOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_09,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=715
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170111



On 1/13/2024 1:56 AM, Christian Marangi wrote:
> On Thu, Jan 11, 2024 at 11:49:53PM +0800, Jie Luo wrote:
>>
>>
>> On 1/11/2024 6:24 AM, Jakub Kicinski wrote:
>>> On Wed, 10 Jan 2024 19:40:12 +0800 Luo Jie wrote:
>>>> The PPE(packet process engine) hardware block is available in Qualcomm
>>>> IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
>>>
>>> What's the relationship between this driver and QCA8084?
>>
>> The PPE (packet processing engine) is the network processing hardware block
>> in QCOM IPQ SoC. It includes the ethernet MAC and UNIPHY(PCS). This driver
>> is the base PPE driver which brings up the PPE and handles MAC/UNIPHY
>> operations. QCA8084 is the external 2.5Gbps 4-port PHY device, which can be
>> connected with PPE integrated MAC by UNIPHY(PCS).
>>
>> Here is the relationship.
>> PPE integrated MAC --- PPE integrated UNIPHY(PCS) --- (PCS)QCA8084.
>>
>>>
>>> In the last month I see separate changes from you for mdio-ipq4019.c,
>>> phy/at803x.c and now this driver (none of which got merged, AFAICT.)
>>> Are you actually the author of this code, or are you just trying
>>> to upstream bunch of vendor code?
>>
>> Yes, Jakub, there are two authors in these patch series, Lei Wei and me.
>> The patches are already ready for some time, the code has been verified
>> on the Qualcomm reference design board. These are not downstream drivers
>> but drivers re-written for upstream.
>>
>>>
>>> Now you're dumping another 10kLoC on the list, and even though this is
>>> hardly your first posting you're apparently not aware of our most basic
>>> posting rules:
>>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
>>>
>>> The reviewers are getting frustrated. Please, help us help you.
>>> Stop throwing code at the list and work out a plan with Andrew
>>> and others on how to get something merged...
>>
>> Sorry for trouble caused, will learn about the guidance provided by
>> the review comments, and follow up on the guidance and have the full
>> internal review of the patch updates before pushing the patch series.
> 
> I renew my will of helping in any kind of manner in this, I love the
> intention for EDMAv2 to have an upstream driver instead of SSDK, hoping
> in the future to also have the same treatement for EDMAv1 (it's really a
> pitty to have a support hole with ipq807x not supported)
> 
> Feel free to send an email or anything, considering this is massive, an
> extra eye before sending might make things better than reaching (I can
> already see this) a massive series with at least 20 revision given the
> complexity of this thing.
> 

Thanks Christian for the help. Yes, the EDMAV2 driver will be posted 
some time after net-next is reopen and after this PPE driver patch 
series resumes. The EDMAv2 driver will be posted as separate driver 
series, which depends on this PPE driver. Currently we plan to post the 
EDMAv2 driver support for IPQ5332 and IPQ9574 firstly. For IPQ807x, it 
is a driver for an older architecture as you can see, but we will 
consider this for the future.

We will certainly review it internally before publishing it later for 
upstream review.

