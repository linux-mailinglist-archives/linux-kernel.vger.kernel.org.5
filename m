Return-Path: <linux-kernel+bounces-19408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C0826C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99485B21F48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9592D14A8D;
	Mon,  8 Jan 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rwyaTlET"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE72575D;
	Mon,  8 Jan 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C290480;
	Mon,  8 Jan 2024 12:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704712848;
	bh=Tum8/DuvvQKxm1SdPRKA7qtNnE7rrSJyBakAOivYufU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rwyaTlETzQot2HCkB5oLTPp2Yz0vLBGXvD0Lle9YxkmHWZu6EDLfcYb44bHnVjuWj
	 +SXlD0/RRpGtKgVD9ZP+Je2EqdkHZLqZMMEHr9QK/Wn3zxiu5MJMmpdBhMlQw+tAFI
	 n+EwDbpaZboJ0H4MHQcyBTIbj6XaTOm+lWcP9kYM=
Message-ID: <9cd1d791-ea1b-426b-9472-fc0fb9476b4b@ideasonboard.com>
Date: Mon, 8 Jan 2024 13:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] media: rkisp1: Support setting memory stride for
 main path
Content-Language: en-US
To: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
 aford173@gmail.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240106160221.4183409-1-paul.elder@ideasonboard.com>
 <20240106160221.4183409-3-paul.elder@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 xsFNBE6ms0cBEACyizowecZqXfMZtnBniOieTuFdErHAUyxVgtmr0f5ZfIi9Z4l+uUN4Zdw2
 wCEZjx3o0Z34diXBaMRJ3rAk9yB90UJAnLtb8A97Oq64DskLF81GCYB2P1i0qrG7UjpASgCA
 Ru0lVvxsWyIwSfoYoLrazbT1wkWRs8YBkkXQFfL7Mn3ZMoGPcpfwYH9O7bV1NslbmyJzRCMO
 eYV258gjCcwYlrkyIratlHCek4GrwV8Z9NQcjD5iLzrONjfafrWPwj6yn2RlL0mQEwt1lOvn
 LnI7QRtB3zxA3yB+FLsT1hx0va6xCHpX3QO2gBsyHCyVafFMrg3c/7IIWkDLngJxFgz6DLiA
 G4ld1QK/jsYqfP2GIMH1mFdjY+iagG4DqOsjip479HCWAptpNxSOCL6z3qxCU8MCz8iNOtZk
 DYXQWVscM5qgYSn+fmMM2qN+eoWlnCGVURZZLDjg387S2E1jT/dNTOsM/IqQj+ZROUZuRcF7
 0RTtuU5q1HnbRNwy+23xeoSGuwmLQ2UsUk7Q5CnrjYfiPo3wHze8avK95JBoSd+WIRmV3uoO
 rXCoYOIRlDhg9XJTrbnQ3Ot5zOa0Y9c4IpyAlut6mDtxtKXr4+8OzjSVFww7tIwadTK3wDQv
 Bus4jxHjS6dz1g2ypT65qnHen6mUUH63lhzewqO9peAHJ0SLrQARAQABzTBUb21pIFZhbGtl
 aW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT7CwY4EEwEIADgWIQTEOAw+
 ll79gQef86f6PaqMvJYe9QUCX/HruAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD6
 PaqMvJYe9WmFD/99NGoD5lBJhlFDHMZvO+Op8vCwnIRZdTsyrtGl72rVh9xRfcSgYPZUvBuT
 VDxE53mY9HaZyu1eGMccYRBaTLJSfCXl/g317CrMNdY0k40b9YeIX10feiRYEWoDIPQ3tMmA
 0nHDygzcnuPiPT68JYZ6tUOvAt7r6OX/litM+m2/E9mtp8xCoWOo/kYO4mOAIoMNvLB8vufi
 uBB4e/AvAjtny4ScuNV5c5q8MkfNIiOyag9QCiQ/JfoAqzXRjVb4VZG72AKaElwipiKCWEcU
 R4+Bu5Qbaxj7Cd36M/bI54OrbWWETJkVVSV1i0tghCd6HHyquTdFl7wYcz6cL1hn/6byVnD+
 sR3BLvSBHYp8WSwv0TCuf6tLiNgHAO1hWiQ1pOoXyMEsxZlgPXT+wb4dbNVunckwqFjGxRbl
 Rz7apFT/ZRwbazEzEzNyrBOfB55xdipG/2+SmFn0oMFqFOBEszXLQVslh64lI0CMJm2OYYe3
 PxHqYaztyeXsx13Bfnq9+bUynAQ4uW1P5DJ3OIRZWKmbQd/Me3Fq6TU57LsvwRgE0Le9PFQs
 dcP2071rMTpqTUteEgODJS4VDf4lXJfY91u32BJkiqM7/62Cqatcz5UWWHq5xeF03MIUTqdE
 qHWk3RJEoWHWQRzQfcx6Fn2fDAUKhAddvoopfcjAHfpAWJ+ENc7BTQROprNHARAAx0aat8GU
 hsusCLc4MIxOQwidecCTRc9Dz/7U2goUwhw2O5j9TPqLtp57VITmHILnvZf6q3QAho2QMQyE
 DDvHubrdtEoqaaSKxKkFie1uhWNNvXPhwkKLYieyL9m2JdU+b88HaDnpzdyTTR4uH7wk0bBa
 KbTSgIFDDe5lXInypewPO30TmYNkFSexnnM3n1PBCqiJXsJahE4ZQ+WnV5FbPUj8T2zXS2xk
 0LZ0+DwKmZ0ZDovvdEWRWrz3UzJ8DLHb7blPpGhmqj3ANXQXC7mb9qJ6J/VSl61GbxIO2Dwb
 xPNkHk8fwnxlUBCOyBti/uD2uSTgKHNdabhVm2dgFNVuS1y3bBHbI/qjC3J7rWE0WiaHWEqy
 UVPk8rsph4rqITsj2RiY70vEW0SKePrChvET7D8P1UPqmveBNNtSS7In+DdZ5kUqLV7rJnM9
 /4cwy+uZUt8cuCZlcA5u8IsBCNJudxEqBG10GHg1B6h1RZIz9Q9XfiBdaqa5+CjyFs8ua01c
 9HmyfkuhXG2OLjfQuK+Ygd56mV3lq0aFdwbaX16DG22c6flkkBSjyWXYepFtHz9KsBS0DaZb
 4IkLmZwEXpZcIOQjQ71fqlpiXkXSIaQ6YMEs8WjBbpP81h7QxWIfWtp+VnwNGc6nq5IQDESH
 mvQcsFS7d3eGVI6eyjCFdcAO8eMAEQEAAcLBXwQYAQIACQUCTqazRwIbDAAKCRD6PaqMvJYe
 9fA7EACS6exUedsBKmt4pT7nqXBcRsqm6YzT6DeCM8PWMTeaVGHiR4TnNFiT3otD5UpYQI7S
 suYxoTdHrrrBzdlKe5rUWpzoZkVK6p0s9OIvGzLT0lrb0HC9iNDWT3JgpYDnk4Z2mFi6tTbq
 xKMtpVFRA6FjviGDRsfkfoURZI51nf2RSAk/A8BEDDZ7lgJHskYoklSpwyrXhkp9FHGMaYII
 m9EKuUTX9JPDG2FTthCBrdsgWYPdJQvM+zscq09vFMQ9Fykbx5N8z/oFEUy3ACyPqW2oyfvU
 CH5WDpWBG0s5BALp1gBJPytIAd/pY/5ZdNoi0Cx3+Z7jaBFEyYJdWy1hGddpkgnMjyOfLI7B
 CFrdecTZbR5upjNSDvQ7RG85SnpYJTIin+SAUazAeA2nS6gTZzumgtdw8XmVXZwdBfF+ICof
 92UkbYcYNbzWO/GHgsNT1WnM4sa9lwCSWH8Fw1o/3bX1VVPEsnESOfxkNdu+gAF5S6+I6n3a
 ueeIlwJl5CpT5l8RpoZXEOVtXYn8zzOJ7oGZYINRV9Pf8qKGLf3Dft7zKBP832I3PQjeok7F
 yjt+9S+KgSFSHP3Pa4E7lsSdWhSlHYNdG/czhoUkSCN09C0rEK93wxACx3vtxPLjXu6RptBw
 3dRq7n+mQChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
In-Reply-To: <20240106160221.4183409-3-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2024 18:02, Paul Elder wrote:
> Some versions of the ISP supported by the rkisp1 driver, such as the ISP
> in the i.MX8MP, implement configurable memory stride for the main path
> the same way as already implemented by the driver for the self path.
> Support this feature by adding a main stride feature flag and program
> the corresponding registers accordingly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> ---
> Changes since v3:
> 
> - Implement memory stride support
> - Squash patch that adds register bits definitions
> - Reword the commit message
> 
> Changes since v2:
> 
> - Document the RKISP1_FEATURE_MAIN_STRIDE bit
> - Use the rkisp1_has_feature() macro
> ---
>   .../platform/rockchip/rkisp1/rkisp1-capture.c | 34 ++++++++++++-------
>   .../platform/rockchip/rkisp1/rkisp1-common.h  |  6 ++--
>   .../platform/rockchip/rkisp1/rkisp1-regs.h    | 27 +++++++++++++++
>   3 files changed, 52 insertions(+), 15 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index c381c22135a2..83a968487f24 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -442,6 +442,14 @@ static void rkisp1_mp_config(struct rkisp1_capture *cap)
>   	rkisp1_write(rkisp1, cap->config->mi.cr_size_init,
>   		     rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CR));
>   
> +	if (rkisp1_has_feature(rkisp1, MAIN_STRIDE)) {
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_LLENGTH, cap->stride);
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_PIC_WIDTH, pixm->width);
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_PIC_HEIGHT, pixm->height);
> +		rkisp1_write(rkisp1, RKISP1_CIF_MI_MP_Y_PIC_SIZE,
> +			     cap->stride * pixm->height);
> +	}
> +
>   	rkisp1_irq_frame_end_enable(cap);
>   
>   	/* set uv swapping for semiplanar formats */
> @@ -479,11 +487,11 @@ static void rkisp1_sp_config(struct rkisp1_capture *cap)
>   	rkisp1_write(rkisp1, cap->config->mi.cr_size_init,
>   		     rkisp1_pixfmt_comp_size(pixm, RKISP1_PLANE_CR));
>   
> -	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_LLENGTH, cap->sp_y_stride);
> +	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_LLENGTH, cap->stride);
>   	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_PIC_WIDTH, pixm->width);
>   	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_PIC_HEIGHT, pixm->height);
>   	rkisp1_write(rkisp1, RKISP1_CIF_MI_SP_Y_PIC_SIZE,
> -		     cap->sp_y_stride * pixm->height);
> +		     cap->stride * pixm->height);
>   
>   	rkisp1_irq_frame_end_enable(cap);
>   
> @@ -1095,8 +1103,8 @@ static const struct vb2_ops rkisp1_vb2_ops = {
>    */
>   
>   static const struct v4l2_format_info *
> -rkisp1_fill_pixfmt(struct v4l2_pix_format_mplane *pixm,
> -		   enum rkisp1_stream_id id)
> +rkisp1_fill_pixfmt(const struct rkisp1_capture *cap,
> +		   struct v4l2_pix_format_mplane *pixm)
>   {
>   	struct v4l2_plane_pix_format *plane_y = &pixm->plane_fmt[0];
>   	const struct v4l2_format_info *info;
> @@ -1109,10 +1117,13 @@ rkisp1_fill_pixfmt(struct v4l2_pix_format_mplane *pixm,
>   
>   	/*
>   	 * The SP supports custom strides, expressed as a number of pixels for
> -	 * the Y plane. Clamp the stride to a reasonable value to avoid integer
> -	 * overflows when calculating the bytesperline and sizeimage values.
> +	 * the Y plane, and so does the MP in ISP versions that have the
> +	 * MAIN_STRIDE feature. Clamp the stride to a reasonable value to avoid
> +	 * integer overflows when calculating the bytesperline and sizeimage
> +	 * values.
>   	 */
> -	if (id == RKISP1_SELFPATH)
> +	if (cap->id == RKISP1_SELFPATH ||
> +	    rkisp1_has_feature(cap->rkisp1, MAIN_STRIDE))
>   		stride = clamp(DIV_ROUND_UP(plane_y->bytesperline, info->bpp[0]),
>   			       pixm->width, 65536U);
>   	else
> @@ -1187,7 +1198,7 @@ static void rkisp1_try_fmt(const struct rkisp1_capture *cap,
>   	pixm->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
>   	pixm->quantization = V4L2_QUANTIZATION_DEFAULT;
>   
> -	info = rkisp1_fill_pixfmt(pixm, cap->id);
> +	info = rkisp1_fill_pixfmt(cap, pixm);
>   
>   	if (fmt_cfg)
>   		*fmt_cfg = fmt;
> @@ -1199,12 +1210,9 @@ static void rkisp1_set_fmt(struct rkisp1_capture *cap,
>   			   struct v4l2_pix_format_mplane *pixm)
>   {
>   	rkisp1_try_fmt(cap, pixm, &cap->pix.cfg, &cap->pix.info);
> -	cap->pix.fmt = *pixm;
>   
> -	/* SP supports custom stride in number of pixels of the Y plane */
> -	if (cap->id == RKISP1_SELFPATH)
> -		cap->sp_y_stride = pixm->plane_fmt[0].bytesperline /
> -				   cap->pix.info->bpp[0];
> +	cap->pix.fmt = *pixm;
> +	cap->stride = pixm->plane_fmt[0].bytesperline / cap->pix.info->bpp[0];
>   }
>   
>   static int rkisp1_try_fmt_vid_cap_mplane(struct file *file, void *fh,
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index be6cb42776b0..6a811b7ef1b9 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -110,6 +110,7 @@ enum rkisp1_isp_pad {
>    * enum rkisp1_feature - ISP features
>    *
>    * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
> + * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
>    *
>    * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
>    * the driver to implement support for features present in some ISP versions
> @@ -117,6 +118,7 @@ enum rkisp1_isp_pad {
>    */
>   enum rkisp1_feature {
>   	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
> +	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
>   };
>   
>   #define rkisp1_has_feature(rkisp1, feature) \
> @@ -266,7 +268,7 @@ struct rkisp1_device;
>    *		  handler to stop the streaming by waiting on the 'done' wait queue.
>    *		  If the irq handler is not called, the stream is stopped by the callback
>    *		  after timeout.
> - * @sp_y_stride:  the selfpath allows to configure a y stride that is longer than the image width.
> + * @stride:       the line stride for the first plane, in pixel units
>    * @buf.lock:	  lock to protect buf.queue
>    * @buf.queue:	  queued buffer list
>    * @buf.dummy:	  dummy space to store dropped data
> @@ -287,7 +289,7 @@ struct rkisp1_capture {
>   	bool is_streaming;
>   	bool is_stopping;
>   	wait_queue_head_t done;
> -	unsigned int sp_y_stride;
> +	unsigned int stride;
>   	struct {
>   		/* protects queue, curr and next */
>   		spinlock_t lock;
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> index bea69a0d766a..3b19c8411360 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
> @@ -207,6 +207,24 @@
>   #define RKISP1_CIF_MI_XTD_FMT_CTRL_SP_CB_CR_SWAP	BIT(1)
>   #define RKISP1_CIF_MI_XTD_FMT_CTRL_DMA_CB_CR_SWAP	BIT(2)
>   
> +/* MI_OUTPUT_ALIGN_FORMAT */
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_LSB_ALIGNMENT			BIT(0)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_BYTES		BIT(1)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_WORDS		BIT(2)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_MP_BYTE_SWAP_DWORDS		BIT(3)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_BYTES		BIT(4)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_WORDS		BIT(5)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_SP_BYTE_SWAP_DWORDS		BIT(6)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_DMA_BYTE_SWAP_BYTES		BIT(7)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_DMA_BYTE_SWAP_WORDS		BIT(8)
> +#define RKISP1_CIF_OUTPUT_ALIGN_FORMAT_DMA_BYTE_SWAP_DWORDS		BIT(9)
> +
> +/* MI_MP_OUTPUT_FIFO_SIZE */
> +#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_FULL	(0 << 0)
> +#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_HALF	(1 << 0)
> +#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_QUARTER	(2 << 0)
> +#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE_OUTPUT_FIFO_DEPTH_EIGHT	(3 << 0)
> +
>   /* VI_CCL */
>   #define RKISP1_CIF_CCL_CIF_CLK_DIS			BIT(2)
>   /* VI_ISP_CLK_CTRL */
> @@ -1000,6 +1018,15 @@
>   #define RKISP1_CIF_MI_SP_CB_BASE_AD_INIT2	(RKISP1_CIF_MI_BASE + 0x00000140)
>   #define RKISP1_CIF_MI_SP_CR_BASE_AD_INIT2	(RKISP1_CIF_MI_BASE + 0x00000144)
>   #define RKISP1_CIF_MI_XTD_FORMAT_CTRL		(RKISP1_CIF_MI_BASE + 0x00000148)
> +#define RKISP1_CIF_MI_MP_HANDSHAKE_0		(RKISP1_CIF_MI_BASE + 0x0000014C)
> +#define RKISP1_CIF_MI_MP_Y_LLENGTH		(RKISP1_CIF_MI_BASE + 0x00000150)
> +#define RKISP1_CIF_MI_MP_Y_SLICE_OFFSET		(RKISP1_CIF_MI_BASE + 0x00000154)
> +#define RKISP1_CIF_MI_MP_C_SLICE_OFFSET		(RKISP1_CIF_MI_BASE + 0x00000158)
> +#define RKISP1_CIF_MI_OUTPUT_ALIGN_FORMAT	(RKISP1_CIF_MI_BASE + 0x0000015C)
> +#define RKISP1_CIF_MI_MP_OUTPUT_FIFO_SIZE	(RKISP1_CIF_MI_BASE + 0x00000160)
> +#define RKISP1_CIF_MI_MP_Y_PIC_WIDTH		(RKISP1_CIF_MI_BASE + 0x00000164)
> +#define RKISP1_CIF_MI_MP_Y_PIC_HEIGHT		(RKISP1_CIF_MI_BASE + 0x00000168)
> +#define RKISP1_CIF_MI_MP_Y_PIC_SIZE		(RKISP1_CIF_MI_BASE + 0x0000016C)
>   
>   #define RKISP1_CIF_SMIA_BASE			0x00001a00
>   #define RKISP1_CIF_SMIA_CTRL			(RKISP1_CIF_SMIA_BASE + 0x00000000)


