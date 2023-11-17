Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520187EEF90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjKQKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:00:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53284;
        Fri, 17 Nov 2023 02:00:13 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9KDIL002157;
        Fri, 17 Nov 2023 09:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q3iC62ynP/mZpKHk8fWgTSo66zEj7Zi2/0wjFcoZTGQ=;
 b=AyVKdcVov8hJCEoszwR2yzPg3FtYQpFAdLCOUa7IkkAHIW3yLfu/cIFgnXe3kisPG/C8
 HN/xE3WgmimYrTZERjSsijSfrXapuGaJ63qIH2VmgysX59q0O2CRzDOLoVA42l2OFayr
 nGbMKGoa4zWinQUTgJFC9IOQegFjvaYkIB6dKQluAmVsSKABJT8ylxHD3sutd45uoK4F
 Snd9P7WBL1JKyZoNk3QcIUa5tf4RfBcBUGUGP3NDHNazMwv09Fu1WbDLiaDxq8Z1+V9X
 jPCgEO3FWKlEIKDzZeDnTtIXv3gjyM3GwJ4TtJ+ADkrTvRcUrnxOEtFYZeFERAFJY3/8 1A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue5exr2hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:59:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9xvmZ009296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:59:57 GMT
Received: from [10.253.8.81] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 01:59:53 -0800
Message-ID: <7e856fc9-25c7-489f-8a42-759ed126ae68@quicinc.com>
Date:   Fri, 17 Nov 2023 17:59:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] net: mdio: ipq4019: Enable GPIO reset for ipq5332
 platform
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-4-quic_luoj@quicinc.com>
 <e740a206-37af-49b1-a6b6-baa3c99165c0@lunn.ch>
 <33246b49-2579-4889-9fcb-babec5003a88@quicinc.com>
 <dd2c3cfa-f7ee-4abb-9eff-2aac04fa914f@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <dd2c3cfa-f7ee-4abb-9eff-2aac04fa914f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M_yXy1nGjp7G9GwYZKFTPx6kEDNQjrct
X-Proofpoint-ORIG-GUID: M_yXy1nGjp7G9GwYZKFTPx6kEDNQjrct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 mlxlogscore=774 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2023 1:20 AM, Andrew Lunn wrote:
>> FYI, here is the sequence to bring up qca8084.
>> a. enable clock output to qca8084.
>> b. do gpio reset of qca8084.
>> c. customize MDIO address and initialization configurations.
>> d. the PHY ID can be acquired.
> 
> This all sounds like it is specific to the qca8084, so it should be in
> the driver for the qca8084.
> 
> Its been pointed out you can get the driver to load by using the PHY
> ID in the compatible. You want the SoC clock driver to export a CCF
> clock, which the PHY driver can use. The PHY driver should also be
> able to get the GPIO. So i think the PHY driver can do all this.
> 
>       Andrew

Yes, Andrew, that is feasible, i will update the patches to move the
initialized clock configs in the PHY probe function.
