Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC37F22BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKUBCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKUBCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:02:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB57A2;
        Mon, 20 Nov 2023 17:02:05 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0chGj003950;
        Tue, 21 Nov 2023 01:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ADWRDvVUH2QzgQGLB9ZCZ7k78nJhhTb9rlJZFZrpR90=;
 b=XZOgimqIuknZsbkYsa95PUSmdxJQfNFPlBPMrU3/ze2m7PsN7q8tYYsWMoQG8MtvkFWW
 nkW9eOOOjzN5nucrUqUqmjw0k28TqtyLkzk4176PYU+apmetwJQSnKvtIx1rbVM7UnY5
 wJP5j6PNtQBFJ1Mli4dwKslgsqn3FM3ovCjfj2bjL0ncyWBbYPK+8RPb+IOs15hXniP7
 90I8w2ijL1vzudhsSM7II+KQdojeFGx3XQ6+zGaj+wm5PPiCXptlGOf48PYoDwNL1FrY
 ZZpaGmkX0Vv/2/HfwGamIOEQRFiXL62HggdfdLoqdBimKMeOlvXeA7kRSkulsRA3dCDy 3w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug37mj74r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 01:02:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL11xU2023174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 01:01:59 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 17:01:56 -0800
Message-ID: <b1beb314-3d31-4e3d-ac6c-c845cbe3c0df@quicinc.com>
Date:   Tue, 21 Nov 2023 09:01:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] arm64: dts: qcom: sm8550-aim300: add notification
 RGB LED
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <-cc=kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-12-quic_tengfan@quicinc.com>
 <5ab340be-5cd4-4fdb-87e2-05188cf7361e@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <5ab340be-5cd4-4fdb-87e2-05188cf7361e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kBwvoiuJAR0IGCCq84ykL1RwbF2DCqdh
X-Proofpoint-ORIG-GUID: kBwvoiuJAR0IGCCq84ykL1RwbF2DCqdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=574 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/17/2023 6:31 PM, Krzysztof Kozlowski 写道:
> On 17/11/2023 11:18, Tengfei Fan wrote:
>> The QRD features a notification LED connected to the pm8550.
>> Configure the RGB led controlled by the PMIC PWM controller.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> 
> You just added this board. Does it mean you added incomplete and wrong DTS?
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,
In next version patch series, I'm going to combine all the splited 
functions into one patch.

-- 
Thx and BRs,
Tengfei Fan
