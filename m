Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8D7DCB54
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJaLE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjJaLEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:04:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0595CBB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:04:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-408425c7c10so43325665e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698750261; x=1699355061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuJmDFcnvNsNtD/SJQI6m9OhMw6aLlvxLn41QzQrOEU=;
        b=rA+EyrqIoTAa/LxuKxkuWGlgz50dgA7Mr1WXZF+/NwBxp/Qq4LZ1yYSNWKJSn0iiaI
         kBN3CekpvWuOl3rdLolDsHOW+phSfUuugbHCdigD36Pt333pp3hzOFBhT07gwnCjhkTv
         orGKcSVNQdhtqq1CVCh0wFuI7OeXnEKJBdNS6KmpXgwAYjR4wSeE2Q4/Ojm+k22CjzsN
         OQParDrt6YXHTurJsFInFJTcCmdd/bIcDjF/AqaZBU3LKGKRhAKucG1SbcRQfWnGslW+
         4kgayiAJL48GRqqbfF3A2As1XvO5a332m6veW3YkoxiQIYdSRirey6NGkaIcbKdgTuU4
         Mn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750261; x=1699355061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJmDFcnvNsNtD/SJQI6m9OhMw6aLlvxLn41QzQrOEU=;
        b=gypkfizyC5yrV/xXX5Q8dr6iiuPnMyPxjqmuxYy5TeB9LJrTcQOrp7TPFMF7E/XsS+
         mD35FlQ0bd0a5TJollJ/bHSCJohf/yEaGEQj+mpyUjPfLSWAI2C3Ju1fxVU39C8fuNlR
         S34cbnhvMAoue6XSW3J7ZgJNgLigwLgs2BjpZXQwM5uv9GFGKACpyTu7RZBrZ3zd77cZ
         tEtNQxPZ5y2niHXr9zNjeS3gvU1wt1YFtIDkKrO6QplMovYO2zPztWyV7V+vOIaB2QFc
         mk84ST85dlwnfqgikI/HSYSegBlXF/TKxlaTUoNv4u7I3624RqxjsoNYeEa5Acg63Kzu
         Xvrg==
X-Gm-Message-State: AOJu0YwAHd1YmVOsAMUCKR40kMok4WDsT2u7PE6U7R735WyZS4GY8S3p
        ipBVbnfgRkmTI1PZDBaeHT8O/g==
X-Google-Smtp-Source: AGHT+IFmjN3FzW7syv0iyhFJQ3HZaaedMn6d0WK5ehUDP7cH7BHv+son/CP3tnxzMzRsiz0mliX5Tg==
X-Received: by 2002:a05:6000:402c:b0:323:2d01:f043 with SMTP id cp44-20020a056000402c00b003232d01f043mr13494065wrb.3.1698750260661;
        Tue, 31 Oct 2023 04:04:20 -0700 (PDT)
Received: from [192.168.7.92] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4e03000000b0032da35baf7bsm1233831wrt.113.2023.10.31.04.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:04:20 -0700 (PDT)
Message-ID: <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org>
Date:   Tue, 31 Oct 2023 12:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tee: optee: Fix supplicant based device
 enumeration
To:     Sumit Garg <sumit.garg@linaro.org>, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com
References: <20231030155901.80673-1-sumit.garg@linaro.org>
 <20231030155901.80673-2-sumit.garg@linaro.org>
Content-Language: en-US
From:   Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20231030155901.80673-2-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 10/30/23 16:59, Sumit Garg wrote:
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
> 
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> 
> Fix this by separating supplicant dependent devices so that the
> user-space service can detach supplicant devices before closing the
> supplicant.
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/device.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..78fc0a15c463 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>  	kfree(optee_device);
>  }
>  
> -static int optee_register_device(const uuid_t *device_uuid)
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>  	struct tee_client_device *optee_device = NULL;
> +	const char *dev_name_fmt = NULL;
>  	int rc;
>  
>  	optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
>  
>  	optee_device->dev.bus = &tee_bus_type;
>  	optee_device->dev.release = optee_release_device;
> -	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> +
> +	if (func == PTA_CMD_GET_DEVICES_SUPP)
> +		dev_name_fmt = "optee-ta-supp-%pUb";
> +	else
> +		dev_name_fmt = "optee-ta-%pUb";

That's an ABI change, isn't it?

> +
> +	if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
>  		kfree(optee_device);
>  		return -ENOMEM;
>  	}
> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
>  	num_devices = shm_size / sizeof(uuid_t);
>  
>  	for (idx = 0; idx < num_devices; idx++) {
> -		rc = optee_register_device(&device_uuid[idx]);
> +		rc = optee_register_device(&device_uuid[idx], func);
>  		if (rc)
>  			goto out_shm;
>  	}

-- 
Jerome
