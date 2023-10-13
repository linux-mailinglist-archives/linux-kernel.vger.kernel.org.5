Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E257C8C40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJMR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:27:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B4C0;
        Fri, 13 Oct 2023 10:27:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B61DC433CD;
        Fri, 13 Oct 2023 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697218041;
        bh=XPp/N2DrY886TmYtke+2pdg6aNdeRFGp8q1vWyV87IU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gwulx8FpUwUeCCL9aE/iQo6qD4lq6Acm1Rnba0amXnQz5YQNDA1BUzqbcmBUmjMwy
         dDW99F5Na8QJ2YHzvB9EaRdGACIXaN2rbRP4DM4fqCsr5W3SIrCddjDDm/KytLtBWD
         N3Eh6NC7OqOPQJaXXfoiSOFpeNAlyv8udyXGbTXOI2vbLlY+hx9lW3/HBULOimfT5R
         +xnB+yqQlCGTFJPVwsCQjs0vXVQ5+dNae/vzPI1n2K5dFBJmHwuF074o/QBXaiI8YP
         6TT3GbujconqjfShBNYF/JS8h010bj/cQWmJSDKW6/xFzJdtwPJkPaya+A9+AmVhX2
         Ttk52yWUI9HIA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50305abe5f0so3089925e87.2;
        Fri, 13 Oct 2023 10:27:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLtTd9ANjdQPi7+AEJD7IJ9Zk3D2ZkV84cLl/LuGW8Wy259X9W
        /v407RTXI/4iOOAwTDQgyAhEzSgW481mb8fALQ==
X-Google-Smtp-Source: AGHT+IEizvXO2mNiDj59lp5atM3o+Uro0LVK63GgCo+PNfwGLPyinV3lNsPocGD4O5YiMYdfS//6qiiSo5V+aBS7Lfo=
X-Received: by 2002:a05:6512:250c:b0:503:55c:7999 with SMTP id
 be12-20020a056512250c00b00503055c7999mr28450678lfb.34.1697218039162; Fri, 13
 Oct 2023 10:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230924181959.64264-1-n2h9z4@gmail.com> <20231010132921.GA628810-robh@kernel.org>
 <0ec4f647-77b9-4b3f-9cbd-6fb122f09462@roeck-us.net>
In-Reply-To: <0ec4f647-77b9-4b3f-9cbd-6fb122f09462@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Oct 2023 12:27:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKhF8apt7==97yHAUo=B8M1oFQFc=ZCYTYAavNqOVAKCQ@mail.gmail.com>
Message-ID: <CAL_JsqKhF8apt7==97yHAUo=B8M1oFQFc=ZCYTYAavNqOVAKCQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert
 txt to yaml
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nik Bune <n2h9z4@gmail.com>, wim@linux-watchdog.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        skhan@linuxfoundation.org, claudiu.beznea@microchip.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 8:56=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Oct 10, 2023 at 08:29:21AM -0500, Rob Herring wrote:
> > On Sun, Sep 24, 2023 at 08:19:59PM +0200, Nik Bune wrote:
> > > Convert txt file to yaml.
> > >
> > > Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Removed trailing whitespace in an element of the maintainers list.
> > >
> > > v2 patch: https://lore.kernel.org/linux-devicetree/20230924172004.592=
08-1-n2h9z4@gmail.com/
> > >
> > >  .../watchdog/atmel,at91rm9200-wdt.yaml        | 33 +++++++++++++++++=
++
> > >  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 -----
> > >  2 files changed, 33 insertions(+), 9 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,=
at91rm9200-wdt.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-=
at91rm9200-wdt.txt
> >
> > Are the watchdog maintainers going to pick up this and other watchdog
> > bindings?
> >
>
> Tricky question. I am way behind with my reviews, and historically you ha=
ve
> picked up some of themm, so I really never know what to do with bindings.

The default is the subsystem maintainers take them, but yes I do pick
up stuff from time to time for $reasons. Largely that was early on in
schema conversions and there wasn't much checking, but now that's much
better and I only tend to pick up stuff if it's been weeks without
getting applied. Last cycle I found a few wdog bindings that hadn't
been applied (from Apr or May), so I've been keeping more of an eye on
them.

Rob
