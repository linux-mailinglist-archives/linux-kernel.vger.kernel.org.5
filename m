Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722A7C83A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjJMKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjJMKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:47:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3E109;
        Fri, 13 Oct 2023 03:47:44 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5PQxO016976;
        Fri, 13 Oct 2023 10:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5CeX+GyTnqbIkFTWtzQtGHiN8bC34N+qdq/3IRn0plY=;
 b=WTH5BM7cXFORw+zslxHDt0s/G20TN0xP/f/XMps1frpyE0Gz+MBKDxrEtoHoJCL+f9s/
 qCLbCOQ4eDDp80c2VnvuQV07MCNFqekC6oz5evXV53/T60RjxGk9dC/umbic9/nciKdJ
 Ityua9yN1an7gq3WqgP4FlBSDwBPJiTL1RVsHE+yC4/Np79NGC7ZX5meYUyrwf2ofqkB
 RudeWS7v4d665CqP5Dc7Ni8Ufi6uCyXjwF0MOVunWKgvLYPI/+gFx3PL3qiYOSSabh1g
 EHxK72w87asfuqpygRtJbM1RlQMf7JlkkojCxTiaENu7cQdf6WyME0U+FvrWGiSX2XH3 +Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt0x1exr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 10:47:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DAlYa8008892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 10:47:34 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 03:47:26 -0700
Message-ID: <86f1c597-0a29-482b-bb21-b305373bbc6c@quicinc.com>
Date:   Fri, 13 Oct 2023 16:17:23 +0530
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
 <ZSkb9ajLZGpD46Ik@matsya> <b88cc301-52db-4401-8364-7056f0e10149@quicinc.com>
 <ZSkfyl757VXnfIjw@matsya>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <ZSkfyl757VXnfIjw@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xF6WC4y7vr9bHQzCGv6VVNHikIZoqEiB
X-Proofpoint-ORIG-GUID: xF6WC4y7vr9bHQzCGv6VVNHikIZoqEiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=645 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/2023 4:15 PM, Vinod Koul wrote:
> On 13-10-23, 16:08, Rohit Agarwal wrote:
>> On 10/13/2023 3:59 PM, Vinod Koul wrote:
>>> On 22-09-23, 10:42, Rohit Agarwal wrote:
>>>> Hi,
>>>>
>>>> Changes in v4:
>>>>    - Replaced the v5 offsets with v6 offsets as per Dmitry's suggestion in patch 5/5.
>>>>
>>>> Changes in v3:
>>>>    - Removed the unnecessary change introduced in v2 of patch 2/5
>>>>    - Added Fixes tag in patch 3/5
>>>>    - Rebased patch 5/5 on Dmitry's cleanup patches.
>>>>      https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
>>>>      https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
>>>>
>>>> Changes in v2:
>>>>    - Dropped the new dt schema introduced in v1 for sdx75 usb3 phy
>>>>      and reusing the bindings.
>>>>    - Rephrased the commit message of patch 3/5
>>>>    - Removed stray lines from the patch 5/5
>>>>
>>>> This series adds support of USB3 PHY support for Qualcomm's SDX75 Platform.
>>> The phy patches fail to apply, can you please rebase the three patches
>>> and resend
>> Can you please apply these two series. This series depends on it for
>> successful compilation.
>> [1] https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
> This one has a pending comment bw Konrad and Dmitry..
Ok, Will wait for this to get resolved.

Thanks,
Rohit.
>
>> [2] https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
> This one is already in -next
>
>> Thanks,
>> Rohit.
