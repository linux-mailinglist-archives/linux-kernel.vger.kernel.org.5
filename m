Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC26758D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGSFZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSFZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:25:41 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B11FD2;
        Tue, 18 Jul 2023 22:25:40 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so8584340a12.1;
        Tue, 18 Jul 2023 22:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689744338; x=1690349138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRgFksD0PKCE1D5trX9nk3Gnv+UFCoWdjPcPmaic2v0=;
        b=h0Xyt5DtMKTHgaArDYiZqiqo/KfhxPXBt9oNI9pMygBMq2flnmi/00mBrqoC3nE0KB
         q0uduAb6I5RL6kwL6UD2fi/WBWI3sbLvdkdlL93L3Oln9sxq9n39T9IslwRuysfTtMM1
         yf+MRmZ6aKclpn+dhnKIT10GEkB6MDBqRTqLHSMPDeo3NzM3UjoQuPE9fffajAzkACen
         zNDUe75GbQyBEpPlnlBuqiqOszGgvvAew2Mk2pTExPNxDKX/Yxpy9k5Qvk415jr9BoQj
         GrQDaWeucX/tosV8GPxBeIZJq7o8DHtyJL1pQGNSFdOmv8ORtUyUvZQBvZC/hs3vC99A
         HO2w==
X-Gm-Message-State: ABy/qLbgKvpZ88IWwGo+wEtKSZQL9ANYe+hYsjR4BdgKabtgMCeFe9PC
        NUuo6oOUTgI/Zm+ZXRkVE4E=
X-Google-Smtp-Source: APBJJlGHhPTXN+PiERIz9uY8LQsOOKUGmhtLr7f/9sCXE4ouCBOBLvXXy7yhPmjG0f4OzQWTWEFn7w==
X-Received: by 2002:aa7:c902:0:b0:521:7417:1131 with SMTP id b2-20020aa7c902000000b0052174171131mr1431658edt.15.1689744338452;
        Tue, 18 Jul 2023 22:25:38 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id o21-20020aa7d3d5000000b0051bed21a635sm2151028edr.74.2023.07.18.22.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 22:25:38 -0700 (PDT)
Message-ID: <35758c24-1543-6f96-7957-b371dc94e59d@kernel.org>
Date:   Wed, 19 Jul 2023 07:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Add support for dev_name:0.0 naming for
 kernel console
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719051525.46494-1-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230719051525.46494-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 07. 23, 7:15, Tony Lindgren wrote:
> With the serial core controller related changes we can now start
> addressing serial ports with dev_name:0.0 naming. The names are something
> like 00:04.0:0.0 on qemu, and 2800000.serial.0:0.0 on ARM for example.
> 
> The dev_name is unique serial port hardware controller device name, also
> known as port->dev, and 0.0 are the serial core controller id and port id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Note that this depends on fix for serial core port ids patch
> "[PATCH] serial: core: Fix serial core port id to not use port->line"
> 
> ---
>   drivers/tty/serial/serial_core.c | 47 ++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3322,6 +3322,49 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
>   	return 0;
>   }
>   
> +/*
> + * Add preferred console if configured on kernel command line with naming
> + * "console=dev_name:0.0".
> + */
> +static int serial_core_add_preferred_console(struct uart_driver *drv,
> +					     struct uart_port *port)
> +{
> +	char *port_match, *opt, *name;
> +	int len, ret = 0;
> +
> +	port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
> +			       dev_name(port->dev), port->ctrl_id,
> +			       port->port_id);
> +	if (!port_match)
> +		return -ENOMEM;
> +
> +	opt = strstr(saved_command_line, port_match);
> +	if (!opt)
> +		goto free_port_match;
> +
> +	len = strlen(port_match);
> +
> +	if (strlen(opt) > len + 1 && opt[len] == ',')
> +		opt += len + 1;
> +	else
> +		opt = NULL;
> +
> +	name = kstrdup(drv->dev_name, GFP_KERNEL);

Why do you dup the name here?

> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto free_port_match;
> +	}
> +
> +	add_preferred_console(name, port->line, opt);
> +
> +	kfree(name);

thanks,
-- 
js
suse labs

