Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39007898AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHZSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjHZS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:29:58 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E63DE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:29:56 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Zy2iqZD4SDlJeZy2iq4uVv; Sat, 26 Aug 2023 20:29:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693074594;
        bh=RjPClBuIQRKMUfUSALQ4hUOgO+gv3HMIBglb3IFBbrg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mIeukVNvFU9WVtm+E106zutSEC0fVbdI/i0uDfT2/deLfV6d8HIb+Yd1cyT9d4e0O
         d6YDqZc+tQFMDWv8c+TDpT7j+D+EBd9h0AQI528gXfCpiOtDUTA7kGl9U2IZo0OiF4
         xPOp1D4mMSTnNMRHJyAn3ID3p5rG2NMSoVhSDNesDL9RAZwrT3xF4K0fj1C56ZZPHF
         5ZCpwKU/ujdEZkGeh15XhlEIN/r9VIugpPM3RyuqW8XPiqQOBveENDnEtO1TKGfceH
         F0oDl+ai//OjAHSDq0TkkAf2pAtMun6HjkV0MWPgDOVTo7lBliM8AuHK4/1wtu2pQm
         97HPP+nHL3GyA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Aug 2023 20:29:54 +0200
X-ME-IP: 86.243.2.178
Message-ID: <50683aac-b186-c6ae-de1f-5b8e4806913c@wanadoo.fr>
Date:   Sat, 26 Aug 2023 20:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 06/12] HID: cp2112: Remove dead code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <20230703185222.50554-7-andriy.shevchenko@linux.intel.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230703185222.50554-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/07/2023 à 20:52, Andy Shevchenko a écrit :
> Remove cp2112_allocate_irq() and counterparts that seems to be
> a dead code from day 1. In case somebody needs it, it can be
> retrieved from Git index.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

for the records, just in case it still makesense to keep this code:

	https://lore.kernel.org/all/CAO-hwJJfncQ3jgtS=HO0atbzrTNOT_rzU66oG2yRTWTSY-L8KA@mail.gmail.com/

CJ

> ---
>   drivers/hid/hid-cp2112.c | 54 ----------------------------------------
>   1 file changed, 54 deletions(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 15b626359281..45cd0d2fd3fd 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -17,8 +17,6 @@
>    */
>   
>   #include <linux/bitops.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/gpio/machine.h>
>   #include <linux/gpio/driver.h>
>   #include <linux/hid.h>
>   #include <linux/hidraw.h>
> @@ -168,7 +166,6 @@ struct cp2112_device {
>   	u8 *in_out_buffer;
>   	struct mutex lock;
>   
> -	struct gpio_desc *desc[8];
>   	bool gpio_poll;
>   	struct delayed_work gpio_poll_worker;
>   	unsigned long irq_mask;
> @@ -1181,51 +1178,6 @@ static int cp2112_gpio_irq_type(struct irq_data *d, unsigned int type)
>   	return 0;
>   }
>   
> -static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
> -					      int pin)
> -{
> -	int ret;
> -
> -	if (dev->desc[pin])
> -		return -EINVAL;
> -
> -	dev->desc[pin] = gpiochip_request_own_desc(&dev->gc, pin,
> -						   "HID/I2C:Event",
> -						   GPIO_ACTIVE_HIGH,
> -						   GPIOD_IN);
> -	if (IS_ERR(dev->desc[pin])) {
> -		dev_err(dev->gc.parent, "Failed to request GPIO\n");
> -		return PTR_ERR(dev->desc[pin]);
> -	}
> -
> -	ret = cp2112_gpio_direction_input(&dev->gc, pin);
> -	if (ret < 0) {
> -		dev_err(dev->gc.parent, "Failed to set GPIO to input dir\n");
> -		goto err_desc;
> -	}
> -
> -	ret = gpiochip_lock_as_irq(&dev->gc, pin);
> -	if (ret) {
> -		dev_err(dev->gc.parent, "Failed to lock GPIO as interrupt\n");
> -		goto err_desc;
> -	}
> -
> -	ret = gpiod_to_irq(dev->desc[pin]);
> -	if (ret < 0) {
> -		dev_err(dev->gc.parent, "Failed to translate GPIO to IRQ\n");
> -		goto err_lock;
> -	}
> -
> -	return ret;
> -
> -err_lock:
> -	gpiochip_unlock_as_irq(&dev->gc, pin);
> -err_desc:
> -	gpiochip_free_own_desc(dev->desc[pin]);
> -	dev->desc[pin] = NULL;
> -	return ret;
> -}
> -
>   static const struct irq_chip cp2112_gpio_irqchip = {
>   	.name = "cp2112-gpio",
>   	.irq_startup = cp2112_gpio_irq_startup,
> @@ -1390,7 +1342,6 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   static void cp2112_remove(struct hid_device *hdev)
>   {
>   	struct cp2112_device *dev = hid_get_drvdata(hdev);
> -	int i;
>   
>   	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
>   	i2c_del_adapter(&dev->adap);
> @@ -1400,11 +1351,6 @@ static void cp2112_remove(struct hid_device *hdev)
>   		cancel_delayed_work_sync(&dev->gpio_poll_worker);
>   	}
>   
> -	for (i = 0; i < ARRAY_SIZE(dev->desc); i++) {
> -		gpiochip_unlock_as_irq(&dev->gc, i);
> -		gpiochip_free_own_desc(dev->desc[i]);
> -	}
> -
>   	gpiochip_remove(&dev->gc);
>   	/* i2c_del_adapter has finished removing all i2c devices from our
>   	 * adapter. Well behaved devices should no longer call our cp2112_xfer

