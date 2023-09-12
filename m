Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6279C946
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjILIHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjILIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:07:04 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91E10DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:06:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b53488f7cso42239727b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506005; x=1695110805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtWP+e9BEXC7w+RUyN/G8YnHnlnT3vcX+sG9NK3ox/I=;
        b=DEysX5LeZ/jYfjHDe2Zq6Uqme5ZHaJLzJe8GsYbgSLZbibMrlTmxNzRfFyBaj/0P1c
         cz9czjQDVLaKktuMv0NIneO+Q0tse058LJ2G4Cbt3lYz1mmRS5syYjBs3So/91pNuEdE
         EnLb2tayuxYxJ1fQn830xtXp8iQSfLlw2zpjvoVlucCVZ6x48nuEE+Dg4hKKZIzukjTG
         9pyA7Grj6URtH18ua+i4dWXVf9Gqup9/x7gB7quj0EoXrP+wpQy2H0gr/s7hnr+5Dc9X
         zh3QV30whKIpjsHIJ+dChCSNO7t3WYfPeYRZxmzBlktOq0gyFmTbx4aTAMXlTa8Xxk5Q
         wIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506005; x=1695110805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtWP+e9BEXC7w+RUyN/G8YnHnlnT3vcX+sG9NK3ox/I=;
        b=CG3Rruevl/RRWU3nG0RRnjlGZ2qWoA3wFfAPhrHnFCkoPGKdAG8JWldQbcgpfq9N7L
         oC7HpQbYVQ7OzpgJtwakaOKSX7L12S6keEQNZ+dUg+R3A6Yr/W1t43UmgH3SNBWVN+Bs
         fs3pkQi6o/IvKTZP8RzatxpqHnGKOZvsc9hdQFaRujut7ONolZmi7A+6FfO3sRLeoNyK
         U62hOeWiL4mMbYhid0Rlox0DAUHuot+vViuqLPqpAqJYOVOXrxuGSjlWD62tc4N2W1JE
         A8HhjRyNAVDxOVFSwBkv2nRD1c0ahx8Cbn6dFxUoeHCj6gOGOc8eQc28jWreexIgYYDP
         pGqA==
X-Gm-Message-State: AOJu0YymiDSkwJSIQVH9o1U2H7woHDTmgQmhRZtOjOB7iZCy1mS9Et5A
        xLim4D70csiTpE3Vj93BjksK9BNEUqMxUX83rhAXig==
X-Google-Smtp-Source: AGHT+IEHrf6SFndkCb20FJCAo20fAKD8jp+yhf85lxl1eNtTsw7mK+na3Y1LgXrzLJhEEtRUNOqoM1uj91TQOZkad/w=
X-Received: by 2002:a25:844c:0:b0:d09:377a:7bf7 with SMTP id
 r12-20020a25844c000000b00d09377a7bf7mr11592083ybm.16.1694506005187; Tue, 12
 Sep 2023 01:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230904115816.1237684-1-s.hauer@pengutronix.de> <20230904115816.1237684-2-s.hauer@pengutronix.de>
In-Reply-To: <20230904115816.1237684-2-s.hauer@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:06:34 +0200
Message-ID: <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain dependency
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Top posting to bring Saravana Kannan into this discussion.

This looks like a big hack to me, Saravana has been working
tirelessly to make the device tree probe order "sort itself out"
and I am pretty sure this issue needs to be fixed at the DT
core level and not in a driver.

Saravana, can you advice how we should handle this properly?

Yours,
Linus Walleij

On Mon, Sep 4, 2023 at 1:58=E2=80=AFPM Sascha Hauer <s.hauer@pengutronix.de=
> wrote:
>
> On some Rockchip SoCs, some SoC pins are split in what are called IO
> domains.
>
> An IO domain is supplied power externally, by regulators from a PMIC for
> example. This external power supply is then used by the IO domain as
> "supply" for the IO pins if they are outputs.
>
> Each IO domain can configure which voltage the IO pins will be operating
> on (1.8V or 3.3V).
>
> There already exists an IO domain driver for Rockchip SoCs[1]. This
> driver allows to explicit the relationship between the external power
> supplies and IO domains[2]. This makes sure the regulators are enabled
> by the Linux kernel so the IO domains are supplied with power and
> correctly configured as per the supplied voltage.
> This driver is a regulator consumer and does not offer any other
> interface for device dependency.
>
> However, IO pins belonging to an IO domain need to have this IO domain
> configured correctly before they are being used otherwise they do not
> operate correctly.
>
> We currently do not have any knowledge about which pin is on which IO
> domain, so we assume that all pins are on some IO domain and defer
> probing of the pin consumers until the IO domain driver has been probed.
> Some pins however are needed to access the regulators driving an IO
> domain. Deferring probe for them as well would introduce a cyclic
> dependency. To break out of this dependency a pin group can be supplied
> a rockchip,io-domain-boot-on property. Probe won't be deferred for pin
> groups with this property. rockchip,io-domain-boot-on should be added
> to all pin groups needed to access the PMIC driving the IO domains.
>
> [1] drivers/soc/rockchip/io-domain.c
> [2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 64 ++++++++++++++++++++++++++++++
>  drivers/pinctrl/pinctrl-rockchip.h |  3 ++
>  2 files changed, 67 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl=
-rockchip.c
> index 0276b52f37168..663bd9d6840a5 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -24,6 +24,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -2678,6 +2680,43 @@ static int rockchip_pmx_get_groups(struct pinctrl_=
dev *pctldev,
>         return 0;
>  }
>
> +static int rockchip_pmx_check_io_domain(struct rockchip_pinctrl *info, u=
nsigned group)
> +{
> +       struct platform_device *pdev;
> +       int i;
> +
> +       if (!info->io_domains)
> +               return 0;
> +
> +       if (info->groups[group].io_domain_skip)
> +               return 0;
> +
> +       for (i =3D 0; i < info->num_io_domains; i++) {
> +               if (!info->io_domains[i])
> +                       continue;
> +
> +               pdev =3D of_find_device_by_node(info->io_domains[i]);
> +               if (!pdev) {
> +                       dev_err(info->dev, "couldn't find IO domain devic=
e\n");
> +                       return -ENODEV;
> +               }
> +
> +               if (!platform_get_drvdata(pdev)) {
> +                       dev_err(info->dev, "IO domain device is not probe=
d yet, deferring...(%s)",
> +                               info->groups[group].name);
> +                       return -EPROBE_DEFER;
> +               }
> +
> +               of_node_put(info->io_domains[i]);
> +               info->io_domains[i] =3D NULL;
> +       }
> +
> +       devm_kfree(info->dev, info->io_domains);
> +       info->io_domains =3D NULL;
> +
> +       return 0;
> +}
> +
>  static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned select=
or,
>                             unsigned group)
>  {
> @@ -2691,6 +2730,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *pc=
tldev, unsigned selector,
>         dev_dbg(dev, "enable function %s group %s\n",
>                 info->functions[selector].name, info->groups[group].name)=
;
>
> +       ret =3D rockchip_pmx_check_io_domain(info, group);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * for each pin in the pin group selected, program the correspond=
ing
>          * pin function number in the config register.
> @@ -3019,6 +3062,8 @@ static int rockchip_pinctrl_parse_groups(struct dev=
ice_node *np,
>         if (!size || size % 4)
>                 return dev_err_probe(dev, -EINVAL, "wrong pins number or =
pins and configs should be by 4\n");
>
> +       grp->io_domain_skip =3D of_property_read_bool(np, "rockchip,io-do=
main-boot-on");
> +
>         grp->npins =3D size / 4;
>
>         grp->pins =3D devm_kcalloc(dev, grp->npins, sizeof(*grp->pins), G=
FP_KERNEL);
> @@ -3417,6 +3462,22 @@ static int rockchip_pinctrl_probe(struct platform_=
device *pdev)
>                         return PTR_ERR(info->regmap_pmu);
>         }
>
> +       info->num_io_domains =3D of_property_count_u32_elems(np, "rockchi=
p,io-domains");
> +       if (info->num_io_domains) {
> +               int i;
> +
> +               info->io_domains =3D devm_kmalloc_array(dev, info->num_io=
_domains,
> +                                                     sizeof(*info->io_do=
mains), GFP_KERNEL);
> +               if (!info->io_domains)
> +                       return -ENOMEM;
> +
> +               for (i =3D 0; i < info->num_io_domains; i++) {
> +                       info->io_domains[i] =3D of_parse_phandle(np, "roc=
kchip,io-domains", 0);
> +                       if (!info->io_domains[i])
> +                               return -EINVAL;
> +               }
> +       }
> +
>         ret =3D rockchip_pinctrl_register(pdev, info);
>         if (ret)
>                 return ret;
> @@ -3439,6 +3500,9 @@ static int rockchip_pinctrl_remove(struct platform_=
device *pdev)
>
>         of_platform_depopulate(&pdev->dev);
>
> +       for (i =3D 0; i < info->num_io_domains; i++)
> +               of_node_put(info->io_domains[i]);
> +
>         for (i =3D 0; i < info->ctrl->nr_banks; i++) {
>                 bank =3D &info->ctrl->pin_banks[i];
>
> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl=
-rockchip.h
> index 4759f336941ef..d2ac79b0a7bc4 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/pinctrl-rockchip.h
> @@ -435,6 +435,7 @@ struct rockchip_pin_group {
>         unsigned int                    npins;
>         unsigned int                    *pins;
>         struct rockchip_pin_config      *data;
> +       bool                            io_domain_skip;
>  };
>
>  /**
> @@ -462,6 +463,8 @@ struct rockchip_pinctrl {
>         unsigned int                    ngroups;
>         struct rockchip_pmx_func        *functions;
>         unsigned int                    nfunctions;
> +       struct device_node              **io_domains;
> +       int                             num_io_domains;
>  };
>
>  #endif
> --
> 2.39.2
>
