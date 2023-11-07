Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC57E4362
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjKGP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjKGP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:27:08 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9471FD0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:26:23 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9df8d0c2505so509361666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699370782; x=1699975582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PNFhMc7ni11X+CIntXbMfTwWzVrqZzB8JwspUtoZfOQ=;
        b=QIgT+GdxL4Br5BapqsN0xjy02B9hMv0g7dmH0Nl6nlHu24QYMJ8ssQ3zap0NTvj8gy
         hZQHBV/SeiX7jpmkJDroh7fgnV5GOf3ZFhfg0ORILTomMofWnwSqBihpePkUh663KCTM
         wzra/tETbMQhXHOHQ/hG8Ny/RwBGU6fIqFcLGqsfHmpJ4xUiidCx4o1pyuPueMm7FyTS
         Nu6ir8ubr132NuK92HeE+kEUkNjG6yZQaJjpGee+tSoYZ0xLABtHbV5e+cCcY84f4eiz
         tBVourC501TChvgUBAQA3Nv41XwbQ1MSbQu5noakdzSQ8lN/B6lfEsAUjBXEhl1ZNhSn
         tDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370782; x=1699975582;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNFhMc7ni11X+CIntXbMfTwWzVrqZzB8JwspUtoZfOQ=;
        b=Hv+Jsz92ED/TQKmidj3PC7RzB7byEUB6FBM/rgxPReLC2i+IVkodiROIwRMPmwn65W
         El84z9A0d5ft5DtzntsA3o7nrwn0PDK1V50KFiwHfuD8TT79umkttpcQhQjilOodOxhk
         psSmz3SvKxqi7SEy5rqddIUz79SwVqu8PfGv4QujMpnK+NrrDnpngOe+1hgoej7S/vqe
         Np3ILCbS7ziOdFZ9tkJ5KSrvc4xdVSYvEV+GyDvMPLjiA2B/8cWG78M2DM8+7Ql51ef0
         XdXM+ENi1Taus49vqy84hR3jitzRxk47RbA5leQxw4u+qDUV1ngjqTIj7mhijf2khE71
         wgUg==
X-Gm-Message-State: AOJu0YypDQHDv0fpJFFH0in70tMBNHkyMXe8a6eyiBp3G7YzI3B+LniI
        K0FZ/yfLyXrvGkMWry/0qP5jZg==
X-Google-Smtp-Source: AGHT+IFn2O96/abPIXmMw7eMollD5P1Ra0QFGt9oWSBzn4n9Z0/DCxLvfUiZ/71S/nzOgfuMXGrm6g==
X-Received: by 2002:a17:907:72cd:b0:9a1:b528:d0f6 with SMTP id du13-20020a17090772cd00b009a1b528d0f6mr2212487ejc.27.1699370781621;
        Tue, 07 Nov 2023 07:26:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id jt21-20020a170906ca1500b009b65a698c16sm1143858ejb.220.2023.11.07.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:26:21 -0800 (PST)
Message-ID: <3bc959e4-9308-4827-ae6d-2ec6fc47d946@linaro.org>
Date:   Tue, 7 Nov 2023 16:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] coresight: Add remote etm support
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
 <20231107060939.13449-2-quic_jinlmao@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231107060939.13449-2-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 07:09, Mao Jinlong wrote:
> Add support for ETM trace collection on remote processor using
> coreSight framework.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/Kconfig           |   9 +
>  drivers/hwtracing/coresight/Makefile          |   1 +
>  drivers/hwtracing/coresight/coresight-core.c  |   3 +
>  drivers/hwtracing/coresight/coresight-qmi.h   | 109 ++++++
>  .../coresight/coresight-remote-etm.c          | 325 ++++++++++++++++++
>  include/linux/coresight.h                     |   1 +
>  6 files changed, 448 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-qmi.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-remote-etm.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 06f0a7594169..425886ab7401 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -247,4 +247,13 @@ config CORESIGHT_DUMMY
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called coresight-dummy.
> +
> +config CORESIGHT_REMOTE_ETM
> +	tristate "Remote processor ETM trace support"
> +	select QCOM_QMI_HELPERS
> +	help
> +	  Enables support for ETM trace collection on remote processor using
> +	  CoreSight framework. Enabling this will allow turning on ETM
> +	  tracing on remote processor via sysfs by configuring the required
> +	  CoreSight components.
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 995d3b2c76df..a5283cab0bc0 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -29,5 +29,6 @@ obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>  obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>  coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>  		   coresight-cti-sysfs.o
> +obj-$(CONFIG_CORESIGHT_REMOTE_ETM) += coresight-remote-etm.o
>  obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>  obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index d7f0e231feb9..f365a3899821 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1094,6 +1094,7 @@ static int coresight_validate_source(struct coresight_device *csdev,
>  	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>  	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>  	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC &&
>  	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>  		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>  		return -EINVAL;
> @@ -1164,6 +1165,7 @@ int coresight_enable(struct coresight_device *csdev)
>  		break;
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>  		/*
>  		 * Use the hash of source's device name as ID
> @@ -1215,6 +1217,7 @@ void coresight_disable(struct coresight_device *csdev)
>  		break;
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC:
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>  		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>  		/* Find the path by the hash. */
> diff --git a/drivers/hwtracing/coresight/coresight-qmi.h b/drivers/hwtracing/coresight/coresight-qmi.h
> new file mode 100644
> index 000000000000..4c35ba8c8a05
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-qmi.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _CORESIGHT_QMI_H
> +#define _CORESIGHT_QMI_H
> +
> +#include <linux/soc/qcom/qmi.h>
> +
> +#define CORESIGHT_QMI_SVC_ID			(0x33)
> +#define CORESIGHT_QMI_VERSION			(1)
> +
> +#define CORESIGHT_QMI_GET_ETM_REQ_V01		(0x002B)
> +#define CORESIGHT_QMI_GET_ETM_RESP_V01		(0x002B)
> +#define CORESIGHT_QMI_SET_ETM_REQ_V01		(0x002C)
> +#define CORESIGHT_QMI_SET_ETM_RESP_V01		(0x002C)
> +
> +#define CORESIGHT_QMI_GET_ETM_REQ_MAX_LEN	(0)
> +#define CORESIGHT_QMI_GET_ETM_RESP_MAX_LEN	(14)
> +#define CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN	(7)
> +#define CORESIGHT_QMI_SET_ETM_RESP_MAX_LEN	(7)
> +
> +#define TIMEOUT_MS				(10000)
> +
> +enum coresight_etm_state_enum_type_v01 {
> +	/* To force a 32 bit signed enum. Do not change or use */
> +	CORESIGHT_ETM_STATE_ENUM_TYPE_MIN_ENUM_VAL_V01 = INT_MIN,
> +	CORESIGHT_ETM_STATE_DISABLED_V01 = 0,
> +	CORESIGHT_ETM_STATE_ENABLED_V01 = 1,
> +	CORESIGHT_ETM_STATE_ENUM_TYPE_MAX_ENUM_VAL_01 = INT_MAX,
> +};
> +
> +struct coresight_get_etm_req_msg_v01 {
> +	/*
> +	 * This element is a placeholder to prevent declaration of
> +	 * empty struct. Do not change.
> +	 */
> +	char __placeholder;
> +};
> +
> +struct coresight_get_etm_resp_msg_v01 {
> +	/* Mandatory */
> +	/* QMI result Code */
> +	struct qmi_response_type_v01 resp;
> +
> +	/* Optional */
> +	/* ETM output state, must be set to true if state is being passed */
> +	uint8_t state_valid;
> +	/* Present when result code is QMI_RESULT_SUCCESS */
> +	enum coresight_etm_state_enum_type_v01 state;
> +};
> +
> +struct coresight_set_etm_req_msg_v01 {
> +	/* Mandatory */
> +	/* ETM output state */
> +	enum coresight_etm_state_enum_type_v01 state;
> +};
> +
> +struct coresight_set_etm_resp_msg_v01 {
> +	/* Mandatory */
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +static struct qmi_elem_info coresight_set_etm_req_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_UNSIGNED_4_BYTE,
> +		.elem_len  = 1,
> +		.elem_size = sizeof(enum coresight_etm_state_enum_type_v01),
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0x01,
> +		.offset    = offsetof(struct coresight_set_etm_req_msg_v01,
> +				      state),
> +		.ei_array  = NULL,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.elem_len  = 0,
> +		.elem_size = 0,
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0,
> +		.offset    = 0,
> +		.ei_array  = NULL,
> +	},
> +};
> +
> +static struct qmi_elem_info coresight_set_etm_resp_msg_v01_ei[] = {
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len  = 1,
> +		.elem_size = sizeof(struct qmi_response_type_v01),
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0x02,
> +		.offset    = offsetof(struct coresight_set_etm_resp_msg_v01,
> +				      resp),
> +		.ei_array  = qmi_response_type_v01_ei,
> +	},
> +	{
> +		.data_type = QMI_EOTI,
> +		.elem_len  = 0,
> +		.elem_size = 0,
> +		.array_type  = NO_ARRAY,
> +		.tlv_type  = 0,
> +		.offset    = 0,
> +		.ei_array  = NULL,
> +	},
> +};
> +
> +#endif
> diff --git a/drivers/hwtracing/coresight/coresight-remote-etm.c b/drivers/hwtracing/coresight/coresight-remote-etm.c
> new file mode 100644
> index 000000000000..d895dc5d14c2
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-remote-etm.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/sysfs.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/coresight.h>
> +#include "coresight-qmi.h"
> +#include "coresight-priv.h"
> +
> +#define REMOTE_ETM_TRACE_ID_START	192
> +
> +DEFINE_CORESIGHT_DEVLIST(remote_etm_devs, "remote-etm");


Why do you define file-scope variables?

> +
> +static DEFINE_MUTEX(remote_etm_lock);

Drop, not used.

> +static LIST_HEAD(remote_etm_list);

Drop, not used.

> +
> +struct remote_etm_drvdata {
> +	struct device			*dev;
> +	struct coresight_device		*csdev;
> +	struct mutex			mutex;
> +	struct qmi_handle		handle;
> +	uint32_t			inst_id;
> +	bool				enable;
> +	bool service_connected;

Your indentation is a mess.

> +	bool security;
> +	struct sockaddr_qrtr s_addr;
> +	struct list_head link;
> +};
> +
> +static int service_remote_etm_new_server(struct qmi_handle *qmi,
> +		struct qmi_service *svc)
> +{
> +	struct remote_etm_drvdata *drvdata = container_of(qmi,
> +					struct remote_etm_drvdata, handle);
> +
> +	drvdata->s_addr.sq_family = AF_QIPCRTR;
> +	drvdata->s_addr.sq_node = svc->node;
> +	drvdata->s_addr.sq_port = svc->port;
> +	drvdata->service_connected = true;
> +	dev_info(drvdata->dev,
> +		"Connection established between QMI handle and %d service\n",
> +		drvdata->inst_id);
> +
> +	return 0;
> +}
> +
> +static void service_remote_etm_del_server(struct qmi_handle *qmi,
> +		struct qmi_service *svc)
> +{
> +	struct remote_etm_drvdata *drvdata = container_of(qmi,
> +					struct remote_etm_drvdata, handle);
> +	drvdata->service_connected = false;
> +	dev_info(drvdata->dev,
> +		"Connection disconnected between QMI handle and %d service\n",
> +		drvdata->inst_id);
> +}
> +
> +static struct qmi_ops server_ops = {
> +	.new_server = service_remote_etm_new_server,
> +	.del_server = service_remote_etm_del_server,
> +};
> +
> +static int remote_etm_enable(struct coresight_device *csdev,
> +			     struct perf_event *event, u32 mode)
> +{
> +	struct remote_etm_drvdata *drvdata =
> +		dev_get_drvdata(csdev->dev.parent);
> +	struct coresight_set_etm_req_msg_v01 req;
> +	struct coresight_set_etm_resp_msg_v01 resp = { { 0, 0 } };
> +	struct qmi_txn txn;
> +	int ret;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +	if (!drvdata->service_connected) {
> +		dev_err(drvdata->dev, "QMI service not connected!\n");
> +		ret = EINVAL;
> +		goto err;
> +	}
> +	/*
> +	 * The QMI handle may be NULL in the following scenarios:
> +	 * 1. QMI service is not present
> +	 * 2. QMI service is present but attempt to enable remote ETM is earlier
> +	 *    than service is ready to handle request
> +	 * 3. Connection between QMI client and QMI service failed
> +	 *
> +	 * Enable CoreSight without processing further QMI commands which
> +	 * provides the option to enable remote ETM by other means.
> +	 */
> +	req.state = CORESIGHT_ETM_STATE_ENABLED_V01;
> +
> +	ret = qmi_txn_init(&drvdata->handle, &txn,
> +			coresight_set_etm_resp_msg_v01_ei,
> +			&resp);
> +
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI tx init failed , ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	ret = qmi_send_request(&drvdata->handle, &drvdata->s_addr,
> +			&txn, CORESIGHT_QMI_SET_ETM_REQ_V01,
> +			CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN,
> +			coresight_set_etm_req_msg_v01_ei,
> +			&req);
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI send ACK failed, ret:%d\n",
> +				ret);
> +		qmi_txn_cancel(&txn);
> +		goto err;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, msecs_to_jiffies(TIMEOUT_MS));
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI qmi txn wait failed, ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	/* Check the response */
> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01)
> +		dev_err(drvdata->dev, "QMI request failed 0x%x\n",
> +				resp.resp.error);
> +
> +	drvdata->enable = true;
> +	mutex_unlock(&drvdata->mutex);
> +
> +	dev_info(drvdata->dev, "Remote ETM tracing enabled for instance %d\n",
> +				drvdata->inst_id);

Why do you print so many info messages?

> +	return 0;
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +	return ret;
> +}
> +
> +static void remote_etm_disable(struct coresight_device *csdev,
> +			       struct perf_event *event)
> +{
> +	struct remote_etm_drvdata *drvdata =
> +		 dev_get_drvdata(csdev->dev.parent);
> +	struct coresight_set_etm_req_msg_v01 req;
> +	struct coresight_set_etm_resp_msg_v01 resp = { { 0, 0 } };
> +	struct qmi_txn txn;
> +	int ret;
> +
> +	mutex_lock(&drvdata->mutex);
> +	if (!drvdata->service_connected) {
> +		dev_err(drvdata->dev, "QMI service not connected!\n");
> +		goto err;
> +	}
> +
> +	req.state = CORESIGHT_ETM_STATE_DISABLED_V01;
> +
> +	ret = qmi_txn_init(&drvdata->handle, &txn,
> +			coresight_set_etm_resp_msg_v01_ei,
> +			&resp);
> +
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI tx init failed , ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	ret = qmi_send_request(&drvdata->handle, &drvdata->s_addr,
> +			&txn, CORESIGHT_QMI_SET_ETM_REQ_V01,
> +			CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN,
> +			coresight_set_etm_req_msg_v01_ei,
> +			&req);
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI send req failed, ret:%d\n",
> +				 ret);
> +		qmi_txn_cancel(&txn);
> +		goto err;
> +	}
> +
> +	ret = qmi_txn_wait(&txn, msecs_to_jiffies(TIMEOUT_MS));
> +	if (ret < 0) {
> +		dev_err(drvdata->dev, "QMI qmi txn wait failed, ret:%d\n",
> +				ret);
> +		goto err;
> +	}
> +
> +	/* Check the response */
> +	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
> +		dev_err(drvdata->dev, "QMI request failed 0x%x\n",
> +				resp.resp.error);
> +		goto err;
> +	}
> +
> +	drvdata->enable = false;
> +	dev_info(drvdata->dev, "Remote ETM tracing disabled for instance %d\n",
> +				drvdata->inst_id);
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +}
> +
> +static const struct coresight_ops_source remote_etm_source_ops = {
> +	.enable		= remote_etm_enable,
> +	.disable	= remote_etm_disable,
> +};
> +
> +static const struct coresight_ops remote_cs_ops = {
> +	.source_ops	= &remote_etm_source_ops,
> +};
> +
> +static int remote_etm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct coresight_platform_data *pdata;
> +	struct remote_etm_drvdata *drvdata;
> +	struct coresight_desc desc = {0 };
> +	int ret;
> +
> +	desc.name = coresight_alloc_device_name(&remote_etm_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	pdev->dev.platform_data = pdata;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "qcom,inst-id",
> +			&drvdata->inst_id);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&drvdata->mutex);
> +
> +	ret = qmi_handle_init(&drvdata->handle,
> +			CORESIGHT_QMI_SET_ETM_REQ_MAX_LEN,
> +			&server_ops, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "Remote ETM client init failed ret:%d\n", ret);
> +		return ret;

Use return dev_err_probe()

> +	}
> +
> +	qmi_add_lookup(&drvdata->handle,
> +			CORESIGHT_QMI_SVC_ID,
> +			CORESIGHT_QMI_VERSION,
> +			drvdata->inst_id);
> +
> +	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC;
> +	desc.ops = &remote_cs_ops;
> +	desc.pdata = pdev->dev.platform_data;
> +	desc.dev = &pdev->dev;
> +	drvdata->csdev = coresight_register(&desc);
> +	if (IS_ERR(drvdata->csdev)) {
> +		ret = PTR_ERR(drvdata->csdev);
> +		goto err;
> +	}
> +	dev_info(dev, "Remote ETM initialized\n");

Drop, quite useless.

> +
> +	pm_runtime_enable(dev);
> +	if (drvdata->inst_id >= sizeof(int)*BITS_PER_BYTE)
> +		dev_err(dev, "inst_id greater than boot_enable bit mask\n");
> +
> +	list_add_tail(&drvdata->link, &remote_etm_list);
> +
> +	return 0;
> +err:
> +	qmi_handle_release(&drvdata->handle);
> +	return ret;
> +}
> +
> +static int remote_etm_remove(struct platform_device *pdev)
> +{
> +	struct remote_etm_drvdata *drvdata = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	list_del(&drvdata->link);
> +	pm_runtime_disable(dev);
> +	qmi_handle_release(&drvdata->handle);
> +	coresight_unregister(drvdata->csdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id remote_etm_match[] = {
> +	{.compatible = "qcom,coresight-remote-etm"},

Please order your patches correctly, so binding is documented before the
users.

> +	{}
> +};
> +
> +static struct platform_driver remote_etm_driver = {
> +	.probe          = remote_etm_probe,
> +	.remove         = remote_etm_remove,
> +	.driver         = {
> +		.name   = "coresight-remote-etm",
> +		.of_match_table = remote_etm_match,
> +	},
> +};
> +
> +int __init remote_etm_init(void)
> +{
> +	return platform_driver_register(&remote_etm_driver);
> +}
> +module_init(remote_etm_init);
> +
> +void __exit remote_etm_exit(void)
> +{
> +	platform_driver_unregister(&remote_etm_driver);
> +}
> +module_exit(remote_etm_exit);

Why aren't you using module platform driver?

Best regards,
Krzysztof

