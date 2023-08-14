Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EDD77C01A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHNSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjHNSyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:54:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC57E77;
        Mon, 14 Aug 2023 11:54:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EFLi0C028403;
        Mon, 14 Aug 2023 18:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4y6Z5Ijpr9XAW6wDb7tS0T7kaxn/F6CZ2MPRoMDHMpQ=;
 b=l5FOy5mTKqpHcXcDQ2zhOswN/LiQMhaCvxlFpy4Sj6tPPXaaKgPfbNkmCs9d2B8w9lC3
 ZlxpUMNUWIMt+jSdbAOYGNO6/XLcbbfxNfJSwtpxP+hbLUBvPKgdxR8k7FuXGAmiD4Ox
 Fe+h03AsXZbrFSDufBrtoyhGSGVFnewPpgWlPCIzc+zMymUyXBNnLCQ+8324LHM2uU/M
 hssSPm3pa7RmAxXJZzTqB9YDyS0ZbWSp/SnsqnUjKaq39A1gmj55cW6l4AZmv+lfDEej
 ucc4pkF/fuihnimSA67L213uZOnnKXzRiV9IYBhowvOiuWMk4PHfQpJmwjBAuM/50yL3 8A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3srvjuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:54:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EIsgrF021284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:54:42 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 11:54:38 -0700
Message-ID: <18ee06b6-65bc-a320-f06c-7d18ed29c739@quicinc.com>
Date:   Tue, 15 Aug 2023 00:24:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
 <0149fcd0-e64b-f155-05d8-f32a78d7e83b@kernel.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <0149fcd0-e64b-f155-05d8-f32a78d7e83b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G-elZpyrUOtWsi9jl6Has0YH6s3ogisJ
X-Proofpoint-ORIG-GUID: G-elZpyrUOtWsi9jl6Has0YH6s3ogisJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 2:46 AM, Krzysztof Kozlowski wrote:
> On 28/07/2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements the platform driver methods, file
>> operations and v4l2 registration.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   | 660 +++++++++++++++++++++
>>  1 file changed, 660 insertions(+)
>>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
>>
>> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
>> new file mode 100644
>> index 0000000..43439cb
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_probe.c
>> @@ -0,0 +1,660 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/stringify.h>
>> +#include <linux/version.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "msm_vidc_core.h"
>> +#include "msm_vidc_debug.h"
>> +#include "msm_vidc_driver.h"
>> +#include "msm_vidc_internal.h"
>> +#include "msm_vidc_memory.h"
>> +#include "msm_vidc_platform.h"
>> +#include "msm_vidc_state.h"
>> +#include "venus_hfi.h"
>> +
>> +#define BASE_DEVICE_NUMBER 32
>> +
>> +struct msm_vidc_core *g_core;
>> +
>> +static inline bool is_video_device(struct device *dev)
>> +{
>> +	return !!(of_device_is_compatible(dev->of_node, "qcom,sm8550-vidc"));
> 
> Where is it documented? Are you 100% sure that checkpatch does not complain?
We ran the checkpatch on this series with DT binding hence no issues were
reported.
DT binding was missed in this version and will be part of next version.
> 
> I is also a bit surprising to see of_device_is_compatible inside the
> code in some random place. How does it scale? Any driver data and
> variant checks should be done via helpers and driver data, not putting
> compatibles in multiple places.
> 
I understand the concern here, this API will be removed in next version.
> 
>> +}
>> +
>> +static inline bool is_video_context_bank_device(struct device *dev)
>> +{
>> +	return !!(of_device_is_compatible(dev->of_node, "qcom,vidc,cb-ns"));
>> +}
>> +
>> +static int msm_vidc_init_resources(struct msm_vidc_core *core)
>> +{
>> +	struct msm_vidc_resource *res = NULL;
>> +	int rc = 0;
>> +
>> +	res = devm_kzalloc(&core->pdev->dev, sizeof(*res), GFP_KERNEL);
>> +	if (!res) {
>> +		d_vpr_e("%s: failed to alloc memory for resource\n", __func__);
>> +		return -ENOMEM;
>> +	}
>> +	core->resource = res;
>> +
>> +	rc = call_res_op(core, init, core);
>> +	if (rc) {
>> +		d_vpr_e("%s: Failed to init resources: %d\n", __func__, rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id msm_vidc_dt_match[] = {
>> +	{.compatible = "qcom,sm8550-vidc"},
>> +	{.compatible = "qcom,vidc,cb-ns"},
> 
> No, srsly, where did you document it?
> 
> If this is not suitable for upstreaming (as it looks like) mark it as
> RFC, so we will know it that you did not run checkpatch...
> 
> 
>> +	MSM_VIDC_EMPTY_BRACE
>> +};
>> +MODULE_DEVICE_TABLE(of, msm_vidc_dt_match);
>> +
>> +static void msm_vidc_release_video_device(struct video_device *vdev)
>> +{
>> +	d_vpr_e("%s: video device released\n", __func__);
> 
> And why would you ever print anything here? What's wrong with tracing?
> 
Sure, I understand having the debug msg here doesn't help, will remove it
in next version.
>> +}
> 
> ...
> 
>> +
>> +static int msm_vidc_probe_video_device(struct platform_device *pdev)
>> +{
>> +	int rc = 0;
>> +	struct msm_vidc_core *core = NULL;
>> +	int nr = BASE_DEVICE_NUMBER;
>> +
>> +	d_vpr_h("%s: %s\n", __func__, dev_name(&pdev->dev));
> 
> No debug prints reinventing tracing.
> 
Sure, all custom debug wrappers will be removed in next series.
>> +
>> +	core = devm_kzalloc(&pdev->dev, sizeof(struct msm_vidc_core), GFP_KERNEL);
>> +	if (!core) {
>> +		d_vpr_e("%s: failed to alloc memory for core\n", __func__);
> 
> Ooops, this for sure did not pass any checks by tools. Sorry, please run
> basic checks like coccinelle, smatch, sparse, W=1 builds.
> 
we ran check patch and smatch on this code but no errors were reported.
please elaborate what issue you see with above code?
>> +		return -ENOMEM;
>> +	}
>> +	g_core = core;
>> +
>> +	core->pdev = pdev;
>> +	dev_set_drvdata(&pdev->dev, core);
>> +
>> +	core->debugfs_parent = msm_vidc_devm_debugfs_get(&pdev->dev);
>> +	if (!core->debugfs_parent)
>> +		d_vpr_h("Failed to create debugfs for msm_vidc\n");
>> +
>> +	rc = msm_vidc_devm_init_core(&pdev->dev, core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init core failed with %d\n", __func__, rc);
>> +		goto init_core_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_platform(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init platform failed with %d\n", __func__, rc);
>> +		rc = -EINVAL;
>> +		goto init_plat_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_resources(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init resource failed with %d\n", __func__, rc);
>> +		goto init_res_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_core_caps(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init core caps failed with %d\n", __func__, rc);
>> +		goto init_res_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_instance_caps(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init inst cap failed with %d\n", __func__, rc);
>> +		goto init_inst_caps_fail;
>> +	}
>> +
>> +	core->debugfs_root = msm_vidc_debugfs_init_core(core);
>> +	if (!core->debugfs_root)
>> +		d_vpr_h("Failed to init debugfs core\n");
>> +
>> +	d_vpr_h("populating sub devices\n");
>> +	/*
>> +	 * Trigger probe for each sub-device i.e. qcom,msm-vidc,context-bank.
>> +	 * When msm_vidc_probe is called for each sub-device, parse the
>> +	 * context-bank details.
>> +	 */
>> +	rc = of_platform_populate(pdev->dev.of_node, msm_vidc_dt_match, NULL,
>> +				  &pdev->dev);
>> +	if (rc) {
>> +		d_vpr_e("Failed to trigger probe for sub-devices\n");
>> +		goto sub_dev_failed;
>> +	}
>> +
>> +	rc = v4l2_device_register(&pdev->dev, &core->v4l2_dev);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register v4l2 device\n");
>> +		goto v4l2_reg_failed;
>> +	}
>> +
>> +	/* setup the decoder device */
>> +	rc = msm_vidc_register_video_device(core, MSM_VIDC_DECODER, nr);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register video decoder\n");
>> +		goto dec_reg_failed;
>> +	}
>> +
>> +	/* setup the encoder device */
>> +	rc = msm_vidc_register_video_device(core, MSM_VIDC_ENCODER, nr + 1);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register video encoder\n");
>> +		goto enc_reg_failed;
>> +	}
>> +
>> +	rc = venus_hfi_queue_init(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: interface queues init failed\n", __func__);
>> +		goto queues_init_failed;
>> +	}
>> +
>> +	rc = msm_vidc_core_init(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: sys init failed\n", __func__);
>> +		goto core_init_failed;
>> +	}
>> +
>> +	d_vpr_h("%s(): succssful\n", __func__);
>> +
>> +	return rc;
>> +
>> +core_init_failed:
>> +	venus_hfi_queue_deinit(core);
>> +queues_init_failed:
>> +	of_platform_depopulate(&pdev->dev);
>> +sub_dev_failed:
>> +	msm_vidc_unregister_video_device(core, MSM_VIDC_ENCODER);
>> +enc_reg_failed:
>> +	msm_vidc_unregister_video_device(core, MSM_VIDC_DECODER);
>> +dec_reg_failed:
>> +	v4l2_device_unregister(&core->v4l2_dev);
>> +v4l2_reg_failed:
>> +init_inst_caps_fail:
>> +init_res_failed:
>> +init_plat_failed:
>> +init_core_failed:
>> +	dev_set_drvdata(&pdev->dev, NULL);
>> +	g_core = NULL;
>> +
>> +	return rc;
>> +}
>> +
>> +static int msm_vidc_probe_context_bank(struct platform_device *pdev)
>> +{
>> +	struct msm_vidc_core *core = NULL;
>> +	int rc = 0;
>> +
>> +	if (!pdev) {
>> +		d_vpr_e("%s: Invalid platform device %pK", __func__, pdev);
>> +		return -EINVAL;
>> +	} else if (!pdev->dev.parent) {
>> +		d_vpr_e("%s: Failed to find a parent for %s\n",
>> +			__func__, dev_name(&pdev->dev));
>> +		return -ENODEV;
>> +	}
>> +
>> +	d_vpr_h("%s(): %s\n", __func__, dev_name(&pdev->dev));
>> +
>> +	core = dev_get_drvdata(pdev->dev.parent);
>> +	if (!core) {
>> +		d_vpr_e("%s: core not found in device %s",
>> +			__func__, dev_name(pdev->dev.parent));
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = msm_vidc_setup_context_bank(core, &pdev->dev);
>> +	if (rc) {
>> +		d_vpr_e("%s: Failed to probe context bank %s\n",
>> +			__func__, dev_name(&pdev->dev));
>> +		return rc;
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static int msm_vidc_probe(struct platform_device *pdev)
>> +{
>> +	if (!pdev) {
>> +		d_vpr_e("%s: invalid params\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Sub devices probe will be triggered by of_platform_populate() towards
>> +	 * the end of the probe function after msm-vidc device probe is
>> +	 * completed. Return immediately after completing sub-device probe.
>> +	 */
>> +	if (is_video_device(&pdev->dev))
>> +		return msm_vidc_probe_video_device(pdev);
>> +	else if (is_video_context_bank_device(&pdev->dev))
>> +		return msm_vidc_probe_context_bank(pdev);
>> +
>> +	/* How did we end up here? */
>> +	WARN_ON(1);
>> +	return -EINVAL;
>> +}
>> +
>> +static int msm_vidc_pm_suspend(struct device *dev)
>> +{
>> +	int rc = 0;
>> +	struct msm_vidc_core *core;
>> +	enum msm_vidc_allow allow = MSM_VIDC_DISALLOW;
>> +
>> +	/*
>> +	 * Bail out if
>> +	 * - driver possibly not probed yet
>> +	 * - not the main device. We don't support power management on
>> +	 *   subdevices (e.g. context banks)
>> +	 */
>> +	if (!dev || !dev->driver || !is_video_device(dev))
>> +		return 0;
>> +
>> +	core = dev_get_drvdata(dev);
>> +	if (!core) {
>> +		d_vpr_e("%s: invalid core\n", __func__);
> 
> How core can be invalid?
> 
Agree! core can't be NULL here as driver data won't be invalid if device
still exist.
will remove this NULL check.
>> +		return -EINVAL;
>> +	}
>> +
>> +	core_lock(core, __func__);
> 
> What's this? Why do you use some custom locking (it's almost never a
> good idea)?
> 
Sure, will remove these custom wrapper for locks and use standard
mutex_lock/unlock APIs directly.
>> +	allow = msm_vidc_allow_pm_suspend(core);
>> +
>> +	if (allow == MSM_VIDC_IGNORE) {
>> +		d_vpr_h("%s: pm already suspended\n", __func__);
> 
> So you have bug in PM runtime code? Runtime PM does not suspend devices
> twice.
>core is power collapsed in case of idle state when there is no processing
happening by hardware, this can also change the core state to power_disable.
this check is ensuring if the core is already in power disable state due to
that, then no need to suspend it again.

>> +		msm_vidc_change_core_sub_state(core, 0, CORE_SUBSTATE_PM_SUSPEND, __func__);
>> +		rc = 0;
>> +		goto unlock;
>> +	} else if (allow != MSM_VIDC_ALLOW) {
>> +		d_vpr_h("%s: pm suspend not allowed\n", __func__);
>> +		rc = 0;
>> +		goto unlock;
>> +	}
>> +
>> +	rc = msm_vidc_suspend(core);
>> +	if (rc == -EOPNOTSUPP)
>> +		rc = 0;
>> +	else if (rc)
>> +		d_vpr_e("Failed to suspend: %d\n", rc);
>> +	else
>> +		msm_vidc_change_core_sub_state(core, 0, CORE_SUBSTATE_PM_SUSPEND, __func__);
>> +
>> +unlock:
>> +	core_unlock(core, __func__);
>> +	return rc;
>> +}
>> +
> 
> Best regards,
> Krzysztof
> 
