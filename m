Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE07EB61D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjKNSE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjKNSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:04:47 -0500
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80A6181;
        Tue, 14 Nov 2023 10:04:34 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso7229999e87.1;
        Tue, 14 Nov 2023 10:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985073; x=1700589873;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey9erX/YrVlUPvW8qimZgQRTCPhSsciFIT0777za9CM=;
        b=DZJVbwJNSedgo/bS2hR5rxADTM8P3WjdP5xE8U6At8q3KkDMnCbNUAU3Ud5Gu+yZsi
         qYV8g2wMNi4qK16SkI1xg2YKE07/T+vikLN098dn8prWL66iF1u5Niai/cVR0PKXa4pr
         gjlucFgL7T3b5r6ag9pGd2jc2gLIyVphOro6jXRHebWw4tmjTbl8cL3ufcD8DkR8uoAa
         Ze//4OW6a3Lp/AJLvGayNO+Evq/dsteCFl0N5485D/VS5+VtvWq7KSWRZBYnZOehfLTd
         XR5HxaDd/QS5ATBK8J11SpsXmKtJOz7ff7a/PirX2VfAz+brFggXWSYjdHq9/MmI7WLZ
         e0UQ==
X-Gm-Message-State: AOJu0YyEKgjUUH1zXh/j17IpamBBPfZKuW8uGG7W9TpU2nsYf1upXQnN
        T5FI4bBJuEJ29pnwuWJvVG5FLo/BLx4=
X-Google-Smtp-Source: AGHT+IFYwfGAP1QXLzYS/irG8xw6JaTeR+eUlbQEDk65Usr2OGHi+c8qJNznffpy88lJr/IBOr6USQ==
X-Received: by 2002:a05:6512:3f0:b0:50a:6fc5:e95c with SMTP id n16-20020a05651203f000b0050a6fc5e95cmr6134583lfq.60.1699985072699;
        Tue, 14 Nov 2023 10:04:32 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::bbbb:121? ([2a0b:e7c0:0:107::bbbb:121])
        by smtp.gmail.com with ESMTPSA id a67-20020a509ec9000000b0053e43492ef1sm5467491edf.65.2023.11.14.10.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 10:04:32 -0800 (PST)
Message-ID: <5da1d0d3-9677-4c9a-8568-d24db389465c@kernel.org>
Date:   Tue, 14 Nov 2023 19:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] /proc/sysrq-trigger: accept multiple keys at once
Content-Language: en-US
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20231114124152.97010-1-tomas.mudrunka@gmail.com>
 <20231114151252.117575-1-tomas.mudrunka@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231114151252.117575-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 11. 23, 16:12, Tomas Mudrunka wrote:
> Just for convenience.
> This way we can do:
> `echo _reisub > /proc/sysrq-trigger`
> Instead of:
> `for i in r e i s u b; do echo "$i" > /proc/sysrq-trigger; done;`
> 
> This can be very useful when trying to execute sysrq combo remotely
> or from userspace. When sending keys in multiple separate writes,
> userspace can be killed before whole combo is completed.
> Therefore putting all keys in single write is more robust approach.
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
> V5 -> V6: Documentation now has notice about undefined behavior
> V4 -> V5: Added this list of changes
> V3 -> V4: Bulk is now bool instead of char (and fixed typo)
> V2 -> V3: Fixed code styling (and introduced typo)
> V1 -> V2: Bulk mode only activated by underscore now, added docs
> 
>   Documentation/admin-guide/sysrq.rst | 11 ++++++++++-
>   drivers/tty/sysrq.c                 | 17 ++++++++++++++---
>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 51906e473..e7a82cba7 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -75,10 +75,19 @@ On other
>   	submit a patch to be included in this section.
>   
>   On all
> -	Write a character to /proc/sysrq-trigger.  e.g.::
> +	Write single character to /proc/sysrq-trigger.

a single

> +	Only first character is interpreted, rest of string is ignored.

the first; the rest of the string

> +	However it is not reccomended to write any extra characters

However, <- comma
recommended

> +	as the behavior is undefined and might change in the future versions.
> +	e.g.::

Even the original was lowercase. But it should be "E.g.::", right -- 
Greg/Jon?

>   
>   		echo t > /proc/sysrq-trigger
>   
> +	Alternatively write multiple keys combo prepended by underscore.

Alternatively, <- comma
s/keys/characters/
an underscore

> +	All characters are interpreted this way. e.g.::

This way, all characters are interpreted. (IMO this has a different 
meaning, but natives would have to tell us.)

> +
> +		echo _reisub > /proc/sysrq-trigger
> +
>   The :kbd:`<command key>` is case sensitive.
>   
>   What are the 'command' keys?
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 6b4a28bcf..ad07bc812 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -1150,16 +1150,27 @@ EXPORT_SYMBOL(unregister_sysrq_key);
>   #ifdef CONFIG_PROC_FS
>   /*
>    * writing 'C' to /proc/sysrq-trigger is like sysrq-C
> + * If first character in write is underscore, all characters are interpreted.

If the first character written is

thanks,
-- 
js
suse labs

