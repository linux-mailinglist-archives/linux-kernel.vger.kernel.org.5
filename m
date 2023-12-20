Return-Path: <linux-kernel+bounces-6530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449A819A04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078FDB2549A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FB179BF;
	Wed, 20 Dec 2023 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BelHfaLP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B11EA80;
	Wed, 20 Dec 2023 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6QAFS004551;
	Wed, 20 Dec 2023 08:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dnaPT7DOo6d+JeXyybt7mk+8LQLkw8QlJ28qRK9Y4xc=; b=Be
	lHfaLPCIVVLUr1/7z7f+PAkJm2qtZJIL04Qo2/YipXsGXE4huNnOJCIlbUIcX5Q2
	489+eh5GAbDUK2bAt/mMtdmqOBwKCNwbU7DcYqPvxwFRSfsNk1jF/5iiKb2O/yas
	rTY1bk018lbfyOYLl9MB2rFJY1As+0XVpat0ymT9meFGbxxxXB+GKdVe8Vjm9WOk
	PW4t21Fp717gHzIHlFGk5rN9VIN68suaSPLKLMP/JT39AP2UFn7B0vXlkN2hijM3
	JHLFSZfFFgK25IjVBpYd2PnSHhsugK81/TWE5w9Yf5zd4qUg3+Bji+Rqs20a9HmF
	7i/5JCyKo9uucOK5+K2Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tnw09hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:04:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK84j7Z026686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:04:45 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:04:41 -0800
Message-ID: <5c3c686a-1500-7261-b112-1ea94d9e346e@quicinc.com>
Date: Wed, 20 Dec 2023 13:34:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/34] media: iris: initialize power resources
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-8-git-send-email-quic_dikshita@quicinc.com>
 <6c2e7cac-6f3d-42f0-84de-72a14e8f9ef5@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <6c2e7cac-6f3d-42f0-84de-72a14e8f9ef5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xH8GPnrIV1iQkUCphvrS0As8fS7J4p90
X-Proofpoint-ORIG-GUID: xH8GPnrIV1iQkUCphvrS0As8fS7J4p90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200055



On 12/18/2023 8:39 PM, Konrad Dybcio wrote:
> On 18.12.2023 12:32, Dikshita Agarwal wrote:
>> Add support for initializing Iris "resources", which are clocks,
>> interconnects, power domains, reset clocks, and clock frequencies
>> used for Iris hardware.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> [...]
> 
>> +	ret = init_resources(core);
>> +	if (ret) {
>> +		dev_err_probe(core->dev, ret,
>> +			      "%s: init resource failed with %d\n", __func__, ret);
>> +		return ret;
> You're supposed to return dev_err_probe, it propagates the errors
> this way
> 
Sure, fix this.
> Also, I think __func__ is excessive, throughout the code. You can
> very quickly grep for the error messages, which are quite unique.
> 
Ok, will remove __func__
> [...]
> 
>> +
>> +static const struct bus_info plat_bus_table[] = {
>> +	{ NULL, "iris-cnoc", 1000, 1000     },
>> +	{ NULL, "iris-ddr",  1000, 15000000 },
>> +};
>> +
>> +static const char * const plat_pd_table[] = { "iris-ctl", "vcodec", NULL };
>> +#define PD_COUNT 2
>> +
>> +static const char * const plat_opp_pd_table[] = { "mxc", "mmcx", NULL };
>> +#define OPP_PD_COUNT 2
>> +
>> +static const struct clock_info plat_clk_table[] = {
>> +	{ NULL, "gcc_video_axi0", GCC_VIDEO_AXI0_CLK, 0, 0 },
>> +	{ NULL, "core_clk",       VIDEO_CC_MVS0C_CLK, 0, 0 },
>> +	{ NULL, "vcodec_core",    VIDEO_CC_MVS0_CLK,  1, 0 },
>> +};
>> +
>> +static const char * const plat_clk_reset_table[] = { "video_axi_reset", NULL };
>> +#define RESET_COUNT 1
> Are you sure this won't change between platforms?
> [...]
> 
yes, these will change, but since at this point in the patches, I have not
introduced platform specific file, added these tables here.
I am moving these to platform specific file when I introduce that in
patch-13 [1].

[1]
https://patchwork.kernel.org/project/linux-media/patch/1702899149-21321-14-git-send-email-quic_dikshita@quicinc.com/
>> +static int init_bus(struct iris_core *core)
>> +{
>> +	struct bus_info *binfo = NULL;
>> +	u32 i = 0;
> no need to initialize
> 
Sure, will fix.
> [...]
> 
>> +static int init_clocks(struct iris_core *core)
>> +{
>> +	struct clock_info *cinfo = NULL;
>> +	u32 i;
>> +
>> +	core->clk_count = ARRAY_SIZE(plat_clk_table);
>> +	core->clock_tbl = devm_kzalloc(core->dev,
>> +				       sizeof(struct clock_info) * core->clk_count,
>> +				       GFP_KERNEL);
>> +	if (!core->clock_tbl)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < core->clk_count; i++) {
>> +		cinfo = &core->clock_tbl[i];
>> +		cinfo->name = plat_clk_table[i].name;
>> +		cinfo->clk_id = plat_clk_table[i].clk_id;
>> +		cinfo->has_scaling = plat_clk_table[i].has_scaling;
>> +		cinfo->clk = devm_clk_get(core->dev, cinfo->name);
>> +		if (IS_ERR(cinfo->clk)) {
>> +			dev_err(core->dev,
>> +				"%s: failed to get clock: %s\n", __func__, cinfo->name);
>> +			return PTR_ERR(cinfo->clk);
>> +		}
>> +	}
> Are you not going to use OPP for scaling the main RPMhPD with the core
> clock?
> 
We are using OPP for scaling the vcodec clk.
Could you please elaborate you query here, may be I didn't understand fully.
>> +
>> +	return 0;
>> +}
>> +
>> +static int init_reset_clocks(struct iris_core *core)
> init_resets
> 
> 'reset clocks' is an old downstream concept
> 
Sure, I can rename it.
>> +{
>> +	struct reset_info *rinfo = NULL;
>> +	u32 i = 0;
> unnecessary initializations
> 
Sure, will fix.
> [...]
> 
>> +
>> +int init_resources(struct iris_core *core)
>> +{
>> +	int ret;
>> +
>> +	ret = init_bus(core);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = init_power_domains(core);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = init_clocks(core);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = init_reset_clocks(core);
>> +
>> +	return ret;
> return init_reset_clocks(core);
> 
>> +}
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/resources.h b/drivers/media/platform/qcom/vcodec/iris/resources.h
>> new file mode 100644
>> index 0000000..d21bcc7e
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/iris/resources.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _RESOURCES_H_
>> +#define _RESOURCES_H_
>> +
>> +struct bus_info {
>> +	struct icc_path		*icc;
>> +	const char		*name;
>> +	u32			bw_min_kbps;
>> +	u32			bw_max_kbps;
> u64?
> 
Will check and do the needful.
>> +};
>> +
>> +struct power_domain_info {
>> +	struct device	*genpd_dev;
>> +	const char	*name;
>> +};
>> +
>> +struct clock_info {
>> +	struct clk	*clk;
>> +	const char	*name;
> I'm not sure why you need it
> 
>> +	u32		clk_id;
> Or this
> 
>> +	bool		has_scaling;
> Or this
> 
> you could probably do something like this:
> 
> struct big_iris_struct {
> 	[...]
> 	struct clk *core_clk;
> 	struct clk *memory_clk;
> 	struct clk *some_important_scaled_clock;
> 	struct clk_bulk_data less_important_nonscaling_clocks[X]
> }
> 
> and then make use of all of the great common upstream APIs to manage
> them!
> 
Will explore this and get back.
>> +	u64		prev;
>> +};
>> +
>> +struct reset_info {
>> +	struct reset_control	*rst;
>> +	const char		*name;
> this seems a bit excessive as well
> 
> Konrad

