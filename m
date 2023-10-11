Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261D67C5027
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbjJKKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjJKKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:32:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09FA7;
        Wed, 11 Oct 2023 03:32:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B5K2Ie023923;
        Wed, 11 Oct 2023 10:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S7Dy4jxMaTB3uSe1nYzpJp84Z3nL4ulmDTKFBXwe5GI=;
 b=pWUHLA33u8v3Zdq4qvsi11aku/Dtj3FfM/1ukLUxb3gZQ7JuBxEfdbgJvqacjCL8swsT
 DoUL6BIrB2mMwnXiAWf3YPfrKBjC5LyRYH9Msqo8b09bvvc0Sd/X15hQIVUtef3dHfGv
 ez2Em51rOcPI+tOcvon3ackCiTUmWYRkJLDEK9K2MyXjeRiPzHFGGxWq2Ec51KVLc69c
 qgzicZHg9VsSWQynAsfjOYlHX4IoJ1i+bxL7ln6J4JYuLdgxObIsjziY2irFXcuqo5nO
 8NwDYMbxA+UL76Jd8r/TRjKf6BNqridlOyV4bcRHRLDrFBWIoj8i4oeLGm/+jNcoXmKd Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tne0q1bcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 10:32:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BAWExL023022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 10:32:14 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 03:32:10 -0700
Message-ID: <785d1ea1-3a71-4257-840f-5f4dab887e15@quicinc.com>
Date:   Wed, 11 Oct 2023 16:02:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add common RDP dtsi file for IPQ9574
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>
References: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fj70R7mipycp8Shdi2ho7m9oWNgb-T7t
X-Proofpoint-ORIG-GUID: Fj70R7mipycp8Shdi2ho7m9oWNgb-T7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_07,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=612 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2023 12:13 PM, Kathiravan Thirumoorthy wrote:
> Some interfaces are common across RDPs. Move the common nodes to
> ipq9574-rdp-common.dtsi like how it is done for IPQ5332. Use rdp specific
> dts file to include interfaces that vary across RDPs. For instance, IPQ9574
> has 4 PCIE controllers. RDP417 enables PCIE0 and PCIE1 whereas RDP433
> enables PCIE1, PCIE2 and PCIE3.
>
> With the introduction of the common RDP DTSI,
> 	- RDP433 gains SPI NOR support
> 	- All the IPQ9574 RDPs gains USB2 and USB3 support
>
> While at it, add support for WPS buttons.
>
> Since Anusha's is busy and can't take up this series right now, I'm
> stepping up to work on this series.


Gentle Reminder...


>
> Changes in V3:
> 	- Reworded the cover letter to indicate the need and advantages
> 	  of common RDP DTSI
> 	- Change logs are in respective patches
> 	- V2: https://lore.kernel.org/linux-arm-msm/20230713105909.14209-1-quic_anusha@quicinc.com/
>
> Changes in V2:
> 	- Detailed change logs are added to the respective patches.
> 	- V1: https://lore.kernel.org/linux-arm-msm/20230614085040.22071-1-quic_anusha@quicinc.com/
>
> ---
> Anusha Rao (2):
>        arm64: dts: qcom: ipq9574: Add common RDP dtsi file
>        arm64: dts: qcom: ipq9574: Enable WPS buttons
>
>   arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 147 +++++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts      |  63 +---------
>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts      |  91 +-------------
>   arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts      |  65 +---------
>   arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts      |  65 +---------
>   arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts      |  66 +---------
>   6 files changed, 152 insertions(+), 345 deletions(-)
> ---
> base-commit: 18030226a48de1fbfabf4ae16aaa2695a484254f
> change-id: 20230927-common-rdp-52f90fd0fd77
>
> Best regards,
