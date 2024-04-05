Return-Path: <linux-kernel+bounces-132649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E38997BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E871C2114D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9B146A81;
	Fri,  5 Apr 2024 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zuyj1HTx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64C14535C;
	Fri,  5 Apr 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305594; cv=none; b=ftbfQN2p6m5CYWmvrb9WZQXNf0AHJ6VdB5G937I7XSzo0LbLM2YFSwVTZJm65UfUKb3wOLjzX5WFtmIyIA3ozLMb75As1g6drbLILWddQnvu3LWRRJ6CTxPpWpjKvjoAGQsrDNjM6G2pcSZVq9nlrAq7Ht13fmqxoTyF5fBjS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305594; c=relaxed/simple;
	bh=j9RoPLZmCC7wWzTStv2sVugCxNGztVnkFeyD2s4KlwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u2I+4YxTTE04+yBo3OcbxTnxeXhiFRMFcpNCtt96F9UUH78Z5j2Q86osb7UzkEbygCo1V29TUgrLz2FDaxs3HOlGqzCjti9+ElveuTYS/am1DbTjdnzmmq6EQG6glS47d4W2wHkTAYYTAXLL7xQfz2xjKrUSSs/IYUvrPGdHcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zuyj1HTx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43556DRS003669;
	Fri, 5 Apr 2024 08:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MXiuHfSkLYp7Elwz53wcV8mv8XCf2+1rKM2cnUVWS7A=; b=Zu
	yj1HTxHxFVsRVMcbVV7dX+9MKG1UsDCvYC3tiNVrG9RcKd98f+lr7EEjdJnh5RCZ
	hUGy9lWV0frkj8KlJRmbJ+2lh2YBiBLp30Aufz48/wU3Y7I6olDCfZatl1HNbDUO
	37GvZ3VlIB4PkfvSnuYBhS+CI97BAyzLQ24Gs/rJWFpkKKZUgNJRlhOW8XGDEM3r
	quPHFpgKRNH58ZiI4GcJndrrQif4rfNcjAGs73EE7fvpC31GqMs3jpLSDqAm++Pc
	6PqecxiHMYlt4lqQrM3a3O9Bs/KO0AxLQnxCoklVbku1eHb0kpwmxpL0NpRCMweo
	Lvq3QIvRrtcgQVJXZuLw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5gqds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 08:26:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4358QMOe024730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 08:26:22 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 01:26:17 -0700
Message-ID: <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
Date: Fri, 5 Apr 2024 13:56:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/19] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-3-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-3-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DdnvdMB5zzqwN8pobNHKJNEHEaOs26ic
X-Proofpoint-GUID: DdnvdMB5zzqwN8pobNHKJNEHEaOs26ic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050061



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> To make it easier to understand the various clock requirements within
> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index ac7c83404c6e..cf91f50a33aa 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -23,6 +23,34 @@
>  
>  static bool legacy_binding;
>  
> +/**
> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
> + * @core: A pointer to the venus core resource
> + *
> + * The Venus block (depending on the generation) can be split into a couple
> + * of clock domains: one for main logic and one for each video core (0-2 instances).
> + *
> + * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
> + * domain, so this function is the only kind if clk_get necessary there.
> + *
> + * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
> + * statically defined a decoder and core1 an encoder, with both having
> + * their own clock domains.
> + *
> + * SDM845 features two video cores, each one of which may or may not be
> + * subdivided into two encoder/decoder threads.
> + *
> + * Other SoCs either feature a single video core (with its own clock domain)
> + * or one video core and one CVP (Computer Vision Processor) core. In both cases
> + * we treat it the same way (CVP only happens to live near-by Venus on the SoC).
> + *
> + * Due to unfortunate developments in the past, we need to support legacy
why unfortunate? please re-phrase this.
> + * bindings (MSM8996, SDM660, SDM845) that require specifying the clocks and
> + * power-domains associated with a video core domain in a bogus sub-node,
> + * which means that additional fluff is necessary..
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
>  static int venus_clks_get(struct venus_core *core)
>  {
>  	const struct venus_resources *res = core->res;
> 

Thanks,
Dikshita

