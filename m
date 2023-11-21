Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C37F2B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjKULKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKULKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:10:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2964CA;
        Tue, 21 Nov 2023 03:10:27 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA8dXl004669;
        Tue, 21 Nov 2023 11:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3jkvNomu/T+rw84AfhK9x8vxgbep/obiHslHag7pVzw=;
 b=ZbfiNtiKqLpZB72rn5PMgIJXP29IFWS5oTLLk/EYxtlsLBsvIVAjupHcC72ui1t0+5jK
 faGkvwA09LZJeRzjmBsLwIifytMbacI2p3wn44Ha07tYY3pOtAdmQI882pH7/nOWmvft
 7TD581A4cMzXhn7ThrYLzkD5hSgPimVuQSZtaUtDNqdXdga5rJWuFNxlIb89O0ugiFIy
 JEtWIblwEL2ROWctx5n6IWjj33TdBqFEaxhvDGnD4aRZgk8g/3xWgzA3e2USLCB4BMi/
 foH3he8OU01QgETG4uOllOLOIdJ7ed39aqpNyUMrn6+LgTTFqbRmgee+Q4DdjkGSPwhc ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugge19ean-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:10:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALBAEJP029315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:10:14 GMT
Received: from [10.253.72.26] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 03:10:10 -0800
Message-ID: <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
Date:   Tue, 21 Nov 2023 19:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uyxGtoquF84BMYww-SOI5QCz__Kbc_ad
X-Proofpoint-ORIG-GUID: uyxGtoquF84BMYww-SOI5QCz__Kbc_ad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2023 11:34 PM, Andrew Lunn wrote:
>> Hi Andrew,
>> The interface mode 10G_QXGMII is a type of USXGMII-M, the other modes
>> such as 20G-QXGMII, 20G-OXGMII...
>>
>> As for the interface mode 10G-QXGMII, there is a multiplexer for 4 PHYs,
>> then do 66bit/68bit encode in xpcs and pass to PMA, the link topology:
>> quad PHY --- multiplexer ---XPCS --- PMA.
>> the 10G-QXGMII interface block includes multiplexer, XPCS and PMA.
>>
>> when the PHY works on SGMII mode, then there is no xpcs, the only fourth
>> PHY of qca8084 can work on SGMII mode, the link topology:
>> the fourth PHY --- PCS --- PMA, the SGMII block includes PCS and PMA.
> 
> What i missed is that you have two different PMA blocks. PHY4 can be
> muxed to either the QXGMII PMA or the 2500BaseX PMA. This is not clear
> in the commit message, and i think why you are getting questions about
> how 2500BaseX can work over QXGMII. Please expand you commit message
> to explain the architecture in more detail.

Ok, Andrew, i will give more detail about the pcs utilized in the next
patch set.

when pcs is configured to QXGMII mode, quad phy can reach to maximum
speed 2.5G, it is still in qxgmii mode.

when pcs is configured to SGMII mode, the fourth PHY can reach to
maximum speed 2.5G(2500BaseT) that is reached by increasing the clock
rate to 312.5MHZ from 125MHZ of 1G speed, but there is no corresponding
interface mode can be used to reflect this 2.5G speed mode(sgmii+), so
i use 2500BaseX to reflect this 2.5G link speed, which is same as
qca8081 PHY. Actually we should add a new interface mode such as sgmii+
to reflect this 2.5G speed of sgmii, so that the PHYLINK can support
all supported link speeds(10/100/1000/2500M) with the interface mode
sgmii+, currently 2500BaseX only advertise 2.5G, sgmii advertise
10/100/1000 in the PHYLINK framework. but actually qca808x supports
10/100/1000/2500 speed. how do you think?

> 
> So, next question. How do you control what PMA PHY4 is connected to?
> Is this going to be based on interface mode? QXGMII it is configured
> to use the QXGMII PMA? SGMII, 1000BaseX, and 2500BaseX it is
> configured to the other PMA?

Yes, there are two different PCS to work on qxgmii and sgmii mode.
one PCS can be connected with quad phy, another pcs can be connected
with PHY4.

> 
>> Here is a problem as Russell mentioned earlier, we need to know which PHY
>> device is changing the link status when the 10G-QXGMII mode is used,
>> since there are 4 PHYs, when one of them has the link change, there is no
>> PHY device information passed to the PHYLINK, so the PCS driver don't
>> which PHY is changing link status and 10G-QXGMII mode don't know which
>> channel(mapped to PHY) should be configured.
> 
> This is the first time QXGMII has been seen in mainline, so its good
> to explain the background.

 From PCS hardware perspective, there is only one QXGMII mode instance
for 4 PHYs and MACs, and the each PHY is related with the channel of
QXGMII.

> 
> Are you saying there is a USXGMII-M level link change status? The link
> between the SoC and the PHY package is up/down? If it is down, all
> four MAC-PHY links are down. If it is up, it is possible to carry
> frames between the SoC and the PHY package, but maybe the PHYs
> themselves are down?
> 

There is a per channel(for each PHY) configurations in XPCS XGMII mode,
if one PHY has the link change, the related channel should be
configured for this PHY, and multiplex is also used for the connected 4
MACs, the link change on one phy does not effect the other PHYs.

If the PHY is down, the pipeline of the related channel can't transfer
data, the phy link status is reflected to XPCS.

> Withing the four multiplex streams, is there a per stream link change
> indication?

Yes, it is per channel(for each PHY) link change indication in QXGMII.

> 
> 	Andrew
