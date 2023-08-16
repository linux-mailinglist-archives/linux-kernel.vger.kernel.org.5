Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95577D6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbjHPAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbjHPAKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:10:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B71FF9;
        Tue, 15 Aug 2023 17:10:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FNk2fp014657;
        Wed, 16 Aug 2023 00:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/sp3AgrnBEmHamq/qC++wlsR2QVoM6XWuGxyCMF61Ig=;
 b=co+KvoqKdbGCQ/5pk2N5jWWD4+kkZL2nJ5pG7kZ1YhX8fgD3vVN/hcSAy9M8w5//6YRK
 VyJXxBChWoeNHoYhCvaNRyJ6E95QOJlWclqFjYzL3FXc04pOEFLpnO24B5Yzoqs7xZtF
 yxnyxGQ83e2fcA8Q2OV8sFaPp0UqzczRWMtoJ2gQDnRBwDorErRoMpCh1LOmq/Y+83+G
 yqvNnpkCwuIW+43aS3wVN8tEHSFkat8BWCk05u2ThyB+rXy2PfHX3cWuPIKqiiZnwg7X
 Y6R/S3ccDo4OlToo6hwSat2dkd0gT7yO88PBwV5g6Lj8xAMCYzxWuj5c1w0GHX2u5BoB nw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfqp1jy25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 00:10:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G0A7NP008345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 00:10:07 GMT
Received: from [10.110.36.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 15 Aug
 2023 17:10:06 -0700
Message-ID: <23a46503-ca45-26cb-c1df-f765e6db95d4@quicinc.com>
Date:   Tue, 15 Aug 2023 17:09:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230814235918.10396-1-quic_amelende@quicinc.com>
 <20230814235918.10396-5-quic_amelende@quicinc.com>
 <vt2ma5qiqv4uvzdhhouvxo6ykvfcwlqjjvctcsorfy6dfh2efp@g4viqt2rqvz4>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <vt2ma5qiqv4uvzdhhouvxo6ykvfcwlqjjvctcsorfy6dfh2efp@g4viqt2rqvz4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: negTXOjxz5dJg7NOVlXcGyezP1bGwF8U
X-Proofpoint-ORIG-GUID: negTXOjxz5dJg7NOVlXcGyezP1bGwF8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150217
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 8:38 AM, Bjorn Andersson wrote:
> On Mon, Aug 14, 2023 at 04:59:15PM -0700, Anjelique Melendez wrote:

[...]>> @@ -65,7 +83,12 @@ struct lpg_data;
>>   * @lut_base:	base address of the LUT block (optional)
>>   * @lut_size:	number of entries in the LUT block
>>   * @lut_bitmap:	allocation bitmap for LUT entries
>> - * @triled_base: base address of the TRILED block (optional)
>> + * @pbs_dev:	PBS device
>> + * @lpg_chan_nvmem:	LPG nvmem peripheral device
>> + * @pbs_en_bitmap:	bitmap for tracking PBS triggers
>> + * @lut_sdam_base:	offset where LUT pattern begins in nvmem
>> + * @ppg_en:	Flag indicating whether PPG is enabled/used
> 
> Looking at its usage, it doesn't feel so much "is PPG enabled" as "does
> this instance use PPG", it's not a thing that can be enabled/disabled in
> runtime.
> 
> So "has_ppg" seems like a better name, or perhaps even "use_sdam" and
> avoid "PPG" completely and make it clearer to the average reader?
Sure, can update to be "use_sdam"


[...]
>> +static void lpg_sdam_configure_triggers(struct lpg_channel *chan)
>> +{
>> +	if (!chan->lpg->ppg_en)
>> +		return;
>> +
>> +	if (chan->enabled && chan->pattern_set) {
>> +		lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 1);
>> +		lpg_set_pbs_trigger(chan);
>> +		chan->pattern_set = false;
> 
> Forgive me if I'm confused, but doesn't this mean that if I configure a
> pattern and then set the brightness twice the pattern will be disabled
> again?
Yes, you are correct. With current code we continuously disable pattern.
I took a look at the code again and found that it makes more sense to
disable pattern in clear_pattern().


[...]
>> @@ -1363,7 +1618,9 @@ static int lpg_probe(struct platform_device *pdev)
>>  	for (i = 0; i < lpg->num_channels; i++)
>>  		lpg_apply_dtest(&lpg->channels[i]);
>>  
>> -	return lpg_add_pwm(lpg);
>> +	ret = lpg_add_pwm(lpg);
>> +
>> +	return ret;
> 
> I'm failing to see the usefulness of this change.
Sorry, looks like this was never reverted from an old change when I was debugging.
Will revert back to original for next version. 

Thanks,
Anjelique

