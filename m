Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7D7D6A20
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjJYL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYL3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:29:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7A10A;
        Wed, 25 Oct 2023 04:29:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34B9766071C9;
        Wed, 25 Oct 2023 12:29:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698233348;
        bh=YcIUG+bFG3gCP/KGT755SKLbRpNGiug2TGJ8Qy80gUA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aAfy4Taoi7eEhWJhC0q5SXJZ6OWE+V4gv4d7aT6Ge/Roi5iW8GZvhJzVM0rO7hjtb
         JtZPD7oPTYddIwZ7+EhBn/b/D48b/05qyX8kI3vVAtRtbn3ZZFKzMlWRcETrqmJeHq
         M/ZqnMeOWCOmdNxN+4wVA7NuYugeYveW/TmbkoibFU3D675qvpeTK6VFQiAr/58jl4
         Yq2+v8bEWgufMNBSdpIE3L2qUQrnu5pLz7E5NnZEGZuocWpcQwprwrv2oOM7s049La
         240tPMxBQPDCROAJZNkUxnlXE1oVjlOTTtKT//ea/3D6mKtMBis43FF20Uh7hoRNt8
         7wyGG/inj3fEQ==
Message-ID: <eb4f7d6e-0e4c-4b2d-b889-cad9fc9262d8@collabora.com>
Date:   Wed, 25 Oct 2023 13:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
Content-Language: en-US
To:     =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
 <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
 <CAGXv+5EpBLnXVdxnk9wBZi5F7U5wdJRfYH7fgg4Lkr1HJXm+WA@mail.gmail.com>
 <9c1e10b56db315e03daa3df5918cde844297c680.camel@mediatek.com>
 <CAGXv+5HQ2sVx=F3my2jOGMw3j3pU2aarEg+Dj1XgNzwio98ezA@mail.gmail.com>
 <e049985de9da9958ba425824ab5f38c7cf41025b.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e049985de9da9958ba425824ab5f38c7cf41025b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/23 11:50, Yu-chang Lee (李禹璋) ha scritto:
> On Tue, 2023-10-24 at 17:20 +0800, Chen-Yu Tsai wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On Tue, Oct 24, 2023 at 3:47 PM Yu-chang Lee (李禹璋)
>> <Yu-chang.Lee@mediatek.com> wrote:
>>>
>>> On Tue, 2023-10-24 at 10:58 +0800, Chen-Yu Tsai wrote:
>>>> On Tue, Oct 24, 2023 at 10:52 AM Stephen Boyd <sboyd@kernel.org>
>>>> wrote:
>>>>>
>>>>> Quoting Chen-Yu Tsai (2023-10-19 22:06:35)
>>>>>> On Thu, Oct 19, 2023 at 8:49 PM AngeloGioacchino Del Regno
>>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>>
>>>>>>> Fix the parenting of clocks imp_iic_wrap_ap_clock_i2c{4-6},
>> as
>>>>>>> those
>>>>>>> are effectively parented to infra_ao_i2c{4-6} and not to
>> the
>>>>>>> I2C_AP.
>>>>>>> This permits the correct (and full) enablement and
>> disablement
>>>>>>> of the
>>>>>>> I2C4, I2C5 and I2C6 bus clocks, satisfying the whole clock
>> tree
>>>>>>> of
>>>>>>> those.
>>>>>>>
>>>>>>> As an example, when requesting to enable
>>>>>>> imp_iic_wrap_ap_clock_i2c4:
>>>>>>>
>>>>>>> Before: infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c4
>>>>>>> After:  infra_ao_i2c_ap -> infra_ao_i2c4 ->
>>>>>>> imp_iic_wrap_ap_clock_i2c4
>>>>>>>
>>>>>>> Fixes: 66cd0b4b0ce5 ("clk: mediatek: Add MT8186 imp i2c
>> wrapper
>>>>>>> clock support")
>>>>>>> Signed-off-by: AngeloGioacchino Del Regno <
>>>>>>> angelogioacchino.delregno@collabora.com>
>>>>>>
>>>>>> I'm curious about what led to discovering this error?
>>>>>>
>>>>>
>>>>> Is that an acked-by?
>>>>
>>>> MediaTek engineers are saying the original code already matches
>> the
>>>> documentation provided by their hardware engineers. I'm trying to
>> get
>>>> them to respond on the mailing list.
>>>>
>>>> ChenYu
>>>>
>>> After checking with I2C clock hardware designer there is no
>>> infra_ao_i2c{4-6} clock gate in between. And the clock document at
>> hand
>>> aslo shows the same result. Generallly speaking, we would like to
>> keep
>>> sw setting align with the hardware design document. I would
>> recommand
>>> not to change this part of code, but enable infra_ao_i2c{4-6} prior
>> to
>>> the usage of imp_iic_wrap_ap_clock_i2c clock.
>>
>> Are infra_ao_i2c{4-6} actually used by the hardware? If so, for what
>> purpose?
> 
> According to hardware designer it servers no purpose. Just a legacy of
> previous design...
> 
>> If it is actually needed by the hardware and it is not in the
>> existing path,
>> then it needs to be described in the device tree and handled by the
>> driver.
>>
>> ChenYu
> 
> After reviewing hardware design diagram, hardware designer concludes
> that the clock tree is indeed
> 
> top_i2c -> infra_ao_i2c{4-6}
> top_i2c -> infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c{4-6}
> 
> so I think we should keep this clock relation unchanged.
> 
> Thanks
> YuChang
> 

Can you please also expand on CLK_INFRA_AO_I2C{1,2,5}_ARBITER clocks?
Is the I2C arbiter also legacy of previous designs?

Please check [1], as I've sent a commit adding those in the devicetree.

Thanks,
Angelo

[1]: 
https://lore.kernel.org/all/20231020075540.15191-1-angelogioacchino.delregno@collabora.com/
