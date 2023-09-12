Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CE79D4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjILPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjILPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:20:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19A10DD;
        Tue, 12 Sep 2023 08:19:59 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 55785660731E;
        Tue, 12 Sep 2023 16:19:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694531998;
        bh=UZbCv99LRYKxLgbkqaaqejLJxYvEBsUqCHcB/QV621E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ajxj/VPvnU1uOPa/+UcO+p+n0/XAeDpiX3jedUX8xezygJG6TGLVMJl1Qx9I6SX2J
         28mcAYh1jqVUmGlkFb3Q6Qo+/EkjNnULJgSJwTVZ2HAw4e5XXgEq+VzEPl1b9j88GF
         ulCWtYe2iCDu/TdRy+3Wk+H+pB5e9cA+UKBMiKMBDeukwPVGywcC+XWRNoLkkIN8ML
         pg/+LCs0pvknCwF3MilvnpWgCB7fugTkwAMTreyNNvsUBJpy/C19ukvg8qkbH++XHu
         PvVdtmGpFsZM86+5CZi8KLYdp8M7CK0sC3v0ycmKOCgIeefhTSkowDw9INsulbFzgm
         IWftApNPuXjGQ==
Message-ID: <4c8c43775c3c691bdc3724b588fbeba6bee66347.camel@collabora.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
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
Date:   Tue, 12 Sep 2023 11:19:48 -0400
In-Reply-To: <5c2ec70c8c346e27b7ddfef56df50bed06d26a5e.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
         <5c2ec70c8c346e27b7ddfef56df50bed06d26a5e.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 septembre 2023 =C3=A0 01:48 +0000, Yunfei Dong (=E8=91=A3=E4=BA=
=91=E9=A3=9E) a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> Thanks for your advice.
>=20
> On Mon, 2023-09-11 at 11:54 -0400, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=A9crit=
 :
> > > Setting secure mode flag to kernel when trying to play secure
> > > video,
> > > then decoder driver will initialize tee related interface to
> > > support
> > > svp.
> >=20
> >=20
> > This is not what the patch is doing, please rework. This patch is an
> > vendor API
> > addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should not
> > have to
> > read your patch to understand this.
> >=20
> I don't know your meaning clearly. Whether I need to add one new patch
> to add the definition of V4L2_CID_MPEG_MTK_SET_SECURE_MODE? Than the
> driver calling it to set secure mode?

I'm commenting next to your commit message. The commit message is saying
something that does not represent what the patch is actually doing, please
rewrite your commit message according to good practices.

>=20
> Best Regards,
> Yunfei Dong
>=20
> > >=20
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > ---
> > >  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
> > > ++++++++++++++-
> > >  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
> > >  include/uapi/linux/v4l2-controls.h                |  1 +
> > >  3 files changed, 20 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > index d2b09ce9f1cf..a981178c25d9 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta
> > > teless.c
> > > @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
> > > *ctrl)
> > >  		ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctrl-
> > > > val);
> > >  		mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D>
> > > 0x%x", sec_fd, ctrl->val);
> > >  		break;
> > > +	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >=20
> > Stepping back a little and focusing on the API, what makes your
> > driver so
> > special that it should be the only one having a "secure mode" ? We
> > are touching
> > in gap in the media pipeline in Linux, and this should come with
> > consideration
> > of the global API.
> >=20
> > Why is this API better then let's say Google Android one, were they
> > expose 2
> > device nodes in their fork of the MFC driver (a secure and a non
> > secure one) ?
> >=20
> > regards,
> > Nicolas
> >=20
> > p.s. you forgot to document your control in the RST doc, please do in
> > following
> > release.
> >=20
> > > +		ctx->is_svp_mode =3D ctrl->val;
> > > +
> > > +		if (ctx->is_svp_mode) {
> > > +			ret =3D mtk_vcodec_dec_optee_open(ctx->dev-
> > > > optee_private);
> > > +			if (ret)
> > > +				mtk_v4l2_vdec_err(ctx, "open secure
> > > mode failed.");
> > > +			else
> > > +				mtk_v4l2_vdec_dbg(3, ctx, "decoder in
> > > secure mode: %d", ctrl->val);
> > > +		}
> > > +		break;
> > >  	default:
> > >  		mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl
> > > id: 0x%x\n", hdr_ctrl->id);
> > >  		return ret;
> > > @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> > > mtk_vcodec_dec_ctx *ctx)
> > >  	unsigned int i;
> > >  	struct v4l2_ctrl *ctrl;
> > > =20
> > > -	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> > > +	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
> > >  	if (ctx->ctrl_hdl.error) {
> > >  		mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init
> > > failed\n");
> > >  		return ctx->ctrl_hdl.error;
> > > @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> > > mtk_vcodec_dec_ctx *ctx)
> > > =20
> > >  	ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> > > &mtk_vcodec_dec_ctrl_ops,
> > >  				 V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE,
> > > 0, 65535, 1, 0);
> > > +	ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> > > &mtk_vcodec_dec_ctrl_ops,
> > > +				 V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0,
> > > 65535, 1, 0);
> > > =20
> > >  	v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> > > =20
> > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > index d8cf01f76aab..a507045a3f30 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > > @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> > >  	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return
> > > "Reference Frames for a P-Frame";
> > >  	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		ret
> > > urn "Prepend SPS and PPS to IDR";
> > >  	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:		return
> > > "MediaTek Decoder get secure handle";
> > > +	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:			ret
> > > urn "MediaTek Decoder set secure mode";
> > > =20
> > >  	/* AV1 controls */
> > >  	case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:			ret
> > > urn "AV1 Profile";
> > > @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
> > > **name, enum v4l2_ctrl_type *type,
> > >  		*type =3D V4L2_CTRL_TYPE_INTEGER;
> > >  		*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> > >  		break;
> > > +	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> > > +		*type =3D V4L2_CTRL_TYPE_INTEGER;
> > > +		*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> > > +		break;
> > >  	case V4L2_CID_USER_CLASS:
> > >  	case V4L2_CID_CAMERA_CLASS:
> > >  	case V4L2_CID_CODEC_CLASS:
> > > diff --git a/include/uapi/linux/v4l2-controls.h
> > > b/include/uapi/linux/v4l2-controls.h
> > > index 7b3694985366..88e90d943e38 100644
> > > --- a/include/uapi/linux/v4l2-controls.h
> > > +++ b/include/uapi/linux/v4l2-controls.h
> > > @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
> > >  /*  MPEG-class control IDs specific to the MediaTek Decoder driver
> > > as defined by V4L2 */
> > >  #define V4L2_CID_MPEG_MTK_BASE			(V4L2_CTRL_CLAS
> > > S_CODEC | 0x2000)
> > >  #define V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE	(V4L2_CID_MPEG_
> > > MTK_BASE+8)
> > > +#define V4L2_CID_MPEG_MTK_SET_SECURE_MODE	(V4L2_CID_MPEG_MTK_BASE
> > > +9)
> > > =20
> > >  /*  Camera class control IDs */
> > > =20
> >=20
> >=20

