Return-Path: <linux-kernel+bounces-19243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A7826A3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F6F1C21C46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E011170E;
	Mon,  8 Jan 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pF0VyO+o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7713FE4;
	Mon,  8 Jan 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4085PPNP010851;
	Mon, 8 Jan 2024 09:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uVnjU5qE0zN1BVEJIW7uX8TLCXT3C3/9s/FQ7gedwi8=; b=pF
	0VyO+oDi92UhCCTXHb0kils0LYT2umNDhwqri7MvE+LFuIvSlBXT63jRi5lfsoDJ
	Zp6f8BETIa5DX7oHLXxvLhfku421InmAB1gXR07vwLVv3LW0ZGLqmWd3n5FvGoKl
	P/KSV+GCm5xMVzVB49nFnTakZJ8Nbr55ZToeNaQw8/bL5gzyXOWEMsFRwgKMWJ9i
	23Ek/XFrXeHpYklEUZASxZYQTmzHNixu6u/7UanL3AC5YkAKCxpwE94J+VjKZtX7
	QavHOWaDKjVAgiFfHcjnhMoR6alJo++YRCDpCJ1+soW9ll/CkEiqdQGlgi7WQl/0
	psgCVS3fGh/u5+kxYu9A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3veymmbfae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 09:07:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408972Kj006927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 09:07:02 GMT
Received: from [10.253.76.26] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 01:06:55 -0800
Message-ID: <63219ada-4bc0-44df-9541-2840229febc6@quicinc.com>
Date: Mon, 8 Jan 2024 17:06:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
 <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
 <1df87389-d78c-48e0-b743-0fd11bd82b85@gmail.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1df87389-d78c-48e0-b743-0fd11bd82b85@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dBJMmOueCiwKNiVtb_v-cpc7Q5dzksgV
X-Proofpoint-GUID: dBJMmOueCiwKNiVtb_v-cpc7Q5dzksgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=829 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080077



On 1/7/2024 6:03 AM, Sergey Ryazanov wrote:
> On 06.01.2024 17:45, Andrew Lunn wrote:
>>> I just realized that the UNIPHY block is a MII (probably SGMII) 
>>> controller.
>>> Isn't it? And I expect that it responsible more then just for clock
>>> enabling. It should also activate and perform a basic configuration 
>>> of MII
>>> for actual data transmission. If so, then it should placed somewhere 
>>> under
>>> drivers/net/phy or drivers/net/pcs.
>>
>> Before we decide that, we need a description of what the UNIPHY
>> actually does, what registers it has, etc. Sometimes blocks like this
>> get split into a generic PHY, aka drivers/phy/ and a PCS driver. This
>> would be true if the UNIPHY is also used for USB SERDES, SATA SERDES
>> etc. The SERDES parts go into a generic PHY driver, and the SGMII on
>> to of the SERDES is placed is a PCS driver.
> 
> As far as I understand, UNIPHY only contains SGMII/PSGMII/whatever and a 
> simple clock controller. PCIe & USB phys are implemented in other 
> hardware blocks. See the lately merged USB support code for similar 
> IPQ5018 SoC. But I can only speak to what I found searching online and 
> checking the vendor's qca-ssdk "driver".
> 
> https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-ssdk/-/tree/NHSS.QSDK.12.4.5.r3
> 
> I hope Luo can clarify with more confidence.

Yes, Sergey. UNIPHY includes the interface mode controller(SGMII/UXGMII
PSGMII etc.) and the clock controller that provides the clocks to the
PPE(packet process engine) ports, which is the dedicated UNIPHY(PCS) for
connecting external PHY(such as qca8084 PHY) and located in the PPE
hardware block. The UNIPHY of PPE can't be used for PCIE & USB.

> 
>> The problem i have so far is that there is no usable description of
>> any of this hardware, and the developers trying to produce drivers for
>> this hardware don't actually seem to understand the Linux architecture
>> for things like this.
>>
>>> As far as I understand, we basically agree that clocks configuration 
>>> can be
>>> implemented based on the clock API using a more specialized driver(s) 
>>> than
>>> MDIO. The only obstacle is the PHY chip initialization issue explained
>>> below.
>>> Thank you for this compact yet detailed summary. Now it much more clear,
>>> what this phy chip requires to be initialized.
>>>
>>> Looks like you need to implement at least two drivers:
>>> 1. chip (package) level driver that is responsible for basic "package"
>>> initialization;
>>> 2. phy driver to handle actual phy capabilities.
>>
>> Nope. As i keep saying, please look at the work Christian is
>> doing. phylib already has the concept of a PHY package, e.g. look at
>> the MSCC driver, and how it uses devm_phy_package_join(). What is
>> missing is a DT binding which allows package properties to be
>> expressed in DT. And this is what Christian is adding.
> 
> Andrew, thank you so much for pointing me to that API and Christian's 
> work. I have checked the DT change proposal and it fits this QCA8084 
> case perfectly.
> 
> Am I right that all one has to do to solve this QCA8084 initialization 
> case is wrap phys in a ethernet-phy-package node and use 
> devm_phy_package_join() / phy_package_init_once() to do the basic 
> initialization? So simple?
> 
> I came to put my 2c in and learnt a couple of new tricks. What a nice 
> day :)
> 
> -- 
> Sergey

