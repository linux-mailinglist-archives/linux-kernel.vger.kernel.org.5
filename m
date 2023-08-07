Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCABC772503
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjHGNHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjHGNHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:07:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA8171A;
        Mon,  7 Aug 2023 06:07:10 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377ASHX8001047;
        Mon, 7 Aug 2023 13:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CqfOPwU9hDvT12Or13YFoKQiulhQ0+H+8G8AkmCCiDo=;
 b=g5oXedAmKh0+UOpgOp0EUlYUUXW/IXXKBNBsWjc5wlfD9u4YK5EqX0cAR2XJT21o2n67
 yvmNRLc3M5/PmUettkho2KmZq5MqISE/tUa+FSCrwagI370oAoYwZd/uIKpMMrlk5jGQ
 7bfwyq+UR3diQFIz77ny6vlsl891Y0r8FzjsrqVrQnqzcW+E+TAVXUZRtDTKinBiW8rW
 jEKrgrazWotpe01IDKSQbYHXnhz4uvYkAaI/IRPE0z2/9DnwLxDRCQE2HFYM9qrbEzAL
 QCGd6KJ224MOGjqQ4/UoB6EBYJwwaIPtPaMZIprcy9Stwtfgok/eyDACOKKS7AoMq7S2 TA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sawbg8kdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 13:06:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377D6wKr016911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 13:06:58 GMT
Received: from [10.216.6.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 06:06:53 -0700
Message-ID: <9864c6b8-aea0-f8e2-5949-2a05cf899e5a@quicinc.com>
Date:   Mon, 7 Aug 2023 18:36:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 0/9] Add pmics supported in Qualcomm's SDX75 platform
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <abel.vesa@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_pkondeti@quicinc.com>
References: <1691411333-1556-1-git-send-email-quic_rohiagar@quicinc.com>
 <83dff121-0a0f-4bd5-bf84-0c7c83f98615@linaro.org>
 <c4006b16-2c06-4c96-86a1-d4ba235503f4@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <c4006b16-2c06-4c96-86a1-d4ba235503f4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7AjZ_FNy7XoCdkW6U_Ip0PbbJxTAqPj3
X-Proofpoint-GUID: 7AjZ_FNy7XoCdkW6U_Ip0PbbJxTAqPj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=796
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070122
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2023 6:15 PM, Konrad Dybcio wrote:
> On 7.08.2023 14:45, Konrad Dybcio wrote:
>> On 7.08.2023 14:28, Rohit Agarwal wrote:
>>> Hi,
>>>
>>> Changes in v2:
>>>   - Added compatible for pm7550ba for eusb2 repeater and used it in DT.
>>>   - Addressed some minor comments from Konrad to add fixes tag, labels
>>>     and update the labels
>>>
>>> This series add support of pmics that are found in SDX75 platform and
>>> add the corresponding regulators in the IDP platform as well.
>>> It also parallely updates the pmic found in SDX65 to PM7250b and add pinctrl
>>> support for the same pmic chip.
>>> This series is based on the new header inclusion[1] and movement of the
>>> regulators level from rpmpd to rpmhpd[2].
>>> This series can be picked after successfully picking [2] and [3] as [1] has
>>> already been applied.
>>>
>>> [1] https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
>>> [2] https://lore.kernel.org/all/1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com/
>>> [3] https://lore.kernel.org/all/1690461813-22564-1-git-send-email-quic_rohiagar@quicinc.com/
>>>
>>> Thanks,
>>> Rohit.
>> Since you resent this (as mentioned in the first thread with "v2" [1]),
>> the subject should be [PATCH RESEND ...]
>>
> [1] https://lore.kernel.org/linux-arm-msm/f29eae07-b6c4-e7ea-3790-ee800d83859e@quicinc.com/T/#m863acf47848ba75987fcf144c588da21306dc2fe
Ok, Let me resend it with RESEND tag. But since there is no change will 
keep it v2.

Thanks,
Rohit.
>
> Konrad
