Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366A7766EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbjG1NqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjG1NqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:46:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B610FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:46:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso3798535e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690551960; x=1691156760;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThGiJ9q0mDo0GTrg1zftQdTtY6zqb1dmL8LzHXfFlSU=;
        b=YXAy8Za7/A722nDmkAUJA4BA0LvDhPDa8+Bz0ma4mt9vmCQLTbs28GV8CbQf54CTT0
         p8IRniT12dV8hJBA+vFW059vUiTa8Bm2VVM7Sd4EYTv8SPcMtgRM8fiNq+ThXHiE5vnq
         zfDz0NKlDZfBheKeOF9eMQNNHmuCYBR7aR+vJQ0PgKWFl1vuXeHzYHV+iXjWQvS9tTnT
         qEhSayQQ/qBYZTHSD+t6Ub/OyEJbVUzAM74L8nq2dGikUfaHOSW4suTcUZFuaJiPWDLU
         H0c6V8TGYQd5BHF9JoZNQGOaX1Ssd9JARchDzJpXocQS4eoKZ+QgzRtWRL+EoyYon9c7
         zBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551960; x=1691156760;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThGiJ9q0mDo0GTrg1zftQdTtY6zqb1dmL8LzHXfFlSU=;
        b=W73td7EuIDk9AGL2zuTcFmAHa2vbfTi12Ozn/xHKKQ5OL1NZUdr/iKeF7i4BPwPzCp
         w2gCSES2aKEvClppCd5wZ0ZABswxGS9EMH+ZWwVmTewdIOYsJI+tirgOCRXCwDkTh+em
         VByfpNEIKNfLBSEIIn7wL991ptJeK/gijMIFyb/FLT/l5xfODl0cRPq/fG8e8qvEM5EC
         Jb5i0b8+3/5FjiWo9UxGUcObkvOxtiWvLnYnt8+aZj5DSWBMb1WJ62BXoB5GvwA2KfZd
         kw0w9gw12kjBKU9krENNK7o8qtCGZ8XgnqFyoKnCe/BxbISsA64vwzqja9fmsTOiIzS9
         B+qg==
X-Gm-Message-State: ABy/qLblADmpQUGXepBpX3tbpeOIU6hxHW3g+13K/RnTk5q/1Ards81W
        t20AfeobqPW6LCdkacvvQVvSRw==
X-Google-Smtp-Source: APBJJlHQNcEWMdYfoSsrbEmpZZKua/0m+StkgNdyCDpxvjzKmY/KRyimB7s7ATxsqZj3ArjZ0UrLIA==
X-Received: by 2002:a05:6512:39c5:b0:4fd:d481:ff35 with SMTP id k5-20020a05651239c500b004fdd481ff35mr2027950lfu.42.1690551960441;
        Fri, 28 Jul 2023 06:46:00 -0700 (PDT)
Received: from [192.168.1.101] (abym224.neoplus.adsl.tpnet.pl. [83.9.32.224])
        by smtp.gmail.com with ESMTPSA id c2-20020ac24142000000b004fe142ecd61sm827648lfi.139.2023.07.28.06.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:45:59 -0700 (PDT)
Message-ID: <c6a094bc-3032-cfe7-d24b-6e83f53e1771@linaro.org>
Date:   Fri, 28 Jul 2023 15:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2023 15:23, Vikash Garodia wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> This implements the platform driver methods, file
> operations and v4l2 registration.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
[...]

> +struct msm_vidc_core *g_core;
> +
> +static inline bool is_video_device(struct device *dev)
> +{
> +	return !!(of_device_is_compatible(dev->of_node, "qcom,sm8550-vidc"));
> +}
Are you expecting this to be expanded each time support for new SoC is added?

> +
> +static inline bool is_video_context_bank_device(struct device *dev)
> +{
> +	return !!(of_device_is_compatible(dev->of_node, "qcom,vidc,cb-ns"));
> +}
> +
> +static int msm_vidc_init_resources(struct msm_vidc_core *core)
> +{
> +	struct msm_vidc_resource *res = NULL;
No need to initialize, you use it right after defining.

> +	int rc = 0;
I think 'ret' is more common for a return-value-holding variable.

> +
> +	res = devm_kzalloc(&core->pdev->dev, sizeof(*res), GFP_KERNEL);
> +	if (!res) {
> +		d_vpr_e("%s: failed to alloc memory for resource\n", __func__);
> +		return -ENOMEM;
> +	}
> +	core->resource = res;
I don't think the 'res' variable makes sense.

> +
> +	rc = call_res_op(core, init, core);
> +	if (rc) {
> +		d_vpr_e("%s: Failed to init resources: %d\n", __func__, rc);
> +		return rc;
you can omit this line and return rc/ret at the last line of this func.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id msm_vidc_dt_match[] = {
> +	{.compatible = "qcom,sm8550-vidc"},
{ .compatible = .... " },

> +	{.compatible = "qcom,vidc,cb-ns"},
> +	MSM_VIDC_EMPTY_BRACE
why?

> +};
> +MODULE_DEVICE_TABLE(of, msm_vidc_dt_match);
> +
> +static void msm_vidc_release_video_device(struct video_device *vdev)
> +{
> +	d_vpr_e("%s: video device released\n", __func__);
> +}
Doesn't sound too useful? And definitely not with an error print?

> +
> +static void msm_vidc_unregister_video_device(struct msm_vidc_core *core,
> +					     enum msm_vidc_domain_type type)
> +{
> +	int index;
> +
> +	if (type == MSM_VIDC_DECODER)
I'm not sure this is defined.

> +		index = 0;
> +	else if (type == MSM_VIDC_ENCODER)
Or this.

Can't we just assign index = MSM_VIDC_EN/DECODER?

> +		index = 1;
> +	else
> +		return;
> +
> +	v4l2_m2m_release(core->vdev[index].m2m_dev);
> +
> +	video_set_drvdata(&core->vdev[index].vdev, NULL);
> +	video_unregister_device(&core->vdev[index].vdev);
> +}
> +
> +static int msm_vidc_register_video_device(struct msm_vidc_core *core,
> +					  enum msm_vidc_domain_type type, int nr)
> +{
> +	int rc = 0;
> +	int index;
> +
> +	d_vpr_h("%s: domain %d\n", __func__, type);
> +
> +	if (type == MSM_VIDC_DECODER)
> +		index = 0;
> +	else if (type == MSM_VIDC_ENCODER)
> +		index = 1;
> +	else
> +		return -EINVAL;
> +
> +	core->vdev[index].vdev.release =
> +		msm_vidc_release_video_device;
> +	core->vdev[index].vdev.fops = core->v4l2_file_ops;
> +	if (type == MSM_VIDC_DECODER)
> +		core->vdev[index].vdev.ioctl_ops = core->v4l2_ioctl_ops_dec;
> +	else
> +		core->vdev[index].vdev.ioctl_ops = core->v4l2_ioctl_ops_enc;
> +	core->vdev[index].vdev.vfl_dir = VFL_DIR_M2M;
> +	core->vdev[index].type = type;
> +	core->vdev[index].vdev.v4l2_dev = &core->v4l2_dev;
> +	core->vdev[index].vdev.device_caps = core->capabilities[DEVICE_CAPS].value;
> +	rc = video_register_device(&core->vdev[index].vdev,
> +				   VFL_TYPE_VIDEO, nr);
> +	if (rc) {
> +		d_vpr_e("Failed to register the video device\n");
> +		return rc;
> +	}
> +	video_set_drvdata(&core->vdev[index].vdev, core);
> +
> +	core->vdev[index].m2m_dev = v4l2_m2m_init(core->v4l2_m2m_ops);
> +	if (IS_ERR(core->vdev[index].m2m_dev)) {
> +		d_vpr_e("Failed to initialize V4L2 M2M device\n");
> +		rc = PTR_ERR(core->vdev[index].m2m_dev);
> +		goto m2m_init_failed;
> +	}
> +
> +	return 0;
> +
> +m2m_init_failed:
> +	video_unregister_device(&core->vdev[index].vdev);
> +	return rc;
> +}
> +
> +static int msm_vidc_deinitialize_core(struct msm_vidc_core *core)
> +{
> +	int rc = 0;
> +
> +	if (!core) {
Are we expecting to ever hit this?

> +		d_vpr_e("%s: invalid params\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_destroy(&core->lock);
> +	msm_vidc_update_core_state(core, MSM_VIDC_CORE_DEINIT, __func__);
Not defined.

> +
> +	if (core->batch_workq)
> +		destroy_workqueue(core->batch_workq);
> +
> +	if (core->pm_workq)
> +		destroy_workqueue(core->pm_workq);
> +
> +	core->batch_workq = NULL;
> +	core->pm_workq = NULL;
> +
> +	return rc;
> +}
> +
> +static int msm_vidc_initialize_core(struct msm_vidc_core *core)
> +{
> +	int rc = 0;
> +
> +	msm_vidc_update_core_state(core, MSM_VIDC_CORE_DEINIT, __func__);
Not defined.

> +
> +	core->pm_workq = create_singlethread_workqueue("pm_workq");
> +	if (!core->pm_workq) {
> +		d_vpr_e("%s: create pm workq failed\n", __func__);
> +		rc = -EINVAL;
> +		goto exit;
> +	}
> +
> +	core->batch_workq = create_singlethread_workqueue("batch_workq");
> +	if (!core->batch_workq) {
> +		d_vpr_e("%s: create batch workq failed\n", __func__);
> +		rc = -EINVAL;
> +		goto exit;
> +	}
> +
> +	core->packet_size = VIDC_IFACEQ_VAR_HUGE_PKT_SIZE;
> +	core->packet = devm_kzalloc(&core->pdev->dev, core->packet_size, GFP_KERNEL);
> +	if (!core->packet) {
> +		d_vpr_e("%s: failed to alloc core packet\n", __func__);
> +		rc = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	core->response_packet = devm_kzalloc(&core->pdev->dev, core->packet_size, GFP_KERNEL);
> +	if (!core->packet) {
> +		d_vpr_e("%s: failed to alloc core response packet\n", __func__);
> +		rc = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	mutex_init(&core->lock);
> +	INIT_LIST_HEAD(&core->instances);
> +	INIT_LIST_HEAD(&core->dangling_instances);
> +
> +	INIT_DELAYED_WORK(&core->pm_work, venus_hfi_pm_work_handler);
> +	INIT_DELAYED_WORK(&core->fw_unload_work, msm_vidc_fw_unload_handler);
> +
> +	return 0;
Either return rc/ret here or don't initialize it at definition.

> +exit:
> +	if (core->batch_workq)
> +		destroy_workqueue(core->batch_workq);
> +	if (core->pm_workq)
> +		destroy_workqueue(core->pm_workq);
> +	core->batch_workq = NULL;
> +	core->pm_workq = NULL;
> +
> +	return rc;
> +}
[...]

> +
> +static int msm_vidc_pm_suspend(struct device *dev)
> +{
> +	int rc = 0;
> +	struct msm_vidc_core *core;
> +	enum msm_vidc_allow allow = MSM_VIDC_DISALLOW;
> +
> +	/*
> +	 * Bail out if
> +	 * - driver possibly not probed yet
Would the pm callbacks be registered by then?

> +	 * - not the main device. We don't support power management on
> +	 *   subdevices (e.g. context banks)
I'm not sure registering context banks as different kinds of devices
within the same driver is a good idea, this seems rather convoluted.

> +	 */
> +	if (!dev || !dev->driver || !is_video_device(dev))
> +		return 0;
> +
> +	core = dev_get_drvdata(dev);
> +	if (!core) {
> +		d_vpr_e("%s: invalid core\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	core_lock(core, __func__);
> +	allow = msm_vidc_allow_pm_suspend(core);
> +
> +	if (allow == MSM_VIDC_IGNORE) {
> +		d_vpr_h("%s: pm already suspended\n", __func__);
> +		msm_vidc_change_core_sub_state(core, 0, CORE_SUBSTATE_PM_SUSPEND, __func__);
> +		rc = 0;
> +		goto unlock;
> +	} else if (allow != MSM_VIDC_ALLOW) {
> +		d_vpr_h("%s: pm suspend not allowed\n", __func__);
> +		rc = 0;
> +		goto unlock;
> +	}
> +
> +	rc = msm_vidc_suspend(core);
> +	if (rc == -EOPNOTSUPP)
> +		rc = 0;
> +	else if (rc)
> +		d_vpr_e("Failed to suspend: %d\n", rc);
> +	else
> +		msm_vidc_change_core_sub_state(core, 0, CORE_SUBSTATE_PM_SUSPEND, __func__);
> +
> +unlock:
> +	core_unlock(core, __func__);
> +	return rc;
> +}
> +
> +static int msm_vidc_pm_resume(struct device *dev)
Same comments as in _suspend

Konrad
