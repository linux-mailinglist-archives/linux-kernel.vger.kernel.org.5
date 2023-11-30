Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D77FEC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjK3Jvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Jvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:51:53 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9D10C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:51:58 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9d2ca9a96so1779281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701337917; x=1701942717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zT6CD4Sj0MP/S/TgTYqHKsGt9SGxs0uGQlNI0IDhrQw=;
        b=wQbDAcil5K4pVpiVnOk4XbP2YyEhryK5qNY1M9k01tvxmNKzUJndelvy8EsgiYcqWS
         x8LqFOZ/uqevRY604w2xpLveodgEn4TLY3Ta7/hxfv2M2XJqVVy+eRpd5vxwjkmaD1zE
         8MCZ+cqrcCy7UfC3x4DEsrTtsGZVBC/lg87wLQ7gxnfgnM4tBt+09g6ZcKd3Xgv3p4yu
         hCvjw21FS0IOJH8KBMsmz7HTmqUSP+R2odzCULhQK8iV48ppiT358iS7rw7GaB1QJWok
         PJd+DAalktVGSlJ+JtkUsk2txy+apn1VxG/0Pp/xwIICXszKQFCAUvObK10oRk8p7HMD
         3isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701337917; x=1701942717;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zT6CD4Sj0MP/S/TgTYqHKsGt9SGxs0uGQlNI0IDhrQw=;
        b=OjK98w8RudRC845LMoYBUf+r9RitDUKTEgyE5wMC/XZdR3JpT8ADFtoPYo8DVXWuO9
         SctOUD7glnp95OKtSG/v11w9WbUrVXn8vAWfRIk47jd+qAz2thZyDlTYA4/ByLCBiB8J
         V8kvupAB2WH6J5VIVoLppFeoLz54dHR1sPKCCJcwJig64oNT3dhjvfKGu9uBbz2Aq4Uz
         FYIMCByeJbmlHfZL4Jjzv5TD9yFqesZ1OrMA3zCyY/iFyQJTjUmhemHh8trwUZIXQ6Mj
         MkyTExXsZpkaeHH/AsMENvTrv5dQdXPyoZ27y/B0c89jz3ahZ8GfeayL4tBZcIqfSgQG
         KgBQ==
X-Gm-Message-State: AOJu0Yyqi7qtQlA5HEtl/eLOtLYxB/Pm+MsT+F0EQj1PZbA5wwNvLdNJ
        Fquvuv9zZvtkzaaYd/jiamBGRQ==
X-Google-Smtp-Source: AGHT+IEyZA+pc18Ydf6PuCOFjs7WUNYo3ZPNLTXocFPN1BteDDgIXxcfIFSiqAj2MCjxj5sGMWvJtw==
X-Received: by 2002:a05:651c:2111:b0:2c9:cd38:935e with SMTP id a17-20020a05651c211100b002c9cd38935emr827043ljq.8.1701337916910;
        Thu, 30 Nov 2023 01:51:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b0040b478da760sm1358964wms.48.2023.11.30.01.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:51:56 -0800 (PST)
Message-ID: <e847c9cf-e3ec-4f0c-a7c9-0a827333a4be@linaro.org>
Date:   Thu, 30 Nov 2023 10:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: qcom: add ADSP PDCharger ULOG driver
Content-Language: en-US, fr
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230908-topic-sm8550-upstream-pdcharge-ulog-v1-1-d1b16b02ced2@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20230908-topic-sm8550-upstream-pdcharge-ulog-v1-1-d1b16b02ced2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 08/09/2023 12:53, Neil Armstrong wrote:
> The Qualcomm PMIC PDCharger ULOG driver provides access to logs of
> the ADSP firmware PDCharger module in charge of Battery and Power
> Delivery on modern systems.
> 
> Implement trace events as a simple rpmsg driver with an 1s interval
> to retrieve the messages.
> 
> The interface allows filtering the messages by subsystem and priority
> level, this could be implemented later on.

Any thoughts on this? It's pretty handy to debug PDCharger firmware events,
even more with enhanced usage of UCSI.

Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/soc/qcom/Kconfig               |  12 +++
>   drivers/soc/qcom/Makefile              |   1 +
>   drivers/soc/qcom/pmic_pdcharger_ulog.c | 166 +++++++++++++++++++++++++++++++++
>   drivers/soc/qcom/pmic_pdcharger_ulog.h |  36 +++++++
>   4 files changed, 215 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e597799e8121..5f63df3d5d6f 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -93,6 +93,18 @@ config QCOM_PDR_HELPERS
>   	select QCOM_QMI_HELPERS
>   	depends on NET
>   
> +config QCOM_PMIC_PDCHARGER_ULOG
> +	tristate "Qualcomm PMIC PDCharger ULOG driver"
> +	depends on RPMSG
> +	depends on EVENT_TRACING
> +	help
> +	  The Qualcomm PMIC PDCharger ULOG driver provides access to logs of
> +	  the ADSP firmware PDCharger module in charge of Battery and Power
> +	  Delivery on modern systems.
> +
> +	  Say yes here to support PDCharger ULOG event tracing on modern
> +	  Qualcomm platforms.
> +
>   config QCOM_PMIC_GLINK
>   	tristate "Qualcomm PMIC GLINK driver"
>   	depends on RPMSG
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 99114c71092b..44f6efe9a48c 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>   obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
>   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
>   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
> +obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
>   obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>   qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>   obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
> diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.c b/drivers/soc/qcom/pmic_pdcharger_ulog.c
> new file mode 100644
> index 000000000000..f1aaacf05005
> --- /dev/null
> +++ b/drivers/soc/qcom/pmic_pdcharger_ulog.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Ltd
> + */
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rpmsg.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/pdr.h>
> +#include <linux/debugfs.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include "pmic_pdcharger_ulog.h"
> +
> +#define MSG_OWNER_CHG_ULOG		32778
> +#define MSG_TYPE_REQ_RESP		1
> +
> +#define GET_CHG_ULOG_REQ		0x18
> +#define SET_CHG_ULOG_PROP_REQ		0x19
> +
> +#define LOG_DEFAULT_TIME_MS		1000
> +
> +#define MAX_ULOG_SIZE			8192
> +
> +struct pmic_pdcharger_ulog_hdr {
> +	__le32 owner;
> +	__le32 type;
> +	__le32 opcode;
> +};
> +
> +struct pmic_pdcharger_ulog {
> +	struct rpmsg_device *rpdev;
> +	struct delayed_work ulog_work;
> +};
> +
> +struct get_ulog_req_msg {
> +	struct pmic_pdcharger_ulog_hdr	hdr;
> +	u32				log_size;
> +};
> +
> +struct get_ulog_resp_msg {
> +	struct pmic_pdcharger_ulog_hdr	hdr;
> +	u8				buf[MAX_ULOG_SIZE];
> +};
> +
> +static int pmic_pdcharger_ulog_write_async(struct pmic_pdcharger_ulog *pg, void *data, size_t len)
> +{
> +	return rpmsg_send(pg->rpdev->ept, data, len);
> +}
> +
> +static int pmic_pdcharger_ulog_request(struct pmic_pdcharger_ulog *pg)
> +{
> +	struct get_ulog_req_msg req_msg = {
> +		.hdr = {
> +			.owner = MSG_OWNER_CHG_ULOG,
> +			.type = MSG_TYPE_REQ_RESP,
> +			.opcode = GET_CHG_ULOG_REQ
> +		},
> +		.log_size = MAX_ULOG_SIZE
> +	};
> +
> +	return pmic_pdcharger_ulog_write_async(pg, &req_msg, sizeof(req_msg));
> +}
> +
> +static void pmic_pdcharger_ulog_work(struct work_struct *work)
> +{
> +	struct pmic_pdcharger_ulog *pg = container_of(work, struct pmic_pdcharger_ulog,
> +						      ulog_work.work);
> +	int rc;
> +
> +	rc = pmic_pdcharger_ulog_request(pg);
> +	if (rc) {
> +		dev_err(&pg->rpdev->dev, "Error requesting ulog, rc=%d\n", rc);
> +		return;
> +	}
> +}
> +
> +static void pmic_pdcharger_ulog_handle_message(struct pmic_pdcharger_ulog *pg,
> +					       struct get_ulog_resp_msg *resp_msg,
> +					       size_t len)
> +{
> +	char *token, *buf = resp_msg->buf;
> +
> +	if (len != sizeof(*resp_msg)) {
> +		dev_err(&pg->rpdev->dev, "Expected data length: %zu, received: %zu\n",
> +			sizeof(*resp_msg), len);
> +		return;
> +	}
> +
> +	buf[MAX_ULOG_SIZE - 1] = '\0';
> +
> +	do {
> +		token = strsep((char **)&buf, "\n");
> +		if (token && strlen(token))
> +			trace_pmic_pdcharger_ulog_msg(token);
> +	} while (token);
> +}
> +
> +static int pmic_pdcharger_ulog_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> +					      int len, void *priv, u32 addr)
> +{
> +	struct pmic_pdcharger_ulog *pg = dev_get_drvdata(&rpdev->dev);
> +	struct pmic_pdcharger_ulog_hdr *hdr = data;
> +	u32 opcode;
> +
> +	opcode = le32_to_cpu(hdr->opcode);
> +
> +	switch (opcode) {
> +	case GET_CHG_ULOG_REQ:
> +		schedule_delayed_work(&pg->ulog_work, msecs_to_jiffies(LOG_DEFAULT_TIME_MS));
> +		pmic_pdcharger_ulog_handle_message(pg, data, len);
> +		break;
> +	default:
> +		dev_err(&pg->rpdev->dev, "Unknown opcode %u\n", opcode);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pmic_pdcharger_ulog_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +	struct pmic_pdcharger_ulog *pg;
> +	struct device *dev = &rpdev->dev;
> +
> +	pg = devm_kzalloc(dev, sizeof(*pg), GFP_KERNEL);
> +	if (!pg)
> +		return -ENOMEM;
> +
> +	pg->rpdev = rpdev;
> +	INIT_DELAYED_WORK(&pg->ulog_work, pmic_pdcharger_ulog_work);
> +
> +	dev_set_drvdata(dev, pg);
> +
> +	pmic_pdcharger_ulog_request(pg);
> +
> +	return 0;
> +}
> +
> +static void pmic_pdcharger_ulog_rpmsg_remove(struct rpmsg_device *rpdev)
> +{
> +	struct pmic_pdcharger_ulog *pg = dev_get_drvdata(&rpdev->dev);
> +
> +	cancel_delayed_work_sync(&pg->ulog_work);
> +}
> +
> +static const struct rpmsg_device_id pmic_pdcharger_ulog_rpmsg_id_match[] = {
> +	{ "PMIC_LOGS_ADSP_APPS" },
> +	{}
> +};
> +
> +static struct rpmsg_driver pmic_pdcharger_ulog_rpmsg_driver = {
> +	.probe = pmic_pdcharger_ulog_rpmsg_probe,
> +	.remove = pmic_pdcharger_ulog_rpmsg_remove,
> +	.callback = pmic_pdcharger_ulog_rpmsg_callback,
> +	.id_table = pmic_pdcharger_ulog_rpmsg_id_match,
> +	.drv  = {
> +		.name  = "qcom_pmic_pdcharger_ulog_rpmsg",
> +	},
> +};
> +
> +module_rpmsg_driver(pmic_pdcharger_ulog_rpmsg_driver);
> +MODULE_DESCRIPTION("Qualcomm PMIC ChargerPD ULOG driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
> new file mode 100644
> index 000000000000..9d5d9af4fbe4
> --- /dev/null
> +++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Linaro Ltd
> + */
> +
> +#if !defined(_TRACE_PMIC_PDCHARGER_ULOG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PMIC_PDCHARGER_ULOG_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pmic_pdcharger_ulog
> +
> +TRACE_EVENT(pmic_pdcharger_ulog_msg,
> +	TP_PROTO(char *msg),
> +	TP_ARGS(msg),
> +	TP_STRUCT__entry(
> +		__string(msg, msg)
> +	),
> +	TP_fast_assign(
> +		__assign_str(msg, msg);
> +	),
> +	TP_printk("%s", __get_str(msg))
> +);
> +
> +#endif /* _TRACE_PMIC_PDCHARGER_ULOG_H */
> +
> +/* This part must be outside protection */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE pmic_pdcharger_ulog
> +
> +#include <trace/define_trace.h>
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230908-topic-sm8550-upstream-pdcharge-ulog-21ece9292474
> 
> Best regards,

