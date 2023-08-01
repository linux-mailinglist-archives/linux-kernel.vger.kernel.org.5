Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71976A8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHAGKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHAGKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:10:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC510C1;
        Mon, 31 Jul 2023 23:10:50 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3712OTub021976;
        Tue, 1 Aug 2023 06:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k0aCpbnFwmp/8D1M9UqaS9hPY06JCFYLbdnWnW8RK8E=;
 b=fCOJKRp5GCf1qyk/d1zmobaAC6VysUZp1oc1Aebnb8uWE2u15ny5kUKLsK5yPYRvhBdM
 G1UfIRwoLDuoDRk9/5/dGkrkvRZpv1ldO4ctij3ncVaSHISQaHzf1ArsPkgl6tkQPu7s
 eCSXv0tlLN+IR8CbsPwpxmcEe6chrPR8DzoA16q7GjMH7jqXphk0ceGbTm8lDphByCi5
 BGYxTCalDRpp1lJCE4osQm4Z/OdWytMzhvucLUMTYdNQ2jlrH57weCN1q/c3hxiZnhJE
 +RxT2vw6xtlfA9efdBPn2fJ+MI5R6kIxE+knhKkMi7EYMwTCboxTWqN1nqJCQ3BK2acY 1w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rhare1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 06:10:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3716AkYc010211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 06:10:46 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 23:10:42 -0700
Message-ID: <71924c34-c398-22d7-bc79-50b0df482a22@quicinc.com>
Date:   Tue, 1 Aug 2023 11:40:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
 <9f417fea-38cf-942b-514e-99b47f27c544@quicinc.com>
 <wst227b45le3ql6ctkdiyiynae7ipy3gqiz6ibhbxau4bogb5o@w25vnllnwnw7>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <wst227b45le3ql6ctkdiyiynae7ipy3gqiz6ibhbxau4bogb5o@w25vnllnwnw7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B6VG5gmQ-zwu4vMHH6aINyuxfioYzfsU
X-Proofpoint-ORIG-GUID: B6VG5gmQ-zwu4vMHH6aINyuxfioYzfsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 10:05 PM, Bjorn Andersson wrote:
> On Thu, Jul 27, 2023 at 12:09:07PM +0530, Mukesh Ojha wrote:
>> On 7/24/2023 2:08 PM, Komal Bajaj wrote:
> [..]
>>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>>> index f82431ec8aef..e248d3daadf3 100644
>>> --- a/drivers/nvmem/Makefile
>>> +++ b/drivers/nvmem/Makefile
>>> @@ -44,6 +44,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
>>>    nvmem-nintendo-otp-y			:= nintendo-otp.o
>>>    obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
>>>    nvmem_qfprom-y				:= qfprom.o
>>> +obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)	+= nvmem_sec_qfprom.o
>>> +nvmem_sec_qfprom-y			:= sec-qfprom.o
>> Are we just doing this for just renaming the object ?
>>
> Correct.
>
>>>    obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>>>    nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
>>>    obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
>>> diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
> [..]
>>> +static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
>>> +{
>>> +	struct sec_qfprom *priv = context;
>>> +	unsigned int i;
>>> +	u8 *val = _val;
>>> +	u32 read_val;
>>> +	u8 *tmp;
>>> +
>>> +	for (i = 0; i < bytes; i++, reg++) {
>>> +		if (i == 0 || reg % 4 == 0) {
>>> +			if (qcom_scm_io_readl(priv->base + (reg & ~3), &read_val)) {
>>> +				dev_err(priv->dev, "Couldn't access fuse register\n");
>>> +				return -EINVAL;
>>> +			}
>>> +			tmp = (u8 *)&read_val;
>>> +		}
>>> +
>>> +		val[i] = tmp[reg & 3];
>>> +	}
>> Getting secure read from fuse region is fine here, since we have to read
>> 4 byte from trustzone, but this restriction of reading is also there
>> for sm8{4|5}50 soc's where byte by byte reading is protected and granularity
>> set to 4 byte (qfprom_reg_read() in drivers/nvmem/qfprom.c)
>> is will result in abort, in  that case this function need to export this
>> logic.
>>
> If qfprom needs similar treatment, then let's land this first and then
> consider generalizing (i.e. move to some library code) this - or if
> infeasible, just fix qfprom_reg_read().

Agree, I will implement this logic into qfprom driver (into 
qfprom_reg_read() ) in a separate patch.

Thanks
Komal
>
> Regards,
> Bjorn

