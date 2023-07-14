Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0531753C59
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjGNN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbjGNN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:59:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EE426B5;
        Fri, 14 Jul 2023 06:59:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EBrE9l028598;
        Fri, 14 Jul 2023 13:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RKiLvVyTbirgw09WubHCuDGi667YE5Ck8Aegz+gLNbk=;
 b=Al2Dhd4xiOamIye89agaIWhnNhc/BlrNT7N3XJa4RqaMarZvbamrlnv52XUB6S8oAOfB
 0RKpRZRbDKII9zSuqE4UpBU80qiieWFSb0qk75O/ihlKjM7UXjlPRDKbd0whSI5qleSK
 1DaKLX4r2hAxO6MfHJVm+GJ2HlRg1+/EhPck6s/Ft4rP+cxzDXSm/01eo3taVy42tjSi
 Y2/tSKc82lZOallt1HERDil5XoOd2+6uGMYjpDg70DlJRKWYhfaBQ+9Z0ZSOVRvQ7sE5
 YQ1Qu2dYhdo5NrNC/NixI0viBZiB6P42+wsocoujQD3bld14zVdt+/Qjo9lwDdk5oruY 9A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpuksum6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:58:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EDwaIP008960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 13:58:36 GMT
Received: from [10.216.8.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 06:58:29 -0700
Message-ID: <99084f51-f156-664b-cd69-51bf224674ac@quicinc.com>
Date:   Fri, 14 Jul 2023 19:28:24 +0530
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
Content-Language: en-US
In-Reply-To: <2f915104-952f-3e3d-b3d5-4c0400b4f331@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fzRa-E1oNp2sYMYiiNvpk4tNU_tm9ao7
X-Proofpoint-GUID: fzRa-E1oNp2sYMYiiNvpk4tNU_tm9ao7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140126
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/2023 11:43 AM, Kathiravan T wrote:
>
> On 6/7/2023 10:23 AM, Kathiravan T wrote:
>> During SCM probe, to identify the SCM convention, scm call is made with
>> SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
>> result what convention to be used is decided.
>>
>> IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
>> variants, however TZ firmware runs in 64bit mode. When running on 32bit
>> kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
>> system crash, due to the difference in the register sets between ARM and
>> AARCH64, which is accessed by the TZ.
>>
>> To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
>
>
> Gentle Reminder...


Bjorn,

Can you share your thoughts on this patch?


Thanks, Kathiravan T.


>
>
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC 
>> and legacy conventions")
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>>     - Added the Fixes tag and cc'd stable mailing list
>>
>>   drivers/firmware/qcom_scm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index fde33acd46b7..db6754db48a0 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -171,6 +171,7 @@ static enum qcom_scm_convention 
>> __get_convention(void)
>>       if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
>>           return qcom_scm_convention;
>>   +#if IS_ENABLED(CONFIG_ARM64)
>>       /*
>>        * Device isn't required as there is only one argument - no device
>>        * needed to dma_map_single to secure world
>> @@ -191,6 +192,7 @@ static enum qcom_scm_convention 
>> __get_convention(void)
>>           forced = true;
>>           goto found;
>>       }
>> +#endif
>>         probed_convention = SMC_CONVENTION_ARM_32;
>>       ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
