Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331F77C835D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjJMKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjJMKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:39:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD595188;
        Fri, 13 Oct 2023 03:39:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DAco1P026746;
        Fri, 13 Oct 2023 10:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ChhIVyXy/0SXa2i6PYFsBV+c//2U9kjNCT4GsWSF2hA=;
 b=fz977hvzFdPHng24xJPkBoPLwMEApaV9iBijh4dKsJbxbD394lC8Pv6QvO/65sqCnnt5
 KpfoOxeHXYK4Jp5fB0Ath78rkcA+RylaW3efJ2f7oNyrnUBmfn9NX+bK7xsBTT5gV/fZ
 R2syZKllHZdpQGYgL8i88IVANECHi5CO7/F2MjimZlMG3Y75oiMb1sLrcHLWYi1OnDJb
 GXWKjaWPFERGB8Ej0rMZKtNA3oNza51SoREe01LU9waOnpX21aTKnzgHfqhqA0xkQLCo
 83pLgcStfhlwm9pBKeO1okxp1vS3NlxVtgrLKMohZmoW1Ov3CCj9sRwu3Eny7B0KAuqT 2w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt109dvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 10:38:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DAcn1R028179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 10:38:49 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 03:38:41 -0700
Message-ID: <b88cc301-52db-4401-8364-7056f0e10149@quicinc.com>
Date:   Fri, 13 Oct 2023 16:08:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add USB Support on Qualcomm's SDX75 Platform
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <kishon@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <abel.vesa@linaro.org>, <quic_wcheng@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1695359525-4548-1-git-send-email-quic_rohiagar@quicinc.com>
 <ZSkb9ajLZGpD46Ik@matsya>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <ZSkb9ajLZGpD46Ik@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3YptFoY2CrZmLjVuXVRhUvmpFLviItT2
X-Proofpoint-ORIG-GUID: 3YptFoY2CrZmLjVuXVRhUvmpFLviItT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=577 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/2023 3:59 PM, Vinod Koul wrote:
> On 22-09-23, 10:42, Rohit Agarwal wrote:
>> Hi,
>>
>> Changes in v4:
>>   - Replaced the v5 offsets with v6 offsets as per Dmitry's suggestion in patch 5/5.
>>
>> Changes in v3:
>>   - Removed the unnecessary change introduced in v2 of patch 2/5
>>   - Added Fixes tag in patch 3/5
>>   - Rebased patch 5/5 on Dmitry's cleanup patches.
>>     https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
>>     https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
>>
>> Changes in v2:
>>   - Dropped the new dt schema introduced in v1 for sdx75 usb3 phy
>>     and reusing the bindings.
>>   - Rephrased the commit message of patch 3/5
>>   - Removed stray lines from the patch 5/5
>>
>> This series adds support of USB3 PHY support for Qualcomm's SDX75 Platform.
> The phy patches fail to apply, can you please rebase the three patches
> and resend
Can you please apply these two series. This series depends on it for 
successful compilation.
[1] 
https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
[2] 
https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/

Thanks,
Rohit.
