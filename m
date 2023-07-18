Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C275793C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGRK0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGRK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:26:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EB5132
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:26:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b9cdef8619so34108015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689675980; x=1692267980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+h8DbYnOjnmebTyDiEmEfE/z7d2WtnxelIIMZJCVNA=;
        b=HPLOOM9FO7EyyqsX63hDCTNah5pcoQODsOUs/f1MnpE3RpkAHc0Ws3KrzcXJG7sgk6
         9ms/F9P2xKpY6jvTbFmVi4Hmkup/PXTZ8uLK6+CQGlDI6iYLrVvfmdBbZSBIaQmw3BVL
         AC4abqBjvd4KyoPsQHdWnxAqaNhhCX/haq3dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675980; x=1692267980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+h8DbYnOjnmebTyDiEmEfE/z7d2WtnxelIIMZJCVNA=;
        b=QQ8QlMtSyimPNtH6ty37T2rGu4nwVbl9VxoWmM+1E83fa7EjK1R7hbnfohfJMn97Yi
         NYJgM+GA6LUEv9IW1tiCjiSMwrd+oLdG3NX6PJKQ+H9xUmWTgCeOcsq5obTGcC0Y/cgK
         v1RNKVcGlNKwFsiH1ak9Nr8Al0QPXIdabt70rQlV+teSOWtfsx21DsXot2o1h2iKO8c6
         gINbs+nHiJMsNUFlJhzIG7WN3aRFbonIvHwNPVU+2qv0mAEglkSQNYbE5Hzqtwj5A2HK
         rb5/3frLsZiCd6KURuFlr6vV+TCGClhyXG2CRuBcu0DDZlr+wSnKyLy+7StjsY8QnssU
         9JsA==
X-Gm-Message-State: ABy/qLZdG0TOgIk7mO+bNJbZBAw+3XbRHZmgKl+VwajgJjLKgAm4m4+u
        x+4uGh9L5WV1M9YA2qrOP5Ojnw==
X-Google-Smtp-Source: APBJJlGiHtLaLGlZGuHJ3RbmOS7Yv4FCfh54s8mDZ9BHSKr4zN5e4yjkQP6LjepKmAbGhvlSGfkDfg==
X-Received: by 2002:a17:902:b28b:b0:1b8:6cab:db7f with SMTP id u11-20020a170902b28b00b001b86cabdb7fmr1636315plr.53.1689675980221;
        Tue, 18 Jul 2023 03:26:20 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:5662:36e5:ffc6:2e8c])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001ac2be26340sm1471238pld.222.2023.07.18.03.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:26:19 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:26:17 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <20230718102617.GA982837@google.com>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
 <20230717075147.43326-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717075147.43326-4-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 17, 2023 at 09:51:47AM +0200, Miquel Raynal wrote:
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
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/nvmem/core.c | 101 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 48659106a1e2..6c04a9cf6919 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -325,6 +325,43 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>  	return nvmem_bin_attr_get_umode(nvmem);
>  }
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
>  /* default read/write permissions */
>  static struct bin_attribute bin_attr_rw_nvmem = {
>  	.attr	= {
> @@ -346,8 +383,14 @@ static const struct attribute_group nvmem_bin_group = {
>  	.is_bin_visible = nvmem_bin_attr_is_visible,
>  };
>  
> +/* Cell attributes will be dynamically allocated */
> +static struct attribute_group nvmem_cells_group = {
> +	.name		= "cells",
> +};
> +
>  static const struct attribute_group *nvmem_dev_groups[] = {
>  	&nvmem_bin_group,
> +	&nvmem_cells_group,
>  	NULL,
>  };
>  
> @@ -406,6 +449,58 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
>  		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
>  }
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
>  #else /* CONFIG_NVMEM_SYSFS */
>  
>  static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> @@ -1006,6 +1101,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	if (rval)
>  		goto err_remove_cells;
>  
> +#ifdef CONFIG_NVMEM_SYSFS
> +	rval = nvmem_populate_sysfs_cells(nvmem);
> +	if (rval)
> +		goto err_remove_cells;

This breaks nvmem / efuse devices with multiple cells that share the
same name. Something like this in DT:

	efuse: efuse@11f10000 {
		compatible = "mediatek,mt8183-efuse",
			     "mediatek,efuse";
		reg = <0 0x11f10000 0 0x1000>;
		#address-cells = <1>;
		#size-cells = <1>;
		thermal_calibration: calib@180 {
			reg = <0x180 0xc>;
		};

		mipi_tx_calibration: calib@190 {
			reg = <0x190 0xc>;
		};

		svs_calibration: calib@580 {
			reg = <0x580 0x64>;
		};
	};

creates three cells, all named DT, and sysfs will complain:

    sysfs: cannot create duplicate filename '/devices/platform/soc/11f10000.efuse/nvmem1/cells/calib'
    mediatek,efuse: probe of 11f10000.efuse failed with error -17

This causes the MT8183-based Chromebooks to lose display capability,
among other things.

The problem lies in the nvmem DT parsing code, where the cell name is
derived from the node name, without including the address portion.
However I'm not sure we can change that, since it could be considered
ABI?


ChenYu

> +#endif
> +
>  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>  
>  	rval = device_add(&nvmem->dev);
> -- 
> 2.34.1
> 
