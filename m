Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8779DDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbjIMBhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbjIMBht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:37:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A51718
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:37:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-414ba610766so159061cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694569064; x=1695173864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxWuYsut4FkcRv6aXGbdeRPZmFAkot9jrI3/mToBnLc=;
        b=A3CsOLh0gvgOzLt5Y+E2zNZhhCNOwbZfHv7pcrd/6rXJKSXoLEIAlv9jx8jFyToKFr
         9yfRn+6LoPex16vxm3hjpFxkCfOjoHm84knLa0yqHpk0IWJAdA7t6W51zUvIdN81NGTC
         NRQ3Rfsy7cLO7LwXs1amQY3PfPoW7UahHAjOp5R6Y9NODL419zJVnls+hbbxmPYnOLS7
         mxuW/KaJjh61FhZF8+otOmAGq71Z47D5Zf0FrKzxlzzaPubUAZ4aW1hLSVX0XpM8bN0Z
         G2FAYRrsq+rOC7HDovXHhy+TTfD+eSQn3et4BExgi0JGIbqwlkOivBfY4/A3I5IsB1hi
         7KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694569064; x=1695173864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxWuYsut4FkcRv6aXGbdeRPZmFAkot9jrI3/mToBnLc=;
        b=gGNSQh6QVM3hLekCoyO3H1CNkkNUAyHCQHn/r73hXLPXRdCn9lyIqKy+l7XMIRJYn7
         3uyj5uXdYwdRHTC3AZuUxCXkVpk04Osj+ob5s8YGNNky/VDqjhZ0tkpCHp5p9HB7viYq
         evVcrARKNtdOGQgz+xQW9foxydsnmUPGffCi4SyrAgGkHMsG3bX2C6yqZBmUwdKgfs3i
         UymT7lJuWgiNsITVAXI3QRXn428xNSHzSucAfdJtgnGDPuP9YMuKjw8zjT/kov7ydPnv
         N8NOIi440JQhVenjdSnAK3PazKJAYqqjatvyj1ig+16N6TomR0bHsZO/GlsX2qO5T9Zf
         vZDQ==
X-Gm-Message-State: AOJu0YzSdr4+d2cQXJlNEzyF0ViF8NjYZOegBBUfrMGJmdSVBnRSL2/x
        PK2xVi3H4B6dF/zE9DLDJHTxYTjpsWQZwhkiNWzMog==
X-Google-Smtp-Source: AGHT+IH3EjYKgP1ixyn3SUhnIocHGW1DFs2bD0ibIdaTWxT4Ius1Fs23iJI7yI1lkiWt5hChdxzb/lb1ScK0zeZICJg=
X-Received: by 2002:ac8:7f4f:0:b0:403:e1d1:8b63 with SMTP id
 g15-20020ac87f4f000000b00403e1d18b63mr161099qtk.24.1694569063779; Tue, 12 Sep
 2023 18:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de> <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
In-Reply-To: <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 12 Sep 2023 18:37:07 -0700
Message-ID: <CAGETcx-_84ki6wHkeg5CtED1ak+F4qNtvhYMcwRAC=2Thw=gyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain dependency
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 1:06=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Top posting to bring Saravana Kannan into this discussion.
>
> This looks like a big hack to me, Saravana has been working
> tirelessly to make the device tree probe order "sort itself out"
> and I am pretty sure this issue needs to be fixed at the DT
> core level and not in a driver.
>
> Saravana, can you advice how we should handle this properly?

Thanks for looping me in. More comments inline.


> Yours,
> Linus Walleij
>
> On Mon, Sep 4, 2023 at 1:58=E2=80=AFPM Sascha Hauer <s.hauer@pengutronix.=
de> wrote:
> >
> > On some Rockchip SoCs, some SoC pins are split in what are called IO
> > domains.
> >
> > An IO domain is supplied power externally, by regulators from a PMIC fo=
r
> > example. This external power supply is then used by the IO domain as
> > "supply" for the IO pins if they are outputs.
> >
> > Each IO domain can configure which voltage the IO pins will be operatin=
g
> > on (1.8V or 3.3V).
> >
> > There already exists an IO domain driver for Rockchip SoCs[1]. This
> > driver allows to explicit the relationship between the external power
> > supplies and IO domains[2]. This makes sure the regulators are enabled
> > by the Linux kernel so the IO domains are supplied with power and
> > correctly configured as per the supplied voltage.
> > This driver is a regulator consumer and does not offer any other
> > interface for device dependency.
> >
> > However, IO pins belonging to an IO domain need to have this IO domain
> > configured correctly before they are being used otherwise they do not
> > operate correctly.
> >
> > We currently do not have any knowledge about which pin is on which IO
> > domain, so we assume that all pins are on some IO domain and defer
> > probing of the pin consumers until the IO domain driver has been probed=
.
> > Some pins however are needed to access the regulators driving an IO
> > domain. Deferring probe for them as well would introduce a cyclic
> > dependency.

It took me a while to understand what's going on with the pinctrl
framework (I'm not too familiar with it) and the rockchip io-domain
driver.

The cyclic dependency seems to be something like this:
pinctrl -> pmu_io_domains -> rk809: pmic@20 -> pinctrl (maybe through
the i2c parent device?).

However, the problem here seems to be that the probe order needs to be
something like:

1. pinctrl registers with pinctrl framework and probes successfully.
2. Defer all pinctrl consumers except rk809.
3. rk809 probes
4. IO domain device probes.
5. Allow the rest of the consumers of pinctrl to probe because the IO
domain device has probed now.

At least in the current state, fw_devlink can't solve this because we
are asking to defer consumers of pinctrl AFTER pinctrl claims it has
successfully probed.

The only way I can think of fixing this at a framework level is to:
1. Add io-domain dependency to all the pins that depend on the pmu_io_domai=
ns.
2. Convert each of the struct pin_desc to be a device (feels like an overki=
ll).
3. Add the pin_desc device to a pin_desc bus and have a probe function
that makes the pin "available" for consumers.
3. fw_devlink can make sure pin_desc doesn't probe until the io-domain is r=
eady.

I'll think more about this tomorrow, but this is the best I can come
up with after staring at it for a couple of hours.

-Saravana

> > To break out of this dependency a pin group can be supplied
> > a rockchip,io-domain-boot-on property. Probe won't be deferred for pin
> > groups with this property. rockchip,io-domain-boot-on should be added
> > to all pin groups needed to access the PMIC driving the IO domains.
> >
> > [1] drivers/soc/rockchip/io-domain.c
> > [2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/pinctrl/pinctrl-rockchip.c | 64 ++++++++++++++++++++++++++++++
> >  drivers/pinctrl/pinctrl-rockchip.h |  3 ++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinct=
rl-rockchip.c
> > index 0276b52f37168..663bd9d6840a5 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/pinctrl/machine.h>
> >  #include <linux/pinctrl/pinconf.h>
> >  #include <linux/pinctrl/pinctrl.h>
> > @@ -2678,6 +2680,43 @@ static int rockchip_pmx_get_groups(struct pinctr=
l_dev *pctldev,
> >         return 0;
> >  }
> >
> > +static int rockchip_pmx_check_io_domain(struct rockchip_pinctrl *info,=
 unsigned group)
> > +{
> > +       struct platform_device *pdev;
> > +       int i;
> > +
> > +       if (!info->io_domains)
> > +               return 0;
> > +
> > +       if (info->groups[group].io_domain_skip)
> > +               return 0;
> > +
> > +       for (i =3D 0; i < info->num_io_domains; i++) {
> > +               if (!info->io_domains[i])
> > +                       continue;
> > +
> > +               pdev =3D of_find_device_by_node(info->io_domains[i]);
> > +               if (!pdev) {
> > +                       dev_err(info->dev, "couldn't find IO domain dev=
ice\n");
> > +                       return -ENODEV;
> > +               }
> > +
> > +               if (!platform_get_drvdata(pdev)) {
> > +                       dev_err(info->dev, "IO domain device is not pro=
bed yet, deferring...(%s)",
> > +                               info->groups[group].name);
> > +                       return -EPROBE_DEFER;
> > +               }
> > +
> > +               of_node_put(info->io_domains[i]);
> > +               info->io_domains[i] =3D NULL;
> > +       }
> > +
> > +       devm_kfree(info->dev, info->io_domains);
> > +       info->io_domains =3D NULL;
> > +
> > +       return 0;
> > +}
> > +
> >  static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned sele=
ctor,
> >                             unsigned group)
> >  {
> > @@ -2691,6 +2730,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *=
pctldev, unsigned selector,
> >         dev_dbg(dev, "enable function %s group %s\n",
> >                 info->functions[selector].name, info->groups[group].nam=
e);
> >
> > +       ret =3D rockchip_pmx_check_io_domain(info, group);
> > +       if (ret)
> > +               return ret;
> > +
> >         /*
> >          * for each pin in the pin group selected, program the correspo=
nding
> >          * pin function number in the config register.
> > @@ -3019,6 +3062,8 @@ static int rockchip_pinctrl_parse_groups(struct d=
evice_node *np,
> >         if (!size || size % 4)
> >                 return dev_err_probe(dev, -EINVAL, "wrong pins number o=
r pins and configs should be by 4\n");
> >
> > +       grp->io_domain_skip =3D of_property_read_bool(np, "rockchip,io-=
domain-boot-on");
> > +
> >         grp->npins =3D size / 4;
> >
> >         grp->pins =3D devm_kcalloc(dev, grp->npins, sizeof(*grp->pins),=
 GFP_KERNEL);
> > @@ -3417,6 +3462,22 @@ static int rockchip_pinctrl_probe(struct platfor=
m_device *pdev)
> >                         return PTR_ERR(info->regmap_pmu);
> >         }
> >
> > +       info->num_io_domains =3D of_property_count_u32_elems(np, "rockc=
hip,io-domains");
> > +       if (info->num_io_domains) {
> > +               int i;
> > +
> > +               info->io_domains =3D devm_kmalloc_array(dev, info->num_=
io_domains,
> > +                                                     sizeof(*info->io_=
domains), GFP_KERNEL);
> > +               if (!info->io_domains)
> > +                       return -ENOMEM;
> > +
> > +               for (i =3D 0; i < info->num_io_domains; i++) {
> > +                       info->io_domains[i] =3D of_parse_phandle(np, "r=
ockchip,io-domains", 0);
> > +                       if (!info->io_domains[i])
> > +                               return -EINVAL;
> > +               }
> > +       }
> > +
> >         ret =3D rockchip_pinctrl_register(pdev, info);
> >         if (ret)
> >                 return ret;
> > @@ -3439,6 +3500,9 @@ static int rockchip_pinctrl_remove(struct platfor=
m_device *pdev)
> >
> >         of_platform_depopulate(&pdev->dev);
> >
> > +       for (i =3D 0; i < info->num_io_domains; i++)
> > +               of_node_put(info->io_domains[i]);
> > +
> >         for (i =3D 0; i < info->ctrl->nr_banks; i++) {
> >                 bank =3D &info->ctrl->pin_banks[i];
> >
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinct=
rl-rockchip.h
> > index 4759f336941ef..d2ac79b0a7bc4 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.h
> > +++ b/drivers/pinctrl/pinctrl-rockchip.h
> > @@ -435,6 +435,7 @@ struct rockchip_pin_group {
> >         unsigned int                    npins;
> >         unsigned int                    *pins;
> >         struct rockchip_pin_config      *data;
> > +       bool                            io_domain_skip;
> >  };
> >
> >  /**
> > @@ -462,6 +463,8 @@ struct rockchip_pinctrl {
> >         unsigned int                    ngroups;
> >         struct rockchip_pmx_func        *functions;
> >         unsigned int                    nfunctions;
> > +       struct device_node              **io_domains;
> > +       int                             num_io_domains;
> >  };
> >
> >  #endif
> > --
> > 2.39.2
> >
