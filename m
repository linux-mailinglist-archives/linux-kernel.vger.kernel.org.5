Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B87766E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjG1Nfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjG1Nfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:35:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0D4222
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:35:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so2697566e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690551299; x=1691156099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+jdPyTRRICX+VTwleLQyCEk097YGrt13KrQ2Veg5Nw=;
        b=A+9bhPJlMR9JqfLsJg82uNCcyGhv4BN7TyTDOJdtWtlioq1CNWXuYUJyhrTGIsIIjF
         Xgb76qghsKvFgJ+kByXA1N0cH4Bi5dKVlIpC/IHWMmupugavfqtcnQQB82ww64PJe1zd
         WKlsG9gaAOqzr/tuUlGW6Qw/US/LlLrUNrPosVRpiU4mLfwxQ5Pwd1vZhuODZOSSJMX3
         Rx1+BhefQWFr6+0rcKbDoq4ADS5LR1BxS6s1Y1XFA14aIwBJLbfeLy3U0Fkjb67480GW
         Y+7AqjIeX6YdqhIXHNKEqKgOtiLJveJYm92Kyzf6VSXPP87uniTgbV4YeAsXv9m5X2+c
         6Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551299; x=1691156099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+jdPyTRRICX+VTwleLQyCEk097YGrt13KrQ2Veg5Nw=;
        b=AVtFyQ1tjMXACKI/CwwcK3HntFR+s4PkDKWd0i4OWiy+00MuxysoJcj1hEbNJ+kZdU
         zU662gyaVY4CEmP7TsZlQ/13ENVGBHyQ6ZQrVrsUSaA+n6/Q410ajgr8ikkkZ0hbKdBw
         EzhkUQ+tjH7oqfj89rT2tSGAqF+jMEy3bZLs4B5xHl/Xwv+boagGZrvUfAFekDGAyIEu
         QoKQ9N+gFFVyCjiPhSybmFNv5XYwHZ0lmOtc1QpQ4M2UJJzLRNYawP5iElIHzYPZhkBA
         CMRG0HtHaVeMb6jYvBWYL/kowdrzbELvfDF6fuvfGjHnwq+jVCbA4cAwbOOayqWgEUAN
         XD8Q==
X-Gm-Message-State: ABy/qLaeJQ5sRdMpClr0iZ9uqpOxTDNNQ5mBnsEmOwcCCC3686QKN78+
        Pmqez60KXlkaRt7xysbNSmHkxQ==
X-Google-Smtp-Source: APBJJlE1W6VrvNMEAYVSOZboYKWVsbHOe8AbEMmgsilYjN5vpN6zPYrlGXq8JnnGi2n8wqADFlER+A==
X-Received: by 2002:a05:6512:6d5:b0:4fd:d18f:2d93 with SMTP id u21-20020a05651206d500b004fdd18f2d93mr2322118lff.6.1690551299263;
        Fri, 28 Jul 2023 06:34:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i18-20020ac25d32000000b004fe15185b67sm830153lfb.229.2023.07.28.06.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:34:58 -0700 (PDT)
Message-ID: <5eecab7a-0d14-de96-f0ef-7de95c68aa62@linaro.org>
Date:   Fri, 28 Jul 2023 16:34:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/33] iris: vidc: add v4l2 wrapper file
Content-Language: en-GB
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 16:23, Vikash Garodia wrote:
> Here is the implementation of v4l2 wrapper functions for all
> v4l2 IOCTLs.

Please do not describe the patch. "Here is..." , "This patch...", "This 
commit..." is a bad style. Please describe _why_ you are doing this. In 
other words, what is the purpose of adding such wrappers. Please rewrite 
your commit messages describing the reasons, not the patch contents.

> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |  77 ++
>   .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    | 953 +++++++++++++++++++++
>   2 files changed, 1030 insertions(+)
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>   create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
> 
> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
> new file mode 100644
> index 0000000..3766c9d
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
> new file mode 100644
> index 0000000..6dfb18b
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
> @@ -0,0 +1,953 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
> +unsigned int msm_v4l2_poll(struct file *filp, struct poll_table_struct *pt)
> +{
> +	int poll = 0;
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, NULL);
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return POLLERR;
> +	}
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		poll = POLLERR;
> +		goto exit;
> +	}
> +
> +	poll = msm_vidc_poll((void *)inst, filp, pt);
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
> +	struct video_device *vdev = video_devdata(filp);
> +	struct msm_video_device *vid_dev =
> +		container_of(vdev, struct msm_video_device, vdev);
> +	struct msm_vidc_core *core = video_drvdata(filp);
> +	struct msm_vidc_inst *inst;
> +
> +	inst = msm_vidc_open(core, vid_dev->type);
> +	if (!inst) {
> +		d_vpr_e("Failed to create instance, type = %d\n",
> +			vid_dev->type);
> +		return -ENOMEM;
> +	}
> +	filp->private_data = &inst->fh;
> +	return 0;
> +}
> +
> +int msm_v4l2_close(struct file *filp)
> +{
> +	int rc = 0;
> +	struct msm_vidc_inst *inst;
> +
> +	inst = get_vidc_inst(filp, NULL);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	rc = msm_vidc_close(inst);
> +	filp->private_data = NULL;
> +	return rc;
> +}
> +
> +int msm_v4l2_querycap(struct file *filp, void *fh,
> +		      struct v4l2_capability *cap)
> +{
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !cap) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_querycap((void *)inst, cap);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_enum_fmt((void *)inst, f);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = inst->event_handle(inst, MSM_VIDC_TRY_FMT, f);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = inst->event_handle(inst, MSM_VIDC_S_FMT, f);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !f) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_g_fmt((void *)inst, f);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !s) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_s_selection((void *)inst, s);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !s) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_g_selection((void *)inst, s);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !a) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_s_param((void *)inst, a);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !a) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_g_param((void *)inst, a);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = inst->event_handle(inst, MSM_VIDC_REQBUFS, b);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_querybuf((void *)inst, b);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_create_bufs((void *)inst, b);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	struct video_device *vdev = video_devdata(filp);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_prepare_buf((void *)inst, vdev->v4l2_dev->mdev, b);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	struct video_device *vdev = video_devdata(filp);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EINVAL;
> +		goto exit;
> +	}
> +
> +	rc = msm_vidc_qbuf(inst, vdev->v4l2_dev->mdev, b);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !b) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	rc = msm_vidc_dqbuf(inst, b);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto exit;
> +	}
> +
> +	rc = msm_vidc_streamon((void *)inst, i);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	rc = msm_vidc_streamoff((void *)inst, i);
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
> +	int rc = 0;
> +
> +	inst = container_of(fh, struct msm_vidc_inst, fh);
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !sub) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_subscribe_event((void *)inst, sub);
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
> +	int rc = 0;
> +
> +	inst = container_of(fh, struct msm_vidc_inst, fh);
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !sub) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	rc = msm_vidc_unsubscribe_event((void *)inst, sub);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !dec) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_try_cmd(inst, (union msm_v4l2_cmd *)dec);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	enum msm_vidc_event event;
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	if (!dec) {
> +		i_vpr_e(inst, "%s: invalid params\n", __func__);
> +		rc = -EINVAL;
> +		goto unlock;
> +	}
> +	if (dec->cmd != V4L2_DEC_CMD_START &&
> +	    dec->cmd != V4L2_DEC_CMD_STOP) {
> +		i_vpr_e(inst, "%s: invalid cmd %#x\n", __func__, dec->cmd);
> +		rc = -EINVAL;
> +		goto unlock;
> +	}
> +	event = (dec->cmd == V4L2_DEC_CMD_START ? MSM_VIDC_CMD_START : MSM_VIDC_CMD_STOP);
> +	rc = inst->event_handle(inst, event, NULL);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !enc) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_try_cmd(inst, (union msm_v4l2_cmd *)enc);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	enum msm_vidc_event event;
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	if (!enc) {
> +		i_vpr_e(inst, "%s: invalid params\n", __func__);
> +		rc = -EINVAL;
> +		goto unlock;
> +	}
> +	if (enc->cmd != V4L2_ENC_CMD_START &&
> +	    enc->cmd != V4L2_ENC_CMD_STOP) {
> +		i_vpr_e(inst, "%s: invalid cmd %#x\n", __func__, enc->cmd);
> +		rc = -EINVAL;
> +		goto unlock;
> +	}
> +	event = (enc->cmd == V4L2_ENC_CMD_START ? MSM_VIDC_CMD_START : MSM_VIDC_CMD_STOP);
> +	rc = inst->event_handle(inst, event, NULL);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
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
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_enum_framesizes((void *)inst, fsize);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
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
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_enum_frameintervals((void *)inst, fival);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
> +	if (!inst || !ctrl) {
> +		d_vpr_e("%s: invalid instance\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	client_lock(inst, __func__);
> +	inst_lock(inst, __func__);
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_query_ctrl((void *)inst, ctrl);
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
> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
> +	int rc = 0;
> +
> +	inst = get_inst_ref(g_core, inst);
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
> +		rc = -EBUSY;
> +		goto unlock;
> +	}
> +	rc = msm_vidc_query_menu((void *)inst, qmenu);
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
> +	struct msm_vidc_inst *inst = priv;
> +
> +	if (!inst) {
> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return;
> +	}
> +	i_vpr_h(inst, "%s: m2m job aborted\n", __func__);
> +	v4l2_m2m_job_finish(inst->m2m_dev, inst->m2m_ctx);
> +}

-- 
With best wishes
Dmitry

