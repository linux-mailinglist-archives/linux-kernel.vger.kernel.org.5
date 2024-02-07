Return-Path: <linux-kernel+bounces-56851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC2E84D03C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74432872E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE65082D88;
	Wed,  7 Feb 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="x1bSm2NB"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3B7FBD2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328533; cv=none; b=Zf8tdcy23jT+W6IpC1Xvkk33eJ8fkBoesggGjzSWJP0IY/ci1zSFPbkFyUJ29sgkFrotxzAYrxuTFdNtmhR7ZBR0Ga7HoMyPjUgaxZpQqyqBEArMKhR2dYPoimlEw3NcGiu+e5jGXBkWY9h6TFp/tiJlTGsXVrC/7Nimnmmajwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328533; c=relaxed/simple;
	bh=PVNQ9lrRXOnUdGtFtfU2OixZ+ynURyncL9U0HlnF7Uo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnQGIChHpZWbgrBlz7ppJfSe6vKjlLF0U2MC8ZuBs34p4vsJMRWpyazOA8ueEByACD5EpMDnqEm+u8V5v0nTzgLn/mzuLKfl910w90SrPKZ4LEDWmt2hZ998dsh0laAuQPjfvvCTVIXpv0glu5TaPzGH+HKJLlwLhCLkgAxnM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=x1bSm2NB; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso300784241.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707328531; x=1707933331; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AaTfUXqJMnus5HhQJpbMfqNcu6i2urdtegdYNHUHp14=;
        b=x1bSm2NBAIBRIyOQW0k5X1f4/98Gcf+bUSaIN11lX3b6AxtFmaZlCcu0H7v2N4cope
         hMWehkyU3dFcRN+NyS73999CC11Q1NZcxqLHsZ4oxObIkDB4SLGTDLQGTtDBiWM4ab0H
         qVIvCLsXVHJ90x9zGL9+d/9Y+Mo0BGDuDLvVwnG3wNDwMFU1pydpSnyYTm3uw44+0ntc
         5FVCKDbU4WhUydYlhTFXhTrb90b2kwBTIR5GcpY1vdKcXo9sh3mg4tIBJfM4eYAv3pUP
         eSe/OfA1h+GhQlKTgE28gww3/OhuTwxWQLZJe1ikJ2vLcbOqypgnLY384ihLaRm7DePz
         rtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328531; x=1707933331;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaTfUXqJMnus5HhQJpbMfqNcu6i2urdtegdYNHUHp14=;
        b=T4Z6ZKQMjs4WwwwD3XhNYYL/484winuIa4S9Ahtd0UgYp6OI7trQ/BrI2LPJXnfnZp
         WNDDFwbAc0ToVQ8F+6nu0jgK4lVpThiCI4KxbOtFESRoa0X8BmkOP9Ho02vmWXc1j/Kb
         5HXdBwdQQveVbfA5Jt2AoNk4qZY/hmuJEF0TmK9JkLtCcCL4/vzgEJZ2L/CLOBX8v2OB
         Gj76HGXkao/Y4osCAqF0O3aLxWFxtcbkNiW9ib25s3Qyyb964Y9sMkZfjxb/3IGVY+9A
         0tjNp1Ar5//EmYiMqcg6MrlHMa2//aY6VIrPETMgOSm/oTRi6158WTZwYZp+FGcQz0nx
         ESog==
X-Gm-Message-State: AOJu0YzEfQnyBXTJf01hAGbVuxTv9rfdVP8vTwSxm5QKltk+nlQa8ZGt
	LlkrvxIe550pY0b+7mpv8HTJuYzuRG4gBOZQhtn5Y6yrPSIb5wV0z4ShWc2xwSs=
X-Google-Smtp-Source: AGHT+IGnfAtMOsdhiib/U3MKWXDTsAiVeW67+8y5X5O2rcRyTWlXolBO5cIwQWnXtlfqUocVYzsuUg==
X-Received: by 2002:a05:6122:280f:b0:4c0:2767:b778 with SMTP id en15-20020a056122280f00b004c02767b778mr3310174vkb.16.1707328530633;
        Wed, 07 Feb 2024 09:55:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTTOhy5MBG7gPD/cq2qmjUJGwKSNn1m5m6rK09MO6VweDrOHpUF8znKLU+YJ2TE8whOk0zGjOL/dTPdEm9yXr30Rtp8l3NP6m/L1jIapxnWoXcHr6dSak78TFulBtikddk2T5L4CMjTF0gkHiqdXHho/C2Gww4P4uy0DjxK1W5EaCKIG1nccc+au63Bxsditnl1DFWG66xD/qTo3WqFcvz9YAKifM+uekO
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id ow8-20020a0562143f8800b0068c87aa8c06sm797920qvb.19.2024.02.07.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:55:30 -0800 (PST)
Message-ID: <baa85477b241880e1cf96efd7037fc1b2423fab5.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 1/5] wave5 : Support yuv422 input format for
 encoder.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nas.chung@chipsnmedia.com
Cc: lafley.kim@chipsnmedia.com, b-brnich@ti.com
Date: Wed, 07 Feb 2024 12:55:29 -0500
In-Reply-To: <20240131013046.15687-2-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-2-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jackson,

Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.lee a =C3=A9crit=C2=
=A0:
> Encoder supports the following formats.
> YUV422P, NV16, NV61, NV16M, NV61M
>=20
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../chips-media/wave5/wave5-vpu-enc.c         | 79 ++++++++++++++++++-
>  1 file changed, 76 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f29cfa3af94a..0cb5bfb67258 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -70,6 +70,41 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES]=
[MAX_FMTS] =3D {
>  			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
>  			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422P,
> +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		},

During upstreaming, we discussed the lack of usage of v4l2-common in this d=
river
and agreed that future updates such as this one should first port the drive=
r to
use the common helpers instead.

This implies dropping this custom made structure in favour of
v4l2_frmsize_stepwise structure. Unlike yours, you can encoded the needed
padding, allowing to encode this in one place instead of spreading it acros=
s
numerous formulas in the code.

With this information, you will be able to use:

  v4l2_apply_frmsize_constraints()
  v4l2_fill_pixfmt_mp()

To adjust your dimensions to padded dimensions and compute your bytesperlin=
e
(stride) and sizeimage. You can of course increase the size image after thi=
s
call. You can have a look at rkvdec driver as an example.

Please port existing set of pixel formats support, and then add the new pix=
el
formats. This should remove about 3/4 of this patch and remove that huge ri=
sk of
miss-computing a size.

> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16,
> +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61,
> +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16M,
> +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61M,
> +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		},
>  	}
>  };
> =20
> @@ -136,6 +171,23 @@ static void wave5_update_pix_fmt(struct v4l2_pix_for=
mat_mplane *pix_mp, unsigned
>  		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
>  		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 2;
>  		break;
> +	case V4L2_PIX_FMT_YUV422P:
> +	case V4L2_PIX_FMT_NV16:
> +	case V4L2_PIX_FMT_NV61:
> +		pix_mp->width =3D width;
> +		pix_mp->height =3D height;
> +		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> +		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height * 2;
> +		break;
> +	case V4L2_PIX_FMT_NV16M:
> +	case V4L2_PIX_FMT_NV61M:
> +		pix_mp->width =3D width;
> +		pix_mp->height =3D height;
> +		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> +		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> +		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> +		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height;
> +		break;
>  	default:
>  		pix_mp->width =3D width;
>  		pix_mp->height =3D height;
> @@ -155,11 +207,19 @@ static int start_encode(struct vpu_instance *inst, =
u32 *fail_res)
>  	struct enc_param pic_param;
>  	u32 stride =3D ALIGN(inst->dst_fmt.width, 32);
>  	u32 luma_size =3D (stride * inst->dst_fmt.height);
> -	u32 chroma_size =3D ((stride / 2) * (inst->dst_fmt.height / 2));
> +	u32 chroma_size;
> =20
>  	memset(&pic_param, 0, sizeof(struct enc_param));
>  	memset(&frame_buf, 0, sizeof(struct frame_buffer));
> =20
> +	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV420 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV420M)
> +		chroma_size =3D ((stride / 2) * (inst->dst_fmt.height / 2));
> +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422P)
> +		chroma_size =3D ((stride) * (inst->dst_fmt.height / 2));
> +	else
> +		chroma_size =3D 0;
> +
>  	dst_buf =3D v4l2_m2m_next_dst_buf(m2m_ctx);
>  	if (!dst_buf) {
>  		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__)=
;
> @@ -550,11 +610,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *fil=
e, void *fh, struct v4l2_form
>  	}
> =20
>  	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12 ||
> -	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M) {
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16M) {
>  		inst->cbcr_interleave =3D true;
>  		inst->nv21 =3D false;
>  	} else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21 ||
> -		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M) {
> +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M ||
> +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61 ||
> +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61M) {
>  		inst->cbcr_interleave =3D true;
>  		inst->nv21 =3D true;
>  	} else {
> @@ -1132,6 +1196,15 @@ static void wave5_set_enc_openparam(struct enc_ope=
n_param *open_param,
>  	u32 num_ctu_row =3D ALIGN(inst->dst_fmt.height, 64) / 64;
>  	u32 num_mb_row =3D ALIGN(inst->dst_fmt.height, 16) / 16;
> =20
> +	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422P ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16M ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61M)
> +		open_param->src_format =3D FORMAT_422;
> +	else
> +		open_param->src_format =3D FORMAT_420;
> +
>  	open_param->wave_param.gop_preset_idx =3D PRESET_IDX_IPP_SINGLE;
>  	open_param->wave_param.hvs_qp_scale =3D 2;
>  	open_param->wave_param.hvs_max_delta_qp =3D 10;


