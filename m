Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380087DEECC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbjKBJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjKBJ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:26:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4767123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:26:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so101071766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698917188; x=1699521988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2j4aw7YBp5jH3zoZ5P27fk/bBVV//KerAOJCMIxdxw=;
        b=VSzvlD7lMjsGMtvRoZEVIiSbjxR5v8YfOeVLxUVXL+yPq9r/Q1qjMmCpEQApfS4ule
         sRyKWui9lAQDB+voot9LPfCbTaWbEhHLdGcpdLmsGcJXcB0dn4IX4tzTgH9PvmzcsyIO
         5AtvGUaXs73FYqwUUhOrw6L0m5qI6FtFDjLUKf5I7vY440GGlT6r5wtZPb066ryetHLR
         qbAAYpmlrogP7+DhoGZ7xEgf/7r3gR7JS/zowj67uEh99WuU4Ovpd2XTA9QxOBLnghle
         kwYjVNed/p86HV8VelDLov5Pt4cL+n6hjvwcZSWV7RK3Dk1bgrWjiZhZqzgiqAOZCTd6
         Z9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917188; x=1699521988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2j4aw7YBp5jH3zoZ5P27fk/bBVV//KerAOJCMIxdxw=;
        b=KMqlwkq5Uu0NCK8PGtHjerJeIlwq36urutxjozvHYonR+h5rfy5sejPskKDqYVoNZO
         LH3sJ898VgKXLFYhoTkLGtSZ5XaXPK7J1hLTAC2Vv44sTae7EKnLvKSWAQfT3j3gzujs
         MTh/mi5uiG/sEjmH8jSW/RSp3AO4I7FxFtA2cZ2ZNVWIHkP0VznecHWM9bRIJV6EpzqC
         R7umGHenDcuMrTHLLd9PtS2UpYl3uoJD6G2MLa5ymMIcmDJddhnwQ3Y6J5J2aWwxAdX+
         zDH4kLENzyyk9lhklmy03Z8j5nnHWOoN8KCgdFpGs1FliwDr3utufRhYMRqG11C+57cQ
         6Xnw==
X-Gm-Message-State: AOJu0YyZi/Bz6rYQsLLEkqCYhJZzt+i0pdgq08s173eGdssVXJGLw8bD
        c+5e620Bmar23I7+4uyL1gqEQQ==
X-Google-Smtp-Source: AGHT+IHl29ZCi0lgoUydVUgECgqBZHZ8myt0YPNHl+i79LdAaIXbhLW+IgKuzwJQmAdIYhxLCJtPVA==
X-Received: by 2002:a17:907:c1d:b0:9d2:20ee:b1d0 with SMTP id ga29-20020a1709070c1d00b009d220eeb1d0mr3288072ejc.53.1698917187873;
        Thu, 02 Nov 2023 02:26:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:12df:4a29:baa:4874? ([2a01:e0a:3cb:7bb0:12df:4a29:baa:4874])
        by smtp.gmail.com with ESMTPSA id lo10-20020a170906fa0a00b009b947aacb4bsm881718ejb.191.2023.11.02.02.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 02:26:27 -0700 (PDT)
Message-ID: <d3d6e1a6-51d1-4bc5-bb6a-f3fff1d3312f@linaro.org>
Date:   Thu, 2 Nov 2023 10:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tee: optee: Fix supplicant based device
 enumeration
To:     Sumit Garg <sumit.garg@linaro.org>, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org
Cc:     jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com
References: <20231102073056.174480-1-sumit.garg@linaro.org>
 <20231102073056.174480-2-sumit.garg@linaro.org>
Content-Language: en-US
From:   Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20231102073056.174480-2-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/23 08:30, Sumit Garg wrote:
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
> 
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> 
> Fix this by adding an attribute for supplicant dependent devices so that
> the user-space service can detect and detach supplicant devices before
> closing the supplicant:
> 
> $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && -f "$dev/driver/unbind" ]]; \
>       then echo $(basename "$dev") > $dev/driver/unbind; fi done
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
>  drivers/tee/optee/device.c                      | 17 +++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> index 0f58701367b6..d914f6629662 100644
> --- a/Documentation/ABI/testing/sysfs-bus-optee-devices
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -6,3 +6,12 @@ Description:
>  		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
>  		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
>  		are free to create needed API under optee-ta-<uuid> directory.
> +
> +What:		/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
> +Date:		July 2008
> +KernelVersion:	6.7
> +Contact:	op-tee@lists.trustedfirmware.org
> +Description:
> +		Allows to distinguish whether an OP-TEE based TA/device requires user-space
> +		tee-supplicant to function properly or not. This attribute will be present for
> +		devices which depend on tee-supplicant to be running.
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..4b1092127694 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
>  	kfree(optee_device);
>  }
>  
> -static int optee_register_device(const uuid_t *device_uuid)
> +static ssize_t need_supplicant_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	return 0;
> +}
> +
> +static DEVICE_ATTR_RO(need_supplicant);
> +
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>  	struct tee_client_device *optee_device = NULL;
>  	int rc;
> @@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
>  		put_device(&optee_device->dev);
>  	}
>  
> +	if (func == PTA_CMD_GET_DEVICES_SUPP)
> +		device_create_file(&optee_device->dev,
> +				   &dev_attr_need_supplicant);
> +
>  	return rc;
>  }
>  
> @@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
>  	num_devices = shm_size / sizeof(uuid_t);
>  
>  	for (idx = 0; idx < num_devices; idx++) {
> -		rc = optee_register_device(&device_uuid[idx]);
> +		rc = optee_register_device(&device_uuid[idx], func);
>  		if (rc)
>  			goto out_shm;
>  	}

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks!

-- 
Jerome
