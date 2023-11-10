Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7797E81BD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjKJSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbjKJScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:32:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773325A0D;
        Fri, 10 Nov 2023 01:56:29 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA9iHNL015268;
        Fri, 10 Nov 2023 09:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dqcOp6uMPuE83dY6kYaHOebngUiHYiPNDGtrKbD1kfY=;
 b=ct5HEE+gnitLwXmqC+KnyB5l/UMTkyESttAYm0AEzg3wis/kH+6aJlECw6tcig2JGcV+
 4TiM3uyQwiRIRxtDF/GRGOo/z1xycN4q3Hj5jlIUEHbBWrlVU0nQztsgw5cpmWu/sfX+
 kwt2qz7s/AWC1ig2WrWM3SmjuZG+b3fLeC6yV8rP8gMl0QJ03oHu2hmoyIVoF7x66ZLY
 96/6EuGtmNNWkaP6G/l2J5mjMHBopcLd1uiYFNcbWrST2Mt7HAX/ldh2wrSSYCdZQfzV
 b34SP9+3rCfzdAPXBrZsU+ZO3yjEMjWg4Q33tEdFkgJw1JC7BptnURdDevSUgKv4oQNQ HQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9h9v84qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:56:14 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA9uDOP029435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:56:13 GMT
Received: from [10.253.8.167] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 01:56:11 -0800
Message-ID: <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
Date:   Fri, 10 Nov 2023 17:56:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Content-Language: en-US
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
 <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231110103328.0bc3d28f@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rKUGGD6_5vdy8zfqH4Q7fuTFkZrctYtN
X-Proofpoint-ORIG-GUID: rKUGGD6_5vdy8zfqH4Q7fuTFkZrctYtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_06,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=580 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100080
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 5:33 PM, Maxime Chevallier wrote:
> On Fri, 10 Nov 2023 17:17:58 +0800
> Jie Luo <quic_luoj@quicinc.com> wrote:
> 
>> On 11/10/2023 4:53 PM, Jie Luo wrote:
>>>
>>>
>>> On 11/9/2023 5:16 PM, Maxime Chevallier wrote:
>>>> Hello,
>>>>
>>>> On Thu, 9 Nov 2023 16:32:36 +0800
>>>> Jie Luo <quic_luoj@quicinc.com> wrote:
>>>>
>>>> [...]
>>>>   
>>>>>> What I understand from this is that this PHY can be used either as a
>>>>>> switch, in which case port 4 would be connected to the host interface
>>>>>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
>>>>>> speed would be limited to 1G per-port, is that correct ?
>>>>>
>>>>> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
>>>>> PHYs can support to the max link speed 2.5G, actually the PHY can
>>>>> support to max link speed 2.5G for all supported interface modes
>>>>> including qusgmii and sgmii.
>>>>
>>>> I'm a bit confused then, as the USGMII spec says that Quad USGMII really
>>>> is for quad 10/100/1000 speeds, using 10b/8b encoding.
>>>>
>>>> Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
>>>>    with 66b/64b encoding ?
>>>>
>>>> Thanks,
>>>>
>>>> Maxime
>>>
>>> Hi Maxime,
>>> Yes, for quad PHY mode, it is using 66b/64 encoding.
>>>
>>> it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
>>> so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
>>> quad PHYs here.
>>>
>>> can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
>>> case(qca8084 quad PHY mode)?
>>>
>>> Thanks,
>>> Jie.
>>
>> one more thing, if we use the PHY_INTERFACE_MODE_USXGMII for
>> the quad PHY here, the MAC serdes can't distinguish the actual
>> mode PHY_INTERFACE_MODE_USXGMII and 10G-QXGMII(qca8084 quad phy mode),
>> the MAC serdes has the different configurations for usxgmii(10g single
>> port) and qxsgmii(quad PHY).
> 
> Yes you do need a way to know which mode to use, what I'm wondering is
> that the usxgmii spec actually defines something like 9 different modes
> ( 1/2/4/8 ports, with a total bandwidth ranging from 2.5Gbps to 20 Gbps
> ), should we define a phy mode for all of these variants, or should we
> have another way of getting the mode variant (like, saying I want to
> use usxgmii, in 4 ports mode, with the serdes at 10.3125Gbps).
> 
> That being said, QUSGMII already exists to define a specific variant of
> USGMII, so maybe adding 10G-QXGMII is fine...

Yes, Maxime, I agree with this solution, the name 10G-QXGMII is exactly
the working mode of qca8084 quad phy mode.

> 
> Also, net-next is still currently closed.

Ok, thanks for this reminder.
