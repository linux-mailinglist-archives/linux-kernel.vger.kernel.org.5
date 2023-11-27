Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7524B7F995B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjK0GWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjK0GWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:22:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A319AD;
        Sun, 26 Nov 2023 22:22:23 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR4pbgE019742;
        Mon, 27 Nov 2023 06:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5KdBbiFwLFtOZF7WLrJ3EbuoE7Dvt1DnypGwC+JKB+c=;
 b=avhEA42UDDVejMQhK4VftiQcVBl6J6CUZa9h23X7mvVI0vmVKTFxTTrN9bHQqVnUy5d6
 Eu4UkjnQ2053RZoHo8GwdNj+C9faAaAdsujVE3nPa25Q5y8wa+qsewUoXRWLnM4Wsszp
 ePzaDOxpNQRYXdm4OM67BtXhs24ANKGJpcEJP0nf2Mf7kINrMPOUKWlVlUu0DP0c4QVB
 YMl7HgLaGPUFiX7tkaZO78Fk9F+S96StfcsaXsP4ErRYDjOp6JIuUNNNuBNEDW350yLt
 ppcP7oLuQUO2AeWLSiw3f+y/CHKQfPp4n+WDC5eNPqYEqU9tl7HWfNBRqhRmdAcC/H05 9Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk9ppkabw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 06:22:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR6M2Qe028669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 06:22:02 GMT
Received: from [10.253.33.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 26 Nov
 2023 22:21:59 -0800
Message-ID: <f0604c25-87a7-497a-8884-7a779ee7a2f5@quicinc.com>
Date:   Mon, 27 Nov 2023 14:21:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
 <20231126060732.31764-4-quic_luoj@quicinc.com>
 <0b22dd51-417c-436d-87ce-7ebc41185860@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <0b22dd51-417c-436d-87ce-7ebc41185860@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WSi6TPtH7lrRBeDVgEeBVZJoh0jjbKug
X-Proofpoint-GUID: WSi6TPtH7lrRBeDVgEeBVZJoh0jjbKug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=907 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2023 1:31 AM, Andrew Lunn wrote:
>> +		/* There are two PCSs available for QCA8084, which support the
>> +		 * following interface modes.
>> +		 *
>> +		 * 1. PHY_INTERFACE_MODE_10G_QXGMII utilizes PCS1 for all
>> +		 * available 4 ports, which is for all link speeds.
>> +		 *
>> +		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the
>> +		 * fourth port, which is only for the link speed 2500M same
>> +		 * as QCA8081.
>> +		 *
>> +		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth
>> +		 * port, which is for the link speed 10M, 100M and 1000M same
>> +		 * as QCA8081.
>> +		 */
> 
> How are these 3 modes configured? I don't see any software
> configuration of this in these drivers. Can it only by configured by
> strapping?

The interface mode is passed in the .config_init, which is configured
by the PCS driver, the hardware register is located in the PCS, this
driver will be pushed later.

> 
> I think there should be some validation of the phydev->interface
> mode. Are ports 1-3 set to PHY_INTERFACE_MODE_10G_QXGMII? Is port 4
> interface mode consistent with the strapping?
> 
> 	  Andrew

All ports(1-4) can be PHY_INTERFACE_MODE_10G_QXGMII, if port4 is
connected with PCS0, which will works on sgmii/2500basex mode,
these configuration is controlled by register instead of boot strapping.
