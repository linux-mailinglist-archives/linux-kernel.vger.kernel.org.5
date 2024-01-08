Return-Path: <linux-kernel+bounces-19444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A171F826CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D6E2831D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E664E21A0E;
	Mon,  8 Jan 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mZA7oNAy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808629415;
	Mon,  8 Jan 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC39F480;
	Mon,  8 Jan 2024 12:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704713785;
	bh=wLsXXURlsAber4mf3UeD5DZIsRKiZzhmGxVOIZi0OLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mZA7oNAy8NPtKDZ1t7MFgisZ2ioXOd6SRM0MFdl/wu/mTL14fVcFpF3RPS5p2yv9T
	 H0a6C/1uBZaDupnSfeN/Yd0izCfCsTzGUIvpgfhht4UFiKZvg/Ia0hQIAE4iPZ+Dsi
	 cviJQlBlFcLsDWBfm2p+n4U4c2ejWdIj8LsqCDA4=
Message-ID: <5e335fef-201c-4775-8a42-4441d749c345@ideasonboard.com>
Date: Mon, 8 Jan 2024 13:37:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] media: rkisp1: Shift DMA buffer addresses on
 i.MX8MP
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
 <20240106160221.4183409-9-paul.elder@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240106160221.4183409-9-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2024 18:02, Paul Elder wrote:
> On the ISP that is integrated in the i.MX8MP, DMA addresses have been
> extended to 34 bits, with the 32 MSBs stored in the DMA address
> registers and the 2 LSBs set to 0. Shift the buffer addresses right by 2
> on that platform.
> 
> While at it, fix an issue where if the system allocated CMA memory
> happens to be located higher than 32-bits, the driver will fail to
> allocate CMA memory and falls back to kmalloc(), which will fail for
> larger allocations (over MAX_ORDER, which often mean 4MB).
> 
> Fix this by setting the dma mask to 34 bits when allowed, and fixing the
> use dma_addr_t when storing dma addresses instead of u32.

I think the desc could be rewritten a bit for clarity. "While at it" 
sounds like doing some secondary changes too, but it's all required. And 
it's not really "fixing", as this is adding a new feature.

To support i.MX8MP's 34-bit addresses, we need to:

- shift the addresses when writing to registers
- set the dma mask
- use dma_addr_t instead of u32 when storing the addresses

Can you rewrite the desc to describe the above?

For the change itself:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> ---
> Changes since v4:
> 
> - Squash in fix from Tomi:
>    - https://gitlab.com/ideasonboard/nxp/linux/-/commit/d6477fe673b1c0d05d12ae21d8db9a03b07e7fea
> 
> Changes since v2:
> 
> - Document the RKISP1_FEATURE_DMA_34BIT bit
> - Use the rkisp1_has_feature() macro
> ---
>   .../platform/rockchip/rkisp1/rkisp1-capture.c | 20 ++++++++++---------
>   .../platform/rockchip/rkisp1/rkisp1-common.h  |  4 +++-
>   .../platform/rockchip/rkisp1/rkisp1-dev.c     | 11 +++++++++-
>   3 files changed, 24 insertions(+), 11 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index ca95f62822fa..1ee7639c42b7 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -648,11 +648,13 @@ static void rkisp1_dummy_buf_destroy(struct rkisp1_capture *cap)
>   
>   static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
>   {
> +	u8 shift = rkisp1_has_feature(cap->rkisp1, DMA_34BIT) ? 2 : 0;
> +
>   	cap->buf.curr = cap->buf.next;
>   	cap->buf.next = NULL;
>   
>   	if (!list_empty(&cap->buf.queue)) {
> -		u32 *buff_addr;
> +		dma_addr_t *buff_addr;
>   
>   		cap->buf.next = list_first_entry(&cap->buf.queue, struct rkisp1_buffer, queue);
>   		list_del(&cap->buf.next->queue);
> @@ -660,7 +662,7 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
>   		buff_addr = cap->buf.next->buff_addr;
>   
>   		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
> -			     buff_addr[RKISP1_PLANE_Y]);
> +			     buff_addr[RKISP1_PLANE_Y] >> shift);
>   		/*
>   		 * In order to support grey format we capture
>   		 * YUV422 planar format from the camera and
> @@ -669,17 +671,17 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
>   		if (cap->pix.cfg->fourcc == V4L2_PIX_FMT_GREY) {
>   			rkisp1_write(cap->rkisp1,
>   				     cap->config->mi.cb_base_ad_init,
> -				     cap->buf.dummy.dma_addr);
> +				     cap->buf.dummy.dma_addr >> shift);
>   			rkisp1_write(cap->rkisp1,
>   				     cap->config->mi.cr_base_ad_init,
> -				     cap->buf.dummy.dma_addr);
> +				     cap->buf.dummy.dma_addr >> shift);
>   		} else {
>   			rkisp1_write(cap->rkisp1,
>   				     cap->config->mi.cb_base_ad_init,
> -				     buff_addr[RKISP1_PLANE_CB]);
> +				     buff_addr[RKISP1_PLANE_CB] >> shift);
>   			rkisp1_write(cap->rkisp1,
>   				     cap->config->mi.cr_base_ad_init,
> -				     buff_addr[RKISP1_PLANE_CR]);
> +				     buff_addr[RKISP1_PLANE_CR] >> shift);
>   		}
>   	} else {
>   		/*
> @@ -687,11 +689,11 @@ static void rkisp1_set_next_buf(struct rkisp1_capture *cap)
>   		 * throw data if there is no available buffer.
>   		 */
>   		rkisp1_write(cap->rkisp1, cap->config->mi.y_base_ad_init,
> -			     cap->buf.dummy.dma_addr);
> +			     cap->buf.dummy.dma_addr >> shift);
>   		rkisp1_write(cap->rkisp1, cap->config->mi.cb_base_ad_init,
> -			     cap->buf.dummy.dma_addr);
> +			     cap->buf.dummy.dma_addr >> shift);
>   		rkisp1_write(cap->rkisp1, cap->config->mi.cr_base_ad_init,
> -			     cap->buf.dummy.dma_addr);
> +			     cap->buf.dummy.dma_addr >> shift);
>   	}
>   
>   	/* Set plane offsets */
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 69940014d597..26573f6ae575 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -114,6 +114,7 @@ enum rkisp1_isp_pad {
>    * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
>    * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
>    * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
> + * @RKISP1_FEATURE_DMA_34BIT: The ISP uses 34-bit DMA addresses
>    *
>    * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
>    * the driver to implement support for features present in some ISP versions
> @@ -124,6 +125,7 @@ enum rkisp1_feature {
>   	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
>   	RKISP1_FEATURE_SELF_PATH = BIT(2),
>   	RKISP1_FEATURE_DUAL_CROP = BIT(3),
> +	RKISP1_FEATURE_DMA_34BIT = BIT(4),
>   };
>   
>   #define rkisp1_has_feature(rkisp1, feature) \
> @@ -239,7 +241,7 @@ struct rkisp1_vdev_node {
>   struct rkisp1_buffer {
>   	struct vb2_v4l2_buffer vb;
>   	struct list_head queue;
> -	u32 buff_addr[VIDEO_MAX_PLANES];
> +	dma_addr_t buff_addr[VIDEO_MAX_PLANES];
>   };
>   
>   /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 01f811b9f9a5..fd99355d5fe0 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -549,7 +549,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
>   	.isrs = imx8mp_isp_isrs,
>   	.isr_size = ARRAY_SIZE(imx8mp_isp_isrs),
>   	.isp_ver = IMX8MP_V10,
> -	.features = RKISP1_FEATURE_MAIN_STRIDE,
> +	.features = RKISP1_FEATURE_MAIN_STRIDE
> +		  | RKISP1_FEATURE_DMA_34BIT,
>   };
>   
>   static const struct of_device_id rkisp1_of_match[] = {
> @@ -575,6 +576,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct rkisp1_device *rkisp1;
>   	struct v4l2_device *v4l2_dev;
> +	unsigned long long dma_mask;
>   	unsigned int i;
>   	int ret, irq;
>   	u32 cif_id;
> @@ -589,6 +591,13 @@ static int rkisp1_probe(struct platform_device *pdev)
>   	dev_set_drvdata(dev, rkisp1);
>   	rkisp1->dev = dev;
>   
> +	dma_mask = rkisp1_has_feature(rkisp1, DMA_34BIT) ? DMA_BIT_MASK(34) :
> +							   DMA_BIT_MASK(32);
> +
> +	ret = dma_set_mask_and_coherent(dev, dma_mask);
> +	if (ret)
> +		return ret;
> +
>   	mutex_init(&rkisp1->stream_lock);
>   
>   	rkisp1->base_addr = devm_platform_ioremap_resource(pdev, 0);


