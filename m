Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A1B758E69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjGSHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGSHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:09:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83755172B;
        Wed, 19 Jul 2023 00:09:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J5smMS028319;
        Wed, 19 Jul 2023 07:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MOFmThYSQ3uAWVQN8xSDNBD3gk6srOE1uRDrYefs0Jc=;
 b=RXlNgPZKDZkj4ArXM+cvsi+osbBANp60ST5sDJx5d9f99q+brzvs4rVMkUIYvM5lmGro
 zNryViSHsM28I4D3DFXJ5EHL5G4MLk7RjhdT3tVQS6rId8hfIZJ+grVkNOnhfsRNEjw1
 fVZd5HP2tSWTS1gFrY66DSGM7d67ZKU1+BQHYLiwk/5/l9HCm6XQXMMh6S5fUXaDb3e/
 F5gx4SYzb/9H/v8gaQZN/JR+P0W87W9Y6IOiCugk5jhP6YeCNPP29kMqvz/XuIodlrr0
 OWDH+QuhUXxVKsEo8WM12Xb9QEbSVOF1RDzkDSoGv4ZnO/69dhNeg59NbNuAYpB1Xz/v Lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwpphjm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 07:09:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J79r8a030247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 07:09:53 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 00:09:46 -0700
Message-ID: <f4337b79-96a5-ba1b-b824-b70068613126@quicinc.com>
Date:   Wed, 19 Jul 2023 12:39:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [V3,00/11] Add multipd remoteproc support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
 <bf6c7433-7773-9b4d-1141-b5ceccae77ee@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <bf6c7433-7773-9b4d-1141-b5ceccae77ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 541kBgwo4Jg-9khb6z4maG8F0aU4AHA6
X-Proofpoint-ORIG-GUID: 541kBgwo4Jg-9khb6z4maG8F0aU4AHA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_03,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=725 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190065
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 12:31 PM, Krzysztof Kozlowski wrote:
> On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
>> APSS brings Q6 out of reset and then Q6 brings
>> WCSS block (wifi radio's) out of reset.
>>
>> 				   ---------------
>> 			      -->  |WiFi 2G radio|
>> 			      |	   --------------
>> 			      |
>> --------	-------	      |
>> | APSS | --->   |QDSP6|  -----|
>> ---------	-------       |
>>                                |
>>        			      |
>> 			      |   --------------
>> 			      --> |WiFi 5G radio|
>> 				  --------------
>>
>> Problem here is if any radio crashes, subsequently other
>> radio also should crash because Q6 crashed. Let's say
>> 2G radio crashed, Q6 should pass this info to APSS. Only
>> Q6 processor interrupts registered with APSS. Obviously
>> Q6 should crash and raise fatal interrupt to APSS. Due
>> to this 5G radio also crashed. But no issue in 5G radio,
>> because of 2G radio crash 5G radio also impacted.
> 
> Your patches and cover letter is unnecessarily more difficult to parse
> and filter:
> 1. Please use standard email subjects, so with the PATCH keyword in the
> title. `git format-patch` helps here to create proper versioned patches.
> Another useful tool is b4. Skipping the PATCH keyword makes filtering of
> emails more difficult thus making the review process less convenient.
> 
I am wondering how i missed 'PATCH' keyword. Sorry for inconvenience.
I won't repeat next time.

> 2. Please wrap message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> This is wrapped way too early.

I will rework on cover page description and update it according
to standards.

Thanks & Regards,
Manikanta.

>>
> 
> Best regards,
> Krzysztof
> 
