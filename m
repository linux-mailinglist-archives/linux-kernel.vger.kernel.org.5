Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932B77C001
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjHNSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjHNSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:50:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336EFF1;
        Mon, 14 Aug 2023 11:50:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EFLHXG004094;
        Mon, 14 Aug 2023 18:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y0tXFSQt6Q6mC011Uhso/Nep0P1TdImpJDek4FAkT10=;
 b=kxPRUs4frpjIuZkkSVwaUWZjgKQkGS5uhC7M+dSKgpsd7N6gWaqV5b4vcJtrlIQlfCeS
 PFY0M3SR8NbfAccEXEQpB/05SLAf6KpVb9z/XouCIoSk8pr1JMMXNzu1xmAW+i6n2We7
 o1aFSc2ZbptJAex0YkFk59pl+zT0VTHyorOvQROIMH/2ux8TrqAiDKeT1yLC2sWoUwGR
 96KxzHb3lzRzUqVwu9XPqDR16UtdexUcc6EOG27jt4vLXeBeF9kTnyngfeQN5BQk3LGP
 PPMX+b/Lc3HonCOmstBtLRKorXCNiBpUHg0qtC6oy3HG22PiXYtsQJGPbbLSWY+InhlG PQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3tymm60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:50:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EIo7BV008376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:50:07 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 11:50:03 -0700
Message-ID: <1c8f7cb2-9536-39f7-05ba-a568b3d3be5f@quicinc.com>
Date:   Tue, 15 Aug 2023 00:19:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
 <c6a094bc-3032-cfe7-d24b-6e83f53e1771@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <c6a094bc-3032-cfe7-d24b-6e83f53e1771@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 11ArUq0RraRB7aD4_RvrP2WxLJVL_992
X-Proofpoint-ORIG-GUID: 11ArUq0RraRB7aD4_RvrP2WxLJVL_992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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



On 7/28/2023 7:15 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements the platform driver methods, file
>> operations and v4l2 registration.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
> [...]
> 
>> +struct msm_vidc_core *g_core;
>> +
>> +static inline bool is_video_device(struct device *dev)
>> +{
>> +	return !!(of_device_is_compatible(dev->of_node, "qcom,sm8550-vidc"));
>> +}
> Are you expecting this to be expanded each time support for new SoC is added?
> 
I understand the concern here.
Will remove this API in next version.
>> +
>> +static inline bool is_video_context_bank_device(struct device *dev)
>> +{
>> +	return !!(of_device_is_compatible(dev->of_node, "qcom,vidc,cb-ns"));
>> +}
>> +
>> +static int msm_vidc_init_resources(struct msm_vidc_core *core)
>> +{
>> +	struct msm_vidc_resource *res = NULL;
> No need to initialize, you use it right after defining.
Agree, will remove.
> 
>> +	int rc = 0;
> I think 'ret' is more common for a return-value-holding variable.
> 
Agree, will replace 'rc' with 'ret' in all APIs in next version
>> +
>> +	res = devm_kzalloc(&core->pdev->dev, sizeof(*res), GFP_KERNEL);
>> +	if (!res) {
>> +		d_vpr_e("%s: failed to alloc memory for resource\n", __func__);
>> +		return -ENOMEM;
>> +	}
>> +	core->resource = res;
> I don't think the 'res' variable makes sense.
> 
Sure, Will update, res->resource
>> +
>> +	rc = call_res_op(core, init, core);
>> +	if (rc) {
>> +		d_vpr_e("%s: Failed to init resources: %d\n", __func__, rc);
>> +		return rc;
> you can omit this line and return rc/ret at the last line of this func.
> 
The abstraction layer for resource is not required so this API will be
changed in next version, will take care of return values as well.
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id msm_vidc_dt_match[] = {
>> +	{.compatible = "qcom,sm8550-vidc"},
> { .compatible = .... " },
> 
>> +	{.compatible = "qcom,vidc,cb-ns"},
>> +	MSM_VIDC_EMPTY_BRACE
> why?
> 
Right, it's not needed, Will replace with {}
>> +};
>> +MODULE_DEVICE_TABLE(of, msm_vidc_dt_match);
>> +
>> +static void msm_vidc_release_video_device(struct video_device *vdev)
>> +{
>> +	d_vpr_e("%s: video device released\n", __func__);
>> +}
> Doesn't sound too useful? And definitely not with an error print?
> 
The device structure is embedded in the core structure, so driver needs to
set the release() callback. hence this API is required.
This API doesn't free anything here because the core struture will be freed
when device is removed.
Will remove error print in next version.
>> +
>> +static void msm_vidc_unregister_video_device(struct msm_vidc_core *core,
>> +					     enum msm_vidc_domain_type type)
>> +{
>> +	int index;
>> +
>> +	if (type == MSM_VIDC_DECODER)
> I'm not sure this is defined.
> 
>> +		index = 0;
>> +	else if (type == MSM_VIDC_ENCODER)
> Or this.
> 
These macros are defined in [1]

[1]:
https://patchwork.linuxtv.org/project/linux-media/patch/1690550624-14642-18-git-send-email-quic_vgarodia@quicinc.com/

> Can't we just assign index = MSM_VIDC_EN/DECODER?
> these are bitmasks hence can not be used as array index and the bitmask
values are being used in driver at multiple places.
>> +		index = 1;
>> +	else
>> +		return;
>> +
>> +	v4l2_m2m_release(core->vdev[index].m2m_dev);
>> +
>> +	video_set_drvdata(&core->vdev[index].vdev, NULL);
>> +	video_unregister_device(&core->vdev[index].vdev);
>> +}
>> +
>> +static int msm_vidc_register_video_device(struct msm_vidc_core *core,
>> +					  enum msm_vidc_domain_type type, int nr)
>> +{
>> +	int rc = 0;
>> +	int index;
>> +
>> +	d_vpr_h("%s: domain %d\n", __func__, type);
>> +
>> +	if (type == MSM_VIDC_DECODER)
>> +		index = 0;
>> +	else if (type == MSM_VIDC_ENCODER)
>> +		index = 1;
>> +	else
>> +		return -EINVAL;
>> +
>> +	core->vdev[index].vdev.release =
>> +		msm_vidc_release_video_device;
>> +	core->vdev[index].vdev.fops = core->v4l2_file_ops;
>> +	if (type == MSM_VIDC_DECODER)
>> +		core->vdev[index].vdev.ioctl_ops = core->v4l2_ioctl_ops_dec;
>> +	else
>> +		core->vdev[index].vdev.ioctl_ops = core->v4l2_ioctl_ops_enc;
>> +	core->vdev[index].vdev.vfl_dir = VFL_DIR_M2M;
>> +	core->vdev[index].type = type;
>> +	core->vdev[index].vdev.v4l2_dev = &core->v4l2_dev;
>> +	core->vdev[index].vdev.device_caps = core->capabilities[DEVICE_CAPS].value;
>> +	rc = video_register_device(&core->vdev[index].vdev,
>> +				   VFL_TYPE_VIDEO, nr);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register the video device\n");
>> +		return rc;
>> +	}
>> +	video_set_drvdata(&core->vdev[index].vdev, core);
>> +
>> +	core->vdev[index].m2m_dev = v4l2_m2m_init(core->v4l2_m2m_ops);
>> +	if (IS_ERR(core->vdev[index].m2m_dev)) {
>> +		d_vpr_e("Failed to initialize V4L2 M2M device\n");
>> +		rc = PTR_ERR(core->vdev[index].m2m_dev);
>> +		goto m2m_init_failed;
>> +	}
>> +
>> +	return 0;
>> +
>> +m2m_init_failed:
>> +	video_unregister_device(&core->vdev[index].vdev);
>> +	return rc;
>> +}
>> +
>> +static int msm_vidc_deinitialize_core(struct msm_vidc_core *core)
>> +{
>> +	int rc = 0;
>> +
>> +	if (!core) {
> Are we expecting to ever hit this?
> 
True, it's highly unlikely that we hit this, will remove the check.
>> +		d_vpr_e("%s: invalid params\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_destroy(&core->lock);
>> +	msm_vidc_update_core_state(core, MSM_VIDC_CORE_DEINIT, __func__);
> Not defined.
> 
it is defined in [2]

>> +
>> +	if (core->batch_workq)
>> +		destroy_workqueue(core->batch_workq);
>> +
>> +	if (core->pm_workq)
>> +		destroy_workqueue(core->pm_workq);
>> +
>> +	core->batch_workq = NULL;
>> +	core->pm_workq = NULL;
>> +
>> +	return rc;
>> +}
>> +
>> +static int msm_vidc_initialize_core(struct msm_vidc_core *core)
>> +{
>> +	int rc = 0;
>> +
>> +	msm_vidc_update_core_state(core, MSM_VIDC_CORE_DEINIT, __func__);
> Not defined.
> 
it is defined in [2]

[2]:
https://patchwork.linuxtv.org/project/linux-media/patch/1690550624-14642-15-git-send-email-quic_vgarodia@quicinc.com/
>> +
>> +	core->pm_workq = create_singlethread_workqueue("pm_workq");
>> +	if (!core->pm_workq) {
>> +		d_vpr_e("%s: create pm workq failed\n", __func__);
>> +		rc = -EINVAL;
>> +		goto exit;
>> +	}
>> +
>> +	core->batch_workq = create_singlethread_workqueue("batch_workq");
>> +	if (!core->batch_workq) {
>> +		d_vpr_e("%s: create batch workq failed\n", __func__);
>> +		rc = -EINVAL;
>> +		goto exit;
>> +	}
>> +
>> +	core->packet_size = VIDC_IFACEQ_VAR_HUGE_PKT_SIZE;
>> +	core->packet = devm_kzalloc(&core->pdev->dev, core->packet_size, GFP_KERNEL);
>> +	if (!core->packet) {
>> +		d_vpr_e("%s: failed to alloc core packet\n", __func__);
>> +		rc = -ENOMEM;
>> +		goto exit;
>> +	}
>> +
>> +	core->response_packet = devm_kzalloc(&core->pdev->dev, core->packet_size, GFP_KERNEL);
>> +	if (!core->packet) {
>> +		d_vpr_e("%s: failed to alloc core response packet\n", __func__);
>> +		rc = -ENOMEM;
>> +		goto exit;
>> +	}
>> +
>> +	mutex_init(&core->lock);
>> +	INIT_LIST_HEAD(&core->instances);
>> +	INIT_LIST_HEAD(&core->dangling_instances);
>> +
>> +	INIT_DELAYED_WORK(&core->pm_work, venus_hfi_pm_work_handler);
>> +	INIT_DELAYED_WORK(&core->fw_unload_work, msm_vidc_fw_unload_handler);
>> +
>> +	return 0;
> Either return rc/ret here or don't initialize it at definition.
> 
Sure, Will fix it.
>> +exit:
>> +	if (core->batch_workq)
>> +		destroy_workqueue(core->batch_workq);
>> +	if (core->pm_workq)
>> +		destroy_workqueue(core->pm_workq);
>> +	core->batch_workq = NULL;
>> +	core->pm_workq = NULL;
>> +
>> +	return rc;
>> +}
> [...]
> 
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
> Would the pm callbacks be registered by then?
> 
>> +	 * - not the main device. We don't support power management on
>> +	 *   subdevices (e.g. context banks)
> I'm not sure registering context banks as different kinds of devices
> within the same driver is a good idea, this seems rather convoluted.
> 
Sure, will remove the separate probe for context bank in next version.
>> +	 */
>> +	if (!dev || !dev->driver || !is_video_device(dev))
>> +		return 0;
>> +
>> +	core = dev_get_drvdata(dev);
>> +	if (!core) {
>> +		d_vpr_e("%s: invalid core\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	core_lock(core, __func__);
>> +	allow = msm_vidc_allow_pm_suspend(core);
>> +
>> +	if (allow == MSM_VIDC_IGNORE) {
>> +		d_vpr_h("%s: pm already suspended\n", __func__);
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
>> +static int msm_vidc_pm_resume(struct device *dev)
> Same comments as in _suspend
> 
> Konrad
