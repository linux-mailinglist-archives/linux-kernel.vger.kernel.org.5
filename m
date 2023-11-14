Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906E7EAABA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKNHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjKNHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:05:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C514186
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:05:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507bd644a96so7585531e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699945529; x=1700550329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyb2EwjVD2jfx+kZp1EpPuK0eXya7TglNpKpzi4k5bM=;
        b=itJIdkFC92yVY3butSQjHOVvkfPg6axVtj1ugWycGwDI4aHxP4NxA9Tbkc01dK2gzb
         gNHfXbdydmkhKutVKyv6NFNnJ0NIRlbbZLrrz8mpntAVWUEehXLjRLwTOGTaRqYK7T4Y
         qg/HkoQ+iBTeZOQ7IuI0ZsHZS4I+KsxoTwgMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699945529; x=1700550329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyb2EwjVD2jfx+kZp1EpPuK0eXya7TglNpKpzi4k5bM=;
        b=fed8ZIwgdXW0y5CrGnXHVSMX/wS+INRO7rQtRJbxXhWTC3Hv7MNhjJn/3Xn61eyH7c
         lLQP1txBQoF0X2T3+6mXMqVwlJvM0Hkx0osK0Hd+5Tf0FzxZQQbw1A5ZHuhrZG/hdc7/
         nchkAWG0/pYnW97reFweYvBwN4IwrZNLeNdp74BLR4KYHChWaD8czguQ/vyfKZG4Tsg4
         z8+CcdC9lVXHGujWgSeJWCxuU7kPjZcvZDhnxWgoh5VaUbreQoNQGoebbj8gBTVVJt3Z
         fXQAVd99R9hDl3uS09eUg2qndbbQiaLrt4RFyk3UmgN3uAys0px+r2O+kqL+3h2ye262
         3WnQ==
X-Gm-Message-State: AOJu0Yw7tswx2LPCaTTA8u3dCe7LAPFYSq+MnMbmDtmpllkIdhhb+CvL
        JaLT4bcwcjbrAaT4WuIdxGSPH7fYwsQUwAZlBSTKlw==
X-Google-Smtp-Source: AGHT+IE75Kw2yjHCmLuUlzVR4qEfz+s0VaQYGbP1keBehuM963WhuH0JPG9R0sbEQN/xTp0cRos+bLKEQ/NqAXRUufY=
X-Received: by 2002:ac2:5dcd:0:b0:507:b4b7:a198 with SMTP id
 x13-20020ac25dcd000000b00507b4b7a198mr5694032lfq.57.1699945528627; Mon, 13
 Nov 2023 23:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
In-Reply-To: <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Nov 2023 15:05:17 +0800
Message-ID: <CAGXv+5Fta3JvtVz6CYg9xRzE+wjoUtpmy1XrCiU7fMbEJbkGgA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 9:52=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wro=
te:
>
> On Thu, Nov 9, 2023 at 4:54=E2=80=AFAM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 09/11/23 11:05, Chen-Yu Tsai ha scritto:
> > > Hi everyone,
> > >
> > > This v2 series continues Doug's "of: device: Support 2nd sources of
> > > probeable but undiscoverable devices" [1] series, but follows the sch=
eme
> > > suggested by Rob, marking all second source component device nodes
> > > as "fail-needs-probe-XXX", and having a hardware prober driver enable
> > > the one of them. I tried to include everyone from the original Cc: li=
st.
> > > Please let me know if you would like to be dropped from future
> > > submissions.
> > >
> > >
> > > For the I2C component (touchscreens and trackpads) case from the
> > > original series, the hardware prober driver finds the particular
> > > class of device in the device tree, gets its parent I2C adapter,
> > > and tries to initiate a simple I2C read for each device under that
> > > I2C bus. When it finds one that responds, it considers that one
> > > present, marks it as "okay", and returns, letting the driver core
> > > actually probe the device.
> > >
> > > This works fine in most cases since these components are connected
> > > via ribbon cable and always have the same resources. The driver as
> > > implemented currently doesn't deal with regulators or GPIO pins,
> > > since in the existing device trees they are either always on for
> > > regulators, or have GPIO hogs or pinmux and pinconfig directly
> > > tied to the pin controller.
> > >
> > >
> > > Another case this driver could handle is selecting components based
> > > on some identifier passed in by the firmware. On Chromebooks we have
> > > a SKU ID which is inserted by the bootloader at
> > > /firmware/coreboot/sku-id. When a new combination of components is
> > > introduced, a new SKU ID is allocated to it. To have SKU ID based
> > > device trees, we would need to have one per SKU ID. This ends up
> > > increasing the number of device trees we have a lot. The recent
> > > MT8186 devices already have 10+10 SKUs [2], with possibly more to com=
e.
> > >
> > > Instead, we could have just one device tree for each device, with
> > > component options listed and marked as "fail-needs-probe-XXX", and
> > > let the hardware prober enable one of them based on the given SKU ID.
> > > The driver will also fix up OF graph remote endpoints to point to the
> > > enabled component.
> > >
> > > The MT8186 Corsola series [2] can also benefit from this, though I
> > > haven't implemented anything yet.
> > >
> > >
> > > Patch 1 adds of_device_is_fail() for the new driver to use.
> > >
> > > Patch 2 implements the first case, probing the I2C bus for presence
> > > of components. This initial version targets the Hana Chromebooks.
> > >
> > > Patch 3 modifies the Hana device tree and marks the touchscreens
> > > and trackpads as "fail-needs-probe-XXX", ready for the driver to
> > > probe.
> > >
> > > Patch 4 adds a missing touchscreen variant to Hana.
> > >
> > > Patch 5 implements the second case, selectively enabling components
> > > based on the SKU ID. This initial version targets the Krane ChromeOS
> > > tablet, which has two possible MIPI DSI display panel options.
> > >
> > > Patch 6 drops Krane's SKU-specific compatible strings from the bindin=
gs.
> > >
> > > Patch 7 merges Krane's SKU-specific device trees into one, with the
> > > device tree now containing two possible panels. This unfortunately
> > > introduces a dtc warning:
> > >
> > >      arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dts:81.13-83.6:
> > >          Warning (graph_endpoint): /soc/dsi@14014000/panel2@0/port/en=
dpoint:
> > >       graph connection to node '/soc/dsi@14014000/ports/port/endpoint=
'
> > >           is not bidirectional
> > >
> > >
> > > Please take a look.
> > >
> > > Johan, I'm not sure if this works as is for the Lenovo Thinkpad 13S
> > > case, since it looks like the trackpad shares the I2C bus with the
> > > keyboard.
> > >
> > >
> > > Thanks
> > > ChenYu
> > >
> > >
> > > Background as given in Doug's cover letter:
> > >
> > > Support for multiple "equivalent" sources for components (also known
> > > as second sourcing components) is a standard practice that helps keep
> > > cost down and also makes sure that if one component is unavailable du=
e
> > > to a shortage that we don't need to stop production for the whole
> > > product.
> > >
> > > Some components are very easy to second source. eMMC, for instance, i=
s
> > > fully discoverable and probable so you can stuff a wide variety of
> > > similar eMMC chips on your board and things will work without a hitch=
.
> > >
> > > Some components are more difficult to second source, specifically
> > > because it's difficult for software to probe what component is presen=
t
> > > on any given board. In cases like this software is provided
> > > supplementary information to help it, like a GPIO strap or a SKU ID
> > > programmed into an EEPROM. This helpful information can allow the
> > > bootloader to select a different device tree. The various different
> > > "SKUs" of different Chromebooks are examples of this.
> > >
> > > Some components are somewhere in between. These in-between components
> > > are the subject of this patch. Specifically, these components are
> > > easily "probeable" but not easily "discoverable".
> > >
> > > A good example of a probeable but undiscoverable device is an
> > > i2c-connected touchscreen or trackpad. Two separate components may be
> > > electrically compatible with each other and may have compatible power
> > > sequencing requirements but may require different software. If
> > > software is told about the different possible components (because it
> > > can't discover them), it can safely probe them to figure out which
> > > ones are present.
> > >
> > > On systems using device tree, if we want to tell the OS about all of
> > > the different components we need to list them all in the device
> > > tree. This leads to a problem. The multiple sources for components
> > > likely use the same resources (GPIOs, interrupts, regulators). If the
> > > OS tries to probe all of these components at the same time then it
> > > will detect a resource conflict and that's a fatal error.
> > >
> > > The fact that Linux can't handle these probeable but undiscoverable
> > > devices well has had a few consequences:
> > > 1. In some cases, we've abandoned the idea of second sourcing
> > >     components for a given board, which increases cost / generates
> > >     manufacturing headaches.
> > > 2. In some cases, we've been forced to add some sort of strapping /
> > >     EEPROM to indicate which component is present. This adds difficul=
ty
> > >     to manufacturing / refurb processes.
> > > 3. In some cases, we've managed to make things work by the skin of ou=
r
> > >     teeth through slightly hacky solutions. Specifically, if we remov=
e
> > >     the "pinctrl" entry from the various options then it won't
> > >     conflict. Regulators inherently can have more than one consumer, =
so
> > >     as long as there are no GPIOs involved in power sequencing and
> > >     probing devices then things can work. This is how
> > >     "sc8280xp-lenovo-thinkpad-x13s" works and also how
> > >     "mt8173-elm-hana" works.
> > >
> > > End of background from Doug's cover letter.
> >
> > I think that using "status" is not a good idea, I find that confusing.
>
> "status" is what defines a device's state in terms of enabled,
> present, available. That's exactly what we're expressing here.
>
> Now, I do not think we should be mixing the device class (e.g.
> touchscreen) into status. I said this on v1, but apparently that was
> not listened to.

I must have missed it and only took in Doug's final response.

My code doesn't actually use the class in the status property though.
I will remove it and just keep "fail-needs-probe".

ChenYu

> >
> > Perhaps we could have a node like
> >
> > something {
> >         device-class-one =3D <&device1>, <&device2>, <&device3>;
> >         device-class-two =3D <&device4>, <&device5>, <&device6>;
> > }
> >
> > so that'd be more or less
> >
> > hw-prober {
> >         trackpads =3D <&tp1>, <&tp2>;
> >         keyboards =3D <&kb1>, <&kb2>;
> >         touchscreens =3D <&ts1>, <&ts2>;
> > }
>
> No. That's more or less what v1 had.
>
> Rob
