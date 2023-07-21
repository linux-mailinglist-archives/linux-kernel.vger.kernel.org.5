Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303575D070
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGURQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGURQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:16:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1602D7B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:16:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9924ac01f98so341453566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689959772; x=1690564572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TheVL5v7h1oU6uewYQYbXyMT32QmeTiVrAkQKUeq3w=;
        b=AXG7XTT8Zv7VRe/X+kgai4M7oUendmdC6/9N24UNlMJQ3IQWp5DZBvdOVbfKfnrpJv
         dU+R9tFAIOhAkbNID+M238BE6zXP4HQezRztKQ5VVe8s++qFvuB9BMAe7Sh8tDqLx2f2
         QocdkOVbekf43MCwyvZDt+pGZnaxfut8yacllEH1fW1ikiuq6im/gXIyN9oziK5s1PqV
         8D7fo4VuBwD4bD5yuS6sS29r81Eu/DiGEUlKUtZmXeIbWT0u3HQ7p4e7FnutJgpttw2I
         G0wTfzCKCxRxNS3rkHR2RADZ1PeKh1RQWPnuwMAl/en2NS2PYVuGqJ+TBFX5+vJBRX87
         Vn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959772; x=1690564572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TheVL5v7h1oU6uewYQYbXyMT32QmeTiVrAkQKUeq3w=;
        b=EPE3MQ5AoZZz2/jVGGb1sKc35A1CLStHx5LuSFWjwRcLCwYx+JdN76QLDw5xQjibOx
         LgcaQKxF7wrJLwVv2+iDTP55SJWtYTrm2Ub9FHE92/BpCs8tg5mO3PUX2M0OK7xWRNYX
         xFydrnOyOa+yZQ5foOREETKHKfVpaqxvSZ0dpYfgGcG0uMjElz4jtaQsEDibTdKMDNG0
         djaU+yvw6mLc6/xMEoY+VOkIei7Z+b7KvTGq2pu51fAE+8G7fmn5Bx6Dtdyn2Dh6uusY
         ebv1k7/RcbJ1zAw0BwlKMxW+arZnOcTC7mqZP/Hh544z/LN7xsMaww/BgsJWv0hy0eSm
         izlQ==
X-Gm-Message-State: ABy/qLbaRgvACYugr+/k0FcNIsDvl8rR6OxELVsM9mVerJXgD4khSOhq
        zSo4vvLnP0ZPV1znxdEs8Vo=
X-Google-Smtp-Source: APBJJlHSsKhgQOQoCDZFvkCCfRrfz/wk6KngN2wtE9SP0wN+0LFNRFofTpxAau4jKXFnPiN5cKqtZQ==
X-Received: by 2002:a17:906:10db:b0:993:e860:f20 with SMTP id v27-20020a17090610db00b00993e8600f20mr2495418ejv.19.1689959772157;
        Fri, 21 Jul 2023 10:16:12 -0700 (PDT)
Received: from [10.4.145.3] (83.10.92.232.ipv4.supernova.orange.pl. [83.10.92.232])
        by smtp.gmail.com with ESMTPSA id si1-20020a170906cec100b00992d70f8078sm2456202ejb.106.2023.07.21.10.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 10:16:11 -0700 (PDT)
Message-ID: <b1370c4b-7bad-4aac-0fa7-32d6479aa255@gmail.com>
Date:   Fri, 21 Jul 2023 19:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Add DMI definition for
 post-Skylake machines running custom Coreboot builds
Content-Language: en-GB
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, robbarnes@google.com,
        lalithkraj@google.com, rrangel@chromium.org, bleung@chromium.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev
References: <ZLm3G5G6/gmLZwkn@tora> <ZLooCXV11JCdWOdK@google.com>
From:   Alicja Michalska <ahplka19@gmail.com>
In-Reply-To: <ZLooCXV11JCdWOdK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feedback.

I've explained the reason behind adding this patch, but we'll go with 
different approach next time around.

Since we're discussing this, I would like to suggest removal of DMI 
matches for EOL machines from lines 503...535 (Link, Samus, Peppy, Glimmer).

Those machines aren't supported by Google anymore. Patch I suggested 
will match DMI while running custom firmware.

If maintainers are okay with it, I will submit a patch removing DMI 
matches for stock firmware running on those machines since it's not 
needed anymore.

On 21/07/2023 08:39, Tzung-Bi Shih wrote:
> On Fri, Jul 21, 2023 at 12:37:15AM +0200, Alicja Michalska wrote:
>> ChromeOS EC LPC lacks DMI match for newer machines, which
>> use "Google" DMI_SYS_VENDOR as opposed to "GOOGLE" in older models.
> 
> I'm confused about the sentence as it looks irrelevant to the patch.
> 
>> This patch adds DMI definition for MrChomebox's custom Coreboots builds,
>> which we (Chrultrabook Project) are using.
> 
> s/This patch adds/Add/.  Search "imperative mood" in [1].
> 
> Looks like a typo: s/MrChomebox/MrChromebox/.
> 
> If you get chance to send next version, please shorten the commit title.
> I guess "platform/chrome: cros_ec_lpc: Add DMI match for MrChromebox" should
> be quite explicit.
> 
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
>> +	/* DMI doesn't match modern machines running custom firmware */
> 
> Remove the line.
> 
>> +	{
>> +		/* MrChromebox's firmware */
>> +		.matches = {
>> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
>> +			DMI_MATCH(DMI_BIOS_VERSION, "MrChromebox-"),
>> +		},
>> +	},
> 
> Put the block after "A small number of non-Chromebook/box machines also use
> the ChromeOS EC"[2].
> 
> [2]: https://elixir.bootlin.com/linux/v6.4/source/drivers/platform/chrome/cros_ec_lpc.c#L533
