Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894527C581B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjJKPaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjJKPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:30:00 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4192;
        Wed, 11 Oct 2023 08:29:59 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b102a6565eso2443691241.0;
        Wed, 11 Oct 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038198; x=1697642998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv1kYdGHJEu/8xSIHscJQ1hEvpIhACaiAxShcFHXWMo=;
        b=afcLE1sElITcNKLCuwsYA1jSxA3D2bvlmI4VVckKjW/SaW9pA6EgH7Zw11VmE3sHqz
         w7OUM7sP/XJ5nT6fyTiVsHKfG4cnSJNSThhsKfUovogYfRrXxYp14pgutuSBHVra84LH
         TpeLQzPEcnO9MER8AtH9utQSzKQcdPrsVB25NNAWQCPb2czhoxeZV5NNSJyizNl4KX6t
         wQ4zYePj5AwuNTPLEc5hlNCN84+M3F0uT/A/w2G5FstLUZsDuRH5I1JV65WD57MMckzF
         ecC2/SQlcKymgP6/nsORTioZRxs597rlqk9KWhqsAQS2MB/gNWxEfZ6FuA7VTtxeEg6e
         TFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038198; x=1697642998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv1kYdGHJEu/8xSIHscJQ1hEvpIhACaiAxShcFHXWMo=;
        b=eIDQlcrQWwEnbKZpXucUrC+q3NRpgAhAxguql2FgiMFxd7JjhK/iWWrYNLn4vtypsk
         m4jc/Rj64RSMyMKZTn1R6uFCo9o3IuGaK09tk1iQcQ/SsWw57jZ3a/AbSqk9/enhv39U
         YswicoeM1iSvL0Wphyw/q4x35erdxZ5vBUpO+nQQerCezMgQCoVsUKBQM82y98n/FYeo
         kc8jSjFFpStII+sko1H+KwhGdMFuoQnfGneqNw7Ic4eW89/GyYqi5VZtDxgqe4i/16T6
         QfpSRF0mGY9yrjZfHWb1/1IrOtEqibmC/K3ZttN3HGdsqEtsyxkLzMkZ6tu+WEEWrOWD
         PlsQ==
X-Gm-Message-State: AOJu0YxR7OTNaTlMlJc4eFWsBl9xWEsSGp6Bdz9VncitcpvJK5QEXgB9
        G1go6AZ2FkJ9YQUjK6YqeJDUiXmBAio=
X-Google-Smtp-Source: AGHT+IFxGuvSUutocYGjgF3CNBIaceI4qqpXL7t01NoCI6VBWU0eV75WwdEkW3KiYkgZpm/Y/a1JFQ==
X-Received: by 2002:a05:6102:4429:b0:457:6602:497b with SMTP id df41-20020a056102442900b004576602497bmr13079198vsb.0.1697038198089;
        Wed, 11 Oct 2023 08:29:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h18-20020a67cb92000000b0045765b2ec50sm14338vsl.20.2023.10.11.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:29:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 08:29:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "xingtong.wu" <xingtong_wu@163.com>
Cc:     linux-watchdog@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Wu, Xing Tong" <XingTong.Wu@siemens.com>, jan.kiszka@siemens.com,
        tobias.schaffner@siemens.com, cedric.hombourger@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: Re: wdat_wdt: Problem with WDAT using shared registers
Message-ID: <df8d53db-0056-434d-953b-991025e6cd34@roeck-us.net>
References: <bef5a084-9a6c-daaf-dad9-89cb5fc32bf9@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef5a084-9a6c-daaf-dad9-89cb5fc32bf9@163.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2043 at 01:17:41AM +0800, xingtong.wu wrote:
> Hi
> 
> I want to use the wdat_wdt to support a watchdog of SIONCT (a multi-function device
> (mfd)), and I register instructions for wdat_wdt in BIOS, it need registers 0x2e-0x2f
> to access the watchdog, then register 0x2e-0x2f will be forever occupied by platform
> device wdat_wdt, see the code: https://elixir.bootlin.com/linux/v6.6-rc5/source/drivers/acpi/acpi_watchdog.c#L180
> 
> but the 0x2e-0x2f are special, they are used for a multi-function device --SIONCT, the
> device have many pins can not only support features for watchdog, but also other
> features like leds, fans, temperature monitor... there are drivers for these pins, e.g.
> gpio-f7188x, nct6775, w83627hf... these driver use the shared register 0x2e-0x2f. 
> 
> So the issue happened, the wdat_wdt occupied the shared register 0x2e-0x2f, then
> the other driver can not load.
> 
> Here is the msg I collected from my device:
> 
> root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# cat /proc/ioports 
> 0000-0cf7 : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   002e-002e : wdat_wdt
>   002f-002f : wdat_wdt
> 
> It will cause other SIONCT drivers can not load, e.g.
> root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# modprobe gpio-f7188x
> modprobe: ERROR: could not insert 'gpio_f7188x': No such device
> 
> And dmesg info is:
> [  213.559168] gpio-f7188xI/O address 0x002e already in use
> 
> Same reason for other drivers:
> root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# modprobe nct6775
> modprobe: ERROR: could not insert 'nct6775': No such device
> 
> Do you have any idea for the wdat_wdt to add support for multi-function device?
> 

In general, it would need to request the 0x2e-0x2f space temporarily
and release it when it isn't used. Many other drivers do the same.
Look for request_muxed_region() and release_region() in, for example,
drivers/watchdog/w83627hf_wdt.c.

However, this is more difficult with ACPI. Device access should either
be all through ACPI, or all direct. It doesn't really make much if any
sense to access one of the sub-devices through ACPI and others directly
because there is no automatic synchronization mechanism between ACPI
and the rest of the kernel. If ACPI reserves the 0x2e-0x2f space, it
owns it, period.

Note: There can only be one device at 0x2e/0x2f. I don't really understand
the reference to both nct6775 and f7188 because it is simply not possible
that both reside at that address at the same time. And if there is a nct6775
or f7188 compatible chip in the system, it would make much more sense to
use the chip specific watchdog drivers instead of wdat_wdt - again, ACPI
takes it all, and doesn't like competition.

Guenter
