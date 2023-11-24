Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAE7F71CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345704AbjKXKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345628AbjKXKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:41:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8931B2;
        Fri, 24 Nov 2023 02:41:30 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO6ijpT003533;
        Fri, 24 Nov 2023 10:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=I0mFE74+HCAZHSs5OcFV/WmM4ST9H8Z6coVPOaLZ/zg=;
 b=iwYrsNlf0qflB8nGDpXnQ+T6s4IWkBlHahjYNhQDZjspPcImpVgSM+ssSXBT9M/xHWj1
 yO3v7EomkXjNRRs738D5h7sH/q3OwudBtHm8gkXSPS1slNKYq+ViUvHUX7LpT+3PBG+O
 Bm2U7duwJKcFujpFjEaWHApPNsRWy7XxzcXvDNmTbbNoVGnUJ+o8XCjgrLv5HlEHsO6g
 P0lIVIV2PceGOqujayiH+KnCuwoD4QaBwaOVzHc6IbbkUD3wGI7PPpqas1ZruSvD46pa
 c0yQbMpGArI6tIdb7myvcWOiAePQ9gMa4hRNLxcbcFEM+keiRIHETNjjHysUyyyQzt98 4w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujptr0q17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:41:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOAfGXG028633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:41:16 GMT
Received: from [10.253.33.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 02:41:12 -0800
Message-ID: <b5e6c55c-af6b-4a29-95bd-389a9323920b@quicinc.com>
Date:   Fri, 24 Nov 2023 18:41:10 +0800
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
References: <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
 <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
 <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
 <d2ac542c-aae3-49ae-ae2b-9defc4ca98eb@quicinc.com>
 <ZV8+/4eNzLpLzSDG@shell.armlinux.org.uk>
 <1bd2f3a9-3dd1-4c95-b4e5-c9bf2274f271@quicinc.com>
 <ZWByn7HpAmPTP3GJ@shell.armlinux.org.uk>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZWByn7HpAmPTP3GJ@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XdTt8mComxSESH2LtOToWtzuUVmA7tdM
X-Proofpoint-GUID: XdTt8mComxSESH2LtOToWtzuUVmA7tdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2023 5:53 PM, Russell King (Oracle) wrote:
> On Fri, Nov 24, 2023 at 05:47:04PM +0800, Jie Luo wrote:
>>
>>
>> On 11/23/2023 8:01 PM, Russell King (Oracle) wrote:
>>> On Thu, Nov 23, 2023 at 06:57:59PM +0800, Jie Luo wrote:
>>>> On 11/21/2023 7:52 PM, Russell King (Oracle) wrote:
>>>>> Ultimately, you will need a way to use inband signalling with Cisco
>>>>> SGMII for 10M/100M/1G speeds, and then switch to 2500base-X when
>>>>> operating at 2.5G speeds, and that is done via the PHY driver
>>>>> updating phydev->interface.
>>>>>
>>>>> What we do need is some way for the PHY to also tell the PCS/MAC
>>>>> whether inband should be used. This is something I keep bringing up
>>>>> and now that we have PCS drivers revised to use the value from
>>>>> phylink_pcs_neg_mode() _and_ a consistent implementation amongst them
>>>>> we can now think about signalling to PCS drivers whether inband mode
>>>>> needs to be turned off when switching between modes.
>>>>
>>>> Yes, we can switch the interface mode according to the current link
>>>> speed in the pcs driver.
>>>> but the issue is that the phy-mode i specified for the PHYLINK,
>>>> if phy-mode is sgmii, the support capability is limited to maximum
>>>> capability 1G during the PHYLINK setup and i can't configure it to 2.5G
>>>> dynamically, if the phy-mode is 2500base-x, then PHY capability will
>>>> be modified to only support 2.5G, other speeds can't be linked up.
>>>
>>> So you need my patches that add "possible_interfaces" to phylib so you
>>> can tell phylink that you will be switching between SGMII and
>>> 2500base-X. Please see the RFC posting of those patches I sent
>>> yesterday and try them out - you will need to modify your phylib
>>> driver to fill in phydev->possible_interfaces.
>>
>> Your patches work on my board, thanks Russell.
> 
> Please can you reply to the covering email for that series giving your
> tested-by? Thanks.
> 
Ok.
