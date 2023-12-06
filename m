Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC980654A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjLFCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFCzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:55:54 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C11A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:55:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf898c43cso2908556e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 18:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701831356; x=1702436156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAjB+OSC2G0sATXrxYuI8k53/GEiZUhN5YxDKMU/l7c=;
        b=DE1M362Mr3J/o1u4oHby3q8T9PzICCGMhNDiPxByQf26C+O8nh+Ac0/iEtSpdkOHdK
         npS7G+QzxOjRmZJc0xTj6esaIRFMbt429pOLjuowICKmitmWx6K2WZayTLw7uA2VKbB+
         7OhrbyrAUf9ARrYLCWK+Hnw5xPz9s9W4Hv7Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701831356; x=1702436156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAjB+OSC2G0sATXrxYuI8k53/GEiZUhN5YxDKMU/l7c=;
        b=ILGozdJyDkoLayUFdF8xGuufS66lruFFspPVUQJULVm8+DHiSti8Z4DAZTlBbMHQVI
         gjFda6UYxvokuxXCPVtXjVZOjOXyOaJHnLBoOmeWTylVFZonWVlZ544HD9eTmb30lFRj
         PrpSgYHDaVStatAaABjX6UPVDhu5zV+nu6j9R6BgGKppDdfiJoUyTjOIPoqmM1l8BV3N
         I8VKDHrRezM3UY7IfEl7jd+WgJS/A7Z/FFrdxu1hyws1XLD6ifee3eAutV7/k1wGLt+s
         hypkzEZgtKxIt1Pyonq23lpixL63dBmP4HOEUvuD2vLI3x/v97E9hb1qIMKNAfvjB0nm
         cu3g==
X-Gm-Message-State: AOJu0YwueH6pAyRXQKihQNdi5txhDNsXmmmLnyg4EbnhHoDbEldOeIXB
        LyLsptRMPuQErt4Z91yc3DAT8B5YvSdbXR7fO1B7Ag==
X-Google-Smtp-Source: AGHT+IHnNZLv+A8rBD2iJfouOzY8bodAfVe2SPHWkYOI3dEcOPciD4ew3LweH+XusZAZCM5WonigRoCXzwrqYp9fpWQ=
X-Received: by 2002:a05:6512:1107:b0:50b:f88d:f83b with SMTP id
 l7-20020a056512110700b0050bf88df83bmr112272lfg.78.1701831355848; Tue, 05 Dec
 2023 18:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-5-wenst@chromium.org>
 <CAD=FV=W01gfxV6RN2o6CVS7jjf8qgKP-jUy9Bp94d2hWzVC48A@mail.gmail.com>
 <CAGXv+5E+R292XsOFSL-j0KJMmVJjWtxMRgCK8besP7mo6NDOWA@mail.gmail.com>
 <CAD=FV=UQkAjgMuR85cPikNtCxsODWPWs7cibOcOoNGdjSSvF8Q@mail.gmail.com> <3700f05f-2411-4422-972f-f3df690efb84@collabora.com>
In-Reply-To: <3700f05f-2411-4422-972f-f3df690efb84@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 6 Dec 2023 10:55:44 +0800
Message-ID: <CAGXv+5G5fFTv8zn=YamSdccjuYemE5oKBqjb8CSyGzu9aMJ0eg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Tue, Dec 5, 2023 at 6:22=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 04/12/23 17:50, Doug Anderson ha scritto:
> > Hi,
> >
> > On Sun, Dec 3, 2023 at 10:59=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> >>
> >> On Sat, Dec 2, 2023 at 8:58=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromium=
.org> wrote:
> >>>>
> >>>> @@ -44,6 +46,7 @@ trackpad2: trackpad@2c {
> >>>>                  reg =3D <0x2c>;
> >>>>                  hid-descr-addr =3D <0x0020>;
> >>>>                  wakeup-source;
> >>>> +               status =3D "fail-needs-probe";
> >>>
> >>> While doing this, you could also remove the hack where the trackpad
> >>> IRQ pinctrl is listed under i2c4.
> >>
> >> Sure. I do think we can do away with it though. According to at least =
one
> >> schematic, the interrupt line has pull-ups on both sides of the voltag=
e
> >> shifter.
> >>
> >> BTW, The touchscreen doesn't have pinctrl entries. This has pull-ups o=
n
> >> both sides of the voltage shifter as well.
> >
> > I dunno if the convention is different on Mediatek boards, but at
> > least on boards I've been involved with in the past we've always put
> > pinctrl entries just to make things explicit. This meant that we
> > didn't rely on the firmware/bootrom/defaults to leave pulls in any
> > particular state. ...otherwise those external pull-ups could be
> > fighting with internal pull-downs, right?
> >
>
> MediaTek boards aren't special and there's no good reason for those to re=
ly on
> firmware/bootrom/defaults - so there is no good reason to avoid declaring=
 any
> relevant pinctrl entry.

I think this should be migrated to use the proper GPIO bindings: the
GPIO_PULL_UP / GPIO_PULL_DOWN / GPIO_BIAS_DISABLE flags.

But that's a different discussion.

ChenYu
