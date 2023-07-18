Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E7757247
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGRD0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGRD0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:26:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105522701
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:24:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso51932225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689650638; x=1692242638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Yaw/su3dm4lGxJq+uDwrFmIvx/782XRsFqzx0jPx1s=;
        b=IOuykNH0+ZMFFZ7k3TlbVOJ/Pa6tE/WgWM+W0l7P09FJuYempieSJwdlPHh9K3znTF
         /3XE0ajAJ0H8RM2IfRskU7qmPxnjl9VFq+QEoL676a5BXTLgAeSgZvb8IU0zBjnLaZyz
         Tt3gIgXCmdic49WDgEuzmzl/pAP7xL58jO/7NOqaLg6z1WN0y8TPR5Z7CvIPz1Opt7JC
         DKeAkPBUXp9TMCFbbDNMK3VKB2+Ir1OQ588YHIcdIDehW71lzT5hszK5YsQbtd8SlmJt
         t44GnfFbTFzBHBBXcK+czgSZSIOcGj/3Jq/Cl98VsK5OYGS62Gvjupd4vlFMTYLZmGm1
         UlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650638; x=1692242638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yaw/su3dm4lGxJq+uDwrFmIvx/782XRsFqzx0jPx1s=;
        b=j1DyndjEPhiweXZhlEdGFMWHh9RpcUIxN1eiJOyC2dG5McSmhHv+CO6MLmnD/2oa8O
         26ogNnw5d9WOXQ/E7P08HNYcxRMCLfvLzWwv9vc+UQ28+s9u0hazGW+peWuGEgYrF3nc
         to4CIRigY9ggC3ZKO1fKkKEpeSprW/Zi6v8QJUXBLp/OoiumYeLgrcJ0DcIoI27rw6iR
         dFWFBNX63lLtUg7lQfOMrQ72rZ6pwa6oicBugR/PWNs0SPi5Di5jAcBH3SbsPPFFzy2t
         0fzOXQwCHjTVfTg37h84EoOBn39marFu6pZbcnIZv4Qi+Kh9cfEhm8LpRIuYaF8wRFuA
         1FOQ==
X-Gm-Message-State: ABy/qLby9o8bFHpoghhgob7vqv2wqzz0tl4q197KnXx0DusMSgmHVOqP
        A0OqBMZXyHzpyqMXQY6oPObd7Q==
X-Google-Smtp-Source: APBJJlEMo+94zfYvjjd0ST7tSjDvYxqx+bPRJDBcTj1MpaxD5e0ocYFgQRm385+XmJ39W4C80uucLg==
X-Received: by 2002:a1c:e90d:0:b0:3fc:524:e80a with SMTP id q13-20020a1ce90d000000b003fc0524e80amr776137wmc.18.1689650638531;
        Mon, 17 Jul 2023 20:23:58 -0700 (PDT)
Received: from [192.168.2.173] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bce11000000b003fc07e17d4esm9223656wmc.2.2023.07.17.20.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 20:23:58 -0700 (PDT)
Message-ID: <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
Date:   Tue, 18 Jul 2023 06:23:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
 <0525440a652854a2a575256cd07d3559@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <0525440a652854a2a575256cd07d3559@walle.cc>
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



On 13.07.2023 10:01, Michael Walle wrote:
> Hi,
> 
> Am 2023-07-13 05:32, schrieb Tudor Ambarus:
>> Hi, Linus,
>>
>> On 13.07.2023 00:59, Linus Walleij wrote:
>>> The Winbond "w25q128" (actual vendor name W25Q128JV)
>>> has exactly the same flags as the sibling device
>>> "w25q128jv". The devices both require unlocking to
>>> enable write access.
>>>
>>> The actual product naming between devices vs the
>>> Linux strings in winbond.c:
>>>
>>> 0xef4018: "w25q128"   W25Q128JV-IM/JM
>>> 0xef7018: "w25q128jv" W25Q128JV-IN/IQ/JQ
>>>
>>> The latter device, "w25q128jv" supports features
>>> named DTQ and QPI, otherwise it is the same.
>>>
>>> Not having the right flags has the annoying side
>>> effect that write access does not work.
>>
>> I guess you refer to the locking flags. Probably your flash has the non
>> volatile block protection (BP) bits from the Status Register set, which
>> means the entire flash is write protected. The factory default for these
>> bits is 0/disabled on this flash so someone must have played with them.
>> The reason why one may want write protection set is to avoid inadvertent
>> writes during power-up.
>> One can control whether to disable the software write protection at boot
>> time with the MTD_SPI_NOR_SWP_ configs.
>>>
>>> After this patch I can write to the flash on the
>>> Inteno XG6846 router.
>>>
>>> The flash memory also supports dual and quad SPI
>>> modes. This does not currently manifest, but by
>>
>> The fasted mode is chosen after SFDP parsing, so you should use quad
>> reads if your controller also supports 4 I/O lines.
>>> turning on SFDP parsing, the right SPI modes are
>>> emitted in
>>> /sys/kernel/debug/spi-nor/spi1.0/capabilities
>>> for this chip, so we also turn on this.
>>>
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Michael Walle <michael@walle.cc>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> Changes in v2:
>>> - Only add the write access flags.
>>> - Use SFDP parsing to properly detect the various
>>>   available SPI modes.
>>> - Link to v1:
>>> https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org
>>> ---
>>>  drivers/mtd/spi-nor/winbond.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/winbond.c
>>> b/drivers/mtd/spi-nor/winbond.c
>>> index 834d6ba5ce70..6c82e525c801 100644
>>> --- a/drivers/mtd/spi-nor/winbond.c
>>> +++ b/drivers/mtd/spi-nor/winbond.c
>>> @@ -121,7 +121,8 @@ static const struct flash_info
>>> winbond_nor_parts[] = {
>>>      { "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
>>>          NO_SFDP_FLAGS(SECT_4K) },
>>>      { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
>>
>> while here try, using INFO with INFO(0xef4018, 0, 0, 0), those
>> parameters shall be discovered at run-time, so we prepare to get rid of
>> explicitly setting them sooner or later.
> 
> This is an entry matching various flash families from Winbond, see my
> reply in v1. I'm not sure we should remove these as we could break the
> older ones, which might or might not have SFDP tables. We don't know.

I'd take the risk and break the older ones if there are some that don't
define SFDP indeed, just to handle the conflict properly. We can't
encourage code based on assumptions otherwise we'll get back to the
knotted spi-nor code that we tried to untie in the last years.

> 
>>
>>> -        NO_SFDP_FLAGS(SECT_4K) },
> 
> Thus, I'd also keep this one.
> 

Keeping this one does not have the effect that you want as SECT_4K is
used in spi_nor_no_sfdp_init_params() which is not called when
PARSE_SFDP is set, which makes perfectly sense. Let's drop this and if
bugs will be reported, I commit I'll fix them in the same release cycle.

If both of you agree, I'll amend Linus's v4 patch when applying.

Cheers,
ta

