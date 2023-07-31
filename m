Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D386E76A292
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGaVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGaVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7D10F6;
        Mon, 31 Jul 2023 14:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E992A612D6;
        Mon, 31 Jul 2023 21:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC87C433C7;
        Mon, 31 Jul 2023 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690838591;
        bh=ZyA51bf3achAwAj2WEOOfH6Xvl1Jq7XbarWlRr1GV6k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N7cxUo1zYeR4rSIsnRiuYIS+RQTYSdjVxVZWRXFS1Bp6govWyRXIp+cVgD6psTcbS
         qnZqkgqFS3ROqhqlOSxl3jgwzHNbX5PVvycEraKiE2los3UWqAdqeVPLRs9+W0Zl9c
         cfvVhSr938IxwMAUZk5fBI8iHSpkAikoMh2LPspmHBfiDZPYFzlBTntMI3yuF8owAD
         Xof0aH2mMZB6U30HHIeTG6yCw1vtAoKdVwgj27s7ldHxFkT3ta1cQgDarKnEbpYVlT
         kdXj0ev17IJNCaRzC2LO3u6YcrWKwbmVVSquVfoAlfM+BtAWg9zA6iDIEREtHvV2wk
         xpLZKTKWPb4JQ==
Message-ID: <aaf1aba2-a757-d9c8-77c9-182ed1aaed35@kernel.org>
Date:   Mon, 31 Jul 2023 23:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 03/33] iris: vidc: add v4l2 wrapper file
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 15:23, Vikash Garodia wrote:
> Here is the implementation of v4l2 wrapper functions for all
> v4l2 IOCTLs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |  77 ++
>  .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    | 953 +++++++++++++++++++++
>  2 files changed, 1030 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
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

This does not look like Linux coding style. Don't create your own
abstraction layer over Linux internal API. Use standard Linux functions
which will behave better and scale along with kernel development.

> +		return POLLERR;
> +	}
> +	if (is_session_error(inst)) {
> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);

i_vpr_e is so obvious for every kernel developer... Please, no.

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

? So we don't know what's this? Mutex? Spinlock? Own reinvented lock?

> +	inst_lock(inst, __func__);

Neither this?

No, don't create your own abstractions over standard API.

Best regards,
Krzysztof

