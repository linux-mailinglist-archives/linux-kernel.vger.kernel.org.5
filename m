Return-Path: <linux-kernel+bounces-57815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3284DDB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E89B25CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E06E2D8;
	Thu,  8 Feb 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bLzj8ooH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787766D1BD;
	Thu,  8 Feb 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386520; cv=none; b=rmOY4CUTBPrf0guTAwT9gsUVu3ahRHHDRTCDm0PO7F5eu/o2fWXCGPjo6RspAifWWvV0+xDSuJWExHrdmxuh2t4N+8iaDdfttE3MXkr34UHbDNEGFHyEWJDgSceqU/UtGSEmvfz2fYoba/ua1ojXgaGpXvLNudmUDn951A1vDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386520; c=relaxed/simple;
	bh=ZjTYuZI27yktivY2o1E00i2URHt1xHbHgN6Q3LlWvUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL/25RjoxGqw+ITI2aZkPKLUCUUj8RceMUZPEAZgo71z7P/q0yGVACsnVrSUP8rHFr3W9uBKqa3qpCLvor2quPTv2QH+raT3pCEeVXMpS24nrBd8tz3dzdsJOlJ1t6/RgH88fe08p/fAsf4RT+4PmkNOkCGVHuaCS0785fX0eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bLzj8ooH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707386511;
	bh=ZjTYuZI27yktivY2o1E00i2URHt1xHbHgN6Q3LlWvUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLzj8ooHWv6M8Wo0jLN4HnS6vZrxTMuvLVSOVdDYjWuM/wDAXm6ZxcIOgdeKCBU9x
	 V8l6sJ37DgW/wfiecteAzhN5YxFX+vLozXOJHzrnzU0UpIjOG1e4TqABaeKFuQ4rL/
	 mqsUkesAckB5rqalYvcYW8UbiOMEXZWPcvGPLRjbHDsltlUJjOHBFzTCEDKsD30P4r
	 cXKXCDFen+ZEC4+fAQA4yKA+W8WuVhMU4NXls4O5Lyr7+LjKpNOoDQlVsdhdi2BX5g
	 hvG3iDAEVqohLtG/+0ioroGo1Az8wddNkqxIhgSGXu4qtyCRo3NQHu+HqiqidU3LD6
	 q8VMBfDldMvrQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9EDA237811CF;
	Thu,  8 Feb 2024 10:01:50 +0000 (UTC)
Date: Thu, 8 Feb 2024 11:01:49 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com, lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: Re: [RESEND PATCH v0 2/5] wave5: Support to prepend sps/pps to IDR
 frame.
Message-ID: <20240208100149.pet6em5tnunv2ome@basti-XPS-13-9310>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
 <20240131013046.15687-3-jackson.lee@chipsnmedia.com>
 <cdcf594ecaefaac748655bdcb7dcc1c4f9ad1a68.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdcf594ecaefaac748655bdcb7dcc1c4f9ad1a68.camel@ndufresne.ca>

Hey Jackson,

as with the previous review, the title needs to be adjusted 'wave5:' is
not enough.
Also 'Support to prepend sps/pps to IDR' sounds a bit weird and doesn't
quite match what you describe below.
How about:
'Support SPS/PPS generation for each IDR'

On 07.02.2024 13:00, Nicolas Dufresne wrote:
>Hi Jackson,
>
>Le mercredi 31 janvier 2024 à 10:30 +0900, jackson.lee a écrit :
>> Indicates whether to generate SPS and PPS at every IDR. Setting it to 0 disables generating SPS and PPS at every IDR.
>> Setting it to one enables generating SPS and PPS at every IDR.

My suggestion:

Provide a control to toggle (0 = off / 1 = on), whether the SPS and PPS
are generated for every IDR.

Greetings,
Sebastian

>>
>> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
>> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
>> ---
>>  drivers/media/platform/chips-media/wave5/wave5-hw.c      | 6 ++++--
>>  drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 7 +++++++
>>  drivers/media/platform/chips-media/wave5/wave5-vpuapi.h  | 1 +
>>  3 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>> index f1e022fb148e..8ad7f3a28ae1 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>> @@ -1602,11 +1602,13 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
>>  	if (inst->std == W_AVC_ENC)
>>  		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
>>  				((p_param->intra_period & 0x7ff) << 6) |
>> -				((p_param->avc_idr_period & 0x7ff) << 17));
>> +				((p_param->avc_idr_period & 0x7ff) << 17) |
>> +				(p_param->forced_idr_header_enable << 28));
>
>I can spot evident hard-coding of mask and bit shifts in here. In order to
>continuously improve this driver code, I would like to see this (and the
>following) magic number being defined with well named macros as a preparation
>patch to this feature change.
>
>regards,
>Nicolas
>
>>  	else if (inst->std == W_HEVC_ENC)
>>  		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
>>  			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
>> -				(p_param->intra_period << 16));
>> +			      (p_param->forced_idr_header_enable << 9) |
>> +			      (p_param->intra_period << 16));
>>
>>  	reg_val = (p_param->rdo_skip << 2) |
>>  		(p_param->lambda_scaling_enable << 3) |
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> index 0cb5bfb67258..761775216cd4 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> @@ -1125,6 +1125,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>>  	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
>>  		inst->enc_param.entropy_coding_mode = ctrl->val;
>>  		break;
>> +	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
>> +		inst->enc_param.forced_idr_header_enable = ctrl->val;
>> +		break;
>>  	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
>>  		break;
>>  	default:
>> @@ -1292,6 +1295,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
>>  		else
>>  			open_param->wave_param.intra_refresh_arg = num_ctu_row;
>>  	}
>> +	open_param->wave_param.forced_idr_header_enable = input.forced_idr_header_enable;
>>  }
>>
>>  static int initialize_sequence(struct vpu_instance *inst)
>> @@ -1775,6 +1779,9 @@ static int wave5_vpu_open_enc(struct file *filp)
>>  			  0, 1, 1, 0);
>>  	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>>  			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
>> +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>> +			  V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR,
>> +			  0, 1, 1, 0);
>>
>>  	if (v4l2_ctrl_hdl->error) {
>>  		ret = -ENODEV;
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> index 352f6e904e50..3ad6118550ac 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> @@ -566,6 +566,7 @@ struct enc_wave_param {
>>  	u32 lambda_scaling_enable: 1; /* enable lambda scaling using custom GOP */
>>  	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
>>  	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
>> +	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR frame */
>>  };
>>
>>  struct enc_open_param {
>
>

