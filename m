Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A858800530
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjLAIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377779AbjLAIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:06:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23010F8;
        Fri,  1 Dec 2023 00:06:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B17cWdt021468;
        Fri, 1 Dec 2023 08:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s6xuQM0TQ839OS3q8j/gWK3Yd0MG2d7O9pgSlh4CGGA=;
 b=RXWHF2BgdeNuqkYnuc0IoUjxsYlk40uyJb2IUq3AE8UitfiqNMXl32S76bHfd+Yaijjj
 GKx63MC0pXhb6UqDmUOdAlYtYDOB6iq3BUyWV8daUJqr7IitwlmlGCh2Ilk6lOlUO+/A
 TyyjK2sD3EfsLuXpIcsLB5Y6XcfvloV3/Gs9N3c3hWhPBGWzAdv+v+3A5ogyD1cFgBhe
 ueE57+i2jnPAFWyYEkov3Rhq9JKokjlZASfRdUZo4O+XsUbL09WZmpZIw30hSl9mlrqJ
 tGjOmvfBbsRkETyA+deDfHiKEhfd+2gnzh1n3+xBsIPgUHesWUovrt19RqKM7z06Jxe2 3w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq2kp921e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 08:06:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B185xNB027895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 08:05:59 GMT
Received: from [10.253.35.195] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 00:05:55 -0800
Message-ID: <27d3ce6f-5bf9-4199-bfac-33223be1d681@quicinc.com>
Date:   Fri, 1 Dec 2023 16:05:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] net: phy: at803x: add QCA8084 ethernet phy support
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
CC:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231129120446.dfwei5cd7ulbdj4v@skbuf>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231129120446.dfwei5cd7ulbdj4v@skbuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0x6xkabtDRX8pJ3fhNwWE3SLpZPFJCKB
X-Proofpoint-GUID: 0x6xkabtDRX8pJ3fhNwWE3SLpZPFJCKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 8:04 PM, Vladimir Oltean wrote:
> On Wed, Nov 29, 2023 at 06:34:16PM +0800, Jie Luo wrote:
>>>> The PCS drivers in drivers/net/pcs/ should be in PHY side, such as
>>>> pcs-lynx.c and pcs-xpcs.c, they are configuring the MDIO device
>>>> registers.
>>>
>>> Wrong. No they are not. Just because they are accessed via MDIO does
>>> not mean they are in the PHY. MDIO can be used for more than just the
>>> PHY, and is on a lot of platforms.
>>>
>>> LX2160A for example has many MDIO buses, and the PCSes (of which there
>>> are multiple inside the chip, and use pcs-lynx) are accessed through
>>> the MDIO bus specific to each port. They are not MMIO mapped.
>>>
>>> The same is true on stmmac platforms, where xpcs is used - xpcs is the
>>> _MAC_ side PCS.
>>>
>>> Sorry but you are wrong.
>>>
>>
>> OK, but it creates the PCS driver based on the MDIO device in pcs-lynx.c
>> looks like this PCS is located in PHY device from hardware perspective.
> 
> In some ways, this contradiction has a potato-patato aspect to it.
> As Russell says, NXP devices do have internal SGMII/USXGMII/10GBASE-R
> ports which use pcs-lynx.c to access the registers of the PCS layer
> (which are on MDIO buses internal to the SoC). They could legally be
> called PHYs, because they have all the layers that 802.3 says a PHY
> should have: a PCS, a PMA and a PMD.
> 
> But what phylib understands a phy_device to be is a more restricted
> definition than just "a PHY - any PHY". Originally, phylib considered a
> struct phy_device to be something (a discrete chip) that has pins and a
> phy_interface_t towards its host side, and pins + an ethtool_link_mode_bit_indices
> on its media side.
> 
> Traditionally, the media side is exclusively copper (BASE-T, BASE-T1) or
> fiber (BASE-SX/LX).
> 
> A struct phy_device was then also used with PHY_INTERFACE_MODE_INTERNAL
> to represent the built-in BASE-T PHYs that are embedded within certain
> small/medium business Ethernet switches. And then, more and more other
> similar embedded copper PHYs.
> 
> The idea is that (1) a phy_device connects to a remote system, and
> (2) the phylib API does not have insight into the components of the
> PHY it controls: PCS, PMA, PMD. It's all just a monolithic struct phy_device.
> 
> Because there are serial phy_interface_t modes where the MAC also need a
> PHY to even connect to the phylib PHY, a problem presented itself:
> phylib only has support for a single phy_device. So a new framework
> appeared: phylink, which uses the unmodified phylib layer for the
> external PHY, but models the MAC-side PHY using a different API. Later
> on, that API became the phylink_pcs.
> 
> To muddy the waters, a phylink_pcs structure usually connects to another
> local component as described above, like a phylib PHY (on-board or on an
> SFP module). But it can also connect directly to a remote system (like a
> phy_device would). But the phylink_pcs is always integrated in silicon
> with the MAC, and the "media side" of it is a phy_interface_t type, not
> an ethtool_link_mode_bit_indices type.
> 
> Having a separate phylink_pcs is what allows us to work around phylib's
> limitation of having a single phy_device. The reverse is also true: you
> can have a single phylink_pcs, and that belongs to the client MAC driver.
> 
> The other layers (PMA/PMD) of the MAC-side PHY are modeled in the kernel
> as a struct phy (https://docs.kernel.org/driver-api/phy/index.html), and
> we have the phy_set_mode_ext() API for reconfiguring this layer to a
> different mode. Again, this is not applicable for phylib PHYs, which are
> monolithic.
> 
> Given the above definitions, what NXP has and drives with pcs-lynx.c is
> not a struct phy_device, but a MAC-side PCS represented by a phylink_pcs.
> It absolutely does not matter that the register access method for the
> PCS is an internal MDIO bus. FWIW, the PMA/PMD layer is at
> drivers/phy/freescale/phy-fsl-lynx-28g.c.
> 
> So, if put into the proper context, what Russell is saying is correct,
> but I think you need a bit of history to not get even more confused
> about why it is the way it is.

Thanks Vladimir for the detail information, i just get this message, 
which is helpful to me.
