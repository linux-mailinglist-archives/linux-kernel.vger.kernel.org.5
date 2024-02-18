Return-Path: <linux-kernel+bounces-70168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB2859446
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41749B21446
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83E1847;
	Sun, 18 Feb 2024 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0fGYKMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58315C0;
	Sun, 18 Feb 2024 03:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708225719; cv=none; b=foNoCELyn7M+A1zG0A5iBQmf7yewTwdNhEDrNVN0vJFTQ4fcveeAcxmQE6yVYWdX+yxaDJU4dinE0YlM2pl706kC113D0n8ceErmSWOu1oLOcqsBFMfs825/kO93bnY+NqHtf8V97N54QCFZj/ojSWcAqXg7hkr02RmAQAPbdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708225719; c=relaxed/simple;
	bh=vXKSuTwc/tRfP2VcwyItf/MpWK++mKOeG9OELf0HgPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj130w4QZ2jSx5pmN98WSRnsEIfjPu5fFIlrxKSphw0FCbYvLDPimdq2M2xhh8vmepfeBuMQoPa2Sz+InJ/lR0fN60e0muFw1dW+WuLu6qjMhZK8EfntTHV7dWJthuSirkmhUCZ0RPQCcHhWLeSk1XOC9Bv0crj2SWAfr6u2iWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0fGYKMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D90DC433F1;
	Sun, 18 Feb 2024 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708225718;
	bh=vXKSuTwc/tRfP2VcwyItf/MpWK++mKOeG9OELf0HgPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0fGYKMHvgJo63tNe/uuhD0jskKrBLa5s0/6aVcVE5HPBlOFc2UnG1f2l3TocGnrF
	 Y5i7IKd21gv41GtxvKHoUQ5ZWqguC7mXmfpz8QgCPKSoybmM/JpPZvHtt6aTftfVjk
	 Xtkzk1NyGK5fbLO9yHkfL28rwrDZaOsyNPe7dqDsAzGY+zvpqBAmxzppvRQXVtkdeZ
	 90/g4jWxhBZVnmQNUd217q7bQFNLckkW9RZBCozJ0mbbjzgz1FkuBaNCrAw7oDbpCT
	 YFHU/ZcP/UsOyKNO/b3S1IyMkRP4KZOD184/62grZ86c6CJkwcxvb2paZsiGpfl7Xb
	 n5HCYI4Yd/NFg==
Date: Sat, 17 Feb 2024 21:08:35 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 08/12] firmware: qcom: qseecom: convert to using the
 TZ allocator
Message-ID: <yu5uhamdlygti3jo73ipy3gxhcmgxrm5g6imgqg6ksleim4ton@npvzlex2j4xi>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-9-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182810.58382-9-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 07:28:06PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> convert all users of it in the qseecom module to using the TZ allocator
> for creating SCM call buffers.

This reads as if this is removal of duplication, now that we have the TZ
allocation. But wasn't there something about you not being able to mix
and match shmbridge and non-shmbridge allocations in the interface, so
this transition is actually required? Or did I get that wrong and this
just reduction in duplication?

> Together with using the cleanup macros,
> it has the added benefit of a significant code shrink.

That is true, but the move to using cleanup macros at the same time as
changing the implementation makes it unnecessarily hard to reason about
this patch.

This patch would be much better if split in two.

> As this is
> largely a module separate from the SCM driver, let's use a separate
> memory pool.
> 

This module is effectively used to read and write EFI variables today.
Is that worth statically removing 256kb of DDR for? Is this done solely
because it logically makes sense, or did you choose this for a reason?

Regards,
Bjorn

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 281 +++++++-----------
>  drivers/firmware/qcom/qcom_scm.c              |  30 +-
>  include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>  3 files changed, 111 insertions(+), 204 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> index 32188f098ef3..3a068f8b6990 100644
> --- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> +++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> @@ -7,17 +7,21 @@
>   * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/ucs2_string.h>
>  
>  #include <linux/firmware/qcom/qcom_qseecom.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_tzmem.h>
>  
>  /* -- Qualcomm "uefisecapp" interface definitions. -------------------------- */
>  
> @@ -253,6 +257,7 @@ struct qsee_rsp_uefi_query_variable_info {
>  struct qcuefi_client {
>  	struct qseecom_client *client;
>  	struct efivars efivars;
> +	struct qcom_tzmem_pool *mempool;
>  };
>  
>  static struct device *qcuefi_dev(struct qcuefi_client *qcuefi)
> @@ -272,11 +277,11 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>  					   const efi_guid_t *guid, u32 *attributes,
>  					   unsigned long *data_size, void *data)
>  {
> -	struct qsee_req_uefi_get_variable *req_data;
> -	struct qsee_rsp_uefi_get_variable *rsp_data;
> +	struct qsee_req_uefi_get_variable *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_get_variable *rsp_data __free(qcom_tzmem) = NULL;
>  	unsigned long buffer_size = *data_size;
> -	efi_status_t efi_status = EFI_SUCCESS;
>  	unsigned long name_length;
> +	efi_status_t efi_status;
>  	size_t guid_offs;
>  	size_t name_offs;
>  	size_t req_size;
> @@ -304,17 +309,13 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>  		__array(u8, buffer_size)
>  	);
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
>  	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
>  	req_data->data_size = buffer_size;
> @@ -325,28 +326,20 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>  	req_data->length = req_size;
>  
>  	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
> -	if (status < 0) {
> -		efi_status = EFI_INVALID_PARAMETER;
> -		goto out_free;
> -	}
> +	if (status < 0)
> +		return EFI_INVALID_PARAMETER;
>  
>  	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>  
>  	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
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
>  	if (rsp_data->status) {
>  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
> @@ -360,18 +353,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>  				*attributes = rsp_data->attributes;
>  		}
>  
> -		goto out_free;
> +		return efi_status;
>  	}
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
>  	/*
>  	 * Note: We need to set attributes and data size even if the buffer is
> @@ -394,33 +383,23 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>  	if (attributes)
>  		*attributes = rsp_data->attributes;
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
>  	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
>  
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>  }
>  
>  static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
>  					   const efi_guid_t *guid, u32 attributes,
>  					   unsigned long data_size, const void *data)
>  {
> -	struct qsee_req_uefi_set_variable *req_data;
> -	struct qsee_rsp_uefi_set_variable *rsp_data;
> -	efi_status_t efi_status = EFI_SUCCESS;
> +	struct qsee_req_uefi_set_variable *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_set_variable *rsp_data __free(qcom_tzmem) = NULL;
>  	unsigned long name_length;
>  	size_t name_offs;
>  	size_t guid_offs;
> @@ -450,17 +429,14 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
>  		__array_offs(u8, data_size, &data_offs)
>  	);
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
>  	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
>  	req_data->attributes = attributes;
> @@ -473,10 +449,8 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
>  	req_data->length = req_size;
>  
>  	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
> -	if (status < 0) {
> -		efi_status = EFI_INVALID_PARAMETER;
> -		goto out_free;
> -	}
> +	if (status < 0)
> +		return EFI_INVALID_PARAMETER;
>  
>  	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>  
> @@ -485,42 +459,31 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
>  
>  	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data,
>  				       sizeof(*rsp_data));
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
>  	if (rsp_data->status) {
>  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
>  			__func__, rsp_data->status);
> -		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
> +		return qsee_uefi_status_to_efi(rsp_data->status);
>  	}
>  
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>  }
>  
>  static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>  						unsigned long *name_size, efi_char16_t *name,
>  						efi_guid_t *guid)
>  {
> -	struct qsee_req_uefi_get_next_variable *req_data;
> -	struct qsee_rsp_uefi_get_next_variable *rsp_data;
> -	efi_status_t efi_status = EFI_SUCCESS;
> +	struct qsee_req_uefi_get_next_variable *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(qcom_tzmem) = NULL;
> +	efi_status_t efi_status;
>  	size_t guid_offs;
>  	size_t name_offs;
>  	size_t req_size;
> @@ -545,17 +508,13 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>  		__array(*name, *name_size / sizeof(*name))
>  	);
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
>  	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
>  	req_data->guid_offset = guid_offs;
> @@ -567,26 +526,18 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>  	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>  	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name,
>  			      *name_size / sizeof(*name));
> -	if (status < 0) {
> -		efi_status = EFI_INVALID_PARAMETER;
> -		goto out_free;
> -	}
> +	if (status < 0)
> +		return EFI_INVALID_PARAMETER;
>  
>  	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
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
>  	if (rsp_data->status) {
>  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
> @@ -601,77 +552,59 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>  		if (efi_status == EFI_BUFFER_TOO_SMALL)
>  			*name_size = rsp_data->name_size;
>  
> -		goto out_free;
> +		return efi_status;
>  	}
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
>  	if (rsp_data->name_size > *name_size) {
>  		*name_size = rsp_data->name_size;
> -		efi_status = EFI_BUFFER_TOO_SMALL;
> -		goto out_free;
> +		return EFI_BUFFER_TOO_SMALL;
>  	}
>  
> -	if (rsp_data->guid_size != sizeof(*guid)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->guid_size != sizeof(*guid))
> +		return EFI_DEVICE_ERROR;
>  
>  	memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data->guid_size);
>  	status = ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->name_offset,
>  			      rsp_data->name_size / sizeof(*name));
>  	*name_size = rsp_data->name_size;
>  
> -	if (status < 0) {
> +	if (status < 0)
>  		/*
>  		 * Return EFI_DEVICE_ERROR here because the buffer size should
>  		 * have already been validated above, causing this function to
>  		 * bail with EFI_BUFFER_TOO_SMALL.
>  		 */
> -		efi_status = EFI_DEVICE_ERROR;
> -	}
> +		return EFI_DEVICE_ERROR;
>  
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>  }
>  
>  static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi, u32 attr,
>  						  u64 *storage_space, u64 *remaining_space,
>  						  u64 *max_variable_size)
>  {
> -	struct qsee_req_uefi_query_variable_info *req_data;
> -	struct qsee_rsp_uefi_query_variable_info *rsp_data;
> -	efi_status_t efi_status = EFI_SUCCESS;
> +	struct qsee_req_uefi_query_variable_info *req_data __free(qcom_tzmem) = NULL;
> +	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(qcom_tzmem) = NULL;
>  	int status;
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
>  	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
>  	req_data->attributes = attr;
> @@ -679,26 +612,19 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
>  
>  	status = qcom_qseecom_app_send(qcuefi->client, req_data, sizeof(*req_data), rsp_data,
>  				       sizeof(*rsp_data));
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
>  	if (rsp_data->status) {
>  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
>  			__func__, rsp_data->status);
> -		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
> -		goto out_free;
> +		return qsee_uefi_status_to_efi(rsp_data->status);
>  	}
>  
>  	if (storage_space)
> @@ -710,12 +636,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
>  	if (max_variable_size)
>  		*max_variable_size = rsp_data->max_variable_size;
>  
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>  }
>  
>  /* -- Global efivar interface. ---------------------------------------------- */
> @@ -844,6 +765,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>  	if (status)
>  		qcuefi_set_reference(NULL);
>  
> +	qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
> +	if (IS_ERR(qcuefi->mempool))
> +		return PTR_ERR(qcuefi->mempool);
> +
>  	return status;
>  }
>  
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 3a6cefb4eb2e..318d7d398e5f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1567,9 +1567,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
>  /**
>   * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
>   * @app_id:   The ID of the target app.
> - * @req:      Request buffer sent to the app (must be DMA-mappable).
> + * @req:      Request buffer sent to the app (must be TZ memory)
>   * @req_size: Size of the request buffer.
> - * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
> + * @rsp:      Response buffer, written to by the app (must be TZ memory)
>   * @rsp_size: Size of the response buffer.
>   *
>   * Sends a request to the QSEE app associated with the given ID and read back
> @@ -1585,26 +1585,12 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>  {
>  	struct qcom_scm_qseecom_resp res = {};
>  	struct qcom_scm_desc desc = {};
> -	dma_addr_t req_phys;
> -	dma_addr_t rsp_phys;
> +	phys_addr_t req_phys;
> +	phys_addr_t rsp_phys;
>  	int status;
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
>  	/* Set up SCM call data */
>  	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS;
> @@ -1622,10 +1608,6 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>  	/* Perform call */
>  	status = qcom_scm_qseecom_call(&desc, &res);
>  
> -	/* Unmap buffers */
> -	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
> -	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
> -
>  	if (status)
>  		return status;
>  
> diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
> index 5c28298a98be..e868fac55675 100644
> --- a/include/linux/firmware/qcom/qcom_qseecom.h
> +++ b/include/linux/firmware/qcom/qcom_qseecom.h
> @@ -27,9 +27,9 @@ struct qseecom_client {
>  /**
>   * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
>   * @client:   The QSEECOM client associated with the target app.
> - * @req:      Request buffer sent to the app (must be DMA-mappable).
> + * @req:      Request buffer sent to the app (must be TZ memory).
>   * @req_size: Size of the request buffer.
> - * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
> + * @rsp:      Response buffer, written to by the app (must be TZ memory).
>   * @rsp_size: Size of the response buffer.
>   *
>   * Sends a request to the QSEE app associated with the given client and read
> -- 
> 2.40.1
> 

