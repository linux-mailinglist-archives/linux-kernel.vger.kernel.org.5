Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15275CD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjGUQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjGUQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65138E42;
        Fri, 21 Jul 2023 09:04:21 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:580::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ABA7966070EA;
        Fri, 21 Jul 2023 17:04:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689955460;
        bh=c01vZiD+s3W+nqFmbR8PlsxyEjz1vFOD3CqBg2e3KSM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Iu/5pyHDzFypwkiyfcAffp/kCp5yJhIRvWQ2bwCVSJ3ZLwyzQCmCEPfOFJN2H3mX8
         4PU/ia8jaiAOmZ32Jb9coQHBS817e0Xswn8k5wDvd5gbON2ezUReW2kKkEkRYD8Zu9
         u6XTEd+suZC5wYmCe9Ko6Use3ZvKTJTRfRxFv5uodw8qAYKSLzlrCIt0p9LYHMSt1V
         H9smoeI9/92evwx5A7Df0u+40kFs92eVJVwh9imRDsJlloVfUxbiOTrAi32sNu/xXL
         0iLV9Uy9EV+qKO8UOUh2sOGgbiB9/RtqEYW5366v3SI3Yp1LkWiZf0xVjL781usJ7R
         UKtIBdvxp1pOw==
Message-ID: <2dfb9b711c5840a4da24b06973c03d6e2b60cb9c.camel@collabora.com>
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: checking decoder ack
 message parameter
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
Date:   Fri, 21 Jul 2023 12:04:10 -0400
In-Reply-To: <9c4fc4ec11988b7068ed0f8ae4bf5e969383979d.camel@mediatek.com>
References: <20230717081319.12542-1-yunfei.dong@mediatek.com>
         <02e3f58e3dc009eadd1f37ac3d7d65a95706c9a6.camel@collabora.com>
         <9c4fc4ec11988b7068ed0f8ae4bf5e969383979d.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 21 juillet 2023 =C3=A0 01:58 +0000, Yunfei Dong (=E8=91=A3=E4=
=BA=91=E9=A3=9E) a =C3=A9crit=C2=A0:
> Hi Nicolas,
>=20
> Thanks for your review.
>=20
> On Thu, 2023-07-20 at 16:22 -0400, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le lundi 17 juillet 2023 =C3=A0 16:13 +0800, Yunfei Dong a =C3=A9crit :
> > > Need to checking all parameters of msg data are valid or not,
> > > in case of access null pointer or unreasonable value leading
> > > to kernel reboot.
> > >=20
> > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > ---
> > >  .../vcodec/decoder/mtk_vcodec_dec_drv.h       |  2 +
> > >  .../mediatek/vcodec/decoder/vdec_vpu_if.c     | 77 ++++++++++++---
> > > ----
> > >  2 files changed, 52 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .h
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .h
> > > index c8b4374c5e6c..1ea5dbb475dd 100644
> > > ---
> > > a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .h
> > > +++
> > > b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv
> > > .h
> > > @@ -160,6 +160,7 @@ struct mtk_vcodec_dec_pdata {
> > >   * @hw_id: hardware index used to identify different hardware.
> > >   *
> > >   * @msg_queue: msg queue used to store lat buffer information.
> > > + * @vpu_inst: vpu instance pointer.
> > >   */
> > >  struct mtk_vcodec_dec_ctx {
> > >  	enum mtk_instance_type type;
> > > @@ -202,6 +203,7 @@ struct mtk_vcodec_dec_ctx {
> > >  	int hw_id;
> > > =20
> > >  	struct vdec_msg_queue msg_queue;
> > > +	void *vpu_inst;
> > >  };
> > > =20
> > >  /**
> > > diff --git
> > > a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > index 82c3dc8c4127..23cfe5c6c90b 100644
> > > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > @@ -72,6 +72,21 @@ static void handle_get_param_msg_ack(const
> > > struct vdec_vpu_ipi_get_param_ack *ms
> > >  	}
> > >  }
> > > =20
> > > +static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec_dev
> > > *dec_dev, struct vdec_vpu_inst *vpu)
> > > +{
> > > +	struct mtk_vcodec_dec_ctx *ctx;
> > > +	int ret =3D false;
> > > +
> > > +	list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
> >=20
> > I'm not quite fully aware of the threading model in place, but this
> > ctx_list is
> > normally protected by dev->dev_mutex, and is not being protected
> > here. I also
> > don't know which type of interrupt handler we are in here.
> >=20
> If the device is opened, one ctx will be inserted to ctx_list, then the
> handler interface will be called.=20
>=20
> 1: This function just used to check whether the context is reasonable,
> no need to add mutex to protect because the context already in ctx_list
> in oped period. This function won't be called after deinit ctx from
> ctx_list.
>=20
> 2: This handler will be called when ap send message to scp.

Ack.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> Best Regards,
> Yunfei Dong
> > > +		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
> > > +			ret =3D true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /*
> > >   * vpu_dec_ipi_handler - Handler for VPU ipi message.
> > >   *
> > > @@ -84,44 +99,51 @@ static void handle_get_param_msg_ack(const
> > > struct vdec_vpu_ipi_get_param_ack *ms
> > >   */
> > >  static void vpu_dec_ipi_handler(void *data, unsigned int len, void
> > > *priv)
> > >  {
> > > +	struct mtk_vcodec_dec_dev *dec_dev;
> > >  	const struct vdec_vpu_ipi_ack *msg =3D data;
> > > -	struct vdec_vpu_inst *vpu =3D (struct vdec_vpu_inst *)
> > > -					(unsigned long)msg-
> > > > ap_inst_addr;
> > > +	struct vdec_vpu_inst *vpu;
> > > =20
> > > -	if (!vpu) {
> > > +	dec_dev =3D (struct mtk_vcodec_dec_dev *)priv;
> > > +	vpu =3D (struct vdec_vpu_inst *)(unsigned long)msg->ap_inst_addr;
> > > +	if (!priv || !vpu) {
> > >  		mtk_v4l2_vdec_err(vpu->ctx, "ap_inst_addr is NULL, did
> > > the SCP hang or crash?");
> > >  		return;
> > >  	}
> > > =20
> > > -	mtk_vdec_debug(vpu->ctx, "+ id=3D%X", msg->msg_id);
> > > +	if (!vpu_dec_check_ap_inst(dec_dev, vpu) || msg->msg_id <
> > > VPU_IPIMSG_DEC_INIT_ACK ||
> > > +	    msg->msg_id > VPU_IPIMSG_DEC_GET_PARAM_ACK) {
> > > +		mtk_v4l2_vdec_err(vpu->ctx, "vdec msg id not correctly
> > > =3D> 0x%x", msg->msg_id);
> > > +		vpu->failure =3D -EINVAL;
> > > +		goto error;
> > > +	}
> > > =20
> > >  	vpu->failure =3D msg->status;
> > > -	vpu->signaled =3D 1;
> > > +	if (msg->status !=3D 0)
> > > +		goto error;
> > > =20
> > > -	if (msg->status =3D=3D 0) {
> > > -		switch (msg->msg_id) {
> > > -		case VPU_IPIMSG_DEC_INIT_ACK:
> > > -			handle_init_ack_msg(data);
> > > -			break;
> > > +	switch (msg->msg_id) {
> > > +	case VPU_IPIMSG_DEC_INIT_ACK:
> > > +		handle_init_ack_msg(data);
> > > +		break;
> > > =20
> > > -		case VPU_IPIMSG_DEC_START_ACK:
> > > -		case VPU_IPIMSG_DEC_END_ACK:
> > > -		case VPU_IPIMSG_DEC_DEINIT_ACK:
> > > -		case VPU_IPIMSG_DEC_RESET_ACK:
> > > -		case VPU_IPIMSG_DEC_CORE_ACK:
> > > -		case VPU_IPIMSG_DEC_CORE_END_ACK:
> > > -			break;
> > > +	case VPU_IPIMSG_DEC_START_ACK:
> > > +	case VPU_IPIMSG_DEC_END_ACK:
> > > +	case VPU_IPIMSG_DEC_DEINIT_ACK:
> > > +	case VPU_IPIMSG_DEC_RESET_ACK:
> > > +	case VPU_IPIMSG_DEC_CORE_ACK:
> > > +	case VPU_IPIMSG_DEC_CORE_END_ACK:
> > > +		break;
> > > =20
> > > -		case VPU_IPIMSG_DEC_GET_PARAM_ACK:
> > > -			handle_get_param_msg_ack(data);
> > > -			break;
> > > -		default:
> > > -			mtk_vdec_err(vpu->ctx, "invalid msg=3D%X", msg-
> > > > msg_id);
> > > -			break;
> > > -		}
> > > +	case VPU_IPIMSG_DEC_GET_PARAM_ACK:
> > > +		handle_get_param_msg_ack(data);
> > > +		break;
> > > +	default:
> > > +		mtk_vdec_err(vpu->ctx, "invalid msg=3D%X", msg->msg_id);
> > > +		break;
> > >  	}
> > > =20
> > > -	mtk_vdec_debug(vpu->ctx, "- id=3D%X", msg->msg_id);
> > > +error:
> > > +	vpu->signaled =3D 1;
> > >  }
> > > =20
> > >  static int vcodec_vpu_send_msg(struct vdec_vpu_inst *vpu, void
> > > *msg, int len)
> > > @@ -182,9 +204,10 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
> > > =20
> > >  	init_waitqueue_head(&vpu->wq);
> > >  	vpu->handler =3D vpu_dec_ipi_handler;
> > > +	vpu->ctx->vpu_inst =3D vpu;
> > > =20
> > >  	err =3D mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler,
> > > vpu->id,
> > > -					 vpu->handler, "vdec", NULL);
> > > +					 vpu->handler, "vdec", vpu-
> > > > ctx->dev);
> > >  	if (err) {
> > >  		mtk_vdec_err(vpu->ctx, "vpu_ipi_register fail
> > > status=3D%d", err);
> > >  		return err;
> > > @@ -193,7 +216,7 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
> > >  	if (vpu->ctx->dev->vdec_pdata->hw_arch =3D=3D
> > > MTK_VDEC_LAT_SINGLE_CORE) {
> > >  		err =3D mtk_vcodec_fw_ipi_register(vpu->ctx->dev-
> > > > fw_handler,
> > >  						 vpu->core_id, vpu-
> > > > handler,
> > > -						 "vdec", NULL);
> > > +						 "vdec", vpu->ctx-
> > > > dev);
> > >  		if (err) {
> > >  			mtk_vdec_err(vpu->ctx, "vpu_ipi_register core
> > > fail status=3D%d", err);
> > >  			return err;
> >=20
> >=20

