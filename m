Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CE7E655D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjKIIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjKIIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:33:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A524210A;
        Thu,  9 Nov 2023 00:33:01 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A98BCFh007178;
        Thu, 9 Nov 2023 08:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J6ZXmXXTgg+b2E438QEG2x0HVhaMiR1kvgY0atBWADs=;
 b=IGAKGGLrU3HdhW5LESkobIIuXrWyW7F+/p+v0AqMXHDlgioCfVEHoId0JayRjNTGXSPF
 BitqffYliwVNydHeqa3Vhs8GWD1BfSSX7ROIksCrUbCrrKp6Uxha6QslW01RoR/bSmIL
 usY4rMZ87c58GVtNPTPm1p3WB4AVPrKVtIBmIelPJM2OG0m4OFv9n+tUxhu6PWUYtdgo
 NV2Y9ri1KD+fLghOxnR5OgKN+wLo13e+j8JY9K7HxKHJbsq3xFW1mggwDjKPHMAwmGES
 QvKS29eHsylQsfyzOEtW10YPiT1Q8GcORaSTZtNIdlfVID+moHhaD0P2JT8B6ELHmHoV 4g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8upj01pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 08:32:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A98Wg3t023168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 08:32:42 GMT
Received: from [10.253.38.48] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 00:32:39 -0800
Message-ID: <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
Date:   Thu, 9 Nov 2023 16:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
 <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231108131250.66d1c236@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SUFP3CfsgJq4mSAR1vWU3KIJhD8RH9TB
X-Proofpoint-ORIG-GUID: SUFP3CfsgJq4mSAR1vWU3KIJhD8RH9TB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=936
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2023 8:12 PM, Maxime Chevallier wrote:
> Hello,
> 
> On Wed, 8 Nov 2023 19:34:43 +0800
> Luo Jie <quic_luoj@quicinc.com> wrote:
> 
>> Add qca8084 PHY support, which is four-port PHY with maximum
>> link capability 2.5G, the features of each port is almost same
>> as QCA8081 and slave seed config is not needed.
>>
>> Three kind of interface modes supported by qca8084.
>> PHY_INTERFACE_MODE_QUSGMII, PHY_INTERFACE_MODE_2500BASEX and
>> PHY_INTERFACE_MODE_SGMII.
>>
>> The PCS(serdes) and clock are also needed to be configured to
>> bringup qca8084 PHY, which will be added in the pcs driver.
>>
>> The additional CDT configurations used for qca8084.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/phy/at803x.c | 48 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
> 
> [...]
> 
>> @@ -1824,6 +1828,21 @@ static int qca808x_read_status(struct phy_device *phydev)
>>   		return ret;
>>   
>>   	if (phydev->link) {
>> +		/* There are two PCSs available for QCA8084, which support the following
>> +		 * interface modes.
>> +		 *
>> +		 * 1. PHY_INTERFACE_MODE_QUSGMII utilizes PCS1 for all available 4 ports,
>> +		 * which is for all link speeds.
>> +		 *
>> +		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the fourth port,
>> +		 * which is only for the link speed 2500M same as QCA8081.
>> +		 *
>> +		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth port,
>> +		 * which is for the link speed 10M, 100M and 1000M same as QCA8081.
>> +		 */
>> +		if (phydev->interface == PHY_INTERFACE_MODE_QUSGMII)
>> +			return 0;
>> +
> 
> What I understand from this is that this PHY can be used either as a
> switch, in which case port 4 would be connected to the host interface
> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> speed would be limited to 1G per-port, is that correct ?

When the PHY works on the interface mode QUSGMII for quad-phy, all 4
PHYs can support to the max link speed 2.5G, actually the PHY can
support to max link speed 2.5G for all supported interface modes
including qusgmii and sgmii.

> 
> However the get_features function seems to build the supported modes
> set by reading some capabilities registers :
> 
> static int qca808x_get_features(struct phy_device *phydev)
> {
> [...]
> 	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
> 	if (ret < 0)
> 		return ret;
> 
> 	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
> 		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
> [...]
> }
> 
> Wouldn't port 4 report 2.5G capabilities then ? Maybe you need to
> mask-out the 2.5G bit if the interface is qusgmii.
> 
> Best regards,
> 
> Maxime

All ports including port4 support 2.5G capability for the supported
interface mode.

Thanks Maxime for the review.
