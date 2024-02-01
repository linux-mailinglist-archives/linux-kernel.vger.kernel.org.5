Return-Path: <linux-kernel+bounces-47680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E84845124
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7446EB2160F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A681ACD;
	Thu,  1 Feb 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eWsKVNFg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D28005B;
	Thu,  1 Feb 2024 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767481; cv=none; b=Rp1aV9XwY2ezel6VRTQdz+eZQ4S9fHkw9VUTQeDw/QTgmc6Na00XCCXMYIaaPDOFrmQc2xbvOhwaV2yyiIvRQHmypRXmIQYN9mBFAmtX0nRfplibluS54K1QXaBPF8x7V7n+uvG3eDCw78tgEmgFqksvBhxsMgDvvAKRfubfeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767481; c=relaxed/simple;
	bh=B/yad2lA/J92uE3dv3uCDmqxZyOCBHtRlqZrKmlCv3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVYDc2AVjRCEHbZ6hoK4U9mb7y8/ewH5hCD4s4cmsoVJokUZP5X/MWqFk+CRvh/klHa4gSWy2kjQ1XTIntG7W9i2ngNS2EVl+5bP2tkYoe/0xKWf704V2KIJmnI3lkfCBv49eboQm3H9I3znnswzJlj4pMaQyRclVy4cMON/oWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eWsKVNFg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cuubT9ORMRxlSpS/OPGYBxMqwCoFHo6Ow8mUI5UMK3A=; b=eWsKVNFg8RWjqgU1q5XyCTH3Dy
	BpkYH5gu/+oomneoc66Yde7qqT3VmH7+xYmBPyEuTdSNE7VxiqoahuX0gI0kblskwEQ3RaoNtkPW2
	5om4P0IIZL3FEjKT79gDIyq2HF7E3z7d4Q8gwOoV8XGep1IZMBIahiy+9mtIZeIMyRGO6s+DfcXdO
	ej9RYfYhW3bBpQUHmLv+fwsM273a0Ezd/iwCxKVB0eDaC3nD+wKpT4Scb1eZVOosrui1VK7YKLd8g
	aomyLxwkdhpWcdzo13rDJ7VBR1EBxlJTe+JkssHlevvocf9pMavCS+4vfvB0Lin5S4vztkxTMmjWs
	IInsG45w==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVQBj-00000006i4n-144t;
	Thu, 01 Feb 2024 06:04:39 +0000
Message-ID: <09e318f9-ccb6-4c0c-b06d-d433d44d6e25@infradead.org>
Date: Wed, 31 Jan 2024 22:04:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Content-Language: en-US
To: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240131174347.510961-2-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/31/24 09:43, Jens Wiklander wrote:
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> partition provides authenticated and replay protected access, hence
> suitable as a secure storage.
> 
> The initial aim of this patch is to provide a simple RPMB Driver which
> can be accessed by the optee driver to facilitate early RPMB access to
> OP-TEE OS (secure OS) during the boot time.
> 
> A TEE device driver can claim the RPMB interface, for example, via
> class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
> 
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/misc/Kconfig     |   9 ++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/rpmb-core.c | 247 +++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmb.h     | 184 +++++++++++++++++++++++++++++
>  5 files changed, 448 insertions(+)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
> 


> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..891aa5763666 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -104,6 +104,15 @@ config PHANTOM
>  	  If you choose to build module, its name will be phantom. If unsure,
>  	  say N here.
>  
> +config RPMB
> +	tristate "RPMB partition interface"
> +	help
> +	  Unified RPMB unit interface for RPMB capable devices such as eMMC and
> +	  UFS. Provides interface for in kernel security controllers to access

	                              in-kernel

> +	  RPMB unit.
> +
> +	  If unsure, select N.
> +
>  config TIFM_CORE
>  	tristate "TI Flash Media interface support"
>  	depends on PCI


> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> new file mode 100644
> index 000000000000..a3c289051687
> --- /dev/null
> +++ b/drivers/misc/rpmb-core.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> + * Copyright(c) 2021 - 2024 Linaro Ltd.
> + */
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rpmb.h>
> +#include <linux/slab.h>

> +
> +/**
> + * rpmb_route_frames() - route rpmb frames to rpmb device
> + * @rdev:	rpmb device
> + * @req:	rpmb request frames
> + * @req_len:	length of rpmb request frames in bytes
> + * @rsp:	rpmb response frames
> + * @rsp_len:	length of rpmb response frames in bytes
> + *
> + * @return < 0 on failure

Above needs a colon ':' after @return, although using
 * Return:
is preferable IMO.

> + */
> +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> +		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
> +{


> +/**
> + * rpmb_dev_find_device() - return first matching rpmb device
> + * @data: data for the match function
> + * @match: the matching function
> + *
> + * @returns a matching rpmb device or NULL on failure

    * @returns:
or
    * Returns:

> + */
> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> +				      const struct rpmb_dev *start,
> +				      int (*match)(struct device *dev,
> +						   const void *data))
> +{
> +	struct device *dev;
> +	const struct device *start_dev = NULL;
> +
> +	if (start)
> +		start_dev = &start->dev;
> +	dev = class_find_device(&rpmb_class, start_dev, data, match);
> +
> +	return dev ? to_rpmb_dev(dev) : NULL;
> +}
> +
> +/**
> + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
> + * @rdev: the rpmb device to unregister
> + *
> + * @returns < 0 on failure

Ditto.

> + */
> +int rpmb_dev_unregister(struct rpmb_dev *rdev)
> +{
> +	if (!rdev)
> +		return -EINVAL;
> +
> +	device_del(&rdev->dev);
> +
> +	rpmb_dev_put(rdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
> +
> +/**
> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> + * @dev: storage device of the rpmb device
> + * @target: RPMB target/region within the physical device

There is no @target function parameter.

> + * @ops: device specific operations
> + *
> + * While registering the RPMB partition get references to needed resources
> + * with the @ops->get_resources() callback and extracts needed devices
> + * information while needed resources are available.
> + *
> + * @returns a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure

Ditto for Return syntax.

> + */
> +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> +				   const struct rpmb_ops *ops)
> +{
> +	struct rpmb_dev *rdev;
> +	int id;
> +	int ret;
> +
> +	if (!dev || !ops || !ops->get_resources ||
> +	    !ops->put_resources || !ops->route_frames ||
> +	    !ops->set_dev_info)
> +		return ERR_PTR(-EINVAL);
> +
> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&rpmb_mutex);
> +	id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
> +	mutex_unlock(&rpmb_mutex);
> +	if (id < 0) {
> +		ret = id;
> +		goto exit;
> +	}
> +
> +	rdev->ops = ops;
> +	rdev->id = id;
> +
> +	dev_set_name(&rdev->dev, "rpmb%d", id);
> +	rdev->dev.class = &rpmb_class;
> +	rdev->dev.parent = dev;
> +
> +	ret = ops->set_dev_info(dev, rdev);
> +	if (ret)
> +		goto exit;
> +
> +	ret = device_register(&rdev->dev);
> +	if (ret)
> +		goto exit;
> +
> +	ops->get_resources(rdev->dev.parent);
> +
> +	dev_dbg(&rdev->dev, "registered device\n");
> +
> +	return rdev;
> +
> +exit:
> +	if (id >= 0) {
> +		mutex_lock(&rpmb_mutex);
> +		ida_simple_remove(&rpmb_ida, id);
> +		mutex_unlock(&rpmb_mutex);
> +	}
> +	kfree(rdev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_register);


> diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> new file mode 100644
> index 000000000000..45073513264a
> --- /dev/null
> +++ b/include/linux/rpmb.h
> @@ -0,0 +1,184 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (C) 2015-2019 Intel Corp. All rights reserved
> + * Copyright (C) 2021-2022 Linaro Ltd
> + */
> +#ifndef __RPMB_H__
> +#define __RPMB_H__
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +
> +/**
> + * struct rpmb_frame - rpmb frame as defined by specs
> + *
> + * @stuff        : stuff bytes
> + * @key_mac      : The authentication key or the message authentication
> + *                 code (MAC) depending on the request/response type.
> + *                 The MAC will be delivered in the last (or the only)
> + *                 block of data.
> + * @data         : Data to be written or read by signed access.
> + * @nonce        : Random number generated by the host for the requests
> + *                 and copied to the response by the RPMB engine.
> + * @write_counter: Counter value for the total amount of the successful
> + *                 authenticated data write requests made by the host.
> + * @addr         : Address of the data to be programmed to or read
> + *                 from the RPMB. Address is the serial number of
> + *                 the accessed block (half sector 256B).
> + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> + *                 read/programmed.
> + * @result       : Includes information about the status of the write counter
> + *                 (valid, expired) and result of the access made to the RPMB.
> + * @req_resp     : Defines the type of request and response to/from the memory.
> + */
> +struct rpmb_frame {
> +	u8     stuff[196];
> +	u8     key_mac[32];
> +	u8     data[256];
> +	u8     nonce[16];
> +	__be32 write_counter;
> +	__be16 addr;
> +	__be16 block_count;
> +	__be16 result;
> +	__be16 req_resp;
> +} __packed;
> +
> +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
> +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
> +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
> +
> +#define RPMB_REQ2RESP(_OP) ((_OP) << 8)
> +#define RPMB_RESP2REQ(_OP) ((_OP) >> 8)
> +
> +/**
> + * enum rpmb_op_result - rpmb operation results
> + *
> + * @RPMB_ERR_OK      : operation successful
> + * @RPMB_ERR_GENERAL : general failure
> + * @RPMB_ERR_AUTH    : mac doesn't match or ac calculation failure
> + * @RPMB_ERR_COUNTER : counter doesn't match or counter increment failure
> + * @RPMB_ERR_ADDRESS : address out of range or wrong address alignment
> + * @RPMB_ERR_WRITE   : data, counter, or result write failure
> + * @RPMB_ERR_READ    : data, counter, or result read failure
> + * @RPMB_ERR_NO_KEY  : authentication key not yet programmed
> + *
> + * @RPMB_ERR_COUNTER_EXPIRED:  counter expired
> + */
> +enum rpmb_op_result {
> +	RPMB_ERR_OK      = 0x0000,
> +	RPMB_ERR_GENERAL = 0x0001,
> +	RPMB_ERR_AUTH    = 0x0002,
> +	RPMB_ERR_COUNTER = 0x0003,
> +	RPMB_ERR_ADDRESS = 0x0004,
> +	RPMB_ERR_WRITE   = 0x0005,
> +	RPMB_ERR_READ    = 0x0006,
> +	RPMB_ERR_NO_KEY  = 0x0007,
> +
> +	RPMB_ERR_COUNTER_EXPIRED = 0x0080
> +};
> +
> +/**
> + * enum rpmb_type - type of underlaying storage technology

                               underlying

> + *
> + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> + * @RPMB_TYPE_UFS   : UFS (JESD220)
> + * @RPMB_TYPE_NVME  : NVM Express
> + */
> +enum rpmb_type {
> +	RPMB_TYPE_EMMC,
> +	RPMB_TYPE_UFS,
> +	RPMB_TYPE_NVME,
> +};
> +
> +/**
> + * struct rpmb_dev - device which can support RPMB partition
> + *
> + * @dev              : device
> + * @id               : device id;
> + * @ops              : operation exported by rpmb
> + * @dev_id           : unique device identifier read from the hardware
> + * @dev_id_len       : length of unique device identifier
> + * @reliable_wr_count: number of sectors that can be written in one access
> + * @capacity         : capacity of the device in units of 128K
> + */
> +struct rpmb_dev {
> +	struct device dev;
> +	int id;
> +	const struct rpmb_ops *ops;
> +	u8 *dev_id;
> +	size_t dev_id_len;
> +	u16 reliable_wr_count;
> +	u16 capacity;
> +};
> +
> +#define to_rpmb_dev(x) container_of((x), struct rpmb_dev, dev)
> +
> +/**
> + * struct rpmb_ops - RPMB ops to be implemented by underlying block device
> + *
> + * @type          : block device type
> + * @get_resources : gets references to needed resources in rpmb_dev_register()
> + * @put_resources : puts references from resources in rpmb_dev_release()
> + * @route_frames  : routes frames to and from the RPMB device
> + * @get_dev_info  : extracts device info from the RPMB device

       set_dev_info ???

> + */
> +struct rpmb_ops {
> +	enum rpmb_type type;
> +	void (*get_resources)(struct device *dev);
> +	void (*put_resources)(struct device *dev);
> +	int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);
> +	int (*route_frames)(struct device *dev, bool write,
> +			    u8 *req, unsigned int req_len,
> +			    u8 *resp, unsigned int resp_len);
> +};
> +

thanks.
-- 
#Randy

