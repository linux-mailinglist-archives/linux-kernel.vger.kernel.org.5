Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AAA76C8C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHBIyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjHBIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:54:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5039F194;
        Wed,  2 Aug 2023 01:54:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3726r9iF009262;
        Wed, 2 Aug 2023 08:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g6o5wNG6h6qIOs8mDQ0tL85vtIAgcD0isgshbVbA0Do=;
 b=ggXLxTlhxOySZPRbU82Wx4wW2teLBtlBqt3i9kww6FEGnC1mFc+GB6+U315ak9rdh+bI
 7AWuqr4utGQA7IJwBF7jYQzYdGfD0EU/fr66QsEZICH0vgRh7HX0yEdM6N14PI+80GHh
 +WfNN5qLk59O8kl/D6nvHoE4J0Omfj286+oI4t3rnnqy7+ek4GQChsm4KTg6ovQVMtnd
 Bqlz5vBp7T8PumrtpXF4JFHkuU/CmToh79TUcaLG+iyeOj1Y6qupAdsYz2MLl/vhOHZ2
 hBUhJwuYXxaZ7OBDIolb4MV9CFy//y5nf4xPm4q1VjpkBDuZ8gWO/8gXfRJhWHyIJVMh rQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s76jv1rax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:54:07 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3728s5O6014329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:54:05 GMT
Received: from [10.214.67.128] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 01:54:02 -0700
Message-ID: <16f07bd5-f62b-5288-74a4-4547ef077d46@quicinc.com>
Date:   Wed, 2 Aug 2023 14:23:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/6] nvmem: core: Add stub for nvmem_cell_read_u8
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-4-quic_kbajaj@quicinc.com>
 <3e193791-613f-b500-75a1-5f36cefe0ddc@quicinc.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <3e193791-613f-b500-75a1-5f36cefe0ddc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wB0hEm6kgcDHDcfa4Z0t6lfrssBGQ1TL
X-Proofpoint-GUID: wB0hEm6kgcDHDcfa4Z0t6lfrssBGQ1TL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020078
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 6:06 PM, Mukesh Ojha wrote:
>
>
> On 7/24/2023 2:11 PM, Komal Bajaj wrote:
>> This change add the stub function for nvmem_cell_read_u8.
>
> "Add the stub nvmem_cell_read_u8() function for drivers running with
> CONFIG_NVMEM disabled"

Okay, will update the commit description.

Thanks
Komal

>
> -Mukesh
>
>> This will be helpful when a driver uses this function and
>
>
>
> -Mukesh
>
>> CONFIG_NVMEM is not enabled.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   include/linux/nvmem-consumer.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/nvmem-consumer.h 
>> b/include/linux/nvmem-consumer.h
>> index fa030d93b768..5c88635d4c2b 100644
>> --- a/include/linux/nvmem-consumer.h
>> +++ b/include/linux/nvmem-consumer.h
>> @@ -125,6 +125,12 @@ static inline int nvmem_cell_write(struct 
>> nvmem_cell *cell,
>>       return -EOPNOTSUPP;
>>   }
>>   +static inline int nvmem_cell_read_u8(struct device *dev,
>> +                     const char *cell_id, u8 *val)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   static inline int nvmem_cell_read_u16(struct device *dev,
>>                         const char *cell_id, u16 *val)
>>   {

