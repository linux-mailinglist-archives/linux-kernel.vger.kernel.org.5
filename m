Return-Path: <linux-kernel+bounces-98706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0A877E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F64F2827BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6936AEF;
	Mon, 11 Mar 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pv1o7omv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC40249E4;
	Mon, 11 Mar 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153321; cv=none; b=gkX3YhQrSaoRjigfWqxhJKwfrIYVC15OolP1AmqRJBY7a6bmbGWxnqOOcYCKSoN4U0mjHuHKodlNguhMNLcOaExNP3lnho+Hv4E4rVjMd9CTTUGauFDyj9Yb3ZIoM1loeLXTjAypFnu/gjLVTGDbCumGiJu5F1SAuNcasnW4cAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153321; c=relaxed/simple;
	bh=bH/XvSdNJiKdE3OIQD4JszYlFQOoKuSIHzKC0Z4hyW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1JvWJIOpzPzPBXRrDVIT4isLLFqnrBixb7+vGjhvLANwom47UDhhNqZBIAz2sZ5hE3AD61235UdySvzEwIapN2xOfEbszii6SJcZ4Di/UwouBakD3DRTJQS1NtQaWto+klBOvREekXDupGxLy2nXjuzPfHhsQeI4IpE/mLl3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pv1o7omv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710153318;
	bh=bH/XvSdNJiKdE3OIQD4JszYlFQOoKuSIHzKC0Z4hyW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pv1o7omv9nUDixra0TUCrmUf64Z1XaOH4vtQhflvk0u/82LZfRmWRnwlF0poOlTeu
	 8YVQ7UX6lGoEOmbvs976jdhWumwwJuEU1nFvtT0oLK02HioXqh5vkgpcdF0dxIRUXC
	 wcPOJdiyVtMQ820UzhytNHxOo2tNtkWdA9UVJovJTvqE1cYLWpkjTYsD/vQmbj4OlZ
	 rz4+ogdEdw4sxIx/71e39STnfznn6Ui59byCfn0TF5B771rzUlofwD0Pznk+e6VbK5
	 CBHlVpSxLveczgyCdtN5/vPOdM5p3c6FJnmapa43LnsesL7XVPl8WdzqLAS6/suKKE
	 sYWPI5ahUEQfQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C64AC3780629;
	Mon, 11 Mar 2024 10:35:17 +0000 (UTC)
Message-ID: <15267045-045d-484a-b645-3c485a89bf12@collabora.com>
Date: Mon, 11 Mar 2024 11:35:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: mediatek: vcodec: Replace false function
 description
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
 <20240309-mediatek-typos-v1-3-fa4aeb59306c@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v1-3-fa4aeb59306c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/03/24 16:08, Sebastian Fricke ha scritto:
> The function descriptions where falsely copy pasted from another entry,
> write more fitting descriptions for the functions.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
>   .../platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h    | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
> index 6f624c266246..2d845b1307b6 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
> @@ -185,7 +185,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
>   void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id);
>   
>   /**
> - * mtk_vdec_h264_fill_dpb_info - get each CID contrl address.
> + * mtk_vdec_h264_fill_dpb_info - Fill the decoded picture buffer info
>    *
>    * @ctx:		v4l2 ctx
>    * @decode_params:	slice decode params
> @@ -225,7 +225,9 @@ void mtk_vdec_h264_copy_slice_hd_params(struct mtk_h264_slice_hd_param *dst_para
>   					const struct v4l2_ctrl_h264_decode_params *dec_param);
>   
>   /**
> - * mtk_vdec_h264_copy_scaling_matrix - get each CID contrl address.
> + * mtk_vdec_h264_copy_scaling_matrix - Copy the scaling matrix from a source to
> + *				       a destination.
> + *				       (for example into the slice parameters)

That should be a short description; the "for example into the slice parameters"
along with a longer description go in the long description part of the doc.

/*
  * mtk_vdec_h264_copy_scaling_matrix - Copy scaling matrix from HW to driver
  * @dst_matrix: .....
  * @src_matrix: ....
  *
  * This function copies the scaling matrix from the hardware decoder (format?
  * structs? registers? what?) to the driver's scaling matrix structure, because
  * this that and the other tell me why we would ever need to do this, as this
  * is a long description of what this function does.
  * If a long description is not needed, just avoid it, of course.
  *
  * Return: some value for something, some other for something else
  *
  * This return value, as described, is so useful! :-)
  */

Cheers,
Angelo

