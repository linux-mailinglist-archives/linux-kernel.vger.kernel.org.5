Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16731771063
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjHEPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:50:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E0E51;
        Sat,  5 Aug 2023 08:50:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f1240a22so2949707b3a.0;
        Sat, 05 Aug 2023 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691250650; x=1691855450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EyjSidwJSs1+lh6cGsr1E2Ndio59AcP0tZxWu5XP/W0=;
        b=SwGTRB6mGgoav+Ytvmsxez0OV3sRBvyvF/lroCiX9zTEmqyxbW2Aiy0y98/HZ753Cx
         GbzqHLGA3fAtSiR/CJFWo0FsUkIeF099zQngmpC8YYEE1PHmY6zCeLrXmdFi3EJJ4gnz
         iPdXnKY2zdRXrcNTZl6nvSRtAdhf/xcDiJWarsIB9u/SPVsQNkdsRSPEhKOYhrTVq3xS
         /pTWCeh6zzVhVvcykV019pKQRMX1fcLKL7qDmQoC39ZexEVMJKM05leyaC/U6HjJAyUE
         b88wXnjwx9t7hRIedpuD2rkjr1LtyN/WAflcQzpyQPRxtxLKIx6bGjmsg3wly6lPJLog
         uAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691250650; x=1691855450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyjSidwJSs1+lh6cGsr1E2Ndio59AcP0tZxWu5XP/W0=;
        b=OMb8ZekpVWx+umVImEmTITwHFcGFd4KhvBsVavpRCwUkKeYDNeIPyOyXeNofAIx7MY
         BhL+hKZkZR20BDdGbaK+liuQxLZZIL4lRie6mbras07Bw+HuwfvIJSf/1mam9s/SiPCy
         1JfvJ3B62ghotJ2liC1wBHYc5K0tLOaS/IGpC/z0Nywhc+NUQN2MMi3RPIB8vmSR4+r9
         ViHc2bhHr3uPQnSUaN0Nca0oL7AON7ii8lv6au0Xwi1wOEo9I07mY19ONEdhmsmqStLK
         MUqpVM73pt1YDJyeicLFRPoCG5irakUf4SZHXRes8I3sftfSqUL0Z/aH/Ojcz+Hl/Wev
         77wA==
X-Gm-Message-State: AOJu0YzHmqtPSQtN2/RaX7EIA7I7KtmYQp7fEAQ7A0SyxyIqv1Kix9oU
        KUKQT6r/EkbR2ObjAfbKGpc=
X-Google-Smtp-Source: AGHT+IHuuKQ6jKw7qMaj7HGGM244pk2RxcFq7iWCRhzYOPv9B+zjheFbn6cJKKwkIUradnrLNxDHPw==
X-Received: by 2002:a05:6a00:3990:b0:67a:553d:3bc3 with SMTP id fi16-20020a056a00399000b0067a553d3bc3mr5999354pfb.6.1691250650338;
        Sat, 05 Aug 2023 08:50:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a056a00270a00b0068796c58441sm3302401pfv.60.2023.08.05.08.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 08:50:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aeca6f69-49df-898c-e70b-afcc5427a29b@roeck-us.net>
Date:   Sat, 5 Aug 2023 08:50:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after fixing
 controller port name
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
 <a6973497-f45f-6456-ac2b-d3c0262d892b@roeck-us.net>
 <20230805114846.GK14799@atomide.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230805114846.GK14799@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/23 04:48, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [230805 10:50]:
>> On 8/4/23 21:49, Tony Lindgren wrote:
>>> * Guenter Roeck <linux@roeck-us.net> [230804 21:42]:
>>>> kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
>>>> serial8250 serial8250.0: unable to register port at index 1 (IO2f8 MEM0 IRQ3): -17
>>>> sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
>>>
>>> The issue above should be fixed with commit:
>>>
>>> bbb4abb1bcfb ("serial: 8250: Reinit port_id when adding back serial8250_isa_devs")
>>>
>>
>> No. I tested the tip of tty-linus (v6.5-rc4-9-gdfe2aeb226fd) which includes
>> above commit, but still see the problem. sparc images also still stall after
>> the "cannot create duplicate filename" message.
>> I bisected the sparc problem - it also bisects to commit d962de6ae51f.
>>
>> The problem affects all mips boot tests, all sparc boot tests, as well as
>> arm sx1, ppc bamboo and sam460ex emulations. As far as I can see, those
>> call serial8250_register_8250_port() without calling  serial8250_setup_port()
>> and thus don't set port_id. I am only testing a few of those, so I strongly
>> suspect that all similar callers of serial8250_register_8250_port() are
>> affected (i.e., almost all of them) if they register more than one serial port.
> 
> OK thanks for explaining. So we need to initialize port->port_id for the
> multi-port instances to avoid being stuck with the port->line index. I'll
> take a look.
> 
> I wonder if we should just revert d962de6ae51f for now. It needs to be
> tested to see if something else also needs reverting though.
> 

It is actually more complicated like that. Adding some debug into, I get the following
from a mips boot. Turns out that serial8250_setup_port() is actually called.

...
####### serial8250_setup_port: index 0
####### serial8250_setup_port: index 0 returning 819a5ab8
####### serial8250_setup_port: index 1
####### serial8250_setup_port: index 1 returning 819a5d20
####### serial8250_setup_port: index 2
####### serial8250_setup_port: index 2 returning 819a5f88
####### serial8250_setup_port: index 3
####### serial8250_setup_port: index 3 returning 819a61f0
...
#### serial8250_register_8250_port: uart=819a5ab8
#### serial8250_register_8250_port: uart=819a5ab8 port_id=0 line=0
...
#### serial8250_register_8250_port: uart=819a5d20
#### serial8250_register_8250_port: uart=819a5d20 port_id=1 line=1
sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'

So line and port_id are both set, but the created sysfs attribute
is still duplicate. I'll do some more debugging.

Guenter

