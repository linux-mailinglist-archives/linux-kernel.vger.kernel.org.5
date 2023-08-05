Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131A3770F5C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHEKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHEKud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:50:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F050468A;
        Sat,  5 Aug 2023 03:50:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-790a590237aso123359539f.3;
        Sat, 05 Aug 2023 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691232631; x=1691837431;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6kDWzV9e2XZH2aJxm/vvznv1nHNWfxKKsnzaVw0sys=;
        b=sbw+HE2I+oBQwgVNQRawZShnAWXrilYum/KcmdhDaS08aSvzOhIaWAHm8b81cwtbVn
         I8j2ZwiGcgjk3AkBVnUVzj4v90AJTC5TbxKM5fTRSBCdv9/wjctJRns1sXGMuGSh7X/z
         LUXRN7OEipgoNKxPMB8kunJ4udKYwnt99MgNxtJjhYURdoiPSk2WDmUso72H7E04Xo0f
         uSrxdHE8i4xoG5nDy8XnjGdYMRiRUJVSUy4+qGRh5DuvJMTSQf6dT8KokYJOvXre5MzX
         j8FCadS8Bl1GPdnMwZTsGqKz+hxPYT1PkYX78/J5AjT4ESuZogSxb+i0JyTZNpAJrxbw
         hTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691232631; x=1691837431;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6kDWzV9e2XZH2aJxm/vvznv1nHNWfxKKsnzaVw0sys=;
        b=fn+fkmWH8IzBseFpH7TN7bR2LcN1U3cG6rOcB8XEgTN20mm4lp15mHuDCXC+6ZErlu
         2fWzbMdLTY7sP98JUehKcCrg3w74WYHZ7BfIT8fUD9pbXYI+opXgPXbuZ2llH5UsPX+d
         jK8IEqnHpAHgoKXj7nUf5JXAYmG/laPH2muqJh1d5wISL54BHU4eQ69Xr0etlATy5mZb
         L7Vyosc+V/n7d8lA86hChSfBz4g8MGsoY5gB/uTUcCUG+oWfUhgDmLJvX+Y998DLu+p3
         yopoxommzSAwY/dHhSdwcF4/IVUS4Tng8s6TctjbRJRHUlG2F/Y1UA1P8DGhclRIaf+S
         vPYw==
X-Gm-Message-State: AOJu0Yxsq1DDpALS8lKTOHi59FerNgtLrf6lyzRYjZCdUC4r6mazRuVp
        Hmw5b6cZj9F4hTePF1ojxG0=
X-Google-Smtp-Source: AGHT+IFKJFOes/jjvK3zfn8n5x/63o/hPs3OylaCizXRI70tospTY3ZA/YF3icAPj6EOq28hF8j0JQ==
X-Received: by 2002:a5d:8909:0:b0:787:1557:3834 with SMTP id b9-20020a5d8909000000b0078715573834mr5665878ion.20.1691232631211;
        Sat, 05 Aug 2023 03:50:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s22-20020a5eaa16000000b00785cd25010esm1239532ioe.11.2023.08.05.03.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 03:50:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a6973497-f45f-6456-ac2b-d3c0262d892b@roeck-us.net>
Date:   Sat, 5 Aug 2023 03:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
        kernel test robot <oliver.sang@intel.com>
References: <20230803071034.25571-1-tony@atomide.com>
 <0e1bc27d-dc84-473d-bfdf-db0743c5d64a@roeck-us.net>
 <20230805044910.GJ14799@atomide.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after fixing
 controller port name
In-Reply-To: <20230805044910.GJ14799@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 21:49, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [230804 21:42]:
>> On Thu, Aug 03, 2023 at 10:10:32AM +0300, Tony Lindgren wrote:
>>> While fixing DEVNAME to be more usable, I broke serial_base_match() as the
>>> ctrl and port prefix for device names seemed unnecessary.
>>>
>>> The prefixes are still needed by serial_base_match() to probe the serial
>>> base controller port, and serial tx is now broken.
>>>
>>> Let's fix the issue by checking against dev->type and drv->name instead
>>> of the prefixes that are no longer in the DEVNAME.
>>>
>>> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> With this patch applied, I see the following traceback in the pending-fixes
>> branch.
>>
>> Bisect log attached as well. It actually points to commit d962de6ae51f
>> ("serial: core: Fix serial core port id to not use port->line").
>> Bisect was on mips, but I also see problems on arm, ppc, and sparc.
>> sparc boot tests show the warning message and then stall until aborted
>> (which of course may be a different problem).
> 
> Sorry about all the hassles and thanks for testing again.
> 
> I too noticed several issues remaining after testing reloading the hardware
> specific serial driver, the issues I saw should be fixed in tty-linus.
> 
>> kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
>> serial8250 serial8250.0: unable to register port at index 1 (IO2f8 MEM0 IRQ3): -17
>> sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
> 
> The issue above should be fixed with commit:
> 
> bbb4abb1bcfb ("serial: 8250: Reinit port_id when adding back serial8250_isa_devs")
> 

No. I tested the tip of tty-linus (v6.5-rc4-9-gdfe2aeb226fd) which includes
above commit, but still see the problem. sparc images also still stall after
the "cannot create duplicate filename" message.
I bisected the sparc problem - it also bisects to commit d962de6ae51f.

The problem affects all mips boot tests, all sparc boot tests, as well as
arm sx1, ppc bamboo and sam460ex emulations. As far as I can see, those
call serial8250_register_8250_port() without calling  serial8250_setup_port()
and thus don't set port_id. I am only testing a few of those, so I strongly
suspect that all similar callers of serial8250_register_8250_port() are
affected (i.e., almost all of them) if they register more than one serial port.

Guenter

