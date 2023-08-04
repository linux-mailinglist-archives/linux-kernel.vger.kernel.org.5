Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59358770982
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHDULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjHDULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:11:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31A1704;
        Fri,  4 Aug 2023 13:11:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdcade7fbso339127866b.1;
        Fri, 04 Aug 2023 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179881; x=1691784681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKN8y/AC/acz/Szpon8X/f+yEM6VT8OIjSeBHa40AyQ=;
        b=e4V/NgB0ai/dAHdj/nJ3fGjRyEetuud6Vmvqu9AkA2uL194LpO1PK9UQ7NlFyWL71o
         343AiWXtajBvbetr7V/h3JcZbRs5gUp77PRny54PJdImpQt93m9p0k8WoX0iWqK+KWMM
         nAkqZsrOxbCrzLl/sMF6h1dMOfGkIRDY6gNyONBKtsHGxqH6vonMFdbAz31s87ycaR48
         j/IeUwzusSFi+uKGpxe/XKDeJOd6/PFBEROxD124Z0V0qxBUP95NCjPdZLVY8Yv0KNJK
         6lcYKKJn+v4Qr788DuAu1pDOxKdSLK4dC6WH6Cpg0tRiSxB4vbrqTYnUYPuG9c8IuNEs
         tO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179881; x=1691784681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKN8y/AC/acz/Szpon8X/f+yEM6VT8OIjSeBHa40AyQ=;
        b=J6LX52iQUq+QWtMk/l9K4XWoNIy92XNIimwx5Qt+sMOhha7LjwKnXSx4LHWMu+vMtT
         +u0jXV5VOx8W3s+vkjmyDnYm6n6CDGZfFbXpfGXlRlGxRKkvATu5jRVF22ouYAFqT32F
         qu/44BOfejzYxjes+XYPVKcMPJDxllZ4EcN/JrHKurCOCzqPa+BISQvofFOz1F8CVDRf
         Y7zxPdc+McS1CVjN00n9/Xuej7Y1JWBHrV8E976i9Tb4ygISWYyxxklehO4jAnHt5IaS
         +b8LhsJaUR7JEB2Uh4v+3REBnnQZRC5abuL+BHbHg7TKgYklM/1ZaJohFCvkxuv7YcB4
         jW1g==
X-Gm-Message-State: AOJu0Yy5M6s8raNl45asQXGOEg1P5UqynLWiDuJQNh4BlqBFTxJHsHoi
        UMQu2fnnU44PtMVEGxDZmtg=
X-Google-Smtp-Source: AGHT+IFsw8jrp/3QMWBqlm5qWJlkBpl5RR8R9zejcUJhe8yU4PtN0Y5X6BYX79WuC/VTf//8Z1QNxg==
X-Received: by 2002:a17:906:cc4d:b0:977:95f4:5cca with SMTP id mm13-20020a170906cc4d00b0097795f45ccamr2220834ejb.54.1691179880780;
        Fri, 04 Aug 2023 13:11:20 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906095400b00992e14af9b9sm1720651ejd.134.2023.08.04.13.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 13:11:20 -0700 (PDT)
Message-ID: <b4d7dbca-f77f-dd8b-2b4c-c82bee086627@gmail.com>
Date:   Fri, 4 Aug 2023 22:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
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
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-3-luzmaximilian@gmail.com>
 <ZM0r-ZrkWXBtNZJZ@hovoldconsulting.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZM0r-ZrkWXBtNZJZ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 18:48, Johan Hovold wrote:
> On Sun, Jul 30, 2023 at 06:19:03PM +0200, Maximilian Luz wrote:
> 
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Driver for Qualcomm Secure Execution Environment (SEE) interface (QSEECOM).
>> + * Responsible for setting up and managing QSEECOM client devices.
>> + *
>> + * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
>> + */
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/types.h>
> 
> Looks like you're missing some includes like module.h and slab.h.

Right. I'll add both for the next version.

>> +
>> +#include <linux/firmware/qcom/qcom_qseecom.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
> 
>> +static void qseecom_client_release(struct device *dev)
>> +{
>> +	struct qseecom_client *client = container_of(dev, struct qseecom_client, aux_dev.dev);
> 
> Nit: Perhaps you can separate declaration and initialisation here to
> stay within 80 columns.

Sure, I'll do that.

>> +
>> +	kfree(client);
>> +}
> 
>> +static int qcom_qseecom_remove(struct platform_device *qseecom_dev)
>> +{
>> +	return 0;	/* Nothing to do here, all is managed via devm. */
>> +}
> 
> You should just drop this one (even if it serves as documentation).

Okay.
  
>> +static struct platform_driver qcom_qseecom_driver = {
>> +	.driver = {
>> +		.name	= "qcom_qseecom",
>> +	},
>> +	.probe = qcom_qseecom_probe,
>> +	.remove = qcom_qseecom_remove,
>> +};
>> +
>> +static int __init qcom_qseecom_init(void)
>> +{
>> +	return platform_driver_register(&qcom_qseecom_driver);
>> +}
>> +subsys_initcall(qcom_qseecom_init);
>> +
>> +static void __exit qcom_qseecom_exit(void)
>> +{
>> +	platform_driver_unregister(&qcom_qseecom_driver);
>> +}
>> +module_exit(qcom_qseecom_exit);
> 
> No need for this one either since this driver can only be built-in now.

Right.

>> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
>> +MODULE_DESCRIPTION("Driver for the Qualcomm SEE (QSEECOM) interface");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:qcom_qseecom");
> 
> No need for MODULE_ALIAS() either.

Oh right. As long as the module and device name match this should work
automatically, correct? I forgot about that.

>> +static void qcom_scm_qseecom_free(void *data)
>> +{
>> +	struct platform_device *qseecom_dev = data;
>> +
>> +	platform_device_unregister(qseecom_dev);
> 
> Perhaps use platform_device_del() and platform_device_put() for symmetry
> as you're not using platform_device_register() below.

Sure, I can do that.
  
>> +}
>> +
>> +static int qcom_scm_qseecom_init(struct qcom_scm *scm)
>> +{
>> +	struct platform_device *qseecom_dev;
>> +	u32 version;
>> +	int ret;
>> +
>> +	/*
>> +	 * Note: We do two steps of validation here: First, we try to query the
>> +	 * QSEECOM version as a check to see if the interface exists on this
>> +	 * device. Second, we check against known good devices due to current
>> +	 * driver limitations (see comment in qcom_scm_qseecom_allowlist).
>> +	 *
>> +	 * Note that we deliberately do the machine check after the version
>> +	 * check so that we can log potentially supported devices. This should
>> +	 * be safe as downstream sources indicate that the version query is
>> +	 * neither blocking nor reentrant.
>> +	 */
>> +	ret = qcom_scm_qseecom_get_version(&version);
>> +	if (ret)
>> +		return 0;
>> +
>> +	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
>> +
>> +	if (!qcom_scm_qseecom_machine_is_allowed()) {
>> +		dev_info(scm->dev, "qseecom: untested device, skipping\n");
> 
> untested "machine"?

That would be more consistent, yes.
  
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Set up QSEECOM interface device. All application clients will be
>> +	 * set up and managed by the corresponding driver for it.
>> +	 */
>> +	qseecom_dev = platform_device_alloc("qcom_qseecom", -1);
>> +	if (!qseecom_dev)
>> +		return -ENOMEM;
>> +
>> +	qseecom_dev->dev.parent = scm->dev;
>> +
>> +	ret = platform_device_add(qseecom_dev);
>> +	if (ret) {
>> +		platform_device_put(qseecom_dev);
>> +		return ret;
>> +	}
>> +
>> +	return devm_add_action_or_reset(scm->dev, qcom_scm_qseecom_free, qseecom_dev);
>> +}
>> +
>> +#else /* CONFIG_QCOM_QSEECOM */
>> +
>> +static int qcom_scm_qseecom_init(struct qcom_scm *scm)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif /* CONFIG_QCOM_QSEECOM */
>> +
>>   /**
>>    * qcom_scm_is_available() - Checks if SCM is available
>>    */
>> @@ -1468,6 +1848,18 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   	if (download_mode)
>>   		qcom_scm_set_download_mode(true);
>>   
>> +	/*
>> +	 * Initialize the QSEECOM interface. Note: QSEECOM is fairly
> 
> Nit: I'd add a line break and an empty line before the "Note:".

Sure, I'll do that.
  
>> +	 * self-contained and this only adds the interface device (the driver
>> +	 * of which does most of the heavy lifting). So any errors returned
>> +	 * here should be either -ENOMEM or -EINVAL (with the latter only in
>> +	 * case there's a bug in our code). This means that there is no need to
>> +	 * bring down the whole SCM driver. Just log the error instead and let
>> +	 * SCM live.
>> +	 */
>> +	ret = qcom_scm_qseecom_init(scm);
>> +	WARN(ret < 0, "failed to initialize qseecom: %d", ret);
> 
> Missing '\n'.

Right.
  
>> +
>>   	return 0;
>>   }
>>   
>    
>> +#ifdef CONFIG_QCOM_QSEECOM
>> +
>> +int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
>> +int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>> +			      size_t rsp_size);
>> +
>> +#else /* CONFIG_QCOM_QSEECOM */
>> +
>> +int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>> +			      size_t rsp_size)
>> +{
>> +	return -EINVAL;
>> +}
> 
> These should be static inline as you already noticed.

Already done :)

>> +
>> +#endif /* CONFIG_QCOM_QSEECOM */
>> +
>>   #endif
> 
> With the above fixed you can add my
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks!

Regards
Max
