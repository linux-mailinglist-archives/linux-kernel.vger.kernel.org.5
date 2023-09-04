Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAC7911B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352380AbjIDG6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbjIDG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:58:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C71123;
        Sun,  3 Sep 2023 23:57:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384657cT018056;
        Mon, 4 Sep 2023 06:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f/6q3k2/wRZz7MrXuwsX/SOSEOJVMJyRe+NGRs2DE0g=;
 b=P9+55I561j+wbDV0HQvurE3EjvwAfgfmBYOIc3BB8ooUBR3MS0m4KTD9TGDxCs1b0wiv
 pbSPWE/Mg6YRC61MQhNq0mVk3Y1N7qqpZ8ofEr6DXjKpjSkHjLrtCwQxdcMeRxQErKOe
 11wLsW30Ogq56hky9h9wAAkRDde2UR3h6xw/7qlJzTB4UZ5Nb3tP7UztIW+2H78Wv9Ts
 5jsar31snGsXxlQVfv2EaYoj8A8O7rD6Lvx+Jepu9gMjDyEUrU/uAP0fvzHiDJ9GIxrA
 BSl/lHoBk8s2jAG38CZReqsEoP4LbySN6aC0n/1U3ItqbZ2Q6meUH7QbAfDDDRh1WRGR Dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suw50tqd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 06:57:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3846vo49007109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 06:57:50 GMT
Received: from [10.201.162.56] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 3 Sep
 2023 23:57:45 -0700
Message-ID: <7579f8d6-8968-44c4-bba7-8221d5d4516f@quicinc.com>
Date:   Mon, 4 Sep 2023 12:27:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: ipq6018: Fix tcsr_mutex register
 size
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ohad@wizery.com>,
        <baolin.wang@linux.alibaba.com>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
 <20230904055010.4118982-2-quic_viswanat@quicinc.com>
 <9380d42a-2c24-89ad-14ca-99e0f1ffcbf7@linaro.org>
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <9380d42a-2c24-89ad-14ca-99e0f1ffcbf7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -sm1hK-OuwDX9mdZj_jh7sFlt59J_EIh
X-Proofpoint-ORIG-GUID: -sm1hK-OuwDX9mdZj_jh7sFlt59J_EIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=670 clxscore=1011
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309040062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2023 12:10 PM, Krzysztof Kozlowski wrote:
> On 04/09/2023 07:50, Vignesh Viswanathan wrote:
>> IPQ6018 has 32 tcsr_mutex hwlock registers and size of each is 0x1000.
>>
>> Fix size of the tcsr_mutex hwlock register to 0x20000.
>> Also, remove the qcom,ipq6018-tcsr-mutex compatible as this maps to
>> incorrect stride and mutex config for IPQ6018 in hwspinlock driver.
> 
> This is 6018, so if 6018 compatible is incorrect... this does not make
> any sense.
> 
> NAK
> 

Understood, Instead of removing the 6018 compatible, I'll use the same
and fix the config mapped to 6018 in the hwspinlock driver.

Thanks,
Vignesh
> 
> Best regards,
> Krzysztof
> 
