Return-Path: <linux-kernel+bounces-47483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB2844E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239341C2A877
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720003984D;
	Thu,  1 Feb 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NdtyHUsC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B4364D5;
	Thu,  1 Feb 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749927; cv=none; b=VyAexIbFlr6yRQgW7HjWHzm5/vYvkdxPCu4BUeHYIhhUyFLZiJQvF8bHWIFl/djlZvsZhlnT3XEb6XBXsr+ggSmjHeL2Ub5c/Z8r0Rnu3Qz6EPW+wrR6wCtCkz5N9NSQiWUNPycS8fJ+5NR1mNPWUaLK+voa9dyRu01v7ZUFRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749927; c=relaxed/simple;
	bh=iRtkz5JOM/9zIVU6PdMRGt56F+wCIMxLlQRrfXNmclo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DEYrEyx8Nl3p9+tWTtHFUTwhNjcGZ0XleDC8lqPpfTJkQOWL8cjfkyYm2WeK0yoWAumBF3O/hSaooFuU+20hFS3ptqlf2FmhI91HAhxq/vbQBO+3xGKXW5kvMpXzM+9TFXuQFh4dXtnJ97132uWMjLsiejoD7FK7yYyoc2g7udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NdtyHUsC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VMGPQc000542;
	Thu, 1 Feb 2024 01:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pPYhNANVYBPQXPyw1Sr3f+BXA8fnFdEaiI27E3Bi4to=; b=Nd
	tyHUsCp57FbKABJiXyFdHicvH1HMqkZBbOSLRzd4NtQdt79QmwicxjjTwnc4BoVi
	kQOx4noh4XGXJ0qlCapKfKs+VOcD1Ao69UUeQSWvwmDc9H/SYWOXEc4Oykej5LJ2
	mfe2h3eizjWS9NXieUg77PsCke7cStbFiNZ3gQFzeE8ag+aWMlLUHpf6iPtrGgrr
	1TAuz0iveQpU+wTlZ4NS7LsncrhvWLgjilHvivpMN4hykB+sBdYOiL+tMbsU2mst
	Z3yT8CrnJvKcYRSBTtEncxQX8R2je9WLGGEjNCcbDWYdzVF84eEMIk2jsqPnkrIy
	Zlx6Sn5Kdn/2EurKfGkw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vygp7jpk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 01:11:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4111BhXt002843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 01:11:43 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 17:11:43 -0800
Message-ID: <45ddbe67-2803-1a33-ceb7-3411229a59f2@quicinc.com>
Date: Wed, 31 Jan 2024 17:11:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dpu: fix the programming of
 INTF_CFG2_DATA_HCTL_EN
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        "Sean
 Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen
 Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <quic_jesszhan@quicinc.com>, <quic_parellan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240201004737.2478-1-quic_abhinavk@quicinc.com>
 <CAA8EJpqG8C=ydpE_w7mWN-PJoAcOyZjQ5J1e7QoVY=MBUkWMxQ@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpqG8C=ydpE_w7mWN-PJoAcOyZjQ5J1e7QoVY=MBUkWMxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -HZs9R7-nRBCMFg_gN3ZoI6QsinADB9s
X-Proofpoint-GUID: -HZs9R7-nRBCMFg_gN3ZoI6QsinADB9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=995 lowpriorityscore=0 clxscore=1015 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2402010007



On 1/31/2024 5:05 PM, Dmitry Baryshkov wrote:
> On Thu, 1 Feb 2024 at 02:48, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> Currently INTF_CFG2_DATA_HCTL_EN is coupled with the enablement
>> of widebus but this is incorrect because we should be enabling
>> this bit independent of widebus except for cases where compression
>> is enabled in one pixel per clock mode.
>>
>> Fix this by making the condition checks more explicit and enabling
>> INTF_CFG2_DATA_HCTL_EN for all other cases when supported by DPU.
>>
>> Fixes: 3309a7563971 ("drm/msm/dpu: revise timing engine programming to support widebus feature")
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Thank you!
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> For the reference: although it is marked as a fix, I'd prefer if this
> patch undergoes a full cycle through msm-next rather than
> fast-tracking through msm-fixes. This would allow us to catch possible
> issues. WDYT?
> 

Yes, I dont plan to take this in -fixes.

Even though this was tested with sc7280, sm8550 before posting, I would 
like to postpone it for a major release as no use-case other than YUV420 
is broken without this.

This will be taken as part of CDM over DP series as we will backout the 
other change: https://patchwork.freedesktop.org/patch/575963/

>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  7 +++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h       |  7 +++++++
>>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  1 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 15 +++++++++------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       |  1 +
>>   5 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 83380bc92a00..467f874979d5 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -230,6 +230,13 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>>          return dpu_enc->wide_bus_en;
>>   }
>>
>> +bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc)
>> +{
>> +       const struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>> +
>> +       return dpu_enc->dsc ? true : false;
>> +}
>> +
>>   int dpu_encoder_get_crc_values_cnt(const struct drm_encoder *drm_enc)
>>   {
>>          struct dpu_encoder_virt *dpu_enc;
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> index 4c05fd5e9ed1..fe6b1d312a74 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> @@ -158,6 +158,13 @@ int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
>>
>>   bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc);
>>
>> +/**
>> + * dpu_encoder_is_dsc_enabled - indicate whether dsc is enabled
>> + *                             for the encoder.
>> + * @drm_enc:    Pointer to previously created drm encoder structure
>> + */
>> +bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc);
>> +
>>   /**
>>    * dpu_encoder_get_crc_values_cnt - get number of physical encoders contained
>>    *     in virtual encoder that can collect CRC values
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> index d0f56c5c4cce..f562beb6f797 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> @@ -102,6 +102,7 @@ static void drm_mode_to_intf_timing_params(
>>          }
>>
>>          timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
>> +       timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
>>
>>          /*
>>           * for DP, divide the horizonal parameters by 2 when
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>> index 6bba531d6dc4..965692ef7892 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>> @@ -163,13 +163,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>>          hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>>          display_hctl = (hsync_end_x << 16) | hsync_start_x;
>>
>> -       /*
>> -        * DATA_HCTL_EN controls data timing which can be different from
>> -        * video timing. It is recommended to enable it for all cases, except
>> -        * if compression is enabled in 1 pixel per clock mode
>> -        */
>>          if (p->wide_bus_en)
>> -               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN;
>> +               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>>
>>          data_width = p->width;
>>
>> @@ -229,6 +224,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>>          DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
>>          DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
>>          if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
>> +               /*
>> +                * DATA_HCTL_EN controls data timing which can be different from
>> +                * video timing. It is recommended to enable it for all cases, except
>> +                * if compression is enabled in 1 pixel per clock mode
>> +                */
>> +               if (!(p->compression_en && !p->wide_bus_en))
>> +                       intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
>> +
>>                  DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
>>                  DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
>>                  DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>> index 0bd57a32144a..6f4c87244f94 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>> @@ -33,6 +33,7 @@ struct dpu_hw_intf_timing_params {
>>          u32 hsync_skew;
>>
>>          bool wide_bus_en;
>> +       bool compression_en;
>>   };
>>
>>   struct dpu_hw_intf_prog_fetch {
>> --
>> 2.40.1
>>
> 
> 

