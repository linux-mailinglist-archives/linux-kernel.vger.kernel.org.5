Return-Path: <linux-kernel+bounces-94007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC615873837
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A7B20E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA7131E56;
	Wed,  6 Mar 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q9wVm5eL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A11E519;
	Wed,  6 Mar 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733683; cv=none; b=gKzDapIUaY8YojBcHv1agU7R2zGhEpIWQAd1APctni57X0BATyCYAaR+WJid5jw4U/bkfYNfMwrecbWJkEYOcW05pCzvsc0UjwTlYD2fh0IEsoPAPnb6sllw/yR2MMMCFHmyek5oUClQcMtb68Hs6O+cjA6WQkv7AHnpQDJZ2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733683; c=relaxed/simple;
	bh=OL16fx6KjUVBqodWcez5kPju6qteSkdvY8c4p+ZXvLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAgMNT3uf56XYymU4i/pUoCRqC6msvWb0mcT2zhq/o3NEwBYcKvnDBVyPZCd3mNcGkh5nH+OPu+F/8ILruFkOHOHebvqFEKxfgizWNJEAvll68hpg9eu3qTLnuCg6XvCu+lFgsHBwatUaw95AOp9W0Qa/j/iqrvzkvBjgWBrSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q9wVm5eL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709733673;
	bh=OL16fx6KjUVBqodWcez5kPju6qteSkdvY8c4p+ZXvLI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q9wVm5eLpkVFAhVCMsjJ/hcOI1icOPvyOHKdr9rvAH0/Rrb6hMjHXePH37OnLUEHl
	 Nu0mINsbRFk0gOe1fWLv4nBRKJIuXRMirkx9EwomEPFn5OGXYTBrHgyNXoElkd8EVt
	 7BNRcXUNKRa4tjUhjCNrfDE+fp5jLKbiU+e3ZwxkRwCmRdUunG98rB2Lbep7D2MW6C
	 XwDq/ILuj44uJTQuPKle3N1RGORioEzlmYkXZcd8snpXeiM7UflTk2negWjWViyO/Z
	 i4kRhXezOUkaAPvnig3EQCe7eDAxgS4LgQdaoW9LgSjiqDwh9y6k+UHjpBqk46X1MA
	 jqPWrGSQhkv5g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9B09037813B6;
	Wed,  6 Mar 2024 14:01:12 +0000 (UTC)
Message-ID: <66a2307a-1420-4cea-aab3-53ac81f8c246@collabora.com>
Date: Wed, 6 Mar 2024 15:01:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: mediatek: vcodec: support 36 bits physical
 address
Content-Language: en-US
To: Yunfei Dong <yunfei.dong@mediatek.com>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Sebastian Fricke <sebastian.fricke@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240306121902.25069-1-yunfei.dong@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240306121902.25069-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/03/24 13:19, Yunfei Dong ha scritto:
> The physical address on the MT8188 platform is larger than 32 bits,
> change the type from unsigned int to dma_addr_t to be able to access
> the high bits of the address.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> compare with v1:
> - change address type from unsigned long to dma_addr_t
> - change vp8 address type
> ---
>   .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c | 2 +-
>   .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> index 19407f9bc773..987b3d71b662 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
> @@ -449,7 +449,7 @@ static int vdec_vp8_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>   		       inst->frm_cnt, y_fb_dma, c_fb_dma, fb);
>   
>   	inst->cur_fb = fb;
> -	dec->bs_dma = (unsigned long)bs->dma_addr;
> +	dec->bs_dma = (uint64_t)bs->dma_addr;
>   	dec->bs_sz = bs->size;
>   	dec->cur_y_fb_dma = y_fb_dma;
>   	dec->cur_c_fb_dma = c_fb_dma;
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> index cf48d09b78d7..eea709d93820 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> @@ -1074,7 +1074,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
>   	unsigned int mi_row;
>   	unsigned int mi_col;
>   	unsigned int offset;
> -	unsigned int pa;
> +	dma_addr_t pa;
>   	unsigned int size;
>   	struct vdec_vp9_slice_tiles *tiles;
>   	unsigned char *pos;
> @@ -1109,7 +1109,7 @@ static int vdec_vp9_slice_setup_tile_buffer(struct vdec_vp9_slice_instance *inst
>   	pos = va + offset;
>   	end = va + bs->size;
>   	/* truncated */
> -	pa = (unsigned int)bs->dma_addr + offset;
> +	pa = bs->dma_addr + offset;
>   	tb = instance->tile.va;
>   	for (i = 0; i < rows; i++) {
>   		for (j = 0; j < cols; j++) {


