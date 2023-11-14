Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AEA7EB1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjKNOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjKNOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:09:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AFFD5B;
        Tue, 14 Nov 2023 06:09:36 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEDSXtd002278;
        Tue, 14 Nov 2023 14:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mLd7H8sAFDrzEpzmFEfjTs8/UKU040HP55AuRMy6KxE=;
 b=GZ1anr8rZqQdaSIONcO9+3p+eTIeg0YLfIIuMUFBOY4iaXeYSljQOa/bdFLT/VkrpMNm
 y/smyKwJdIRFhYBNeFTWeeAtFjVH0U+/pvAKYhmS+QuDuedJzjrRiG5i3IMya04xMYn7
 tLqL8moTNW0xrJJj6QheFa3kP1UyaNcLVpJJ7SgckzBTiU89VGZ3RkN/a9b8oL51RkEG
 Cp9Lbhgzbx/9MKsXCmsJptUlPBlAP+X+9eKYAhN6OoIbuagJzqYPydo7iOeNWev1C5wp
 NPcJ/5TOxHPugmHEJpIFoM4VdnMRWhpHGxfMDiFOGXS9p1WdZ9hFEHBSEV2ltoHU12o2 4g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubqfdje8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:09:20 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEE9JmP014918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 14:09:19 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 06:09:17 -0800
Message-ID: <71a4e1ba-60ec-41ef-94f7-6804b9fa798b@quicinc.com>
Date:   Tue, 14 Nov 2023 22:09:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
 <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <20231110101841.27aba547@fedora> <ZVI8sOTEKITeHPc+@shell.armlinux.org.uk>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZVI8sOTEKITeHPc+@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -KNaBWBBsysoJ0eybP9fC6a3_q_vcsZJ
X-Proofpoint-ORIG-GUID: -KNaBWBBsysoJ0eybP9fC6a3_q_vcsZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2023 11:11 PM, Russell King (Oracle) wrote:
> On Fri, Nov 10, 2023 at 10:18:41AM +0100, Maxime Chevallier wrote:
>> On Fri, 10 Nov 2023 16:53:39 +0800
>> Jie Luo <quic_luoj@quicinc.com> wrote:
>>
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
>>>>    with 66b/64b encoding ?
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
>>
>> I see, when I added the QUSGMII mode I wrongly stated that it came from
>> the USXGMII spec where it really comes from USGMII, my bad.
>>
>>> can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
>>> case(qca8084 quad PHY mode)?
>>
>>  From what I can see, the USXGMII mode in the kernel is used as the
>> single-port 10G mode of usxgmii. You might need to create a new mode
>> for quad usxgmii at 10G, the spec calls it 10G-QXGMII I think, but as
>> the spec defines quite a lot of modes, should we define all of them or
>> rely on some other parameters to select the actual mode ?
>>
>> Andrew, Heiner, Russell, what do you think ?
> 
> Looking at the Cisco USXGMII Multiport Copper Interface specification,
> you appear to be correct with the "10G-QXGMII" name. I note that it is
> also specified that "System Interface operates in full duplex mode
> only." and makes no other significant mention of duplex, so it's not
> clear whether half duplex is supported on the media side.
> 
Yes, the half duplex is not supported by PCS.

> Figure 2 in this document is the significant one that we need to
> consider, as we're talking about N network interfaces connecting to a
> system interface that then connects to a PHY with multiple ports.
> 
> Given our model, I think it's quite right to use "10G-QXGMII" because
> that describes the protocol over the system interface that will be
> used. However, we need to consider whether this is the only information
> we need, or whether we need to also be thinking about expanding the
> "pcs" property to something such as:
> 
> 	pcs = <&usxgmiim_pcs PORT>;
> 
> where PORT is the port number on the USXGMII PHY as described by figure
> 2. It seems to me that a driver for this USXGMII PHY would need to know
> the port information that a network interface is connected to.
> 

That's true.
There are 4 channels of 10G-QXGMII PCS for mapping with quad PHY ports,
the port ID information of PCS needs be delivered to driver.

In the PCS driver, it seems we need to know the current channel of PCS
taking the link status change when the PHY link updated.

