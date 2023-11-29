Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88607FD43E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjK2Kec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2Keb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:34:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FAAF4;
        Wed, 29 Nov 2023 02:34:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT8P7fL032596;
        Wed, 29 Nov 2023 10:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6xXYi+xKtEG06/HjGg2mLynpoaBkBI2GynoJOjdnHZ0=;
 b=gNttpJrSvPz4c2l1cFF/TdntqOQ5XtsMA5HI/yrXHxKYh5yARL8PBgQidDCKkGyOBAtW
 fTNT9ZFBmpWi9XUA3vTxGaNGgW2BzTbdTg2GAcF6cjEN8bYI1sMsBYR8tRtzgi9ku2DE
 xAUoUmT+wtCLl7yHyyxty7elcx4scpQp/la/KIUPRy3pz7elf11tcP9I1Didmh9TP99h
 abUJir/OY733TOKjcEC3tmtN+4y+oL0zgi5zPEmqyXALy63NJJuGl4+3pA5zk0P938Z4
 ZciqRiwPWy2rI8Ha53edaYxZv+wk4kJzXiMqwC8fbKwvqeIkBO/csfhSsJajmpiP9/ta Vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unkentd11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:34:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATAYL6w003692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:34:22 GMT
Received: from [10.253.72.234] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 02:34:19 -0800
Message-ID: <277a4cdf-fef6-4d40-baac-01d5da40ce62@quicinc.com>
Date:   Wed, 29 Nov 2023 18:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] net: phy: at803x: add QCA8084 ethernet phy support
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
 <20231126060732.31764-4-quic_luoj@quicinc.com>
 <0b22dd51-417c-436d-87ce-7ebc41185860@lunn.ch>
 <f0604c25-87a7-497a-8884-7a779ee7a2f5@quicinc.com>
 <8e4046dd-813c-4766-83fb-c54a700caf31@lunn.ch>
 <9c4c1fe7-5d71-4bb2-8b92-f4e9a136e93d@quicinc.com>
 <ZWWsLf/w82N0vwBq@shell.armlinux.org.uk>
 <a324b7d4-5265-4766-814a-36c53a84f732@quicinc.com>
 <ZWXCVPq2aE59uJs+@shell.armlinux.org.uk>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZWXCVPq2aE59uJs+@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QLy0-bQkoAkOvZUamEX-XHuVgyoLE3MH
X-Proofpoint-ORIG-GUID: QLy0-bQkoAkOvZUamEX-XHuVgyoLE3MH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_07,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=870 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 6:35 PM, Russell King (Oracle) wrote:
> On Tue, Nov 28, 2023 at 05:50:41PM +0800, Jie Luo wrote:
>>
>>
>> On 11/28/2023 5:00 PM, Russell King (Oracle) wrote:
>>> On Tue, Nov 28, 2023 at 03:16:45PM +0800, Jie Luo wrote:
>>>>>> The interface mode is passed in the .config_init, which is configured
>>>>>> by the PCS driver, the hardware register is located in the PCS, this
>>>>>> driver will be pushed later.
>>>>>
>>>>> Is this the same as how the syqca807x works? Can the PCS driver be
>>>>> shared by these two drivers?
>>>>
>>>> I am not sure syqca807x, would you point me the code path of this driver?
>>>>
>>>>>
>>>>> What i don't like at the moment is that we have two driver
>>>>> developments going on at once for hardware which seems very similar,
>>>>> but no apparent cooperation?
>>>>>
>>>>> 	Andrew
>>>>
>>>> The PCS of qca8084 is the PHY PCS, which should be new PCS driver,
>>>> in the previous chips, we don't have this kind of PHY PCS.
>>>
>>> No. PCS drivers are for MAC-side PCS drivers, not PHY-side PCS drivers.
>>>
>>>                        +-------------
>>> 		     |     PHY
>>> MAC---PCS --- link --- PCS --- ...
>>>          ^             |  ^
>>>          |	     +--|----------
>>>     For this PCS          |
>>>                     Not for this PCS
>>>
>>
>> The PCS drivers in drivers/net/pcs/ should be in PHY side, such as
>> pcs-lynx.c and pcs-xpcs.c, they are configuring the MDIO device
>> registers.
> 
> Wrong. No they are not. Just because they are accessed via MDIO does
> not mean they are in the PHY. MDIO can be used for more than just the
> PHY, and is on a lot of platforms.
> 
> LX2160A for example has many MDIO buses, and the PCSes (of which there
> are multiple inside the chip, and use pcs-lynx) are accessed through
> the MDIO bus specific to each port. They are not MMIO mapped.
> 
> The same is true on stmmac platforms, where xpcs is used - xpcs is the
> _MAC_ side PCS.
> 
> Sorry but you are wrong.
> 

OK, but it creates the PCS driver based on the MDIO device in pcs-lynx.c
looks like this PCS is located in PHY device from hardware perspective.
