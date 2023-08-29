Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00C78BE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjH2GBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjH2GBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:01:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D410C;
        Mon, 28 Aug 2023 23:01:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T4xFR7018456;
        Tue, 29 Aug 2023 06:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jO5xq/EeQ5EoB9F8EJCDml3opKZbrH3EKXAg6gdg3PE=;
 b=hnd37hOd8pB8+dHWVo3+84Nb1etp5h+qGZZL39BfHmjzDj61Zn5FoCCVY+fpm76xSqTg
 rKQnQ5ECj0mkw9kKvNmBwEj6dAY2+NBfiqRYdCdF9le+BJJBhl1Yl2cqIvmwbrjuT6uJ
 SfLU4EZ2avB3qgaCohL8oy8aXSuWfzK9ToS+UvXck2isAVYzEq+qr8QhDw3fmc+IrHuF
 c5zdrWomuPh8EWdZkwjTvF63AQfW4mlusrjy0mZ8Res0YAwrtUHYFsvYMaZuKN3K9KjE
 5ManIElrZLUjwHb3ydrj7EzB0SywJdVyZlJiP/qY7asVuldBPFMESHifkglTtqrFi2Y3 2g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybq99u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:01:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T61Nv5013054
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:01:23 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 23:01:18 -0700
Message-ID: <1a94738a-c2ec-519f-e966-baba1bcd36cf@quicinc.com>
Date:   Tue, 29 Aug 2023 11:31:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/7] thermal/drivers/qcom: Add new feat for soc without
 rpm
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-3-git-send-email-quic_srichara@quicinc.com>
 <CAA8EJppX4SJo8GtvR5D251mnAT42YzH7ju2bE+qxSc7GtmKXCQ@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAA8EJppX4SJo8GtvR5D251mnAT42YzH7ju2bE+qxSc7GtmKXCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LR00zH1S5k48xapRJr0ExBnH9F0YeM75
X-Proofpoint-GUID: LR00zH1S5k48xapRJr0ExBnH9F0YeM75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290051
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 8/29/2023 2:47 AM, Dmitry Baryshkov wrote:
> On Mon, 28 Aug 2023 at 22:20, Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
>>
>> Some of the tsens IP like the one in IPQ5018 does not have a
>> RPM in the soc. Hence the early init to enable tsens would not
> 
> Tsens IP doesn't have RPM. Please rephrase this.
> 

  ok.

>> be done. So add a flag for that in feat and skip enable checks.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   drivers/thermal/qcom/tsens.c | 2 +-
>>   drivers/thermal/qcom/tsens.h | 3 +++
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 98c356acfe98..f39495b61952 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
>>          ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>>          if (ret)
>>                  goto err_put_device;
>> -       if (!enabled) {
>> +       if (!enabled && !(priv->feat->no_early_init)) {
>>                  dev_err(dev, "%s: device not enabled\n", __func__);
>>                  ret = -ENODEV;
>>                  goto err_put_device;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 2805de1c6827..fb73e3dd0de9 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -505,6 +505,8 @@ enum regfield_ids {
>>    * @srot_split: does the IP neatly splits the register space into SROT and TM,
>>    *              with SROT only being available to secure boot firmware?
>>    * @has_watchdog: does this IP support watchdog functionality?
>> + * @no_early_init: does this IP reside in a soc that does not have rpm to
>> + *                 do pre-init.
>>    * @max_sensors: maximum sensors supported by this version of the IP
>>    * @trip_min_temp: minimum trip temperature supported by this version of the IP
>>    * @trip_max_temp: maximum trip temperature supported by this version of the IP
>> @@ -516,6 +518,7 @@ struct tsens_features {
>>          unsigned int adc:1;
>>          unsigned int srot_split:1;
>>          unsigned int has_watchdog:1;
>> +       unsigned int no_early_init:1;
> 
> s/no_early_init/ignore_enable/
> 

  ok, will change.

Regards,
  Sricharan
