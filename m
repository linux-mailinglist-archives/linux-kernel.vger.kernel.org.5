Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8F75993C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGSPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGSPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:11:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3753A2;
        Wed, 19 Jul 2023 08:11:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JAbFwL018116;
        Wed, 19 Jul 2023 15:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NEljoRLZmxSC945GR/7jUU+l1FRSEid4AYsn6lQQG0g=;
 b=SljNi75lchYbJjSOGLfuDPVip5BrNdFSLhF/HfHRyTBU5CuRNa/s+FOaUrPezVFOQk3E
 9QNisxeLQrwftFXER7AwtK00JkxQYEZSbfLCDuqY8OCPt99pEB4q1N/ZiMOaGpQJWeJl
 r8tOjM/W8dp/NnYX6iMhP5IH8AdLNFfb8tHbgjHy3flc6C7+avSZU8F95/goAwfe5HtN
 n6PTvNmWl4xAeqMy64R5Mbr2nQvrLMaVB5Hocv53Dnq/EfYoiJGOKmzTO/xv8zotb5eq
 IpC8T8iGKjl7SmejRndoHHQ/e+MEtmA4+EVVkSoWy+yFXWpb3tMklvwixKGrWddr0wcE zQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx7rnhfyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 15:11:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JFBqoU021355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 15:11:52 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 08:11:45 -0700
Message-ID: <ed817ba3-a424-1247-0ba8-88f1a9c23fee@quicinc.com>
Date:   Wed, 19 Jul 2023 20:41:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [V3,02/11] dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring
 up clock macros
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
 <20230718120501.3205661-3-quic_mmanikan@quicinc.com>
 <9d473f0b-bd6b-f426-3bd2-2890e8a79431@linaro.org>
 <9c540e3b-d8d1-0807-a21e-d01a301c1972@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <9c540e3b-d8d1-0807-a21e-d01a301c1972@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: htHNUGCH63xkGt4IDHmdVxTGxuKTqvWc
X-Proofpoint-ORIG-GUID: htHNUGCH63xkGt4IDHmdVxTGxuKTqvWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_10,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=644
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190136
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 12:45 PM, Krzysztof Kozlowski wrote:
> On 19/07/2023 09:14, Krzysztof Kozlowski wrote:
>> On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
>>> In multipd model Q6 firmware takes care of bringup clocks,
>>> so remove them.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>> Changes in V3:
>>> 	- Rebased on TOT
>>
>> No clue what is TOT. We have TIP, but you should not use it as a base.
>> Other used names are mainline and linux-next.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Un-acked. I said last time that this does not compile and I do not see
> any improvements here.
> 

My bad, i missed.

Is it fine to move gcc driver patch to first and then dt-bindings
patch ?

With this way dt-bindings patch will compile.

Current patch order:
-------------------
1) Removing clock macros from dt-bindigs
https://patchwork.kernel.org/project/linux-arm-msm/patch/20230718120501.3205661-3-quic_mmanikan@quicinc.com/

2) Removing clocks from gcc driver
https://patchwork.kernel.org/project/linux-arm-msm/patch/20230718120501.3205661-5-quic_mmanikan@quicinc.com/


Proposed patch order:
---------------------
1) Removing clocks from gcc driver
https://patchwork.kernel.org/project/linux-arm-msm/patch/20230718120501.3205661-5-quic_mmanikan@quicinc.com/

2) Removing clock macros from dt-bindigs
https://patchwork.kernel.org/project/linux-arm-msm/patch/20230718120501.3205661-3-quic_mmanikan@quicinc.com/

Thanks & Regards,
Manikanta.

> Best regards,
> Krzysztof
> 
