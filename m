Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8F77C092
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjHNTQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHNTQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:16:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4486AA8;
        Mon, 14 Aug 2023 12:16:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIoKLj004821;
        Mon, 14 Aug 2023 19:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ttNyqbFJz9aBBw1DYEEJ4T8HU+r0O/Q0SAe6cStAHAc=;
 b=Mv+JA4KGfoFSVXnahVzk9mIIMbmGkXxEGvfTmUyFgB3XPhm6PzoRbIUZmvO9PD3G/5sH
 WAY+kCBWYwYzxj4FQ1K9slcTRltOa3AMsMguvOhsOo+qZ23oIQSM613MghQMoysg2OV2
 fMXwBwyTO7S0LYTxnT3tyAChnb/WO87I53IvDaek7AQqtjECHFi+41fZ6QhQYXC/SgkG
 lrCZzOoKFLfO38+JU1JUqDBhn0RhEJwbYIHO87imh465kMa2bNKBox9BgGIvmECBRGgh
 gzy24m5QCyT0+YZ0sC4MBKiNsBMXMxIuuGVp2I1LUu6Qjkf0Kvfy3MxvGUthvRL+dX+i WQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se40rmkr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:16:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJFu1h006669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:15:56 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:15:52 -0700
Message-ID: <8d5b117e-4743-c006-7e7b-a15bd3866e6d@quicinc.com>
Date:   Tue, 15 Aug 2023 00:45:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/33] iris: vidc: add helper functions
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-11-git-send-email-quic_vgarodia@quicinc.com>
 <7a727add-6aa6-fe3d-b2bd-7e0bd2f93579@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <7a727add-6aa6-fe3d-b2bd-7e0bd2f93579@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mHSt4AP8k7IGPWxGT76IlqAZOrLgqUU5
X-Proofpoint-GUID: mHSt4AP8k7IGPWxGT76IlqAZOrLgqUU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=853 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:11 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> This implements common helper functions for v4l2 to vidc and
>> vice versa conversion for different enums.
>> Add helpers for state checks, buffer management, locks etc.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
> [...]
> 
>> +
>> +#define is_odd(val) ((val) % 2 == 1)
>> +#define in_range(val, min, max) (((min) <= (val)) && ((val) <= (max)))
>> +#define COUNT_BITS(a, out) {       \
> hweight.* functions?
> 
> [...]
> 
sure, will replace with hweight.
>> +
>> +const char *cap_name(enum msm_vidc_inst_capability_type cap_id)
>> +{
>> +	const char *name = "UNKNOWN CAP";
> Perhaps it'd be worth to include the unknown cap id here
> 
could you please elaborate more on this.
>> +
>> +	if (cap_id >= ARRAY_SIZE(cap_name_arr))
>> +		goto exit;
>> +
>> +	name = cap_name_arr[cap_id];
>> +
>> +exit:
>> +	return name;
>> +}
> [...]
> 
>> +
>> +const char *buf_name(enum msm_vidc_buffer_type type)
>> +{
>> +	const char *name = "UNKNOWN BUF";
> Similarly here
> 
could you please elaborate more on this.
>> +
>> +	if (type >= ARRAY_SIZE(buf_type_name_arr))
>> +		goto exit;
>> +
>> +	name = buf_type_name_arr[type];
>> +
>> +exit:
>> +	return name;
>> +}
> [...]
> 
>> +const char *v4l2_type_name(u32 port)
>> +{
>> +	switch (port) {
> switch-case seems a bit excessive here.
> 
>> +	case INPUT_MPLANE:      return "INPUT";
>> +	case OUTPUT_MPLANE:     return "OUTPUT";
>> +	}
>> +
>> +	return "UNKNOWN";
>> +}
that's right, will fix in next version
> [...]
> 
> There's some more stuff I'd comment on, but 4500 lines in a single patch
> is way too much to logically follow.
> 
> Couple more style suggestions:
> - use Reverse-Christmas-tree sorting for variable declarations
> - some oneliner functions could possibly become preprocessor macros
> - when printing giant debug messages, you may want to use loops
> - make sure your indentation is in order, 100 chars per line is
>   totally fine
> - generally inline magic hex values are discouraged, but if they're
>   necessary, the hex should be lowercase
Nice suggestions! will take care of these comments in next version.

Thanks,
Dikshita
> 
> Konrad
