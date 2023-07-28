Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23567673DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjG1RvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjG1RvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:51:07 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432D3588
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:51:01 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63d170a649eso15434446d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690566661; x=1691171461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdkN/HWzTtQ8+g588YDBN6yR2pcz0J9nkivK+OPcSI0=;
        b=UJcOLHjls7N7HIFjPn+7Fm2THbXD9vY+sLkQ49POuPq0lKPKYs/KOOqdx7rfMxjgXk
         KA+mE/MT71r6M/L1TkHmqXzL0Nu8B7GaKtOnTeTuoWSAnw42c/Z3ZCAquCYDtYa6Ra4V
         0CwAfNKigukeHmJkpDT3NXSvTpudaOknJ+9VHLTd4CyrpWs87qIXmWDE+Au+vamnSl1h
         P5940iUuAuvUM/iDqN323DNHdO8GHOZdFUg2WCRLS1fkjyQ2jhbIrzLQswptcL6WHPDs
         8z3zZxwd883CTgMOwLoXICGp7QDzYPLf45PoOkr1HKzPuDi1O3s/mnsxRdaOSHV3QdRm
         S6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566661; x=1691171461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdkN/HWzTtQ8+g588YDBN6yR2pcz0J9nkivK+OPcSI0=;
        b=TLVTDvspGZh0SkuxhNhGi7qjLO3cKPaOxd/5GbkmMrA8h0s5gI6pyODz1NgiB3vrLB
         PqhfvteVutH9ok4YMVMBfOdWJNUbUYbU98forvzqmdCeUZPigis8oNve3XDjnYMDwVtu
         s0bHtauJJvTEGR80jAxMkcD2rib+FAcddFYTsMYk7eEutKGYfkoEWK0xvfA6QnkmSg4c
         4b3Xwm75/u5/6Qf9o7sK2YUs36BDrQ6KV9Fi040jEyzIf31EF5Mfky+p6aVU+v3JSHCS
         DSTEZ8FHTeygZwhIOS1/46+TdauLH5XM2lR2wwcYzw8yj3uaWQuksvadoMgCzBXOL2aW
         TcrA==
X-Gm-Message-State: ABy/qLZARg8hhHXQTkEmaH4Yx4bCCilwQGuH8jXt2IJEewO8UNgzmbUn
        xZs2CosBxJmmoFNVqnfleXuDnQ==
X-Google-Smtp-Source: APBJJlHVVnXhuZJAIVOTHQ9kDjrHlM7JbS7CSuAywmuFxCd8RcDkoaABy5qjFbkge/5pl9XzrKgScg==
X-Received: by 2002:a0c:e3cb:0:b0:63d:37f2:73a8 with SMTP id e11-20020a0ce3cb000000b0063d37f273a8mr3235405qvl.42.1690566660734;
        Fri, 28 Jul 2023 10:51:00 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:2688::7a9])
        by smtp.gmail.com with ESMTPSA id x11-20020a0ce24b000000b0063d162a8b8bsm1411739qvl.19.2023.07.28.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:51:00 -0700 (PDT)
Message-ID: <7a91c48594efb2ab40f80a4a6532cb40ec20f89d.camel@ndufresne.ca>
Subject: Re: [PATCH 03/33] iris: vidc: add v4l2 wrapper file
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
Date:   Fri, 28 Jul 2023 13:50:59 -0400
In-Reply-To: <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
         <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 28 juillet 2023 =C3=A0 18:53 +0530, Vikash Garodia a =C3=A9crit=
=C2=A0:
> Here is the implementation of v4l2 wrapper functions for all
> v4l2 IOCTLs.
>=20
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |  77 ++
>  .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    | 953 +++++++++++++++=
++++++
>  2 files changed, 1030 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4=
l2.h
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4=
l2.c
>=20
> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h b/=
drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
> new file mode 100644
> index 0000000..3766c9d
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +
> +#ifndef _MSM_VIDC_V4L2_H_
> +#define _MSM_VIDC_V4L2_H_
> +
> +#include <linux/fs.h>
> +#include <linux/poll.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-ioctl.h>
> +
> +int msm_v4l2_open(struct file *filp);
> +int msm_v4l2_close(struct file *filp);
> +int msm_v4l2_querycap(struct file *filp, void *fh,
> +		      struct v4l2_capability *cap);
> +int msm_v4l2_enum_fmt(struct file *file, void *fh,
> +		      struct v4l2_fmtdesc *f);
> +int msm_v4l2_try_fmt(struct file *file, void *fh,
> +		     struct v4l2_format *f);
> +int msm_v4l2_s_fmt(struct file *file, void *fh,
> +		   struct v4l2_format *f);
> +int msm_v4l2_g_fmt(struct file *file, void *fh,
> +		   struct v4l2_format *f);
> +int msm_v4l2_s_selection(struct file *file, void *fh,
> +			 struct v4l2_selection *s);
> +int msm_v4l2_g_selection(struct file *file, void *fh,
> +			 struct v4l2_selection *s);
> +int msm_v4l2_s_parm(struct file *file, void *fh,
> +		    struct v4l2_streamparm *a);
> +int msm_v4l2_g_parm(struct file *file, void *fh,
> +		    struct v4l2_streamparm *a);
> +int msm_v4l2_reqbufs(struct file *file, void *fh,
> +		     struct v4l2_requestbuffers *b);
> +int msm_v4l2_querybuf(struct file *file, void *fh,
> +		      struct v4l2_buffer *b);
> +int msm_v4l2_create_bufs(struct file *filp, void *fh,
> +			 struct v4l2_create_buffers *b);
> +int msm_v4l2_prepare_buf(struct file *filp, void *fh,
> +			 struct v4l2_buffer *b);
> +int msm_v4l2_qbuf(struct file *file, void *fh,
> +		  struct v4l2_buffer *b);
> +int msm_v4l2_dqbuf(struct file *file, void *fh,
> +		   struct v4l2_buffer *b);
> +int msm_v4l2_streamon(struct file *file, void *fh,
> +		      enum v4l2_buf_type i);
> +int msm_v4l2_streamoff(struct file *file, void *fh,
> +		       enum v4l2_buf_type i);
> +int msm_v4l2_subscribe_event(struct v4l2_fh *fh,
> +			     const struct v4l2_event_subscription *sub);
> +int msm_v4l2_unsubscribe_event(struct v4l2_fh *fh,
> +			       const struct v4l2_event_subscription *sub);
> +int msm_v4l2_try_decoder_cmd(struct file *file, void *fh,
> +			     struct v4l2_decoder_cmd *enc);
> +int msm_v4l2_decoder_cmd(struct file *file, void *fh,
> +			 struct v4l2_decoder_cmd *dec);
> +int msm_v4l2_try_encoder_cmd(struct file *file, void *fh,
> +			     struct v4l2_encoder_cmd *enc);
> +int msm_v4l2_encoder_cmd(struct file *file, void *fh,
> +			 struct v4l2_encoder_cmd *enc);
> +int msm_v4l2_enum_framesizes(struct file *file, void *fh,
> +			     struct v4l2_frmsizeenum *fsize);
> +int msm_v4l2_enum_frameintervals(struct file *file, void *fh,
> +				 struct v4l2_frmivalenum *fival);
> +int msm_v4l2_queryctrl(struct file *file, void *fh,
> +		       struct v4l2_queryctrl *ctrl);
> +int msm_v4l2_querymenu(struct file *file, void *fh,
> +		       struct v4l2_querymenu *qmenu);
> +unsigned int msm_v4l2_poll(struct file *filp,
> +			   struct poll_table_struct *pt);
> +void msm_v4l2_m2m_device_run(void *priv);
> +void msm_v4l2_m2m_job_abort(void *priv);
> +
> +#endif // _MSM_VIDC_V4L2_H_
> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c b/=
drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
> new file mode 100644
> index 0000000..6dfb18b
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
> @@ -0,0 +1,953 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +
> +#include "msm_vidc.h"
> +#include "msm_vidc_core.h"
> +#include "msm_vidc_debug.h"
> +#include "msm_vidc_driver.h"
> +#include "msm_vidc_inst.h"
> +#include "msm_vidc_internal.h"
> +#include "msm_vidc_v4l2.h"
> +
> +static struct msm_vidc_inst *get_vidc_inst(struct file *filp, void *fh)
> +{
> +	if (!filp || !filp->private_data)
> +		return NULL;
> +	return container_of(filp->private_data,
> +					struct msm_vidc_inst, fh);
> +}
> +
> +unsigned int msm_v4l2_poll(struct file *filp, struct poll_table_struct *=
pt)
> +{
> +	int poll =3D 0;
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, NULL);
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return POLLERR;
> +	}
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		poll =3D POLLERR;
> +		goto exit;
> +	}
> +
> +	poll =3D msm_vidc_poll((void *)inst, filp, pt);
> +	if (poll)
> +		goto exit;
> +
> +exit:
> +	put_inst(inst);
> +	return poll;
> +}
> +
> +int msm_v4l2_open(struct file *filp)
> +{
> +	struct video_device *vdev =3D video_devdata(filp);
> +	struct msm_video_device *vid_dev =3D
> +		container_of(vdev, struct msm_video_device, vdev);
> +	struct msm_vidc_core *core =3D video_drvdata(filp);
> +	struct msm_vidc_inst *inst;
> +
> +	inst =3D msm_vidc_open(core, vid_dev->type);
> +	if (!inst) {
> +		d_vpr_e("Failed to create instance, type =3D %d\n",
> +			vid_dev->type);
> +		return -ENOMEM;
> +	}
> +	filp->private_data =3D &inst->fh;
> +	return 0;
> +}
> +
> +int msm_v4l2_close(struct file *filp)
> +{
> +	int rc =3D 0;
> +	struct msm_vidc_inst *inst;
> +
> +	inst =3D get_vidc_inst(filp, NULL);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	rc =3D msm_vidc_close(inst);
> +	filp->private_data =3D NULL;
> +	return rc;
> +}
> +
> +int msm_v4l2_querycap(struct file *filp, void *fh,
> +		      struct v4l2_capability *cap)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !cap) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);

You always takes both locks, which may indicate that you have one too many =
lock.
Any reason my the m2m_ctx->q_lock did not work for you ?

> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_querycap((void *)inst, cap);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_enum_fmt(struct file *filp, void *fh,
> +		      struct v4l2_fmtdesc *f)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_enum_fmt((void *)inst, f);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_try_fmt(struct file *filp, void *fh, struct v4l2_format *f)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D inst->event_handle(inst, MSM_VIDC_TRY_FMT, f);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_s_fmt(struct file *filp, void *fh,
> +		   struct v4l2_format *f)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D inst->event_handle(inst, MSM_VIDC_S_FMT, f);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_g_fmt(struct file *filp, void *fh,
> +		   struct v4l2_format *f)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_g_fmt((void *)inst, f);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_s_selection(struct file *filp, void *fh,
> +			 struct v4l2_selection *s)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !s) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_s_selection((void *)inst, s);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_g_selection(struct file *filp, void *fh,
> +			 struct v4l2_selection *s)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !s) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_g_selection((void *)inst, s);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_s_parm(struct file *filp, void *fh,
> +		    struct v4l2_streamparm *a)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !a) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_s_param((void *)inst, a);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_g_parm(struct file *filp, void *fh,
> +		    struct v4l2_streamparm *a)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !a) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_g_param((void *)inst, a);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_reqbufs(struct file *filp, void *fh,
> +		     struct v4l2_requestbuffers *b)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D inst->event_handle(inst, MSM_VIDC_REQBUFS, b);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_querybuf(struct file *filp, void *fh,
> +		      struct v4l2_buffer *b)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_querybuf((void *)inst, b);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_create_bufs(struct file *filp, void *fh,
> +			 struct v4l2_create_buffers *b)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_create_bufs((void *)inst, b);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_prepare_buf(struct file *filp, void *fh,
> +			 struct v4l2_buffer *b)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	struct video_device *vdev =3D video_devdata(filp);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_prepare_buf((void *)inst, vdev->v4l2_dev->mdev, b);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_qbuf(struct file *filp, void *fh,
> +		  struct v4l2_buffer *b)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	struct video_device *vdev =3D video_devdata(filp);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EINVAL;
> +		goto exit;
> +	}
> +
> +	rc =3D msm_vidc_qbuf(inst, vdev->v4l2_dev->mdev, b);
> +	if (rc)
> +		goto exit;
> +
> +exit:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_dqbuf(struct file *filp, void *fh,
> +		   struct v4l2_buffer *b)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	rc =3D msm_vidc_dqbuf(inst, b);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_streamon(struct file *filp, void *fh,
> +		      enum v4l2_buf_type i)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto exit;
> +	}
> +
> +	rc =3D msm_vidc_streamon((void *)inst, i);
> +	if (rc)
> +		goto exit;
> +
> +exit:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_streamoff(struct file *filp, void *fh,
> +		       enum v4l2_buf_type i)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	rc =3D msm_vidc_streamoff((void *)inst, i);
> +	if (rc)
> +		i_vpr_e(inst, "%s: msm_vidc_stramoff failed\n", __func__);
> +
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_subscribe_event(struct v4l2_fh *fh,
> +			     const struct v4l2_event_subscription *sub)
> +{
> +	struct msm_vidc_inst *inst;
> +	int rc =3D 0;
> +
> +	inst =3D container_of(fh, struct msm_vidc_inst, fh);
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !sub) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_subscribe_event((void *)inst, sub);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_unsubscribe_event(struct v4l2_fh *fh,
> +			       const struct v4l2_event_subscription *sub)
> +{
> +	struct msm_vidc_inst *inst;
> +	int rc =3D 0;
> +
> +	inst =3D container_of(fh, struct msm_vidc_inst, fh);
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !sub) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	rc =3D msm_vidc_unsubscribe_event((void *)inst, sub);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_try_decoder_cmd(struct file *filp, void *fh,
> +			     struct v4l2_decoder_cmd *dec)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !dec) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_try_cmd(inst, (union msm_v4l2_cmd *)dec);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_decoder_cmd(struct file *filp, void *fh,
> +			 struct v4l2_decoder_cmd *dec)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	enum msm_vidc_event event;
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	if (!dec) {
> +		i_vpr_e(inst, "%s: invalid params\n", __func__);
> +		rc =3D -EINVAL;
> +		goto unlock;
> +	}
> +	if (dec->cmd !=3D V4L2_DEC_CMD_START &&
> +	    dec->cmd !=3D V4L2_DEC_CMD_STOP) {
> +		i_vpr_e(inst, "%s: invalid cmd %#x\n", __func__, dec->cmd);
> +		rc =3D -EINVAL;
> +		goto unlock;
> +	}
> +	event =3D (dec->cmd =3D=3D V4L2_DEC_CMD_START ? MSM_VIDC_CMD_START : MS=
M_VIDC_CMD_STOP);
> +	rc =3D inst->event_handle(inst, event, NULL);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_try_encoder_cmd(struct file *filp, void *fh,
> +			     struct v4l2_encoder_cmd *enc)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !enc) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_try_cmd(inst, (union msm_v4l2_cmd *)enc);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_encoder_cmd(struct file *filp, void *fh,
> +			 struct v4l2_encoder_cmd *enc)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	enum msm_vidc_event event;
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	if (!enc) {
> +		i_vpr_e(inst, "%s: invalid params\n", __func__);
> +		rc =3D -EINVAL;
> +		goto unlock;
> +	}
> +	if (enc->cmd !=3D V4L2_ENC_CMD_START &&
> +	    enc->cmd !=3D V4L2_ENC_CMD_STOP) {
> +		i_vpr_e(inst, "%s: invalid cmd %#x\n", __func__, enc->cmd);
> +		rc =3D -EINVAL;
> +		goto unlock;
> +	}
> +	event =3D (enc->cmd =3D=3D V4L2_ENC_CMD_START ? MSM_VIDC_CMD_START : MS=
M_VIDC_CMD_STOP);
> +	rc =3D inst->event_handle(inst, event, NULL);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_enum_framesizes(struct file *filp, void *fh,
> +			     struct v4l2_frmsizeenum *fsize)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !fsize) {
> +		d_vpr_e("%s: invalid params: %pK %pK\n",
> +			__func__, inst, fsize);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_enum_framesizes((void *)inst, fsize);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_enum_frameintervals(struct file *filp, void *fh,
> +				 struct v4l2_frmivalenum *fival)
> +
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !fival) {
> +		d_vpr_e("%s: invalid params: %pK %pK\n",
> +			__func__, inst, fival);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_enum_frameintervals((void *)inst, fival);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_queryctrl(struct file *filp, void *fh,
> +		       struct v4l2_queryctrl *ctrl)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !ctrl) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_query_ctrl((void *)inst, ctrl);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +int msm_v4l2_querymenu(struct file *filp, void *fh,
> +		       struct v4l2_querymenu *qmenu)
> +{
> +	struct msm_vidc_inst *inst =3D get_vidc_inst(filp, fh);
> +	int rc =3D 0;
> +
> +	inst =3D get_inst_ref(g_core, inst);
> +	if (!inst || !qmenu) {
> +		d_vpr_e("%s: invalid params %pK %pK\n",
> +			__func__, inst, qmenu);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc =3D -EBUSY;
> +		goto unlock;
> +	}
> +	rc =3D msm_vidc_query_menu((void *)inst, qmenu);
> +	if (rc)
> +		goto unlock;
> +
> +unlock:
> +	inst_unlock(inst, __func__);
> +	client_unlock(inst, __func__);
> +	put_inst(inst);
> +
> +	return rc;
> +}
> +
> +void msm_v4l2_m2m_device_run(void *priv)
> +{
> +	d_vpr_l("%s(): device_run\n", __func__);
> +}
> +
> +void msm_v4l2_m2m_job_abort(void *priv)
> +{
> +	struct msm_vidc_inst *inst =3D priv;
> +
> +	if (!inst) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +	i_vpr_h(inst, "%s: m2m job aborted\n", __func__);
> +	v4l2_m2m_job_finish(inst->m2m_dev, inst->m2m_ctx);
> +}

