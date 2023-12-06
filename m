Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F88075F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442687AbjLFRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442701AbjLFRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:00:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F01FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:01:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cfb03f1a8so3356065a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701882058; x=1702486858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6USO49247dIS4iM67DLL61cvXhjKL/DNTtVy5lpNUks=;
        b=gifP1k+Yzp7gkRJYp3Qf8JR0NsdSk9TMYT3tUjwdFlsoGMB1N2eLoCEvr3nueaebuv
         KrCXYKLiT9PczYOOaXE+RVoroxIVV6KhLlO7ztvaEOXAvtY7SSBCdW+DHFQ6hiums/it
         AEL9S8JJ8S/Rln6btJCYdBplJgq7HNlHNbhns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882058; x=1702486858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6USO49247dIS4iM67DLL61cvXhjKL/DNTtVy5lpNUks=;
        b=egne+McDqVHkhUViZBxdN5XNBohNMLQ6rKcsYwVKeGiwmBlK3luIPE4XLzC12AuX0O
         TOvn5Fw2UFngiSyCFmHi8i8+4zSYMEQNQhV+uLJHVE0LdB14wwApvpLi3KHzC+R46tzm
         ZmYQN0HDyv5Ucpp6vDUQVZqBJcISAFJaHu+77MXt7tjvBwV0/nW6iP4+LER2XiHzjdfE
         1r15r/GAJ6scEwzltKzEISBVnftYoKJQPu/ZZPQtSjTnbqBS/vZru7QUIImjCNAdKnpq
         6EMSu0+GLdUlraO5Z4SyC/umngZ3u6TKJwHUBn0LByfJka9C2CJauyuy0zfq8ly4RnHd
         DMzw==
X-Gm-Message-State: AOJu0Yx7TgukwbdoU8rVFAAZ8rT7F8HXng7iQBNI4x91S5gCSkQ0VynN
        /3rMDtuc37YszW/JP/OvEpcJlCsy4mbjvpTjGBMhVQKS
X-Google-Smtp-Source: AGHT+IHZGGr78XdFa20pJrNKjOACZDyHJ+DoXTPleSY78inA8vUPemExqVm/v/YTK4JGihrZe7D/Bw==
X-Received: by 2002:a50:c048:0:b0:54b:1bf2:2f36 with SMTP id u8-20020a50c048000000b0054b1bf22f36mr891930edd.7.1701882058397;
        Wed, 06 Dec 2023 09:00:58 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7df08000000b0054cba269d4fsm188632edy.16.2023.12.06.09.00.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:00:58 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso71865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:00:57 -0800 (PST)
X-Received: by 2002:a05:600c:4e8d:b0:40b:33aa:a2b9 with SMTP id
 f13-20020a05600c4e8d00b0040b33aaa2b9mr101895wmq.4.1701882057134; Wed, 06 Dec
 2023 09:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-5-wenst@chromium.org>
 <CAD=FV=W01gfxV6RN2o6CVS7jjf8qgKP-jUy9Bp94d2hWzVC48A@mail.gmail.com>
 <CAGXv+5E+R292XsOFSL-j0KJMmVJjWtxMRgCK8besP7mo6NDOWA@mail.gmail.com>
 <CAD=FV=UQkAjgMuR85cPikNtCxsODWPWs7cibOcOoNGdjSSvF8Q@mail.gmail.com>
 <3700f05f-2411-4422-972f-f3df690efb84@collabora.com> <CAGXv+5G5fFTv8zn=YamSdccjuYemE5oKBqjb8CSyGzu9aMJ0eg@mail.gmail.com>
 <4b9ea82c-d1a4-47b6-ba03-346cfdedef05@collabora.com>
In-Reply-To: <4b9ea82c-d1a4-47b6-ba03-346cfdedef05@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Dec 2023 09:00:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UMRRYieChp2+4Z6zxL-CSVZabiokuHH=qrnMMSmjNM2Q@mail.gmail.com>
Message-ID: <CAD=FV=UMRRYieChp2+4Z6zxL-CSVZabiokuHH=qrnMMSmjNM2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 6, 2023 at 2:02=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 06/12/23 03:55, Chen-Yu Tsai ha scritto:
> > On Tue, Dec 5, 2023 at 6:22=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 04/12/23 17:50, Doug Anderson ha scritto:
> >>> Hi,
> >>>
> >>> On Sun, Dec 3, 2023 at 10:59=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> >>>>
> >>>> On Sat, Dec 2, 2023 at 8:58=E2=80=AFAM Doug Anderson <dianders@chrom=
ium.org> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromi=
um.org> wrote:
> >>>>>>
> >>>>>> @@ -44,6 +46,7 @@ trackpad2: trackpad@2c {
> >>>>>>                   reg =3D <0x2c>;
> >>>>>>                   hid-descr-addr =3D <0x0020>;
> >>>>>>                   wakeup-source;
> >>>>>> +               status =3D "fail-needs-probe";
> >>>>>
> >>>>> While doing this, you could also remove the hack where the trackpad
> >>>>> IRQ pinctrl is listed under i2c4.
> >>>>
> >>>> Sure. I do think we can do away with it though. According to at leas=
t one
> >>>> schematic, the interrupt line has pull-ups on both sides of the volt=
age
> >>>> shifter.
> >>>>
> >>>> BTW, The touchscreen doesn't have pinctrl entries. This has pull-ups=
 on
> >>>> both sides of the voltage shifter as well.
> >>>
> >>> I dunno if the convention is different on Mediatek boards, but at
> >>> least on boards I've been involved with in the past we've always put
> >>> pinctrl entries just to make things explicit. This meant that we
> >>> didn't rely on the firmware/bootrom/defaults to leave pulls in any
> >>> particular state. ...otherwise those external pull-ups could be
> >>> fighting with internal pull-downs, right?
> >>>
> >>
> >> MediaTek boards aren't special and there's no good reason for those to=
 rely on
> >> firmware/bootrom/defaults - so there is no good reason to avoid declar=
ing any
> >> relevant pinctrl entry.
> >
> > I think this should be migrated to use the proper GPIO bindings: the
> > GPIO_PULL_UP / GPIO_PULL_DOWN / GPIO_BIAS_DISABLE flags.
> >
> > But that's a different discussion.
> >
>
> 100% agreed.

I guess I'd need to see patches as an example to see how this looks,
but I'm at least slightly skeptical. In this case the GPIO is
indirectly specified via "interrupts". Would you add these flags to
the interrupts specifier, too? There's another potential pull as well
(PIN_CONFIG_BIAS_BUS_HOLD) as well as other pin configuration
(PIN_CONFIG_INPUT_DEBOUNCE, for instance). Do we try to fit all of
these into the GPIO / interrupt specifier?

Certainly I will admit that this is a complicated topic, but it seems
weird to say that we use pinctrl to specify pin configuration / pulls
for all pins except ones that are configured as GPIOs or GPIO
interrupts.

-Doug
