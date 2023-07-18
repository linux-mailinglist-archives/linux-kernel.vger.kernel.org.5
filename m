Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9E757599
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGRHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGRHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:44:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EC18C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:44:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso49576055e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689666271; x=1692258271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HE+Oix7TpLVk1HmTfb4ABzqg7vkmtJM2h4JGp2urH0=;
        b=J8RUGAcUcigaAJQXgqRjsDIrBHp2ntqz7wavjEbkn3knygg9ahwPeGqkNBIYcKfIDw
         fL8btNa0oGfzo8Wv0ctTFMxbSoZprK+7GI5jjy6dZ8vj7Fq2z0ENcYR8y7jcIs+5fZcm
         x4ZaWAFMpcSPWGOD79eidsUaPp9oO4HB87zzV/pzYCp0B9aya3lOkowPk/Qs4M4xR0WM
         z8s3V7B+5+sX1hK+F70JTfQaI72EQ3JCkFdAdLAZhJASFHZ5UeVoYokXe2ZiV+0v2Cmv
         zbXa+KZtBNM9PYh9OHZHVpX7IiWZ7Ap0/XfTV4pl0DYd8Smx1VR/437BOdY4e987lKJ5
         n4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666271; x=1692258271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HE+Oix7TpLVk1HmTfb4ABzqg7vkmtJM2h4JGp2urH0=;
        b=DiStjTpCHjzY24TY/kNBHi+97MNrq8/5qxlfVnCfuRhXI2tX0JraObx9ygrIrVVXs5
         rhX1bD3pWHjBS/MZSUu33olB6SJ5UbcLw0pbyYBevvN+0ZbaXSrH5/PS5PTwxlxZmbFz
         kw+9OP56ADVCi909DycPDJn/5H6vJ91iUii1wQz1aBzEx6OC6ASWQfEviXFjj3TU4mbe
         sBIcPUQJLG7+Gt9HKwmBgXBdxIcK7XoykNuDMBUClaR/QqdVKxyddkMaqWdzVjQ083cu
         hzmu/JoCnARTRL+26faxi1rwrPiAoWp//+E0NqwU2ULeyG6eXo0nRi8wEZTspvHIVycN
         +zgQ==
X-Gm-Message-State: ABy/qLbHsly6yHpUu0wuy6fxhKUryFWgErf6H/VRsPaEJjVM/nui9T3H
        gYo9SBlnpLMOOWxNwBNE/1k/3w==
X-Google-Smtp-Source: APBJJlEC+GZ2Wuo773tHd6/PokbpabY/9JONiWrESJsgr8zMIvZ0NtmsY30tsNx+iLjwk/w+wQE32A==
X-Received: by 2002:a1c:7212:0:b0:3fb:afc0:56c5 with SMTP id n18-20020a1c7212000000b003fbafc056c5mr1232534wmc.12.1689666271265;
        Tue, 18 Jul 2023 00:44:31 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003fb225d414fsm9518654wmi.21.2023.07.18.00.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:44:30 -0700 (PDT)
Message-ID: <2d71326c-023e-69af-9337-62672f50fed9@linaro.org>
Date:   Tue, 18 Jul 2023 08:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
 <0525440a652854a2a575256cd07d3559@walle.cc>
 <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
 <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 07:25, Michael Walle wrote:
> Hi,
> 
>>>> while here try, using INFO with INFO(0xef4018, 0, 0, 0), those
>>>> parameters shall be discovered at run-time, so we prepare to get rid of
>>>> explicitly setting them sooner or later.
>>>
>>> This is an entry matching various flash families from Winbond, see my
>>> reply in v1. I'm not sure we should remove these as we could break the
>>> older ones, which might or might not have SFDP tables. We don't know.
>>
>> I'd take the risk and break the older ones if there are some that don't
>> define SFDP indeed, just to handle the conflict properly. We can't
>> encourage code based on assumptions otherwise we'll get back to the
>> knotted spi-nor code that we tried to untie in the last years.
> 
> Wait a minute, now I'm the more conservative one of the both of
> us? (:

;)

> 
> Jokes aside, basically you are saying that if there are two flashes
> with the same id, one supports JEDEC one doesn't, we can brake the
> latter one.

I say I don't want to suffocate the code based on assumptions and I'm ready
to take the risk and break some presumably old flashes that don't support
SFDP. If we know for sure that we break old variants of this flash ID,
then we have to rework the core now. Otherwise I'll rework it when a bug
is reported.

> 
>>>>> -        NO_SFDP_FLAGS(SECT_4K) },
>>>
>>> Thus, I'd also keep this one.
>>>
>>
>> Keeping this one does not have the effect that you want as SECT_4K is
>> used in spi_nor_no_sfdp_init_params() which is not called when
>> PARSE_SFDP is set, which makes perfectly sense. Let's drop this and if
>> bugs will be reported, I commit I'll fix them in the same release cycle.
> 
> Mhh, I should have been more curious to why Linus needed the PARSE_SFDP
> flag in the first place. Taking a closer look, that is because in the
> legacy behavior, the SFDP is only read if the chip supports dual or
> quad read (whatever the rationale was for that).

dual or quad reads are params that could be discovered in the first version of
SFDP, that why they associated them with reading SFDP. Not great, but it
worked.

> 
> Also, if PARSE_SFDP is set, none of the no_sfdp_flags are ever handled.
> If the chip doesn't support the SFDP is will just fail probing.
> 
> As I'm reading the code right now, for the new behavior
> it is either
>  * expect the flash supports SFDP, if not, probe fails
>  * expect the flash to don't support SFDP, no SFDP is ever read at all
> 

sort of. It's more elaborate than that. Check spi_nor_init_params().
> Shouldn't we handle the third case in the new behavior, too:
>  * start with the static data we have and try reading SFDP to amend/correct it.

This case is already supported and it's the old way of initializing flash
parameters. Check spi_nor_init_params_deprecated().

I don't want to do that for the SFDP capable flashes for now, otherwise
we'll have again parameters initialized all over the place, which results
in ugly hard to read code. You have the fixup hooks if you need to amend SFDP
data. And since the first table of SFDP is mandatory (BFPT), if you set PARSE_SFDP
and get an error, then you shouldn't have set PARSE_SFDP in the first place.
Optional SFDP tables return void and we have a rollback mechanism for the parameters
set in those optional tables in case of errors.

> 
> If not, will you accept breakage for future flashes, too? Looking at winbond.c
> for example, I guess all chips with 0xef40.. 0xef50.. and 0xef60.. supports
> SFDP nowadays and most of them only have SECT_4K set.

I will. Note that you have to actually have a physical flash to do changes,
I don't queue untested patches.
> 
>> If both of you agree, I'll amend Linus's v4 patch when applying.
> 
> So it would be the first chip without flags at all? Then we could
> drop the entry entirely :) And if we do this, then we should also

No, you have the locking flags that can't be discovered by parsing SFDP,
thus you need to define a flash entry for it.

> drop all the other entries for the newer winbond flashes.

If you can test it, and there's no dedicated compatible for that flash,
I'm ok to drop them.
> 
> If you decide to break older flashes, then I'd prefer to also drop
> the n_sectors and sector_size, i.e. INFO(0xef...., 0, 0, 0).
> 

Isn't v4 already doing this? I'll amend it if not. Waiting for ack from
both you and Linus.

Cheers,
ta
