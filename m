Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CA7D2FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjJWK23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjJWK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:28:25 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590F188;
        Mon, 23 Oct 2023 03:28:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 431875C027F;
        Mon, 23 Oct 2023 06:28:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 06:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698056900; x=1698143300; bh=sl
        J4gsmLFLLG28yC7DauJDzx27bn8p/IiBTXbBZAE1A=; b=WYniU+v0LQ9c0HRur4
        W10+/qiyVQOIdiVGnK1R2E9hrNKzDXTSU0hq8J4bC2cnYJcbRpRNlT3wl916l0K4
        nLX4jRVrk496SlZ+bji5Yq5yeLalUVD2LQFfXoWEXLZ8LZOB3sWINDsnLL2sSQjb
        fm0lR5U5vj6M2clKJV0L3frCq/MbCPXHccMWGG7jYhnMDGH6T5+xHdisZ2EwQ33I
        K+FFjwgeGH0zl1BwLsxDV4O0X5oc3VArJB5pkCAUQ7QIgfcPmrJiOmsReHA6a/nW
        ifN+1Vi/bAS0Os93lQMoRhGy64uVeArjl+Pr6AroKuby3BvukV5QohvhRKvhjk30
        95SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698056900; x=1698143300; bh=slJ4gsmLFLLG2
        8yC7DauJDzx27bn8p/IiBTXbBZAE1A=; b=sacQjNjjZYyQ7+D6+xGCed3u3mK9m
        fYqOXgE9b8d8agnZbS8LXNv8upZhEMjYR10qc+lyTNZZPRUJjm6V0tG1SxKG4mPo
        TWJo3D5sXPCvqpn4ebNxF07vvoB1ee9MnD87npmBLRZIWWSF7xwjdglrsB3Rn67p
        1iAHv9/xiVxV1ZWCw6zAckjMFCJh5gCQURLS0fA5QEnjRrvD2Ool9bVCyMWc7Hgf
        tMBUCzFiXQfJv4+VK9kF0r4O0ydFqEbThVcw+EnWzxHNanADToGvT49mmbv3+mRN
        U73AR3utLMJ9Uisf2jPacZh3IThl41en1CXROoxzDCsX9mMQp0mqfBKTA==
X-ME-Sender: <xms:w0o2ZfIx46pW4d3RehSADLmlzh_0fOoJMvmJWh5vF2sKDacs8vH1Dw>
    <xme:w0o2ZTLMqRD4LTUkRLWmj_CbdRag4j4vtUbqONJz1qS6ETJdbwexRIkgJkyvvT1aE
    kxQneOhygDHYm7It8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:w0o2ZXs1OTcI2ut4t5b9uILfYlpkZ2s13por9jxvYW0yz8DWqSVj5g>
    <xmx:w0o2ZYazryU-hCtv7BbCpYR4RzbmXfrFnQjiL76hyfr16QFrfFOuWw>
    <xmx:w0o2ZWaY5dbqra9qlg3RRk2akHz8H20CNpn0HKiE4pzwvNrmLXuQew>
    <xmx:xEo2ZYCmgkojUBxNcvg6ek0W56J4VA4qCRUxzSGlWYX8OO12_Jlkng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5040B60089; Mon, 23 Oct 2023 06:28:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <d0dfba41-d234-4a1d-b167-08a85ae6724a@app.fastmail.com>
In-Reply-To: <1jmswds9dn.fsf@starbuckisacylon.baylibre.com>
References: <20231020132036.1181762-1-arnd@kernel.org>
 <1jmswds9dn.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 23 Oct 2023 12:27:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jerome Brunet" <jbrunet@baylibre.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Kevin Hilman" <khilman@baylibre.com>, "Yu Tu" <yu.tu@amlogic.com>
Cc:     "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        "Dmitry Rokosov" <ddrokosov@sberdevices.ru>,
        "Jian Hu" <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: S4: select CONFIG_COMMON_CLK_MESON_CLKC_UTILS
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023, at 15:35, Jerome Brunet wrote:
> On Fri 20 Oct 2023 at 15:19, Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Without this, the newly added driver fails to link:
>>
>> aarch64-linux-ld: drivers/clk/meson/s4-pll.o: in function `meson_s4_pll_probe':
>> s4-pll.c:(.text+0x13c): undefined reference to `meson_clk_hw_get'
>>
>> Fixes: e787c9c55edad ("clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/clk/meson/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index c5303e4c16043..3c28560b0faba 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -149,6 +149,7 @@ config COMMON_CLK_S4_PLL
>>  	tristate "S4 SoC PLL clock controllers support"
>>  	depends on ARM64
>>  	default y
>> +	select COMMON_CLK_MESON_CLKC_UTILS
>>  	select COMMON_CLK_MESON_MPLL
>>  	select COMMON_CLK_MESON_PLL
>>  	select COMMON_CLK_MESON_REGMAP
>
> Thx Arnd and sorry about this.
>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>
> Stephen, do you mind taking this directly ?

I ran into the same bug with drivers/clk/meson/s4-peripherals.c,
sending a v2 of my patch to fix both at the same time, assuming
v1 has not been applied yet (it's not in today's linux-next).

      Arnd
