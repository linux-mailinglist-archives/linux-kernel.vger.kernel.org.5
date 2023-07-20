Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FFC75B80C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGTTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGTTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:33:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A719BE;
        Thu, 20 Jul 2023 12:33:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso7915355e9.0;
        Thu, 20 Jul 2023 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689881625; x=1690486425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK0hJ5BpyRFgpH94OVke+qc5eEO5PN9SBlCB1IrPJ4Q=;
        b=i8blU4Pr4DbcnmMFdb2hdCDhoNrYIJYkypL2UtrbQraTh3y0w3PQXful5HJx5Ydu1l
         XJBK4H37Hfj/camOALS3pRS3r+HIT85/z74idl9hQ/t7oiTpSN3VpaViiObyXB+Im5jg
         o0iXRmFVvl9RWkwLemeLX0TPkWk+V6NFNGaEzsOBtNRMxRPgC1+nIz1fukh0hE21vykE
         uytnXWN+DHz6b+dYSWeEPIdRRsdUqr9YejN3bVXUbJMPAe1njEid466hJwlxc0nFxyMc
         VoCZPwy1ZOtVPY2qfqpCdjTAPrJrNMptF/1taWaZWBjC7UlPLubsCG0w3RlsDW++VFFe
         zBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881625; x=1690486425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK0hJ5BpyRFgpH94OVke+qc5eEO5PN9SBlCB1IrPJ4Q=;
        b=KPSAdM+3zDeRK6HTh0axMPxy02XZPF9dyACakEwC8RTpOoZkqJ1pQE4h5mkPhKEAEp
         r2K2oR30Iqg6URdkmw9EzrzE8Ugk+HTUZrm+uY3YfpQ9XnKwkERXZ4sQEPt99TODDG0k
         7tQCqKxxbHJ5j7FjtA6uMxr2yeGV7vGdxew34oDjeOoc1C4cA1H77asOVCKtcnKArBwp
         cqLYDTtPB1Paw5/zZugRvT8jWHQJjIUqX4zoXLP/acAFoBVrYMmQqOFhyfZvsrrEMiJv
         HFx9LTuimhOkWlXJn9S1D4tVrtK29+0LUIC3Nz2vZBLIDcpzSZeoDuHh4Gg243NnSria
         rMmw==
X-Gm-Message-State: ABy/qLaAeZ1+l6SbIUs7SIr5NKrjmo9n1KqyhlYpb2zR8M2szt9NSji4
        GdodVZwCX/evDBgL0YKuMd4=
X-Google-Smtp-Source: APBJJlGYUXRzhkTyWCDi3k/5PqJp0K+6InU6ghcplgx1Kv7cF+BBf5pipmMEYHxGcIbMRuddw0eEoA==
X-Received: by 2002:a7b:c5d6:0:b0:3f4:2a69:409 with SMTP id n22-20020a7bc5d6000000b003f42a690409mr5589459wmk.11.1689881624376;
        Thu, 20 Jul 2023 12:33:44 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fa95f328afsm4522681wmi.29.2023.07.20.12.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:33:43 -0700 (PDT)
Message-ID: <0ab0b5a3-695e-742c-d9ef-c1b2503f3476@gmail.com>
Date:   Thu, 20 Jul 2023 21:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-5-luzmaximilian@gmail.com>
 <ZJ11H8btBhvCx9gD@hovoldconsulting.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZJ11H8btBhvCx9gD@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 14:12, Johan Hovold wrote:
> On Mon, May 29, 2023 at 01:03:51AM +0200, Maximilian Luz wrote:
>> On platforms using the Qualcomm UEFI Secure Application (uefisecapp),
>> EFI variables cannot be accessed via the standard interface in EFI
>> runtime mode. The respective functions return EFI_UNSUPPORTED. On these
>> platforms, we instead need to talk to uefisecapp. This commit provides
>> support for this and registers the respective efivars operations to
>> access EFI variables from the kernel.
>>
>> Communication with uefisecapp follows the Qualcomm QSEECOM / Secure OS
>> conventions via the respective SCM call interface. This is also the
>> reason why variable access works normally while boot services are
>> active. During this time, said SCM interface is managed by the boot
>> services. When calling ExitBootServices(), the ownership is transferred
>> to the kernel. Therefore, UEFI must not use that interface itself (as
>> multiple parties accessing this interface at the same time may lead to
>> complications) and cannot access variables for us.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Changes in v4:
>>   - Adapt to changes in DMA allocation in patch 3.
>>   - Rework alignment: Use native alignment of types instead of a general
>>     8 byte alignment. While the windows driver uses 8 byte alignment for
>>     GUIDs, the native (4 byte) alignment seems to work fine here.
>>   - Add a helper macro for determining size and layout of request and
>>     response buffers, taking care of proper alignment.
>>   - Implement support for EFI's query_variable_info() call, which is now
>>     supported by the kernel (and expected by efivarfs).
>>   - Move UCS-2 string helpers to lib/ucs2_string.c
> 
>> +config QCOM_QSEECOM_UEFISECAPP
>> +	tristate "Qualcomm SEE UEFI Secure App client driver"
>> +	select QCOM_SCM
>> +	select QCOM_SCM_QSEECOM
> 
> This should just be
> 
> 	depends on QCOM_SCM_QSEECOM
> 
> Using select should generally be avoided.

Okay.

>> +	depends on EFI
>> +	help
>> +	  Various Qualcomm SoCs do not allow direct access to EFI variables.
>> +	  Instead, these need to be accessed via the UEFI Secure Application
>> +	  (uefisecapp), residing in the Secure Execution Environment (SEE).
>> +
>> +	  This module provides a client driver for uefisecapp, installing efivar
>> +	  operations to allow the kernel accessing EFI variables, and via that also
>> +	  provide user-space with access to EFI variables via efivarfs.
>> +
>> +	  Select M or Y here to provide access to EFI variables on the
>> +	  aforementioned platforms.
> 
> We still have not really sorted how best to handle modular efivars
> implementations as userspace may try to mount efivarfs before the module
> has been loaded...
> 
> Perhaps require it to be built-in for now?

Sure, I can do that.

>> +
>>   config SYSFB
>>   	bool
>>   	select BOOT_VESA_SUPPORT
> 
>> +/* -- Alighment helpers ----------------------------------------------------- */
> 
> typo: Alignment

Oh, thanks for spotting that.
  
>> +
>> +/*
>> + * Helper macro to ensure proper alignment of types (fields and arrays) when
>> + * stored in some (contiguous) buffer.
>> + *
>> + * Note: The driver from which this one has been reverse-engineered expects an
>> + * alignment of 8 bytes (64 bits) for GUIDs. Our definition of efi_guid_t,
>> + * however, has an alignment of 4 byte (32 bits). So far, this seems to work
>> + * fine here. See also the comment on the typedef of efi_guid_t.
>> + */
>> +#define qcuefi_buf_align_fields(fields...)					\
>> +	({									\
>> +		size_t __len = 0;						\
>> +		fields								\
>> +		__len;								\
>> +	})
>> +
>> +#define __field_impl(size, align, offset)					\
>> +	({									\
>> +		size_t *__offset = (offset);					\
>> +		size_t __aligned;						\
>> +										\
>> +		__aligned = ALIGN(__len, align);				\
>> +		__len = __aligned + (size);					\
>> +										\
>> +		if (__offset)							\
>> +			*__offset = __aligned;					\
>> +	});
>> +
>> +#define __array_offs(type, count, offset)					\
>> +	__field_impl(sizeof(type) * (count), __alignof__(type), offset)
>> +
>> +#define __array(type, count)		__array_offs(type, count, NULL)
>> +#define __field_offs(type, offset)	__array_offs(type, 1, offset)
>> +#define __field(type)			__array_offs(type, 1, NULL)
> 
> Heh. This is some nice macro magic. :)
> 
>> +static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
>> +					   const efi_guid_t *guid, u32 *attributes,
>> +					   unsigned long *data_size, void *data)
>> +{
>> +	struct qsee_req_uefi_get_variable *req_data;
>> +	struct qsee_rsp_uefi_get_variable *rsp_data;
>> +	unsigned long buffer_size = *data_size;
>> +	efi_status_t efi_status = EFI_SUCCESS;
>> +	unsigned long name_length;
>> +	size_t guid_offs;
>> +	size_t name_offs;
>> +	size_t req_size;
>> +	size_t rsp_size;
>> +	int status;
>> +
>> +	/* Validation: We need a name and GUID. */
>> +	if (!name || !guid)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	/* Get length of name and ensure that the name is not truncated. */
>> +	name_length = ucs2_strnlen(name, QSEE_MAX_NAME_LEN) + 1;
>> +	if (name_length > QSEE_MAX_NAME_LEN)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	/* Validation: We need a buffer if the buffer_size is nonzero. */
>> +	if (buffer_size && !data)
>> +		return EFI_INVALID_PARAMETER;
>> +
>> +	/* Compute required buffer size for request. */
>> +	req_size = qcuefi_buf_align_fields(
>> +		__field(*req_data)
>> +		__array_offs(*name, name_length, &name_offs)
>> +		__field_offs(*guid, &guid_offs)
>> +	);
>> +
>> +	/* Compute required buffer size for response. */
>> +	rsp_size = qcuefi_buf_align_fields(
>> +		__field(*rsp_data)
>> +		__array(u8, buffer_size)
>> +	);
>> +
>> +	/* Allocate request buffer. */
>> +	req_data = kzalloc(req_size, GFP_KERNEL);
>> +	if (!req_data) {
>> +		efi_status = EFI_OUT_OF_RESOURCES;
>> +		goto out;
>> +	}
>> +
>> +	/* Allocate response buffer. */
>> +	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
>> +	if (!rsp_data) {
>> +		efi_status = EFI_OUT_OF_RESOURCES;
>> +		goto out_free_req;
>> +	}
>> +
>> +	/* Set up request data. */
>> +	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
>> +	req_data->data_size = buffer_size;
>> +	req_data->name_offset = name_offs;
>> +	req_data->name_size = name_length * sizeof(*name);
>> +	req_data->guid_offset = guid_offs;
>> +	req_data->guid_size = sizeof(*guid);
>> +	req_data->length = req_size;
>> +
>> +	/* Copy request parameters. */
>> +	ucs2_strlcpy(((void *)req_data) + req_data->name_offset, name, name_length);
>> +	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
>> +
>> +	/* Perform SCM call. */
>> +	status = qcom_scm_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
>> +
>> +	/* Check for errors and validate. */
>> +	if (status) {
>> +		efi_status = EFI_DEVICE_ERROR;
>> +		goto out_free;
>> +	}
>> +
>> +	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE) {
>> +		efi_status = EFI_DEVICE_ERROR;
>> +		goto out_free;
>> +	}
>> +
>> +	if (rsp_data->length < sizeof(*rsp_data)) {
>> +		efi_status = EFI_DEVICE_ERROR;
>> +		goto out_free;
>> +	}
>> +
>> +	if (rsp_data->status) {
>> +		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
>> +			__func__, rsp_data->status);
>> +		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
>> +
>> +		/* Update size and attributes in case buffer is too small. */
>> +		if (efi_status == EFI_BUFFER_TOO_SMALL) {
>> +			*data_size = rsp_data->data_size;
>> +			if (attributes)
>> +				*attributes = rsp_data->attributes;
>> +		}
>> +
>> +		goto out_free;
>> +	}
>> +
>> +	if (rsp_data->length > rsp_size) {
>> +		efi_status = EFI_DEVICE_ERROR;
>> +		goto out_free;
>> +	}
>> +
>> +	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length) {
>> +		efi_status = EFI_DEVICE_ERROR;
>> +		goto out_free;
>> +	}
>> +
>> +	/* Set attributes and data size even if buffer is too small. */
>> +	*data_size = rsp_data->data_size;
>> +	if (attributes)
>> +		*attributes = rsp_data->attributes;
>> +
>> +	/*
>> +	 * If we have a buffer size of zero and no buffer, just return
>> +	 * attributes and required size.
>> +	 */
>> +	if (buffer_size == 0 && !data) {
>> +		efi_status = EFI_SUCCESS;
>> +		goto out_free;
>> +	}
>> +
>> +	/* Validate output buffer size. */
>> +	if (buffer_size < rsp_data->data_size) {
>> +		efi_status = EFI_BUFFER_TOO_SMALL;
>> +		goto out_free;
>> +	}
>> +
>> +	/* Copy to output buffer. Note: We're guaranteed to have one at this point. */
>> +	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
>> +
>> +out_free:
>> +	kfree(rsp_data);
>> +out_free_req:
>> +	kfree(req_data);
>> +out:
>> +	return efi_status;
>> +}
> 
> The above reads very easily as it stands, but generally we try to avoid
> adding comments inside functions unless doing something unexpected or
> similar.
> 
> Comments like "Allocate response buffer" and "Perform SCM call" should
> not be needed as it should be clear from the code (given apt names of
> variables and function which you already seem to have chosen).

Okay, I'll drop those.

>> +/* -- Global efivar interface. ---------------------------------------------- */
>> +
>> +static struct qcuefi_client *__qcuefi;
>> +static DEFINE_MUTEX(__qcuefi_lock);
>> +
>> +static int qcuefi_set_reference(struct qcuefi_client *qcuefi)
>> +{
>> +	mutex_lock(&__qcuefi_lock);
>> +
>> +	if (qcuefi && __qcuefi) {
>> +		mutex_unlock(&__qcuefi_lock);
>> +		return -EEXIST;
>> +	}
>> +
>> +	__qcuefi = qcuefi;
>> +
>> +	mutex_unlock(&__qcuefi_lock);
>> +	return 0;
>> +}
>> +
>> +static struct qcuefi_client *qcuefi_acquire(void)
>> +	__acquires(&__qcuefi_lock)
> 
> I noticed that someone told you to add sparse annotation here but that
> was not correct.
> 
> The mutex implementation does not use sparse annotation so this actually
> introduces sparse warnings such as:
> 
> /home/johan/work/linaro/src/linux/drivers/firmware/qcom_qseecom_uefisecapp.c:741:29: warning: context imbalance in 'qcuefi_acquire' - wrong count at exit
> 
> Just drop the annotation again.

Sure, will do. I might also want to look into actually running sparse at
some point I guess...
  
>> +{
>> +	mutex_lock(&__qcuefi_lock);
>> +	return __qcuefi;
>> +}
>> +
>> +static void qcuefi_release(void)
>> +	__releases(&__qcuefi_lock)
>> +{
>> +	mutex_unlock(&__qcuefi_lock);
>> +}
> 
>> +static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>> +				 const struct auxiliary_device_id *aux_dev_id)
>> +{
>> +	struct qcuefi_client *qcuefi;
>> +	int status;
>> +
>> +	/* Allocate driver data. */
> 
> As mentioned above, I suggest dropping comments like this throughout.

Sure.
  
>> +	qcuefi = devm_kzalloc(&aux_dev->dev, sizeof(*qcuefi), GFP_KERNEL);
>> +	if (!qcuefi)
>> +		return -ENOMEM;
>> +
>> +	qcuefi->client = container_of(aux_dev, struct qseecom_client, aux_dev);
>> +
>> +	/* Register global reference. */
>> +	auxiliary_set_drvdata(aux_dev, qcuefi);
>> +	status = qcuefi_set_reference(qcuefi);
>> +	if (status)
>> +		return status;
>> +
>> +	/* Register efivar ops. */
>> +	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
>> +	if (status)
>> +		qcuefi_set_reference(NULL);
>> +
>> +	return status;
>> +}

Again, thanks for the review and the patience. I'll try to prepare a new
version over the weekend.

Regards
Max
