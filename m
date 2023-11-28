Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231817FB283
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbjK1HRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbjK1HRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:17:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E7D4B;
        Mon, 27 Nov 2023 23:17:10 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS5TPPG009575;
        Tue, 28 Nov 2023 07:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x6K4f+OPEftNFmuo369lliTD2CG6kzo5gCB7A0J1JUo=;
 b=HvKJb6X7jfrCJ/jBEjfvG8idvHVgOGLW7sSR/9XkZ0XgfAQT2dCVwQ3FlgMr1zHLv7Bd
 k0Qde/VsA4P1krjzB+vDDfFRQR8SvjZADITqwI105hwueMJ+zKEpm/nn75DmzHyMTING
 IYcE+45JEvFLVj56O2vwP3bBiGmKYglh6nbdia0QuOSSxG6YwxkaYodcUm+uDAgxrtNK
 D8havENIU+ItbQVt9xTRMg/Ue8UqryiMsW8sMJbLLcbHS3vorLCA1I78mcNvo1Sk2dsI
 FJiwC1SDa22bRSdxSJbhUiMgQBo69znm/hwWorBvcPDFhGvhY6KStjUB/F33Mpih2Pas Qg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt632mk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:16:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS7GpMj014522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 07:16:51 GMT
Received: from [10.253.72.234] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 27 Nov
 2023 23:16:47 -0800
Message-ID: <9c4c1fe7-5d71-4bb2-8b92-f4e9a136e93d@quicinc.com>
Date:   Tue, 28 Nov 2023 15:16:45 +0800
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
 <f0604c25-87a7-497a-8884-7a779ee7a2f5@quicinc.com>
 <8e4046dd-813c-4766-83fb-c54a700caf31@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <8e4046dd-813c-4766-83fb-c54a700caf31@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sQivrcbt6sr1381r_AlFHt39Y1KM7cWh
X-Proofpoint-ORIG-GUID: sQivrcbt6sr1381r_AlFHt39Y1KM7cWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_05,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=734 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/2023 9:22 PM, Andrew Lunn wrote:
> On Mon, Nov 27, 2023 at 02:21:46PM +0800, Jie Luo wrote:
>>
>>
>> On 11/27/2023 1:31 AM, Andrew Lunn wrote:
>>>> +		/* There are two PCSs available for QCA8084, which support the
>>>> +		 * following interface modes.
>>>> +		 *
>>>> +		 * 1. PHY_INTERFACE_MODE_10G_QXGMII utilizes PCS1 for all
>>>> +		 * available 4 ports, which is for all link speeds.
>>>> +		 *
>>>> +		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the
>>>> +		 * fourth port, which is only for the link speed 2500M same
>>>> +		 * as QCA8081.
>>>> +		 *
>>>> +		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth
>>>> +		 * port, which is for the link speed 10M, 100M and 1000M same
>>>> +		 * as QCA8081.
>>>> +		 */
>>>
>>> How are these 3 modes configured? I don't see any software
>>> configuration of this in these drivers. Can it only by configured by
>>> strapping?
>>
>> The interface mode is passed in the .config_init, which is configured
>> by the PCS driver, the hardware register is located in the PCS, this
>> driver will be pushed later.
> 
> Is this the same as how the syqca807x works? Can the PCS driver be
> shared by these two drivers?

I am not sure syqca807x, would you point me the code path of this driver?

> 
> What i don't like at the moment is that we have two driver
> developments going on at once for hardware which seems very similar,
> but no apparent cooperation?
> 
> 	Andrew

The PCS of qca8084 is the PHY PCS, which should be new PCS driver,
in the previous chips, we don't have this kind of PHY PCS.
