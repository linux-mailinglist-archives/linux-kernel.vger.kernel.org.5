Return-Path: <linux-kernel+bounces-5093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3464818682
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AEAB2425C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21F116423;
	Tue, 19 Dec 2023 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lM/G4drB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA5156EC;
	Tue, 19 Dec 2023 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ4Stpj013179;
	Tue, 19 Dec 2023 11:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tTEM9+8aN4jdGDZVBn56jBJDwAVMgY9LUmvQoSoWN8o=; b=lM
	/G4drBoOybYqO4v6ZQvs69e6nGZxeUXanKIW3yemms7/Axtf3JB8KcMLZJbaQIUQ
	PGG2iXjsO3yRoLyN3/MutOt5WPXIrJDfrWHRMkCWn1vCeuRrW7uCkzOHtGh9vyz3
	QtUoqoewC2aB2Xj9g0GV8HFGY6BG8xBiZq0Z0uOK9Pw3ldooyka/QBjxMzV8sf+j
	+iLdtMaL6J/b5YfKC83Z1Xqjy7te7q2NO2xAWY6TDdg0l5CXxuLng/LV5vl4Xxe3
	rMTKEfGLPM/s6GwVKcYhbcb+ZWKFvQRNrdE+XGhjCe2B80feg5umBQmC/xqtk0DD
	cs1ZpCYfFmvrrLedfr/A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2yyxhec0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 11:39:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJBdMN6025950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 11:39:22 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 03:39:16 -0800
Message-ID: <fe091dba-142e-403c-b304-b79064718555@quicinc.com>
Date: Tue, 19 Dec 2023 17:09:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robin Murphy
	<robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>,
        <mani@kernel.org>, <quic_eberman@quicinc.com>,
        <robdclark@chromium.org>, <u.kleine-koenig@pengutronix.de>,
        <robh@kernel.org>, <vladimir.oltean@nxp.com>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com>
 <CAA8EJppcsr1sbeD1fK0nZ+rASABNcetBK3yMvaP7OiA4JPwskw@mail.gmail.com>
 <c9493c5f-ccf8-4e21-b00c-5fbc2a5f2edb@quicinc.com>
 <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
 <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org>
 <42d627af-164b-4b50-973e-fa71d86cb84c@linaro.org>
 <aa8b2ccd-33da-404b-9a93-3d88cf63ec77@quicinc.com>
 <8338db1e-0216-4fc5-b6ab-ddf43adf3648@linaro.org>
 <a363c860-62be-43a7-930c-cab8a6f3fa6c@quicinc.com>
 <CAA8EJpoMwrwQ9wBZE6AcobLLkCchFtN23SnHhw3enNOfX3CzTQ@mail.gmail.com>
 <334bc814-07d2-4966-93e3-f2cfbabc15b2@quicinc.com>
 <CAA8EJprL8pHQyWcdHiS+GReJsTMrddL=SCgkPhePR_7HvsQpsQ@mail.gmail.com>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJprL8pHQyWcdHiS+GReJsTMrddL=SCgkPhePR_7HvsQpsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BfMrt3ZJkh0VCNRteAlKbLahPha3pp4d
X-Proofpoint-GUID: BfMrt3ZJkh0VCNRteAlKbLahPha3pp4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190086



On 12/19/2023 4:14 PM, Dmitry Baryshkov wrote:
> On Tue, 19 Dec 2023 at 12:37, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>>
>>
>> On 12/19/2023 3:51 PM, Dmitry Baryshkov wrote:
>>> On Tue, 19 Dec 2023 at 10:25, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/18/2023 7:51 PM, Dmitry Baryshkov wrote:
>>>>> On 18/12/2023 13:23, Bibek Kumar Patro wrote:
>>>>>>
>>>>>>
>>>>>> On 12/16/2023 9:45 PM, Dmitry Baryshkov wrote:
>>>>>>> On 16/12/2023 02:03, Konrad Dybcio wrote:
>>>>>>>> On 15.12.2023 13:54, Robin Murphy wrote:
>>>>>>>>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
>>>>>>>>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
>>>>>>>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Add ACTLR data table for SM8550 along with support for
>>>>>>>>>>>> same including SM8550 specific implementation operations.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>      drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89
>>>>>>>>>>>> ++++++++++++++++++++++
>>>>>>>>>>>>      1 file changed, 89 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>>>> index cb49291f5233..d2006f610243 100644
>>>>>>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>>>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
>>>>>>>>>>>>             u32 actlr;
>>>>>>>>>>>>      };
>>>>>>>>>>>>
>>>>>>>>>>>> +/*
>>>>>>>>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching
>>>>>>>>>>>> in the
>>>>>>>>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the
>>>>>>>>>>>> prefetch
>>>>>>>>>>>> + * buffer). The remaining bits are implementation defined and
>>>>>>>>>>>> vary across
>>>>>>>>>>>> + * SoCs.
>>>>>>>>>>>> + */
>>>>>>>>>>>> +
>>>>>>>>>>>> +#define PREFETCH_DEFAULT       0
>>>>>>>>>>>> +#define PREFETCH_SHALLOW       BIT(8)
>>>>>>>>>>>> +#define PREFETCH_MODERATE      BIT(9)
>>>>>>>>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
>>>>>>>>>>>
>>>>>>>>>>> I thin the following might be more correct:
>>>>>>>>>>>
>>>>>>>>>>> #include <linux/bitfield.h>
>>>>>>>>>>>
>>>>>>>>>>> #define PREFETCH_MASK GENMASK(9, 8)
>>>>>>>>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
>>>>>>>>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
>>>>>>>>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
>>>>>>>>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Ack, thanks for this suggestion. Let me try this out using
>>>>>>>>>> GENMASK. Once tested, will take care of this in next version.
>>>>>>>>>
>>>>>>>>> FWIW the more typical usage would be to just define the named
>>>>>>>>> macros for the raw field values, then put the FIELD_PREP() at the
>>>>>>>>> point of use. However in this case that's liable to get pretty
>>>>>>>>> verbose, so although I'm usually a fan of bitfield.h, the most
>>>>>>>>> readable option here might actually be to stick with simpler
>>>>>>>>> definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really
>>>>>>>>> a big deal either way, and I defer to whatever Dmitry and Konrad
>>>>>>>>> prefer, since they're the ones looking after arm-smmu-qcom the most :)
>>>>>>>> My 5 cents would be to just use the "common" style of doing this, so:
>>>>>>>>
>>>>>>>> #define ACTRL_PREFETCH    GENMASK(9, 8)
>>>>>>>>     #define PREFETCH_DEFAULT 0
>>>>>>>>     #define PREFETCH_SHALLOW 1
>>>>>>>>     #define PREFETCH_MODERATE 2
>>>>>>>>     #define PREFETCH_DEEP 3
>>>>>>>>
>>>>>>>> and then use
>>>>>>>>
>>>>>>>> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
>>>>>>>>
>>>>>>>> it can get verbose, but.. arguably that's good, since you really want
>>>>>>>> to make sure the right bits are set here
>>>>>>>
>>>>>>> Sounds good to me.
>>>>>>>
>>>>>>
>>>>>> Konrad, Dimitry, just checked FIELD_PREP() implementation
>>>>>>
>>>>>> #define FIELD_FIT(_mask, _val)
>>>>>> ({                                                              \
>>>>>>                     __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");  \
>>>>>>                     ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask); \
>>>>>> })
>>>>>>
>>>>>> since it is defined as a block, it won't be possible to use FIELD_PREP
>>>>>> in macro or as a structure value, and can only be used inside a
>>>>>> block/function. Orelse would show compilation errors as following
>>>>>>
>>>>>> kernel/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:94:20: note: in
>>>>>> expansion of macro 'PREFETCH_SHALLOW'
>>>>>>      { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>>>>                        ^
>>>>>> kernel/include/linux/bitfield.h:113:2: error: braced-group within
>>>>>> expression allowed only inside a function
>>>>>>      ({        \
>>>>>>      ^
>>>>>>
>>>>>> So as per my understanding I think, we might need to go ahead with the
>>>>>> generic implementation only. Let me know if I missed something.
>>>>>
>>>>> Then anyway (foo << bar) is better compared to BIT(n) | BIT(m).
>>>>>
>>>>
>>>> Sure Dmitry, (foo << bar) would be simpler as well as Robin mentioned
>>>> earlier in his reply.
>>>> I can implement the defines as:
>>>>
>>>> #define PREFETCH_DEFAULT       0
>>>> #define PREFETCH_SHALLOW       (1 << 8)
>>>> #define PREFETCH_MODERATE      (1 << 9)
>>>
>>> 2 << 8. Isn't that hard.
>>>
>>
>> Ah, right. This is nice! .
>> Will use 2 << 8 instead. Thanks for the suggestion.
> 
> It might still be useful to define the PREFETCH_SHIFT equal to 8.
> 

Sure, looks okay to me as well to define PREFETCH_SHIFT to 8
as it's constant.

Thanks,
Bibek

>>
>> Thanks,
>> Bibek
>>
>>>> #define PREFETCH_DEEP          (3 << 8)
>>>>
>>>> This should be okay I think ?
>>>>
>>>> Thanks,
>>>> Bibek
>>>>
>>>
>>>
> 
> 
> 

