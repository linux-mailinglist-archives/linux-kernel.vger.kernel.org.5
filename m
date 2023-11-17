Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4D7EEE25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjKQJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:10:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997992;
        Fri, 17 Nov 2023 01:10:40 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH69tC9027592;
        Fri, 17 Nov 2023 09:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=82qJD7J4Eg2G8Fyr2J1ob+B3of08iuAUuyE0IfHN0Dg=;
 b=S1YljXhrmA+iErKiPh/YJUBpv9dWxhrhFwaEFl18z7jRqeP0qlN1toB59vAXvV509ap1
 Kl6tE3KHH7OJbz9IY7aOtPHwAf5RgRw5Q2d5jwd7bHo5ywfMbqZOxXg1bllQ+a03Zqa1
 B1sI8v7NKDxyGSAvWdZS3YD30TydbXJlxxT6dppsd1h6Uyo3RS/espnQqFcBczBBoZ+k
 XT2Hdj0oS6Nnot4Nb0FWyg8JrbN2o3j5fHBRWvcyy9O5/Z8AEceAvy2iA9U3lA8BjuVF
 5T8PBIyE2KXK2yWROqa1OqzOPomROkdUGcQmXKQgp1bWUs2voU1ZaKwFhwhYMpj39JIO AQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue2na0cka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:10:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9ALXU009948
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:10:21 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 01:10:17 -0800
Message-ID: <e04bc179-347b-415a-a5e9-00563a24507e@quicinc.com>
Date:   Fri, 17 Nov 2023 14:40:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <will@kernel.org>, <joro@8bytes.org>, <a39.skl@gmail.com>,
        <konrad.dybcio@linaro.org>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com>
 <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
 <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
 <CAA8EJprPE=z2VN5LkaUyLyvYpx6i1eF9dyxOzN_L86pi5tmU-Q@mail.gmail.com>
 <0d290a5c-081f-4dfa-af9a-b061e6134662@quicinc.com>
 <CAA8EJprHppoN6rg8-rS1F+4kynQqmV1L3OiHFnJ0HyrshywFig@mail.gmail.com>
 <4db1b4d2-0aa9-4640-b7d7-7d18ab64569a@arm.com>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <4db1b4d2-0aa9-4640-b7d7-7d18ab64569a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: utyFtJGbvqdnYrr0qvP31-CR-31cxmD9
X-Proofpoint-ORIG-GUID: utyFtJGbvqdnYrr0qvP31-CR-31cxmD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_06,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/2023 10:34 PM, Robin Murphy wrote:
> On 16/11/2023 3:24 pm, Dmitry Baryshkov wrote:
>> On Thu, 16 Nov 2023 at 14:45, Bibek Kumar Patro
>> <quic_bibekkum@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 11/15/2023 4:33 PM, Dmitry Baryshkov wrote:
>>>> On Wed, 15 Nov 2023 at 11:45, Bibek Kumar Patro
>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>
>>>>> On 11/14/2023 7:45 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>
>>>>>>> Context caching is re-enabled in the prefetch buffer for Qualcomm 
>>>>>>> SoCs
>>>>>>> through SoC specific reset ops, which is disabled in the default 
>>>>>>> MMU-500
>>>>>>> reset ops, but is expected for context banks using ACTLR register to
>>>>>>> retain the prefetch value during reset and runtime suspend.
>>>>>>
>>>>>> Please refer to Documentation/process/submitting-patches.rst and
>>>>>> rephrase this following the rules there.
>>>>>>
>>>>>
>>>>> Noted, will go through the description once and rephrase it
>>>>> in next version complying with rules.
>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 
>>>>>>> ++++++++++++++++++----
>>>>>>>     1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> index 0eaf6f2a2e49..fa867b1d9d16 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct 
>>>>>>> device *dev)
>>>>>>>            return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>>>>>>     }
>>>>>>>
>>>>>>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>>>>>>> +{
>>>>>>> +       int i;
>>>>>>> +       u32 reg;
>>>>>>> +
>>>>>>> +       arm_mmu500_reset(smmu);
>>>>>>> +
>>>>>>> +       /* Re-enable context caching after reset */
>>>>>>> +       for (i = 0; i < smmu->num_context_banks; ++i) {
>>>>>>> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
>>>>>>> +               reg |= CPRE;
>>>>>>> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>     static int qcom_sdm845_smmu500_reset(struct arm_smmu_device 
>>>>>>> *smmu)
>>>>>>>     {
>>>>>>>            int ret;
>>>>>>>
>>>>>>> -       arm_mmu500_reset(smmu);
>>>>>>> +       qcom_smmu500_reset(smmu);
>>>>>>
>>>>>> Is this applicable for sdm845? For all other platforms supported by
>>>>>> qcom_smmu_500 implementation?
>>>>>>
>>>>>
>>>>> In arm_mmu500_reset operation 
>>>>> drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
>>>>> CPRE bit is reset for all SoC based on mmu500 platform, hence for all
>>>>> Qualcomm SoCs including sm845 we are setting back the CPRE bit.
>>>>
>>>> The errata for the CoreLink MMU-500 requires CPRE to be disabled for
>>>> all revisions before r2p2. Do we know whether these SoC used CoreLink
>>>> MMU-500 and which version of it?
>>>>
>>>
>>> Just checked all these SoCs are using r2p4 revision.
>>> So CPRE needs to be enabled back here then?
>>
>> can be enabled, yes.
> 
> There are still open errata #562869 and #1047329 which might need this 
> workaround. I guess one could argue that we're not (knowingly) using 
> nested translation at the moment, and also probably not running this in 
> situations which would end up using short-descriptor format, however 
> stuff like pKVM and IOMMUFD could potentially change those assumptions 
> in future, so they still feel a bit sketchy to me.
> 

Could you help provide some details on these two errata (#562869 and 
#1047329).Both of these erratum are there for r2p4 revisions as well?

Thanks & regards,
Bibek

> Thanks,
> Robin.
> 
>>
>>>
>>>>>
>>>>>>>
>>>>>>>            /*
>>>>>>>             * To address performance degradation in non-real time 
>>>>>>> clients,
>>>>>>> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl 
>>>>>>> qcom_smmu_500_impl = {
>>>>>>>            .init_context = qcom_smmu_init_context,
>>>>>>>            .cfg_probe = qcom_smmu_cfg_probe,
>>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>>> -       .reset = arm_mmu500_reset,
>>>>>>> +       .reset = qcom_smmu500_reset,
>>>>>>>            .write_s2cr = qcom_smmu_write_s2cr,
>>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>>     };
>>>>>>> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl 
>>>>>>> sm8550_smmu_500_impl = {
>>>>>>>            .init_context = qcom_smmu_init_context,
>>>>>>>            .cfg_probe = qcom_smmu_cfg_probe,
>>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>>> -       .reset = arm_mmu500_reset,
>>>>>>> +       .reset = qcom_smmu500_reset,
>>>>>>>            .write_s2cr = qcom_smmu_write_s2cr,
>>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>>     };
>>>>>>> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl 
>>>>>>> qcom_adreno_smmu_v2_impl = {
>>>>>>>     static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>>>>>>>            .init_context = qcom_adreno_smmu_init_context,
>>>>>>>            .def_domain_type = qcom_smmu_def_domain_type,
>>>>>>> -       .reset = arm_mmu500_reset,
>>>>>>> +       .reset = qcom_smmu500_reset,
>>>>>>>            .alloc_context_bank = 
>>>>>>> qcom_adreno_smmu_alloc_context_bank,
>>>>>>>            .write_sctlr = qcom_adreno_smmu_write_sctlr,
>>>>>>>            .tlb_sync = qcom_smmu_tlb_sync,
>>>>>>> -- 
>>>>>>> 2.17.1
>>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>>> -- 
>>>> With best wishes
>>>> Dmitry
>>
>>
>>
