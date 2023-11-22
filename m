Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241A27F3E69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjKVGxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVGxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:53:48 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579819D;
        Tue, 21 Nov 2023 22:53:44 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso3871135e9.2;
        Tue, 21 Nov 2023 22:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700636023; x=1701240823;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyW7IEyoOxPI6zVC/onRZuSNEa7WQLhyWprKMNjU5kk=;
        b=cp+DmzGzjYdGTyfBIpf6TQrJa7y+GKGpXM8ftVpaBZerciEok1bmTNdJzoGnPZDC7i
         NCQF6o3vIUr0Pyd+n1PqXLdMsjF80goXWEuN/V39LyG1cdlW4PevgiSxlaJCwhr/fI94
         ZMXiGUyQaIj94524A6dAhsbmaNGQFXbYmhCPzcf8gGuxvkK3ezdmeDqNomiMk6u5CZmd
         qc8BhCfk3vc0dyQkMxi3nAXbZi6NCXQY6M4CXAL+0rxzXHP28MZ0YMIDgiLxzfIlbplt
         9SeQa3ohZHZKcEeB8pn5q2Gtfbcfr3dDn1Xf9JdT2VMEAeQ5yJAWM5riSdvT2IE7CNJz
         J+0w==
X-Gm-Message-State: AOJu0Yxqmi2IFvPfoO8XUG6k8ZNunDiZbDae2hiNDWy7pOLW2iCf3zzK
        8+vEY5/uK3LSlHAwkTYdVc4=
X-Google-Smtp-Source: AGHT+IE3QuqVBr4aCJMDYyvYKHw+JyLDzrnor+iGfuIQ6ebrfAt4WLqaJcccbSgsDEcrLm5MvtD2gA==
X-Received: by 2002:a05:600c:4f86:b0:40a:44aa:bf3a with SMTP id n6-20020a05600c4f8600b0040a44aabf3amr998607wmq.23.1700636022378;
        Tue, 21 Nov 2023 22:53:42 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b00332c6f1beccsm8550295wrf.66.2023.11.21.22.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 22:53:42 -0800 (PST)
Message-ID: <ce8e5446-9fcf-4692-90e5-1c5fa75a880f@kernel.org>
Date:   Wed, 22 Nov 2023 07:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] tty: move locking docs out of Returns for functions
 in tty.h
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-5-jirislaby@kernel.org>
 <e74f4dfb-55f2-f997-6a70-a1b7edd11016@linux.intel.com>
 <bdb4cd62-2d17-4d19-b429-1232ec863456@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <bdb4cd62-2d17-4d19-b429-1232ec863456@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 23, 7:45, Jiri Slaby wrote:
> On 21. 11. 23, 10:48, Ilpo Järvinen wrote:
>> On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:
>>
>>> Both tty_kref_get() and tty_get_baud_rate() note about locking in their
>>> Return kernel-doc clause. Extract this info into a separate "Locking"
>>> paragraph -- the same as we do for other tty functions.
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>   include/linux/tty.h | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/tty.h b/include/linux/tty.h
>>> index 4b6340ac2af2..7625fc98fef3 100644
>>> --- a/include/linux/tty.h
>>> +++ b/include/linux/tty.h
> ...
>>> @@ -436,10 +438,10 @@ void tty_encode_baud_rate(struct tty_struct 
>>> *tty, speed_t ibaud,
>>>    * tty_get_baud_rate - get tty bit rates
>>>    * @tty: tty to query
>>>    *
>>> - * Returns: the baud rate as an integer for this terminal. The 
>>> termios lock
>>> - * must be held by the caller and the terminal bit flags may be 
>>> updated.
>>> + * Returns: the baud rate as an integer for this terminal
>>>    *
>>> - * Locking: none
>>> + * Locking: The termios lock must be held by the caller and the 
>>> terminal bit
>>> + * flags may be updated.
>>
>> I don't think the second part about the flags really belongs here, I'd
>> keep it the description.
> 
> Any idea what does the part says in fact? I had not been thinking about 
> the content and now I don't understand it.

Maybe before:
commit 6865ff222ccab371c04afce17aec1f7d70b17dbc
Author: Jiri Slaby <jirislaby@kernel.org>
Date:   Thu Mar 7 13:12:27 2013 +0100

     TTY: do not warn about setting speed via SPD_*


tty->warned was "the terminal bit".

Let's drop that part. And we can make tty const there too.

> thanks,

-- 
js
suse labs

