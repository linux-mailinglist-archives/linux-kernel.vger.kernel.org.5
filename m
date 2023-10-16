Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AE37CA823
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJPMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:39:33 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0B9B;
        Mon, 16 Oct 2023 05:39:31 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4066241289bso45974305e9.0;
        Mon, 16 Oct 2023 05:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459970; x=1698064770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWn8OKKmgH1SLqX3IBNKtZAxHwSFanLzmHjQ4o8BFLI=;
        b=kfrEQVDGXKbM0nezsHfuSwwffQqbR8cvh65MvElsnYrEoIDoZ3HkO5p7OTXlnL7QO7
         vlnwV37E07UsQhldzwTdqveylwZ25mZHvy7UjM9VK3oMhDo7LN9qVsFcQAEpi6nHngVg
         XRMD5S8Lvn2PLVRdyIaGTaPu+lwWHmjP5rUB4D9HlHSWUfeoFvv7i7YGxUO3gzhxjVfi
         U4+l7yxiD6sfDD0pUb7hmPUH7neExpQMC6VjeZEdMppVycFg1divkdSF6nhqATD2clKz
         j7Ejjx4W6p79RZS1GIWIDJFoVI/8RV6azBWhEQ5Cj3r1K2AGd3dvvsIzGr7+/DSyvi5S
         fKnw==
X-Gm-Message-State: AOJu0YyTbHpAZQ+kmY8yrNVlojvNDpVBHJeFkuaLj1c2Kj2/xy6D8XNv
        /aU0HOnzs/8ujaxmr3ac0lJIDVVU0jFeiA==
X-Google-Smtp-Source: AGHT+IFXjdSjOK6JR2Ain6tAFdG0oAEw3Sl7ExLj4KHQXnDZh4Js4y3DUPj0hTlMTEHBKwY5v+tMsA==
X-Received: by 2002:a05:600c:230d:b0:407:5b54:bb13 with SMTP id 13-20020a05600c230d00b004075b54bb13mr14407628wmo.37.1697459969365;
        Mon, 16 Oct 2023 05:39:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c510300b004065d67c3c9sm7196660wms.8.2023.10.16.05.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:39:29 -0700 (PDT)
Message-ID: <af95fcfc-0fb4-4915-9001-3ff6439e5384@kernel.org>
Date:   Mon, 16 Oct 2023 14:39:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] trigger: ledtrig-tty: move variable definition to
 the top
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, m.brock@vanmierlo.com
Cc:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, kabel@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20231016071332.597654-1-fe@dev.tdt.de>
 <20231016071332.597654-4-fe@dev.tdt.de>
 <93dcb9f6f218593084f834ba6b450999@vanmierlo.com>
 <34e8fcd94b4a959fe2336485e4722c3b@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <34e8fcd94b4a959fe2336485e4722c3b@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 10. 23, 11:12, Florian Eckert wrote:
> 
> 
> On 2023-10-16 10:46, m.brock@vanmierlo.com wrote:
>> Florian Eckert wrote on 2023-10-16 09:13:
>>> Has complained about the following construct:
>>
>> Who is "Has" or who/what has complained?
> 
> The test robot who does not agree with my change in the v1 patchset.

Well, you should have put subject to that sentence, so that we can 
understand. And not to parse "Has" as a tool/person name ;).

>>> drivers/leds/trigger/ledtrig-tty.c:362:3: error: a label can only be
>>> part of a statement and a declaration is not a statement
>>>
>>> Hence move the variable definition to the beginning of the function.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes:
>>> https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/
>>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>>> ---
>>> @@ -124,8 +125,6 @@ static void ledtrig_tty_work(struct work_struct 
>>> *work)
>>>
>>>      if (icount.rx != trigger_data->rx ||
>>>          icount.tx != trigger_data->tx) {
>>> -        unsigned long interval = LEDTRIG_TTY_INTERVAL;
>>> -
>>
>> Is this kernel test robot broken?
> 
> The test robot does nothing wrong.
> 
>> I see no label definition here.

case is a label.

>> And this variable declaration is at the start of a new block which 
>> does not
>> even require C99 support.

Nah. The block begins after the switch.
So
"""
switch (X) {
type var;
case X:
}
would work. Moving the def after case is no longer at the block beginning.

So just wrap put the case code in a block like we are used to:
"""
case X: {
   type var;
}
""".

regards,
-- 
js
suse labs

