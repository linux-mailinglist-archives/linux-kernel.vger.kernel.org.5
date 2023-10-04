Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5961C7B8B01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbjJDSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244257AbjJDSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:44:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7880AD;
        Wed,  4 Oct 2023 11:44:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bb94eso1298305e9.0;
        Wed, 04 Oct 2023 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445079; x=1697049879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tfYIyhWueFbCoEaQL/520GF8dZ83yLjHCABvjZmLrM=;
        b=NDAhlM+5QwLGZXX4drZiTs8e5tQCqIpzdEAUgfQxtMbRaJ41BPzR1/7a6j0eH2CcMu
         GGg3Cm78unSElocPXmtuCYbs+j/lkW9XnwgfxXAw5eoKWrqvHLvKqFUW1kGYKMZvlCNZ
         s8zXJ95i4KEgpkaqX1nkezNc3/2V5TynZkBpdBeIrbXiFrxwOBcz/q2aueW1V4OAjCCp
         i0/xbauk0BmmuXClxRlnVpWkK3CReXaqX4kqqbrAjnASD5hZ6Y7Ry5l5vCVLz8wNo0cA
         MY+L9pfpq0cuUdenOwZDKtaK4Fhlmst/Je2P4xeod7Um6VEAc0fBRwDudUv4miUm4rLz
         Jn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445079; x=1697049879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tfYIyhWueFbCoEaQL/520GF8dZ83yLjHCABvjZmLrM=;
        b=dK2cChRPLB/PoJfUAUcWgcRut/Uy6V1C/LTc/rJyxFx9Hp7hRSbY8Rr5UJT5MydxW3
         MMsgIN+WKdlwyZD/rAC8nWbLlfGxBwD91U+bf7o0OZF2dr+6s/KXGK0Zw00A/FABeiXF
         x/wVaBq9XsXZVGCYsYl1Yo+p1ddXyRP4ikrw/2HZp05cDNNXjXgnGjPPZ5sEpIHa/hv5
         oarKwDYbz4rnQXCNiGzKo7vtPh6JtXjrpReBoDCJcsxKbbGZOLWkrkWS/QibGa576jmK
         yzyGD5DpFPJMDJ0xgIAo4cj8oZ16/Vx7f5KnHf+uBc48o5coG7thT/wI2gvdEYdeqOB+
         GmAA==
X-Gm-Message-State: AOJu0Yw2x6m0w5+EjMyTqtEU1eKxWDVLhq+ZXYgLqeclft52APeWoSPw
        H/DVxXc8igtROLmZFHlr+2s=
X-Google-Smtp-Source: AGHT+IGcvTOOCiGFLsDoCW+bXZevP/p0GFjlKvQanj1WARFpwmRsrR6hDhrNzxd1opInApWpYYIw/A==
X-Received: by 2002:a7b:c8d6:0:b0:402:f55e:ac11 with SMTP id f22-20020a7bc8d6000000b00402f55eac11mr3289607wml.20.1696445078851;
        Wed, 04 Oct 2023 11:44:38 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b003fef5e76f2csm176843wms.0.2023.10.04.11.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 11:44:38 -0700 (PDT)
Message-ID: <1431f5b4-fb39-483b-9314-ed2b7c118c11@gmail.com>
Date:   Wed, 4 Oct 2023 20:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>, Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230525113034.46880-1-tony@atomide.com>
 <62d3678a-a23d-4619-95de-145026629ba8@gmail.com>
 <20231003121455.GB34982@atomide.com> <20231003122137.GC34982@atomide.com>
 <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
 <20231004061708.GD34982@atomide.com> <ZR0Q7YUwgQV5TLhQ@hovoldconsulting.com>
 <20231004090320.GE34982@atomide.com> <ZR0s7dEh19lTid6-@hovoldconsulting.com>
 <20231004100123.GH34982@atomide.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231004100123.GH34982@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 12:01, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [231004 09:14]:
>> On Wed, Oct 04, 2023 at 12:03:20PM +0300, Tony Lindgren wrote:
>>> The serial port device and serdev device are siblings of the physical
>>> serial port controller device as seen in the hierarcy printed out by
>>> Maximilian.
>>
>> Yeah, and that's precisely the broken part. Keeping the serdev
>> controller active is supposed to keep the serial controller active. Your
>> serial core rework appears to have broken just that.
> 
> Hmm OK good point, tx can currently have an extra delay if a serdev
> device is active, and the serial port controller device is not active.
> 
> So we can check for active port->dev instead of &port_dev->dev though
> to know when when start_tx() is safe to do as below.

I can confirm that this works as well.

Thanks,
Max

> 8< -----------------
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6207f0051f23d..defecc5b04422 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -156,7 +156,7 @@ static void __uart_start(struct uart_state *state)
>   	 * enabled, serial_port_runtime_resume() calls start_tx() again
>   	 * after enabling the device.
>   	 */
> -	if (pm_runtime_active(&port_dev->dev))
> +	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
>   		port->ops->start_tx(port);
>   	pm_runtime_mark_last_busy(&port_dev->dev);
>   	pm_runtime_put_autosuspend(&port_dev->dev);
> 
