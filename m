Return-Path: <linux-kernel+bounces-61201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7E850EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502A71F25A93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C5F503;
	Mon, 12 Feb 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a29Nh45J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93968EAE3;
	Mon, 12 Feb 2024 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726694; cv=none; b=BrMExHSCIKOM5QgPnYVzVfez4byrIZGVhDjCtDEDB8vueOUoum7JNuz4AkUq/gsCTZ3FD5s/n9hjd9z7hUXg2You8OCc8RKLFZ7SL9zof6xBH3Tv5oEBhPu+A2rClK5nNBpJLNrOHS9z98AHEmG+lqOGmqGinBcDgQ/7SgNXpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726694; c=relaxed/simple;
	bh=GUQ7DQ7kwxgM4WTXtFcH6Oix95LRGDfvMgsxii8Jykk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgogmfyIsGtqPkgiOBrF7jzOcmPOtAGGSuXk+OdPbGzX7DoI2r752ZhayB2JyLtXSjkynnAg7+MZZ6ckll+finmJ7hBjlq6FHwr8Gan3MLjFwRAeVW+YebRaOluOWeFGbAmMD8zYXMqxK0S6EfUnLdb5tOwlLhcIFdpJQg2YK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a29Nh45J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C7H3qk016634;
	Mon, 12 Feb 2024 08:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yTucRgJBo8/A2HJgMuT0wk4I588NU1na//7P6y/aNPk=; b=a2
	9Nh45JxZloEui01KURYGocIYMN0gHENQPRQGYx1cXWOi5VnS3HY29VaOUcmNNjPc
	YNgAIJ+vWOSbk+P3VQ82NnSXgY71ookF9dngk8V+qpaGXdaXbjNy/eAZaO5A9Ycy
	uzRviVgzgNiwBbUhnRRh6AfcK+Te4VYnx1e2uMc4DnbRSYViG7j9O4S33nq+Ooiy
	rGTkP0O6bamAJSMbR60l4Z0MVD6hXRlQzszQY4Kt2m1P3czaR3u/7sdbrxYDf+c9
	tf4X0WlC0Aye9fAuWgXl3RiKgWh2vFJ26Qf5cIPnOMTyXHlEQkscbIIhyse0K9mB
	BwMb6ckym1S5WEZ6zXUA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62ps2rys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 08:31:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C8VNOB016583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 08:31:23 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 00:31:19 -0800
Message-ID: <a777f419-05a5-fecc-b51c-fa442502ac47@quicinc.com>
Date: Mon, 12 Feb 2024 14:01:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        Amir Vajid <avajid@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com>
 <CAA8EJpqUgqHfMOZip58yGpt6S3XSBz+9BeXZSL_JmWar_JbO4g@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAA8EJpqUgqHfMOZip58yGpt6S3XSBz+9BeXZSL_JmWar_JbO4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VioE8Q4BC608BBwFnaXJVzmxlrb-K6ti
X-Proofpoint-GUID: VioE8Q4BC608BBwFnaXJVzmxlrb-K6ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120063



On 1/18/24 00:39, Dmitry Baryshkov wrote:
> On Wed, 17 Jan 2024 at 19:36, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> SCMI QCOM vendor protocol provides interface to communicate with SCMI
>> controller and enable vendor specific features like bus scaling capable
>> of running on it.
>>

Hey Dmitry,

Thanks for taking time to review the series!

Will get all of these done in the next re-spin.

>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/Kconfig            |  11 ++
>>   drivers/firmware/arm_scmi/Makefile           |   1 +
>>   drivers/firmware/arm_scmi/qcom_scmi_vendor.c | 160 +++++++++++++++++++
>>   include/linux/qcom_scmi_vendor.h             |  36 +++++
>>   4 files changed, 208 insertions(+)
>>   create mode 100644 drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>>   create mode 100644 include/linux/qcom_scmi_vendor.h
>>
>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
>> index aa5842be19b2..86b5d6c18ec4 100644
>> --- a/drivers/firmware/arm_scmi/Kconfig
>> +++ b/drivers/firmware/arm_scmi/Kconfig
>> @@ -180,4 +180,15 @@ config ARM_SCMI_POWER_CONTROL
>>            called scmi_power_control. Note this may needed early in boot to catch
>>            early shutdown/reboot SCMI requests.
>>
>> +config QCOM_SCMI_VENDOR_PROTOCOL
>> +       tristate "Qualcomm Technologies, Inc. Qcom SCMI vendor Protocol"
>> +       depends on ARM || ARM64 || COMPILE_TEST
>> +       depends on ARM_SCMI_PROTOCOL
>> +       help
>> +         The SCMI QCOM vendor protocol provides interface to communicate with SCMI
>> +         controller and enable vendor specific features like bus scaling.
>> +
>> +         This driver defines the commands or message ID's used for this
>> +         communication and also exposes the ops used by the clients.
>> +
>>   endmenu
>> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
>> index a7bc4796519c..eaeb788b93c6 100644
>> --- a/drivers/firmware/arm_scmi/Makefile
>> +++ b/drivers/firmware/arm_scmi/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
>>   obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
>>
>>   obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
>> +obj-$(CONFIG_QCOM_SCMI_VENDOR_PROTOCOL) += qcom_scmi_vendor.o
>>
>>   ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
>>   # The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
>> diff --git a/drivers/firmware/arm_scmi/qcom_scmi_vendor.c b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>> new file mode 100644
>> index 000000000000..878b99f0d1ef
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/qcom_scmi_vendor.c
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/qcom_scmi_vendor.h>
>> +
>> +#include "common.h"
>> +
>> +#define        EXTENDED_MSG_ID                 0
>> +#define        SCMI_MAX_TX_RX_SIZE             128
>> +#define        PROTOCOL_PAYLOAD_SIZE           16
>> +#define        SET_PARAM                       0x10
>> +#define        GET_PARAM                       0x11
>> +#define        START_ACTIVITY                  0x12
>> +#define        STOP_ACTIVITY                   0x13
>> +
>> +static int qcom_scmi_set_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                              u32 param_id, size_t size)
>> +{
>> +       int ret = -EINVAL;
>> +       struct scmi_xfer *t;
>> +       u32 *msg;
>> +
>> +       if (!ph || !ph->xops)
>> +               return ret;
> 
> Drop init of ret, return -EINVAL directly here.
> 
>> +
>> +       ret = ph->xops->xfer_get_init(ph, SET_PARAM, size + PROTOCOL_PAYLOAD_SIZE,
>> +                                     SCMI_MAX_TX_RX_SIZE, &t);
>> +       if (ret)
>> +               return ret;
>> +
>> +       msg = t->tx.buf;
>> +       *msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +       *msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +       *msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +       *msg++ = cpu_to_le32(param_id);
> 
> First, this header ops looks like a generic code which can be extracted.
> 
> Second, using GENMASK here in the ops doesn't make any sense. The
> values will be limited to u32 anyway.
> 
>> +       memcpy(msg, buf, size);
>> +       ret = ph->xops->do_xfer(ph, t);
>> +       ph->xops->xfer_put(ph, t);
>> +
>> +       return ret;
>> +}
>> +
>> +static int qcom_scmi_get_param(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                              u32 param_id, size_t tx_size, size_t rx_size)
>> +{
>> +       int ret = -EINVAL;
>> +       struct scmi_xfer *t;
>> +       u32 *msg;
>> +
>> +       if (!ph || !ph->xops || !buf)
>> +               return ret;
> 
> Drop init of ret, return -EINVAL directly here.
> 
>> +
>> +       ret = ph->xops->xfer_get_init(ph, GET_PARAM, tx_size + PROTOCOL_PAYLOAD_SIZE,
>> +                                     SCMI_MAX_TX_RX_SIZE, &t);
>> +       if (ret)
>> +               return ret;
>> +
>> +       msg = t->tx.buf;
>> +       *msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +       *msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +       *msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +       *msg++ = cpu_to_le32(param_id);
>> +       memcpy(msg, buf, tx_size);
>> +       ret = ph->xops->do_xfer(ph, t);
>> +       if (t->rx.len > rx_size) {
>> +               pr_err("SCMI received buffer size %zu is more than expected size %zu\n",
>> +                      t->rx.len, rx_size);
>> +               return -EMSGSIZE;
>> +       }
>> +       memcpy(buf, t->rx.buf, t->rx.len);
>> +       ph->xops->xfer_put(ph, t);
>> +
>> +       return ret;
>> +}
>> +
>> +static int qcom_scmi_start_activity(const struct scmi_protocol_handle *ph,
>> +                                   void *buf, u64 algo_str, u32 param_id, size_t size)
>> +{
>> +       int ret = -EINVAL;
>> +       struct scmi_xfer *t;
>> +       u32 *msg;
>> +
>> +       if (!ph || !ph->xops)
>> +               return ret;
> 
> You can guess the comment here.
> 
>> +
>> +       ret = ph->xops->xfer_get_init(ph, START_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
>> +                                     SCMI_MAX_TX_RX_SIZE, &t);
>> +       if (ret)
>> +               return ret;
>> +
>> +       msg = t->tx.buf;
>> +       *msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +       *msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +       *msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +       *msg++ = cpu_to_le32(param_id);
>> +       memcpy(msg, buf, size);
>> +       ret = ph->xops->do_xfer(ph, t);
>> +       ph->xops->xfer_put(ph, t);
>> +
>> +       return ret;
>> +}
>> +
>> +static int qcom_scmi_stop_activity(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                                  u32 param_id, size_t size)
>> +{
>> +       int ret = -EINVAL;
>> +       struct scmi_xfer *t;
>> +       u32 *msg;
>> +
>> +       if (!ph || !ph->xops)
>> +               return ret;
>> +
>> +       ret = ph->xops->xfer_get_init(ph, STOP_ACTIVITY, size + PROTOCOL_PAYLOAD_SIZE,
>> +                                     SCMI_MAX_TX_RX_SIZE, &t);
>> +       if (ret)
>> +               return ret;
>> +
>> +       msg = t->tx.buf;
>> +       *msg++ = cpu_to_le32(EXTENDED_MSG_ID);
>> +       *msg++ = cpu_to_le32(algo_str & GENMASK(31, 0));
>> +       *msg++ = cpu_to_le32((algo_str & GENMASK(63, 32)) >> 32);
>> +       *msg++ = cpu_to_le32(param_id);
>> +       memcpy(msg, buf, size);
>> +       ret = ph->xops->do_xfer(ph, t);
>> +       ph->xops->xfer_put(ph, t);
>> +
>> +       return ret;
>> +}
>> +
>> +static struct qcom_scmi_vendor_ops qcom_proto_ops = {
>> +       .set_param = qcom_scmi_set_param,
>> +       .get_param = qcom_scmi_get_param,
>> +       .start_activity = qcom_scmi_start_activity,
>> +       .stop_activity = qcom_scmi_stop_activity,
>> +};
>> +
>> +static int qcom_scmi_vendor_protocol_init(const struct scmi_protocol_handle *ph)
>> +{
>> +       u32 version;
>> +
>> +       ph->xops->version_get(ph, &version);
>> +
>> +       dev_info(ph->dev, "qcom scmi version %d.%d\n",
>> +                PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct scmi_protocol qcom_scmi_vendor = {
>> +       .id = QCOM_SCMI_VENDOR_PROTOCOL,
>> +       .owner = THIS_MODULE,
>> +       .instance_init = &qcom_scmi_vendor_protocol_init,
>> +       .ops = &qcom_proto_ops,
>> +};
>> +module_scmi_protocol(qcom_scmi_vendor);
>> +
>> +MODULE_DESCRIPTION("QTI SCMI vendor protocol");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/qcom_scmi_vendor.h b/include/linux/qcom_scmi_vendor.h
>> new file mode 100644
>> index 000000000000..bde57bb18367
>> --- /dev/null
>> +++ b/include/linux/qcom_scmi_vendor.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * QTI SCMI vendor protocol's header
>> + *
>> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _QCOM_SCMI_VENDOR_H
>> +#define _QCOM_SCMI_VENDOR_H
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/types.h>
>> +
>> +#define QCOM_SCMI_VENDOR_PROTOCOL    0x80
>> +
>> +struct scmi_protocol_handle;
>> +extern struct scmi_device *get_qcom_scmi_device(void);
>> +
>> +/**
>> + * struct qcom_scmi_vendor_ops - represents the various operations provided
>> + *                              by qcom scmi vendor protocol
>> + */
>> +struct qcom_scmi_vendor_ops {
>> +       int (*set_param)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                        u32 param_id, size_t size);
>> +       int (*get_param)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                        u32 param_id, size_t tx_size, size_t rx_size);
>> +       int (*start_activity)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                             u32 param_id, size_t size);
>> +       int (*stop_activity)(const struct scmi_protocol_handle *ph, void *buf, u64 algo_str,
>> +                            u32 param_id, size_t size);
>> +};
>> +
>> +#endif /* _QCOM_SCMI_VENDOR_H */
>> +
>> --
>> 2.34.1
>>
>>
> 
> 

