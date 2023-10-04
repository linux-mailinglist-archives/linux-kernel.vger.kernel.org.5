Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479B7B8102
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbjJDNdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjJDNdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:33:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A80C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:33:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af603da0d1so1327157b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1696426392; x=1697031192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVU05/6eSA7iMjbJNdKOxOh7qlcL+m/U1QBiwV2qM/s=;
        b=PtMPchn1DpzrmuDx5n7kjImw9BVdmQ0I/LmXesZaBIRVVEanLuGo5gQN8kOTVAISNv
         3cl8vSnqILUXYSXgM/eGqrQdSwrQQGasrfm5Z4SVRptwpsqQ4CDhiC8+irA4lteVPpbR
         A0N7BSQcCqNtStAlZsrHRuFh6TEfY46CIwHrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696426392; x=1697031192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVU05/6eSA7iMjbJNdKOxOh7qlcL+m/U1QBiwV2qM/s=;
        b=HfMFY5xk1eAwpYv1bwUG5mu51wdnJsPrpQUsBWmksg7TW5Sb9Y/eAr66ds6buba5DH
         aIISIdHgn31jVahzgcXvKsPQ4EWITh31V3hGjJHEyznAl3MMnjyB0RQWNX7HYxMJQPs1
         kX8vGJc3LCSR2A+F+FEUNeiODPeB+TpTaX1jKOCipg0aWcRlZ7IJEg8eOenKhaUVvtc4
         0Iu6GO9Qs+2+9MZ4vHwrPNiViYp8zmcQXBMd3aQvoEkiWKcq9mpavzzGHviqu3JVfhcH
         w+tLr7ISV+GPMWlCA5iVdS90GtH957rlxfWSwMI0xu88lFCDpgTIWbPP84XTjtAKE9+J
         H4QQ==
X-Gm-Message-State: AOJu0Yx93gJtHGIKGftHKoPgm5xoxI6Fgw5OgdoW+Wz0U+5y0FHyqvsG
        0eZZVWJVFKCkgHvm2sLtBf1b4pW6zqpWJrejdt5LCQ==
X-Google-Smtp-Source: AGHT+IFdWMGiRlhPQJNXuCSpwDBon00Wy1d2O8LTSVzc6jBknELc0g54aRIlIw2z5gDHlItTDtMI2FLmbFdayYYKXrw=
X-Received: by 2002:a05:6358:88f:b0:143:61d:ffd3 with SMTP id
 m15-20020a056358088f00b00143061dffd3mr2911004rwj.4.1696426392070; Wed, 04 Oct
 2023 06:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231002141020.2403652-1-jbrunet@baylibre.com>
 <20231002141020.2403652-3-jbrunet@baylibre.com> <2248b34e-d755-4142-986c-0ead80796e13@linaro.org>
 <1jleciyahv.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jleciyahv.fsf@starbuckisacylon.baylibre.com>
From:   Da Xue <da@lessconfused.com>
Date:   Wed, 4 Oct 2023 21:33:00 +0800
Message-ID: <CACdvmAhVODCikHMVpX91kBRxZi=7hgrR2Q-_71mFf9OVdptTWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add libretech cottonwood support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:59=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com>=
 wrote:
>
>
> On Wed 04 Oct 2023 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> w=
rote:
>
> > On 02/10/2023 16:10, Jerome Brunet wrote:
> >> Add support for the Libretech cottonwood board family.
> >> These 2 boards are based on the same PCB, with an RPi B form factor.
> >> The "Alta" board uses an a311d while the "Solitude" variant uses an
> >> s905d3.
> >> Co-developed-by: Da Xue <da.xue@libretech.co>
> >> Signed-off-by: Da Xue <da.xue@libretech.co>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>   arch/arm64/boot/dts/amlogic/Makefile          |   2 +
> >>   .../amlogic/meson-g12b-a311d-libretech-cc.dts | 133 ++++
> >>   .../amlogic/meson-libretech-cottonwood.dtsi   | 610 ++++++++++++++++=
++
> >>   .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
> >>   4 files changed, 834 insertions(+)
> >>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libr=
etech-cc.dts
> >>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cotto=
nwood.dtsi
> >>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libr=
etech-cc.dts
> >>
> >
> > <snip>
> >
> >> +
> >> +    leds-pwm {
> >> +            compatible =3D "pwm-leds";
> >> +
> >> +            led-green {
> >> +                    color =3D <LED_COLOR_ID_GREEN>;
> >> +                    function =3D LED_FUNCTION_STATUS;
> >> +                    linux,default-trigger =3D "default-on";
> >> +                    panic-indicator;
> >> +                    max-brightness =3D <255>;
> >> +                    pwms =3D <&pwm_cd 1 1250 0>;
> >> +                    active-low;
> >> +            };
> >> +
> >> +            led-blue {
> >> +                    color =3D <LED_COLOR_ID_BLUE>;
> >> +                    function =3D LED_FUNCTION_ACTIVITY;
> >> +                    linux,default-trigger =3D "activity";
> >
> > "activity" isn't documented, perhaps heartbeat instead ?
> >
>
> The trigger does exist though. The other way is to extend the DT doc.
> I don't really care one way or the other

We can and should use heartbeat to both be consistent and also show
Linux has started for developers.

>
> I'll defer to Da on this one
>
> >> +                    max-brightness =3D <255>;
> >> +                    pwms =3D <&pwm_ab 1 1250 0>;
> >> +                    active-low;
> >> +            };
> >
> > leds subnodes should be named as led(-[0-9a-f]+)
> >
> > see Documentation/devicetree/bindings/leds/leds-pwm.yaml
>
> That I do care. The schematics refer to the leds by name. There is no
> number assigned, much less hex. Making one up makes no sense.
>
> User should be able to quickly (and easily) link  what they see in the
> schematics with DT.
>
> So I'd prefer to submit a change for the regex rather than changing this

I don't get why the LEDs should be hex either. It's contradictory to
https://www.kernel.org/doc/html/latest/leds/leds-class.html

I did a simple grep and didn't find any references to
LED_COLOR_ID_ORANGE. We can debug this later.

>
> >
> >> +    };
> >> +
> >> +    leds-gpio {
> >> +            compatible =3D "gpio-leds";
> >> +
> >> +            led-orange {
> >> +                    color =3D <LED_COLOR_ID_AMBER>;
> >> +                    function =3D LED_FUNCTION_STANDBY;
> >> +                    gpios =3D <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> >> +            };
> >
> > Ditto, but you can simply use "led" since it's the only one.
> >
> > See Documentation/devicetree/bindings/leds/leds-gpio.yaml
> >
> > Neil
> >
> >
> > <snip>
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
