Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18F7BD78B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbjJIJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345692AbjJIJsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:48:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8C594
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:48:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40666aa674fso40810265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696844899; x=1697449699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcDBEh9tT+OAEwST3qjndiq/2rC0957sQfGVKrifBjA=;
        b=xEJYZiraM+YlDG+RzxRN2HcaNyvRxd77tV0hMSU1Y7D8PaTLl0vUbskJCBea5n7nK4
         gztUQx5XZX5ZAZpIgxbHvhlOpbzZiLTnf0XW3njUnIiZUvsPIQvjhO3cVdoythkXG0u1
         8AnXqya21BUOdYFmTYLreBtgGvFOZWfJ7Vr/yTcFve0Dbj4e8IfJXLDchtA6O/wg/pKR
         N7qyJkaoRnquzXsQLaHMUz1k9XrdUdNB509DsZ1HcMkVcqHSmhZAR8Y9rFIT+2FNXsOg
         yO99TpZ8UNi0izOnSxKaU7t+zwNoxQL6wB5hw0n8E7z1yhu88LjyuladTvP4B3GEcaor
         tAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844899; x=1697449699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcDBEh9tT+OAEwST3qjndiq/2rC0957sQfGVKrifBjA=;
        b=lnl4pCksLDAP/U7bYdgIxjp/AaPAfJr6r4x5znojbtc+hTXwMzmUFSDm1TJQlb05t0
         4JvMtgH3HyLwQFnv7EbvlfwCruppy8Y3KY5VarB2YVa3QiQbfXWdj9QZkZLju72sG7X3
         7TWHityw73hjFLS1wu8cAfNZSyTjrtGM7HOJ+JQC4ypTRuD48Aci7jN1B3c9pWJdILhk
         pGzPZRBoVirGiZtgSLXW8AP8KrBlCDa3AUrrmoT9edXu8IXZ32GrsR1R6ItT+t1VlvZ2
         LldNBXgdW6UpKaTXChCjP9NQx/IkhbSPDor/fVtUZias8xwmIdV79T7uuTOuj9+hYhRe
         x4qg==
X-Gm-Message-State: AOJu0Yx9OQXhfMerQWmqYOE5nTnHk6nFXtdv53TuZqulx8eKbmIVhPsF
        uO7s72orGu/azgu4EH3iu62uOw==
X-Google-Smtp-Source: AGHT+IGPqsFUDbVxTxcPqC8MUtZkS0ZFnpjfkuYliWFnriB/Ftmhga+9P707XkrGvNlqN3auETyENw==
X-Received: by 2002:a1c:7407:0:b0:401:c338:ab94 with SMTP id p7-20020a1c7407000000b00401c338ab94mr13567584wmc.29.1696844898752;
        Mon, 09 Oct 2023 02:48:18 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y24-20020a7bcd98000000b004064741f855sm10629557wmj.47.2023.10.09.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:48:18 -0700 (PDT)
Message-ID: <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
Date:   Mon, 9 Oct 2023 10:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 7/7] nvmem: core: Expose cells through sysfs
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-8-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231005155907.2701706-8-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2023 16:59, Miquel Raynal wrote:
> , int index);
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
> @@ -320,11 +357,21 @@ static const struct attribute_group nvmem_bin_group = {
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
>   	NULL,
>   };
>   
> +static const struct attribute_group *nvmem_cells_groups[] = {
> +	&nvmem_cells_group,
> +	NULL,
> +};
> +
>   static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
>   	.attr	= {
>   		.name	= "eeprom",
> @@ -380,6 +427,68 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
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
> +	if (list_empty(&nvmem->cells) || nvmem->sysfs_cells_populated) {
> +		nvmem_cells_group.bin_attrs = NULL;
> +		goto unlock_mutex;
> +	}
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
> +		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> +						    "%s@%x", entry->name,
> +						    entry->offset);
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
> +	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
> +	if (ret)
> +		goto unlock_mutex;

This is going to create groups after the nvmem device is added, isn't 
this going to be problem with user space notifications?

--srini
> +
> +	nvmem->sysfs_cells_populated = true;
> +
> +unlock_mutex:
> +	mutex_unlock(&nvmem_mutex);
> +
> +	return ret;
