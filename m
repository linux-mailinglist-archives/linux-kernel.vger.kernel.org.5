Return-Path: <linux-kernel+bounces-139941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCC8A0960
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED401F21DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE513DDDD;
	Thu, 11 Apr 2024 07:11:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924713DBA0;
	Thu, 11 Apr 2024 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819474; cv=none; b=QRivoBlXPAHnKEPR+vK9MUtrYh7ok8Vvg4Psko77HKB7hIjf0iWUQc+G13Q+U0tMj7+DPBHPVJmCl12PgBLgFCSdIBXikrCgeuIV07oagdZHKqGrEhzWIIDWBv2YCjarl9n/jODj3fFIzOoHJXelZwMLIADqXDHw+tT0KFMrxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819474; c=relaxed/simple;
	bh=mHFt/G53hAFEMBRtvSArbsest/5VtPkry0VDRfUuA1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNOsnGaQdhZI+l8QFgs+0MD42auRWKpphyqbp5gvkgCa5S4JKSIr32OZ6rnDSorWMOOP9LqY2lIq75eJTbSJg+KKConFSaUvmGYARvioaPxq1v/EDDCdn7Rv53rm26VQCe/b2htBgwtJmg1Aor0lKYEXGa1mrGwpzwq1hsaWOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9FAC433F1;
	Thu, 11 Apr 2024 07:11:10 +0000 (UTC)
Message-ID: <d230b840-471b-4f77-b9f4-34a4063f1db9@xs4all.nl>
Date: Thu, 11 Apr 2024 09:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: mediatek: vcodec: support 36 bits physical
 address
Content-Language: en-US, nl
To: Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>,
 Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240411070127.12384-1-yunfei.dong@mediatek.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240411070127.12384-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yunfei,

Since the v2 patch is now merged in mainline as-is, you need to make a patch
on top of that.

So just post a new patch that applies to the mainline.

Regards,

	Hans

On 11/04/2024 09:01, Yunfei Dong wrote:
> The physical address on the MT8188 platform is larger than 32 bits,
> change the type from unsigned int to dma_addr_t to be able to access
> the high bits of the address.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> compared with v2:
> - remove unless cast
> ---
>  .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c | 2 +-
>  .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> index 9649f4ec1f2a..5f848691cea4 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> @@ -449,7 +449,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  		       inst->frm_cnt, y_fb_dma, c_fb_dma, fb);
>  
>  	inst->cur_fb = fb;
> -	dec->bs_dma = (unsigned long)bs->dma_addr;
> +	dec->bs_dma = bs->dma_addr;
>  	dec->bs_sz = bs->size;
>  	dec->cur_y_fb_dma = y_fb_dma;
>  	dec->cur_c_fb_dma = c_fb_dma;
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> index cf48d09b78d7..eea709d93820 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> @@ -1074,7 +1074,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
>  	unsigned int mi_row;
>  	unsigned int mi_col;
>  	unsigned int offset;
> -	unsigned int pa;
> +	dma_addr_t pa;
>  	unsigned int size;
>  	struct vdec_vp9_slice_tiles *tiles;
>  	unsigned char *pos;
> @@ -1109,7 +1109,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
>  	pos = va + offset;
>  	end = va + bs->size;
>  	/* truncated */
> -	pa = (unsigned int)bs->dma_addr + offset;
> +	pa = bs->dma_addr + offset;
>  	tb = instance->tile.va;
>  	for (i = 0; i < rows; i++) {
>  		for (j = 0; j < cols; j++) {


