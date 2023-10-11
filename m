Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB67C6141
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376550AbjJKXvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjJKXvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:51:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313EE90;
        Wed, 11 Oct 2023 16:51:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78C16F0C;
        Thu, 12 Oct 2023 01:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1697068299;
        bh=Hjxmx01sAc5bb5ChoLB88Vb82HFzXsjyo1hU8gbb9z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5IT3CkK20sQkBbc/hWtYM/veApf6DW1sLirSUUT/DjBug4rTtRhFMY/n7wt/Gr7V
         bghnrC+q+RMrgCwYcD/gsnPL8eb7I4Sxfhb58FqH5+sK+ImeH3icH89CVBoIYhYwc/
         jeHoUw/WWF00EM8sCDZZUYnpZ1YSvpNrhosszQrs=
Date:   Thu, 12 Oct 2023 02:51:49 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Florian Sylvestre <fsylvestre@baylibre.com>,
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
Message-ID: <20231011235149.GD5322@pendragon.ideasonboard.com>
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

Another comment.

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

> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
> new file mode 100644
> index 000000000000..902f2a391064
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
> @@ -0,0 +1,196 @@

[snip]

> +struct mtk_cam_dev_buffer {
> +	struct vb2_v4l2_buffer v4l2_buf;
> +	struct list_head list;
> +	dma_addr_t daddr;
> +	dma_addr_t fhaddr;
> +};

fhaddr is a dma_addr_t.

[snip]

> diff --git a/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
> new file mode 100644
> index 000000000000..f879726eacd8
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
> @@ -0,0 +1,781 @@

[snip]

> +static int mtk_cam_vb2_buf_prepare(struct vb2_buffer *vb)
> +{
> +	struct mtk_cam_video_device *vdev =
> +		vb2_queue_to_mtk_cam_video_device(vb->vb2_queue);
> +	struct mtk_cam_dev *cam = vb2_get_drv_priv(vb->vb2_queue);
> +	struct mtk_cam_dev_buffer *buf = to_mtk_cam_dev_buffer(vb);
> +	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
> +	u32 size;
> +	int i;
> +
> +	for (i = 0; i < vb->num_planes; i++) {
> +		size = fmt->plane_fmt[i].sizeimage;
> +		if (vb2_plane_size(vb, i) < size) {
> +			dev_err(cam->dev, "plane size is too small:%lu<%u\n",
> +				vb2_plane_size(vb, i), size);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	buf->v4l2_buf.field = V4L2_FIELD_NONE;
> +
> +	for (i = 0; i < vb->num_planes; i++) {
> +		size = fmt->plane_fmt[i].sizeimage;
> +		vb2_set_plane_payload(vb, i, size);
> +	}
> +
> +	if (buf->daddr == 0ULL) {
> +		buf->daddr = vb2_dma_contig_plane_dma_addr(vb, 0);
> +		if (cam->conf->frm_hdr_en)
> +			buf->fhaddr = vb2_dma_contig_plane_dma_addr(vb, 1);

Here you store the address of the second plane in fhaddr. This is
correct, but that address is then never used anywhere.

> +	}
> +
> +	return 0;
> +}

[snip]

> +static int mtk_cam_vb2_start_streaming(struct vb2_queue *vq,
> +				       unsigned int count)
> +{
> +	struct mtk_cam_dev *cam = vb2_get_drv_priv(vq);
> +	struct mtk_cam_dev_buffer *buf;
> +	struct mtk_cam_video_device *vdev =
> +		vb2_queue_to_mtk_cam_video_device(vq);
> +	struct device *dev = cam->dev;
> +	const struct v4l2_pix_format_mplane *fmt = &vdev->format;
> +	int ret;
> +	unsigned long flags = 0;
> +
> +	if (pm_runtime_get_sync(dev) < 0) {
> +		dev_err(dev, "failed to get pm_runtime\n");
> +		pm_runtime_put_autosuspend(dev);
> +		return -1;
> +	}
> +
> +	/* Enable CMOS and VF */
> +	mtk_cam_cmos_vf_enable(cam, true, vdev->fmtinfo->packed);
> +
> +	mutex_lock(&cam->op_lock);
> +
> +	ret = mtk_cam_verify_format(cam);
> +	if (ret < 0)
> +		goto fail_unlock;
> +
> +	/* Start streaming of the whole pipeline now*/
> +	if (!cam->pipeline.start_count) {
> +		ret = media_pipeline_start(vdev->vdev.entity.pads,
> +					   &cam->pipeline);
> +		if (ret) {
> +			dev_err(dev, "failed to start pipeline:%d\n", ret);
> +			goto fail_unlock;
> +		}
> +	}
> +
> +	/* Media links are fixed after media_pipeline_start */
> +	cam->stream_count++;
> +
> +	cam->sequence = (unsigned int)-1;
> +
> +	/* Stream on the sub-device */
> +	ret = v4l2_subdev_call(&cam->subdev, video, s_stream, 1);
> +	if (ret)
> +		goto fail_no_stream;
> +
> +	mutex_unlock(&cam->op_lock);
> +
> +	/* Create dummy buffer */
> +	cam->dummy_size = fmt->plane_fmt[0].sizeimage;
> +
> +	cam->dummy.fhaddr = (dma_addr_t)dma_alloc_coherent(cam->dev,
> +					       cam->dummy_size,
> +					       &cam->dummy.daddr, GFP_KERNEL);

And here, for the dummy buffer only, you use fhaddr to store a CPU
address. The cast to dma_addr_t is here only to silence the compiler
telling you you've made a mistake.

I recommend dropping the handling of the second plane (which should then
prompt you to review the usage of the frm_hdr_en flag), turning fhaddr
into a void *, and renaming to vaddr. You should also document the
mtk_cam_dev_buffer structure with kerneldoc to explain what the
different fields are about. It could be useful to document other
structures too.

> +	if (!cam->dummy.fhaddr) {
> +		dev_err(cam->dev, "can't allocate dummy buffer\n");
> +		ret = -ENOMEM;
> +		goto fail_no_buffer;
> +	}
> +
> +	/* update first buffer address */
> +
> +	/* added the buffer into the tracking list */
> +	spin_lock_irqsave(&cam->irqlock, flags);
> +	if (list_empty(&cam->buf_list)) {
> +		(*cam->hw_functions->mtk_cam_update_buffers_add)(cam, &cam->dummy);
> +		cam->is_dummy_used = true;
> +	} else {
> +		buf = list_first_entry_or_null(&cam->buf_list,
> +					       struct mtk_cam_dev_buffer,
> +					       list);
> +		(*cam->hw_functions->mtk_cam_update_buffers_add)(cam, buf);
> +		cam->is_dummy_used = false;
> +	}
> +	spin_unlock_irqrestore(&cam->irqlock, flags);
> +
> +	return 0;
> +
> +fail_no_buffer:
> +	mutex_lock(&cam->op_lock);
> +	v4l2_subdev_call(&cam->subdev, video, s_stream, 0);
> +fail_no_stream:
> +	cam->stream_count--;
> +	if (cam->stream_count == 0)
> +		media_pipeline_stop(vdev->vdev.entity.pads);
> +fail_unlock:
> +	mutex_unlock(&cam->op_lock);
> +	mtk_cam_vb2_return_all_buffers(cam, VB2_BUF_STATE_QUEUED);
> +
> +	return ret;
> +}

[snip]

-- 
Regards,

Laurent Pinchart
