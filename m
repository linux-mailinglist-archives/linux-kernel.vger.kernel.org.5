Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBECA75FEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGXSEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGXSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:04:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34287E49
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:04:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 933285C0163;
        Mon, 24 Jul 2023 14:04:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Jul 2023 14:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690221883; x=1690308283; bh=W1IOgxn7P+BFYVG803IwgCp4NMVbrQ5YoLe
        yU6Y7q+E=; b=Hihf4ck/OcL7AkJ203uqW5V5iV+CM2uQe9+4oLLtehpQGHZfoOw
        U9vAkNRMIZaSmbbJqmsTQUAo+mjiJm5mo22RIeBSW6OUmLQ7BASc7wAYNFnZb5KS
        XQpLGqJYJ8hWEqFfa0E5uq/kP+LzWoeoaAu0Xu9FJ/qjvH2P3XPvG5mfoVQfCBav
        fFfilONcNiotKjv4KcU3/JoZX7+ppFabwyShc9gYiDoyBovGwaUckU10lYuEuXTf
        31JEQBcKSHnBmLyeOUN7fwjfjR1MUlwOMaOLjHWf4LAt1XsBsHXJfxC4KLm3d1px
        JI2tZrZaVYN3GBTMORj4UpsVoTeXlYk8z9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690221883; x=1690308283; bh=W1IOgxn7P+BFYVG803IwgCp4NMVbrQ5YoLe
        yU6Y7q+E=; b=BG+lJ/+CsQWYqzw5derQ43VP4lMl8jyjqIv+FWMfmHN/yRUQJ2h
        KFnKBQwA2A2+tApWwyMoWNge+754Vxb6T+vP8hOGEK3D8oJbBYQ/3mB0YSTEsanW
        BkvAvfWE8gabua/bTP5VEfACmRHtn2f9nJDTKdabBSmgB+OefHMTK2oMgETHnjhd
        +18kKjxkNAmtgHn+a66NvcHAj0O3217WNwDMr8bgTD4Inhi9kdaqJH5MqmI+de7Z
        86MAtB3XVaaBPYdpXdw/V+Z+bU6omubfMo90hIZX6ZqllTLDrYImuE2/hzq4AH52
        w7up5TJ9L9Fwzo9OgDPuwkImadqncsKlE3A==
X-ME-Sender: <xms:Or2-ZEXRsebBkhpjaTZeJcrFle-x093J5aKiSntpgqzl11c6bF2C3w>
    <xme:Or2-ZIk0TAUVzwAZM9BadsESEAo-1AdjpI2A6paJBV_ZDGsfoArkXZaHrn_smYljB
    nLZ_frSlBxizxXHNWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Or2-ZIbMUezXXeBHXrOUQVDP6RK9WT0X9QfPCzkrPqR2kTX82AAWPg>
    <xmx:Or2-ZDXl_yCYtXSWYDyNYbjmEb6AZpqWswOT3LDczOooF459eGZnow>
    <xmx:Or2-ZOn5AXRNhNce2WJe_5jbr7mvvcDMAVFLnss1j2mnQE3ryR9sBQ>
    <xmx:O72-ZFtgZfCpNhCUo_KWLvU7PfFHDotKeq-SIGYs6EBpTGX5k2yFLA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3BE66B60089; Mon, 24 Jul 2023 14:04:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <9b51bd0a-271a-4830-9422-89ad853a67b6@app.fastmail.com>
In-Reply-To: <886e29ec-a290-993a-d99a-d5fd90662e99@linaro.org>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
 <0ec81b89-4d4c-4e13-5ea0-697f5c0af835@linaro.org>
 <4073daf401a820c0f64e6fa813b5253bd0427bcd.camel@maquefel.me>
 <886e29ec-a290-993a-d99a-d5fd90662e99@linaro.org>
Date:   Mon, 24 Jul 2023 20:04:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Nikita Shubin" <nikita.shubin@maquefel.me>,
        "Andy Shevchenko" <andy@kernel.org>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Michael Peters" <mpeters@embeddedTS.com>,
        "Kris Bahnsen" <kris@embeddedTS.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023, at 18:31, Krzysztof Kozlowski wrote:
> On 24/07/2023 17:02, Nikita Shubin wrote:
>>>
>>> There is no even need for this, because this code does not use it!
>>=20
>> It's a little emotional, so i can hardly understand the exact reason =
of
>> dissatisfaction.
>>=20
>> Are you against usage of EXPORT_SYMBOL_NS_GPL ? - then indeed my fault
>> it's not needed as both PINCTRL and CLK (the only users of this code)
>> can't be built as modules.
>
> I am against any exported symbols and most of functions visible outside
> of this driver.

I think it's a reasonable compromise here, this all ancient code
and we don't need to rewrite all of it as part of the DT conversion,
even if we would do it differently for a new platform.

I really just want to merge the series before Nikita runs out
of motivation to finish the work, after having done almost all
of it.

>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("EP93xx SoC revi=
sion %s\n", attrs->revision);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>>>> +}
>>>> +core_initcall(ep93xx_soc_init);
>>>
>>> That's not the way to add soc driver. You need a proper driver for it
>>=20
>> What is a proper driver for these ?=C2=A0
>
> Usually platform_driver, e.g. exynos-chipid.

Using a platform driver sounds like the right thing to do here,
it's cleaner and should not be hard to do if the driver just matches
the cirrus,ep9301-syscon node. I would have just merged
the v3 version, but this is something that makes sense changing
in v4.

>> Even the latest additions in drivers/soc/* go with *_initcall.
>
> Which one? Ones which call platform_driver_register()? That's quite
> different story, isn't it? I don't see other recent cases, except
> regulator couplers. They might be, some people send and accept poor
> code, so what do you expect from us? Crappy code got in once, so more =
of
> it can go?

That's not what is happening here, this is all part of an incremental
improvement of the existing code. If the DT bindings make sense, I'm
happy to take some shortcuts with the implementation that keep it
closer to the existing implementation and either clean them up over
time or just throw out the platform in five or ten years when the last
machines are dead.

      Arnd
