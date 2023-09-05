Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986E792CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjIER6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbjIER6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:58:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986A15A1B;
        Tue,  5 Sep 2023 10:53:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385BSwJN023491;
        Tue, 5 Sep 2023 16:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wr1Ck6RCHOMwvpJ21oFY9bXdw5ypgpuIPcQMdoCBAh4=;
 b=m/wKng7Tk6guMKISRL0TCoZoEndSFSBPjqmpIx/ne31b27t3KAapmA76FuyYF4JdmpHO
 MMGYss6YJNkhnxlefcpv20ouRvvN/kpxKXahwzsnuBb4XcmQRZNOrCh160t1qbX0cUYR
 1T2RM32qRmsuNkzO2qXApdc2gC1hLrsLetpR97yZXQoVR7Fqsx+r8saE4YDdaQdTrqYp
 x8oK1pA3U5B142uBjgNahOkTKzzg87z7nQTvFGLf8deC6JHKZ9A5ijqPP1ZMsQvoAY/0
 RKe/Rsl3KiTVNDiIXITb/+wLfQS65URhU51yadLNLgrFky87iXHuifIrRa8mBlxYCf17 iQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swtr89q1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 16:06:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385G6Wnc021231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 16:06:32 GMT
Received: from [10.110.6.69] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 5 Sep
 2023 09:06:32 -0700
Message-ID: <3342d8bf-5281-c082-cb9a-7a027b413237@quicinc.com>
Date:   Tue, 5 Sep 2023 09:06:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] Add qcom hvc/shmem transport
Content-Language: en-US
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230811175719.28378-1-quic_nkela@quicinc.com>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230811175719.28378-1-quic_nkela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NdqNObDs4LPTSCjvvNKeB6Ci4JvZ3isy
X-Proofpoint-ORIG-GUID: NdqNObDs4LPTSCjvvNKeB6Ci4JvZ3isy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxlogscore=974 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050141
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/2023 10:57 AM, Nikunj Kela wrote:
> This change introduce a new transport channel for Qualcomm virtual
> platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
> The difference between the two transports is that a parameter is passed in
> the hypervisor call to identify which doorbell to assert. This parameter is
> dynamically generated at runtime on the device and insuitable to pass via
> the devicetree.
>
> The function ID and parameter are stored by firmware in the shmem region.
>
> This has been tested on ARM64 virtual Qualcomm platform.
>
> ---
> v3 -> fix the compilation error reported by the test bot,
>        add support for polling based instances
>
> v2 -> use allOf construct in dtb schema,
>        remove wrappers from mutexes,
>        use architecture independent channel layout
>
> v1 -> original patches
>
> Nikunj Kela (3):
>    dt-bindings: arm: convert nested if-else construct to allOf
>    dt-bindings: arm: Add qcom specific hvc transport for SCMI
>    firmware: arm_scmi: Add qcom hvc/shmem transport
>
>   .../bindings/firmware/arm,scmi.yaml           |  67 ++---
>   drivers/firmware/arm_scmi/Kconfig             |  13 +
>   drivers/firmware/arm_scmi/Makefile            |   2 +
>   drivers/firmware/arm_scmi/common.h            |   3 +
>   drivers/firmware/arm_scmi/driver.c            |   4 +
>   drivers/firmware/arm_scmi/qcom_hvc.c          | 232 ++++++++++++++++++
>   6 files changed, 293 insertions(+), 28 deletions(-)
>   create mode 100644 drivers/firmware/arm_scmi/qcom_hvc.c
Gentle Ping!
