Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA47AC7DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIXMEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:04:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47A3FE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:04:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40528376459so47571445e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695557076; x=1696161876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kbxdvSag+fMHEAsgBoeHBpA9Y8v3UwP2713wqpTk7w=;
        b=nq0UyNBQyBZ7dygLmwTYegm2Hshc2zfJWc0QX4OgPWF2zouxDADs1j3dNU6UbZ5NR2
         jZz4a02+rvvtgBwhDblCk2Qs09Hy8pjWqN0XpRB4wvBMbOvJFm3lL/xf/fuDz26ARmdC
         8owt01gTTGrR+M8SJ9MLW1jeHwlKmHa+eetsNy2GJXQrTkwIK9Ln7pqRKyhkEDo63L72
         EWyiKRPCH/Pdz05RJ4kiHj3yEMndHVJOePZNM2O3dwmvvzihwafEyKsDnXi0O3yAAcp8
         l5bNt7hiTR+nk0OGUzBdSyOKeG07zRaJ47N85MxEoOnYgGoEgFHUCK8YhEbxV3LIFzUx
         DF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695557076; x=1696161876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kbxdvSag+fMHEAsgBoeHBpA9Y8v3UwP2713wqpTk7w=;
        b=oDZSEpbvacuARX8AOEThiDnLUaGbRkkjM15fBZ0LuxrzgJDFQONPM6/ihNTKYj7AVu
         P+hRdD2Fe0tgBGb9aze0RD+6JtYp8YlwOCmVtkCFDXnV312NR7sM8gMBS6bxi3KzpJ1G
         ekjyoMTgB7QzUvhdHd2kRjDoDbOnIucyMzQr60FvEeNa7erIycfBUYWRTmj/muQeY6f8
         TIs+CrhH2+1gBwYDM1YtCNcLIUV78tLiuevYQsVK+uW3l+Uwwnk2jp3wGFndMHDx+kl5
         fGjSZvK45yYtTsb0o7bgIq5UhNdfhFIyNfS/14fl7Pb22LEzIY9FpOHkZXsqXTuoCPoQ
         /fAg==
X-Gm-Message-State: AOJu0YwOHl0wm8Ctr4n4sQCtjk5qWiZiQSHg353Cgf78KtxUKIVpR8GP
        ZXy8O9bGsG3dAZXDN9dsxQWNbQ==
X-Google-Smtp-Source: AGHT+IFOxfkV6x8akvIQonthsIjUc8LBq8tTfByOIjzPt1UHHoR9uvwX+HhSa5ZiCIcTStrWGt3FgA==
X-Received: by 2002:a05:600c:2252:b0:3fe:ba7:f200 with SMTP id a18-20020a05600c225200b003fe0ba7f200mr3336414wmm.20.1695557076006;
        Sun, 24 Sep 2023 05:04:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id c38-20020a05600c4a2600b00405718cbeadsm767594wmp.1.2023.09.24.05.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 05:04:35 -0700 (PDT)
Message-ID: <6ce74c42-d1d0-d9cb-9d90-68989933d1d4@linaro.org>
Date:   Sun, 24 Sep 2023 14:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
 <20230924113725.164948-3-ayushdevel1325@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230924113725.164948-3-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2023 13:36, Ayush Singh wrote:
> Add the Greybus host driver for BeaglePlay board by BeagleBoard.org.
> 
> Current beagleconnect setup involves running SVC in a user-space
> application (GBridge) and using netlink to communicate with kernel
> space. GBridge itself uses wpanusb kernel driver for communication with
> CC1325, so the greybus messages travel from kernel space (gb_netlink) to
> user-space (GBridge) and then back to kernel space (wpanusb) before
> reaching CC1352.
> 

Thank you for your patch. There is something to discuss/improve.

>  
>  GREYBUS SUBSYSTEM
>  M:	Johan Hovold <johan@kernel.org>
> diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> index 78ba3c3083d5..07e3119e2faa 100644
> --- a/drivers/greybus/Kconfig
> +++ b/drivers/greybus/Kconfig
> @@ -17,6 +17,16 @@ menuconfig GREYBUS
>  
>  if GREYBUS
>  
> +config GREYBUS_BEAGLEPLAY
> +	tristate "Greybus BeaglePlay driver"
> +	depends on TTY
> +	help
> +	  Select this option if you have a BeaglePlay where CC1352
> +		co-processor acts as Greybus SVC.

Fix indentation.

> +
> +	  To compile this code as a module, chose M here: the module
> +	  will be called gb-beagleplay.ko
> +
>  config GREYBUS_ES2
>  	tristate "Greybus ES3 USB host controller"
>  	depends on USB
> diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
> index 9bccdd229aa2..15a84a83788d 100644
> --- a/drivers/greybus/Makefile
> +++ b/drivers/greybus/Makefile
> @@ -18,9 +18,9 @@ obj-$(CONFIG_GREYBUS)		+= greybus.o
>  # needed for trace events
>  ccflags-y += -I$(src)
>  
> +obj-$(CONFIG_GREYBUS_BEAGLEPLAY)	+= gb-beagleplay.o
> +
>  # Greybus Host controller drivers
>  gb-es2-y := es2.o
>  
>  obj-$(CONFIG_GREYBUS_ES2)	+= gb-es2.o
> -
> -

Does not look related to your patch.

> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> new file mode 100644
> index 000000000000..39d87ef3b8fc
> --- /dev/null
> +++ b/drivers/greybus/gb-beagleplay.c
> @@ -0,0 +1,526 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Beagleplay Linux Driver for Greybus
> + *
> + * Copyright (c) 2023 Ayush Singh <ayushdevel1325@gmail.com>
> + * Copyright (c) 2023  BeagleBoard.org Foundation
> + */
> +
> +#include <linux/gfp.h>
> +#include <linux/greybus.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/printk.h>
> +#include <linux/serdev.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/greybus/hd.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/crc-ccitt.h>
> +#include <linux/circ_buf.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +#define RX_HDLC_PAYLOAD 1024
> +#define CRC_LEN 2
> +#define MAX_RX_HDLC (1 + RX_HDLC_PAYLOAD + CRC_LEN)
> +#define TX_CIRC_BUF_SIZE 1024
> +
> +#define ADDRESS_GREYBUS 0x01
> +#define ADDRESS_DBG 0x02
> +#define ADDRESS_CONTROL 0x03
> +
> +#define HDLC_FRAME 0x7E
> +#define HDLC_ESC 0x7D
> +#define HDLC_XOR 0x20
> +
> +#define CONTROL_SVC_START 0x01
> +#define CONTROL_SVC_STOP 0x02
> +
> +/* The maximum number of CPorts supported by Greybus Host Device */
> +#define BEAGLEPLAY_GB_MAX_CPORTS 32
> +
> +/*

Use kerneldoc.

> + * BeaglePlay Greybus driver
> + *
> + * @serdev: Serdev device
> + *
> + * @gb_host_device: greybud host device
> + *
> + * @tx_work: transmit work
> + * @tx_producer_lock: transmit producer lock
> + * @tx_consumer_lock: transmit consumer lock
> + * @tx_circ_buf: transmit circular buffer
> + * @tx_crc: HDCL CRC
> + * @tx_ack_seq: current TX ACK sequence number
> + *
> + * @rx_buffer_len: Rx buffer length
> + * @rx_in_esc: Rx Flag to indicate if ESC
> + * @rx_buffer: Rx buffer

This is absolutely useless comment. We know it is RX buffer because
member is called "rx_buffer".

> + */
> +struct gb_beagleplay {
> +	struct serdev_device *serdev;
> +
> +	struct gb_host_device *gb_host_device;
> +
> +	struct work_struct tx_work;
> +	/* tx_producer_lock: HDLC producer lock */

Do not comment in two places - kerneldoc and in-line. Only one place.

> +	spinlock_t tx_producer_lock;
> +	/* tx_consumer_lock: HDLC consumer lock */
> +	spinlock_t tx_consumer_lock;
> +	struct circ_buf tx_circ_buf;
> +	u16 tx_crc;
> +	u8 tx_ack_seq;
> +
> +	u16 rx_buffer_len;
> +	u8 rx_in_esc;
> +	u8 rx_buffer[MAX_RX_HDLC];
> +};
> +
> +struct hdlc_payload {
> +	u16 length;
> +	void *payload;
> +};
> +

...

> +
> +static int gb_serdev_init(struct gb_beagleplay *bg)
> +{
> +	u32 speed = 115200;
> +	int ret;
> +
> +	serdev_device_set_drvdata(bg->serdev, bg);
> +	serdev_device_set_client_ops(bg->serdev, &gb_beagleplay_ops);
> +	ret = serdev_device_open(bg->serdev);
> +	if (ret) {
> +		return dev_err_probe(&bg->serdev->dev, ret,
> +				     "Unable to Open Serial Device");
> +	}

Please run scripts/checkpatch.pl --strict and fix reported warnings.
Some warnings can be ignored, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> +	speed = serdev_device_set_baudrate(bg->serdev, speed);
> +	serdev_device_set_flow_control(bg->serdev, false);
> +
> +	return 0;
> +}
> +
> +static int gb_beagleplay_probe(struct serdev_device *serdev)
> +{
> +	int ret = 0;
> +	struct gb_beagleplay *bg =
> +		devm_kmalloc(&serdev->dev, sizeof(*bg), GFP_KERNEL);

Don't mix dynamic memory allocation with variable definition. That's not
readable.

> +

There is never blank line between allocation and the check.

> +	if (!bg)
> +		return -ENOMEM;
> +
> +	bg->serdev = serdev;
> +	ret = gb_serdev_init(bg);
> +	if (ret)
> +		return ret;
> +
> +	ret = hdlc_init(bg);
> +	if (ret)
> +		goto free_serdev;
> +
> +	ret = gb_greybus_init(bg);
> +	if (ret)
> +		goto free_hdlc;
> +
> +	gb_beagleplay_start_svc(bg);
> +
> +	return 0;
> +
> +free_hdlc:
> +	hdlc_deinit(bg);
> +free_serdev:
> +	gb_serdev_deinit(bg);
> +	return ret;
> +}
> +
> +static void gb_beagleplay_remove(struct serdev_device *serdev)
> +{
> +	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
> +
> +	gb_greybus_deinit(bg);
> +	gb_beagleplay_stop_svc(bg);
> +	hdlc_deinit(bg);
> +	gb_serdev_deinit(bg);
> +}
> +
> +static const struct of_device_id gb_beagleplay_of_match[] = {
> +	{
> +		.compatible = "beagle,play-cc1352",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gb_beagleplay_of_match);
> +
> +static struct serdev_device_driver gb_beagleplay_driver = {
> +	.probe = gb_beagleplay_probe,
> +	.remove = gb_beagleplay_remove,
> +	.driver = {
> +	      .name = "gb_beagleplay",
> +	      .of_match_table = gb_beagleplay_of_match,

This is still wrongly aligned. Spaces after tab. Are you sure checkpatch
does not complain bout it?

> +	    },

Align with .driver, so only one tab.

> +};
> +
> +module_serdev_device_driver(gb_beagleplay_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ayush Singh <ayushdevel1325@gmail.com>");
> +MODULE_DESCRIPTION("A Greybus driver for BeaglePlay");

Best regards,
Krzysztof

