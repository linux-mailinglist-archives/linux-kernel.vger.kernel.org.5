Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98493761B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGYOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjGYOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B12136
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:16:29 -0700 (PDT)
Received: from [IPV6:2a01:e0a:212:79f0:c61e:ae3f:a2:fe43] (unknown [IPv6:2a01:e0a:212:79f0:c61e:ae3f:a2:fe43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B90126600357;
        Tue, 25 Jul 2023 15:16:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690294562;
        bh=8Yx9/u1pnkdZXQC7WxaG0vujP7+zkjx6QBkYxWSjdK4=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=DKA9d51vwnwDR0IWHIyIlJrlyFdB1FrOiuAOkcot4BeSxaJtqlPgUl/j49CZMX3/A
         5RGxUFElafn48CtKEsQ7EQNDfmICbl4PzEEap7kmC+ABnqLuiLd1GCt63dSgKsdkv2
         ICvvh5DNWxCx5TVa3yf0BX93OYISR3MEr5cvqtsCmAc/Rqf/h4FUj7XjmimzpYrQGL
         QXSdGI/HLcR9NCg5OO8iJ5hkZHnLSwOMImVOh1zg5deR/R4CnILOXhK6AdKShH266h
         fM8YSW3WblWH+9+5JSg036PP9cdrW7J21dxZzOm0/rZBtndGGlAMrwZzx3BAhNKUwd
         9WO2k1in5pOGg==
Message-ID: <0623ebc5-eef8-2c93-040f-eeeabc79ce17@collabora.com>
Date:   Tue, 25 Jul 2023 16:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v5 2/2 RESEND] drm: panel: Add novatek nt35596s panel
 driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
References: <20230719152007.197710-1-arnaud.ferraris@collabora.com>
 <20230719152007.197710-3-arnaud.ferraris@collabora.com>
 <CACRpkdZ2Fu8jyyyDd4e1yq8g4bDoj2gCd4KnntST8uYvDNKUZw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACRpkdZ2Fu8jyyyDd4e1yq8g4bDoj2gCd4KnntST8uYvDNKUZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Le 23/07/2023 à 18:45, Linus Walleij a écrit :
> Hi Arnaud & Molly,
>
> overall the driver looks very good!
>
> On Wed, Jul 19, 2023 at 5:20 PM Arnaud Ferraris
> <arnaud.ferraris@collabora.com>  wrote:
>
>> From: Molly Sophia<mollysophia379@gmail.com>
>>
>> Novatek NT35596s is a generic DSI IC that drives command and video mode
>> panels. Add the driver for it. Currently add support for the LCD panel
>> from JDI connected with this IC, as found on Xiaomi Mi Mix2s phones.
>>
>> Signed-off-by: Molly Sophia<mollysophia379@gmail.com>
>> Signed-off-by: Arnaud Ferraris<arnaud.ferraris@collabora.com>
> (...)
>
>>   .../gpu/drm/panel/panel-novatek-nt36672a.c    | 251 ++++++++++++++++--
> So are you sure the nt35596s panel driver is so similar to nt36672a that
> they should share the same driver?
> With all the magic number sequences I'm not so sure, do they really share
> any of the magic numbers?

Their magic number sequences are quite different, however all the other 
bits (power/reset sequences and timings) fit in, which isn't the case of 
the other novatek panel drivers. Moreover, they have similar (although 
not identical) resolutions.

> If not, consider creating a new driver, and then base it on the
> nt35510 instead.

I would gladly make this a new driver, but I'd rather base it on the 
nt36672a for the reasons mentioned above. I do fear, however, that this 
would lead to unnecessary code duplication, as 90% of the driver (magic 
number sequences excluded) would be identical to the nt36672a (and to be 
fully honest, I don't think I have the needed knowledge to make it 
"better").

>> +static const struct nt36672a_panel_cmd jdi_nt35596s_video_on_cmds[] = {
>> +       { .data = { 0xff, 0x24 } },
>> +       { .data = { 0x9d, 0x34 } },
> (...)
>
> These are never nice. Do you have a datasheet so you can provide
> defines for the magic hex values?

I found an old (2012) datasheet for the NT35596 (without the final "S") 
which is marked "Draft", so I'm really unsure this will be enough to 
make sense of those numbers.

> The construction with these .data seqence array
> should be replaces with some open coded sequences
> I feel, bit this pattern is already in the driver so I guess it's OK.
> Yours,
> Linus Walleij

Cheers,
Arnaud
