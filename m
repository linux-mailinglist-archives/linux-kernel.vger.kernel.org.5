Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C028750F82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGLRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjGLRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:20:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E21FEC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:20:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so86779985e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689182404; x=1691774404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDRrYuGkfGu9+OWOJtRbwI/eG56aDj0AgxYkHMCfxpY=;
        b=N5Cq9HIRTYnQ6I2pyOLTzmuSfx+iyf+HX9Hbig6xWehSGSd92ZgjFJsBnbWyIY3Mr1
         WuaJiOy2q7xrT/M9G8ZnzDrEsaTEk1RmLIJQ0zQOxT5DFuEmnEc3Cmp1goBuyMCXNmRa
         E68J0LH0HxUTwEmEcOMV+ZGIPJ4h2rczqG+0cjg1FJeqhhy4ezolE272Tc16m7BRApTJ
         WeDRB0KXVIdxfhIeiecnjPMzSQuidhmCTql0B5jh7shfxEE81/L2R8rPkDGn9XmDwHOo
         ni6IXdVVNf2i6I6pA9OctZzCavcIX9FevNQQkSvrJYY2gkHmXcoXHhHCrX+r3We/haRD
         5duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689182404; x=1691774404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDRrYuGkfGu9+OWOJtRbwI/eG56aDj0AgxYkHMCfxpY=;
        b=c05gAXjKBkE4KQATh7JCIz5dnVpb0lP2c6qQzlaqihSB5duCDEmmCqqtGr5H4sl7Fy
         RD76vNIFabPQujn8GaQSj7eRUQ8jYJI8l9cg9gl8TTo6St+geu+uGzz5EYLrWQ9mxxhV
         EKgPIwc7YWtr+EX2W3Wj+yzab6FIa54B5t8kSo1OfJ5QfQQriD/hUxrcoClMXLgcJ4+g
         mcie8/iyA0wto9WpJA2SOYLBX5hERe+Y/XdTChmepo8zJS6NwJXuvPyEF9ficm5IPWrn
         02h9U1V1n+BC9uCDnBZvN1onyUT2oF6AEksMMWQGqjeoesbISS5DlJKx5dLcUosv9i4C
         wX7g==
X-Gm-Message-State: ABy/qLYXOM1LYSIwqAc6snc/kQrtDgn7mSzxj4mySS+jGiYMNUKEMwBv
        dB7SRBXHrwjt5Vbq8vyPctpoeg==
X-Google-Smtp-Source: APBJJlHDJIIDK7gc5cerAXF+NcrzKRdYfF682bDUWF5LzYa/c92XQDfsDVlHeeMDJs11K2h4u3Dumg==
X-Received: by 2002:a05:600c:2043:b0:3fc:25:ced6 with SMTP id p3-20020a05600c204300b003fc0025ced6mr20377383wmg.13.1689182404460;
        Wed, 12 Jul 2023 10:20:04 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id f17-20020a7bc8d1000000b003fa968e9c27sm16135534wml.9.2023.07.12.10.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:20:02 -0700 (PDT)
Message-ID: <838e1e9a-a679-5b2f-d190-cdd10016a7bf@linaro.org>
Date:   Wed, 12 Jul 2023 18:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/4] nvmem: core: Expose cells through sysfs
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
References: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
 <20230614063018.2419043-5-miquel.raynal@bootlin.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230614063018.2419043-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 14/06/2023 07:30, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of each
> cell, regardless of its position/size in the underlying
> device. Unfortunately, these information are not accessible by users,
> unless by fully re-implementing the parser logic in userland.
> 
> Let's expose the cells and their content through sysfs to avoid these
> situations. Of course the relevant NVMEM sysfs Kconfig option must be
> enabled for this support to be available.
> 
> Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> group member will be filled at runtime only when relevant and will
> remain empty otherwise. In this case, as the cells attribute group will
> be empty, it will not lead to any additional folder/file creation.
> 
> Exposed cells are read-only. There is, in practice, everything in the
> core to support a write path, but as I don't see any need for that, I
> prefer to keep the interface simple (and probably safer). The interface
> is documented as being in the "testing" state which means we can later
> add a write attribute if though relevant.
> 
> There is one limitation though: if a layout is built as a module but is
> not properly installed in the system and loaded manually with insmod
> while the nvmem device driver was built-in, the cells won't appear in
> sysfs. But if done like that, the cells won't be usable by the built-in
> kernel drivers anyway.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Unable to apply this, Can you re-base this on rc1?

--srini

> ---
>   drivers/nvmem/core.c | 109 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 105 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 342cd380b420..baa1f0038b28 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -325,6 +325,43 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>   	return nvmem_bin_attr_get_umode(nvmem);
>   }
>   
> +static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
> +					    const char *id, int index);
> +
> +static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *attr, char *buf,
> +				    loff_t pos, size_t count)
> +{
> +	struct nvmem_cell_entry *entry;
> +	struct nvmem_cell *cell = NULL;
> +	size_t cell_sz, read_len;
> +	void *content;
> +
> +	entry = attr->private;
> +	cell = nvmem_create_cell(entry, entry->name, 0);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	if (!cell)
> +		return -EINVAL;
> +
> +	content = nvmem_cell_read(cell, &cell_sz);
> +	if (IS_ERR(content)) {
> +		read_len = PTR_ERR(content);
> +		goto destroy_cell;
> +	}
> +
> +	read_len = min_t(unsigned int, cell_sz - pos, count);
> +	memcpy(buf, content + pos, read_len);
> +	kfree(content);
> +
> +destroy_cell:
> +	kfree_const(cell->id);
> +	kfree(cell);
> +
> +	return read_len;
> +}
> +
>   /* default read/write permissions */
>   static struct bin_attribute bin_attr_rw_nvmem = {
>   	.attr	= {
> @@ -346,8 +383,14 @@ static const struct attribute_group nvmem_bin_group = {
>   	.is_bin_visible = nvmem_bin_attr_is_visible,
>   };
>   
> +/* Cell attributes will be dynamically allocated */
> +static struct attribute_group nvmem_cells_group = {
> +	.name		= "cells",
> +};
> +
>   static const struct attribute_group *nvmem_dev_groups[] = {
>   	&nvmem_bin_group,
> +	&nvmem_cells_group,
>   	NULL,
>   };
>   
> @@ -406,6 +449,58 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
>   		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
>   }
>   
> +static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> +{
> +	struct bin_attribute **cells_attrs, *attrs;
> +	struct nvmem_cell_entry *entry;
> +	unsigned int ncells = 0, i = 0;
> +	int ret = 0;
> +
> +	mutex_lock(&nvmem_mutex);
> +
> +	if (list_empty(&nvmem->cells))
> +		goto unlock_mutex;
> +
> +	/* Allocate an array of attributes with a sentinel */
> +	ncells = list_count_nodes(&nvmem->cells);
> +	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
> +				   sizeof(struct bin_attribute *), GFP_KERNEL);
> +	if (!cells_attrs) {
> +		ret = -ENOMEM;
> +		goto unlock_mutex;
> +	}
> +
> +	attrs = devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribute), GFP_KERNEL);
> +	if (!attrs) {
> +		ret = -ENOMEM;
> +		goto unlock_mutex;
> +	}
> +
> +	/* Initialize each attribute to take the name and size of the cell */
> +	list_for_each_entry(entry, &nvmem->cells, node) {
> +		sysfs_bin_attr_init(&attrs[i]);
> +		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
> +		attrs[i].attr.mode = 0444;
> +		attrs[i].size = entry->bytes;
> +		attrs[i].read = &nvmem_cell_attr_read;
> +		attrs[i].private = entry;
> +		if (!attrs[i].attr.name) {
> +			ret = -ENOMEM;
> +			goto unlock_mutex;
> +		}
> +
> +		cells_attrs[i] = &attrs[i];
> +		i++;
> +	}
> +
> +	nvmem_cells_group.bin_attrs = cells_attrs;
> +
> +unlock_mutex:
> +	mutex_unlock(&nvmem_mutex);
> +
> +	return ret;
> +}
> +
>   #else /* CONFIG_NVMEM_SYSFS */
>   
>   static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> @@ -976,16 +1071,22 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> +	rval = nvmem_add_cells_from_layout(nvmem);
> +	if (rval)
> +		goto err_remove_cells;
> +
> +#ifdef CONFIG_NVMEM_SYSFS
> +	rval = nvmem_populate_sysfs_cells(nvmem);
> +	if (rval)
> +		goto err_remove_cells;
> +#endif
> +
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>   
>   	rval = device_add(&nvmem->dev);
>   	if (rval)
>   		goto err_remove_cells;
>   
> -	rval = nvmem_add_cells_from_layout(nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> -
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
