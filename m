Return-Path: <linux-kernel+bounces-32084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E93835649
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54E61F22E63
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E3376E8;
	Sun, 21 Jan 2024 15:25:21 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0ED374FB;
	Sun, 21 Jan 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705850721; cv=none; b=EI7PcIPQe9sTPXVjIQ4DpcA9kf+lJGTv951tFu7XW+NPG83X6lvx1nHty/3fniJpjSG1heIOlvE/r/e1gO3g0TnRy6ElCyv9pE0+tBFD0YScAf+wtOOEbHHWvXhiEtest32zhXgPgqK/vHrj33op2fgbY/mUwIto1DMuhIi4HTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705850721; c=relaxed/simple;
	bh=jGO81K2QgVEPQqbTMatCLa0toaJpWr0kDm/GsH1CW3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDuiXqbupiUJ8vHO+6aw1Uxm/8yWC8GKnEIXUz9y2Owl3MPovaFK4Ts93lbQ7tgUombbXub6Wx86ou8SNR4UkiVZy6aUXK8YZeTmBiFWTaNqIrJMV7bCE0ncHxe7EPM5C24ywMRlyAr3tf97U/3JIPo5dg8BiURsBYcPUtfJrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so545005a91.1;
        Sun, 21 Jan 2024 07:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705850718; x=1706455518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioCLCyK2xaIUJuYQNFoL0fsROPo2IIM04TY0gvr3Xo0=;
        b=mAN2k1sFuyQiMl/lxAEoNg/sksvqX7PSYofrjnn5BV2ph8mJwdx5Uq1qLKMEJJIrZk
         cOYAxG59AC0srhs3ZQ8m8mYBUmdnIX8B5vCVI/MTFwrS14nmyelaYtubskA9KAUf99GU
         MC/+UcfJd0wPS+oYCixuhgrFeGZWqJPTf3IuXpUhmDZrd6nyB3QHBFZhgFhpDooqs4Jp
         +cmfSWzJQb6Gmm8ZmfaNEf6MFoLkHaVxRi/i1la8l2U5Y8oXxur2pb4PWaNhZVdO2rqX
         8tXFf9iJpPMro1ooRD9XL2eCuGeWeonDvndCUCFxqZFyWruUPnp3pqPiTFkl6iS6a2Ew
         OYmg==
X-Gm-Message-State: AOJu0Yz6Pw/OGsn+OfrN34UXoa+AxreBTaOS6Ct+1ZY7d4C/IpBuGd87
	n8i8tnRjmy0u785JpQlH8nIfMrMGYTRHIIbQIzTjN8Qhi8p8xRU1TrUqtvkU
X-Google-Smtp-Source: AGHT+IEEZTPn+xoybNObp6lctvB8qDZcvMjO5uvtRXO7HRf851D4blVSn7MIqEFRlyJ3Zxf1DEEH1g==
X-Received: by 2002:a17:90b:3782:b0:28e:20d5:a047 with SMTP id mz2-20020a17090b378200b0028e20d5a047mr960588pjb.27.1705850717830;
        Sun, 21 Jan 2024 07:25:17 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id qj4-20020a17090b28c400b002906a444b2esm3237882pjb.7.2024.01.21.07.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 07:25:17 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6db05618c1fso2267561b3a.1;
        Sun, 21 Jan 2024 07:25:17 -0800 (PST)
X-Received: by 2002:a05:6a20:8929:b0:19b:6ec7:8f9a with SMTP id
 i41-20020a056a20892900b0019b6ec78f9amr2714082pzg.70.1705850717152; Sun, 21
 Jan 2024 07:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121014057.1042466-1-aren@peacevolution.org> <20240121014057.1042466-3-aren@peacevolution.org>
In-Reply-To: <20240121014057.1042466-3-aren@peacevolution.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 21 Jan 2024 23:25:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65QcP1bcT++51n7Ada6QvFmrQzqiA-b3tbzfAr3XC6XJQ@mail.gmail.com>
Message-ID: <CAGb2v65QcP1bcT++51n7Ada6QvFmrQzqiA-b3tbzfAr3XC6XJQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] power: supply: axp20x_usb_power: add input current limit
To: Aren Moynihan <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <j.w.r.degoede@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

+CC Hans de Goede since the AXP288 is similar to the later AXPs in the USB
power section.

On Sun, Jan 21, 2024 at 9:54=E2=80=AFAM Aren Moynihan <aren@peacevolution.o=
rg> wrote:
>
> Add properties for setting the maximum current that will be drawn from
> the usb connection.
>
> These changes don't apply to all axp20x chips, so we need to add new
> power_desc and power supply property objects for axp813 specifically.
> These are copied from the axp22x variants that were used before, with
> extra fields added.
>
> Also add a dev field to the axp20x_usb_power struct, so we can use
> dev_dbg and dev_err in more places.

I think this patch highlights some errors in the driver.

1. We are likely misusing POWER_SUPPLY_PROP_CURRENT_MAX. Based on the
   ABI docs, this is supposed to be a read only property. The correct
   way would be to use POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT as you did.

2. For AXP288 and AXP803/AXP813/AXP818, we are setting the current limit
   for when BC detection finishes in register 0x30, not the actual active
   limit in register 0x35. This should be fixed.

3. BC detection race condition

Could you maybe respin the patches to address them separately instead?


Thanks
ChenYu



> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
>
>  drivers/power/supply/axp20x_usb_power.c | 127 +++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index e23308ad4cc7..8c0c2c25565f 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -50,7 +50,10 @@ struct axp_data {
>         const char * const              *irq_names;
>         unsigned int                    num_irq_names;
>         const int                       *curr_lim_table;
> +       int                             input_curr_lim_table_size;
> +       const int                       *input_curr_lim_table;
>         struct reg_field                curr_lim_fld;
> +       struct reg_field                input_curr_lim_fld;
>         struct reg_field                vbus_valid_bit;
>         struct reg_field                vbus_mon_bit;
>         struct reg_field                usb_bc_en_bit;
> @@ -59,7 +62,9 @@ struct axp_data {
>  };
>
>  struct axp20x_usb_power {
> +       struct device *dev;
>         struct regmap *regmap;
> +       struct regmap_field *input_curr_lim_fld;
>         struct regmap_field *curr_lim_fld;
>         struct regmap_field *vbus_valid_bit;
>         struct regmap_field *vbus_mon_bit;
> @@ -115,6 +120,15 @@ static void axp20x_usb_power_poll_vbus(struct work_s=
truct *work)
>         if (val !=3D power->old_status)
>                 power_supply_changed(power->supply);
>
> +       if (power->usb_bc_en_bit && (val & AXP20X_PWR_STATUS_VBUS_PRESENT=
) !=3D
> +               (power->old_status & AXP20X_PWR_STATUS_VBUS_PRESENT)) {
> +               dev_dbg(power->dev, "Cable status changed, re-enabling US=
B BC");
> +               ret =3D regmap_field_write(power->usb_bc_en_bit, 1);
> +               if (ret)
> +                       dev_err(power->dev, "failed to enable USB BC: err=
no %d",
> +                               ret);
> +       }
> +
>         power->old_status =3D val;
>         power->online =3D val & AXP20X_PWR_STATUS_VBUS_USED;
>
> @@ -123,6 +137,66 @@ static void axp20x_usb_power_poll_vbus(struct work_s=
truct *work)
>                 mod_delayed_work(system_power_efficient_wq, &power->vbus_=
detect, DEBOUNCE_TIME);
>  }
>
> +static int
> +axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
> +                                        int limit)
> +{
> +       int ret;
> +       unsigned int reg;
> +
> +       if (!power->axp_data->input_curr_lim_table)
> +               return -EINVAL;
> +
> +       if (limit < power->axp_data->input_curr_lim_table[0])
> +               return -EINVAL;
> +
> +       /*
> +        * BC1.2 detection can cause a race condition if we try to set a =
current
> +        * limit while it's in progress. When it finishes it will overwri=
te the
> +        * current limit we just set.
> +        */
> +       if (power->usb_bc_en_bit) {
> +               dev_dbg(power->dev,
> +                       "disabling BC1.2 detection because current limit =
was set");
> +               ret =3D regmap_field_write(power->usb_bc_en_bit, 0);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       for (reg =3D power->axp_data->input_curr_lim_table_size - 1; reg =
> 0; reg--) {
> +               if (limit >=3D power->axp_data->input_curr_lim_table[reg]=
)
> +                       break;
> +       }
> +
> +       dev_dbg(power->dev, "setting input current limit reg to %d (%d uA=
), requested %d uA",
> +               reg, power->axp_data->input_curr_lim_table[reg], limit);
> +
> +       return regmap_field_write(power->input_curr_lim_fld, reg);
> +}
> +
> +static int
> +axp20x_usb_power_get_input_current_limit(struct axp20x_usb_power *power,
> +                                        int *intval)
> +{
> +       int ret;
> +       unsigned int v;
> +
> +       if (!power->axp_data->input_curr_lim_table)
> +               return -EINVAL;
> +
> +       ret =3D regmap_field_read(power->input_curr_lim_fld, &v);
> +       if (ret)
> +               return ret;
> +
> +       if (v < power->axp_data->input_curr_lim_table_size)
> +               *intval =3D power->axp_data->input_curr_lim_table[v];
> +       else
> +               *intval =3D power->axp_data->input_curr_lim_table[
> +                         power->axp_data->input_curr_lim_table_size - 1]=
;
> +
> +       return 0;
> +}
> +
>  static int axp20x_usb_power_get_property(struct power_supply *psy,
>         enum power_supply_property psp, union power_supply_propval *val)
>  {
> @@ -189,6 +263,9 @@ static int axp20x_usb_power_get_property(struct power=
_supply *psy,
>
>                 val->intval =3D ret * 375; /* 1 step =3D 0.375 mA */
>                 return 0;
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               return axp20x_usb_power_get_input_current_limit(power,
> +                                                               &val->int=
val);
>         default:
>                 break;
>         }
> @@ -290,6 +367,10 @@ static int axp20x_usb_power_set_property(struct powe=
r_supply *psy,
>         case POWER_SUPPLY_PROP_CURRENT_MAX:
>                 return axp20x_usb_power_set_current_max(power, val->intva=
l);
>
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               return axp20x_usb_power_set_input_current_limit(power,
> +                                                               val->intv=
al);
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -313,7 +394,8 @@ static int axp20x_usb_power_prop_writeable(struct pow=
er_supply *psy,
>                 return power->vbus_disable_bit !=3D NULL;
>
>         return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> -              psp =3D=3D POWER_SUPPLY_PROP_CURRENT_MAX;
> +              psp =3D=3D POWER_SUPPLY_PROP_CURRENT_MAX ||
> +              psp =3D=3D POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
>  }
>
>  static enum power_supply_property axp20x_usb_power_properties[] =3D {
> @@ -334,6 +416,15 @@ static enum power_supply_property axp22x_usb_power_p=
roperties[] =3D {
>         POWER_SUPPLY_PROP_CURRENT_MAX,
>  };
>
> +static enum power_supply_property axp813_usb_power_properties[] =3D {
> +       POWER_SUPPLY_PROP_HEALTH,
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +       POWER_SUPPLY_PROP_CURRENT_MAX,
> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
>  static const struct power_supply_desc axp20x_usb_power_desc =3D {
>         .name =3D "axp20x-usb",
>         .type =3D POWER_SUPPLY_TYPE_USB,
> @@ -354,6 +445,16 @@ static const struct power_supply_desc axp22x_usb_pow=
er_desc =3D {
>         .set_property =3D axp20x_usb_power_set_property,
>  };
>
> +static const struct power_supply_desc axp813_usb_power_desc =3D {
> +       .name =3D "axp20x-usb",
> +       .type =3D POWER_SUPPLY_TYPE_USB,
> +       .properties =3D axp813_usb_power_properties,
> +       .num_properties =3D ARRAY_SIZE(axp813_usb_power_properties),
> +       .property_is_writeable =3D axp20x_usb_power_prop_writeable,
> +       .get_property =3D axp20x_usb_power_get_property,
> +       .set_property =3D axp20x_usb_power_set_property,
> +};
> +
>  static const char * const axp20x_irq_names[] =3D {
>         "VBUS_PLUGIN",
>         "VBUS_REMOVAL",
> @@ -394,6 +495,18 @@ static int axp813_usb_curr_lim_table[] =3D {
>         2500000,
>  };
>
> +static int axp_813_usb_input_curr_lim_table[] =3D {
> +       100000,
> +       500000,
> +       900000,
> +       1500000,
> +       2000000,
> +       2500000,
> +       3000000,
> +       3500000,
> +       4000000,
> +};
> +
>  static const struct axp_data axp192_data =3D {
>         .power_desc     =3D &axp20x_usb_power_desc,
>         .irq_names      =3D axp20x_irq_names,
> @@ -433,11 +546,14 @@ static const struct axp_data axp223_data =3D {
>  };
>
>  static const struct axp_data axp813_data =3D {
> -       .power_desc     =3D &axp22x_usb_power_desc,
> +       .power_desc     =3D &axp813_usb_power_desc,
>         .irq_names      =3D axp22x_irq_names,
>         .num_irq_names  =3D ARRAY_SIZE(axp22x_irq_names),
>         .curr_lim_table =3D axp813_usb_curr_lim_table,
>         .curr_lim_fld   =3D REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
> +       .input_curr_lim_table_size =3D ARRAY_SIZE(axp_813_usb_input_curr_=
lim_table),
> +       .input_curr_lim_table =3D axp_813_usb_input_curr_lim_table,
> +       .input_curr_lim_fld =3D REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
>         .usb_bc_en_bit  =3D REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
>         .vbus_disable_bit =3D REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
>         .vbus_needs_polling =3D true,
> @@ -558,6 +674,7 @@ static int axp20x_usb_power_probe(struct platform_dev=
ice *pdev)
>
>         platform_set_drvdata(pdev, power);
>
> +       power->dev =3D &pdev->dev;
>         power->axp_data =3D axp_data;
>         power->regmap =3D axp20x->regmap;
>         power->num_irqs =3D axp_data->num_irq_names;
> @@ -567,6 +684,12 @@ static int axp20x_usb_power_probe(struct platform_de=
vice *pdev)
>         if (IS_ERR(power->curr_lim_fld))
>                 return PTR_ERR(power->curr_lim_fld);
>
> +       ret =3D axp20x_regmap_field_alloc_optional(&pdev->dev, power->reg=
map,
> +                                                axp_data->input_curr_lim=
_fld,
> +                                                &power->input_curr_lim_f=
ld);
> +       if (ret)
> +               return ret;
> +
>         ret =3D axp20x_regmap_field_alloc_optional(&pdev->dev, power->reg=
map,
>                                                  axp_data->vbus_valid_bit=
,
>                                                  &power->vbus_valid_bit);
> --
> 2.43.0
>

