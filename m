Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075A771072
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHEQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHEQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:12:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA84206;
        Sat,  5 Aug 2023 09:12:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so20426175ad.2;
        Sat, 05 Aug 2023 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691251959; x=1691856759;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1PVEx7nr6yhvj7FyF5RKKbAyJ4svpMxzRSzbs1UjL4Y=;
        b=AXQ2AHhUFoWdfORhaGI3KG9Tvxya64wqg+MvXlyYtHkaGcPLekrwLSC6GU/Q5A72y/
         r/yw0LJMeoAEf6S9qJdbWmI28aDWCDWDqSOdS62Mv6y5Uu9/dY7afbIQyOwiZEeItiv9
         RxJanoj4AAEjEEf6w6VieADKBckDQzJWxZaTlAyDYvLvSPXztlwhIwXwwIOkKa+c6Ytn
         i24gdfQvdaTdBreB4r0owLR7U/bz6yXkJix6OvbIKhyfrjxkppMl5/Gf8fHExYbWIIHy
         0oCwqW3R9XkBHnBC54mp4d3zrykeIudnxFD4k6NVqTnRnFi/T8Bw1BsmmsyEtQYm0xG2
         FRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691251959; x=1691856759;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PVEx7nr6yhvj7FyF5RKKbAyJ4svpMxzRSzbs1UjL4Y=;
        b=AcnjvytpklRKeV2NOPNFWRhExAt0N08xwFkhziaGz4cR1MITjzBbKY1rH64LUQ1qiI
         V+eoQ4Cs5yZCGeEzvF4cidXtMm+oO+4BTr5IIvuikrnSeA8nrwCHRgii1ySGAnrlYKZw
         sSzL1pEq17uoXP7IUUsPttu0U0hWQzcYhR28Jqyv+wGMcjCQhgXXltWqtYd+/328vJyz
         kphOjBImCxQyzHAwhXEqsFFA9CO+tqhipOWT6GogtiVx1AnFDcDYuPua8fvB46J+LJ7o
         LJ/mtJHWK/EXzTM/Kohsh/4GbXSKp2mT5R742i+sg27GcBh96qUhlGd3gRSg8rXEdAnj
         yJFw==
X-Gm-Message-State: AOJu0Yybi5KMsyz9CVqe+Iwl/2HEBYMCWIsp4AHQN/tO6wvCwqdG5xZy
        e2ut4jY/T8j5px1v7WhJ/vbVtMV/9AI=
X-Google-Smtp-Source: AGHT+IGilHqMTi1vGu//g9fHCOzC1xGCHTJlDlvj9pDfqkNZntJVd3HiCTXvx+95niL4tzBhSQXBcg==
X-Received: by 2002:a17:902:e890:b0:1bb:dc48:644a with SMTP id w16-20020a170902e89000b001bbdc48644amr4546518plg.49.1691251959266;
        Sat, 05 Aug 2023 09:12:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v24-20020a1709028d9800b001b8c6662094sm3681664plo.188.2023.08.05.09.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 09:12:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <095e0120-ba81-64e7-e5d0-c042fb64978f@roeck-us.net>
Date:   Sat, 5 Aug 2023 09:12:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after fixing
 controller port name
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
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
 <aeca6f69-49df-898c-e70b-afcc5427a29b@roeck-us.net>
In-Reply-To: <aeca6f69-49df-898c-e70b-afcc5427a29b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/5/23 08:50, Guenter Roeck wrote:
> On 8/5/23 04:48, Tony Lindgren wrote:
>> * Guenter Roeck <linux@roeck-us.net> [230805 10:50]:
>>> On 8/4/23 21:49, Tony Lindgren wrote:
>>>> * Guenter Roeck <linux@roeck-us.net> [230804 21:42]:
>>>>> kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
>>>>> serial8250 serial8250.0: unable to register port at index 1 (IO2f8 MEM0 IRQ3): -17
>>>>> sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
>>>>
>>>> The issue above should be fixed with commit:
>>>>
>>>> bbb4abb1bcfb ("serial: 8250: Reinit port_id when adding back serial8250_isa_devs")
>>>>
>>>
>>> No. I tested the tip of tty-linus (v6.5-rc4-9-gdfe2aeb226fd) which includes
>>> above commit, but still see the problem. sparc images also still stall after
>>> the "cannot create duplicate filename" message.
>>> I bisected the sparc problem - it also bisects to commit d962de6ae51f.
>>>
>>> The problem affects all mips boot tests, all sparc boot tests, as well as
>>> arm sx1, ppc bamboo and sam460ex emulations. As far as I can see, those
>>> call serial8250_register_8250_port() without calling  serial8250_setup_port()
>>> and thus don't set port_id. I am only testing a few of those, so I strongly
>>> suspect that all similar callers of serial8250_register_8250_port() are
>>> affected (i.e., almost all of them) if they register more than one serial port.
>>
>> OK thanks for explaining. So we need to initialize port->port_id for the
>> multi-port instances to avoid being stuck with the port->line index. I'll
>> take a look.
>>
>> I wonder if we should just revert d962de6ae51f for now. It needs to be
>> tested to see if something else also needs reverting though.
>>
> 
> It is actually more complicated like that. Adding some debug into, I get the following
> from a mips boot. Turns out that serial8250_setup_port() is actually called.
> 
> ...
> ####### serial8250_setup_port: index 0
> ####### serial8250_setup_port: index 0 returning 819a5ab8
> ####### serial8250_setup_port: index 1
> ####### serial8250_setup_port: index 1 returning 819a5d20
> ####### serial8250_setup_port: index 2
> ####### serial8250_setup_port: index 2 returning 819a5f88
> ####### serial8250_setup_port: index 3
> ####### serial8250_setup_port: index 3 returning 819a61f0
> ...
> #### serial8250_register_8250_port: uart=819a5ab8
> #### serial8250_register_8250_port: uart=819a5ab8 port_id=0 line=0
> ...
> #### serial8250_register_8250_port: uart=819a5d20
> #### serial8250_register_8250_port: uart=819a5d20 port_id=1 line=1
> sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
> 
> So line and port_id are both set, but the created sysfs attribute
> is still duplicate. I'll do some more debugging.
> 

Ok, it is actually quite simple. In serial8250_register_8250_port(),
uart->port.port_id has the correct and expected value. However, that is
overwritten with
	uart->port.port_id      = up->port.port_id;
where 'up' is the port pointer passed by the caller of serial8250_register_8250_port().
And 'port_id' is always 0 in _that_ port pointer (while 'line' is set correctly).

Guenter

