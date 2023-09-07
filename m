Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3534C797D10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbjIGT4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbjIGT4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:56:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CB31BD1;
        Thu,  7 Sep 2023 12:56:11 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387J0LZs017267;
        Thu, 7 Sep 2023 19:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qdMo3SD+CUj18ffMSqOb+eFhA9+thykKFcC5u+IY98s=;
 b=nbNqkhKAzKLXV69LFF8e8popqbA7J3WcLrn+f9RxKfF9rgbB7BQesGf9+SNjvHIIvhcl
 zAzcjOabC3BoTUzxSWi+cJ4hELuCeh7BK0s77t1R1gxVb7uQ4lwtISCWOLKktoOoIFq1
 NPvmniOi0fa/u0y+mkOhFI5towetcwdpw+FInlxczLLYTf35ooYiF/ci2NCXwJT0Emfs
 FWFJrrrmRrhZ6ZnGXJai5NCs26ZnynpcZpePy5kFc8VZGX+d2LKxktjgPvsm1kkdhJnl
 O/QB4Co/bBZ7mods+IT8PkIhslAugF1KAhm6j9p2xwtwjeIRinReVw6pOGH/ED5QH7hO Pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syfj2gw3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 19:55:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387JtnAc010515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 19:55:49 GMT
Received: from [10.110.111.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 12:55:46 -0700
Message-ID: <a9aa7bd9-7d42-3897-443e-b3ef2d73d05c@quicinc.com>
Date:   Thu, 7 Sep 2023 12:55:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-7-quic_amelende@quicinc.com>
 <3b6f6285-ec3b-4e12-aa65-d5f61937de6f@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <3b6f6285-ec3b-4e12-aa65-d5f61937de6f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bRvwnAo920U0xej0R58pGF7PjzNCyiR2
X-Proofpoint-GUID: bRvwnAo920U0xej0R58pGF7PjzNCyiR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=955
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070176
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
> On 30.08.2023 20:05, Anjelique Melendez wrote:
>> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
>> configuration can be stored in a single SDAM module instead of LUT
>> peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
>> Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.
> I still fail to understand what benefit this brings.
> 
> Is this a "can be used", or "should be used", or maybe "must be used"?
> 
> Are there any distinct advantages to using one over the other?
> I see some limitations in the code below, but that's not being made
> obvious.
> 
> This all should be in the commit message, the current one includes
> a lot of cryptic names that mean nothing to most people.
> 
> [...]
This is a must be used if you would like to trigger patterns. Will update commit message to try and 
make that more clear for next patch.

>> @@ -775,7 +952,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>>  	unsigned int lo_idx;
>>  	unsigned int hi_idx;
>>  	unsigned int i;
>> -	bool ping_pong = true;
>> +	bool ping_pong = false;
> Why?
> 
> This change combined with assigning true below for LUT mode
> is a NOP

LUT devices support a "ping pong" setting that PPG devices do not but honestly looking back at this
I'm not quite sure why I decided to make the change like this :)

Will revert back to bool ping_pong = true and just wrap loop in an if (lpg->lut_base) { for...} else {ping_pong = false;}
i.e.

	if (lpg->lut_base) {
		for (i = 0; i < len / 2; i++) {
			brightness_a = pattern[i].brightness;
			brightness_b = pattern[len - i - 1].brightness;

			if (brightness_a != brightness_b) {
				ping_pong = false;
				break;
			}
  		}
  	} else
		ping_pong = false;

> 
>>  	int ret = -EINVAL;
>>  
>>  	/* Hardware only support oneshot or indefinite loops */
>> @@ -824,7 +1001,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>>  	 * used to stretch the first delay of the pattern and a "high pause"
>>  	 * the last one.
>>  	 *
>> -	 * In order to save space the pattern can be played in "ping pong"
>> +	 * In order to save space for the pattern can be played in "ping pong"
>>  	 * mode, in which the pattern is first played forward, then "high
>>  	 * pause" is applied, then the pattern is played backwards and finally
>>  	 * the "low pause" is applied.
>> @@ -837,16 +1014,22 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>>  	 * If the specified pattern is a palindrome the ping pong mode is
>>  	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
>>  	 * last in the programmed pattern) determines the "high pause".
>> +	 *
>> +	 * NVMEM devices supporting LUT do not support "low pause", "high pause"
>> +	 * or "ping pong"
>>  	 */
>>  
>>  	/* Detect palindromes and use "ping pong" to reduce LUT usage */
>> -	for (i = 0; i < len / 2; i++) {
>> -		brightness_a = pattern[i].brightness;
>> -		brightness_b = pattern[len - i - 1].brightness;
>> -
>> -		if (brightness_a != brightness_b) {
>> -			ping_pong = false;
>> -			break;
>> +	if (lpg->lut_base) {
>> +		ping_pong = true;
>> +		for (i = 0; i < len / 2; i++) {
>> +			brightness_a = pattern[i].brightness;
>> +			brightness_b = pattern[len - i - 1].brightness;
>> +
>> +			if (brightness_a != brightness_b) {
>> +				ping_pong = false;
>> +				break;
>> +			}
>>  		}
>>  	}
>>  
>> @@ -860,14 +1043,21 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>>  	 * Validate that all delta_t in the pattern are the same, with the
>>  	 * exception of the middle element in case of ping_pong.
>>  	 */
>> -	delta_t = pattern[1].delta_t;
>> -	for (i = 2; i < len; i++) {
>> +	if (lpg->lpg_chan_nvmem) {
>> +		i = 1;
>> +		delta_t = pattern[0].delta_t;
>> +	} else {
>> +		i = 2;
>> +		delta_t = pattern[1].delta_t;
>> +	}
> Why?
> 
> What's the rationale behind this change?
Patterns are required to have the same duration for each step of the pattern. Devices with LUT peripherals support low/high
pause which is when the first/last entry of the pattern can have a longer duration. This loop checks that the all of the
pattern durations are the same with the exception of the first and last entry for low/hi pause.

This change was made because devices that use single SDAM do not support low/high pause, so we must check every
single pattern duration. Instead of changing the loop arguments with an if statement I was thinking we could either:

a. keep the original loop arguments and when loop exits we can check first element for single SDAM devices

   delta_t = pattern[1].delta_t;
   for (i = 2; i < len; i++) {
	if (pattern[i].delta_t != delta_t) {
+ 		if (i != actual_len - 1 || lpg->lpg_chan_nvmem)
  			goto out_free_pattern;
  		}
  	}

+ if (lpg->lpg_chan_nvmem) {
+	if (delta_t != pattern[0].delta_t)
+		goto out_free_pattern
+ }


b. Change the loop argument to start with i=0 and for LUT device we could just skip checking first and last element duration
  ** We would end up checking if pattern[1].delta_t == pattern[1].delta_t inside the loop when i == 1

   delta_t = pattern[1].delta_t;
+  for (i = 0; i < len; i++) {
	if (pattern[i].delta_t != delta_t) {
+		if (lpg->lut_base && (i == 0 || i == actual_len - 1)
+			continue;
+               else
+			goto out_free_pattern;

  	}

Let me know if you would rather go with one of these options to make this change cleaner.

Thanks,
Anjelique

> 
>> +
>> +	for (; i < len; i++) {
>>  		if (pattern[i].delta_t != delta_t) {
>>  			/*
>>  			 * Allow last entry in the full or shortened pattern to
>>  			 * specify hi pause. Reject other variations.
>>  			 */
>> -			if (i != actual_len - 1)
>> +			if (i != actual_len - 1 || lpg->lpg_chan_nvmem)
>>  				goto out_free_pattern;
>>  		}
>>  	}

