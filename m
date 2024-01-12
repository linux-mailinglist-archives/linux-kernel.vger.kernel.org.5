Return-Path: <linux-kernel+bounces-24829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22382C31B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CAF1C219C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56067317A;
	Fri, 12 Jan 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eHPoiG6N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2C6EB6E;
	Fri, 12 Jan 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CEhLdd009370;
	Fri, 12 Jan 2024 15:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=godOMp+xB/8b+SwNVvmIz5aXGAQrkx1QMjaDlquO9Jc=; b=eH
	PoiG6N3Z2r7zwDho/Kv/Xbcmza0okC+lwRUpP/vTKuSS5n1EZNU+vjLsbfJk8Ox5
	hRcocNO+5nvsRbhaer3Ip0PFBVusfMmjNhIWt5nWvJ/FvKTh/CMGSJLBLUfitB2I
	TdwAHyQdS705MYTeFF58LxyeN7AcFQo5USMQpcXU14WWFl9LRsAhuUObsn26tiWd
	sBuwpr8lWzKjbZJ+VbysqjyWNHUE6c10+6x9IZvnD6fCyEAInMLaVfIpJqv86GFQ
	tWLHgAY7qEiMBtjyen5D4b5nZtA5jwcEpe2jhBDAdv/IcDPnVwfxG1XxpsP+6Cc5
	y6vdR2ame3JkNQcLWOsw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk6ee88y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:49:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CFnowV017974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 15:49:50 GMT
Received: from [10.253.78.164] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 07:49:37 -0800
Message-ID: <29d744c3-b06b-4959-acc1-288b2804356d@quicinc.com>
Date: Fri, 12 Jan 2024 23:49:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
Content-Language: en-US
To: Simon Horman <horms@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
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
 <a72405c2-c891-4db5-9ac5-42ca1c36cafb@linaro.org>
 <20240110154414.GH9296@kernel.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20240110154414.GH9296@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ybGN_sbOMlh8_paMCeNBYLvIpmaTQ9IS
X-Proofpoint-GUID: ybGN_sbOMlh8_paMCeNBYLvIpmaTQ9IS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120124



On 1/10/2024 11:44 PM, Simon Horman wrote:
> On Wed, Jan 10, 2024 at 01:24:06PM +0100, Krzysztof Kozlowski wrote:
>> On 10/01/2024 12:40, Luo Jie wrote:
>>> The PPE(packet process engine) hardware block is available in Qualcomm
>>> IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
>>> The PPE includes integrated ethernet MAC and PCS(uniphy), which is used
>>> to connect with external PHY devices by PCS. The PPE also includes
>>> various packet processing offload capabilities such as routing and
>>> briding offload, L2 switch capability, VLAN and tunnel processing
>>> offload.
>>>
>>> This patch series enables support for the PPE driver which intializes
>>> and configures the PPE, and provides various services for higher level
>>> network drivers in the system such as EDMA (Ethernet DMA) driver or a
>>> DSA switch driver for PPE L2 Switch, for Qualcomm IPQ SoCs.
>>
>> net-next is closed.
> 
> Also, please try to avoid sending patch-sets with more than 15 patches
> for net or net-next.
> 
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#dividing-work-into-patches

Got it, at a later point when this review resumes, we will split the PPE 
driver patches into two series, one is for PPE switch core feature, 
another is for MAC/UNIPHY features. Hope this is fine.

Thanks for this comment.


