Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BD758078
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjGRPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGRPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:10:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA391;
        Tue, 18 Jul 2023 08:10:13 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so8295894276.1;
        Tue, 18 Jul 2023 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689693012; x=1692285012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8G72SQQvEAGIOu2XhscKjAI4N+s0xdWDLE6O4dTKvKk=;
        b=g4DqZ0Q+wouW6Y3R5ZID3YLkCbFZYL71juAB+/HBwZhw2W9Yo/Y4/x+vuJw1cLXVRj
         cRpQlc6HlMj1rWDxb3tMEajCoKju+eyQPMA3HNO6Vlmm7kslf2OC02xzVVJJZ0vstNtP
         V4mjRwsN1aLC25kK70UTwVYV4SOrmH6g0dQT9OATCAGzc1dr3XDBpgjXfmTEZKqCu31x
         TzKA31kFD27F7GPwccQo8QrVVaaZIPP2Q8w+RU/VmoWkzwoB6V6PUN/pBKgrInXrMaSs
         2+WWMSPxNWNuxgE4cbMhtYJh2BozLzonyJRbp46kiL0aeuxWvqmkSnIjRlA1n9CHpus1
         y8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693012; x=1692285012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G72SQQvEAGIOu2XhscKjAI4N+s0xdWDLE6O4dTKvKk=;
        b=KWvZwo0r0DGdKT/JKGVJvzsvwOyJE1q4UNZ5SFa9MDTeH2EzPlrpAlhyI+0ZV7fopl
         HeUBoWE1A0YsbqNYw9xq/+0ysVZ/JXnasWE1iiOkyefN8YFpi+F6j/BtUKIWe6TSGyMy
         pttDvfBcohoQHI3ULWKGRHJuAfu8DTYJMoC5o5TBs5I8tueP3WI3DhjWncS6EkBBY5QR
         vzNH84ljJxEFut22vlx2O+gksWqnkg+uRzBn84bsZZBu6y1np9TtpJ06nvggHsquJ7Bf
         5KfAyi2eQl+dQVR9qscM1/CDWvZxsR4mHTnQeO2No21Yl4CRzHAo8KFLmAlhZF6CWenA
         njbw==
X-Gm-Message-State: ABy/qLaOW4p8euKH1F0+1CeahB6iBoZVjNt+jNBoZS+kCVhlAiXTiQ+v
        84NlEHvK8C717IuIcV2kfoI=
X-Google-Smtp-Source: APBJJlG5WwOxAX6LI+YUl4h9lmONGulHjCZNZGbmG958hHvkbXtlNVM4SuR3Oa5zU5VzkwpVVMywGA==
X-Received: by 2002:a25:ac66:0:b0:cb8:a812:a91 with SMTP id r38-20020a25ac66000000b00cb8a8120a91mr208402ybd.0.1689693012431;
        Tue, 18 Jul 2023 08:10:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a056902054900b00be8e8772025sm442631ybs.45.2023.07.18.08.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 08:10:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b1528e3d-15f7-7ab2-b803-917f79efe999@roeck-us.net>
Date:   Tue, 18 Jul 2023 08:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-2-henning.schild@siemens.com>
 <ZLafwOPrw+puH+rF@smile.fi.intel.com>
 <20230718164251.13855c47@md1za8fc.ad001.siemens.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230718164251.13855c47@md1za8fc.ad001.siemens.net>
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

On 7/18/23 07:42, Henning Schild wrote:
> Am Tue, 18 Jul 2023 17:20:48 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
>> On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:
>>> If a user did choose to enable Siemens Simatic platform support they
>>> likely want that driver to be enabled without having to flip more
>>> config switches. So we make the watchdog driver config switch
>>> default to the platform driver switches value.
>>
>> A nit-pick below.
>>
>> ...
>>
>>>   config SIEMENS_SIMATIC_IPC_WDT
>>>   	tristate "Siemens Simatic IPC Watchdog"
>>>   	depends on SIEMENS_SIMATIC_IPC
>>
>>> +	default SIEMENS_SIMATIC_IPC
>>
>> It's more natural to group tristate and default, vs. depends and
>> select.
> 
> Will be ignored unless maintainer insists.
> 

Maintainer wants to know why "default SIEMENS_SIMATIC_IPC" is needed
or warranted instead of the much simpler and easier to understand
"default y".

Guenter

