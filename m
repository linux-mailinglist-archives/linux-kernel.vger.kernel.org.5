Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1B78DF19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbjH3TXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241397AbjH3Gxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:53:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3987D194;
        Tue, 29 Aug 2023 23:53:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U6HXiM009693;
        Wed, 30 Aug 2023 06:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AR3LwVmiR7fUIw9Y7M81NThlnJOB2X7Gn0DBD2+0/mk=;
 b=gt15Phm8BQzrvzmb+oL7PIBUuGddnDcW4Zb8PVLJ/XGcQBNiuIUowRWmi9ZThdHPReJo
 zLAhe/qWgnRORTPC+9FrcdowUk01zRjMtXj07wjJXSpMZsudY3gBbp0HWSbVfq4UtP6b
 lkSW2ugNds/SLSr6N7mkc7ImBxNclWYe5bO5KlMaHF/k1rIg2gDc2smbQ//nYOM5q/k4
 UW021naJ7Gs9QYDzKU6wsxDgPzOTWXMAOcMI6NSp6dyNewtqffNAPgRKCv/eCOpCoWdp
 TbdnR57BNJ8/Eh5MNLR0pXbk3TNqgq13qGX8PtzHH0HdThWJpM95L3LyOV5Eyjgsees2 PA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sswbv0862-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:53:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U6raEd027024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:53:36 GMT
Received: from [10.50.47.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 23:53:31 -0700
Message-ID: <ff71da5b-4553-0be5-950e-47a0d741f676@quicinc.com>
Date:   Wed, 30 Aug 2023 12:23:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] dt-bindings: usb: dwc3: Add IPQ5018 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230825093531.7399-1-quic_nsekar@quicinc.com>
 <20230825093531.7399-3-quic_nsekar@quicinc.com>
 <3e4e03b6-380c-ce61-dd93-30669e6f9b5c@linaro.org>
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <3e4e03b6-380c-ce61-dd93-30669e6f9b5c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uqWx4pXznQocG_ii8QRXUcatiDlM5Hea
X-Proofpoint-GUID: uqWx4pXznQocG_ii8QRXUcatiDlM5Hea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 mlxlogscore=548 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300062
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/2023 4:07 PM, Krzysztof Kozlowski wrote:
> On 25/08/2023 11:35, Nitheesh Sekar wrote:
>> Document the IPQ5018 dwc3 compatible.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Split the series per subsystem. You are making applying process
> unnecessarily more cumbersome for the maintainers and as result - delay
> your patchset without any single reason.
Sure. Will split this into a separate one.

Regards,
Nitheesh
