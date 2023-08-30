Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35F78DE39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjH3S7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbjH3L0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:26:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF8132;
        Wed, 30 Aug 2023 04:26:27 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UAKIU5021502;
        Wed, 30 Aug 2023 11:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=39FSy9iMArq4qwujTHj5LNIHuUSVAhx3F/QVlkULB20=;
 b=HALMrjKWsXLkQj6ygdDezub4Y/KPZquEMvsH44LYDDN9N1HGAxLXx97o2X0lm0gq22Zh
 VcePBzMMiN/beu3hm5qSzhX9sc5y8Fjs1X5ysilJ4eh3LhOdguMlSIA04FRfIumEVG6o
 nkoztBeBCuvlZyYg/0xSvrIerfn8rxVctzAX5o92pbgcmOwjO5P83uOqXNQ/pk+E+TOp
 vMp8tUQf870o/xFpQEteWAByQsXKMl22SIHJ2IbgDdzBEIhlqT/+7O7IaqfRuZ6d3aqS
 Vl9IdJ6cl0Jxn0Ay2TNLI3dAGTiZzaOGwP4ZgH3tIvLh1XM1M2Voawrwlyw2nZ77wpSI GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st3whr3dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 11:26:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UBQMqc004209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 11:26:22 GMT
Received: from [10.50.47.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 04:26:18 -0700
Message-ID: <3f0d3997-effd-4f51-7aeb-a52428eca47e@quicinc.com>
Date:   Wed, 30 Aug 2023 16:56:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add IPQ5018 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230830111641.19293-1-quic_nsekar@quicinc.com>
 <3b4c873a-a091-51dd-4ce1-84b40886b5cd@linaro.org>
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <3b4c873a-a091-51dd-4ce1-84b40886b5cd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fcegh49H6YntyNDQ36BoE_Mw_vIvi6R6
X-Proofpoint-ORIG-GUID: Fcegh49H6YntyNDQ36BoE_Mw_vIvi6R6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=696 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300107
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/2023 4:48 PM, Krzysztof Kozlowski wrote:
> On 30/08/2023 13:16, Nitheesh Sekar wrote:
>> Document the IPQ5018 dwc3 compatible.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> ---
>> Link: https://lore.kernel.org/all/3e4e03b6-380c-ce61-dd93-30669e6f9b5c@linaro.org/
>> As per the review comments in the above series
>> created a new series for this patchset as per subsystem.
> Please provide changelog. This is not v1 anymore.
ok. Will add tag "V2" and post another version.

Regards,
Nitheesh
