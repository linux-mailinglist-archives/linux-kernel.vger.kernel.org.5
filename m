Return-Path: <linux-kernel+bounces-41413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B483F07C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34171F2378C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FD1BDFC;
	Sat, 27 Jan 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6PjP3Qy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6E1A731;
	Sat, 27 Jan 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393244; cv=none; b=W9fLKFeD1PlYXcartR8TvTP0A4GiMEyDuDDSjrqkMtmvMKoDEo/opItE/I5TbXUrOJaCuQY0JWZA5TQKQBfNewUYVa0cx3FsrVDq6+2rv+/62q5ioWSvzO8R8VGlB7zaLCnH0+pkA207u1RsA9rAqNXWusncSpyCxjAW0Lcnnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393244; c=relaxed/simple;
	bh=Vf6HmXNqmhTWKFlU+cNMSwBAo0o70VhJ3UNNL/CT4b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnV8AVnW3att7Rcgp87M5L2q/RSruAib7Ghx278wfdd/QzWbpNOkYHz3hXISsf4FqMnkjDwSTDoY4IYxpV11FwxnKLuZE0q5MNFyOklAezfgP7iwYH5hEX07rB+yh5i6Mqxxf4qTsxv/x2F5L273bb/e1GIDqduTjIahz/5hzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h6PjP3Qy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sVH0boheHEjqFAG/uYCckQKXtdYKR4rZiD2FneAdLPQ=; b=h6PjP3QyPtQKXjFhTp8fFlHleO
	D4qs4ndCARXcn9tYt2b6slt3hz4cQwIKE9fmXJzT6EcOR3v+V2MED4k9ewQB4GusF33QXM6Ob6mz6
	vrXve4Kg3JejkIkNDTc0qHRkVdurMFrZmlkPhO2ziRhgkJdrgUehMSFNNZX3o2cmTgWm8dtSfJADQ
	efn/SxcqBS6O1rzdgjMe4qKH9VxRt1wyIuuYQaNPyn5amtZzTJ8jYQQntC67AszEAb4utp4wfOPol
	0DuGpkcRIY5xoxSa0e2iFEaZs3MkExkv2pVnvRL8wjABl9ZqzP0pAdV0iSaTZqYP4cQaGxcJXwq7Q
	5gbxyWYQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqpV-00000008GkT-32FI;
	Sat, 27 Jan 2024 22:07:13 +0000
Message-ID: <0b108b53-0dba-4c8f-91c1-2725f0752f23@infradead.org>
Date: Sat, 27 Jan 2024 14:07:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] media: mediatek: vcodec: Fix kerneldoc
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Bin Liu <bin.liu@mediatek.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-amlogic@lists.infradead.org
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-9-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-9-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Those fields have been removed. They do not need to be documented.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h | 1 -
>  drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h    | 1 -
>  drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
> index ece27c880e50..1af075fc0194 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
> @@ -39,7 +39,6 @@ struct vdec_fb {
>  /**
>   * struct mtk_video_dec_buf - Private data related to each VB2 buffer.
>   * @m2m_buf:	M2M buffer
> - * @list:	link list
>   * @used:	Capture buffer contain decoded frame data and keep in
>   *			codec data structure
>   * @queued_in_vb2:	Capture buffer is queue in vb2
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> index fbb3f34a73f0..aa7d08afc2f4 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
> @@ -22,7 +22,6 @@ struct mtk_vcodec_dec_ctx;
>   *                in place of inst_addr in messages.
>   * @signaled    : 1 - Host has received ack message from VPU, 0 - not received
>   * @ctx         : context for v4l2 layer integration
> - * @dev		: platform device of VPU
>   * @wq          : wait queue to wait VPU message ack
>   * @handler     : ipi handler for each decoder
>   * @codec_type     : use codec type to separate different codecs
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
> index 82246401ed4a..908d8179b2d2 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
> @@ -26,7 +26,6 @@
>  /**
>   * struct mtk_video_enc_buf - Private data related to each VB2 buffer.
>   * @m2m_buf:	M2M buffer
> - * @list:	list that buffer link to
>   * @param_change: Types of encode parameter change before encoding this
>   *				buffer
>   * @enc_params: Encode parameters changed before encode this buffer
> 

-- 
#Randy

