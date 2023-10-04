Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018437B78DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbjJDHj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjJDHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:39:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2209B;
        Wed,  4 Oct 2023 00:39:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1773345f8f.1;
        Wed, 04 Oct 2023 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696405160; x=1697009960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Gfh5lgXOpkevOAqpRU3OUbH/HKTJy5YqVriUNrt62M=;
        b=D4SgZ84DHSBinB70iyoXb5cxEKdmtVK43UJ9TjHqHmyuTa8pROex/AVkNpdHSDybDx
         eurkiDKCppnGdI1bmhktr7kHw1rVY7LIBL5tvkBIsFjQrQ48Ms7QxIOOCL8K+hvfxes2
         93vm7qguE3QdnzZ5BRymUwkxDS7I5aE8vCwx1G3GEmPPz4c1rqDa4/AYDWHEsoQ2nYG/
         SGTU7d0z1cH5i3uda7wPStkd7LpGDmtXKFnDKFC9ZYtYoXZYXU3xfh9iyV4aIIu5NxUU
         4na02MPWz6ifd5HxFzvfJvz3mDVGKrdDCdP1MJcBEhuHzyemDeAfp6GbL1JlvKAR/Vwo
         vOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696405160; x=1697009960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gfh5lgXOpkevOAqpRU3OUbH/HKTJy5YqVriUNrt62M=;
        b=pHda4zpkzZ5V3wHiIOk7pNNRQRYA21zUCPD2O0+ZlhpPABbzb7DmgMk2vYTeFg25rc
         apwi7+yqhbTqgN63BrkOCYOdLQnhhAZq4u76DriDtPgD34jivWeeHIQpb0WMkS2sQ5+H
         pbtaLYIeKJvrRfQncoivVNx9RV7CkwjuRAhA2sSvQiLS8yB6AxJ4Bku/aw3xgHv655X3
         waLyuRItbAY5KJwM9cNcGYJH5X09rIP2l9NAU+OZvM/Y53ANPMdDjMlsaYmIEV+hKPXi
         4GU6rOciUy5J5NnGQ+VT6Z7ss/mzpTZROFx2/gh8FOug3JbFeNKVVGZAd7mmCIBXPDDT
         Tmag==
X-Gm-Message-State: AOJu0YxdpY1Jo/cz6+cy2krvDpIQocDUbtapC5bgpfz/tY5817g4qjOX
        d8Di+ABusuxkDdhtEK1CQDg=
X-Google-Smtp-Source: AGHT+IGpt0KPrEWdJC/qX3DO5lAHm0haGynKrndXR/O6O2XItabJkRfgyauX0ggSfjBTCYAQXiuprQ==
X-Received: by 2002:a5d:62c8:0:b0:31f:eb6a:c824 with SMTP id o8-20020a5d62c8000000b0031feb6ac824mr1196164wrv.10.1696405159670;
        Wed, 04 Oct 2023 00:39:19 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id d14-20020adffd8e000000b00325a59b2080sm3344754wrr.97.2023.10.04.00.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 00:39:19 -0700 (PDT)
Message-ID: <fcad430b-b9e8-4b1d-9dc9-195d12da5b00@gmail.com>
Date:   Wed, 4 Oct 2023 09:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230525113034.46880-1-tony@atomide.com>
 <62d3678a-a23d-4619-95de-145026629ba8@gmail.com>
 <20231003121455.GB34982@atomide.com> <20231003122137.GC34982@atomide.com>
 <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
 <20231004061708.GD34982@atomide.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231004061708.GD34982@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 08:17, Tony Lindgren wrote:
> * Maximilian Luz <luzmaximilian@gmail.com> [231003 22:09]:
>> On 10/3/23 14:21, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [231003 12:15]:
>>>> Hi,
>>>>
>>>> * Maximilian Luz <luzmaximilian@gmail.com> [231003 11:57]:
>>>>> A bad workaround is to disable runtime PM, e.g. via
>>>>>
>>>>>     echo on > /sys/bus/serial-base/devices/dw-apb-uart.4:0/dw-apb-uart.4:0.0/power/control
>>>>
>>>> If the touchscreen controller driver(s) are using serdev they are
>>>> children of the dw-apb-uart.4:0.0 and can use runtime PM calls to
>>>> block the parent device from idling as necessary. The hierarchy
>>>> unless changed using ignore_children.
>>>
>>> Sorry about all the typos, I meant "the hierarchy works unless changed"
>>> above. The rest of the typos are easier to decipher probably :)
>>
>> Unfortunately that doesn't quite line up with what I can see on v6.5.5. The
>> serdev controller seems to be a child of dw-apb-uart.4, a platform device. The
>> serial-base and serdev devices are siblings. According to sysfs:
>>
>>      /sys/bus/platform/devices/dw-apb-uart.4
>>      ├── driver -> ../../../../bus/platform/drivers/dw-apb-uart
>>      ├── subsystem -> ../../../../bus/platform
>>      │
>>      ├── dw-apb-uart.4:0
>>      │  ├── driver -> ../../../../../bus/serial-base/drivers/ctrl
>>      │  ├── subsystem -> ../../../../../bus/serial-base
>>      │  │
>>      │  └── dw-apb-uart.4:0.0
>>      │     ├── driver -> ../../../../../../bus/serial-base/drivers/port
>>      │     └── subsystem -> ../../../../../../bus/serial-base
>>      │
>>      └── serial0
>>         ├── subsystem -> ../../../../../bus/serial
>>         │
>>         └── serial0-0
>>            ├── driver -> ../../../../../../bus/serial/drivers/surface_serial_hub
>>            └── subsystem -> ../../../../../../bus/serial
> 
> The hierachy above is correct. Looks like I pasted the wrong device above,
> I meant dw-apb-uart.4, sorry about the extra confusion added. Eventually
> the serdev device could be a child of dw-apb-uart.4:0.0 at some point as
> it's specific to a serial port instance, but for now that should not be
> needed.
> 
> If serial0-0 is runtime PM active, then dw-apb-uart.4 is runtime PM active
> also unless ingore_children is set.
> 
>> Runtime suspend on serial0-0 is disabled/not set up at all. So I assume that if
>> it were a descendent of dw-apb-uart.4:0.0, things should have worked
>> out-of-the-box.
> 
> Hmm yes so maybe the issue is not with surface_serial_hub, but with serial
> port device being nable to resume after __device_suspend_late() has
> disabled runtime PM like you've been saying.
> 
> If the issue is with the serial port not being able to runtime resume, then
> the patch below should help. Care to give it a try?

Your patch does indeed make it work. So that's at least a better workaround
that we can carry in our downstream for now. Thanks!

Regards,
Max

> 8< ------------------
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -46,8 +46,27 @@ static int serial_port_runtime_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
> -				 NULL, serial_port_runtime_resume, NULL);
> +/*
> + * Allow serdev devices to talk to hardware during system suspend.
> + * Assumes the serial port hardware controller device driver calls
> + * pm_runtime_force_suspend() and pm_runtime_force_resume() for
> + * system suspend as needed.
> + */
> +static int serial_port_prepare(struct device *dev)
> +{
> +	return pm_runtime_resume_and_get(dev);
> +}
> +
> +static void serial_port_complete(struct device *dev)
> +{
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static const struct dev_pm_ops __maybe_unused serial_port_pm = {
> +	SET_RUNTIME_PM_OPS(NULL, serial_port_runtime_resume, NULL)
> +	.prepare = serial_port_prepare,
> +	.complete = serial_port_complete,
> +};
>   
>   static int serial_port_probe(struct device *dev)
>   {
