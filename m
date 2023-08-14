Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA64677C06B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjHNTKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjHNTKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:10:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D6110;
        Mon, 14 Aug 2023 12:10:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIvffR009024;
        Mon, 14 Aug 2023 19:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QpwWy1wg9NaHl3YSiMV3O4VgDueItZcwUcMbJZIwmPk=;
 b=AWE+8yU3AWoM5J4Jm1lJBKNN3IPkqMlvdSmvMbI6bR4knaZaVZ0XNKnVlB/3T22vA3un
 o5P14Wk333ZpDZpMjJGSCBkp3d1vJGbrX9LXCfTi8jEBgRVfrGF8vGhskWOZ7zqq06a+
 0cyGqnCosMoiX+1/3YNDyBxPlL4ftQ3DGMurmm2tyTZsLRTluS18+Wq2a5bXy/aI4S3Z
 v8gF3p60DWju4sWPUdx8UDiQOql6TnkHlh4CiUgdAcFhZH2v/5/l1uxoKJBVmpi381Ht
 CcneI9V0RKTKj6Dv2G270S+LhWGsgITc3SFBulCaM2aGUNatZQQ9XFjhYrciJDPsadGU /g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3mt4kut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:10:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJAUBh019227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:10:30 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:10:26 -0700
Message-ID: <c1872458-33e7-74ed-dcdd-b55c77e942f6@quicinc.com>
Date:   Tue, 15 Aug 2023 00:40:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/33] iris: vidc: add helper functions for power
 management
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-14-git-send-email-quic_vgarodia@quicinc.com>
 <a8ebcacd-19c7-b5e7-f372-6abde311e17d@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <a8ebcacd-19c7-b5e7-f372-6abde311e17d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nlpeq_bm_ChddtJ52AqOEwMW0RPzl8my
X-Proofpoint-ORIG-GUID: nlpeq_bm_ChddtJ52AqOEwMW0RPzl8my
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:16 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> this implements functions for calculating current load of the
>> hardware. Depending on the count of instances and
>> resolutions it selects the best clock rate for the video
>> core. Also it scales clocks, power and enable/disable dcvs.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---[...]
> 
>> +
>> +/* TODO: Move to dtsi OR use source clock instead of branch clock.*/
>> +#define MSM_VIDC_CLOCK_SOURCE_SCALING_RATIO 3
> Seems unused in this patch.
Right, moved to the resource.c file where it is used.
> 
>> +
>> +enum vidc_bus_type {
>> +	PERF,
>> +	DDR,
>> +	LLCC,
>> +};
>> +
>> +/*
>> + * Minimum dimensions for which to calculate bandwidth.
>> + * This means that anything bandwidth(0, 0) ==
>> + * bandwidth(BASELINE_DIMENSIONS.width, BASELINE_DIMENSIONS.height)
>> + */
>> +static const struct {
>> +	int height, width;
>> +} BASELINE_DIMENSIONS = {
>> +	.width = 1280,
>> +	.height = 720,
>> +};
>> +
>> +/* converts Mbps to bps (the "b" part can be bits or bytes based on context) */
> if 'b', the multiplier must be 1024 or it makes no sense
>
we are calculating the value in decimal hence multiplication factor is 1000.

>> +#define kbps(__mbps) ((__mbps) * 1000)
>> +#define bps(__mbps) (kbps(__mbps) * 1000)
>> +
> [...]
> 
>> +void __dump(struct dump dump[], int len)
>> +{
>> +	int c = 0;
>> +
>> +	for (c = 0; c < len; ++c) {
>> +		char format_line[128] = "", formatted_line[128] = "";
> That's a lot of bytes on the stack..
> 
This code will be removed in next version as part of custom debug wrapper
removal.
>> +
>> +		if (dump[c].val == DUMP_HEADER_MAGIC) {
>> +			snprintf(formatted_line, sizeof(formatted_line), "%s\n",
>> +				 dump[c].key);
>> +		} else {
>> +			snprintf(format_line, sizeof(format_line),
>> +				 "    %-35s: %s\n", dump[c].key,
>> +					 dump[c].format);
>> +			snprintf(formatted_line, sizeof(formatted_line),
>> +				 format_line, dump[c].val);
>> +		}
>> +		d_vpr_b("%s", formatted_line);
>> +	}
>> +}
>> +
>> +u64 msm_vidc_max_freq(struct msm_vidc_inst *inst)
>> +{
>> +	struct msm_vidc_core *core;
>> +	struct frequency_table *freq_tbl;
>> +	u64 freq = 0;
>> +
>> +	core = inst->core;
>> +
>> +	if (!core->resource || !core->resource->freq_set.freq_tbl ||
>> +	    !core->resource->freq_set.count) {
>> +		i_vpr_e(inst, "%s: invalid frequency table\n", __func__);
>> +		return freq;
>> +	}
>> +	freq_tbl = core->resource->freq_set.freq_tbl;
> Do we need a separate freuqency table if we have OPP?
we are using freq table at multiple places to
- setting freq to turbo
- limiting the freq to NOM
- changing the frequency values based on DCVS
hence this table is need.

will explore more to see if it can be removed.
> [...]
> 
> 
>> +	if (inst->power.fw_cf) {
>> +		cf = inst->power.fw_cf;
>> +		frame_size = (msm_vidc_get_mbs_per_frame(inst) / (32 * 8) * 3) / 2;
> too magic!
> 
this is the standard calculation for calculating the frame size, will try
to simplify this in next version.

Thanks,
Dikshita
> Konrad
