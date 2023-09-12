Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3179D4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjILPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjILPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:18:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D0D12E;
        Tue, 12 Sep 2023 08:18:02 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5CF1660731E;
        Tue, 12 Sep 2023 16:17:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694531881;
        bh=Hx1lpYS6F6d56eE0iklgSTbFgFAyo1rdh+QYd7bka3s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QjwEmmgwW6dU+ZMQqDaA/HiWw4ynMw2LgpaZuRPcohd4tA2tBjVsoOj99YbDOk1pK
         j+C939ll4Eisaj6gfj2VOD0PU6EbzFkSL9HyyX1MHKqF65CoXkhYPOlRazvPrgny0S
         wA0M9TGqS4M67URNwkk04V1vG4G27kmSPv0wDvCrYu4ymGKx5XB3TNdRD52P6DVqf/
         A7Y0qM7lzY3++ACYMR47Hnwq1BPmFFAoMYM3xU42kLUDKKovk8cwYQtfQiCHL/nlBy
         Wc9sW4ptmOa54lN7XgTpLpzDSswPaksbxqpTr7NWYnJgnLpDQKiinKxOq0M8PeGyKm
         ruayIiqsBGTng==
Message-ID: <44b9c67df85414baafc3bdbcc3e39dd5f4cbdec6.camel@collabora.com>
Subject: Re: [PATCH 11/14] media: medkatek: vcodec: covert secure fd to
 secure handle
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong =?UTF-8?Q?=28=E8=91=A3=E4=BA=91=E9=A3=9E=29?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Sep 2023 11:17:50 -0400
In-Reply-To: <2c4fe325d8e541749a84ad30774129321e169151.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-12-yunfei.dong@mediatek.com>
         <4867b91b3bbc9267982dd80ad79f3e73a7bab6fc.camel@collabora.com>
         <2c4fe325d8e541749a84ad30774129321e169151.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 septembre 2023 =C3=A0 01:55 +0000, Yunfei Dong (=E8=91=A3=E4=BA=
=91=E9=A3=9E) a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> Thanks for your advice.
> On Mon, 2023-09-11 at 11:47 -0400, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=A9crit=
 :
> > > User driver will fill or parse data in optee-os with secure handle,
> > > need to covert secure fd to secure handle in kernel.
> >=20
> > A major rework of the wording is needed in this patchset, to fix the
> > obvious
> > typos like covert->convert,=20
> I will fix in next patch.
> > but also to stop calling dmabuf allocated from
> > secure heap, secure fd,=20
> Could you please help to explain it detail?
> Whether you meaning I can't
> call dma_buf_get/dma_buf_attach functions directly?

This is in regard to comments in the code. I'd suggest to use secure dmabuf=
 fd
rather then just "secure fd", which is ambiguous.

>=20
> > its not precise enough to understand what this patch is
> > going to be about.
> >=20
> This patch is used to covert secure fd to secure handle.
> User space will get a secure fd using dma interface to allocate secure
> memory, but need to covert fd to handle in order to fill es
> buffer(output queue) in optee-os. I will write the commit message
> detail.

When you say "secure fd", it gives readers the impression you have introduc=
ed a
new concept of memory object in the linux kernel. In fact, these are dmabuf
object. My suggestion is to rework the accuracy of the naming and wording.

>=20
> Best Regards,
> Yunfei Dong
> > >=20
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > ---
> > >  .../vcodec/decoder/mtk_vcodec_dec_drv.c       |  1 +
> > >  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 54
> > > ++++++++++++++++++-
> > >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  5 ++
> > >  include/uapi/linux/v4l2-controls.h            |  4 ++
> > >  4 files changed, 62 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .c
> > > index 0a89ce452ac3..64e006820f43 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .c
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .c
> > > @@ -571,3 +571,4 @@ module_platform_driver(mtk_vcodec_dec_driver);
> > > =20
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_DESCRIPTION("Mediatek video codec V4L2 decoder driver");
> > > +MODULE_IMPORT_NS(DMA_BUF);
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > index 2ea517883a86..d2b09ce9f1cf 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > @@ -426,6 +426,46 @@ static int mtk_vcodec_get_pic_info(struct
> > > mtk_vcodec_dec_ctx *ctx)
> > >  	return ret;
> > >  }
> > > =20
> > > +static int mtk_dma_contig_get_secure_handle(struct
> > > mtk_vcodec_dec_ctx *ctx, int fd)
> > > +{
> > > +	int secure_handle =3D 0;
> > > +	struct dma_buf *buf;
> > > +	struct dma_buf_attachment *dba;
> > > +	struct sg_table *sgt;
> > > +	struct device *dev =3D &ctx->dev->plat_dev->dev;
> > > +
> > > +	buf =3D dma_buf_get(fd);
> > > +	if (IS_ERR(buf)) {
> > > +		mtk_v4l2_vdec_err(ctx, "dma_buf_get fail fd:%d", fd);
> > > +		return 0;
> > > +	}
> > > +
> > > +	dba =3D dma_buf_attach(buf, dev);
> > > +	if (IS_ERR(dba)) {
> > > +		mtk_v4l2_vdec_err(ctx, "dma_buf_attach fail fd:%d",
> > > fd);
> > > +		goto err_attach;
> > > +	}
> > > +
> > > +	sgt =3D dma_buf_map_attachment(dba, DMA_BIDIRECTIONAL);
> > > +	if (IS_ERR(sgt)) {
> > > +		mtk_v4l2_vdec_err(ctx, "dma_buf_map_attachment fail
> > > fd:%d", fd);
> > > +		goto err_map;
> > > +	}
> > > +	secure_handle =3D sg_dma_address(sgt->sgl);
> > > +
> > > +	dma_buf_unmap_attachment(dba, sgt, DMA_BIDIRECTIONAL);
> > > +	dma_buf_detach(buf, dba);
> > > +	dma_buf_put(buf);
> > > +
> > > +	return secure_handle;
> > > +err_map:
> > > +	dma_buf_detach(buf, dba);
> > > +err_attach:
> > > +	dma_buf_put(buf);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
> > >  {
> > >  	struct mtk_vcodec_dec_ctx *ctx =3D ctrl_to_dec_ctx(ctrl);
> > > @@ -436,7 +476,7 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
> > > *ctrl)
> > >  	struct v4l2_ctrl *hdr_ctrl;
> > >  	const struct mtk_vcodec_dec_pdata *dec_pdata =3D ctx->dev-
> > > > vdec_pdata;
> > >  	const struct mtk_video_fmt *fmt;
> > > -	int i =3D 0, ret =3D 0;
> > > +	int i =3D 0, ret =3D 0, sec_fd;
> > > =20
> > >  	hdr_ctrl =3D ctrl;
> > >  	if (!hdr_ctrl || !hdr_ctrl->p_new.p)
> > > @@ -489,6 +529,12 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
> > > *ctrl)
> > >  			return -EINVAL;
> > >  		}
> > >  		break;
> > > +	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:
> > > +		sec_fd =3D ctrl->val;
> > > +
> > > +		ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctrl-
> > > > val);
> > > +		mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D>
> > > 0x%x", sec_fd, ctrl->val);
> > > +		break;
> > >  	default:
> > >  		mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl
> > > id: 0x%x\n", hdr_ctrl->id);
> > >  		return ret;
> > > @@ -525,8 +571,9 @@ static const struct v4l2_ctrl_ops
> > > mtk_vcodec_dec_ctrl_ops =3D {
> > >  static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx
> > > *ctx)
> > >  {
> > >  	unsigned int i;
> > > +	struct v4l2_ctrl *ctrl;
> > > =20
> > > -	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS);
> > > +	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> > >  	if (ctx->ctrl_hdl.error) {
> > >  		mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init
> > > failed\n");
> > >  		return ctx->ctrl_hdl.error;
> > > @@ -543,6 +590,9 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> > > mtk_vcodec_dec_ctx *ctx)
> > >  		}
> > >  	}
> > > =20
> > > +	ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> > > &mtk_vcodec_dec_ctrl_ops,
> > > +				 V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE,
> > > 0, 65535, 1, 0);
> > > +
> > >  	v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> > > =20
> > >  	return 0;
> > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > index 8696eb1cdd61..d8cf01f76aab 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > @@ -1041,6 +1041,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > >  	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:	return
> > > "HEVC Size of Length Field";
> > >  	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return
> > > "Reference Frames for a P-Frame";
> > >  	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		ret
> > > urn "Prepend SPS and PPS to IDR";
> > > +	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:		return
> > > "MediaTek Decoder get secure handle";
> > > =20
> > >  	/* AV1 controls */
> > >  	case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:			ret
> > > urn "AV1 Profile";
> > > @@ -1437,6 +1438,10 @@ void v4l2_ctrl_fill(u32 id, const char
> > > **name, enum v4l2_ctrl_type *type,
> > >  	case V4L2_CID_MPEG_VIDEO_VPX_NUM_REF_FRAMES:
> > >  		*type =3D V4L2_CTRL_TYPE_INTEGER_MENU;
> > >  		break;
> > > +	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:
> > > +		*type =3D V4L2_CTRL_TYPE_INTEGER;
> > > +		*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> > > +		break;
> > >  	case V4L2_CID_USER_CLASS:
> > >  	case V4L2_CID_CAMERA_CLASS:
> > >  	case V4L2_CID_CODEC_CLASS:
> > > diff --git a/include/uapi/linux/v4l2-controls.h
> > > b/include/uapi/linux/v4l2-controls.h
> > > index c3604a0a3e30..7b3694985366 100644
> > > --- a/include/uapi/linux/v4l2-controls.h
> > > +++ b/include/uapi/linux/v4l2-controls.h
> > > @@ -954,6 +954,10 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
> > >  #define V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC	=09
> > > (V4L2_CID_CODEC_MFC51_BASE+53)
> > >  #define V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P	=09
> > > (V4L2_CID_CODEC_MFC51_BASE+54)
> > > =20
> > > +/*  MPEG-class control IDs specific to the MediaTek Decoder driver
> > > as defined by V4L2 */
> > > +#define V4L2_CID_MPEG_MTK_BASE			(V4L2_CTRL_CLAS
> > > S_CODEC | 0x2000)
> > > +#define V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE	(V4L2_CID_MPEG_
> > > MTK_BASE+8)
> > > +
> > >  /*  Camera class control IDs */
> > > =20
> > >  #define V4L2_CID_CAMERA_CLASS_BASE	(V4L2_CTRL_CLASS_CAMERA |
> > > 0x900)
> >=20
> >=20

