Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B5176F90B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjHDEjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHDEio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:38:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C54229;
        Thu,  3 Aug 2023 21:38:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso12108105ad.2;
        Thu, 03 Aug 2023 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691123885; x=1691728685;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XocLwPYb77kZUEtEw5j8D7AOWzYHR1969Dzq6RM/Css=;
        b=lYJVt7iDGitPQ/64J+Y5iSUFeCdkDFoFlWyKga8THRP2pX/3qf0v99MLyZs28DmmWr
         GC2AHHr3LVi4M0LbGcFYaCO/1iviMRrBzAFHAGE/waD+YYyf/cWHNipO7y45FlMN0qGl
         x93HTe8P1/q2hdeeogKMsH+fA0QDz4WYfwPvIWUwyRqzrUJt63+XnQMpJml3bUDJ6L2L
         1YfHmf2ZJby9qKtBV7YcYVuDbbJY6WG4wF3OocbvMpxt66NfpBE0bFLntUccGnnGZoqI
         7+0nfvXIMRYywC7eLzWRHTrfAnwbiBPFHcbvl74dmBKMcFM0fFlq1SRulrrwQsKj9O1d
         VArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691123885; x=1691728685;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XocLwPYb77kZUEtEw5j8D7AOWzYHR1969Dzq6RM/Css=;
        b=VlN1lKv2gHlpfv/ODTmpnc0WjnS3lA2KcBB2F5/j3zGSOnhmm2/qYTNiHkGrZRbTEm
         NvnSozOVYBunJgmiWKq2y/BFgmn/gBSzou2y+gOho+o/hTpPc7ShvwVfYpTShtM5Pi/F
         iB4j8biIVRZR4a95LVy5dHWLFc5Ro7ZhYMGkUAFGFW6oRjY5HXhNZ00ZJM8ilS1f1WJb
         7gxHHi5a9oleoptia9BYIntBIOC0kfdn/YWWd536F5j/dBfajmIi7yxvpaN9rlSkqcf0
         mE2QVA3HYBmIHSEYPgZa1dT2fjcWHvQeOZjKO0dkOTx8JAQ24ubrvq3wFW3gXkEyWljI
         sCvA==
X-Gm-Message-State: AOJu0YxxQVWnaouAM9gphlMgC3Qv9poRP/9KjYezHQhPfsnd9pyGHRWT
        OGPmJUFBvWaTwZZMX73dcmw=
X-Google-Smtp-Source: AGHT+IHWNMIlJ7hXqjquDdAYrwx4EpGF20/XIJhHMPijrPz4xIx2pKqxb2ExMw5OikoP1B1F5Yb/sA==
X-Received: by 2002:a17:902:ecc8:b0:1bb:32de:95c5 with SMTP id a8-20020a170902ecc800b001bb32de95c5mr757271plh.65.1691123884781;
        Thu, 03 Aug 2023 21:38:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b001bb97e51ad5sm679169plg.99.2023.08.03.21.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 21:38:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b8123925-9f9a-834a-c08d-49f41c875ee1@roeck-us.net>
Date:   Thu, 3 Aug 2023 21:38:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
 <6423de18-637e-4ee6-858e-b74e701ff3e5@roeck-us.net>
 <ZMx8nQzYB3dBouFE@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port name
 to show controller id
In-Reply-To: <ZMx8nQzYB3dBouFE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 21:20, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 03:18:42PM -0700, Guenter Roeck wrote:
>> On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
>>> We are missing the serial core controller id for the serial core port
>>> name. Let's fix the issue for sane sysfs output, and to avoid issues
>>> addressing serial ports later on.
>>>
>>> And as we're now showing the controller id, the "ctrl" and "port" prefix
>>> for the DEVNAME become useless, we can just drop them. Let's standardize on
>>> DEVNAME:0 for controller name, where 0 is the controller id. And
>>> DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
>>>
>>> This makes the sysfs output nicer, on qemu for example:
>>>
>>> $ ls /sys/bus/serial-base/devices
>>> 00:04:0         serial8250:0    serial8250:0.2
>>> 00:04:0.0       serial8250:0.1  serial8250:0.3
>>>
>>> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> This patch causes about 50% of my boot tests to fail because the console
>> is no longer recognized. Reverting this patch fixes the problem.
>> Bisect log attached.
> 
> Isn't fix already available?
> 7d695d83767c ("serial: core: Fix serial_base_match() after fixing controller port name")
> 

Yes, hopefully that should fix it. We'll see tonight, when my test bed builds it again.

Guenter

