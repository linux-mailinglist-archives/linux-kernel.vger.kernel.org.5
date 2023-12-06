Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA2806B39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbjLFKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377291AbjLFKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:02:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5811FA;
        Wed,  6 Dec 2023 02:02:33 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73A4166072EC;
        Wed,  6 Dec 2023 10:02:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701856952;
        bh=cr+tV0XqzVvByUwmvFvRoMfvYN0mf8oLqsTQmUgIzdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QqSgwEI2TEj20+Ep5cFRKALAPW2dGLQ+U6+O//hmeymH+I85vaA544p42v4fUIYGq
         kMTDOzwhdnCgN0qBdKruKDYPv5cEtZ/wsKeAU9n6p7vqnXjI0wXAidADulKD6AOpUG
         ++lhp2UKrtuta7g1DPvnGCIsleozW5Px79utFaF1GLkYQjuwKXpfBK+LyQauseX66+
         /Y2FfupnUpxOAnSQEA7GHWDWvXcJzC0hFTZzBg6ENhNKkqDhTNTlBifqMgGHYo2QKI
         xBmn+cRsEul8n19Mmgk7LsBm/5G5JIG0W5sBfdxuLyqMhsgDyv0h+ZHinXRZDricCI
         +SIkKoNwWXvew==
Message-ID: <4b9ea82c-d1a4-47b6-ba03-346cfdedef05@collabora.com>
Date:   Wed, 6 Dec 2023 11:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20231128084236.157152-1-wenst@chromium.org>
 <20231128084236.157152-5-wenst@chromium.org>
 <CAD=FV=W01gfxV6RN2o6CVS7jjf8qgKP-jUy9Bp94d2hWzVC48A@mail.gmail.com>
 <CAGXv+5E+R292XsOFSL-j0KJMmVJjWtxMRgCK8besP7mo6NDOWA@mail.gmail.com>
 <CAD=FV=UQkAjgMuR85cPikNtCxsODWPWs7cibOcOoNGdjSSvF8Q@mail.gmail.com>
 <3700f05f-2411-4422-972f-f3df690efb84@collabora.com>
 <CAGXv+5G5fFTv8zn=YamSdccjuYemE5oKBqjb8CSyGzu9aMJ0eg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5G5fFTv8zn=YamSdccjuYemE5oKBqjb8CSyGzu9aMJ0eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/12/23 03:55, Chen-Yu Tsai ha scritto:
> On Tue, Dec 5, 2023 at 6:22 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 04/12/23 17:50, Doug Anderson ha scritto:
>>> Hi,
>>>
>>> On Sun, Dec 3, 2023 at 10:59 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>>>
>>>> On Sat, Dec 2, 2023 at 8:58 AM Doug Anderson <dianders@chromium.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Tue, Nov 28, 2023 at 12:45 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>>>>>
>>>>>> @@ -44,6 +46,7 @@ trackpad2: trackpad@2c {
>>>>>>                   reg = <0x2c>;
>>>>>>                   hid-descr-addr = <0x0020>;
>>>>>>                   wakeup-source;
>>>>>> +               status = "fail-needs-probe";
>>>>>
>>>>> While doing this, you could also remove the hack where the trackpad
>>>>> IRQ pinctrl is listed under i2c4.
>>>>
>>>> Sure. I do think we can do away with it though. According to at least one
>>>> schematic, the interrupt line has pull-ups on both sides of the voltage
>>>> shifter.
>>>>
>>>> BTW, The touchscreen doesn't have pinctrl entries. This has pull-ups on
>>>> both sides of the voltage shifter as well.
>>>
>>> I dunno if the convention is different on Mediatek boards, but at
>>> least on boards I've been involved with in the past we've always put
>>> pinctrl entries just to make things explicit. This meant that we
>>> didn't rely on the firmware/bootrom/defaults to leave pulls in any
>>> particular state. ...otherwise those external pull-ups could be
>>> fighting with internal pull-downs, right?
>>>
>>
>> MediaTek boards aren't special and there's no good reason for those to rely on
>> firmware/bootrom/defaults - so there is no good reason to avoid declaring any
>> relevant pinctrl entry.
> 
> I think this should be migrated to use the proper GPIO bindings: the
> GPIO_PULL_UP / GPIO_PULL_DOWN / GPIO_BIAS_DISABLE flags.
> 
> But that's a different discussion.
> 

100% agreed.

Cheers,
Angelo

