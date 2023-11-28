Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DB7FB64B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbjK1JvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjK1JvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:51:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A442DD;
        Tue, 28 Nov 2023 01:51:22 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS92Jim001270;
        Tue, 28 Nov 2023 09:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x3VuEoTEYQ/pyLlSPNqK4bzWJTAHrnd0D4Sm8XSCgyA=;
 b=Rrxrx8Z7BINkdDBoUmEp2JQ/XL9Rj9lIk/DPkuwQ/9KERXfr60LIEWCkopPyiUIOYBGh
 Il6Awg4M3LDi7FKDM1JLRr6CrGL461CdHU+NMV1ZV6htkDQ7Hh9SXHD0wXiNlJfzgsKg
 Ckh39HC5GkM9VCSBsQq3b556CiqM40P8VQp2fybJvfh/w0swni87M7jfTxwTP+EFvlDd
 NxxSH066Uph+2kR03LlG0A0kp06KHzmcWkq8qy4PtELFsirlhsHSH0+ng1Cb6/t4uk1S
 vihtkjg91wqqKdWTjOnrSt8f/xRWbTfo32i04nS//FVANfJtVud6RT1LyQxuk2g0waRD jQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un02h1u53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 09:51:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS9oluF032645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 09:50:47 GMT
Received: from [10.253.72.234] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 01:50:43 -0800
Message-ID: <a324b7d4-5265-4766-814a-36c53a84f732@quicinc.com>
Date:   Tue, 28 Nov 2023 17:50:41 +0800
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
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZWWsLf/w82N0vwBq@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9_16NBdSU2EYQ7K_JFS6gQk8ZNMaNUE3
X-Proofpoint-ORIG-GUID: 9_16NBdSU2EYQ7K_JFS6gQk8ZNMaNUE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_08,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=741 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 5:00 PM, Russell King (Oracle) wrote:
> On Tue, Nov 28, 2023 at 03:16:45PM +0800, Jie Luo wrote:
>>>> The interface mode is passed in the .config_init, which is configured
>>>> by the PCS driver, the hardware register is located in the PCS, this
>>>> driver will be pushed later.
>>>
>>> Is this the same as how the syqca807x works? Can the PCS driver be
>>> shared by these two drivers?
>>
>> I am not sure syqca807x, would you point me the code path of this driver?
>>
>>>
>>> What i don't like at the moment is that we have two driver
>>> developments going on at once for hardware which seems very similar,
>>> but no apparent cooperation?
>>>
>>> 	Andrew
>>
>> The PCS of qca8084 is the PHY PCS, which should be new PCS driver,
>> in the previous chips, we don't have this kind of PHY PCS.
> 
> No. PCS drivers are for MAC-side PCS drivers, not PHY-side PCS drivers.
> 
>                       +-------------
> 		     |     PHY
> MAC---PCS --- link --- PCS --- ...
>         ^             |  ^
>         |	     +--|----------
>    For this PCS          |
>                    Not for this PCS
> 

The PCS drivers in drivers/net/pcs/ should be in PHY side, such as
pcs-lynx.c and pcs-xpcs.c, they are configuring the MDIO device
registers.
