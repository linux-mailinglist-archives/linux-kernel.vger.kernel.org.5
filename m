Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84DD80A1F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573538AbjLHLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbjLHLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:15:27 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC919A9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:15:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1ec87a7631so171958866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702034126; x=1702638926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIIS9v6G6GekW2v2sVwpLES4TnbQZcd8SpKnIKotzc4=;
        b=P1L54kRNqOQK03mtxUcb5/og3FcAO7bJ1THI+ATGLua4JEytZz0hnxntGLzmahwPoR
         xBzCMDAkmNNXAiOijSOsnpdeGJDqmuFg7OqzljJfDqBQkUVbgkuz7iW8M8ns/45O1mVc
         FJdA7e+7UJekM9iNMljp/5/z5VC+Rr4nCkWLNTcl1itq+aP4F1RbwBoPY6Wna3RXWG8t
         yepgG9hHqXFMQTNLzRybx5/ve5s64KhKc8uWtjU+3nqP2bS44GDO76lMRfFpCHqefgo4
         BeqWpgHEXQXm6ProjYmu/L0v2YeJhgv4Ufjo//lhzR6VRTDQaXqyTnLK82e1I76knijz
         6HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034126; x=1702638926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIIS9v6G6GekW2v2sVwpLES4TnbQZcd8SpKnIKotzc4=;
        b=Mh7EYzU0VSaBe8VUle1587O67VOWUMDWb5/WdSoXWWyUvJ37YfkGRr6kosL8r1XY6q
         jwKew2ep4HO+5sxinrugSAPT0v2R83/vFCHCxXubVaaoTZzNVF1CsS8XQyu4mfMsdOJ1
         hYpaLURIgTGWTFFN6mi6YpRvaSHj6SpuDI2MOlQhrZBgZGh5kh/B+wzIIN8jd03jPPge
         GIsYJTtOqJBoWZX6tuGROuRVEDq3ExbC7w6lVTyn3ICNQNE0JjdTXzJ493Yv96DZjnrs
         /BN9QlR5tu6kUJqdyb3LWpGL/SsMzR21cbK2rlXDDP1UO+8fOsPY943DXWBvvCLCD0MI
         UpOw==
X-Gm-Message-State: AOJu0Yxe15KqnCvRfQNBYLeAzZprGMfD7+/rA8AsIQrfPblpJwfLmr4W
        jBVk+MSEbCPRS2Apmu/01/WOFg==
X-Google-Smtp-Source: AGHT+IHAvE+6FUlFjwj4pdUdJXx3hE2Ih4kolJ61x+aoZuvCFV1vfstdwtvjJBxr7rFg4mzmBWQ8gQ==
X-Received: by 2002:a17:906:51ca:b0:a1c:9c1a:3d36 with SMTP id v10-20020a17090651ca00b00a1c9c1a3d36mr2114370ejk.59.1702034126469;
        Fri, 08 Dec 2023 03:15:26 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id kt17-20020a1709079d1100b00a015eac52dcsm878356ejc.108.2023.12.08.03.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 03:15:25 -0800 (PST)
Message-ID: <29d2f463-90c2-4c96-8828-96806679db8e@linaro.org>
Date:   Fri, 8 Dec 2023 11:15:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvmem: brcm_nvram: store a copy of NVRAM content
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
References: <20231102062848.23965-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231102062848.23965-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the patch,

On 02/11/2023 06:28, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This driver uses MMIO access for reading NVRAM from a flash device.
> Underneath there is a flash controller that reads data and provides
> mapping window.
> 
> Using MMIO interface affects controller configuration and may break real
> controller driver. It was reported by multiple users of devices with
> NVRAM stored on NAND.
> 
> Modify driver to read & cache NVRAM content during init and use that
> copy to provide NVMEM data when requested. On NAND flashes due to their
> alignment NVRAM partitions can be quite big (1 MiB and more) while
> actual NVRAM content stays quite small (usually 16 to 32 KiB). To avoid
> allocating so much memory check for actual data length.
> 
> Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
> Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM")

Any reason not to add
Cc: <Stable@vger.kernel.org>
?

--srini
> Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> V2: Minialize amount of allocated memory (check for actual data length)
> V3: Document missed fields in struct brcm_nvram
> 
>   drivers/nvmem/brcm_nvram.c | 134 ++++++++++++++++++++++++++-----------
>   1 file changed, 94 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 9737104f3b76..5cdf339cfbec 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -17,9 +17,23 @@
>   
>   #define NVRAM_MAGIC			"FLSH"
>   
> +/**
> + * struct brcm_nvram - driver state internal struct
> + *
> + * @dev:		NVMEM device pointer
> + * @nvmem_size:		Size of the whole space available for NVRAM
> + * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
> + * @data_len:		NVRAM data size
> + * @padding_byte:	Padding value used to fill remaining space
> + * @cells:		Array of discovered NVMEM cells
> + * @ncells:		Number of elements in cells
> + */
>   struct brcm_nvram {
>   	struct device *dev;
> -	void __iomem *base;
> +	size_t nvmem_size;
> +	uint8_t *data;
> +	size_t data_len;
> +	uint8_t padding_byte;
>   	struct nvmem_cell_info *cells;
>   	int ncells;
>   };
> @@ -36,10 +50,47 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
>   			   size_t bytes)
>   {
>   	struct brcm_nvram *priv = context;
> -	u8 *dst = val;
> +	size_t to_copy;
> +
> +	if (offset + bytes > priv->data_len)
> +		to_copy = max_t(ssize_t, (ssize_t)priv->data_len - offset, 0);
> +	else
> +		to_copy = bytes;
> +
> +	memcpy(val, priv->data + offset, to_copy);
> +
> +	memset((uint8_t *)val + to_copy, priv->padding_byte, bytes - to_copy);
> +
> +	return 0;
> +}
> +
> +static int brcm_nvram_copy_data(struct brcm_nvram *priv, struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->nvmem_size = resource_size(res);
> +
> +	priv->padding_byte = readb(base + priv->nvmem_size - 1);
> +	for (priv->data_len = priv->nvmem_size;
> +	     priv->data_len;
> +	     priv->data_len--) {
> +		if (readb(base + priv->data_len - 1) != priv->padding_byte)
> +			break;
> +	}
> +	WARN(priv->data_len > SZ_128K, "Unexpected (big) NVRAM size: %zu B\n", priv->data_len);
> +
> +	priv->data = devm_kzalloc(priv->dev, priv->data_len, GFP_KERNEL);
> +	if (!priv->data)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(priv->data, base, priv->data_len);
>   
> -	while (bytes--)
> -		*dst++ = readb(priv->base + offset++);
> +	bcm47xx_nvram_init_from_iomem(base, priv->data_len);
>   
>   	return 0;
>   }
> @@ -67,8 +118,13 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
>   				size_t len)
>   {
>   	struct device *dev = priv->dev;
> -	char *var, *value, *eq;
> +	char *var, *value;
> +	uint8_t tmp;
>   	int idx;
> +	int err = 0;
> +
> +	tmp = priv->data[len - 1];
> +	priv->data[len - 1] = '\0';
>   
>   	priv->ncells = 0;
>   	for (var = data + sizeof(struct brcm_nvram_header);
> @@ -78,67 +134,68 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
>   	}
>   
>   	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
> -	if (!priv->cells)
> -		return -ENOMEM;
> +	if (!priv->cells) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>   
>   	for (var = data + sizeof(struct brcm_nvram_header), idx = 0;
>   	     var < (char *)data + len && *var;
>   	     var = value + strlen(value) + 1, idx++) {
> +		char *eq, *name;
> +
>   		eq = strchr(var, '=');
>   		if (!eq)
>   			break;
>   		*eq = '\0';
> +		name = devm_kstrdup(dev, var, GFP_KERNEL);
> +		*eq = '=';
> +		if (!name) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
>   		value = eq + 1;
>   
> -		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
> -		if (!priv->cells[idx].name)
> -			return -ENOMEM;
> +		priv->cells[idx].name = name;
>   		priv->cells[idx].offset = value - (char *)data;
>   		priv->cells[idx].bytes = strlen(value);
>   		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
> -		if (!strcmp(var, "et0macaddr") ||
> -		    !strcmp(var, "et1macaddr") ||
> -		    !strcmp(var, "et2macaddr")) {
> +		if (!strcmp(name, "et0macaddr") ||
> +		    !strcmp(name, "et1macaddr") ||
> +		    !strcmp(name, "et2macaddr")) {
>   			priv->cells[idx].raw_len = strlen(value);
>   			priv->cells[idx].bytes = ETH_ALEN;
>   			priv->cells[idx].read_post_process = brcm_nvram_read_post_process_macaddr;
>   		}
>   	}
>   
> -	return 0;
> +out:
> +	priv->data[len - 1] = tmp;
> +	return err;
>   }
>   
>   static int brcm_nvram_parse(struct brcm_nvram *priv)
>   {
> +	struct brcm_nvram_header *header = (struct brcm_nvram_header *)priv->data;
>   	struct device *dev = priv->dev;
> -	struct brcm_nvram_header header;
> -	uint8_t *data;
>   	size_t len;
>   	int err;
>   
> -	memcpy_fromio(&header, priv->base, sizeof(header));
> -
> -	if (memcmp(header.magic, NVRAM_MAGIC, 4)) {
> +	if (memcmp(header->magic, NVRAM_MAGIC, 4)) {
>   		dev_err(dev, "Invalid NVRAM magic\n");
>   		return -EINVAL;
>   	}
>   
> -	len = le32_to_cpu(header.len);
> -
> -	data = kzalloc(len, GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	memcpy_fromio(data, priv->base, len);
> -	data[len - 1] = '\0';
> -
> -	err = brcm_nvram_add_cells(priv, data, len);
> -	if (err) {
> -		dev_err(dev, "Failed to add cells: %d\n", err);
> -		return err;
> +	len = le32_to_cpu(header->len);
> +	if (len > priv->nvmem_size) {
> +		dev_err(dev, "NVRAM length (%zd) exceeds mapped size (%zd)\n", len,
> +			priv->nvmem_size);
> +		return -EINVAL;
>   	}
>   
> -	kfree(data);
> +	err = brcm_nvram_add_cells(priv, priv->data, len);
> +	if (err)
> +		dev_err(dev, "Failed to add cells: %d\n", err);
>   
>   	return 0;
>   }
> @@ -150,7 +207,6 @@ static int brcm_nvram_probe(struct platform_device *pdev)
>   		.reg_read = brcm_nvram_read,
>   	};
>   	struct device *dev = &pdev->dev;
> -	struct resource *res;
>   	struct brcm_nvram *priv;
>   	int err;
>   
> @@ -159,21 +215,19 @@ static int brcm_nvram_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	priv->dev = dev;
>   
> -	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -	if (IS_ERR(priv->base))
> -		return PTR_ERR(priv->base);
> +	err = brcm_nvram_copy_data(priv, pdev);
> +	if (err)
> +		return err;
>   
>   	err = brcm_nvram_parse(priv);
>   	if (err)
>   		return err;
>   
> -	bcm47xx_nvram_init_from_iomem(priv->base, resource_size(res));
> -
>   	config.dev = dev;
>   	config.cells = priv->cells;
>   	config.ncells = priv->ncells;
>   	config.priv = priv;
> -	config.size = resource_size(res);
> +	config.size = priv->nvmem_size;
>   
>   	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
>   }
