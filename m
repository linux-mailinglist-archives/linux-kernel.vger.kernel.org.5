Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E282D77C043
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHNTBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjHNTAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:00:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404510F9;
        Mon, 14 Aug 2023 12:00:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGJiOm024444;
        Mon, 14 Aug 2023 19:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tfoHIs0i4rXK1LvTUxqXB9AumTQgIMnkB7DStQlHNKs=;
 b=He5YAnFUL+CAvhQXranehwEF9k20Uy7UVPI66CyY1g6HeuwAE1kzMyb/ILTI0XRbN4VE
 qcAapeHJLSmlKJXT7hJoOUdoSaASN8Ef65quarFQ+bjbj5L70eSI4Ze22nwIg5nyN1P3
 BcrkPCJrI0wPvI/yolbbnK0FCGdQoJqSSH40bmWQ04r+gHg1Dk8+vW8B3HrVSStVsMRh
 xzwc68xjI5JgVqhWv5FyjuNNCvwGYiP+avqwZA5cbelRwxP5Mb6clgNJqgM4gsXj95OS
 FebWmY+TYhBS4ZlE+wtnG0zeR4W1xfBIhz0ZjvdyR4mAujWWN0nvyU1bQiJCPJTyJyNW zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfqp1ga91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:00:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJ0eDG007017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:00:40 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:00:36 -0700
Message-ID: <cd9bcde6-eb00-2576-438e-926a99e22d08@quicinc.com>
Date:   Tue, 15 Aug 2023 00:30:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/33] iris: vidc: add v4l2 wrapper file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
 <aaf1aba2-a757-d9c8-77c9-182ed1aaed35@kernel.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <aaf1aba2-a757-d9c8-77c9-182ed1aaed35@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vlGSeklyFO_OqG3wIurEZ6Kkt51UAAva
X-Proofpoint-ORIG-GUID: vlGSeklyFO_OqG3wIurEZ6Kkt51UAAva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140176
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 2:53 AM, Krzysztof Kozlowski wrote:
> On 28/07/2023 15:23, Vikash Garodia wrote:
>> Here is the implementation of v4l2 wrapper functions for all
>> v4l2 IOCTLs.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |  77 ++
>>  .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    | 953 +++++++++++++++++++++
>>  2 files changed, 1030 insertions(+)
>>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
>>
>> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>> new file mode 100644
>> index 0000000..3766c9d
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _MSM_VIDC_V4L2_H_
>> +#define _MSM_VIDC_V4L2_H_
>> +
>> +#include <linux/fs.h>
>> +#include <linux/poll.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-dev.h>
>> +#include <media/v4l2-ioctl.h>
>> +
>> +int msm_v4l2_open(struct file *filp);
>> +int msm_v4l2_close(struct file *filp);
>> +int msm_v4l2_querycap(struct file *filp, void *fh,
>> +		      struct v4l2_capability *cap);
>> +int msm_v4l2_enum_fmt(struct file *file, void *fh,
>> +		      struct v4l2_fmtdesc *f);
>> +int msm_v4l2_try_fmt(struct file *file, void *fh,
>> +		     struct v4l2_format *f);
>> +int msm_v4l2_s_fmt(struct file *file, void *fh,
>> +		   struct v4l2_format *f);
>> +int msm_v4l2_g_fmt(struct file *file, void *fh,
>> +		   struct v4l2_format *f);
>> +int msm_v4l2_s_selection(struct file *file, void *fh,
>> +			 struct v4l2_selection *s);
>> +int msm_v4l2_g_selection(struct file *file, void *fh,
>> +			 struct v4l2_selection *s);
>> +int msm_v4l2_s_parm(struct file *file, void *fh,
>> +		    struct v4l2_streamparm *a);
>> +int msm_v4l2_g_parm(struct file *file, void *fh,
>> +		    struct v4l2_streamparm *a);
>> +int msm_v4l2_reqbufs(struct file *file, void *fh,
>> +		     struct v4l2_requestbuffers *b);
>> +int msm_v4l2_querybuf(struct file *file, void *fh,
>> +		      struct v4l2_buffer *b);
>> +int msm_v4l2_create_bufs(struct file *filp, void *fh,
>> +			 struct v4l2_create_buffers *b);
>> +int msm_v4l2_prepare_buf(struct file *filp, void *fh,
>> +			 struct v4l2_buffer *b);
>> +int msm_v4l2_qbuf(struct file *file, void *fh,
>> +		  struct v4l2_buffer *b);
>> +int msm_v4l2_dqbuf(struct file *file, void *fh,
>> +		   struct v4l2_buffer *b);
>> +int msm_v4l2_streamon(struct file *file, void *fh,
>> +		      enum v4l2_buf_type i);
>> +int msm_v4l2_streamoff(struct file *file, void *fh,
>> +		       enum v4l2_buf_type i);
>> +int msm_v4l2_subscribe_event(struct v4l2_fh *fh,
>> +			     const struct v4l2_event_subscription *sub);
>> +int msm_v4l2_unsubscribe_event(struct v4l2_fh *fh,
>> +			       const struct v4l2_event_subscription *sub);
>> +int msm_v4l2_try_decoder_cmd(struct file *file, void *fh,
>> +			     struct v4l2_decoder_cmd *enc);
>> +int msm_v4l2_decoder_cmd(struct file *file, void *fh,
>> +			 struct v4l2_decoder_cmd *dec);
>> +int msm_v4l2_try_encoder_cmd(struct file *file, void *fh,
>> +			     struct v4l2_encoder_cmd *enc);
>> +int msm_v4l2_encoder_cmd(struct file *file, void *fh,
>> +			 struct v4l2_encoder_cmd *enc);
>> +int msm_v4l2_enum_framesizes(struct file *file, void *fh,
>> +			     struct v4l2_frmsizeenum *fsize);
>> +int msm_v4l2_enum_frameintervals(struct file *file, void *fh,
>> +				 struct v4l2_frmivalenum *fival);
>> +int msm_v4l2_queryctrl(struct file *file, void *fh,
>> +		       struct v4l2_queryctrl *ctrl);
>> +int msm_v4l2_querymenu(struct file *file, void *fh,
>> +		       struct v4l2_querymenu *qmenu);
>> +unsigned int msm_v4l2_poll(struct file *filp,
>> +			   struct poll_table_struct *pt);
>> +void msm_v4l2_m2m_device_run(void *priv);
>> +void msm_v4l2_m2m_job_abort(void *priv);
>> +
>> +#endif // _MSM_VIDC_V4L2_H_
>> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
>> new file mode 100644
>> index 0000000..6dfb18b
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
>> @@ -0,0 +1,953 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "msm_vidc.h"
>> +#include "msm_vidc_core.h"
>> +#include "msm_vidc_debug.h"
>> +#include "msm_vidc_driver.h"
>> +#include "msm_vidc_inst.h"
>> +#include "msm_vidc_internal.h"
>> +#include "msm_vidc_v4l2.h"
>> +
>> +static struct msm_vidc_inst *get_vidc_inst(struct file *filp, void *fh)
>> +{
>> +	if (!filp || !filp->private_data)
>> +		return NULL;
>> +	return container_of(filp->private_data,
>> +					struct msm_vidc_inst, fh);
>> +}
>> +
>> +unsigned int msm_v4l2_poll(struct file *filp, struct poll_table_struct *pt)
>> +{
>> +	int poll = 0;
>> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, NULL);
>> +
>> +	inst = get_inst_ref(g_core, inst);
>> +	if (!inst) {
>> +		d_vpr_e("%s: invalid instance\n", __func__);
> 
> This does not look like Linux coding style. Don't create your own
> abstraction layer over Linux internal API. Use standard Linux functions
> which will behave better and scale along with kernel development.
> 
I understand. these custom debug wrappers will be removed in next version.
>> +		return POLLERR;
>> +	}
>> +	if (is_session_error(inst)) {
>> +		i_vpr_e(inst, "%s: inst in error state\n", __func__);
> 
> i_vpr_e is so obvious for every kernel developer... Please, no.
> 
>> +		poll = POLLERR;
>> +		goto exit;
>> +	}
>> +
>> +	poll = msm_vidc_poll((void *)inst, filp, pt);
>> +	if (poll)
>> +		goto exit;
>> +
>> +exit:
>> +	put_inst(inst);
>> +	return poll;
>> +}
>> +
>> +int msm_v4l2_open(struct file *filp)
>> +{
>> +	struct video_device *vdev = video_devdata(filp);
>> +	struct msm_video_device *vid_dev =
>> +		container_of(vdev, struct msm_video_device, vdev);
>> +	struct msm_vidc_core *core = video_drvdata(filp);
>> +	struct msm_vidc_inst *inst;
>> +
>> +	inst = msm_vidc_open(core, vid_dev->type);
>> +	if (!inst) {
>> +		d_vpr_e("Failed to create instance, type = %d\n",
>> +			vid_dev->type);
>> +		return -ENOMEM;
>> +	}
>> +	filp->private_data = &inst->fh;
>> +	return 0;
>> +}
>> +
>> +int msm_v4l2_close(struct file *filp)
>> +{
>> +	int rc = 0;
>> +	struct msm_vidc_inst *inst;
>> +
>> +	inst = get_vidc_inst(filp, NULL);
>> +	if (!inst) {
>> +		d_vpr_e("%s: invalid instance\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = msm_vidc_close(inst);
>> +	filp->private_data = NULL;
>> +	return rc;
>> +}
>> +
>> +int msm_v4l2_querycap(struct file *filp, void *fh,
>> +		      struct v4l2_capability *cap)
>> +{
>> +	struct msm_vidc_inst *inst = get_vidc_inst(filp, fh);
>> +	int rc = 0;
>> +
>> +	inst = get_inst_ref(g_core, inst);
>> +	if (!inst || !cap) {
>> +		d_vpr_e("%s: invalid instance\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	client_lock(inst, __func__);
> 
> ? So we don't know what's this? Mutex? Spinlock? Own reinvented lock?
> 
>> +	inst_lock(inst, __func__);
> 
> Neither this?
> 
> No, don't create your own abstractions over standard API.
Sure, will remove these custom wrappers and use standard API directly in
next version.
> 
> Best regards,
> Krzysztof
> 
