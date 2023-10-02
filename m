Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012317B4EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjJBJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjJBJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:23:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024791
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:23:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533d9925094so18215229a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696238623; x=1696843423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Tt9uIJf62EJuNCl3Di8JJrZ5Pxjfaw5GLI4jWqpU0Q=;
        b=ulOuWRlfz8ewtW9g+WeY0/jm1TuGPvOknBuprBK2wcpQWuWVuDWOTXdgewgBYe+gy8
         WJ0ns4CGCvgb4YYLz1MOr3S9c8DNdpT1Qx6ialXRQzEHunBYWW665PjQaMEFR1awuuC/
         dc7jV8ggqjfe7O77YsLwb7E9pAlfotJp+2q1q2oNwdvOntNHVz8ImouvgEIDtaCrLvP/
         pHZEP/RnURiK2/YIKXwODNATjKCfDgJWwzotdSxEh/hQ/Iiniab4s12Pou48ffZrcL3s
         Dahbpr5yC6fhqpYvv/65u0DWAiScT1VQlpY4leq4LjPfD4i1W2iq88CaKylgfI/lKy6X
         7Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238623; x=1696843423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Tt9uIJf62EJuNCl3Di8JJrZ5Pxjfaw5GLI4jWqpU0Q=;
        b=B0Y0LaphFOjWaiMdvaejPS6JN01YPf5BkwNYmQNr6651GVBZnZ3eXSA3gqMZumKrZ9
         J6hsQ3Ws9Xw+fGlNik9RkEvjNHRGy+b9OFIPcW3FIPgedO1MdT2YrqyWpwt7cmSFoACL
         OsU7EXFN3uLRcgKNrDQkSpRy0UgbFct9qOk0/LtN8OUnlgmoyWtAPIVg1GjnWgvOZ4Y5
         iAMsDxaZZhmnjqo0kgZsQ8DySTghbGjSRQMD0rOCkA0wXZTmyasAqvSeiITbvxBC5Ihy
         t04Hw00rqjehfSOxob7hVesGD1/wkF5HyORcCBdW0hOpUlWCu6BNFC0aVrAshjhgxMAP
         Py5A==
X-Gm-Message-State: AOJu0Yx9kRg1SvM7FigREfE66erF5h8K3f73Hp1AG18wWRxz0XAycuF7
        rcVrjFZNkTNpjIg+KhjMmQWj+g==
X-Google-Smtp-Source: AGHT+IEEx5hEH8jh+czsyPeSvPANvsJfbtf4hBgEGiITFlQosM0D9trbLYAJQD9EUVNLOqpBrR8b6w==
X-Received: by 2002:a17:906:2097:b0:9ae:53df:9855 with SMTP id 23-20020a170906209700b009ae53df9855mr10793351ejq.58.1696238623191;
        Mon, 02 Oct 2023 02:23:43 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bl19-20020a170906c25300b0099bc8db97bcsm16675420ejb.131.2023.10.02.02.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:23:42 -0700 (PDT)
Message-ID: <84ff0dd8-706e-4b44-5313-3dd77b83100c@linaro.org>
Date:   Mon, 2 Oct 2023 10:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v10 1/3] nvmem: core: Rework layouts to become platform
 devices
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230922174854.611975-1-miquel.raynal@bootlin.com>
 <20230922174854.611975-2-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230922174854.611975-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Miquel for the work on this.
I have one comment below.


On 22/09/2023 18:48, Miquel Raynal wrote:
> Current layout support was initially written without modules support in
> mind. When the requirement for module support rose, the existing base
> was improved to adopt modularization support, but kind of a design flaw
> was introduced. With the existing implementation, when a storage device
> registers into NVMEM, the core tries to hook a layout (if any) and
> populates its cells immediately. This means, if the hardware description
> expects a layout to be hooked up, but no driver was provided for that,
> the storage medium will fail to probe and try later from
> scratch. Technically, the layouts are more like a "plus" and, even we
> consider that the hardware description shall be correct, we could still
> probe the storage device (especially if it contains the rootfs).
> 
> One way to overcome this situation is to consider the layouts as
> devices, and leverage the existing notifier mechanism. When a new NVMEM
> device is registered, we can:
> - populate its nvmem-layout child, if any
> - try to modprobe the relevant driver, if relevant
> - try to hook the NVMEM device with a layout in the notifier
> And when a new layout is registered:
> - try to hook all the existing NVMEM devices which are not yet hooked to
>    a layout with the new layout
> This way, there is no strong order to enforce, any NVMEM device creation
> or NVMEM layout driver insertion will be observed as a new event which
> may lead to the creation of additional cells, without disturbing the
> probes with costly (and sometimes endless) deferrals.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/nvmem/core.c             | 140 ++++++++++++++++++++++++-------
>   drivers/nvmem/layouts/onie-tlv.c |  39 +++++++--
>   drivers/nvmem/layouts/sl28vpd.c  |  39 +++++++--
>   include/linux/nvmem-provider.h   |  11 +--
>   4 files changed, 180 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index eaf6a3fe8ca6..14dd3ae777bb 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -17,11 +17,13 @@
>   #include <linux/nvmem-provider.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/of.h>
> +#include <linux/of_platform.h>
>   #include <linux/slab.h>
>   
>   struct nvmem_device {
>   	struct module		*owner;
>   	struct device		dev;
> +	struct list_head	node;
>   	int			stride;
>   	int			word_size;
>   	int			id;
> @@ -75,6 +77,7 @@ static LIST_HEAD(nvmem_cell_tables);
>   static DEFINE_MUTEX(nvmem_lookup_mutex);
>   static LIST_HEAD(nvmem_lookup_list);
>   
> +struct notifier_block nvmem_nb;
>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
>   
>   static DEFINE_SPINLOCK(nvmem_layout_lock);
> @@ -790,23 +793,16 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
>   static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
>   {
>   	struct device_node *layout_np;
> -	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
> +	struct nvmem_layout *l, *layout = NULL;
>   
>   	layout_np = of_nvmem_layout_get_container(nvmem);
>   	if (!layout_np)
>   		return NULL;
>   
> -	/*
> -	 * In case the nvmem device was built-in while the layout was built as a
> -	 * module, we shall manually request the layout driver loading otherwise
> -	 * we'll never have any match.
> -	 */
> -	of_request_module(layout_np);
> -
>   	spin_lock(&nvmem_layout_lock);
>   
>   	list_for_each_entry(l, &nvmem_layouts, node) {
> -		if (of_match_node(l->of_match_table, layout_np)) {
> +		if (of_match_node(l->dev->driver->of_match_table, layout_np)) {
>   			if (try_module_get(l->owner))
>   				layout = l;
>   
> @@ -863,7 +859,7 @@ const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
>   	const struct of_device_id *match;
>   
>   	layout_np = of_nvmem_layout_get_container(nvmem);
> -	match = of_match_node(layout->of_match_table, layout_np);
> +	match = of_match_node(layout->dev->driver->of_match_table, layout_np);
>   
>   	return match ? match->data : NULL;
>   }
> @@ -882,6 +878,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
>   struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   {
>   	struct nvmem_device *nvmem;
> +	struct device_node *layout_np;
>   	int rval;
>   
>   	if (!config->dev)
> @@ -974,19 +971,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   			goto err_put_device;
>   	}
>   
> -	/*
> -	 * If the driver supplied a layout by config->layout, the module
> -	 * pointer will be NULL and nvmem_layout_put() will be a noop.
> -	 */
> -	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
> -	if (IS_ERR(nvmem->layout)) {
> -		rval = PTR_ERR(nvmem->layout);
> -		nvmem->layout = NULL;
> -
> -		if (rval == -EPROBE_DEFER)
> -			goto err_teardown_compat;
> -	}
> -
>   	if (config->cells) {
>   		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
>   		if (rval)
> @@ -1005,24 +989,27 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> -	rval = nvmem_add_cells_from_layout(nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> -
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>   
>   	rval = device_add(&nvmem->dev);
>   	if (rval)
>   		goto err_remove_cells;
>   
> +	/* Populate layouts as devices */
> +	layout_np = of_nvmem_layout_get_container(nvmem);
> +	if (layout_np) {
> +		rval = of_platform_populate(nvmem->dev.of_node, NULL, NULL, NULL);
> +		of_node_put(layout_np);
> +		if (rval)
> +			goto err_remove_cells;
> +	}
> +
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
>   
>   err_remove_cells:
>   	nvmem_device_remove_all_cells(nvmem);
> -	nvmem_layout_put(nvmem->layout);
> -err_teardown_compat:
>   	if (config->compat)
>   		nvmem_sysfs_remove_compat(nvmem, config);
>   err_put_device:
> @@ -2124,13 +2111,106 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
>   }
>   EXPORT_SYMBOL_GPL(nvmem_dev_name);
>   
> +static void nvmem_try_loading_layout_driver(struct nvmem_device *nvmem)
> +{
> +	struct device_node *layout_np;
> +
> +	layout_np = of_nvmem_layout_get_container(nvmem);
> +	if (layout_np) {
> +		of_request_module(layout_np);
> +		of_node_put(layout_np);
> +	}
> +}
> +
> +static int nvmem_match_available_layout(struct nvmem_device *nvmem)
> +{
> +	int ret;
> +
> +	if (nvmem->layout)
> +		return 0;
> +
> +	nvmem->layout = nvmem_layout_get(nvmem);
> +	if (!nvmem->layout)
> +		return 0;
> +
> +	ret = nvmem_add_cells_from_layout(nvmem);
> +	if (ret) {
> +		nvmem_layout_put(nvmem->layout);
> +		nvmem->layout = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nvmem_dev_match_available_layout(struct device *dev, void *data)
> +{
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +
> +	return nvmem_match_available_layout(nvmem);
> +}
> +
> +static int nvmem_for_each_dev(int (*fn)(struct device *dev, void *data))
> +{
> +	return bus_for_each_dev(&nvmem_bus_type, NULL, NULL, fn);
> +}
> +
> +/*
> + * When an NVMEM device is registered, try to match against a layout and
> + * populate the cells. When an NVMEM layout is probed, ensure all NVMEM devices
> + * which could use it properly expose their cells.
> + */
> +static int nvmem_notifier_call(struct notifier_block *notifier,
> +			       unsigned long event_flags, void *context)
> +{
> +	struct nvmem_device *nvmem = NULL;
> +	int ret;
> +
> +	switch (event_flags) {
> +	case NVMEM_ADD:
> +		nvmem = context;
> +		break;
> +	case NVMEM_LAYOUT_ADD:
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}

It looks bit unnatural for core to register notifier for its own events.


Why do we need the notifier at core level, can we not just handle this 
in core before raising these events, instead of registering a notifier cb?


--srini


> +
> +	if (nvmem) {
> +		/*
> +		 * In case the nvmem device was built-in while the layout was
> +		 * built as a module, manually request loading the layout driver.
> +		 */
> +		nvmem_try_loading_layout_driver(nvmem);
> +
> +		/* Populate the cells of the new nvmem device from its layout, if any */
> +		ret = nvmem_match_available_layout(nvmem);
> +	} else {
> +		/* NVMEM devices might be "waiting" for this layout */
> +		ret = nvmem_for_each_dev(nvmem_dev_match_available_layout);
> +	}
> +
> +	if (ret)
> +		return notifier_from_errno(ret);
> +
> +	return NOTIFY_OK;
> +}
> +
>   static int __init nvmem_init(void)
>   {
> -	return bus_register(&nvmem_bus_type);
> +	int ret;
> +
> +	ret = bus_register(&nvmem_bus_type);
> +	if (ret)
> +		return ret;
> +
> +	nvmem_nb.notifier_call = &nvmem_notifier_call;
> +	return nvmem_register_notifier(&nvmem_nb);
>   }
>   
>   static void __exit nvmem_exit(void)
>   {
> +	nvmem_unregister_notifier(&nvmem_nb);
>   	bus_unregister(&nvmem_bus_type);
>   }
>   
