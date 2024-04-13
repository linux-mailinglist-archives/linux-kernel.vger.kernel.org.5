Return-Path: <linux-kernel+bounces-143679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CB58A3C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EB31F21BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BB101CA;
	Sat, 13 Apr 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ed1H/cBA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3B1F94C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004557; cv=none; b=ON6o1bdBrJ8194q+8zIrHUrhUIS/GyDKtyV0klMNH3LkBKomfthIvqU2fQgOhBohkhraDqplQUHWsIxAMnFILejHMwvesQb1ngFDDv+dY/56Bfa0EAZZkNUyYXtuewmLPnnlMWukVoMRAu2rz49AiNFxtF1RBVOEV8uVvFUGCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004557; c=relaxed/simple;
	bh=IRTejWZ/HR8M+OVFjm7w8gIW3e87BmodQ6p+YOaG+EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcK9XVsxjWX/jGGevSVnKpUnxtxpomehC40k03w0A/Ugh0NK49yRKERptvPsNZIssfA5OyqnEaijWXc24tnFc6O4zfP16SPh5Ggvbn7Ki3UPBRjMak2x8gvqdBGj8AdoXB7E4dZNyNnsnfJ4X7CKMWAXNBc1qHnW8d96Gj3pXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ed1H/cBA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41551500a7eso10646625e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713004554; x=1713609354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhsiqZjoN/yLO75o8oZFG2XvUlu4IpaZo5+uNtvirTE=;
        b=Ed1H/cBAuOIjnsHFVxfV3sUXPkfVxnzpwczbuQpatNiyrsghQRnIp5a4h7hctudlez
         VuDiEPTXjj7Ok0ivXwR84tm9NHqQb+ckehfnnEHtcMIQwYdXdUPv2k0W4BGDOeYLYac4
         qcjh8U1RV/2kHzEkignpkHreHm5h8KqhlW9GMkcS9MA9DLYmqOCYY3Y5ox9TUjacuQGp
         MRXQ+kWH+haksrQigwZEE4T00Toj2Ti0S6zLJUNATRi9UisY7JWT8L69GGBPHU49aDJh
         Jn5a/b5/rIZOBXGT0ckX0HhXyYQylh9omuks7ntKRjJRx/Dee5l+rD6kT7IYWCKz72s9
         6ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713004554; x=1713609354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhsiqZjoN/yLO75o8oZFG2XvUlu4IpaZo5+uNtvirTE=;
        b=JgHUhBDz+lHGW75QatfT2Hz5GQbGC2bTlzywCHMtK8nkyBr7NzSQI1Eg/5nNCCr8sL
         KJ1hfcmaRGIq1jrL/jTxlQTLv18xMMdjU6i8EeTqCL8XYzd4a9u4cHHdtI8QPlrW9fqT
         32QpcJfMaflTZP4aDrPxBmPVxd1QcBL8Di6hx5sq1gYwSY5DdHh9eKOfy0qGKTp5kzaG
         PHS9zg8RJXXPBYC2r79qc3B+g1eXVEZVb89sgZHZRTvURPkHTw/6UTOn08c+cfJUiWRe
         uD6tsWJNXbVFkekPTEAXYF8LTe+U0ZTJRcv0aNnAjYHglOFgbgj1d5vY5sJfXb4/JFQG
         GMPg==
X-Gm-Message-State: AOJu0YwuqSwf3/vJhVOl7uJfyZMGqBgE869lix+XfIUuh3UNa/MNRA1p
	/k2kIk3R3r24NtSz6Q7AbX/QsaD0WndMKU+TfpIhCkJ6BEyGJkZ7DXd2FL1oGqmAzRVvW5Gc/ra
	k
X-Google-Smtp-Source: AGHT+IFN/SdmGC+Gg9x8E4Wh8JpXKOpJ00QeWMnMBKfTXwCoFCIqPfmMOlKXPJcwPQz2JXSBCakbaA==
X-Received: by 2002:a05:600c:4e91:b0:418:1083:d2a0 with SMTP id f17-20020a05600c4e9100b004181083d2a0mr1998162wmq.21.1713004553153;
        Sat, 13 Apr 2024 03:35:53 -0700 (PDT)
Received: from [172.20.10.4] (82-132-212-30.dab.02.net. [82.132.212.30])
        by smtp.googlemail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm11612645wmn.45.2024.04.13.03.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 03:35:52 -0700 (PDT)
Message-ID: <406eb283-6ac0-4917-9dbf-e45d033bf3de@linaro.org>
Date: Sat, 13 Apr 2024 11:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: add sysfs cell write support
To: Marco Felsch <m.felsch@pengutronix.de>, miquel.raynal@bootlin.com,
 michael@walle.cc
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20240223154129.1902905-1-m.felsch@pengutronix.de>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240223154129.1902905-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Marco  for the work,

On 23/02/2024 15:41, Marco Felsch wrote:
> Add the sysfs cell write support to make it possible to write to exposed
> cells from sysfs as well e.g. for device provisioning. The write support

Which device are you testing this on?

AFAIU, Normally all the device provisioning happens early stages at 
production line, not after OS is up and running. I might be wrong.

Can you provide more details on what type of device provisioning that 
you are referring to.

Write support should not be enabled by default, this has to be an 
explicit Kconfig with a big WARNING that it could potentially corrupt 
the nvmem by rouge writes.

I would also like this to be an optional feature from providers side 
too, as not all nvmem providers want to have device provisioning support 
from Linux side.


> is limited to EEPROM based nvmem devices and to nvmem-cells which don't
> require post-processing.

> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/nvmem/core.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 980123fb4dde..b1f86cb431ef 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -336,6 +336,40 @@ static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
>   	return read_len;
>   }
>   
> +static ssize_t nvmem_cell_attr_write(struct file *filp, struct kobject *kobj,
> +				     struct bin_attribute *attr, char *buf,
> +				     loff_t pos, size_t count)
> +{
> +	struct nvmem_cell_entry *entry;
> +	struct nvmem_cell *cell;
> +	int ret;
> +
> +	entry = attr->private;
> +
> +	if (!entry->nvmem->reg_write)

nvmem->read_only ?

> +		return -EPERM;
> +
> +	if (pos >= entry->bytes)
> +		return -EFBIG;
> +
> +	if (pos + count > entry->bytes)
> +		count = entry->bytes - pos;
> +
> +	cell = nvmem_create_cell(entry, entry->name, 0);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	if (!cell)
> +		return -EINVAL;
> +
> +	ret = nvmem_cell_write(cell, buf, count);
> +
> +	kfree_const(cell->id);
> +	kfree(cell);
> +
> +	return ret;
> +}
> +
>   /* default read/write permissions */
>   static struct bin_attribute bin_attr_rw_nvmem = {
>   	.attr	= {
> @@ -458,13 +492,20 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
>   
>   	/* Initialize each attribute to take the name and size of the cell */
>   	list_for_each_entry(entry, &nvmem->cells, node) {
> +		umode_t mode = nvmem_bin_attr_get_umode(nvmem);
> +
> +		/* Limit cell-write support to EEPROMs at the moment */
> +		if (entry->read_post_process || nvmem->type != NVMEM_TYPE_EEPROM)
> +			mode &= ~0222;
> +
>   		sysfs_bin_attr_init(&attrs[i]);
>   		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
>   						    "%s@%x", entry->name,
>   						    entry->offset);
> -		attrs[i].attr.mode = 0444;
> +		attrs[i].attr.mode = mode;
>   		attrs[i].size = entry->bytes;
>   		attrs[i].read = &nvmem_cell_attr_read;
can we not make this conditional based on read_only flag?

> +		attrs[i].write = &nvmem_cell_attr_write;
>   		attrs[i].private = entry;
>   		if (!attrs[i].attr.name) {
>   			ret = -ENOMEM;

thanks,
Srini

