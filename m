Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C377C611A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376546AbjJKXbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKXbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:31:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66CCA9;
        Wed, 11 Oct 2023 16:31:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66363F0C;
        Thu, 12 Oct 2023 01:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1697067093;
        bh=veZu4nip6XJTOC2Cjjm0FeHRqsbH4ZSamFt2SVxn1/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxODQ9ixtia+33hvE04Ke239gnbxGcjPmShfBu5SLFPfDcmN1VwerZ4pNmq2ug3P1
         lom9oF5czzPK0t0mcWsN2Y7pkdttFgunvai8bBtiSfEFoxbmo2DwGrkQ6I22EqIY87
         SDhPax5Q5dg/K6OqbrN0eYtCmGJfbyQZMC3zSPG0=
Date:   Thu, 12 Oct 2023 02:31:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 4/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Message-ID: <20231011233143.GA2257@pendragon.ideasonboard.com>
References: <20230807094940.329165-1-jstephan@baylibre.com>
 <20230807094940.329165-5-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807094940.329165-5-jstephan@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

Thank you for the patch.

A first review comment, for an issue I've noticed while testing.

On Mon, Aug 07, 2023 at 11:48:13AM +0200, Julien Stephan wrote:
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
> 
> This driver provides a path to bypass the SoC ISP so that image data
> coming from the SENINF can go directly into memory without any image
> processing. This allows the use of an external ISP.
> 
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  MAINTAINERS                                   |   1 +
>  .../platform/mediatek/isp/isp_30/Kconfig      |  19 +
>  .../platform/mediatek/isp/isp_30/Makefile     |   1 +
>  .../mediatek/isp/isp_30/camsv/Makefile        |   7 +
>  .../mediatek/isp/isp_30/camsv/mtk_camsv.c     | 328 ++++++++
>  .../mediatek/isp/isp_30/camsv/mtk_camsv.h     | 196 +++++
>  .../isp/isp_30/camsv/mtk_camsv30_hw.c         | 432 ++++++++++
>  .../isp/isp_30/camsv/mtk_camsv30_regs.h       |  60 ++
>  .../isp/isp_30/camsv/mtk_camsv_video.c        | 781 ++++++++++++++++++
>  9 files changed, 1825 insertions(+)
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c

[snip]

> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
> new file mode 100644
> index 000000000000..bdf878460354
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
> @@ -0,0 +1,432 @@

[snip]

> +static void mtk_camsv30_setup(struct mtk_cam_dev *cam_dev, u32 w, u32 h,
> +			      u32 bpl, u32 mbus_fmt)
> +{
> +	const struct mtk_cam_conf *conf = cam_dev->conf;
> +	u32 int_en = INT_ST_MASK_CAMSV;
> +	u32 tmp;
> +	struct mtk_cam_sparams sparams;
> +
> +	fmt_to_sparams(mbus_fmt, &sparams);
> +
> +	spin_lock(&cam_dev->irqlock);

This isn't right, for multiple reasons.

First, the lock is taken in IRQ context, so you need to disable IRQs
here, or you'll risk deadlocking. spin_lock_irqsave() is the safe
wildcard solution, but if this function is guaranteed to be called with
interrupts enabled, you can also use spin_lock_irq(). This problem is
caught by lockdep, didn't you test the driver with lockdep enabled ? If
not, please enable it for v4.

Then, pm_runtime_get_sync() may sleep, so you should take the lock
after.

Next, mtk_camsv30_setup() is called by mtk_camsv30_runtime_resume()
below, right after calling spin_lock_irqsave() on the same lock. This
has quite clearly not been tested. Please make sure to test system
suspend/resume while streaming for v4.

Finally, does this function really require taking the irqlock ? It looks
like locking should be revisited in this driver.

> +
> +	if (pm_runtime_get_sync(cam_dev->dev) < 0) {

When pm_runtime_get_sync() fails you need to call pm_runtime_put(). A
better option is to use pm_runtime_resume_and_get().

> +		dev_err(cam_dev->dev, "failed to get pm_runtime\n");
> +		spin_unlock(&cam_dev->irqlock);
> +		return;
> +	}
> +
> +	writel(conf->tg_sen_mode, cam_dev->regs_tg + CAMSV_TG_SEN_MODE);
> +
> +	writel((w * sparams.w_factor) << 16U, cam_dev->regs_tg + CAMSV_TG_SEN_GRAB_PXL);
> +
> +	writel(h << 16U, cam_dev->regs_tg + CAMSV_TG_SEN_GRAB_LIN);
> +
> +	/* YUV_U2S_DIS: disable YUV sensor unsigned to signed */
> +	writel(0x1000U, cam_dev->regs_tg + CAMSV_TG_PATH_CFG);
> +
> +	/* Reset cam */
> +	writel(CAMSV_SW_RST, cam_dev->regs + CAMSV_SW_CTL);
> +	writel(0x0U, cam_dev->regs + CAMSV_SW_CTL);
> +	writel(CAMSV_IMGO_RST_TRIG, cam_dev->regs + CAMSV_SW_CTL);
> +
> +	readl_poll_timeout(cam_dev->regs + CAMSV_SW_CTL, tmp,
> +			(tmp == (CAMSV_IMGO_RST_TRIG | CAMSV_IMGO_RST_ST)), 10, 200);
> +
> +	writel(0x0U, cam_dev->regs + CAMSV_SW_CTL);
> +
> +	writel(int_en, cam_dev->regs + CAMSV_INT_EN);
> +
> +	writel(conf->module_en | sparams.module_en_pak,
> +	      cam_dev->regs + CAMSV_MODULE_EN);
> +	writel(sparams.fmt_sel, cam_dev->regs + CAMSV_FMT_SEL);
> +	writel(sparams.pak, cam_dev->regs + CAMSV_PAK);
> +
> +	writel(bpl - 1U, cam_dev->regs_img0 + CAMSV_IMGO_SV_XSIZE);
> +	writel(h - 1U, cam_dev->regs_img0 + CAMSV_IMGO_SV_YSIZE);
> +
> +	writel(sparams.imgo_stride | bpl, cam_dev->regs_img0 + CAMSV_IMGO_SV_STRIDE);
> +
> +	writel(conf->imgo_con, cam_dev->regs_img0 + CAMSV_IMGO_SV_CON);
> +	writel(conf->imgo_con2, cam_dev->regs_img0 + CAMSV_IMGO_SV_CON2);
> +
> +	/* CMOS_EN first */
> +	writel(readl(cam_dev->regs_tg + CAMSV_TG_SEN_MODE) | CAMSV_TG_SEN_MODE_CMOS_EN,
> +			cam_dev->regs_tg + CAMSV_TG_SEN_MODE);
> +
> +	/* finally, CAMSV_MODULE_EN : IMGO_EN */
> +	writel(readl(cam_dev->regs + CAMSV_MODULE_EN) | CAMSV_MODULE_EN_IMGO_EN,
> +		    cam_dev->regs + CAMSV_MODULE_EN);
> +
> +	pm_runtime_put_autosuspend(cam_dev->dev);

This will cut the power off after a delay, possibly loosing state. If
userspace requests buffers and then starts streaming only later, you
risk issues.

> +	spin_unlock(&cam_dev->irqlock);
> +}
> +
> +static irqreturn_t isp_irq_camsv30(int irq, void *data)
> +{
> +	struct mtk_cam_dev *cam_dev = (struct mtk_cam_dev *)data;
> +	struct mtk_cam_dev_buffer *buf;
> +	unsigned long flags = 0;
> +	unsigned int irq_status;
> +
> +	spin_lock_irqsave(&cam_dev->irqlock, flags);
> +
> +	irq_status = readl(cam_dev->regs + CAMSV_INT_STATUS);
> +
> +	if (irq_status & INT_ST_MASK_CAMSV_ERR) {
> +		dev_err(cam_dev->dev, "irq error 0x%x\n",
> +			(unsigned int)(irq_status & INT_ST_MASK_CAMSV_ERR));
> +	}
> +
> +	/* De-queue frame */
> +	if (irq_status & CAMSV_IRQ_PASS1_DON) {
> +		cam_dev->sequence++;
> +
> +		if (!cam_dev->is_dummy_used) {
> +			buf = list_first_entry_or_null(&cam_dev->buf_list,
> +						       struct mtk_cam_dev_buffer,
> +						       list);
> +			if (buf) {
> +				buf->v4l2_buf.sequence = cam_dev->sequence;
> +				buf->v4l2_buf.vb2_buf.timestamp = ktime_get_ns();
> +				vb2_buffer_done(&buf->v4l2_buf.vb2_buf,
> +						VB2_BUF_STATE_DONE);
> +				list_del(&buf->list);
> +			}
> +		}
> +
> +		if (list_empty(&cam_dev->buf_list)) {
> +			mtk_camsv30_update_buffers_add(cam_dev, &cam_dev->dummy);
> +			cam_dev->is_dummy_used = true;
> +		} else {
> +			buf = list_first_entry_or_null(&cam_dev->buf_list,
> +						       struct mtk_cam_dev_buffer,
> +						       list);
> +			mtk_camsv30_update_buffers_add(cam_dev, buf);
> +			cam_dev->is_dummy_used = false;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&cam_dev->irqlock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_camsv30_runtime_suspend(struct device *dev)
> +{
> +	struct mtk_cam_dev *cam_dev = dev_get_drvdata(dev);
> +	struct vb2_queue *vbq = &cam_dev->vdev.vbq;
> +
> +	if (vb2_is_streaming(vbq)) {
> +		mutex_lock(&cam_dev->op_lock);
> +		v4l2_subdev_call(&cam_dev->subdev, video, s_stream, 0);
> +		mutex_unlock(&cam_dev->op_lock);
> +	}
> +
> +	clk_bulk_disable_unprepare(cam_dev->num_clks, cam_dev->clks);
> +
> +	return 0;
> +}
> +
> +static int mtk_camsv30_runtime_resume(struct device *dev)
> +{
> +	struct mtk_cam_dev *cam_dev = dev_get_drvdata(dev);
> +	struct mtk_cam_video_device *vdev = &cam_dev->vdev;
> +	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
> +	struct vb2_queue *vbq = &vdev->vbq;
> +	struct mtk_cam_dev_buffer *buf, *buf_prev;
> +	int ret;
> +	unsigned long flags = 0;
> +
> +	ret = clk_bulk_prepare_enable(cam_dev->num_clks, cam_dev->clks);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock:%d\n", ret);
> +		return ret;
> +	}
> +
> +	if (vb2_is_streaming(vbq)) {
> +		spin_lock_irqsave(&cam_dev->irqlock, flags);
> +
> +		mtk_camsv30_setup(cam_dev, fmt->width, fmt->height,
> +				  fmt->plane_fmt[0].bytesperline, vdev->fmtinfo->code);
> +
> +		buf = list_first_entry_or_null(&cam_dev->buf_list,
> +					       struct mtk_cam_dev_buffer,
> +					       list);
> +		if (buf) {
> +			mtk_camsv30_update_buffers_add(cam_dev, buf);
> +			cam_dev->is_dummy_used = false;
> +		} else {
> +			mtk_camsv30_update_buffers_add(cam_dev, &cam_dev->dummy);
> +			cam_dev->is_dummy_used = true;
> +		}
> +
> +		mtk_camsv30_cmos_vf_hw_enable(cam_dev, vdev->fmtinfo->packed);
> +
> +		spin_unlock_irqrestore(&cam_dev->irqlock, flags);
> +
> +		/* Stream on the sub-device */
> +		mutex_lock(&cam_dev->op_lock);
> +		ret = v4l2_subdev_call(&cam_dev->subdev, video, s_stream, 1);
> +
> +		if (ret) {
> +			cam_dev->stream_count--;
> +			if (cam_dev->stream_count == 0)
> +				media_pipeline_stop(vdev->vdev.entity.pads);
> +		}
> +		mutex_unlock(&cam_dev->op_lock);
> +
> +		if (ret)
> +			goto fail_no_stream;
> +	}
> +
> +	return 0;
> +
> +fail_no_stream:
> +	spin_lock_irqsave(&cam_dev->irqlock, flags);
> +	list_for_each_entry_safe(buf, buf_prev, &cam_dev->buf_list, list) {
> +		buf->daddr = 0ULL;
> +		list_del(&buf->list);
> +		vb2_buffer_done(&buf->v4l2_buf.vb2_buf, VB2_BUF_STATE_ERROR);
> +	}
> +	spin_unlock_irqrestore(&cam_dev->irqlock, flags);
> +	return ret;
> +}

[snip]

> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
> new file mode 100644
> index 000000000000..f879726eacd8
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
> @@ -0,0 +1,781 @@

[snip]

> +/* -----------------------------------------------------------------------------
> + * VB2 Queue Operations
> + */
> +
> +static int mtk_cam_vb2_queue_setup(struct vb2_queue *vq,
> +				   unsigned int *num_buffers,
> +				   unsigned int *num_planes,
> +				   unsigned int sizes[],
> +				   struct device *alloc_devs[])
> +{
> +	struct mtk_cam_video_device *vdev =
> +		vb2_queue_to_mtk_cam_video_device(vq);
> +	unsigned int max_buffer_count = vdev->desc->max_buf_count;
> +	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
> +	struct mtk_cam_dev *cam = vb2_get_drv_priv(vq);
> +	unsigned int size;
> +	unsigned int np_conf;
> +	unsigned int i;
> +
> +	/* Check the limitation of buffer size */
> +	if (max_buffer_count)
> +		*num_buffers = clamp_val(*num_buffers, 1, max_buffer_count);
> +
> +	size = fmt->plane_fmt[0].sizeimage;
> +	/* Add for q.create_bufs with fmt.g_sizeimage(p) / 2 test */
> +
> +	np_conf = cam->conf->frm_hdr_en ? 2 : 1;
> +
> +	if (*num_planes == 0) {
> +		*num_planes = np_conf;
> +		for (i = 0; i < *num_planes; ++i)
> +			sizes[i] = size;
> +	} else if (*num_planes != np_conf || sizes[0] < size) {
> +		return -EINVAL;
> +	}
> +
> +	(*cam->hw_functions->mtk_cam_setup)(cam, fmt->width, fmt->height,
> +			fmt->plane_fmt[0].bytesperline, vdev->fmtinfo->code);

This isn't the right time to call this. The hardware should be
programmed when starting streaming, not when allocating buffers.

> +
> +	return 0;
> +}

[snip]

-- 
Regards,

Laurent Pinchart
