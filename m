Return-Path: <linux-kernel+bounces-83113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958EC868E96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F5C2836A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4B13958B;
	Tue, 27 Feb 2024 11:17:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AB2A8C1;
	Tue, 27 Feb 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032658; cv=none; b=llV6EwFUTLmY/aXoaFbQrnah1BTLd33PtbNP7LZnd2tucpVRziLgp+7BLe+8FjWjZ2bqXG0um6Oc5dxQED02sljyQ19GNL+lIPRrptzZ1JklNeIc4suDftPkZswWOTeBk1rWKg2nmUOw/ckbtgvY9sCsP17LMi0XJujHSftb/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032658; c=relaxed/simple;
	bh=+49PE0rmpYPiVSZiMf8Gq+g+p6nE5io7rB40mfxy//o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLCtBBbp2gBlKomdPpcK2F2SCXNDFjG75sxRo9gLiWMX1pvJK4cXeopbPD6DmLPD7OZL2oLg+K+zCJiz/Vaz7uauZiKNoR1sd6vUgo6qZvAf71z7uHx3ciFZ7hSEXQnS/n5O/NOyJ5GjqspBEvuKsU6sRS9xPdwlvSlR2HjyGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F71C433C7;
	Tue, 27 Feb 2024 11:17:33 +0000 (UTC)
Message-ID: <c25638af-d40d-4dbc-a179-efb6f29c38aa@xs4all.nl>
Date: Tue, 27 Feb 2024 12:17:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: mediatek: vcodedc: Fix
 Wcast-function-type-strict warnings
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
 <20240226-fix-clang-warnings-v2-3-fa1bc931d17e@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240226-fix-clang-warnings-v2-3-fa1bc931d17e@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ricardo,

First of all, note the typo in theo subject line: vcodedc -> vcodec.

There is also a similar (but not identical!) patch from Arnd:

https://patchwork.linuxtv.org/project/linux-media/patch/20240224121059.1806691-1-arnd@kernel.org/

That patch and yours share the change to common/mtk_vcodec_fw_vpu.c but otherwise
they are different, which is a bit odd.

Can you take a look at Arnd's patch and see if you need to incorporate his changes
into your patch?

Regards,

	Hans

On 26/02/2024 18:32, Ricardo Ribalda wrote:
> Building with LLVM=1 throws the following warning:
> drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsigned int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
> 
> Constify the types to avoid the warning.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c          | 12 ++++++------
>  .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h    |  2 +-
>  .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 10 +---------
>  drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c |  2 +-
>  drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c |  2 +-
>  drivers/remoteproc/mtk_scp.c                                 |  4 ++--
>  include/linux/remoteproc/mtk_scp.h                           |  2 +-
>  include/linux/rpmsg/mtk_rpmsg.h                              |  2 +-
>  8 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
> index 49fc2e9d45dd5..c4f1c49b9d52a 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
> @@ -77,10 +77,10 @@ void mdp_vpu_shared_mem_free(struct mdp_vpu_dev *vpu)
>  		dma_free_wc(dev, vpu->config_size, vpu->config, vpu->config_addr);
>  }
>  
> -static void mdp_vpu_ipi_handle_init_ack(void *data, unsigned int len,
> +static void mdp_vpu_ipi_handle_init_ack(const void *data, unsigned int len,
>  					void *priv)
>  {
> -	struct mdp_ipi_init_msg *msg = (struct mdp_ipi_init_msg *)data;
> +	const struct mdp_ipi_init_msg *msg = data;
>  	struct mdp_vpu_dev *vpu =
>  		(struct mdp_vpu_dev *)(unsigned long)msg->drv_data;
>  
> @@ -91,10 +91,10 @@ static void mdp_vpu_ipi_handle_init_ack(void *data, unsigned int len,
>  	complete(&vpu->ipi_acked);
>  }
>  
> -static void mdp_vpu_ipi_handle_deinit_ack(void *data, unsigned int len,
> +static void mdp_vpu_ipi_handle_deinit_ack(const void *data, unsigned int len,
>  					  void *priv)
>  {
> -	struct mdp_ipi_deinit_msg *msg = (struct mdp_ipi_deinit_msg *)data;
> +	const struct mdp_ipi_deinit_msg *msg = data;
>  	struct mdp_vpu_dev *vpu =
>  		(struct mdp_vpu_dev *)(unsigned long)msg->drv_data;
>  
> @@ -102,10 +102,10 @@ static void mdp_vpu_ipi_handle_deinit_ack(void *data, unsigned int len,
>  	complete(&vpu->ipi_acked);
>  }
>  
> -static void mdp_vpu_ipi_handle_frame_ack(void *data, unsigned int len,
> +static void mdp_vpu_ipi_handle_frame_ack(const void *data, unsigned int len,
>  					 void *priv)
>  {
> -	struct img_sw_addr *addr = (struct img_sw_addr *)data;
> +	const struct img_sw_addr *addr = data;
>  	struct img_ipi_frameparam *param =
>  		(struct img_ipi_frameparam *)(unsigned long)addr->va;
>  	struct mdp_vpu_dev *vpu =
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> index 300363a40158c..2561b99c95871 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
> @@ -23,7 +23,7 @@ enum mtk_vcodec_fw_use {
>  
>  struct mtk_vcodec_fw;
>  
> -typedef void (*mtk_vcodec_ipi_handler) (void *data,
> +typedef void (*mtk_vcodec_ipi_handler) (const void *data,
>  	unsigned int len, void *priv);
>  
>  struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index 9f6e4b59455da..4c34344dc7dcb 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -29,15 +29,7 @@ static int mtk_vcodec_vpu_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
>  					   mtk_vcodec_ipi_handler handler,
>  					   const char *name, void *priv)
>  {
> -	/*
> -	 * The handler we receive takes a void * as its first argument. We
> -	 * cannot change this because it needs to be passed down to the rproc
> -	 * subsystem when SCP is used. VPU takes a const argument, which is
> -	 * more constrained, so the conversion below is safe.
> -	 */
> -	ipi_handler_t handler_const = (ipi_handler_t)handler;
> -
> -	return vpu_ipi_register(fw->pdev, id, handler_const, name, priv);
> +	return vpu_ipi_register(fw->pdev, id, handler, name, priv);
>  }
>  
>  static int mtk_vcodec_vpu_ipi_send(struct mtk_vcodec_fw *fw, int id, void *buf,
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> index 82e57ae983d55..a840dd2a48d0e 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> @@ -97,7 +97,7 @@ static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec_dev *dec_dev, struct vde
>   * This function runs in interrupt context and it means there's an IPI MSG
>   * from VPU.
>   */
> -static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv)
> +static void vpu_dec_ipi_handler(const void *data, unsigned int len, void *priv)
>  {
>  	struct mtk_vcodec_dec_dev *dec_dev;
>  	const struct vdec_vpu_ipi_ack *msg = data;
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> index 84ad1cc6ad171..ea0c4a281d1a1 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> @@ -57,7 +57,7 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc_dev *enc_dev, struct ven
>  	return ret;
>  }
>  
> -static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv)
> +static void vpu_enc_ipi_handler(const void *data, unsigned int len, void *priv)
>  {
>  	struct mtk_vcodec_enc_dev *enc_dev;
>  	const struct venc_vpu_ipi_msg_common *msg = data;
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index a35409eda0cf2..b508136b416a8 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -78,10 +78,10 @@ static void scp_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
>  		rproc_report_crash(scp_node->rproc, RPROC_WATCHDOG);
>  }
>  
> -static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
> +static void scp_init_ipi_handler(const void *data, unsigned int len, void *priv)
>  {
>  	struct mtk_scp *scp = priv;
> -	struct scp_run *run = data;
> +	const struct scp_run *run = data;
>  
>  	scp->run.signaled = run->signaled;
>  	strscpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
> diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
> index 7c2b7cc9fe6c1..84e579940b8e5 100644
> --- a/include/linux/remoteproc/mtk_scp.h
> +++ b/include/linux/remoteproc/mtk_scp.h
> @@ -8,7 +8,7 @@
>  
>  #include <linux/platform_device.h>
>  
> -typedef void (*scp_ipi_handler_t) (void *data,
> +typedef void (*scp_ipi_handler_t) (const void *data,
>  				   unsigned int len,
>  				   void *priv);
>  struct mtk_scp;
> diff --git a/include/linux/rpmsg/mtk_rpmsg.h b/include/linux/rpmsg/mtk_rpmsg.h
> index 363b60178040b..9d67507471fba 100644
> --- a/include/linux/rpmsg/mtk_rpmsg.h
> +++ b/include/linux/rpmsg/mtk_rpmsg.h
> @@ -9,7 +9,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  
> -typedef void (*ipi_handler_t)(void *data, unsigned int len, void *priv);
> +typedef void (*ipi_handler_t)(const void *data, unsigned int len, void *priv);
>  
>  /*
>   * struct mtk_rpmsg_info - IPI functions tied to the rpmsg device.
> 


