Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7797B73F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbjJCWKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjJCWKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:10:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25BC6;
        Tue,  3 Oct 2023 15:09:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso1466885f8f.0;
        Tue, 03 Oct 2023 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696370995; x=1696975795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNt+Sr2/aj4UZHdSxf+VyJh7hp1Iyn42noN2hwnne40=;
        b=awik4XDtNx34wD0ejaWqXQJBXLbxRmqV9hWLVMeSJpnGmTiSNFp0KsTBcEijH8JPD8
         fnb5PMOq8k4kRzuBsKcKkNWkq7xjZJ/XVs8kEM+mWbjkJ1CokmnQp+sO6sxwsMRipxZV
         V70DKIN2jn4//nNUnNdUVIhHF3RF60MJUh1gJkh5r2NDwBs2O1eLXIBSbKF1PvWPICGL
         yvVi7G10R5aGlJb7Z7qLu6LcddbEprhLI0aVoG2azMDcHXO19jHVzXtQXM6trR4+p+ce
         UYXCFIzvjaTtKEZ4c+wpPaB/nhuIvmY785k4oGQ+k3H658oTgEcHJigklCeaAIzGbNZj
         rKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370995; x=1696975795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNt+Sr2/aj4UZHdSxf+VyJh7hp1Iyn42noN2hwnne40=;
        b=aX+fD0y6P7idJSHM3LFy+wQuOfO8iaJ7zAfgdO8HJtYrD+MHZpJdVWiDKgsO8ouLWV
         Zoez26pkhhD0zPvo3C+QYChF7iwBfyRENmzRfJZ0HpF1YJVcv/r43Jd0evKAjdpiAzZG
         uskdgr2qjrCFOHhnIwmEE/VgrbIA7YgFjTbKKFtTB/27L9oobGS66CXLWbPU3+cFDhul
         35yetmRwIOUwmRBQzvWx4aH7QgijcaZlGDX7oBssE5XVc0P+gNH4/LbL+cjrhzWCnuYA
         cd6Dg5GnclNB7M6VOYjiOJzirFGXwKZMEF4cCEzSAlciRLHVU4eSDRQR0SA6X4x8LAOJ
         g7OA==
X-Gm-Message-State: AOJu0YxKsdaO9HJbMIMnOe+XaF1x2wMiC4Dvfdbt+LMgNDTRq+ppaW+v
        kmdhs15cNOUsb0sFNqa4oso=
X-Google-Smtp-Source: AGHT+IEOt8JcmZBYur3zHdZnapFkHn9P3WDdhKEsFSXKl/X6ZNahM4p+UNMC31JSiOc9zglN7urqkQ==
X-Received: by 2002:adf:d0cc:0:b0:323:2290:e39b with SMTP id z12-20020adfd0cc000000b003232290e39bmr513266wrh.59.1696370995018;
        Tue, 03 Oct 2023 15:09:55 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b003196b1bb528sm2460004wru.64.2023.10.03.15.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 15:09:54 -0700 (PDT)
Message-ID: <dc7af79d-bca8-4967-80fe-e90907204932@gmail.com>
Date:   Wed, 4 Oct 2023 00:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
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
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231003122137.GC34982@atomide.com>
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

On 10/3/23 14:21, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [231003 12:15]:
>> Hi,
>>
>> * Maximilian Luz <luzmaximilian@gmail.com> [231003 11:57]:
>>> A bad workaround is to disable runtime PM, e.g. via
>>>
>>>    echo on > /sys/bus/serial-base/devices/dw-apb-uart.4:0/dw-apb-uart.4:0.0/power/control
>>
>> If the touchscreen controller driver(s) are using serdev they are
>> children of the dw-apb-uart.4:0.0 and can use runtime PM calls to
>> block the parent device from idling as necessary. The hierarchy
>> unless changed using ignore_children.
> 
> Sorry about all the typos, I meant "the hierarchy works unless changed"
> above. The rest of the typos are easier to decipher probably :)

Unfortunately that doesn't quite line up with what I can see on v6.5.5. The
serdev controller seems to be a child of dw-apb-uart.4, a platform device. The
serial-base and serdev devices are siblings. According to sysfs:

     /sys/bus/platform/devices/dw-apb-uart.4
     ├── driver -> ../../../../bus/platform/drivers/dw-apb-uart
     ├── subsystem -> ../../../../bus/platform
     │
     ├── dw-apb-uart.4:0
     │  ├── driver -> ../../../../../bus/serial-base/drivers/ctrl
     │  ├── subsystem -> ../../../../../bus/serial-base
     │  │
     │  └── dw-apb-uart.4:0.0
     │     ├── driver -> ../../../../../../bus/serial-base/drivers/port
     │     └── subsystem -> ../../../../../../bus/serial-base
     │
     └── serial0
        ├── subsystem -> ../../../../../bus/serial
        │
        └── serial0-0
           ├── driver -> ../../../../../../bus/serial/drivers/surface_serial_hub
           └── subsystem -> ../../../../../../bus/serial

Runtime suspend on serial0-0 is disabled/not set up at all. So I assume that if
it were a descendent of dw-apb-uart.4:0.0, things should have worked
out-of-the-box.

Regards,
Max

