Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A37E6B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjKINwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjKINwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:52:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275E30D2;
        Thu,  9 Nov 2023 05:52:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93849C43395;
        Thu,  9 Nov 2023 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699537920;
        bh=FFkhHR6zONA657K44Icp6MBkFGWCenGcJS5ZGEO0rM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PGczriILDOeKDBxPaMki9Pkjlz0Q3w3CnFLAJS0cnkCY77NFqemaq6uTyM1kGbAVC
         OmnDwPG2yaa4/1pgaYR/8k3WIcurGwbpaRM9w+RimR9FcxIJlQdNrfoGgOJTGIZBtR
         5Pb+A0QLmCBDruJ+mqyiWG5imJfIfvkGpBCcD2lM9+dmG4Kqvf1KoWe++3UT67qHLM
         MRfEi4XRj0hjkuPhdM7xDbhJzmkUPDlYZQnSas+DP6rB0FLnjdugCvlFxFnK/6in9n
         6W8gr+g6fQQwtUGWJUrBwnuD8yAyqljkOwLgkqua3B61SopCOi4TzXV/NN1vXXWPEI
         X4Y3B92sN71mA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507973f3b65so1134659e87.3;
        Thu, 09 Nov 2023 05:52:00 -0800 (PST)
X-Gm-Message-State: AOJu0YyFiFW2bPPRZSh2qI+wZWkzutxeJgXV3GkAQKPSSVU2LqvYRd+i
        YLr10RwnuLXv8rTqzLzxobuQ8gL8BlIvx+7MLg==
X-Google-Smtp-Source: AGHT+IG9/kgPzv5XhrN8/jQMMd6yVLRKaSGIV1+0jPtpk0hYQw+Fo0kHJiioOILImXzxpX3r8GCNSfxdsoXcPID4Vcc=
X-Received: by 2002:a19:f502:0:b0:509:47ba:3160 with SMTP id
 j2-20020a19f502000000b0050947ba3160mr1219621lfb.56.1699537918648; Thu, 09 Nov
 2023 05:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
In-Reply-To: <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Nov 2023 07:51:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
Message-ID: <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 4:54=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 09/11/23 11:05, Chen-Yu Tsai ha scritto:
> > Hi everyone,
> >
> > This v2 series continues Doug's "of: device: Support 2nd sources of
> > probeable but undiscoverable devices" [1] series, but follows the schem=
e
> > suggested by Rob, marking all second source component device nodes
> > as "fail-needs-probe-XXX", and having a hardware prober driver enable
> > the one of them. I tried to include everyone from the original Cc: list=
.
> > Please let me know if you would like to be dropped from future
> > submissions.
> >
> >
> > For the I2C component (touchscreens and trackpads) case from the
> > original series, the hardware prober driver finds the particular
> > class of device in the device tree, gets its parent I2C adapter,
> > and tries to initiate a simple I2C read for each device under that
> > I2C bus. When it finds one that responds, it considers that one
> > present, marks it as "okay", and returns, letting the driver core
> > actually probe the device.
> >
> > This works fine in most cases since these components are connected
> > via ribbon cable and always have the same resources. The driver as
> > implemented currently doesn't deal with regulators or GPIO pins,
> > since in the existing device trees they are either always on for
> > regulators, or have GPIO hogs or pinmux and pinconfig directly
> > tied to the pin controller.
> >
> >
> > Another case this driver could handle is selecting components based
> > on some identifier passed in by the firmware. On Chromebooks we have
> > a SKU ID which is inserted by the bootloader at
> > /firmware/coreboot/sku-id. When a new combination of components is
> > introduced, a new SKU ID is allocated to it. To have SKU ID based
> > device trees, we would need to have one per SKU ID. This ends up
> > increasing the number of device trees we have a lot. The recent
> > MT8186 devices already have 10+10 SKUs [2], with possibly more to come.
> >
> > Instead, we could have just one device tree for each device, with
> > component options listed and marked as "fail-needs-probe-XXX", and
> > let the hardware prober enable one of them based on the given SKU ID.
> > The driver will also fix up OF graph remote endpoints to point to the
> > enabled component.
> >
> > The MT8186 Corsola series [2] can also benefit from this, though I
> > haven't implemented anything yet.
> >
> >
> > Patch 1 adds of_device_is_fail() for the new driver to use.
> >
> > Patch 2 implements the first case, probing the I2C bus for presence
> > of components. This initial version targets the Hana Chromebooks.
> >
> > Patch 3 modifies the Hana device tree and marks the touchscreens
> > and trackpads as "fail-needs-probe-XXX", ready for the driver to
> > probe.
> >
> > Patch 4 adds a missing touchscreen variant to Hana.
> >
> > Patch 5 implements the second case, selectively enabling components
> > based on the SKU ID. This initial version targets the Krane ChromeOS
> > tablet, which has two possible MIPI DSI display panel options.
> >
> > Patch 6 drops Krane's SKU-specific compatible strings from the bindings=
.
> >
> > Patch 7 merges Krane's SKU-specific device trees into one, with the
> > device tree now containing two possible panels. This unfortunately
> > introduces a dtc warning:
> >
> >      arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dts:81.13-83.6:
> >          Warning (graph_endpoint): /soc/dsi@14014000/panel2@0/port/endp=
oint:
> >       graph connection to node '/soc/dsi@14014000/ports/port/endpoint'
> >           is not bidirectional
> >
> >
> > Please take a look.
> >
> > Johan, I'm not sure if this works as is for the Lenovo Thinkpad 13S
> > case, since it looks like the trackpad shares the I2C bus with the
> > keyboard.
> >
> >
> > Thanks
> > ChenYu
> >
> >
> > Background as given in Doug's cover letter:
> >
> > Support for multiple "equivalent" sources for components (also known
> > as second sourcing components) is a standard practice that helps keep
> > cost down and also makes sure that if one component is unavailable due
> > to a shortage that we don't need to stop production for the whole
> > product.
> >
> > Some components are very easy to second source. eMMC, for instance, is
> > fully discoverable and probable so you can stuff a wide variety of
> > similar eMMC chips on your board and things will work without a hitch.
> >
> > Some components are more difficult to second source, specifically
> > because it's difficult for software to probe what component is present
> > on any given board. In cases like this software is provided
> > supplementary information to help it, like a GPIO strap or a SKU ID
> > programmed into an EEPROM. This helpful information can allow the
> > bootloader to select a different device tree. The various different
> > "SKUs" of different Chromebooks are examples of this.
> >
> > Some components are somewhere in between. These in-between components
> > are the subject of this patch. Specifically, these components are
> > easily "probeable" but not easily "discoverable".
> >
> > A good example of a probeable but undiscoverable device is an
> > i2c-connected touchscreen or trackpad. Two separate components may be
> > electrically compatible with each other and may have compatible power
> > sequencing requirements but may require different software. If
> > software is told about the different possible components (because it
> > can't discover them), it can safely probe them to figure out which
> > ones are present.
> >
> > On systems using device tree, if we want to tell the OS about all of
> > the different components we need to list them all in the device
> > tree. This leads to a problem. The multiple sources for components
> > likely use the same resources (GPIOs, interrupts, regulators). If the
> > OS tries to probe all of these components at the same time then it
> > will detect a resource conflict and that's a fatal error.
> >
> > The fact that Linux can't handle these probeable but undiscoverable
> > devices well has had a few consequences:
> > 1. In some cases, we've abandoned the idea of second sourcing
> >     components for a given board, which increases cost / generates
> >     manufacturing headaches.
> > 2. In some cases, we've been forced to add some sort of strapping /
> >     EEPROM to indicate which component is present. This adds difficulty
> >     to manufacturing / refurb processes.
> > 3. In some cases, we've managed to make things work by the skin of our
> >     teeth through slightly hacky solutions. Specifically, if we remove
> >     the "pinctrl" entry from the various options then it won't
> >     conflict. Regulators inherently can have more than one consumer, so
> >     as long as there are no GPIOs involved in power sequencing and
> >     probing devices then things can work. This is how
> >     "sc8280xp-lenovo-thinkpad-x13s" works and also how
> >     "mt8173-elm-hana" works.
> >
> > End of background from Doug's cover letter.
>
> I think that using "status" is not a good idea, I find that confusing.

"status" is what defines a device's state in terms of enabled,
present, available. That's exactly what we're expressing here.

Now, I do not think we should be mixing the device class (e.g.
touchscreen) into status. I said this on v1, but apparently that was
not listened to.

>
> Perhaps we could have a node like
>
> something {
>         device-class-one =3D <&device1>, <&device2>, <&device3>;
>         device-class-two =3D <&device4>, <&device5>, <&device6>;
> }
>
> so that'd be more or less
>
> hw-prober {
>         trackpads =3D <&tp1>, <&tp2>;
>         keyboards =3D <&kb1>, <&kb2>;
>         touchscreens =3D <&ts1>, <&ts2>;
> }

No. That's more or less what v1 had.

Rob
