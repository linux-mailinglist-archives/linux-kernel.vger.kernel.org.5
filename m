Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3817EDEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbjKPKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345042AbjKPKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:44:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119118B;
        Thu, 16 Nov 2023 02:44:45 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG8Vakx004901;
        Thu, 16 Nov 2023 10:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D1svzL+K4mX38CebFwfuvfAb54VtCzK1NOI55/OaP1w=;
 b=EJrx+9CctyeAF0U2Sq28VpTjQIduRpRZHsS9oEBP6M8lURbSpsR88+ZlwvkZRzyMkTIm
 Bck56GTPURRmDZz2KICOsce6FtRnOLOqJIiyXR2pSI4uMwj8lwbqOAbEo82epofV+vO+
 Rg80ms/wFz918EnctIvik+mtQezNX8Mo4pTiqz3DJKt+1EhLzjq08VF4AK17eie5WqCO
 LkJ2GpQCq/y0lRoLvucPqjgvOZKbwfP8eWW0KzUUlt+dG9YJh5M7yJ/9F/+DFd9XFNdy
 lvqh2b+k5HHuYpOIaH6jNmFwNaOt+KTiGHLtCWFW5en6rdvwrCpXyLFqyfCoFUehhv1R hg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac32ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:44:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGAiLm2023401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:44:21 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 02:44:17 -0800
Message-ID: <8608e88e-e379-4e08-b376-86d9f25d2270@quicinc.com>
Date:   Thu, 16 Nov 2023 18:44:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
 <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aO_XPBb_fBjY-CpFbSBD2d8e64uf5W3x
X-Proofpoint-GUID: aO_XPBb_fBjY-CpFbSBD2d8e64uf5W3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=450
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 1:01 AM, Konrad Dybcio wrote:
> 
> 
> On 11/15/23 17:20, Andrew Lunn wrote:
>> On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
>>> The PHY & PCS clocks need to be enabled and the reset
>>> sequence needs to be completed to make qca8084 PHY
>>> probeable by MDIO bus.
>>
>> Is all this guaranteed to be the same between different boards?
> No, this looks like a total subsystem overreach, these should be
> taken care of from within clk framework and consumed with the clk
> APIs.
> 
> Konrad

Hi Konrad,
As Robert shared the link of the clock provider driver, which is
registered as MDIO device and not available until to the qca8084
initializations completed done here, so i need to do raw read/write
the clock registers in this patch.
