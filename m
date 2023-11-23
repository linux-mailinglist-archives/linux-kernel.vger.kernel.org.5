Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64417F5B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjKWJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKWJjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:39:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D858D41;
        Thu, 23 Nov 2023 01:39:11 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN99CdQ010829;
        Thu, 23 Nov 2023 09:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fVu0Dv71kyMzuO2gCH1AEla4mWG8l3Rv8Z188wvB89Y=;
 b=m146CrM2qH5TPAfkyhORRyjbm1EygISNXHUk5lEUMCObTswmphdCg6ZjBPpkKFH3vti3
 PHjZ5JnWRZRbYcMHXrTuZGXyPR92kMf1URDEnUJRw8uv/l1WNUG9uz4PB+3ZDpw1nrwf
 LDM+W9ITtBNbS3IoiyZ+yTFixfy8jZWg28wRdsGUJj6wjegpkUdoPmPcxLeSDjvALc2T
 YtbfkQAcZAmqhyI6kST3zNsGiAq9tlBBn78uD//mrdTQtEzm/Vx/+5UwFHvUgR+c5b/x
 Rqo3Vu6gEil8WQoa6f1ReeNCN42TXnCXVtp9AqJ9n+/OQB3jFg2fDqzl9b1huQOWbTZT pw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj30x859y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:39:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN9d6vN005836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:39:06 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 01:39:02 -0800
Message-ID: <b79e8a80-4ee3-e20a-cccf-5ed219072c1d@quicinc.com>
Date:   Thu, 23 Nov 2023 15:08:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 1/2] dt-bindings: interconnect: Add Qualcomm X1E80100
 SoC
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>
References: <20231117103035.25848-1-quic_sibis@quicinc.com>
 <20231117103035.25848-2-quic_sibis@quicinc.com>
 <77f39971-6d8a-4e1a-b7e6-bffb5fbf74db@kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <77f39971-6d8a-4e1a-b7e6-bffb5fbf74db@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DyrWU_syZ-AVBiFUFwyXhAqM93AZHLqv
X-Proofpoint-GUID: DyrWU_syZ-AVBiFUFwyXhAqM93AZHLqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230068
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 20:22, Georgi Djakov wrote:
> Hi Sibi,

Hey Georgi,

Thanks for taking time to review the series!

> On 17.11.23 12:30, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> The Qualcomm X1E80100 SoC has several bus fabrics that could be 
>> controlled
>> and tuned dynamically according to the bandwidth demand.
>>
>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>
>> v2:
>> * Update the part number from sc8380xp to x1e80100.
>> * Fixup required property ordering [Krzysztof]
>> * Pickup Rbs.
>>
>>   .../interconnect/qcom,x1e80100-rpmh.yaml      |  83 +++++++
>>   .../interconnect/qcom,x1e80100-rpmh.h         | 207 ++++++++++++++++++
>>   2 files changed, 290 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
>>   create mode 100644 
>> include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
> 
> [..]
> 
>> +#define MASTER_AV1_ENC                0
>> +#define MASTER_CAMNOC_HF            1
>> +#define MASTER_CAMNOC_ICP            2
>> +#define MASTER_CAMNOC_SF            3
>> +#define MASTER_EVA                4
>> +#define MASTER_MDP                5
>> +#define MASTER_VIDEO                6
>> +#define MASTER_VIDEO_CV_PROC            7
>> +#define MASTER_VIDEO_V_PROC            8
>> +#define MASTER_CNOC_MNOC_CFG            9
>> +#define SLAVE_MNOC_HF_MEM_NOC            10
>> +#define SLAVE_MNOC_SF_MEM_NOC            11
>> +#define SLAVE_SERVICE_MNOC            12
>> +#define MASTER_MDP_DISP                13
>> +#define SLAVE_MNOC_HF_MEM_NOC_DISP        14
>> +
>> +#define MASTER_CDSP_PROC            0
>> +#define SLAVE_CDSP_MEM_NOC            1
>> +
>> +#define MASTER_PCIE_NORTH            0
>> +#define MASTER_PCIE_SOUTH            0
> 
> This duplicate index looks like a typo?

Thanks for catching ^^. Will fix it in the next re-spin.

-Sibi

> 
>> +#define SLAVE_ANOC_PCIE_GEM_NOC            3
>> +#define MASTER_PCIE_NORTH_PCIE            4
>> +#define MASTER_PCIE_SOUTH_PCIE            5
>> +#define SLAVE_ANOC_PCIE_GEM_NOC_PCIE        6
> [..]
> 
> Thanks,
> Georgi
> 
> 
