Return-Path: <linux-kernel+bounces-57766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87D84DD2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34451F2681B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACFF6BFC8;
	Thu,  8 Feb 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0FF/uE1N"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF069300;
	Thu,  8 Feb 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385342; cv=none; b=g0Bop1VCIfzfFBYeQ6Pvb1AaqLD5bOCTzevfxAR0b0HCKBUJE7G15gGu4QKfDvi1WrLODK0fLFdHM9OCjf1K7tVn0NaspVxoByVLGTYAFTbTssRmt1Z/PdIXk5wR942AbD/JuUmu+jUEs1aYQZACVJslgNe4Ha52ArkRbzbe9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385342; c=relaxed/simple;
	bh=kEoPO4lzGFJXsKVlv3cGLfhAw7EqukJVsoGKDJfDJqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJbx/2Kvl2mYfMCeaMREYwDe9NiM0swenjqEv8aV8ilEg1WN/H8l6o4aZaG+sbuqulL4HoHRwj6UX5PU/29ztOL68+AexYR8HBirGnNRBRZa7vDVzBCGYgS928fZxRlBQiMV3qAcSzoG3pT27Uc3+07IwpIfOXGxk/amIJCmPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0FF/uE1N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707385339;
	bh=kEoPO4lzGFJXsKVlv3cGLfhAw7EqukJVsoGKDJfDJqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0FF/uE1NNmbAKwmLHTJl6bVHoWzBDcZEYLKe9ocgaIYsoCWfJ8K63SwnGl6Yg4s9g
	 1W55eL5oMuXmzEoiCX1Ov82dmGHRSFMscQGrLBMa8V2WaE+hvP8ulfk7ZWy38tqot+
	 1VJu+oMz5VcXVHJacisNbtah2XJWIEhzlfudYep/Y/qbimQes/UZA1LqgyxDMKrMXN
	 Wz77KdGzFVq+sJQrD58ndEW1Q2Xwj+hF57orSeccvMLmojUXHEuD7qrUuTxZbcs5SW
	 0mERyJa8OKLW6HE4TX4F1gMJzkIQ/ym0dW30/H3JwwuyFf9FxXQxpH6I4X+sKOG0/Z
	 pF8Vz4e91J+VA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9AD843780624;
	Thu,  8 Feb 2024 09:42:18 +0000 (UTC)
Date: Thu, 8 Feb 2024 10:42:17 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	nas.chung@chipsnmedia.com, lafley.kim@chipsnmedia.com,
	b-brnich@ti.com
Subject: Re: [RESEND PATCH v0 1/5] wave5 : Support yuv422 input format for
 encoder.
Message-ID: <20240208094217.ipkbk5ixsvavnf26@basti-XPS-13-9310>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
 <20240131013046.15687-2-jackson.lee@chipsnmedia.com>
 <baa85477b241880e1cf96efd7037fc1b2423fab5.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baa85477b241880e1cf96efd7037fc1b2423fab5.camel@ndufresne.ca>

Hey Jackson,

a few additional comments ...

Please extend the patch title a bit, the title has to clearly indicate
where the driver can be found, so the correct title is:

media: chips-media: wave5: Support yuv422 input format for encoder.

and even better might be:

media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder 

Notice that you do not need punctuation and no space before the ':'.

On 07.02.2024 12:55, Nicolas Dufresne wrote:
>Hi Jackson,
>
>Le mercredi 31 janvier 2024 à 10:30 +0900, jackson.lee a écrit :
>> Encoder supports the following formats.
>> YUV422P, NV16, NV61, NV16M, NV61M

I would slightly reword this, the way it is written now is a bit
confusing.
First of all, when I look into the encoder, I can see support for the
following formats:
V4L2_PIX_FMT_YUV420
V4L2_PIX_FMT_NV12
V4L2_PIX_FMT_NV21
V4L2_PIX_FMT_YUV420M
V4L2_PIX_FMT_NV12M
V4L2_PIX_FMT_NV21M
V4L2_PIX_FMT_YUV422P
V4L2_PIX_FMT_NV16
V4L2_PIX_FMT_NV61
V4L2_PIX_FMT_NV16M
V4L2_PIX_FMT_NV61M

which is clearly more than would you provide, so your patch adds support
for a couple of new formats but the encoder supports more formats.

Secondly, the commit message should shortly explain what happens in the
patch and the reason for doing it. Stating what the encoder supports
doesn't explain both of these things.

My suggestion for the commit message would be something like:

Add support for the YUV422P, NV16, NV61, NV16M & NV61M raw pixel-formats
to the Wave5 encoder. All these formats have a chroma subsampling ratio
of 4:2:0 and therefore require a new image size calculation as the
driver previously only handled a ratio of 4:2:0.

And when you switch to v4l2_fill_pixfmt_mp please note that in the
commit message as well.

more below ..

>>
>> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
>> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
>> ---
>>  .../chips-media/wave5/wave5-vpu-enc.c         | 79 ++++++++++++++++++-
>>  1 file changed, 76 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> index f29cfa3af94a..0cb5bfb67258 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> @@ -70,6 +70,41 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
>>  			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>>  			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>>  		},
>> +		{
>> +			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422P,
>> +			.max_width = W5_MAX_ENC_PIC_WIDTH,
>> +			.min_width = W5_MIN_ENC_PIC_WIDTH,
>> +			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>> +			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>> +		},
>
>During upstreaming, we discussed the lack of usage of v4l2-common in this driver
>and agreed that future updates such as this one should first port the driver to
>use the common helpers instead.
>
>This implies dropping this custom made structure in favour of
>v4l2_frmsize_stepwise structure. Unlike yours, you can encoded the needed
>padding, allowing to encode this in one place instead of spreading it across
>numerous formulas in the code.
>
>With this information, you will be able to use:
>
>  v4l2_apply_frmsize_constraints()
>  v4l2_fill_pixfmt_mp()
>
>To adjust your dimensions to padded dimensions and compute your bytesperline
>(stride) and sizeimage. You can of course increase the size image after this
>call. You can have a look at rkvdec driver as an example.
>
>Please port existing set of pixel formats support, and then add the new pixel
>formats. This should remove about 3/4 of this patch and remove that huge risk of
>miss-computing a size.

Please have a look at:
https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/rkvdec/rkvdec.c#L257

There you see a nice example of how that can look.

>
>> +		{
>> +			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16,
>> +			.max_width = W5_MAX_ENC_PIC_WIDTH,
>> +			.min_width = W5_MIN_ENC_PIC_WIDTH,
>> +			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>> +			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>> +		},
>> +		{
>> +			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61,
>> +			.max_width = W5_MAX_ENC_PIC_WIDTH,
>> +			.min_width = W5_MIN_ENC_PIC_WIDTH,
>> +			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>> +			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>> +		},
>> +		{
>> +			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16M,
>> +			.max_width = W5_MAX_ENC_PIC_WIDTH,
>> +			.min_width = W5_MIN_ENC_PIC_WIDTH,
>> +			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>> +			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>> +		},
>> +		{
>> +			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61M,
>> +			.max_width = W5_MAX_ENC_PIC_WIDTH,
>> +			.min_width = W5_MIN_ENC_PIC_WIDTH,
>> +			.max_height = W5_MAX_ENC_PIC_HEIGHT,
>> +			.min_height = W5_MIN_ENC_PIC_HEIGHT,
>> +		},
>>  	}
>>  };
>>
>> @@ -136,6 +171,23 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
>>  		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
>>  		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
>>  		break;
>> +	case V4L2_PIX_FMT_YUV422P:
>> +	case V4L2_PIX_FMT_NV16:
>> +	case V4L2_PIX_FMT_NV61:
>> +		pix_mp->width = width;
>> +		pix_mp->height = height;
>> +		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>> +		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 2;
>> +		break;
>> +	case V4L2_PIX_FMT_NV16M:
>> +	case V4L2_PIX_FMT_NV61M:
>> +		pix_mp->width = width;
>> +		pix_mp->height = height;
>> +		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
>> +		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
>> +		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
>> +		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height;
>> +		break;
>>  	default:
>>  		pix_mp->width = width;
>>  		pix_mp->height = height;
>> @@ -155,11 +207,19 @@ static int start_encode(struct vpu_instance *inst, u32 *fail_res)
>>  	struct enc_param pic_param;
>>  	u32 stride = ALIGN(inst->dst_fmt.width, 32);
>>  	u32 luma_size = (stride * inst->dst_fmt.height);
>> -	u32 chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
>> +	u32 chroma_size;
>>
>>  	memset(&pic_param, 0, sizeof(struct enc_param));
>>  	memset(&frame_buf, 0, sizeof(struct frame_buffer));
>>
>> +	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420 ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV420M)
>> +		chroma_size = ((stride / 2) * (inst->dst_fmt.height / 2));
>> +	else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P)
>> +		chroma_size = ((stride) * (inst->dst_fmt.height / 2));
>> +	else
>> +		chroma_size = 0;

Just making sure, with the previous calculation the chroma size was
unable to ever be 0 and here you say that:
V4L2_PIX_FMT_NV12
V4L2_PIX_FMT_NV21
V4L2_PIX_FMT_NV12M
V4L2_PIX_FMT_NV21M
V4L2_PIX_FMT_NV16
V4L2_PIX_FMT_NV61
V4L2_PIX_FMT_NV16M
V4L2_PIX_FMT_NV61M

All have a chroma size of 0, that seems odd to me as these formats have
a chroma part. Maybe I am misunderstanding something, please provide a
little explanation as a comment on top of that block.

Greetings,
Sebastian

>> +
>>  	dst_buf = v4l2_m2m_next_dst_buf(m2m_ctx);
>>  	if (!dst_buf) {
>>  		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__);
>> @@ -550,11 +610,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
>>  	}
>>
>>  	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12 ||
>> -	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M) {
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV12M ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M) {
>>  		inst->cbcr_interleave = true;
>>  		inst->nv21 = false;
>>  	} else if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21 ||
>> -		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M) {
>> +		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV21M ||
>> +		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
>> +		   inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M) {
>>  		inst->cbcr_interleave = true;
>>  		inst->nv21 = true;
>>  	} else {
>> @@ -1132,6 +1196,15 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
>>  	u32 num_ctu_row = ALIGN(inst->dst_fmt.height, 64) / 64;
>>  	u32 num_mb_row = ALIGN(inst->dst_fmt.height, 16) / 16;
>>
>> +	if (inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16 ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61 ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_YUV422P ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV16M ||
>> +	    inst->src_fmt.pixelformat == V4L2_PIX_FMT_NV61M)
>> +		open_param->src_format = FORMAT_422;
>> +	else
>> +		open_param->src_format = FORMAT_420;
>> +
>>  	open_param->wave_param.gop_preset_idx = PRESET_IDX_IPP_SINGLE;
>>  	open_param->wave_param.hvs_qp_scale = 2;
>>  	open_param->wave_param.hvs_max_delta_qp = 10;
>
>

