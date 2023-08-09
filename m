Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D40776AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjHIVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:17:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA110CA;
        Wed,  9 Aug 2023 14:17:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790ca0ed6d3so6868139f.3;
        Wed, 09 Aug 2023 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691615821; x=1692220621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KVEgLwTnFL0wbRwfXbs4nUcy42ZilD8DRhTF/jpgAqw=;
        b=HaA3v2uwdAP/fVnp8G4q7dRlwpEy8QEr66I+yPVf4qUrbqNnwoXqv3C8neuKlqgMOo
         Di8P+XARxPcNBSig4nG48a7gPrQTT1GnVvuNRZUH1Q/xHdaLU/dz7qt48jWKtqf4CkDt
         vMA6v5cRnue95BcU6VhftKuSxa1Oj1HhnWAfAPRFTJm8GBR0F+YLUFzVUjVzsQesLgAK
         v2ZDcIwycWfOZdjD6JN4L8GgItsQj9cuNuw5AvZk0D9zOndJZ4vUNm0D8NWzJVIc1MxA
         QM+f4B1hQeZMP6AXtkj/S9a6o4yccXetWi6WMk6K/Ym/S3JqEdOefzf40QaFHIpR9W8C
         oxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615821; x=1692220621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVEgLwTnFL0wbRwfXbs4nUcy42ZilD8DRhTF/jpgAqw=;
        b=dAMYgNLxdFpWKE6lS+IDvt1MIlUv30JJSdeN8rqp6zNVvsAFpW50/7UztzVPIYCMu7
         vgQ4Zj/wTG1Kp1OgzA0qsFHXeyKYiSjPiWN1tUfZ4XKiE/z5Snd5Q9qh8iMCSVWORSRb
         4rRTYl3lITuytWYkSjulhKnaDpW/QwDMrTs4FyLJZUoW15wpId5UFWlpJKi7/VexfunF
         qaLwQLH+Xj1BX5DmgTBKKhQ/XkrOKnlQyknUlG7oPKEbgkhGfTV3J934afErhi+REWln
         5zLdCrWaBoCZrVpGod4I2BcdiQocyr6Q7pgSrz3vsn2yvrx1dV7yXIaV7Jm0Cje7+AjF
         R+MQ==
X-Gm-Message-State: AOJu0Yxs1Kr4sCj/bNbNqH5Wy/G2Xo0kn2KZEMXLeq8o7GBkVJydoean
        y/fstPG/l5h6DnlXt9J3bTQ=
X-Google-Smtp-Source: AGHT+IH9aG2b/NYz0H3DjhuHWwv5USpb7h4j8e717s69mav6viJxUAtiYNHHKIAiYM5cBe3iyeJ6SA==
X-Received: by 2002:a05:6e02:12a8:b0:348:ec07:9dfa with SMTP id f8-20020a056e0212a800b00348ec079dfamr274670ilr.14.1691615820725;
        Wed, 09 Aug 2023 14:17:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r7-20020a028807000000b0042b56b57a50sm3949245jai.171.2023.08.09.14.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 14:17:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d883dd8b-1858-7204-32f6-09f1ef9ec326@roeck-us.net>
Date:   Wed, 9 Aug 2023 14:16:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Revert port_id use
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
 <20230809052650.GT14799@atomide.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230809052650.GT14799@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 22:26, Tony Lindgren wrote:
> Hi,
> 
> * Guenter Roeck <linux@roeck-us.net> [230806 13:19]:
>> On Sun, Aug 06, 2023 at 09:20:50AM +0300, Tony Lindgren wrote:
>>> Guenter reports boot issues with duplicate sysfs entries for multiport
>>> drivers. Let's go back to using port->line for now to fix the regression.
>>>
>>> With this change, the serial core port device names are not correct for the
>>> hardware specific 8250 single port drivers, but that's a cosmetic issue for
>>> now.
>>>
>>> Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
>>> Reported-by: Guenter Roeck <groeck7@gmail.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks for testing.
> 
> Guenter, care to also test the patch below on top of this fix and
> see if things still behave for you?
> 
> I'll send a proper patch assuming things test fine.
> 

Patch below works for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Regagrds,
> 
> Tony
> 
> 8< --------------------
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -16,6 +16,7 @@ struct device;
>   
>   struct serial_ctrl_device {
>   	struct device dev;
> +	struct ida ida;
>   };
>   
>   struct serial_port_device {
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/container_of.h>
>   #include <linux/device.h>
> +#include <linux/idr.h>
>   #include <linux/module.h>
>   #include <linux/serial_core.h>
>   #include <linux/slab.h>
> @@ -112,6 +113,8 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
>   	if (!ctrl_dev)
>   		return ERR_PTR(-ENOMEM);
>   
> +	ida_init(&ctrl_dev->ida);
> +
>   	err = serial_base_device_init(port, &ctrl_dev->dev,
>   				      parent, &serial_ctrl_type,
>   				      serial_base_ctrl_release,
> @@ -142,16 +145,31 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
>   						struct serial_ctrl_device *ctrl_dev)
>   {
>   	struct serial_port_device *port_dev;
> +	unsigned int min = 0, max = ~0U;
>   	int err;
>   
>   	port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
>   	if (!port_dev)
>   		return ERR_PTR(-ENOMEM);
>   
> +	/* Device driver specified port_id vs automatic assignment? */
> +	if (port->port_id) {
> +		min = port->port_id;
> +		max = port->port_id;
> +	}
> +
> +	err = ida_alloc_range(&ctrl_dev->ida, min, max, GFP_KERNEL);
> +	if (err < 0) {
> +		kfree(port_dev);
> +		return ERR_PTR(err);
> +	}
> +
> +	port->port_id = err;
> +
>   	err = serial_base_device_init(port, &port_dev->dev,
>   				      &ctrl_dev->dev, &serial_port_type,
>   				      serial_base_port_release,
> -				      port->ctrl_id, port->line);
> +				      port->ctrl_id, port->port_id);
>   	if (err)
>   		goto err_put_device;
>   
> @@ -165,16 +183,24 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
>   
>   err_put_device:
>   	put_device(&port_dev->dev);
> +	ida_free(&ctrl_dev->ida, port->port_id);
>   
>   	return ERR_PTR(err);
>   }
>   
>   void serial_base_port_device_remove(struct serial_port_device *port_dev)
>   {
> +	struct serial_ctrl_device *ctrl_dev;
> +	struct device *parent;
> +
>   	if (!port_dev)
>   		return;
>   
> +	parent = port_dev->dev.parent;
> +	ctrl_dev = to_serial_base_ctrl_device(parent);
> +
>   	device_del(&port_dev->dev);
> +	ida_free(&ctrl_dev->ida, port_dev->port->port_id);
>   	put_device(&port_dev->dev);
>   }
>   

