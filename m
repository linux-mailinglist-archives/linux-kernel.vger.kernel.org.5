Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF275B7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGTTRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGTTRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:17:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459A3171D;
        Thu, 20 Jul 2023 12:17:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso9749135e9.1;
        Thu, 20 Jul 2023 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689880622; x=1690485422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXukylodVqH9JNB2xYzFmQvVhUgyJyk21M2oAxRxV5M=;
        b=U1PK+o1EwCgIYwcWbAmOWTxkL4ilXH/OEcylEqcP/tF//0tdBNqX5a9hnSfPZZqYZC
         YMJr/HUYI2M7gZvIFYVEoB8jcDqNflrLVKMWxc9rcmIvlTGiliMMWQlpEsToTIpk3cRS
         EsviPGnVnzN1cXM29H/4dI6e3sVpZyeO3wJ5B+IBDbhry5n/uS8JHO8nt1edTB0CO2rU
         13BefUsftCkLkkgpv9q3xkb2vCX+SlIR9LTgy5KRPzvmcoYxXegidxgqcWnIeyaw4H/+
         ua5HsKqvkBvry+oycDyrHSUghAeb5QO2U+F9dnwA3kIKCbzX9zzbK7z2In346PqKGqqs
         PkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880622; x=1690485422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXukylodVqH9JNB2xYzFmQvVhUgyJyk21M2oAxRxV5M=;
        b=HotRgE6LOg4ogX2Kpu6nBKxdicy3kXdCWuqqlalggvdozNTuvdL7MaBgBtFRPvBGpa
         0TIxUjIdWWZYlxZzONsmHfpPlD+6hejTPl+p6Tz0vBMLyxRSw+2Oqsuf6irabJidpXtc
         eAKkUoWhlvu2U+K398bytsFEBWJXFQYF8JByAfotB/zolCU8HZD228lqRanWA5BIhDep
         p9pfLeFagsoeG7qRuRQGRqqbbRoCei1+Q3aSFhyIkWNDTTgsB0zSYFSgHHpyXcH5vzIh
         TQ88zZWuYQUvRWmsqvl2gxbbTmgFzuYTZXG28CPmMFXZ5TswJESt4RwBRHuKFB0zghu1
         U/rA==
X-Gm-Message-State: ABy/qLa3JZBhQfNs2NgP9dPNQT6XM2Aj6qGSdaYq7jpaf4DFT/3Ov4By
        2bLvJg8fomKnfs9riUHw+rU=
X-Google-Smtp-Source: APBJJlGgMCpgwSWD62Him83usUN5FM/uQwvb/ofmRU5BrC1NqMjlJPD64U1HkIr1zS7H9TZvGqTyxw==
X-Received: by 2002:a05:6000:124d:b0:30e:4515:1529 with SMTP id j13-20020a056000124d00b0030e45151529mr2866029wrx.37.1689880621313;
        Thu, 20 Jul 2023 12:17:01 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d67c5000000b0031416362e23sm2118066wrw.3.2023.07.20.12.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:17:00 -0700 (PDT)
Message-ID: <20503e8b-553b-4f82-a72b-966342811053@gmail.com>
Date:   Thu, 20 Jul 2023 21:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] firmware: qcom_scm: Add support for Qualcomm
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
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-4-luzmaximilian@gmail.com>
 <ZJwjWoxm3GDkJ0cm@hovoldconsulting.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZJwjWoxm3GDkJ0cm@hovoldconsulting.com>
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

On 6/28/23 14:11, Johan Hovold wrote:
> On Mon, May 29, 2023 at 01:03:50AM +0200, Maximilian Luz wrote:
>> Add support for SCM calls to Secure OS and the Secure Execution
>> Environment (SEE) residing in the TrustZone (TZ) via the QSEECOM
>> interface. This allows communication with Secure/TZ applications, for
>> example 'uefisecapp' managing access to UEFI variables.
>>
>> The added interface attempts to automatically detect known and supported
>> applications, creating a client (auxiliary) device for each one. The
>> respective client/auxiliary driver is then responsible for managing and
>> communicating with the application.
>>
>> While this patch introduces only a very basic interface without the more
>> advanced features (such as re-entrant and blocking SCM calls and
>> listeners/callbacks), this is enough to talk to the aforementioned
>> 'uefisecapp'.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>
>> Changes in v4:
>>   - Remove instantiation of dedicated QSEECOM device and load the driver
>>     via qcom_scm instead. In particular:
>>     - Add a list of tested devices to ensure that we don't run into any
>>       issues with the currently unimplemented re-entrant calls.
>>     - Use the QSEECOM version to check for general availability of the
>>       interface.
>>     - Attempt to automatically detect available QSEECOM applications
>>       (and instantiate respective clients) based on a fixed list.
>>   - Use auxiliary bus and devices for clients instead of MFD.
>>   - Restructure DMA allocations: Use dma_map_single() directly inside
>>     qcom_scm_qseecom_app_send() instead of requiring clients to allocate
>>     DMA memory themselves.
>   
>> +#ifdef CONFIG_QCOM_SCM_QSEECOM
>> +
>> +/* Lock for QSEECOM SCM call executions */
>> +DEFINE_MUTEX(qcom_scm_qseecom_call_lock);
> 
> Missing static keyword.

Right.
  
>> +/**
>> + * qcom_scm_qseecom_call() - Perform a QSEECOM SCM call.
>> + * @desc: SCM call descriptor.
>> + * @res:  SCM call response (output).
>> + *
>> + * Performs the QSEECOM SCM call described by @desc, returning the response in
>> + * @rsp.
>> + *
>> + * Return: Returns zero on success, nonzero on failure.
> 
> Nit: You should drop "Returns" here and capitalise Zero. Similar below.

Okay, will do.
  
>> + */
> 
>> +/**
>> + * qcom_scm_qseecom_get_version() - Query the QSEECOM version.
>> + * @version: Pointer where the QSEECOM version will be stored.
>> + *
>> + * Performs the QSEECOM SCM querying the QSEECOM version currently running in
>> + * the TrustZone.
>> + *
>> + * Return: Returns zero on success, nonzero on failure.
>> + */
>> +static int qcom_scm_qseecom_get_version(u32 *version)
>> +{
>> +	struct qcom_scm_desc desc = {};
>> +	struct qcom_scm_qseecom_resp res = {};
>> +	u32 feature = 10;
>> +	int ret;
>> +
>> +	desc.owner = QSEECOM_TZ_OWNER_SIP;
>> +	desc.svc = QSEECOM_TZ_SVC_INFO;
>> +	desc.cmd = 0x03;
> 
> I know this has been reverse engineered, but is it possible to name also
> these cmd codes?

Sure, I can try.

>> +	desc.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL);
>> +	desc.args[0] = feature;
>> +
>> +	ret = qcom_scm_qseecom_call(&desc, &res);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*version = res.result;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qcom_scm_qseecom_app_get_id() - Query the app ID for a given QSEE app name.
>> + * @app_name: The name of the app.
>> + * @app_id:   The returned app ID.
>> + *
>> + * Query and return the application ID of the SEE app identified by the given
>> + * name. This returned ID is the unique identifier of the app required for
>> + * subsequent communication.
>> + *
>> + * Return: Returns zero on success, nonzero on failure. Returns -ENOENT if the
>> + * app has not been loaded or could not be found.
>> + */
>> +static int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
>> +{
>> +	unsigned long name_buf_size = QSEECOM_MAX_APP_NAME_SIZE;
>> +	unsigned long app_name_len = strlen(app_name);
>> +	struct qcom_scm_desc desc = {};
>> +	struct qcom_scm_qseecom_resp res = {};
>> +	dma_addr_t name_buf_phys;
>> +	char *name_buf;
>> +	int status;
>> +
>> +	if (app_name_len >= name_buf_size)
>> +		return -EINVAL;
>> +
>> +	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
>> +	if (!name_buf)
>> +		return -ENOMEM;
>> +
>> +	memcpy(name_buf, app_name, app_name_len);
>> +
>> +	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
>> +	if (dma_mapping_error(__scm->dev, name_buf_phys)) {
>> +		kfree(name_buf);
>> +		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
>> +		return -EFAULT;
> 
> This should be -ENOMEM (you can also just use the return value from
> dma_mapping_error()). Similar below.

Somehow I missed that dma_mapping_error() returned an actuall error
code. Will use that.

>> +	}
>> +
>> +	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
>> +	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
>> +	desc.cmd = 0x03;
>> +	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
>> +	desc.args[0] = name_buf_phys;
>> +	desc.args[1] = app_name_len;
>> +
>> +	status = qcom_scm_qseecom_call(&desc, &res);
>> +	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
>> +	kfree(name_buf);
>> +
>> +	if (status)
>> +		return status;
>> +
>> +	if (res.result == QSEECOM_RESULT_FAILURE)
>> +		return -ENOENT;
>> +
>> +	if (res.result != QSEECOM_RESULT_SUCCESS)
>> +		return -EINVAL;
>> +
>> +	if (res.resp_type != QSEECOM_SCM_RES_APP_ID)
>> +		return -EINVAL;
>> +
>> +	*app_id = res.data;
>> +	return 0;
>> +}
>> +
>> +/**
>> + * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
>> + * @client:   The QSEECOM client device corresponding to the target app.
>> + * @req:      Request buffer sent to the app (must be DMA-mappable).
>> + * @req_size: Size of the request buffer.
>> + * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
>> + * @rsp_size: Size of the response buffer.
>> + *
>> + * Sends a request to the QSEE app associated with the given client and read
>> + * back its response. The caller must provide two DMA memory regions, one for
>> + * the request and one for the response, and fill out the @req region with the
>> + * respective (app-specific) request data. The QSEE app reads this and returns
>> + * its response in the @rsp region.
>> + *
>> + * Return: Returns zero on success, nonzero error code on failure.
>> + */
>> +int qcom_scm_qseecom_app_send(struct qseecom_client *client, void *req,
>> +			      size_t req_size, void *rsp, size_t rsp_size)
>> +{
> 
>> +}
>> +EXPORT_SYMBOL(qcom_scm_qseecom_app_send);
> 
> Should this not be EXPORT_SYMBOL_GPL()?

Indeed it should.
  
>> +
>> +static void qseecom_client_release(struct device *dev)
>> +{
>> +	struct qseecom_client *client = container_of(dev, struct qseecom_client, aux_dev.dev);
>> +
>> +	kfree(client);
>> +}
>> +
>> +static void qseecom_client_remove(void *data)
>> +{
>> +	struct qseecom_client *client = data;
>> +
>> +	auxiliary_device_delete(&client->aux_dev);
>> +	auxiliary_device_uninit(&client->aux_dev);
>> +}
>> +
>> +static int qseecom_client_register(const struct qseecom_app_desc *desc)
>> +{
>> +	struct qseecom_client *client;
>> +	u32 app_id;
>> +	int ret;
>> +
>> +	/* Try to find the app ID, skip device if not found */
>> +	ret = qcom_scm_qseecom_app_get_id(desc->app_name, &app_id);
>> +	if (ret)
>> +		return ret == -ENOENT ? 0 : ret;
>> +
>> +	dev_info(__scm->dev, "qseecom: setting up client for %s\n", desc->app_name);
>> +
>> +	/* Allocate and set-up the client device */
>> +	client = kzalloc(sizeof(*client), GFP_KERNEL);
>> +	if (!client)
>> +		return -ENOMEM;
>> +
>> +	client->aux_dev.name = desc->dev_name;
>> +	client->aux_dev.dev.parent = __scm->dev;
>> +	client->aux_dev.dev.release = qseecom_client_release;
>> +	client->app_id = app_id;
>> +
>> +	ret = auxiliary_device_init(&client->aux_dev);
>> +	if (ret) {
>> +		kfree(client);
>> +		return ret;
>> +	}
>> +
>> +	ret = auxiliary_device_add(&client->aux_dev);
>> +	if (ret) {
>> +		auxiliary_device_uninit(&client->aux_dev);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Ensure that the device is properly cleaned up in case of removal or
>> +	 * errors.
>> +	 */
>> +	ret = devm_add_action_or_reset(__scm->dev, qseecom_client_remove, client);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * We do not yet support re-entrant calls via the qseecom interface. To prevent
>> + + any potential issues with this, only allow validated devices for now.
>> + */
>> +static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
>> +	{ .compatible = "lenovo,thinkpad-x13s", },
>> +	{ }
>> +};
>> +
>> +static bool qcom_scm_qseecom_device_allowed(void)
>> +{
>> +	struct device_node *np;
>> +	bool match;
>> +
>> +	np = of_find_node_by_path("/");
>> +	match = of_match_node(qcom_scm_qseecom_allowlist, np);
>> +	of_node_put(np);
>> +
>> +	return match;
>> +}
>> +
>> +static const struct qseecom_app_desc qcom_scm_qseecom_apps[] = {};
>> +
>> +static int qcom_scm_qseecom_init(void)
>> +{
>> +	u32 version;
>> +	int ret, i;
>> +
>> +	/* Try to query the qseecom version, skip qseecom setup if this fails */
>> +	ret = qcom_scm_qseecom_get_version(&version);
>> +	if (ret)
>> +		return 0;
>> +
>> +	dev_info(__scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
>> +
>> +	/* Check against tested/verified devices */
>> +	if (!qcom_scm_qseecom_device_allowed()) {
>> +		dev_info(__scm->dev, "qseecom: untested device, skipping\n");
> 
> Perhaps call the helper machine_allowed() and update the commit message
> to match (cf. of_machine_is_compatible())?

Thanks, I didn't know about of_machine_is_compatible(). Makes sense to
keep the naming aligned.

>> +		return 0;
>> +	}
>> +
>> +	/* Set up client devices for each base application */
>> +	for (i = 0; i < ARRAY_SIZE(qcom_scm_qseecom_apps); i++) {
>> +		ret = qseecom_client_register(&qcom_scm_qseecom_apps[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#else /* CONFIG_QCOM_SCM_QSEECOM */
>> +
>> +static int qcom_scm_qseecom_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif /* CONFIG_QCOM_SCM_QSEECOM */
>> +
>>   /**
>>    * qcom_scm_is_available() - Checks if SCM is available
>>    */
>> @@ -1496,6 +1903,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   
>>   	__get_convention();
>>   
>> +	ret = qcom_scm_qseecom_init();
>> +	if (ret < 0) {
>> +		__scm = NULL;
> 
> So as I mentioned in my reply to 2/4, you can still have clients
> registered here when you clear the __scm pointer which they rely on
> after an error.
> 
> Not sure how best to handle this, but perhaps registering a qseecom
> platform device here and have it's driver probe defer until scm is
> available would work?
> 
> That way you could also separate out the qseecom implementation in a
> separate file (driver) rather than having the ifdef above.

The main reason it's in one file is because people were against
exporting core SCM functions in v3, fearing abuse by allowing GKI
compatibility through implementation of SCM clients in modules (i.e.
vendors loosing the last reasons to push their code upstream).

I believe I used a dedicated parent device in v3 and I tend to agree
that it's conceptually a bit nicer to separate these things (with the
downside that it needs a bit more code). I'll play around with it a bit
on the weekend and see if I can't find something better, but I think
some code will still need to stay here.

>> +		return dev_err_probe(scm->dev, ret, "Failed to initialize qseecom\n");
>> +	}
>> +
>>   	/*
>>   	 * If requested enable "download mode", from this point on warmboot
>>   	 * will cause the boot stages to enter download mode, unless
> 
> Overall this looks really good. Nice job!

Thanks!

Regards
Max
