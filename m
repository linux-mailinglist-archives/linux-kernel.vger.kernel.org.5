Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379AA77C20F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjHNVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjHNVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:03:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F9F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:03:35 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d684d7a2a67so2794049276.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692047014; x=1692651814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygl9t1H2a8/F8MpclWB1xLcw3duBmKz3QWlYfLcnKKU=;
        b=mvmWdt+eJcRrLIyyUx7doXAXLkRXcgABMlLMmwbCia0o6ubcuGCDKbcJ27FlyI3os5
         a98DUBkd940kMpneC0lLHS6MIYR4tJLVq9ykmEqtN1Cf52KdXXegY3XOaD4vVY+SJxBS
         eWZKF5z/NUjg2U0NED545Uf2bSKoQOP/0PFUcuV8lqInL4eseMNd3B/J/X8f490/ip7e
         YDm4VGFke3JZVtWDI8kNSjryDxJahHlLTlyiP9qXVh+vAdBTki6HJVvLIm5DsgokLlB0
         aXwnxdVfunGtN08ct72fyH7sgVgEly4ADsBopLOXyhyoQ9EaxXaI2chWCp5vLnUqQS6p
         PC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047014; x=1692651814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ygl9t1H2a8/F8MpclWB1xLcw3duBmKz3QWlYfLcnKKU=;
        b=cwmAoTVj1P2IcgCwC6xiVMmz+CXhZwkEwevUc3kMKwiW3FxLfyiaS8xAGTHQiji1wJ
         BpDpjQejC1EfV7KgdV1o0kZ814zhLykPmS3RT4IkKffYIYhLksTammSgcWJZzS3z0eMO
         yzu7hFXgbLwE65JZCjgKdYPDl0ig+ai7bPOBXM3W2jKOa18QdTZb/SBL4q6V89cADFLX
         bU0NYdKdhWZo+50CU3Lc8IUlSt7YtRrMlOQFGc1NQK/PbAJWWd0T7MoZVU2hQC26aI1i
         FY6PPD6pkgUYIiurR/5rsseZ0htaG0SS9NPLq7o3cm18Bt6D8yqh2My6xK34b9ih8CyZ
         /Abg==
X-Gm-Message-State: AOJu0YwgGWgtlcOCeO6VeTmdpAQ9fzfLk+PMQdztAtFaQYVuOzA01/f+
        8cEVtMqLZ6s/uSI8Pqoi+BG4cOuNi3CcbUvAPtDCAg==
X-Google-Smtp-Source: AGHT+IFFZAS4AjbzB9DM31n1sE0kRUILkPFS1WVhaWNllfJ8hu5wv1HRrkj5lCdiiFKrI4+fdIdGQ4xq3pe6vc5WRxg=
X-Received: by 2002:a25:285:0:b0:d05:37c4:2182 with SMTP id
 127-20020a250285000000b00d0537c42182mr11387326ybc.5.1692047014570; Mon, 14
 Aug 2023 14:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
 <0e344949-1f9b-ca0b-9b19-9daf8e864c5a@linaro.org> <8794afbe-d8fc-9a09-f371-029169d9f80b@quicinc.com>
In-Reply-To: <8794afbe-d8fc-9a09-f371-029169d9f80b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 15 Aug 2023 00:03:23 +0300
Message-ID: <CAA8EJpqTej1=95WvutJuSyspDd_VtZ=JiBeNU6hppgyPPX=vng@mail.gmail.com>
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 21:58, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
>
>
> On 7/28/2023 7:19 PM, Dmitry Baryshkov wrote:
> > On 28/07/2023 16:23, Vikash Garodia wrote:
> >> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >>
> >> This implements the platform driver methods, file
> >> operations and v4l2 registration.
> >>
> >> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> >> ---
> >>   .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   | 660
> >> +++++++++++++++++++++
> >>   1 file changed, 660 insertions(+)
> >>   create mode 100644
> >> drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> >> b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> >> new file mode 100644
> >> index 0000000..43439cb
> >> --- /dev/null
> >> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
> >> @@ -0,0 +1,660 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/iommu.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/stringify.h>
> >> +#include <linux/version.h>
> >> +#include <linux/workqueue.h>
> >> +
> >> +#include "msm_vidc_core.h"
> >> +#include "msm_vidc_debug.h"
> >> +#include "msm_vidc_driver.h"
> >> +#include "msm_vidc_internal.h"
> >> +#include "msm_vidc_memory.h"
> >> +#include "msm_vidc_platform.h"
> >> +#include "msm_vidc_state.h"
> >> +#include "venus_hfi.h"
> >
> > This files are not present yet, so this commit doesn't have a change of
> > being compiled in any way.
> >
> >> +
> >> +#define BASE_DEVICE_NUMBER 32
> >> +
> >> +struct msm_vidc_core *g_core;
> >> +
> >> +static inline bool is_video_device(struct device *dev)
> >> +{
> >> +    return !!(of_device_is_compatible(dev->of_node, "qcom,sm8550-vidc"));
> >
> > Are you going to add future platforms to this list? Please don't duplicate
> > of_match_data here.
> > Sure, Will remove this API in next version.
> >> +}
> >> +
> >> +static inline bool is_video_context_bank_device(struct device *dev)
> >> +{
> >> +    return !!(of_device_is_compatible(dev->of_node, "qcom,vidc,cb-ns"));
> >> +}
> >> +
> >> +static int msm_vidc_init_resources(struct msm_vidc_core *core)
> >> +{
> >> +    struct msm_vidc_resource *res = NULL;
> >> +    int rc = 0;
> >> +
> >> +    res = devm_kzalloc(&core->pdev->dev, sizeof(*res), GFP_KERNEL);
> >> +    if (!res) {
> >> +        d_vpr_e("%s: failed to alloc memory for resource\n", __func__);
> >
> > Where is this macro defined? Please structure your comments in a logical
> > way, so that one can read them from the beginning and understand what is
> > going one.
> >
> > This is not to mention that adding such debugging wrappers doesn't have a
> > lot of value.
> >
> I understand the concern here, will remove the custom debug wrappers in
> next version.
> >> +        return -ENOMEM;
> >> +    }
> >> +    core->resource = res;
> >> +
> >> +    rc = call_res_op(core, init, core);
> >
> > What is call_res_op?
> >
> This implements the resource ops, but as we don't need the abstraction for
> resource ops, this will be removed in next version.
> >> +    if (rc) {
> >> +        d_vpr_e("%s: Failed to init resources: %d\n", __func__, rc);
> >> +        return rc;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static const struct of_device_id msm_vidc_dt_match[] = {
> >> +    {.compatible = "qcom,sm8550-vidc"},
> >> +    {.compatible = "qcom,vidc,cb-ns"},
> >> +    MSM_VIDC_EMPTY_BRACE
> >
> > NO!!! Please use {} directly.
> >
> I Understand, will replace with {}.
> >> +};
> >> +MODULE_DEVICE_TABLE(of, msm_vidc_dt_match);
> >> +
> >> +static void msm_vidc_release_video_device(struct video_device *vdev)
> >> +{
> >> +    d_vpr_e("%s: video device released\n", __func__);
> >> +}
> >> +
> >> +static void msm_vidc_unregister_video_device(struct msm_vidc_core *core,
> >> +                         enum msm_vidc_domain_type type)
> >> +{
> >> +    int index;
> >> +
> >> +    if (type == MSM_VIDC_DECODER)
> >> +        index = 0;
> >> +    else if (type == MSM_VIDC_ENCODER)
> >> +        index = 1;
> >> +    else
> >> +        return;
> >
> > You can index by the type instead of converting to index.
> >
> MSM_VIDC_DECODER/MSM_VIDC_ENCODER are bit masks hence can not be used as
> array index and these bit mask values are being used in driver at multiple
> places.

A subdevice can not be a decoder and an encoder at the same time, can
it? So, please replace masks with indices.

> >> +
> >> +    v4l2_m2m_release(core->vdev[index].m2m_dev);
> >> +
> >> +    video_set_drvdata(&core->vdev[index].vdev, NULL);
> >> +    video_unregister_device(&core->vdev[index].vdev);
> >> +}
> >> +
> >> +static int msm_vidc_register_video_device(struct msm_vidc_core *core,
> >> +                      enum msm_vidc_domain_type type, int nr)
> >> +{
> >> +    int rc = 0;
> >> +    int index;
> >> +
> >> +    d_vpr_h("%s: domain %d\n", __func__, type);
> >> +
> >> +    if (type == MSM_VIDC_DECODER)
> >> +        index = 0;
> >> +    else if (type == MSM_VIDC_ENCODER)
> >> +        index = 1;
> >> +    else
> >> +        return -EINVAL;
> >> +
> >> +    core->vdev[index].vdev.release =
> >> +        msm_vidc_release_video_device;
> >> +    core->vdev[index].vdev.fops = core->v4l2_file_ops;
> >> +    if (type == MSM_VIDC_DECODER)
> >> +        core->vdev[index].vdev.ioctl_ops = core->v4l2_ioctl_ops_dec;
> >> +    else
> >> +        core->vdev[index].vdev.ioctl_ops = core->v4l2_ioctl_ops_enc;
> >> +    core->vdev[index].vdev.vfl_dir = VFL_DIR_M2M;
> >> +    core->vdev[index].type = type;
> >> +    core->vdev[index].vdev.v4l2_dev = &core->v4l2_dev;
> >> +    core->vdev[index].vdev.device_caps =
> >> core->capabilities[DEVICE_CAPS].value;
> >> +    rc = video_register_device(&core->vdev[index].vdev,
> >> +                   VFL_TYPE_VIDEO, nr);
> >> +    if (rc) {
> >> +        d_vpr_e("Failed to register the video device\n");
> >> +        return rc;
> >> +    }
> >> +    video_set_drvdata(&core->vdev[index].vdev, core);
> >> +
> >> +    core->vdev[index].m2m_dev = v4l2_m2m_init(core->v4l2_m2m_ops);
> >> +    if (IS_ERR(core->vdev[index].m2m_dev)) {
> >> +        d_vpr_e("Failed to initialize V4L2 M2M device\n");
> >> +        rc = PTR_ERR(core->vdev[index].m2m_dev);
> >> +        goto m2m_init_failed;
> >> +    }
> >> +
> >> +    return 0;
> >> +
> >> +m2m_init_failed:
> >> +    video_unregister_device(&core->vdev[index].vdev);
> >> +    return rc;
> >> +}
> >> +
> >> +static int msm_vidc_deinitialize_core(struct msm_vidc_core *core)
> >> +{
> >> +    int rc = 0;
> >> +
> >> +    if (!core) {
> >> +        d_vpr_e("%s: invalid params\n", __func__);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    mutex_destroy(&core->lock);
> >> +    msm_vidc_update_core_state(core, MSM_VIDC_CORE_DEINIT, __func__);
> >> +
> >> +    if (core->batch_workq)
> >> +        destroy_workqueue(core->batch_workq);
> >> +
> >> +    if (core->pm_workq)
> >> +        destroy_workqueue(core->pm_workq);
> >> +
> >> +    core->batch_workq = NULL;
> >> +    core->pm_workq = NULL;
> >> +
> >> +    return rc;
> >> +}
> >> +
> >> +static int msm_vidc_initialize_core(struct msm_vidc_core *core)
> >> +{
> >> +    int rc = 0;
> >> +
> >> +    msm_vidc_update_core_state(core, MSM_VIDC_CORE_DEINIT, __func__);
> >> +
> >> +    core->pm_workq = create_singlethread_workqueue("pm_workq");
> >> +    if (!core->pm_workq) {
> >> +        d_vpr_e("%s: create pm workq failed\n", __func__);
> >> +        rc = -EINVAL;
> >> +        goto exit;
> >> +    }
> >> +
> >> +    core->batch_workq = create_singlethread_workqueue("batch_workq");
> >> +    if (!core->batch_workq) {
> >> +        d_vpr_e("%s: create batch workq failed\n", __func__);
> >> +        rc = -EINVAL;
> >> +        goto exit;
> >> +    }
> >> +
> >> +    core->packet_size = VIDC_IFACEQ_VAR_HUGE_PKT_SIZE;
> >> +    core->packet = devm_kzalloc(&core->pdev->dev, core->packet_size,
> >> GFP_KERNEL);
> >> +    if (!core->packet) {
> >> +        d_vpr_e("%s: failed to alloc core packet\n", __func__);
> >> +        rc = -ENOMEM;
> >> +        goto exit;
> >> +    }
> >> +
> >> +    core->response_packet = devm_kzalloc(&core->pdev->dev,
> >> core->packet_size, GFP_KERNEL);
> >> +    if (!core->packet) {
> >> +        d_vpr_e("%s: failed to alloc core response packet\n", __func__);
> >> +        rc = -ENOMEM;
> >> +        goto exit;
> >> +    }
> >> +
> >> +    mutex_init(&core->lock);
> >> +    INIT_LIST_HEAD(&core->instances);
> >> +    INIT_LIST_HEAD(&core->dangling_instances);
> >> +
> >> +    INIT_DELAYED_WORK(&core->pm_work, venus_hfi_pm_work_handler);
> >> +    INIT_DELAYED_WORK(&core->fw_unload_work, msm_vidc_fw_unload_handler);
> >> +
> >> +    return 0;
> >> +exit:
> >> +    if (core->batch_workq)
> >> +        destroy_workqueue(core->batch_workq);
> >> +    if (core->pm_workq)
> >> +        destroy_workqueue(core->pm_workq);
> >> +    core->batch_workq = NULL;
> >> +    core->pm_workq = NULL;
> >> +
> >> +    return rc;
> >> +}
> >> +
> >> +static void msm_vidc_devm_deinit_core(void *res)
> >> +{
> >> +    struct msm_vidc_core *core = res;
> >> +
> >> +    msm_vidc_deinitialize_core(core);
> >> +}
> >> +
> >> +static int msm_vidc_devm_init_core(struct device *dev, struct
> >> msm_vidc_core *core)
> >> +{
> >> +    int rc = 0;
> >> +
> >> +    if (!dev || !core) {
> >> +        d_vpr_e("%s: invalid params\n", __func__);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    rc = msm_vidc_initialize_core(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: init failed with %d\n", __func__, rc);
> >> +        return rc;
> >> +    }
> >> +
> >> +    rc = devm_add_action_or_reset(dev, msm_vidc_devm_deinit_core, (void
> >> *)core);
> >> +    if (rc)
> >> +        return -EINVAL;
> >> +
> >> +    return rc;
> >> +}
> >> +
> >> +static void msm_vidc_devm_debugfs_put(void *res)
> >> +{
> >> +    struct dentry *parent = res;
> >> +
> >> +    debugfs_remove_recursive(parent);
> >> +}
> >> +
> >> +static struct dentry *msm_vidc_devm_debugfs_get(struct device *dev)
> >
> > Why is it called get?
> >
> this will be removed in next version as part of debug wrappers removal
> >
> >> +{
> >> +    struct dentry *parent = NULL;
> >> +    int rc = 0;
> >> +
> >> +    if (!dev) {
> >> +        d_vpr_e("%s: invalid params\n", __func__);
> >> +        return NULL;
> >> +    }
> >> +
> >> +    parent = msm_vidc_debugfs_init_drv();
> >> +    if (!parent)
> >> +        return NULL;
> >> +
> >> +    rc = devm_add_action_or_reset(dev, msm_vidc_devm_debugfs_put, (void
> >> *)parent);
> >> +    if (rc)
> >> +        return NULL;
> >> +
> >> +    return parent;
> >> +}
> >> +
> >> +static int msm_vidc_setup_context_bank(struct msm_vidc_core *core,
> >> +                       struct device *dev)
> >> +{
> >> +    struct context_bank_info *cb = NULL;
> >> +    int rc = 0;
> >> +
> >> +    cb = msm_vidc_get_context_bank_for_device(core, dev);
> >> +    if (!cb) {
> >> +        d_vpr_e("%s: Failed to get context bank device for %s\n",
> >> +            __func__, dev_name(dev));
> >> +        return -EIO;
> >> +    }
> >> +
> >> +    /* populate dev & domain field */
> >> +    cb->dev = dev;
> >> +    cb->domain = iommu_get_domain_for_dev(cb->dev);
> >> +    if (!cb->domain) {
> >> +        d_vpr_e("%s: Failed to get iommu domain for %s\n", __func__,
> >> dev_name(dev));
> >> +        return -EIO;
> >> +    }
> >> +
> >> +    if (cb->dma_mask) {
> >> +        rc = dma_set_mask_and_coherent(cb->dev, cb->dma_mask);
> >> +        if (rc) {
> >> +            d_vpr_e("%s: dma_set_mask_and_coherent failed\n", __func__);
> >> +            return rc;
> >> +        }
> >> +    }
> >> +
> >> +    /*
> >> +     * configure device segment size and segment boundary to ensure
> >> +     * iommu mapping returns one mapping (which is required for partial
> >> +     * cache operations)
> >> +     */
> >> +    if (!dev->dma_parms)
> >> +        dev->dma_parms =
> >> +            devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);
> >> +    dma_set_max_seg_size(dev, (unsigned int)DMA_BIT_MASK(32));
> >> +    dma_set_seg_boundary(dev, (unsigned long)DMA_BIT_MASK(64));
> >> +
> >> +    iommu_set_fault_handler(cb->domain, msm_vidc_smmu_fault_handler,
> >> (void *)core);
> >> +
> >> +    d_vpr_h("%s: name %s addr start %x size %x secure %d\n",
> >> +        __func__, cb->name, cb->addr_range.start,
> >> +        cb->addr_range.size, cb->secure);
> >> +    d_vpr_h("%s: dma_coherant %d region %d dev_name %s domain %pK
> >> dma_mask %llu\n",
> >> +        __func__, cb->dma_coherant, cb->region, dev_name(cb->dev),
> >> +        cb->domain, cb->dma_mask);
> >> +
> >> +    return rc;
> >> +}
> >> +
> >> +static int msm_vidc_remove_video_device(struct platform_device *pdev)
> >> +{
> >> +    struct msm_vidc_core *core;
> >> +
> >> +    if (!pdev) {
> >> +        d_vpr_e("%s: invalid input %pK", __func__, pdev);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    core = dev_get_drvdata(&pdev->dev);
> >> +    if (!core) {
> >> +        d_vpr_e("%s: invalid core\n", __func__);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    msm_vidc_core_deinit(core, true);
> >> +    venus_hfi_queue_deinit(core);
> >> +
> >> +    msm_vidc_unregister_video_device(core, MSM_VIDC_ENCODER);
> >> +    msm_vidc_unregister_video_device(core, MSM_VIDC_DECODER);
> >> +
> >> +    v4l2_device_unregister(&core->v4l2_dev);
> >> +
> >> +    d_vpr_h("depopulating sub devices\n");
> >> +    /*
> >> +     * Trigger remove for each sub-device i.e. qcom,context-bank,xxxx
> >> +     * When msm_vidc_remove is called for each sub-device, destroy
> >> +     * context-bank mappings.
> >> +     */
> >> +    of_platform_depopulate(&pdev->dev);
> >> +
> >> +    dev_set_drvdata(&pdev->dev, NULL);
> >> +    g_core = NULL;
> >> +    d_vpr_h("%s(): succssful\n", __func__);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int msm_vidc_remove_context_bank(struct platform_device *pdev)
> >> +{
> >> +    d_vpr_h("%s(): %s\n", __func__, dev_name(&pdev->dev));
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int msm_vidc_remove(struct platform_device *pdev)
> >> +{
> >> +    /*
> >> +     * Sub devices remove will be triggered by of_platform_depopulate()
> >> +     * after core_deinit(). It return immediately after completing
> >> +     * sub-device remove.
> >> +     */
> >> +    if (is_video_device(&pdev->dev))
> >> +        return msm_vidc_remove_video_device(pdev);
> >> +    else if (is_video_context_bank_device(&pdev->dev))
> >> +        return msm_vidc_remove_context_bank(pdev);
> >> +
> >> +    /* How did we end up here? */
> >> +    WARN_ON(1);
> >> +    return -EINVAL;
> >> +}
> >> +
> >> +static int msm_vidc_probe_video_device(struct platform_device *pdev)
> >> +{
> >> +    int rc = 0;
> >> +    struct msm_vidc_core *core = NULL;
> >> +    int nr = BASE_DEVICE_NUMBER;
> >> +
> >> +    d_vpr_h("%s: %s\n", __func__, dev_name(&pdev->dev));
> >> +
> >> +    core = devm_kzalloc(&pdev->dev, sizeof(struct msm_vidc_core),
> >> GFP_KERNEL);
> >> +    if (!core) {
> >> +        d_vpr_e("%s: failed to alloc memory for core\n", __func__);
> >> +        return -ENOMEM;
> >> +    }
> >> +    g_core = core;
> >> +
> >> +    core->pdev = pdev;
> >> +    dev_set_drvdata(&pdev->dev, core);
> >> +
> >> +    core->debugfs_parent = msm_vidc_devm_debugfs_get(&pdev->dev);
> >> +    if (!core->debugfs_parent)
> >> +        d_vpr_h("Failed to create debugfs for msm_vidc\n");
> >> +
> >> +    rc = msm_vidc_devm_init_core(&pdev->dev, core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: init core failed with %d\n", __func__, rc);
> >> +        goto init_core_failed;
> >> +    }
> >> +
> >> +    rc = msm_vidc_init_platform(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: init platform failed with %d\n", __func__, rc);
> >> +        rc = -EINVAL;
> >> +        goto init_plat_failed;
> >> +    }
> >> +
> >> +    rc = msm_vidc_init_resources(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: init resource failed with %d\n", __func__, rc);
> >> +        goto init_res_failed;
> >> +    }
> >> +
> >> +    rc = msm_vidc_init_core_caps(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: init core caps failed with %d\n", __func__, rc);
> >> +        goto init_res_failed;
> >> +    }
> >> +
> >> +    rc = msm_vidc_init_instance_caps(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: init inst cap failed with %d\n", __func__, rc);
> >> +        goto init_inst_caps_fail;
> >> +    }
> >> +
> >> +    core->debugfs_root = msm_vidc_debugfs_init_core(core);
> >> +    if (!core->debugfs_root)
> >> +        d_vpr_h("Failed to init debugfs core\n");
> >> +
> >> +    d_vpr_h("populating sub devices\n");
> >> +    /*
> >> +     * Trigger probe for each sub-device i.e. qcom,msm-vidc,context-bank.
> >> +     * When msm_vidc_probe is called for each sub-device, parse the
> >> +     * context-bank details.
> >> +     */
> >> +    rc = of_platform_populate(pdev->dev.of_node, msm_vidc_dt_match, NULL,
> >> +                  &pdev->dev);
> >> +    if (rc) {
> >> +        d_vpr_e("Failed to trigger probe for sub-devices\n");
> >> +        goto sub_dev_failed;
> >> +    }
> >> +
> >> +    rc = v4l2_device_register(&pdev->dev, &core->v4l2_dev);
> >> +    if (rc) {
> >> +        d_vpr_e("Failed to register v4l2 device\n");
> >> +        goto v4l2_reg_failed;
> >> +    }
> >> +
> >> +    /* setup the decoder device */
> >> +    rc = msm_vidc_register_video_device(core, MSM_VIDC_DECODER, nr);
> >> +    if (rc) {
> >> +        d_vpr_e("Failed to register video decoder\n");
> >> +        goto dec_reg_failed;
> >> +    }
> >> +
> >> +    /* setup the encoder device */
> >> +    rc = msm_vidc_register_video_device(core, MSM_VIDC_ENCODER, nr + 1);
> >> +    if (rc) {
> >> +        d_vpr_e("Failed to register video encoder\n");
> >> +        goto enc_reg_failed;
> >> +    }
> >> +
> >> +    rc = venus_hfi_queue_init(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: interface queues init failed\n", __func__);
> >> +        goto queues_init_failed;
> >> +    }
> >> +
> >> +    rc = msm_vidc_core_init(core);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: sys init failed\n", __func__);
> >> +        goto core_init_failed;
> >> +    }
> >> +
> >> +    d_vpr_h("%s(): succssful\n", __func__);
> >> +
> >> +    return rc;
> >> +
> >> +core_init_failed:
> >> +    venus_hfi_queue_deinit(core);
> >> +queues_init_failed:
> >> +    of_platform_depopulate(&pdev->dev);
> >> +sub_dev_failed:
> >> +    msm_vidc_unregister_video_device(core, MSM_VIDC_ENCODER);
> >> +enc_reg_failed:
> >> +    msm_vidc_unregister_video_device(core, MSM_VIDC_DECODER);
> >> +dec_reg_failed:
> >> +    v4l2_device_unregister(&core->v4l2_dev);
> >> +v4l2_reg_failed:
> >> +init_inst_caps_fail:
> >> +init_res_failed:
> >> +init_plat_failed:
> >> +init_core_failed:
> >> +    dev_set_drvdata(&pdev->dev, NULL);
> >> +    g_core = NULL;
> >> +
> >> +    return rc;
> >> +}
> >> +
> >> +static int msm_vidc_probe_context_bank(struct platform_device *pdev)
> >> +{
> >> +    struct msm_vidc_core *core = NULL;
> >> +    int rc = 0;
> >> +
> >> +    if (!pdev) {
> >> +        d_vpr_e("%s: Invalid platform device %pK", __func__, pdev);
> >> +        return -EINVAL;
> >> +    } else if (!pdev->dev.parent) {
> >> +        d_vpr_e("%s: Failed to find a parent for %s\n",
> >> +            __func__, dev_name(&pdev->dev));
> >> +        return -ENODEV;
> >> +    }
> >> +
> >> +    d_vpr_h("%s(): %s\n", __func__, dev_name(&pdev->dev));
> >> +
> >> +    core = dev_get_drvdata(pdev->dev.parent);
> >> +    if (!core) {
> >> +        d_vpr_e("%s: core not found in device %s",
> >> +            __func__, dev_name(pdev->dev.parent));
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    rc = msm_vidc_setup_context_bank(core, &pdev->dev);
> >> +    if (rc) {
> >> +        d_vpr_e("%s: Failed to probe context bank %s\n",
> >> +            __func__, dev_name(&pdev->dev));
> >> +        return rc;
> >> +    }
> >> +
> >> +    return rc;
> >> +}
> >> +
> >> +static int msm_vidc_probe(struct platform_device *pdev)
> >> +{
> >> +    if (!pdev) {
> >> +        d_vpr_e("%s: invalid params\n", __func__);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    /*
> >> +     * Sub devices probe will be triggered by of_platform_populate()
> >> towards
> >> +     * the end of the probe function after msm-vidc device probe is
> >> +     * completed. Return immediately after completing sub-device probe.
> >> +     */
> >> +    if (is_video_device(&pdev->dev))
> >> +        return msm_vidc_probe_video_device(pdev);
> >> +    else if (is_video_context_bank_device(&pdev->dev))
> >> +        return msm_vidc_probe_context_bank(pdev);
> >> +
> >> +    /* How did we end up here? */
> >> +    WARN_ON(1);
> >> +    return -EINVAL;
> >
> > No. Please don't hack around the driver infrastructure and register two
> > separate drivers. They can even come in two separate commits, simplifying
> > the review.
> >
> Sure, will remove the separate probe for context bank in next version.
> >> +}
> >> +
> >> +static int msm_vidc_pm_suspend(struct device *dev)
> >> +{
> >> +    int rc = 0;
> >> +    struct msm_vidc_core *core;
> >> +    enum msm_vidc_allow allow = MSM_VIDC_DISALLOW;
> >> +
> >> +    /*
> >> +     * Bail out if
> >> +     * - driver possibly not probed yet
> >> +     * - not the main device. We don't support power management on
> >> +     *   subdevices (e.g. context banks)
> >> +     */
> >> +    if (!dev || !dev->driver || !is_video_device(dev))
> >> +        return 0;
> >> +
> >> +    core = dev_get_drvdata(dev);
> >> +    if (!core) {
> >> +        d_vpr_e("%s: invalid core\n", __func__);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    core_lock(core, __func__);
> >> +    allow = msm_vidc_allow_pm_suspend(core);
> >> +
> >> +    if (allow == MSM_VIDC_IGNORE) {
> >> +        d_vpr_h("%s: pm already suspended\n", __func__);
> >> +        msm_vidc_change_core_sub_state(core, 0,
> >> CORE_SUBSTATE_PM_SUSPEND, __func__);
> >> +        rc = 0;
> >> +        goto unlock;
> >> +    } else if (allow != MSM_VIDC_ALLOW) {
> >> +        d_vpr_h("%s: pm suspend not allowed\n", __func__);
> >> +        rc = 0;
> >> +        goto unlock;
> >> +    }
> >> +
> >> +    rc = msm_vidc_suspend(core);
> >> +    if (rc == -EOPNOTSUPP)
> >> +        rc = 0;
> >> +    else if (rc)
> >> +        d_vpr_e("Failed to suspend: %d\n", rc);
> >> +    else
> >> +        msm_vidc_change_core_sub_state(core, 0,
> >> CORE_SUBSTATE_PM_SUSPEND, __func__);
> >> +
> >> +unlock:
> >> +    core_unlock(core, __func__);
> >> +    return rc;
> >> +}
> >> +
> >> +static int msm_vidc_pm_resume(struct device *dev)
> >> +{
> >> +    struct msm_vidc_core *core;
> >> +
> >> +    /*
> >> +     * Bail out if
> >> +     * - driver possibly not probed yet
> >> +     * - not the main device. We don't support power management on
> >> +     *   subdevices (e.g. context banks)
> >> +     */
> >> +    if (!dev || !dev->driver || !is_video_device(dev))
> >> +        return 0;
> >> +
> >> +    core = dev_get_drvdata(dev);
> >> +    if (!core) {
> >> +        d_vpr_e("%s: invalid core\n", __func__);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    /* remove PM suspend from core sub_state */
> >> +    core_lock(core, __func__);
> >> +    msm_vidc_change_core_sub_state(core, CORE_SUBSTATE_PM_SUSPEND, 0,
> >> __func__);
> >> +    core_unlock(core, __func__);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops msm_vidc_pm_ops = {
> >> +    SET_SYSTEM_SLEEP_PM_OPS(msm_vidc_pm_suspend, msm_vidc_pm_resume)
> >
> > No runtime PM?
> runtime PM is not added in this series, but we plan to add it at later
> point of time.
> >
> >> +};
> >> +
> >> +struct platform_driver msm_vidc_driver = {
> >> +    .probe = msm_vidc_probe,
> >> +    .remove = msm_vidc_remove,
> >> +    .driver = {
> >> +        .name = "msm_vidc_v4l2",
> >> +        .of_match_table = msm_vidc_dt_match,
> >> +        .pm = &msm_vidc_pm_ops,
> >> +    },
> >> +};
> >> +
> >> +module_platform_driver(msm_vidc_driver);
> >> +MODULE_LICENSE("GPL");
> >
> > Unfortunately, after taking a glance at first two patches, I have to stop.
> > It is nearly impossible to review it.
> >
> > Please start from the beginning, split the driver according to the logical
> > functions, not per-file. Ideally something should be compillable starting
> > from one of the first patches, if not the very first one. This would
> > guarantee that your patchset is structured logically.
> >
> > Please add DT bindings. New driver series should start from the bindings
> > anyway.
> >
> > Please drop your custom debugging wrappers. Use dev_info, dev_warn, dev_err
> > and dev_dbg instead.
> >
> > Please drop the custom multi-device-single-driver scheme. If there are
> > different kinds of devices, there should be different drivers.
> >
> > Please take a look around. If you are pushing your driver for kernel
> > inclusion, it should not stand out by the style and by the typical code
> > seuqences.
>
> Thanks a lot for all your comments, will take care of these in next version.



-- 
With best wishes
Dmitry
