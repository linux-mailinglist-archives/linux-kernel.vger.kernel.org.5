Return-Path: <linux-kernel+bounces-19409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1302F826C83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6DBB21E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5814A97;
	Mon,  8 Jan 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VwWBYH0s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8414280;
	Mon,  8 Jan 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEB6B552;
	Mon,  8 Jan 2024 12:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704712922;
	bh=mZEYbOfdCedJgfR8Tpz+2lLXQYYX5qzf34saVCOcZGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VwWBYH0s3c6vgsuc1par1NyeMkjhJJ4aCZP5CsZdWLz5KAZOih9h6l4urhXsC6zNn
	 f4ZII8bPVvbc08hnWX90vSrYtlmIOI+mrl+9iGvRMqhnEHEr4A5lEme6KV6oCev46F
	 K6JzR4pJE5NUjlTFB5jJU534HhBSqP7fMsPF8ITs=
Message-ID: <a828ade8-41cf-47a9-addf-594325635426@ideasonboard.com>
Date: Mon, 8 Jan 2024 13:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] media: rkisp1: Support devices lacking self path
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
 <20240106160221.4183409-4-paul.elder@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240106160221.4183409-4-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2024 18:02, Paul Elder wrote:
> Some versions of the ISP supported by the rkisp1 driver, such as the ISP
> in the i.MX8MP, lack the self path. Support those ISP versions by adding
> a self path feature flag, and massage the rest of the driver to support
> the lack of a self path.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> ---
> Changes since v3:
> 
> - Document the feature bit
> - Reorder commit
> 
> Changes since v2:
> 
> - Simplify rkisp1_path_count()
> - Use the rkisp1_has_feature() macro
> ---
>   .../platform/rockchip/rkisp1/rkisp1-capture.c     |  9 ++++++---
>   .../platform/rockchip/rkisp1/rkisp1-common.h      | 15 +++++++++++++++
>   .../media/platform/rockchip/rkisp1/rkisp1-dev.c   |  9 ++++++---
>   .../platform/rockchip/rkisp1/rkisp1-resizer.c     |  6 ++++--
>   4 files changed, 31 insertions(+), 8 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index 83a968487f24..ca95f62822fa 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -730,6 +730,7 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
>   {
>   	struct device *dev = ctx;
>   	struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> +	unsigned int dev_count = rkisp1_path_count(rkisp1);
>   	unsigned int i;
>   	u32 status;
>   
> @@ -742,7 +743,7 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
>   
>   	rkisp1_write(rkisp1, RKISP1_CIF_MI_ICR, status);
>   
> -	for (i = 0; i < ARRAY_SIZE(rkisp1->capture_devs); ++i) {
> +	for (i = 0; i < dev_count; ++i) {
>   		struct rkisp1_capture *cap = &rkisp1->capture_devs[i];
>   
>   		if (!(status & RKISP1_CIF_MI_FRAME(cap)))
> @@ -899,6 +900,7 @@ static void rkisp1_cap_stream_enable(struct rkisp1_capture *cap)
>   {
>   	struct rkisp1_device *rkisp1 = cap->rkisp1;
>   	struct rkisp1_capture *other = &rkisp1->capture_devs[cap->id ^ 1];
> +	bool has_self_path = rkisp1_has_feature(rkisp1, SELF_PATH);
>   
>   	cap->ops->set_data_path(cap);
>   	cap->ops->config(cap);
> @@ -916,7 +918,7 @@ static void rkisp1_cap_stream_enable(struct rkisp1_capture *cap)
>   	 * This's also required because the second FE maybe corrupt
>   	 * especially when run at 120fps.
>   	 */
> -	if (!other->is_streaming) {
> +	if (!has_self_path || !other->is_streaming) {
>   		/* force cfg update */
>   		rkisp1_write(rkisp1, RKISP1_CIF_MI_INIT,
>   			     RKISP1_CIF_MI_INIT_SOFT_UPD);
> @@ -1509,10 +1511,11 @@ rkisp1_capture_init(struct rkisp1_device *rkisp1, enum rkisp1_stream_id id)
>   
>   int rkisp1_capture_devs_register(struct rkisp1_device *rkisp1)
>   {
> +	unsigned int dev_count = rkisp1_path_count(rkisp1);
>   	unsigned int i;
>   	int ret;
>   
> -	for (i = 0; i < ARRAY_SIZE(rkisp1->capture_devs); i++) {
> +	for (i = 0; i < dev_count; i++) {
>   		struct rkisp1_capture *cap = &rkisp1->capture_devs[i];
>   
>   		rkisp1_capture_init(rkisp1, i);
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 6a811b7ef1b9..f7c251f79aa9 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -111,6 +111,7 @@ enum rkisp1_isp_pad {
>    *
>    * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
>    * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
> + * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
>    *
>    * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
>    * the driver to implement support for features present in some ISP versions
> @@ -119,6 +120,7 @@ enum rkisp1_isp_pad {
>   enum rkisp1_feature {
>   	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
>   	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
> +	RKISP1_FEATURE_SELF_PATH = BIT(2),
>   };
>   
>   #define rkisp1_has_feature(rkisp1, feature) \
> @@ -531,6 +533,19 @@ int rkisp1_cap_enum_mbus_codes(struct rkisp1_capture *cap,
>    */
>   const struct rkisp1_mbus_info *rkisp1_mbus_info_get_by_index(unsigned int index);
>   
> +/*
> + * rkisp1_path_count - Return the number of paths supported by the device
> + *
> + * Some devices only have a main path, while other device have both a main path
> + * and a self path. This function returns the number of paths that this device
> + * has, based on the feature flags. It should be used insted of checking
> + * ARRAY_SIZE of capture_devs/resizer_devs.
> + */
> +static inline unsigned int rkisp1_path_count(struct rkisp1_device *rkisp1)
> +{
> +	return rkisp1_has_feature(rkisp1, SELF_PATH) ? 2 : 1;
> +}
> +
>   /*
>    * rkisp1_sd_adjust_crop_rect - adjust a rectangle to fit into another rectangle.
>    *
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 44b753026ba2..106040c4181c 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -358,6 +358,7 @@ static const struct dev_pm_ops rkisp1_pm_ops = {
>   
>   static int rkisp1_create_links(struct rkisp1_device *rkisp1)
>   {
> +	unsigned int dev_count = rkisp1_path_count(rkisp1);
>   	unsigned int i;
>   	int ret;
>   
> @@ -373,7 +374,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
>   	}
>   
>   	/* create ISP->RSZ->CAP links */
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < dev_count; i++) {
>   		struct media_entity *resizer =
>   			&rkisp1->resizer_devs[i].sd.entity;
>   		struct media_entity *capture =
> @@ -505,7 +506,8 @@ static const struct rkisp1_info px30_isp_info = {
>   	.isrs = px30_isp_isrs,
>   	.isr_size = ARRAY_SIZE(px30_isp_isrs),
>   	.isp_ver = RKISP1_V12,
> -	.features = RKISP1_FEATURE_MIPI_CSI2,
> +	.features = RKISP1_FEATURE_MIPI_CSI2
> +		  | RKISP1_FEATURE_SELF_PATH,
>   };
>   
>   static const char * const rk3399_isp_clks[] = {
> @@ -524,7 +526,8 @@ static const struct rkisp1_info rk3399_isp_info = {
>   	.isrs = rk3399_isp_isrs,
>   	.isr_size = ARRAY_SIZE(rk3399_isp_isrs),
>   	.isp_ver = RKISP1_V10,
> -	.features = RKISP1_FEATURE_MIPI_CSI2,
> +	.features = RKISP1_FEATURE_MIPI_CSI2
> +		  | RKISP1_FEATURE_SELF_PATH,
>   };
>   
>   static const struct of_device_id rkisp1_of_match[] = {
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> index a8e377701302..dd77a31e6014 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> @@ -631,6 +631,7 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
>   	struct rkisp1_device *rkisp1 = rsz->rkisp1;
>   	struct rkisp1_capture *other = &rkisp1->capture_devs[rsz->id ^ 1];
>   	enum rkisp1_shadow_regs_when when = RKISP1_SHADOW_REGS_SYNC;
> +	bool has_self_path = rkisp1_has_feature(rkisp1, SELF_PATH);
>   	struct v4l2_subdev_state *sd_state;
>   
>   	if (!enable) {
> @@ -639,7 +640,7 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
>   		return 0;
>   	}
>   
> -	if (other->is_streaming)
> +	if (has_self_path && other->is_streaming)
>   		when = RKISP1_SHADOW_REGS_ASYNC;
>   
>   	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
> @@ -731,10 +732,11 @@ static int rkisp1_rsz_register(struct rkisp1_resizer *rsz)
>   
>   int rkisp1_resizer_devs_register(struct rkisp1_device *rkisp1)
>   {
> +	unsigned int dev_count = rkisp1_path_count(rkisp1);
>   	unsigned int i;
>   	int ret;
>   
> -	for (i = 0; i < ARRAY_SIZE(rkisp1->resizer_devs); i++) {
> +	for (i = 0; i < dev_count; i++) {
>   		struct rkisp1_resizer *rsz = &rkisp1->resizer_devs[i];
>   
>   		rsz->rkisp1 = rkisp1;


