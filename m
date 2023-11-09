Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293897E6D06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjKIPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjKIPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:14:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009635A5;
        Thu,  9 Nov 2023 07:14:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C86C433AB;
        Thu,  9 Nov 2023 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699542841;
        bh=FU2kTWEV/iC5NrY2xfbnKAFEU4M/r009NlocXokOA4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OwhUAHTP7XFEW9APt8lfsU+L6kwlPSy/LDJoLUFi60vwGMaP+dV92h2wR1o+d5i44
         vi4H0U3nJnPAufn0ze87xlh4cmjPUkhWp6wjFgvvL5LgcV2pwA9VV8KRbSzAdgdxrl
         xz0nPd5fY3cNYmrtfRoXytUbMge50nUBZIBD1oTvTzhHIkAUBcy9HNTXCH1bOt0pzI
         vxlK+A4jke1SOGOMyR3uWxHZvIJjQd2Dqip+8C9yaIvHLyCGNd3W7vq4YJZtnaDhg5
         gLeJ77QWcNL2fg8A6Zv6Bnf3NcBXyHCwAyoILeS1DqE83QdBasm/0YsVxRt4RA07kr
         o6CT8HG2u4MWA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507a62d4788so1296044e87.0;
        Thu, 09 Nov 2023 07:14:01 -0800 (PST)
X-Gm-Message-State: AOJu0YwdiGv3gsQX3BMfBtz6vFMRDu0rZ8TnGCjyPFOvAV9HRChs5WHI
        9TE1NO/dzyBHAG+OTrFW674qhi7dj9gQIhN+zg==
X-Google-Smtp-Source: AGHT+IFB6x1gr32VeAyFyy5yY/wT4lO3/ubJla/ZBhOhYyGEqasIDyXQZSSE6pubpoWAO+rGp7sbHnZP7sdHy9aZGiY=
X-Received: by 2002:a19:f502:0:b0:509:47ba:3160 with SMTP id
 j2-20020a19f502000000b0050947ba3160mr1396690lfb.56.1699542839133; Thu, 09 Nov
 2023 07:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <20231109100606.1245545-3-wenst@chromium.org>
In-Reply-To: <20231109100606.1245545-3-wenst@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Nov 2023 09:13:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgUNcuXqtzHKdz5FdbxsrnLeZpgq-F+E21BvYS9qL0xg@mail.gmail.com>
Message-ID: <CAL_JsqJgUNcuXqtzHKdz5FdbxsrnLeZpgq-F+E21BvYS9qL0xg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/7] of: Introduce hardware prober driver
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
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

On Thu, Nov 9, 2023 at 4:06=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> Some devices are designed and manufactured with some components having
> multiple drop-in replacement options. These components are often
> connected to the mainboard via ribbon cables, having the same signals
> and pin assignments across all options. These may include the display
> panel and touchscreen on laptops and tablets, and the trackpad on
> laptops. Sometimes which component option is used in a particular device
> can be detected by some firmware provided identifier, other times that
> information is not available, and the kernel has to try to probe each
> device.
>
> This change attempts to make the "probe each device" case cleaner. The
> current approach is to have all options added and enabled in the device
> tree. The kernel would then bind each device and run each driver's probe
> function. This works, but has been broken before due to the introduction
> of asynchronous probing, causing multiple instances requesting "shared"
> resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
> time, with only one instance succeeding. Work arounds for these include
> moving the pinmux to the parent I2C controller, using GPIO hogs or
> pinmux settings to keep the GPIO pins in some fixed configuration, and
> requesting the interrupt line very late. Such configurations can be seen
> on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
> Lenovo Thinkpad 13S.
>
> Instead of this delicate dance between drivers and device tree quirks,
> this change introduces a simple I2C component prober. For any given
> class of devices on the same I2C bus, it will go through all of them,
> doing a simple I2C read transfer and see which one of them responds.
> It will then enable the device that responds.
>
> This requires some minor modifications in the existing device tree.
> The status for all the device nodes for the component options must be
> set to "failed-needs-probe-xxx". This makes it clear that some mechanism
> is needed to enable one of them, and also prevents the prober and device
> drivers running at the same time.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/of/Kconfig     |  13 ++++
>  drivers/of/Makefile    |   1 +
>  drivers/of/hw_prober.c | 154 +++++++++++++++++++++++++++++++++++++++++

Not sure about having this in drivers/of/, but fine for now... Really,
the I2C bus stuff should be in the I2C core with the rest of the code
that knows how to parse I2C bus nodes.

>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/of/hw_prober.c
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index da9826accb1b..269d20d51936 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -102,4 +102,17 @@ config OF_OVERLAY
>  config OF_NUMA
>         bool
>
> +config HW_PROBER
> +       bool "Hardware Prober driver"
> +       select I2C

You should not select I2C, but enable/disable I2C functionality based
on it being enabled.

> +       select OF_DYNAMIC
> +       help
> +         Some devices will have multiple drop-in options for one compone=
nt.
> +         In many cases the different options are indistinguishable by th=
e
> +         kernel without actually probing each possible option.
> +
> +         This driver is meant to handle the probing of such components, =
and
> +         update the running device tree such that the correct variant is
> +         made available.
> +
>  endif # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index eff624854575..ed3875cdc554 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_OF_RESERVED_MEM) +=3D of_reserved_mem.o
>  obj-$(CONFIG_OF_RESOLVE)  +=3D resolver.o
>  obj-$(CONFIG_OF_OVERLAY) +=3D overlay.o
>  obj-$(CONFIG_OF_NUMA) +=3D of_numa.o
> +obj-$(CONFIG_HW_PROBER) +=3D hw_prober.o
>
>  ifdef CONFIG_KEXEC_FILE
>  ifdef CONFIG_OF_FLATTREE
> diff --git a/drivers/of/hw_prober.c b/drivers/of/hw_prober.c
> new file mode 100644
> index 000000000000..442da6eff896
> --- /dev/null
> +++ b/drivers/of/hw_prober.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * hw_prober.c - Hardware prober driver
> + *
> + * Copyright (c) 2023 Google LLC
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/i2c.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME       "hw_prober"
> +
> +/**
> + * struct hw_prober_entry - Holds an entry for the hardware prober
> + *
> + * @compatible:        compatible string to match against the machine
> + * @prober:    prober function to call when machine matches
> + * @data:      extra data for the prober function
> + */
> +struct hw_prober_entry {
> +       const char *compatible;
> +       int (*prober)(struct platform_device *pdev, const void *data);
> +       const void *data;
> +};
> +
> +/*
> + * Some devices, such as Google Hana Chromebooks, are produced by multip=
le
> + * vendors each using their preferred components. This prober assumes su=
ch
> + * drop-in parts are on dedicated I2C busses, have non-conflicting addre=
sses,
> + * and can be directly probed by seeing which address responds without n=
eeding
> + * regulators or GPIOs being enabled or toggled.
> + */
> +static int i2c_component_prober(struct platform_device *pdev, const void=
 *data)
> +{
> +       const char *node_name =3D data;
> +       struct device_node *node, *i2c_node;
> +       struct i2c_adapter *i2c;
> +       int ret =3D 0;
> +
> +       node =3D of_find_node_by_name(NULL, node_name);
> +       if (!node)
> +               return dev_err_probe(&pdev->dev, -ENODEV, "Could not find=
 %s device node\n",
> +                                    node_name);
> +
> +       i2c_node =3D of_get_next_parent(node);
> +       if (strcmp(i2c_node->name, "i2c")) {

We have functions for comparing node names, use them and don't access
->name directly.

> +               of_node_put(i2c_node);
> +               return dev_err_probe(&pdev->dev, -EINVAL, "%s device isn'=
t on I2C bus\n",
> +                                    node_name);
> +       }
> +
> +       for_each_child_of_node(i2c_node, node) {
> +               if (!of_node_name_prefix(node, node_name))
> +                       continue;
> +               if (!of_device_is_fail(node)) {
> +                       /* device tree has component already enabled */

This isn't quite right if there's a disabled device. To check 'is
enabled', you just need to use of_device_is_available().

> +                       of_node_put(node);
> +                       of_node_put(i2c_node);
> +                       return 0;
> +               }
> +       }
> +
> +       i2c =3D of_get_i2c_adapter_by_node(i2c_node);
> +       if (!i2c) {
> +               of_node_put(i2c_node);
> +               return dev_err_probe(&pdev->dev, -EPROBE_DEFER, "Couldn't=
 get I2C adapter\n");
> +       }
> +
> +       for_each_child_of_node(i2c_node, node) {

The I2C core will walk the devices too. Perhaps if that saves off a
list of failed devices, then we don't need to walk the nodes again.

> +               struct property *prop;
> +               union i2c_smbus_data data;
> +               u32 addr;
> +
> +               if (!of_node_name_prefix(node, node_name))
> +                       continue;
> +               if (of_property_read_u32(node, "reg", &addr))
> +                       continue;
> +               if (i2c_smbus_xfer(i2c, addr, 0, I2C_SMBUS_READ, 0, I2C_S=
MBUS_BYTE, &data) < 0)
> +                       continue;
> +
> +               dev_info(&pdev->dev, "Enabling %pOF\n", node);
> +
> +               prop =3D kzalloc(sizeof(*prop), GFP_KERNEL);
> +               if (!prop) {
> +                       ret =3D -ENOMEM;
> +                       of_node_put(node);
> +                       break;
> +               }
> +
> +               prop->name      =3D "status";
> +               prop->length    =3D 5;
> +               prop->value     =3D "okay";
> +
> +               /* Found a device that is responding */
> +               ret =3D of_update_property(node, prop);

Use the changeset API instead and make an update flavor of
of_changeset_add_prop_string().

> +               if (ret)
> +                       kfree(prop);
> +
> +               of_node_put(node);
> +               break;
> +       }
> +
> +       i2c_put_adapter(i2c);
> +       of_node_put(i2c_node);
> +
> +       return ret;
> +}
> +
> +static const struct hw_prober_entry hw_prober_platforms[] =3D {
> +       { .compatible =3D "google,hana", .prober =3D i2c_component_prober=
, .data =3D "touchscreen" },
> +       { .compatible =3D "google,hana", .prober =3D i2c_component_prober=
, .data =3D "trackpad" },

Not generic code. Needs to be somewhere else.

> +};
> +
> +static int hw_prober_probe(struct platform_device *pdev)
> +{
> +       for (int i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++)
> +               if (of_machine_is_compatible(hw_prober_platforms[i].compa=
tible)) {
> +                       int ret;
> +
> +                       ret =3D hw_prober_platforms[i].prober(pdev, hw_pr=
ober_platforms[i].data);
> +                       if (ret)
> +                               return ret;
> +               }
> +
> +       return 0;
> +}
> +
> +static struct platform_driver hw_prober_driver =3D {
> +       .probe  =3D hw_prober_probe,
> +       .driver =3D {
> +               .name =3D DRV_NAME,
> +       },
> +};
> +
> +static int __init hw_prober_driver_init(void)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       ret =3D platform_driver_register(&hw_prober_driver);
> +       if (ret)
> +               return ret;
> +
> +       pdev =3D platform_device_register_simple(DRV_NAME, -1, NULL, 0);

This should be dependent on platforms that need it, not everyone. IOW,
this is where checking for "google,hana" belongs.


Rob
