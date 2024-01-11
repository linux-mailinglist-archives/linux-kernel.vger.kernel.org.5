Return-Path: <linux-kernel+bounces-23815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693C82B220
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B868C287538
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB24F5F8;
	Thu, 11 Jan 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C+2m6OJn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93F4D5AA;
	Thu, 11 Jan 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BAdEQl022986;
	Thu, 11 Jan 2024 15:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DjlS7QjoT/ZajZTXdhBIzm8VFFqh56+0Yj9o9G8tWZQ=; b=C+
	2m6OJnoD2OfhrWPPMokj1zqpIHngTXN3z0HZm6REE/yvBEImPLDG7WcITPA2ySHJ
	ZhuofruGHSk+d7cFQKSiFk288U+xVkP7yexssWVRN5vrB5B8J4H+1i7908zwOASf
	bK6zpjg8yPJf1GeA88ETlQ9DiRAjzTGs2F8w5pVz0ZgJNsf8YSkpqC2CkaC1+ir9
	Q/0pQm4p5hXax9JTeGcq//Nf/oOlpzVWZJ2MO1PyXc79Zh+sfyTr+4806XuJZfc9
	xB3Rwxd5I7hslydlMBoNYeQ+7H+TdbxHpeBtBxvYL9qzs+8Z2gaZn7PpZR1MfUPW
	9G9EQx9+otpBbFE15ucQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vja9y1aq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:50:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BFo6Rs001359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 15:50:06 GMT
Received: from [10.253.37.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 07:49:56 -0800
Message-ID: <5ec26378-a5ff-4de3-b69e-806e36907db6@quicinc.com>
Date: Thu, 11 Jan 2024 23:49:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
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
        <ansuelsmth@gmail.com>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_soni@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_souravp@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110142428.52026d9e@kernel.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20240110142428.52026d9e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YTP3S5b9uvJM-jssQAH_ZJa51okpKawv
X-Proofpoint-GUID: YTP3S5b9uvJM-jssQAH_ZJa51okpKawv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=701 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110123



On 1/11/2024 6:24 AM, Jakub Kicinski wrote:
> On Wed, 10 Jan 2024 19:40:12 +0800 Luo Jie wrote:
>> The PPE(packet process engine) hardware block is available in Qualcomm
>> IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
> 
> What's the relationship between this driver and QCA8084?

The PPE (packet processing engine) is the network processing hardware 
block in QCOM IPQ SoC. It includes the ethernet MAC and UNIPHY(PCS). 
This driver is the base PPE driver which brings up the PPE and handles 
MAC/UNIPHY operations. QCA8084 is the external 2.5Gbps 4-port PHY 
device, which can be connected with PPE integrated MAC by UNIPHY(PCS).

Here is the relationship.
PPE integrated MAC --- PPE integrated UNIPHY(PCS) --- (PCS)QCA8084.

> 
> In the last month I see separate changes from you for mdio-ipq4019.c,
> phy/at803x.c and now this driver (none of which got merged, AFAICT.)
> Are you actually the author of this code, or are you just trying
> to upstream bunch of vendor code?

Yes, Jakub, there are two authors in these patch series, Lei Wei and me.
The patches are already ready for some time, the code has been verified
on the Qualcomm reference design board. These are not downstream drivers
but drivers re-written for upstream.

> 
> Now you're dumping another 10kLoC on the list, and even though this is
> hardly your first posting you're apparently not aware of our most basic
> posting rules:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
> 
> The reviewers are getting frustrated. Please, help us help you.
> Stop throwing code at the list and work out a plan with Andrew
> and others on how to get something merged...

Sorry for trouble caused, will learn about the guidance provided by
the review comments, and follow up on the guidance and have the full
internal review of the patch updates before pushing the patch series.

