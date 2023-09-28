Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAA7B112C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjI1DZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1DZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:25:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4783B94;
        Wed, 27 Sep 2023 20:25:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S0hdB9026031;
        Thu, 28 Sep 2023 03:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=grNrLoV28d5n1cs+whe18FZ93EPbXFJ8YZQwi16fRrY=;
 b=ef8UoKEdPHl1Vx2KwqWZBKF+VghjwICwNgHqVOVf/tGcjyLjj+S9ms8aPX2fDu1y4hkA
 Dnnvy8oK+nHP1DYykL27K5hgcK5giEx+NmNXGqPr4bdlNrGBoq/20Ww9JwfSbyzua1Ws
 zKkcCpsLsaADL/zLp3ROccoBhACTtvq+y4H69Zios8cqO4T8QwhdbgmDxOaJMQtQ/9M7
 i5ffq1Xw+BiUnJDacKCVlb3vKhHM0No8KvtyT8NJVSoxOpfgBvWhIvUcJZGgeR9xa27g
 k2wft7nrYS5QqxZfAuCYus0+cUgEMxCX7YjiVv+/q/clnW793aZWmJ8GsQcUIYLzMkVT cQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcda7tqvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 03:24:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S3Oh8I025207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 03:24:43 GMT
Received: from [10.216.41.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 20:24:33 -0700
Message-ID: <8ec79ad9-bbd5-eac7-3128-0487e0459b61@quicinc.com>
Date:   Thu, 28 Sep 2023 08:54:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 3/5] opp: Add dev_pm_opp_find_level_floor()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vireshk@kernel.org>, <nm@ti.com>,
        <sboyd@kernel.org>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-4-git-send-email-quic_krichai@quicinc.com>
 <20230927071458.busudwwj26kmia4u@vireshk-i7>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230927071458.busudwwj26kmia4u@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Wctj5yS1caAOQnwjX4lCk_l-yZhPjdg
X-Proofpoint-GUID: 0Wctj5yS1caAOQnwjX4lCk_l-yZhPjdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280029
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2023 12:44 PM, Viresh Kumar wrote:
> On 07-09-23, 11:30, Krishna chaitanya chundru wrote:
>
> $Subject should have OPP instead of opp. Past history of framework can be seen
> for this.

I will change the subject in the next patch series.

- KC

>> During initialization of some drivers, need to vote for max level.
>>
>> Adding dev_pm_opp_find_level_floor() for searching a lesser match or
>> operating on OPP in the order of decreasing level.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/opp/core.c     | 25 +++++++++++++++++++++++++
>>   include/linux/pm_opp.h |  9 +++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 919cc53..6d4d226 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -814,6 +814,31 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
>>   
>>   /**
>> + * dev_pm_opp_find_level_floor() - Search for a rounded floor freq
> freq ?
>
>> + * @dev:	device for which we do this operation
>> + * @level:	Start level
>> + *
>> + * Search for the matching floor *available* OPP from a starting level
>> + * for a device.
>> + *
>> + * Return: matching *opp and refreshes *level accordingly, else returns
>> + * ERR_PTR in case of error and should be handled using IS_ERR. Error return
>> + * values can be:
>> + * EINVAL:	for bad pointer
>> + * ERANGE:	no match found for search
>> + * ENODEV:	if device not found in list of registered devices
>> + *
>> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
>> + * use.
>> + */
>> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
>> +					       unsigned long *level)
>> +{
>> +	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
>> +
>> +/**
>>    * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
>>    * @dev:	device for which we do this operation
>>    * @bw:	start bandwidth
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index 91f87d7..baea92f 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -144,6 +144,9 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>>   struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>>   					      unsigned int *level);
>>   
>> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
>> +					       unsigned long *level);
>> +
>>   struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
>>   					   unsigned int *bw, int index);
>>   
>> @@ -314,6 +317,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
>>   	return ERR_PTR(-EOPNOTSUPP);
>>   }
>>   
>> +static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
> Why add between two bw related functions ?
>
>> +							     unsigned long *level)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>>   static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>>   					unsigned int *bw, int index)
>>   {
> Fixed all this and applied. Thanks.
>
