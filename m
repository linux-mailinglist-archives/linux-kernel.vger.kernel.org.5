Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9393A7AC80C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIXMco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:32:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE7B101;
        Sun, 24 Sep 2023 05:32:36 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3add37de892so2514725b6e.1;
        Sun, 24 Sep 2023 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695558756; x=1696163556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dANrrk5p+EjdkURDN78idqWaQmsYPz+72ck1VOrsJsA=;
        b=iXhfaDG+Id8Ws9rPH653xdDDzi7WQL4bKRZ8M0z0JyMS73pzDEoW9+f3+/3dnrMfP8
         RzSc1u4aSDZFubq/V6eZXL3sRCLB2urewnyq6VVGBghwJw0bQexRfVCZm/bRiWxbIbS2
         5yPBh5DG5RkEG0DLttRR7yDMSWh9J40rmn0wlFxJGfXkQz7V0YUNoaoY9zm3KCzIXEL6
         4qfOPT+RagBth1fB+H6ilwKimA0CtLwR8E9kl9bMr8Ry+sDpW4wWa0CrXhBLbkztu8u1
         yV2NhO0LKZ/cpb3/MAMZvysXnQUuFalxnmGvAqYPWzfNKwqtwNkEZ23i1Q87eJ3IRUm+
         dKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695558756; x=1696163556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dANrrk5p+EjdkURDN78idqWaQmsYPz+72ck1VOrsJsA=;
        b=ARCxpeymCxyFmQ2CKSYwoywzUDYVgua08Oq8fSvaRNgMuPdndLSwj0NHJjxjvNl8KV
         wj+TGB7Uh0ESFauK2tIPKRUMAGaqcWvmnOZFNFudTXJHJo1kgCOJHOabrdRkROdgW3x6
         760zzbjmNfhLtxNEltB9aOm7CBhdcafbjhxV9ubCPHOonIV+w42jOBR4xDFWw/AU3bKg
         UMnVi+eJa2kZwVgdX5tEJdVMDDtW7ZKl5Vrmkfhz+iQcWwMGoKFTITcMwmBGwvmbef/4
         ABZAQAZQePV+ET7YTnGgt21mtCofztJsNKHFbS8hK0B19yVKpZp9zgpo6NI7T0zhuZoT
         T5gQ==
X-Gm-Message-State: AOJu0Yx5swcCALlDILELVv+6tJHUbwvi3dUxZkULsGPCqIDEqylf35Hg
        MS1SD6ImX4GiNie8Eko47Zc=
X-Google-Smtp-Source: AGHT+IEPXUTQMEpFxBCRYjBNMbNR1c9FRtYTuWCQlBZBD5ZRM5pB0nr+aNIBOeS6b305WhBnb7Pi2g==
X-Received: by 2002:a05:6808:488:b0:3a8:512a:41b8 with SMTP id z8-20020a056808048800b003a8512a41b8mr4494389oid.21.1695558756052;
        Sun, 24 Sep 2023 05:32:36 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79249000000b00690c9fda0fesm6167584pfp.169.2023.09.24.05.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 05:32:35 -0700 (PDT)
Message-ID: <62f5671d-738b-997c-798f-7e6cc00f7ef9@gmail.com>
Date:   Sun, 24 Sep 2023 18:02:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
 <20230924113725.164948-3-ayushdevel1325@gmail.com>
 <6ce74c42-d1d0-d9cb-9d90-68989933d1d4@linaro.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <6ce74c42-d1d0-d9cb-9d90-68989933d1d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +
>> +	  To compile this code as a module, chose M here: the module
>> +	  will be called gb-beagleplay.ko
>> +
>>   config GREYBUS_ES2
>>   	tristate "Greybus ES3 USB host controller"
>>   	depends on USB
>> diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
>> index 9bccdd229aa2..15a84a83788d 100644
>> --- a/drivers/greybus/Makefile
>> +++ b/drivers/greybus/Makefile
>> @@ -18,9 +18,9 @@ obj-$(CONFIG_GREYBUS)		+= greybus.o
>>   # needed for trace events
>>   ccflags-y += -I$(src)
>>   
>> +obj-$(CONFIG_GREYBUS_BEAGLEPLAY)	+= gb-beagleplay.o
>> +
>>   # Greybus Host controller drivers
>>   gb-es2-y := es2.o
>>   
>>   obj-$(CONFIG_GREYBUS_ES2)	+= gb-es2.o
>> -
>> -
> Does not look related to your patch.
You are referring to the removal of last 2 newlines, right? In that 
case, I will fix it.
>
>> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
>> new file mode 100644
>> index 000000000000..39d87ef3b8fc
>> --- /dev/null
>> +++ b/drivers/greybus/gb-beagleplay.c
>> @@ -0,0 +1,526 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Beagleplay Linux Driver for Greybus
>> + *
>> + * Copyright (c) 2023 Ayush Singh <ayushdevel1325@gmail.com>
>> + * Copyright (c) 2023  BeagleBoard.org Foundation
>> + */
>> +
>> +#include <linux/gfp.h>
>> +#include <linux/greybus.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/printk.h>
>> +#include <linux/serdev.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_driver.h>
>> +#include <linux/greybus/hd.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/crc-ccitt.h>
>> +#include <linux/circ_buf.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define RX_HDLC_PAYLOAD 1024
>> +#define CRC_LEN 2
>> +#define MAX_RX_HDLC (1 + RX_HDLC_PAYLOAD + CRC_LEN)
>> +#define TX_CIRC_BUF_SIZE 1024
>> +
>> +#define ADDRESS_GREYBUS 0x01
>> +#define ADDRESS_DBG 0x02
>> +#define ADDRESS_CONTROL 0x03
>> +
>> +#define HDLC_FRAME 0x7E
>> +#define HDLC_ESC 0x7D
>> +#define HDLC_XOR 0x20
>> +
>> +#define CONTROL_SVC_START 0x01
>> +#define CONTROL_SVC_STOP 0x02
>> +
>> +/* The maximum number of CPorts supported by Greybus Host Device */
>> +#define BEAGLEPLAY_GB_MAX_CPORTS 32
>> +
>> +/*
> Use kerneldoc.
Thanks, will do that.
>> + */
>> +struct gb_beagleplay {
>> +	struct serdev_device *serdev;
>> +
>> +	struct gb_host_device *gb_host_device;
>> +
>> +	struct work_struct tx_work;
>> +	/* tx_producer_lock: HDLC producer lock */
> Do not comment in two places - kerneldoc and in-line. Only one place.
I was getting some errors in checkpatch without those. I guess they will 
go away if I am using kerneldoc?
>
>> +	spinlock_t tx_producer_lock;
>> +	/* tx_consumer_lock: HDLC consumer lock */
>> +	spinlock_t tx_consumer_lock;
>> +	struct circ_buf tx_circ_buf;
>> +	u16 tx_crc;
>> +	u8 tx_ack_seq;
>> +
>> +	u16 rx_buffer_len;
>> +	u8 rx_in_esc;
>> +	u8 rx_buffer[MAX_RX_HDLC];
>> +};
>> +
>> +struct hdlc_payload {
>> +	u16 length;
>> +	void *payload;
>> +};
>> +
> ...
>
>> +
>> +static int gb_serdev_init(struct gb_beagleplay *bg)
>> +{
>> +	u32 speed = 115200;
>> +	int ret;
>> +
>> +	serdev_device_set_drvdata(bg->serdev, bg);
>> +	serdev_device_set_client_ops(bg->serdev, &gb_beagleplay_ops);
>> +	ret = serdev_device_open(bg->serdev);
>> +	if (ret) {
>> +		return dev_err_probe(&bg->serdev->dev, ret,
>> +				     "Unable to Open Serial Device");
>> +	}
> Please run scripts/checkpatch.pl --strict and fix reported warnings.
> Some warnings can be ignored, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
So I do not actually get any errors here in checkpatch. I am running the 
follwing:

`scripts/checkpatch.pl --codespell --strict patch/*`

I only get a warning in coverletter due to that path of DT bindings 
being more than 75 character long and ` Lines should not end with a '('`.

>> +	if (!bg)
>> +		return -ENOMEM;
>> +
>> +	bg->serdev = serdev;
>> +	ret = gb_serdev_init(bg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = hdlc_init(bg);
>> +	if (ret)
>> +		goto free_serdev;
>> +
>> +	ret = gb_greybus_init(bg);
>> +	if (ret)
>> +		goto free_hdlc;
>> +
>> +	gb_beagleplay_start_svc(bg);
>> +
>> +	return 0;
>> +
>> +free_hdlc:
>> +	hdlc_deinit(bg);
>> +free_serdev:
>> +	gb_serdev_deinit(bg);
>> +	return ret;
>> +}
>> +
>> +static void gb_beagleplay_remove(struct serdev_device *serdev)
>> +{
>> +	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
>> +
>> +	gb_greybus_deinit(bg);
>> +	gb_beagleplay_stop_svc(bg);
>> +	hdlc_deinit(bg);
>> +	gb_serdev_deinit(bg);
>> +}
>> +
>> +static const struct of_device_id gb_beagleplay_of_match[] = {
>> +	{
>> +		.compatible = "beagle,play-cc1352",
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, gb_beagleplay_of_match);
>> +
>> +static struct serdev_device_driver gb_beagleplay_driver = {
>> +	.probe = gb_beagleplay_probe,
>> +	.remove = gb_beagleplay_remove,
>> +	.driver = {
>> +	      .name = "gb_beagleplay",
>> +	      .of_match_table = gb_beagleplay_of_match,
> This is still wrongly aligned. Spaces after tab. Are you sure checkpatch
> does not complain bout it?

Again, it doesn't seem to for me. Am I missing some environment 
variables or options? Or maybe something wrong with my editor config 
(neovim)?


Yours Sincerely

Ayush Singh

