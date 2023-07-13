Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F27520CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjGMMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjGMMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:08:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16182694;
        Thu, 13 Jul 2023 05:08:15 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DA0VqF012150;
        Thu, 13 Jul 2023 12:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0F4GPxIYA77tndG+1GAZHCJVFRLjMpsAqqv7BbRVin8=;
 b=DxqDRfjfMVEw0EOjzhwhj6UzUNowVVmgCA5TnnTPrEokJK6URE9KqOaFCZ43uirStJXY
 X6QThS0OwQY1jmp1bhcCoOcr7IOSVOj2uJXuzchwv8Eew9Dp+FIO9bNojKSYP3nSA2mD
 OO5ot2Jc/UxlHgO/FNKxhJX/2eZX9TJNeQVkQAXXM5xkF89B+naD6mL4RWxstT3lofdx
 AAo0BMUd0bnk3LJ1ry7pI7SYmNE1VxAJV3KNiKPIL3o68uLJxGKym2QkXQJMlpUQ1pq+
 5LYalP0xIwYccKvjXpRxpZ/JvodTHOnn57aMYiDlRKPA1K9wFYnsKbbMSwlfgvV9q49+ xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt89trxsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 12:08:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DC8Amb008693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 12:08:10 GMT
Received: from [10.201.206.212] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 05:08:06 -0700
Message-ID: <946b3761-a280-b0b6-e3ac-860d68f7072a@quicinc.com>
Date:   Thu, 13 Jul 2023 17:37:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for the RDP417
 variant
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230713115544.953998-1-quic_sridsn@quicinc.com>
 <20230713115544.953998-3-quic_sridsn@quicinc.com>
 <f9bfb051-aa39-0e87-6597-e5b5ce85a37f@linaro.org>
From:   Sridharan S N <quic_sridsn@quicinc.com>
In-Reply-To: <f9bfb051-aa39-0e87-6597-e5b5ce85a37f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 64roNzw-2rTzDfnmovjmhrH8GTnMjJPp
X-Proofpoint-GUID: 64roNzw-2rTzDfnmovjmhrH8GTnMjJPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=833 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130107
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/2023 5:28 PM, Krzysztof Kozlowski wrote:
> On 13/07/2023 13:55, Sridharan S N wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 417 based on IPQ9574 family of SoC.
>>
>> This patch depends on below patchset:
>> https://lore.kernel.org/lkml/20230713105909.14209-2-quic_anusha@quicinc.com/
> This does not make sense in commit log. Why would you store it in commit
> in the first place? Please put dependencies with changelog, so after ---
> separator.
>
> Best regards,
> Krzysztof

Sorry,I overlooked it. Will move the dependencies to change log and post v2


Thanks,

Sridharan

>
