Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D637566E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGQOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGQOzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:55:02 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35CE60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:55:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6348a8045a2so28725166d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1689605700; x=1692197700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=okcqMdVJPvttpfaCtDyFAC5JgGUGiUE8bqJ2YnmapIA=;
        b=dSMjRG1xXeIpAWJIRFcUGnqRpFCyi9zPVPWb3/NjxOC+wh872BTFzO9juIQqz8Hlny
         e6KXjPaDYCldVv5v9fVLoG/unNJKuGnz88FzGoIZzIv7LFiJ476+MzlOZcVcaF/Bj4p1
         1dYbecf6chhcZ89kTIu5E67wCo98UkCokexncUG0OqaWOsdBbrXan3GOskLmTsiL8ahK
         oldztOGZdzTfc6RqaUwWOtIrSxjxTk+WCweI8dfpAtAuzHierUhQ7apykPjI28U+voZS
         Vk0uzWNjRSe5S6b2YriilOt+ZBtphWEfQbEeoBoPgsWIilwdOiUB+BA2t40C5M0ZNLIG
         RECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605700; x=1692197700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okcqMdVJPvttpfaCtDyFAC5JgGUGiUE8bqJ2YnmapIA=;
        b=lYxihSywtceHjfZKu+xeCx9lz7nlebtrMjBvSAbj4oBF6TGgFg0wSd4DfnNLnmpjeH
         6BUlOhAA9xLDhOoaW5pRoqpRSAssdvYmaoHBoAYis5C8V2zh4nTyXrHu9zOrV33EePW5
         LZ01CrTN1CGCNw38vRQB3izJBAn4+eYYyFe9DjeGCmyzbI8XPeIJphH0MaK+1X3uFvfE
         GPGgYDAMGbS2SlVIeQ4RAYLMqt2slTCN68q/rSoaJ4HT3sQVNu/+tV5fJvS9FqE7/abg
         uO1B9be0G2a5AnHQbAcY1OHs+BaNaofWckoE/OqzZG+dvFMYUd6C1LZzUA8Lcv0tWoYt
         i7lQ==
X-Gm-Message-State: ABy/qLbNXJaybJNj2q25Wkm7z/gaN+g5k2B3KQGRBGC319AxjMcQQNii
        osu4Oqzp3Puba3a3b6stdI8xCA==
X-Google-Smtp-Source: APBJJlGij9+chSVFLc0V26YeVKRUuyjkGAKuN0uayk/MIBlJXxcw+FTvYkNn34lWPL82JnPoEL4OSA==
X-Received: by 2002:a0c:f2c9:0:b0:62d:ef66:ff1c with SMTP id c9-20020a0cf2c9000000b0062def66ff1cmr9702016qvm.24.1689605699760;
        Mon, 17 Jul 2023 07:54:59 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:83d4::7a9])
        by smtp.gmail.com with ESMTPSA id p5-20020a0ce185000000b00631ecb1052esm6429441qvl.74.2023.07.17.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:54:59 -0700 (PDT)
Message-ID: <a40c81a39de214c756a36fde535bfc775d82b922.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: fix some issues reported by coverity
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 17 Jul 2023 10:54:58 -0400
In-Reply-To: <20230717074006.22372-1-ming.qian@nxp.com>
References: <20230717074006.22372-1-ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

Le lundi 17 juillet 2023 =C3=A0 15:40 +0800, Ming Qian a =C3=A9crit=C2=A0:
> CHECKED_RETURN: 4 case
> REVERSE_INULL: 2 case
> UNINIT: 6 case
> UNUSED_VALUE: 1 case
>=20
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vdec.c     |  5 ++++-
>  drivers/media/platform/amphion/venc.c     |  6 ++++--
>  drivers/media/platform/amphion/vpu_cmds.c |  5 +++--
>  drivers/media/platform/amphion/vpu_core.c |  2 ++
>  drivers/media/platform/amphion/vpu_dbg.c  | 11 +++++++++--
>  drivers/media/platform/amphion/vpu_msgs.c | 12 ++++++------
>  6 files changed, 28 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platfo=
rm/amphion/vdec.c
> index eeb2ef72df5b..133d77d1ea0c 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -1019,6 +1019,7 @@ static int vdec_response_frame_abnormal(struct vpu_=
inst *inst)
>  {
>  	struct vdec_t *vdec =3D inst->priv;
>  	struct vpu_fs_info info;
> +	int ret;
> =20
>  	if (!vdec->req_frame_count)
>  		return 0;
> @@ -1026,7 +1027,9 @@ static int vdec_response_frame_abnormal(struct vpu_=
inst *inst)
>  	memset(&info, 0, sizeof(info));
>  	info.type =3D MEM_RES_FRAME;
>  	info.tag =3D vdec->seq_tag + 0xf0;
> -	vpu_session_alloc_fs(inst, &info);
> +	ret =3D vpu_session_alloc_fs(inst, &info);
> +	if (ret)
> +		return ret;
>  	vdec->req_frame_count--;
> =20
>  	return 0;
> diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platfo=
rm/amphion/venc.c
> index 58480e2755ec..4eb57d793a9c 100644
> --- a/drivers/media/platform/amphion/venc.c
> +++ b/drivers/media/platform/amphion/venc.c
> @@ -268,7 +268,7 @@ static int venc_g_parm(struct file *file, void *fh, s=
truct v4l2_streamparm *parm
>  {
>  	struct vpu_inst *inst =3D to_inst(file);
>  	struct venc_t *venc =3D inst->priv;
> -	struct v4l2_fract *timeperframe =3D &parm->parm.capture.timeperframe;
> +	struct v4l2_fract *timeperframe;

Could be just me, but I feel I'm missing some context to understand why thi=
s
change. Perhaps the commit message could be improved ?

All other changes looks like improvement to me, so with a good explanation =
on
this one (and the change seems to be equivalent), you can add:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> =20
>  	if (!parm)
>  		return -EINVAL;
> @@ -279,6 +279,7 @@ static int venc_g_parm(struct file *file, void *fh, s=
truct v4l2_streamparm *parm
>  	if (!vpu_helper_check_type(inst, parm->type))
>  		return -EINVAL;
> =20
> +	timeperframe =3D &parm->parm.capture.timeperframe;
>  	parm->parm.capture.capability =3D V4L2_CAP_TIMEPERFRAME;
>  	parm->parm.capture.readbuffers =3D 0;
>  	timeperframe->numerator =3D venc->params.frame_rate.numerator;
> @@ -291,7 +292,7 @@ static int venc_s_parm(struct file *file, void *fh, s=
truct v4l2_streamparm *parm
>  {
>  	struct vpu_inst *inst =3D to_inst(file);
>  	struct venc_t *venc =3D inst->priv;
> -	struct v4l2_fract *timeperframe =3D &parm->parm.capture.timeperframe;
> +	struct v4l2_fract *timeperframe;
>  	unsigned long n, d;
> =20
>  	if (!parm)
> @@ -303,6 +304,7 @@ static int venc_s_parm(struct file *file, void *fh, s=
truct v4l2_streamparm *parm
>  	if (!vpu_helper_check_type(inst, parm->type))
>  		return -EINVAL;
> =20
> +	timeperframe =3D &parm->parm.capture.timeperframe;
>  	if (!timeperframe->numerator)
>  		timeperframe->numerator =3D venc->params.frame_rate.numerator;
>  	if (!timeperframe->denominator)
> diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/pl=
atform/amphion/vpu_cmds.c
> index 647d94554fb5..235b71398d40 100644
> --- a/drivers/media/platform/amphion/vpu_cmds.c
> +++ b/drivers/media/platform/amphion/vpu_cmds.c
> @@ -306,7 +306,8 @@ static void vpu_core_keep_active(struct vpu_core *cor=
e)
> =20
>  	dev_dbg(core->dev, "try to wake up\n");
>  	mutex_lock(&core->cmd_lock);
> -	vpu_cmd_send(core, &pkt);
> +	if (vpu_cmd_send(core, &pkt))
> +		dev_err(core->dev, "fail to keep active\n");
>  	mutex_unlock(&core->cmd_lock);
>  }
> =20
> @@ -314,7 +315,7 @@ static int vpu_session_send_cmd(struct vpu_inst *inst=
, u32 id, void *data)
>  {
>  	unsigned long key;
>  	int sync =3D false;
> -	int ret =3D -EINVAL;
> +	int ret;
> =20
>  	if (inst->id < 0)
>  		return -EINVAL;
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/pl=
atform/amphion/vpu_core.c
> index 43d85a54268b..6f054700d5db 100644
> --- a/drivers/media/platform/amphion/vpu_core.c
> +++ b/drivers/media/platform/amphion/vpu_core.c
> @@ -88,6 +88,8 @@ static int vpu_core_boot_done(struct vpu_core *core)
> =20
>  		core->supported_instance_count =3D min(core->supported_instance_count,=
 count);
>  	}
> +	if (core->supported_instance_count >=3D BITS_PER_TYPE(core->instance_ma=
sk))
> +		core->supported_instance_count =3D BITS_PER_TYPE(core->instance_mask);
>  	core->fw_version =3D fw_version;
>  	vpu_core_set_state(core, VPU_CORE_ACTIVE);
> =20
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/pla=
tform/amphion/vpu_dbg.c
> index adc523b95061..982c2c777484 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -50,6 +50,13 @@ static char *vpu_stat_name[] =3D {
>  	[VPU_BUF_STATE_ERROR] =3D "error",
>  };
> =20
> +static inline const char *to_vpu_stat_name(int state)
> +{
> +	if (state <=3D VPU_BUF_STATE_ERROR)
> +		return vpu_stat_name[state];
> +	return "unknown";
> +}
> +
>  static int vpu_dbg_instance(struct seq_file *s, void *data)
>  {
>  	struct vpu_inst *inst =3D s->private;
> @@ -141,7 +148,7 @@ static int vpu_dbg_instance(struct seq_file *s, void =
*data)
>  		num =3D scnprintf(str, sizeof(str),
>  				"output [%2d] state =3D %10s, %8s\n",
>  				i, vb2_stat_name[vb->state],
> -				vpu_stat_name[vpu_get_buffer_state(vbuf)]);
> +				to_vpu_stat_name(vpu_get_buffer_state(vbuf)));
>  		if (seq_write(s, str, num))
>  			return 0;
>  	}
> @@ -156,7 +163,7 @@ static int vpu_dbg_instance(struct seq_file *s, void =
*data)
>  		num =3D scnprintf(str, sizeof(str),
>  				"capture[%2d] state =3D %10s, %8s\n",
>  				i, vb2_stat_name[vb->state],
> -				vpu_stat_name[vpu_get_buffer_state(vbuf)]);
> +				to_vpu_stat_name(vpu_get_buffer_state(vbuf)));
>  		if (seq_write(s, str, num))
>  			return 0;
>  	}
> diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/pl=
atform/amphion/vpu_msgs.c
> index f9eb488d1b5e..d0ead051f7d1 100644
> --- a/drivers/media/platform/amphion/vpu_msgs.c
> +++ b/drivers/media/platform/amphion/vpu_msgs.c
> @@ -32,7 +32,7 @@ static void vpu_session_handle_start_done(struct vpu_in=
st *inst, struct vpu_rpc_
> =20
>  static void vpu_session_handle_mem_request(struct vpu_inst *inst, struct=
 vpu_rpc_event *pkt)
>  {
> -	struct vpu_pkt_mem_req_data req_data;
> +	struct vpu_pkt_mem_req_data req_data =3D { 0 };
> =20
>  	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&req_data);
>  	vpu_trace(inst->dev, "[%d] %d:%d %d:%d %d:%d\n",
> @@ -80,7 +80,7 @@ static void vpu_session_handle_resolution_change(struct=
 vpu_inst *inst, struct v
> =20
>  static void vpu_session_handle_enc_frame_done(struct vpu_inst *inst, str=
uct vpu_rpc_event *pkt)
>  {
> -	struct vpu_enc_pic_info info;
> +	struct vpu_enc_pic_info info =3D { 0 };
> =20
>  	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
>  	dev_dbg(inst->dev, "[%d] frame id =3D %d, wptr =3D 0x%x, size =3D %d\n"=
,
> @@ -90,7 +90,7 @@ static void vpu_session_handle_enc_frame_done(struct vp=
u_inst *inst, struct vpu_
> =20
>  static void vpu_session_handle_frame_request(struct vpu_inst *inst, stru=
ct vpu_rpc_event *pkt)
>  {
> -	struct vpu_fs_info fs;
> +	struct vpu_fs_info fs =3D { 0 };
> =20
>  	vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
>  	call_void_vop(inst, event_notify, VPU_MSG_ID_FRAME_REQ, &fs);
> @@ -107,7 +107,7 @@ static void vpu_session_handle_frame_release(struct v=
pu_inst *inst, struct vpu_r
>  		info.type =3D inst->out_format.type;
>  		call_void_vop(inst, buf_done, &info);
>  	} else if (inst->core->type =3D=3D VPU_CORE_TYPE_DEC) {
> -		struct vpu_fs_info fs;
> +		struct vpu_fs_info fs =3D { 0 };
> =20
>  		vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
>  		call_void_vop(inst, event_notify, VPU_MSG_ID_FRAME_RELEASE, &fs);
> @@ -122,7 +122,7 @@ static void vpu_session_handle_input_done(struct vpu_=
inst *inst, struct vpu_rpc_
> =20
>  static void vpu_session_handle_pic_decoded(struct vpu_inst *inst, struct=
 vpu_rpc_event *pkt)
>  {
> -	struct vpu_dec_pic_info info;
> +	struct vpu_dec_pic_info info =3D { 0 };
> =20
>  	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
>  	call_void_vop(inst, get_one_frame, &info);
> @@ -130,7 +130,7 @@ static void vpu_session_handle_pic_decoded(struct vpu=
_inst *inst, struct vpu_rpc
> =20
>  static void vpu_session_handle_pic_done(struct vpu_inst *inst, struct vp=
u_rpc_event *pkt)
>  {
> -	struct vpu_dec_pic_info info;
> +	struct vpu_dec_pic_info info =3D { 0 };
>  	struct vpu_frame_info frame;
> =20
>  	memset(&frame, 0, sizeof(frame));

