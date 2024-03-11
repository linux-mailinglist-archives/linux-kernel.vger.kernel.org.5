Return-Path: <linux-kernel+bounces-98700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD0877E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A671C21566
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C41383A5;
	Mon, 11 Mar 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YZG/gzB1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C08494;
	Mon, 11 Mar 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152881; cv=none; b=GPAKKdwBp1DvVYQNYap1Do/lut5hNxW3zvKHSdsx0nEK5RjUnOFf/i9AEizCPfdCPgZcarY8C3R4zvxOiVFjHNVF0p8C1qJeKz3I+KIc+8Jta9hebMRpWiPshmVuvCzaxbM5o3r/TbsbVTHicTUFQuyJi1a+qFBMSXWTkNCf7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152881; c=relaxed/simple;
	bh=wHQ4vlUGoL2z6qkxE8BaQRaSfdBVhRWAnhaO/rToAfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ept+2+gefj/ULYjjkY+LC3aTsK6+F3bb6iAOiHryTd0OUE4eL+vgTzzHhvQEIQL+jiM6VO0zgn7HPlxQ2KCTlEz5mcNvCfxGLu+nXXDyc85q5BwrpqD1Pdv3JATjoD25h9UvTxWOMyl5XXeO8cMrMwbLMGIxaj4teYGH8m09SAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YZG/gzB1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710152878;
	bh=wHQ4vlUGoL2z6qkxE8BaQRaSfdBVhRWAnhaO/rToAfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YZG/gzB1a9w3vaQs4XNNdLsv2tqzV+jwngD+mckw1686kj55qPaftWratb7tXcPZZ
	 n0Ll626CGOLr7RyfIRBmvMRrQ1gqPNyNBVx/pN0I0e0sKdJEWCm28AgqIiz54ziVi3
	 yk0+sFz5qSGrCUWIA7sAMmhYdnjrdRz8ueZm36l+Rr1douOB8w3UVfdtfB2yEtNZoi
	 IXnkK7KeWRDdw53KwjcwFnHCp+hkK+L4a/hSh6ffCMfwn/XhuUYpYCu2Of6gBKjpoY
	 I/DvF5gEfsbMI9YndInHJ3si5HkY8YJa09abvbJmEmvxuXMebnoFhVsD+/o5KjDhq5
	 +v+5BK6UQt8+w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 949D337813F2;
	Mon, 11 Mar 2024 10:27:57 +0000 (UTC)
Message-ID: <483ba231-4b7b-44c5-a5b6-c58ec0760407@collabora.com>
Date: Mon, 11 Mar 2024 11:27:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] media: mediatek: vcodec: Improve wording & fix
 grammatic issues
Content-Language: en-US
To: Sebastian Fricke <sebastian.fricke@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240309-mediatek-typos-v1-0-fa4aeb59306c@collabora.com>
 <20240309-mediatek-typos-v1-2-fa4aeb59306c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v1-2-fa4aeb59306c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/03/24 16:08, Sebastian Fricke ha scritto:
> Multiple issues detected while scanning the code by far not a complete
> list of required changes but some small improvements.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>   drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h   | 2 +-
>   .../media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c    | 2 +-
>   .../platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c    | 2 +-
>   .../platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c    | 2 +-
>   drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c     | 4 ++--
>   drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> index a0451116f2e4..f975db4293da 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -71,7 +71,7 @@ enum mtk_vdec_hw_arch {
>    * @fb_sz: bitstream size of each plane
>    * E.g. suppose picture size is 176x144,
>    *      buffer size will be aligned to 176x160.
> - * @cap_fourcc: fourcc number(may changed when resolution change)
> + * @cap_fourcc: fourcc number(may change on a resolution change)

This goes to patch 1/3

>    * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bit os.
>    */
>   struct vdec_pic_info {
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
> index 37c41b673876..668e87bf30e8 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
> @@ -27,7 +27,7 @@ struct mtk_h264_dec_slice_param {
>   /**
>    * struct vdec_h264_dec_info - decode information
>    * @dpb_sz		: decoding picture buffer size
> - * @resolution_changed  : resolution change happend
> + * @resolution_changed  : flag to notify that a resolution change happend

happend -> happened

>    * @realloc_mv_buf	: flag to notify driver to re-allocate mv buffer
>    * @cap_num_planes	: number planes of capture buffer
>    * @bs_dma		: Input bit-stream buffer dma address
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
> index d5224c9584b6..c4ac6b6f7acf 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
> @@ -131,7 +131,7 @@ struct vdec_h264_slice_share_info {
>   /**
>    * struct vdec_h264_slice_inst - h264 decoder instance
>    *
> - * @slice_dec_num:	how many picture be decoded
> + * @slice_dec_num:	how many pictures to be decoded

number of frames to be decoded ?

Cheers,
Angelo

>    * @ctx:		point to mtk_vcodec_dec_ctx
>    * @pred_buf:		HW working prediction buffer
>    * @mv_buf:		HW working motion vector buffer
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
> index a44db6139ff2..349b510d355a 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
> @@ -342,7 +342,7 @@ struct vdec_hevc_slice_share_info {
>   /**
>    * struct vdec_hevc_slice_inst - hevc decoder instance
>    *
> - * @slice_dec_num:      how many picture be decoded
> + * @slice_dec_num:      how many pictures to be decoded
>    * @ctx:                point to mtk_vcodec_dec_ctx
>    * @mv_buf:             HW working motion vector buffer
>    * @vpu:                VPU instance
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> index 19407f9bc773..9649f4ec1f2a 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> @@ -56,7 +56,7 @@
>    * @cur_c_fb_dma      : current plane C frame buffer dma address
>    * @bs_dma	      : bitstream dma address
>    * @bs_sz	      : bitstream size
> - * @resolution_changed: resolution change flag 1 - changed,  0 - not change
> + * @resolution_changed: resolution change flag 1 - changed,  0 - not changed

This goes to patch [1/3]

>    * @show_frame	      : display this frame or not
>    * @wait_key_frame    : wait key frame coming
>    */
> @@ -109,7 +109,7 @@ struct vdec_vp8_hw_reg_base {
>   /**
>    * struct vdec_vp8_vpu_inst - VPU instance for VP8 decode
>    * @wq_hd	: Wait queue to wait VPU message ack
> - * @signaled	: 1 - Host has received ack message from VPU, 0 - not receive
> + * @signaled	: 1 - Host has received ack message from VPU, 0 - not received

same

>    * @failure	: VPU execution result status 0 - success, others - fail
>    * @inst_addr	: VPU decoder instance address
>    */
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> index f677e499fefa..e27e728f392e 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> @@ -35,7 +35,7 @@
>    * @cur_c_fb_dma:	current plane C frame buffer dma address
>    * @bs_dma:		bitstream dma address
>    * @bs_sz:		bitstream size
> - * @resolution_changed:resolution change flag 1 - changed,  0 - not change
> + * @resolution_changed:resolution change flag 1 - changed,  0 - not changed

ditto

>    * @frame_header_type:	current frame header type
>    * @crc:		used to check whether hardware's status is right
>    * @reserved:		reserved, currently unused
> 

Cheers,
Angelo


