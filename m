Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DD810A58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378605AbjLMGcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378551AbjLMGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:32:35 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A3AD;
        Tue, 12 Dec 2023 22:32:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 766763200A12;
        Wed, 13 Dec 2023 01:32:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 01:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=fm1; t=1702449155;
         x=1702535555; bh=UyW0IXIQPsKnr5ShFX4RHhbev01w7X9e9SS2M4KdIQE=; b=
        hH019c6jpUpdOMYxII369agbX2xrFFWUJUaaWR1goA1XTcP8iY8lKDebN2WfEJy8
        ZQmRrgqWPyeWgoTFFjhrJNf/NakQ/5a51j7z9M2fAlpEXGhQI5vooeE5P4Nuz8lj
        YQmXJpngABQQjVI31iSN+Gsqsvv08e+erezTUDgwuKxyJf1c2rtMjvvRE3dqgOOi
        QzEeXDNSicFcYeB2H3j4BOtcFJfOIIYkYzH9sKkvS2nQWMl5mOs6IchGZZ3yMVSY
        NSpva/pHqQ8mhqAB9IORiwUUTed77wLhuP1mWP7o6bOJunElyaTRId1xWBDX0OJG
        ApdoH4zhydGsVvLMQpo1Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702449155; x=
        1702535555; bh=UyW0IXIQPsKnr5ShFX4RHhbev01w7X9e9SS2M4KdIQE=; b=u
        93SpR8K00SNfGyjLScld39ONSX3DLD2VIv2Qc34TVz/T7sO6a4wPlB5kpQOr7zzW
        IBdy/FlL3Dz9BLUuQljWWcUkY0wc7JaYrVjLcHJqT3Mg0bW2TR6V0XPGSjLOPHH3
        OWVp3sqPdJqvEHdWN+HiKYtPO3O5lRHUnoe2/ylZTJqoaKY01XOTZ1mrzcoqw1Hd
        nIeCrk4gXXMV6tKMZba762hF7AsA8UdpdreK7JrFXx/DGFEx6HqN0eAVBwm6U7g/
        6J+fJrUOW/YPwC7wviLGaRtVgSxaKgGeptAOIIP8Mq7LeEZmAaXWK0J2Ubk42Y1l
        p9avhRszS3Zv9ce2+G1Gw==
X-ME-Sender: <xms:A1B5ZRmQQOjQiYtXsOyFHSCj_5SOwkQg5DUtS9uMjiT92_zrjjb4jw>
    <xme:A1B5Zc3s9bGC3-5rIcxToews5sTaZQXV3fJP9SV37SYZkO1tMq6g4jexcK3ULwvlo
    jabpvmEpzX8aYOZT-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:A1B5ZXpZ0sIY5ElZOjJ8DiS8OJFHWHkrBszEqIG1LdL_0ysv8kN1ug>
    <xmx:A1B5ZRkhT31O43qDSo5BoCvMza94RJ5EKx-CC-MP-xYgvN0jKKbttA>
    <xmx:A1B5Zf1Rvd-6lcG5Gi5GQz2mJQ83TfdYAO9fHFe0P59UEmUwZ7sZRw>
    <xmx:A1B5ZZNuk9oY7eWdO0hmMScL5EY4D4s53-n3e4BpauCgs4eAGfMKoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E8939B6008D; Wed, 13 Dec 2023 01:32:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <42f522b5-6406-4bef-8180-3a431ee884a5@app.fastmail.com>
In-Reply-To: <CAJF2gTQckdn=uDfeLKu7wceOq7LT1KGJUT0vARMr9zUy3xc4xw@mail.gmail.com>
References: <20231212214536.175327-1-arnd@kernel.org>
 <CAJF2gTQckdn=uDfeLKu7wceOq7LT1KGJUT0vARMr9zUy3xc4xw@mail.gmail.com>
Date:   Wed, 13 Dec 2023 07:32:14 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Pavel Machek" <pavel@ucw.cz>, "Lee Jones" <lee@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Bill Wendling" <morbo@google.com>,
        "Justin Stitt" <justinstitt@google.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] leds: sun50i-a100: avoid division-by-zero warning
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023, at 02:26, Guo Ren wrote:
> On Wed, Dec 13, 2023 at 5:45=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>  {
>>         const struct sun50i_a100_ledc_timing *timing =3D &priv->timin=
g;
>>         unsigned long mod_freq =3D clk_get_rate(priv->mod_clk);
>> -       u32 cycle_ns =3D NSEC_PER_SEC / mod_freq;
>> +       u32 cycle_ns;
>>         u32 control;
>>
>> +       if (!mod_freq)
>> +               return;
>> +
> Shall we need err_disable_bus_clk?
>
> + static int sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv)
> - static void sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *pri=
v)

I'm not worried about it too much, as there is already an error check
on priv->mod_clk being unavailable during initialization. The case that
the warning is about is just for build-testing on architectures that
don't even use COMMON_CLK.

     Arnd
