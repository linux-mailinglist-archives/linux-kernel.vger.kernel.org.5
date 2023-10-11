Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0E7C5E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376302AbjJKUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJKUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:09:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA790;
        Wed, 11 Oct 2023 13:09:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4060b623e64so1297125e9.0;
        Wed, 11 Oct 2023 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054980; x=1697659780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yNwy3r+AgBl1PvTiQhTFUmxrxfEGVPhw2UnqZh/tu0=;
        b=B3vRwxyP1cPBl8I1Cyfoo82cMDaOvEyirbXo46WlBVr57Ym3uwRr4eWmHdV4mIa1wA
         T3pksyGgCJfhTpAIghzgxeyvoBi43UNHOIN3hYxnVEXZ6p2mLAwtHVH6IwleMdukZHfY
         MyE4AinUeczqhNzK/Ynk7bc5RkSsB7vJzFSSL9ss/tPbok9S6Fmw0KUEpIE0myts/Cvn
         f2kknQAHmS3IdIYeU7KH02wTkjtN5nVd6+2tOEKwC1l22dBHJEfe48yMFXHi1yxRUgFV
         JLA+6HWxJzTquNR/hcp8QkXn9AmNp6gmYkU5OQQIZbcxjysz175bI5Wdf8s0y212D7yF
         H1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054980; x=1697659780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yNwy3r+AgBl1PvTiQhTFUmxrxfEGVPhw2UnqZh/tu0=;
        b=vtM/5dMxKFYaRiPVsMW8lHrfgVuOFsqyiRXqDE8f/OdMukeJPJwndBT4P4kcuBpxg/
         bqy+k0kUHolpNZbDRucszmeY1ihiMtnlmxLPNn7jtemBcYSbma/3UoZxpsdJSazfVKh8
         xH4zadGuEX5FwwezvRSqSeGMuXUkAnhtoMDk1fEkRbFrs83UQb4ul22b+rDnpJTrC3zK
         xRwR2QWF+aBIcAR2N68mi7E5cRsYBgm69ILvFVOX/sUHEK0GYL67dCcmGgUi1JTWVb6x
         i1i1MhLnZNB6Zops/td1et+QYXErffLFLgGrXvRzCyYK3Dr3zA8T9bZY+jtP8NSUTrMC
         iFFg==
X-Gm-Message-State: AOJu0Yx6GFtrBlpSPVOQAqO2PoLyu0HUDMWNNDHwykScZAK5wRV6Bb2m
        vpwDjipoMeHfPyX2RBenCOw=
X-Google-Smtp-Source: AGHT+IG06Yud8b+G7IdF2TsN5EQKTw7B2vyLs6QTmrIUNxrihnCz3g6e1V3pcgTX+exPLONBOoD3EA==
X-Received: by 2002:a05:600c:5390:b0:405:29ba:9b5c with SMTP id hg16-20020a05600c539000b0040529ba9b5cmr15531178wmb.16.1697054979466;
        Wed, 11 Oct 2023 13:09:39 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm20163058wmb.34.2023.10.11.13.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:09:39 -0700 (PDT)
Message-ID: <e73649b2-34de-4947-8056-4d6537ca0a23@gmail.com>
Date:   Wed, 11 Oct 2023 22:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] firmware: qcom: qseecom: convert to using the TZ
 allocator
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-12-brgl@bgdev.pl>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231009153427.20951-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 17:34, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> convert all users of it in the qseecom module to using the TZ allocator
> for creating SCM call buffers. Together with using the cleanup macros,
> it has the added benefit of a significant code shrink. As this is
> largely a module separate from the SCM driver, let's use a separate
> memory pool.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 260 +++++++-----------
>   drivers/firmware/qcom/qcom_scm.c              |  30 +-
>   include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>   3 files changed, 103 insertions(+), 191 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> index a33acdaf7b78..720cddd7c8c7 100644
> --- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> +++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> @@ -7,6 +7,7 @@
>    * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
>    */
>   
> +#include <linux/cleanup.h>
>   #include <linux/efi.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -18,6 +19,8 @@
>   #include <linux/ucs2_string.h>
>   
>   #include <linux/firmware/qcom/qcom_qseecom.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_tzmem.h>
>   
>   /* -- Qualcomm "uefisecapp" interface definitions. -------------------------- */
>   
> @@ -253,6 +256,7 @@ struct qsee_rsp_uefi_query_variable_info {
>   struct qcuefi_client {
>   	struct qseecom_client *client;
>   	struct efivars efivars;
> +	struct qcom_tzmem_pool *mempool;
>   };
>   
>   static struct device *qcuefi_dev(struct qcuefi_client *qcuefi)
> @@ -272,11 +276,11 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>   					   const efi_guid_t *guid, u32 *attributes,
>   					   unsigned long *data_size, void *data)
>   {
> -	struct qsee_req_uefi_get_variable *req_data;
> -	struct qsee_rsp_uefi_get_variable *rsp_data;
> +	struct qsee_req_uefi_get_variable *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_get_variable *rsp_data __free(qcom_tzmem) = NULL;
>   	unsigned long buffer_size = *data_size;
> -	efi_status_t efi_status = EFI_SUCCESS;
>   	unsigned long name_length;
> +	efi_status_t efi_status;
>   	size_t guid_offs;
>   	size_t name_offs;
>   	size_t req_size;
> @@ -304,17 +308,13 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>   		__array(u8, buffer_size)
>   	);
>   
> -	req_data = kzalloc(req_size, GFP_KERNEL);
> -	if (!req_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out;
> -	}
> +	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
> +	if (!req_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
> -	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
> -	if (!rsp_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out_free_req;
> -	}
> +	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, rsp_size, GFP_KERNEL);
> +	if (!rsp_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
>   	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
>   	req_data->data_size = buffer_size;
> @@ -331,20 +331,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>   	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>   
>   	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
> -	if (status) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (status)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->length < sizeof(*rsp_data)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length < sizeof(*rsp_data))
> +		return EFI_DEVICE_ERROR;
>   
>   	if (rsp_data->status) {
>   		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
> @@ -358,18 +352,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>   				*attributes = rsp_data->attributes;
>   		}
>   
> -		goto out_free;
> +		return efi_status;
>   	}
>   
> -	if (rsp_data->length > rsp_size) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length > rsp_size)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length)
> +		return EFI_DEVICE_ERROR;
>   
>   	/*
>   	 * Note: We need to set attributes and data size even if the buffer is
> @@ -392,33 +382,23 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>   	if (attributes)
>   		*attributes = rsp_data->attributes;
>   
> -	if (buffer_size == 0 && !data) {
> -		efi_status = EFI_SUCCESS;
> -		goto out_free;
> -	}
> +	if (buffer_size == 0 && !data)
> +		return EFI_SUCCESS;
>   
> -	if (buffer_size < rsp_data->data_size) {
> -		efi_status = EFI_BUFFER_TOO_SMALL;
> -		goto out_free;
> -	}
> +	if (buffer_size < rsp_data->data_size)
> +		return EFI_BUFFER_TOO_SMALL;
>   
>   	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
>   
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>   }
>   
>   static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
>   					   const efi_guid_t *guid, u32 attributes,
>   					   unsigned long data_size, const void *data)
>   {
> -	struct qsee_req_uefi_set_variable *req_data;
> -	struct qsee_rsp_uefi_set_variable *rsp_data;
> -	efi_status_t efi_status = EFI_SUCCESS;
> +	struct qsee_req_uefi_set_variable *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_set_variable *rsp_data __free(qcom_tzmem) = NULL;
>   	unsigned long name_length;
>   	size_t name_offs;
>   	size_t guid_offs;
> @@ -448,17 +428,14 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
>   		__array_offs(u8, data_size, &data_offs)
>   	);
>   
> -	req_data = kzalloc(req_size, GFP_KERNEL);
> -	if (!req_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out;
> -	}
> +	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
> +	if (!req_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
> -	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
> -	if (!rsp_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out_free_req;
> -	}
> +	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*rsp_data),
> +				    GFP_KERNEL);
> +	if (!rsp_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
>   	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
>   	req_data->attributes = attributes;
> @@ -481,42 +458,31 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
>   
>   	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data,
>   				       sizeof(*rsp_data));
> -	if (status) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (status)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->length != sizeof(*rsp_data)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length != sizeof(*rsp_data))
> +		return EFI_DEVICE_ERROR;
>   
>   	if (rsp_data->status) {
>   		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
>   			__func__, rsp_data->status);
> -		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
> +		return qsee_uefi_status_to_efi(rsp_data->status);
>   	}
>   
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>   }
>   
>   static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>   						unsigned long *name_size, efi_char16_t *name,
>   						efi_guid_t *guid)
>   {
> -	struct qsee_req_uefi_get_next_variable *req_data;
> -	struct qsee_rsp_uefi_get_next_variable *rsp_data;
> -	efi_status_t efi_status = EFI_SUCCESS;
> +	struct qsee_req_uefi_get_next_variable *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(qcom_tzmem) = NULL;
> +	efi_status_t efi_status;
>   	size_t guid_offs;
>   	size_t name_offs;
>   	size_t req_size;
> @@ -541,17 +507,13 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>   		__array(*name, *name_size / sizeof(*name))
>   	);
>   
> -	req_data = kzalloc(req_size, GFP_KERNEL);
> -	if (!req_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out;
> -	}
> +	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
> +	if (!req_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
> -	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
> -	if (!rsp_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out_free_req;
> -	}
> +	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, rsp_size, GFP_KERNEL);
> +	if (!rsp_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
>   	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
>   	req_data->guid_offset = guid_offs;
> @@ -567,20 +529,14 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>   		return EFI_INVALID_PARAMETER;
>   
>   	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
> -	if (status) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (status)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->length < sizeof(*rsp_data)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length < sizeof(*rsp_data))
> +		return EFI_DEVICE_ERROR;
>   
>   	if (rsp_data->status) {
>   		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
> @@ -595,77 +551,59 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>   		if (efi_status == EFI_BUFFER_TOO_SMALL)
>   			*name_size = rsp_data->name_size;
>   
> -		goto out_free;
> +		return efi_status;
>   	}
>   
> -	if (rsp_data->length > rsp_size) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length > rsp_size)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
> +		return EFI_DEVICE_ERROR;
>   
>   	if (rsp_data->name_size > *name_size) {
>   		*name_size = rsp_data->name_size;
> -		efi_status = EFI_BUFFER_TOO_SMALL;
> -		goto out_free;
> +		return EFI_BUFFER_TOO_SMALL;
>   	}
>   
> -	if (rsp_data->guid_size != sizeof(*guid)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->guid_size != sizeof(*guid))
> +		return EFI_DEVICE_ERROR;
>   
>   	memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data->guid_size);
>   	status = ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->name_offset,
>   			      rsp_data->name_size / sizeof(*name));
>   	*name_size = rsp_data->name_size;
>   
> -	if (status < 0) {
> +	if (status < 0)
>   		/*
>   		 * Return EFI_DEVICE_ERROR here because the buffer size should
>   		 * have already been validated above, causing this function to
>   		 * bail with EFI_BUFFER_TOO_SMALL.
>   		 */
>   		return EFI_DEVICE_ERROR;
> -	}
>   
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>   }
>   
>   static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi, u32 attr,
>   						  u64 *storage_space, u64 *remaining_space,
>   						  u64 *max_variable_size)
>   {
> -	struct qsee_req_uefi_query_variable_info *req_data;
> -	struct qsee_rsp_uefi_query_variable_info *rsp_data;
> -	efi_status_t efi_status = EFI_SUCCESS;
> +	struct qsee_req_uefi_query_variable_info *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(qcom_tzmem) = NULL;
>   	int status;
>   
> -	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
> -	if (!req_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out;
> -	}
> +	req_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*req_data),
> +				    GFP_KERNEL);
> +	if (!req_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
> -	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
> -	if (!rsp_data) {
> -		efi_status = EFI_OUT_OF_RESOURCES;
> -		goto out_free_req;
> -	}
> +	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*rsp_data),
> +				    GFP_KERNEL);
> +	if (!rsp_data)
> +		return EFI_OUT_OF_RESOURCES;
>   
>   	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
>   	req_data->attributes = attr;
> @@ -673,26 +611,19 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
>   
>   	status = qcom_qseecom_app_send(qcuefi->client, req_data, sizeof(*req_data), rsp_data,
>   				       sizeof(*rsp_data));
> -	if (status) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (status)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->command_id != QSEE_CMD_UEFI_QUERY_VARIABLE_INFO) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->command_id != QSEE_CMD_UEFI_QUERY_VARIABLE_INFO)
> +		return EFI_DEVICE_ERROR;
>   
> -	if (rsp_data->length != sizeof(*rsp_data)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length != sizeof(*rsp_data))
> +		return EFI_DEVICE_ERROR;
>   
>   	if (rsp_data->status) {
>   		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
>   			__func__, rsp_data->status);
> -		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
> -		goto out_free;
> +		return qsee_uefi_status_to_efi(rsp_data->status);
>   	}
>   
>   	if (storage_space)
> @@ -704,12 +635,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
>   	if (max_variable_size)
>   		*max_variable_size = rsp_data->max_variable_size;
>   
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>   }
>   
>   /* -- Global efivar interface. ---------------------------------------------- */
> @@ -838,6 +764,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>   	if (status)
>   		qcuefi_set_reference(NULL);
>   
> +	qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
> +	if (IS_ERR(qcuefi->mempool))
> +		return PTR_ERR(qcuefi->mempool);
> +
>   	return status;
>   }
>   
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 3a6cefb4eb2e..318d7d398e5f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1567,9 +1567,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
>   /**
>    * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
>    * @app_id:   The ID of the target app.
> - * @req:      Request buffer sent to the app (must be DMA-mappable).
> + * @req:      Request buffer sent to the app (must be TZ memory)
>    * @req_size: Size of the request buffer.
> - * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
> + * @rsp:      Response buffer, written to by the app (must be TZ memory)
>    * @rsp_size: Size of the response buffer.
>    *
>    * Sends a request to the QSEE app associated with the given ID and read back
> @@ -1585,26 +1585,12 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>   {
>   	struct qcom_scm_qseecom_resp res = {};
>   	struct qcom_scm_desc desc = {};
> -	dma_addr_t req_phys;
> -	dma_addr_t rsp_phys;
> +	phys_addr_t req_phys;
> +	phys_addr_t rsp_phys;
>   	int status;
>   
> -	/* Map request buffer */
> -	req_phys = dma_map_single(__scm->dev, req, req_size, DMA_TO_DEVICE);
> -	status = dma_mapping_error(__scm->dev, req_phys);
> -	if (status) {
> -		dev_err(__scm->dev, "qseecom: failed to map request buffer\n");
> -		return status;
> -	}
> -
> -	/* Map response buffer */
> -	rsp_phys = dma_map_single(__scm->dev, rsp, rsp_size, DMA_FROM_DEVICE);
> -	status = dma_mapping_error(__scm->dev, rsp_phys);
> -	if (status) {
> -		dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
> -		dev_err(__scm->dev, "qseecom: failed to map response buffer\n");
> -		return status;
> -	}
> +	req_phys = qcom_tzmem_to_phys(req);
> +	rsp_phys = qcom_tzmem_to_phys(rsp);
>   
>   	/* Set up SCM call data */
>   	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS;
> @@ -1622,10 +1608,6 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>   	/* Perform call */
>   	status = qcom_scm_qseecom_call(&desc, &res);
>   
> -	/* Unmap buffers */
> -	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
> -	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
> -
>   	if (status)
>   		return status;
>   
> diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
> index b531547e1dc9..26af1e778f00 100644
> --- a/include/linux/firmware/qcom/qcom_qseecom.h
> +++ b/include/linux/firmware/qcom/qcom_qseecom.h
> @@ -23,9 +23,9 @@ struct qseecom_client {
>   /**
>    * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
>    * @client:   The QSEECOM client associated with the target app.
> - * @req:      Request buffer sent to the app (must be DMA-mappable).
> + * @req:      Request buffer sent to the app (must be TZ memory).
>    * @req_size: Size of the request buffer.
> - * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
> + * @rsp:      Response buffer, written to by the app (must be TZ memory).
>    * @rsp_size: Size of the response buffer.
>    *
>    * Sends a request to the QSEE app associated with the given client and read
