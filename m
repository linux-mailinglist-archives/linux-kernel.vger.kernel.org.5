Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD87F5D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjKWK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKWK6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:58:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEFAD44;
        Thu, 23 Nov 2023 02:58:21 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8CE7I004665;
        Thu, 23 Nov 2023 10:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qLQaZ89NvhC1j+2VehIGu4V3oAPl0sgBsH3ZIGNFkaM=;
 b=gLKeQ1QI7H/gScDyatm7kmuoQmdvrzr1+I2l2JWr5AG7njKzdNwZGYQoi9hS3tEMzfQJ
 lRX5aBsFpHsnD7m5ewJJnYz8I46Ozl8rn8TyfaUVjMMXtzbMyzE/jPzbklTt47P1U+Md
 gorHEgFGgCgaD+AuXatiIS/tYhoNxPtahu53xJ3dnqgYSm+I1JNI1XI5nr+DyC5ocTZA
 Q3+FeIeApLhTiF/U+qVOGxFZuA8CeMQ56a4GTd2mvCGeeFXACOVgL5zquR++vVgHh0OQ
 bi9AVrlH9yNpYZmePQ9iPY1vdB+UC5Wsuop02mwiHWRvX4lHA4wFyWZJ9EHRRI+sSsuG ZQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj30x8a11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:58:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANAw5fJ002445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:58:05 GMT
Received: from [10.253.33.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 02:58:02 -0800
Message-ID: <d2ac542c-aae3-49ae-ae2b-9defc4ca98eb@quicinc.com>
Date:   Thu, 23 Nov 2023 18:57:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
 <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
 <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pOQONhNd20YTfGS7Zztiqo-7s85JCRCK
X-Proofpoint-GUID: pOQONhNd20YTfGS7Zztiqo-7s85JCRCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2023 7:52 PM, Russell King (Oracle) wrote:
> On Tue, Nov 21, 2023 at 07:10:08PM +0800, Jie Luo wrote:
>> when pcs is configured to SGMII mode, the fourth PHY can reach to
>> maximum speed 2.5G(2500BaseT) that is reached by increasing the clock
>> rate to 312.5MHZ from 125MHZ of 1G speed, but there is no corresponding
>> interface mode can be used to reflect this 2.5G speed mode(sgmii+)
> 
> So this comes up again. 2.5G SGMII? What is that?

2.5G SGMII here is reached by increasing the PCS clock rate to 312.5MHZ
from sgmii with the clock rate 125MHZ.

> 
> Let's start off with the basics. SGMII is Cisco's modification of
> 1000base-X. The two are broadly compatible in that they can communicate
> with each other provided that the inband control word is disregarded.
> 
> 2500base-X is generally implemented as 1000base-X over-clocked by 2.5x.
> Some manufacturers state that the inband control word is not supported.
> Others say it can be used. This disparity comes from the lack of early
> IEEE standardisation of this protocol.
> 
> Cisco SGMII as defined is a 10M/100M/1G protocol operating at 125MHz
> with a fixed underlying baud rate of 1250Mbaud. Slower speeds are
> achieved via symbol replication by 10x or 100x. The inband control
> word is modified in order to convey this speed information, as well
> as duplex and sometimes also other vendor extensions.
> 
> Switching SGMII to be clocked 2.5x faster means that a partner that
> expects SGMII at normal speed sees garbage - it can't recognise the
> waveform. Therefore, it is not possible for inband to convey any
> information. Many vendors explicitly state that symbol replication
> is not supported when "SGMII" is clocked at 2.5x.
> 
> All variants of whatever the vendor calls the 2.5G mode tend to use
> the SGMII term because... it's Serial Gigabit... and SGMII even gets
> used by vendors to describe the interface used for 1000base-X.
> Vendors use terms like "HS-SGMII" and other stuff to describe their
> 2.5x mode. Some use "2500base-X". Yours seems to use "SGMII+".

i use the term SGMII+ because of the 2.5G speed achieved by operating
the clock rate in 312.5MHZ from 1G speed of 125MHZ.

> 
> SGMII without inband signalling is basically the same as 1000base-X.
> Therefore, SGMII clocked at 2.5x the speed is basically the same as
> 2500base-X without inband signalling.

SGMII+ disable the autoneg when the serdes works 312.5MHZ for the 2.5
link speed.

> 
> So, the whole area is totally confused, and one should not get too
> hung up on the terminology that vendors are using, but go back to
> precisely what's going on at the hardware level.
> 
> We have raised this point almost every time someone talks about an
> up-clocked "SGMII".
> 
> 
>> Actually we should add a new interface mode such as sgmii+
>> to reflect this 2.5G speed of sgmii
> 
> Only if there really is something different about it. For example,
> if it were Cisco SGMII modified to operate always at 312.5MHz with
> inband signalling updated to signal the four speeds. That would
> definitely be a different protocol.

For qca808x PHY, the clock rate is different between sgmii(125MHZ for
speed 10/100/1000M) and sgmii+(312.5MHZ for 2.5G).

> 
> However, it's not that. What it actually is is Cisco SGMII when
> operating at 10M/100M/1G speeds, and 2500base-X without inband
> signalling when operating at 2.5G speed.

Yes, Russell, this is what qca808x PHY works on.

> 
> We have PHYs that support this (and more) which we support. PHYs
> that switch between 10GBASE-R, 5GBASE-R, 2500BASE-X and Cisco SGMII
> depending on the speed that was negotiated on the media. There is
> no definition of a single interface mode that covers all those,
> because it isn't a single interface mode. It's four separate modes
> that the PHY switches between - and this is no different from what
> is happening with your PHY.

This is indeed two different modes switched between 2.5G and other
speeds(10/100/1000M).

> 
> Ultimately, you will need a way to use inband signalling with Cisco
> SGMII for 10M/100M/1G speeds, and then switch to 2500base-X when
> operating at 2.5G speeds, and that is done via the PHY driver
> updating phydev->interface.
> 
> What we do need is some way for the PHY to also tell the PCS/MAC
> whether inband should be used. This is something I keep bringing up
> and now that we have PCS drivers revised to use the value from
> phylink_pcs_neg_mode() _and_ a consistent implementation amongst them
> we can now think about signalling to PCS drivers whether inband mode
> needs to be turned off when switching between modes.

Yes, we can switch the interface mode according to the current link
speed in the pcs driver.
but the issue is that the phy-mode i specified for the PHYLINK,
if phy-mode is sgmii, the support capability is limited to maximum
capability 1G during the PHYLINK setup and i can't configure it to 2.5G
dynamically, if the phy-mode is 2500base-x, then PHY capability will
be modified to only support 2.5G, other speeds can't be linked up.

> 
> There have been patches in the past that allow inband mode to be
> queried from phylib, and this is another important component in
> properly dealing with PHYs that need to use inband signalling with
> Cisco SGMII, but do not support inband signalling when operating at
> 2.5G speeds. The problem when operating at 2.5G speed is that the
> base-X protocols are normally for use over fibre, which is the media,
> and therefore the ethtool Autoneg bit should define whether inband
> gets used or not. However, in the case of a PHY using 2500base-X,
> the Autoneg bit continues to define whether autonegotiation should
> be used on the media, and in this case it's the media side of the
> PHY rather than the 2500base-X link.
> 
> So, when using a 2500base-X link to a PHY, we need to disregard the
> Autoneg bit, but that then raises the question about how we should
> configure it - and one solution to that would be to entire of phylib
> what the PHY wants to do. Another is to somehow ask the PCS driver
> whether it supports inband signalling at 2500base-X, and resolve
> those capabilities.

For the qca808x PHY, when it is linked in 2.5G, the autoneg is also
disabled in PCS hardware, so the sgmii+ of qca808x PHY is almost
same as 2500base-X.

> 
> That is my view where we need to get to in order to properly resolve
> the ongoing issues about 2500base-X and PHYs that make use of that.
> 

Thanks Russell for the detail information about the SGMII and 2500BASE-X
mode, it is really helpful.

For now, the issue is "the Supported link modes" of PHY is limited when
the interface mode(such as sgmii) is used to setup PHYLINK, which leads
to the PHY can't link in the speed(such as 2.5G) of the different
interface mode(sgmii+).

