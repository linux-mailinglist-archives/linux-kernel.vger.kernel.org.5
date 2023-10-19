Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64177D029A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjJSTeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346523AbjJSTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:34:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1DBCA;
        Thu, 19 Oct 2023 12:34:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E7C433CB;
        Thu, 19 Oct 2023 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744056;
        bh=U4uvieOMjkf+PFUrgjolzRXzsKujYoPFvUARZuVi93g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XIOTf/856ZdqwalZjvSzQ8fSJO1n4KiWsacm/1Df7JYiUp4JB9+Te46XnHn37YMh6
         DmDC6p3CZwBQ9TNRluPc5gDxlMifNmNfCynXNl7w77U8SU5X/2cl6Bh40IHYohVL9V
         QFqX91wAJ6EwJv39lI18MJr4yik6jMcvOZmUaQNmIgh1WGbV3TXiF/9kar9VpiLyIa
         8rg2ohTES4fShSu/LyTDgVEGa2jyonSjwsiuaeHhgbvOiABJuvPpBaanXnP9Gk/T4z
         jtFPG6S8YHnhpTfXlxYvqQL+rrke88jZtd/WUlrGbCqkDIn1Nko5Hpb10PIKK2bvr4
         R41si6gdULx6g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507c8316abcso9210e87.1;
        Thu, 19 Oct 2023 12:34:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywe5PT97BFNi+5/HuL7SCaAs2Vk4eOjxtYchmwPrkvZlHwJAkZG
        iEwDLl0VYgCE1hAqXAXVykQFu1WPCTIo/FVGPQ==
X-Google-Smtp-Source: AGHT+IGMT9Lrdbp7434FU0vSJTcnDLj9QZz+YqqqKURgtaUGGFvehHaTryvXAxTMKsvBGBRehz5HOHtRRNA6CFuynY8=
X-Received: by 2002:a05:6512:20d2:b0:507:a701:3206 with SMTP id
 u18-20020a05651220d200b00507a7013206mr2071442lfr.49.1697744054489; Thu, 19
 Oct 2023 12:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230531111038.6302-1-francesco@dolcini.it> <CAMuHMdUkPiA=o_QLyuwsTYW7y1ksCjHAqyNSHFx2QZ-dP-HGsQ@mail.gmail.com>
 <ZTFFp8Yr7lq6HIab@francesco-nb.int.toradex.com> <CAMuHMdXtA3LNL6UkWyz6oytfNpSv77EShfF-uQvnPJktMUr40A@mail.gmail.com>
 <ZTFNNudzuvDtSn4J@francesco-nb.int.toradex.com>
In-Reply-To: <ZTFNNudzuvDtSn4J@francesco-nb.int.toradex.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Oct 2023 14:34:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQrkeFmdtvdrscDMTTO6TfUZvJejCNGgC+osC3KjwE8Q@mail.gmail.com>
Message-ID: <CAL_JsqKQrkeFmdtvdrscDMTTO6TfUZvJejCNGgC+osC3KjwE8Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: 8250_omap: add rs485-rts-active-high
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
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

On Thu, Oct 19, 2023 at 10:37=E2=80=AFAM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> On Thu, Oct 19, 2023 at 05:13:01PM +0200, Geert Uytterhoeven wrote:
> > Hi Franceso,
> >
> > On Thu, Oct 19, 2023 at 5:05=E2=80=AFPM Francesco Dolcini <francesco@do=
lcini.it> wrote:
> > > On Thu, Oct 19, 2023 at 12:09:06PM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, May 31, 2023 at 1:14=E2=80=AFPM Francesco Dolcini <francesc=
o@dolcini.it> wrote:
> > > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > >
> > > > > Add rs485-rts-active-high property, this was removed by mistake.
> > > > > In general we just use rs485-rts-active-low property, however the=
 OMAP
> > > > > UART for legacy reason uses the -high one.
> > > > >
> > > > > Fixes: 767d3467eb60 ("dt-bindings: serial: 8250_omap: drop rs485 =
properties")
> > > > > Closes: https://lore.kernel.org/all/ZGefR4mTHHo1iQ7H@francesco-nb=
.int.toradex.com/
> > > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > ---
> > > > > v2: removed reported-by
> > > >
> > > > Thanks for your patch, which is now commit 403e97d6ab2cb6fd
> > > > ("dt-bindings: serial: 8250_omap: add rs485-rts-active-high")
> > > > in v6.4-rc5.
> > > >
> > > > > --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > > > > +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
> > > > > @@ -70,6 +70,7 @@ properties:
> > > > >    dsr-gpios: true
> > > > >    rng-gpios: true
> > > > >    dcd-gpios: true
> > > > > +  rs485-rts-active-high: true
> > > >
> > > > make dt_binding_check complains:
> > > >
> > > >     Documentation/devicetree/bindings/serial/8250_omap.yaml:
> > > > rs485-rts-active-high: missing type definition
> > >
> > > For some reasons it works for me (and worked when I did send the patc=
h)
> > >
> > > $ make dt_binding_check DT_SCHEMA_FILES=3D8250_omap.yaml
> > > ...
> > >   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
> > >   HOSTCC  scripts/dtc/fdtoverlay.o
> > >   HOSTLD  scripts/dtc/fdtoverlay
> > >   LINT    Documentation/devicetree/bindings
> > > invalid config: unknown option "required" for rule "quoted-strings"
> > > xargs: /usr/bin/yamllint: exited with status 255; aborting
> > >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > > /home/francesco/Toradex/sources/linux/Documentation/devicetree/bindin=
gs/phy/qcom,usb-snps-femto-v2.yaml: ignoring, error in schema: properties: =
qcom,ls-fs-output-impedance-bp
> > > /home/francesco/Toradex/sources/linux/Documentation/devicetree/bindin=
gs/arm/vexpress-sysreg.yaml: ignoring, error in schema: properties: gpio-co=
ntroller
> > > /home/francesco/Toradex/sources/linux/Documentation/devicetree/bindin=
gs/iio/temperature/adi,ltc2983.yaml: ignoring, error in schema: patternProp=
erties: ^thermistor@: properties: adi,excitation-current-nanoamp
> > > /home/francesco/Toradex/sources/linux/Documentation/devicetree/bindin=
gs/iio/adc/adi,ad4130.yaml: ignoring, error in schema: patternProperties: ^=
channel@([0-9a-f])$: properties: adi,burnout-current-nanoamp
> > > /home/francesco/Toradex/sources/linux/Documentation/devicetree/bindin=
gs/iio/addac/adi,ad74115.yaml: ignoring, error in schema: properties: adi,e=
xt2-burnout-current-nanoamp
> > >   DTEX    Documentation/devicetree/bindings/serial/8250_omap.example.=
dts
> > >   DTC_CHK Documentation/devicetree/bindings/serial/8250_omap.example.=
dtb
> > >
> > >
> > > any idea on what could be different between us?
> >
> > Are you using the latest dt-schema?

Indeed, it is a new check.

> Nope, and I tried to update it and now everything fails in a miserable
> way.

Do you have more details?

Rob
