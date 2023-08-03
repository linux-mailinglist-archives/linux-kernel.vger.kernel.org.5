Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7B76E41F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHCJQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjHCJQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:16:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB43AC;
        Thu,  3 Aug 2023 02:16:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373984vI026848;
        Thu, 3 Aug 2023 09:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AfmvGrFBo+mjbonztvfWYLDiQ0svI+wbYuTjfBmylIU=;
 b=HlLvaeFFlCsh6j8oHtIgalex0APZ0PaX7smmmU3dJpVPQHcljM2HnbL9SIkjgv/7uhUg
 fnzdgkvnUiBNQk7ORIwAhuKERb+ZETn2boaHqbldWNNR31j8yidAfxZK9Z7h3BtjabIT
 wu1f1hDLogzZNvflLaI4ZC8EI/VabVUzcabIEULZU5YFExbG2rde4knIM8iW/L3I06yb
 q9tiUr41tyQkuubQ7ofF/mWGzfUiVEKUhC2pwyyuh4VyQmd2EF/wY8AEn6TeOCDeH4+9
 zdfffie7Tja1/HM7NsXqtsPYemg7VAkmluT2sIw+3pGFpmBRbGNhdzqSufPeLTa5Y28J eg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7upp1gc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 09:16:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3739G6pD011728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 09:16:06 GMT
Received: from [10.201.2.96] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 3 Aug
 2023 02:16:03 -0700
Message-ID: <45649e51-7c89-24ea-cd99-4cc0e3dad71f@quicinc.com>
Date:   Thu, 3 Aug 2023 14:46:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on
 ARM / ARM64
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_eberman@quicinc.com>, <stable@vger.kernel.org>
References: <20230607045345.25049-1-quic_kathirav@quicinc.com>
 <2f915104-952f-3e3d-b3d5-4c0400b4f331@quicinc.com>
 <99084f51-f156-664b-cd69-51bf224674ac@quicinc.com>
Content-Language: en-US
In-Reply-To: <99084f51-f156-664b-cd69-51bf224674ac@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ue6prKWo0KgweRDRDHDs3iD_x_sXmSn2
X-Proofpoint-ORIG-GUID: Ue6prKWo0KgweRDRDHDs3iD_x_sXmSn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030081
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2023 7:28 PM, Kathiravan T wrote:
>
> On 6/20/2023 11:43 AM, Kathiravan T wrote:
>>
>> On 6/7/2023 10:23 AM, Kathiravan T wrote:
>>> During SCM probe, to identify the SCM convention, scm call is made with
>>> SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
>>> result what convention to be used is decided.
>>>
>>> IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit 
>>> kernel
>>> variants, however TZ firmware runs in 64bit mode. When running on 32bit
>>> kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
>>> system crash, due to the difference in the register sets between ARM 
>>> and
>>> AARCH64, which is accessed by the TZ.
>>>
>>> To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
>>
>>
>> Gentle Reminder...
>
>
> Bjorn,
>
> Can you share your thoughts on this patch?
>
>
> Thanks, Kathiravan T.


Gentle Reminder...


>
>
>>
>>
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC 
>>> and legacy conventions")
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>> Changes in V2:
>>>     - Added the Fixes tag and cc'd stable mailing list
>>>
>>>   drivers/firmware/qcom_scm.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index fde33acd46b7..db6754db48a0 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -171,6 +171,7 @@ static enum qcom_scm_convention 
>>> __get_convention(void)
>>>       if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
>>>           return qcom_scm_convention;
>>>   +#if IS_ENABLED(CONFIG_ARM64)
>>>       /*
>>>        * Device isn't required as there is only one argument - no 
>>> device
>>>        * needed to dma_map_single to secure world
>>> @@ -191,6 +192,7 @@ static enum qcom_scm_convention 
>>> __get_convention(void)
>>>           forced = true;
>>>           goto found;
>>>       }
>>> +#endif
>>>         probed_convention = SMC_CONVENTION_ARM_32;
>>>       ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
