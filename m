Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC56877526E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHIGAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjHIGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:00:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F81BFF;
        Tue,  8 Aug 2023 23:00:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so99369191fa.1;
        Tue, 08 Aug 2023 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691560841; x=1692165641;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbxOCcqWFDoEl6SLEqfM/p5RritbhF98JyPQ4sgWJB4=;
        b=MDfPMW4qGuFL2DtitjHrILK6OAtMuBRoULDwBcnMV67AZAIZt7TL6I+/r/is9B5dbA
         s/HpvljSsXkiDJ5hPW9dULV0RvZbpqVrjhjSRDDS9JH10HR9+haEaL7MPN7683eIis/K
         i6SVi2se3su/6l0nJmh9B9xfJ+l6wS9/lVpUdnqoDUDS7Qh2mEr8/uNtFFMTmp36RuJ1
         h/C2av5tv5+dtNp6J2CpNDfg9ZEy7bJKl28WOMfIXYoBuINYE+V41XJ1e7VZqyWHTkT+
         2ZwHfoY9ZFwgTg96vI7kZ29p5fPzMa/ttGxUVSjL+FvOF+gQXiyr3PWmsyZrIZR1mxhB
         82pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560841; x=1692165641;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbxOCcqWFDoEl6SLEqfM/p5RritbhF98JyPQ4sgWJB4=;
        b=AG7uPiCunZvA9SLV+RLV0R/geKdc9o9T2SuevD7WuId2IKhCm+iNOmxR1c5rUetnmF
         vlQWr7C+9Buaahe9REcTI8702aoYhp7iINOpL2BUvPh4p/u/dWkt1VvhMZeUM2V+/hVu
         aV44hDb49LrRHU+aqVHaQJa5xVm2rODCGqLxwmMpjRms9kSG2HVUbZs3pjkwN1frdfwu
         Z1k9cIwLE6qrI5h0mjWuimQ4lL96YEX9Euzz+ScZWfiqJLtEVcel/DXjjlGFLMhWCWzM
         mUO0iLdi20cCI5Tg9P6xCD558LKqXKNx4y5t9wpBqtdlNQ9PNPpQTSYqNmzju3LBUNW1
         vcKw==
X-Gm-Message-State: AOJu0Yye0eSIlqMsSpV2WAU9iU11jO5qjhG2/Zad4qnDEp/4hhaM/H+t
        LDSM9Ks8nX7c6r5C1l1d0qI=
X-Google-Smtp-Source: AGHT+IHCGVQ4nGGIxrTe5wisQH0qK/mzBKULeM9m4jlTfi2dEGMwc0tS4/ORBw9KvmTVPqmeFdAVAg==
X-Received: by 2002:a2e:b0fc:0:b0:2b9:e317:ec4d with SMTP id h28-20020a2eb0fc000000b002b9e317ec4dmr1040829ljl.39.1691560840679;
        Tue, 08 Aug 2023 23:00:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id a20-20020a2eb174000000b002b9e9a8532dsm2531309ljm.138.2023.08.08.23.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 23:00:40 -0700 (PDT)
Message-ID: <d8f84ec0-142d-88d1-c317-acfb8c234bad@gmail.com>
Date:   Wed, 9 Aug 2023 09:00:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20230808164204.66818-1-andriy.shevchenko@linux.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: accel: kionix-kx022a: Use correct header(s)
 instead of string_helpers.h
In-Reply-To: <20230808164204.66818-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 19:42, Andy Shevchenko wrote:
> There is nothing from string_helpers.h used in the driver, correct
> the header inclusion block accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Out of the curiosity - is the goal to get rid of including choices from 
helpers? (I think) then the header split would be more beneficial.

> ---
>   drivers/iio/accel/kionix-kx022a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 4ea3c6718ed4..f164b09520c9 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -15,7 +15,7 @@
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
> -#include <linux/string_helpers.h>
> +#include <linux/string_choices.h>
>   #include <linux/units.h>
>   
>   #include <linux/iio/iio.h>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

