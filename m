Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA17AA559
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjIUW4I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjIUWzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:55:48 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91FA4A32D;
        Thu, 21 Sep 2023 10:14:24 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so1111729b3a.2;
        Thu, 21 Sep 2023 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316381; x=1695921181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAHKG7R+6lgDEExNMzQpuzImNL/hQIVkiU8H9tQe9qs=;
        b=qn1ShQ654vea/JyspgXm4BKzvAq1BI2+RQRKH9d3X0FIb2IiFf78005+9QVVMR6DlV
         ZKKfkDmQCaVjdinLXXlQ3CPGr38xNL2WqGA+f7tWjjaoxnfuLWfx0o1y2S9zJzZiQ3al
         h0BwA1r5Yv6BWpALyu5fRMtQHjBc03w6taidVd+sblAVBuUZe+KLhg/vj3DZIkSc9w8P
         C9bgEbQVCSvoMRCI2pMHjYYaM+rVnfrFMzK7yNOPQP1vPU/MXer2l/5dDZ1dUPdyHGZF
         r+LxrKQISxijzkRWLZjufc7I2GGlMPvTKxa86vGr/bE88Pwbcw7y0OQCW3lX7sQcneLL
         IAuw==
X-Gm-Message-State: AOJu0YxrDsTmr0Ae1sXNZ/bqQ6LRvLvcW87XWDrJEXGudQejZCDJbQDL
        vCyzPvEjTtkzVasgHhAZxMbTS/9Q0S5R664I
X-Google-Smtp-Source: AGHT+IE+DSffpVBY2fAYdjK9RqpHWFHeAABPgDSQcgdEstjFSu4XhYPWPAjjeOKcf3AXtNokRlDirA==
X-Received: by 2002:a25:850e:0:b0:d0a:a1fa:b8e4 with SMTP id w14-20020a25850e000000b00d0aa1fab8e4mr5651126ybk.38.1695301687803;
        Thu, 21 Sep 2023 06:08:07 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id z17-20020a258691000000b00d7e3e42d0c4sm308412ybk.53.2023.09.21.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 06:08:07 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59ed7094255so11814607b3.3;
        Thu, 21 Sep 2023 06:08:07 -0700 (PDT)
X-Received: by 2002:a81:c213:0:b0:58f:bda3:8dd with SMTP id
 z19-20020a81c213000000b0058fbda308ddmr5534159ywc.32.1695301687169; Thu, 21
 Sep 2023 06:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-28-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-28-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 15:07:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfa_vre2Y0nOwST4FZ5D8NZj7cOmhrvk+MaMTjNYM+uA@mail.gmail.com>
Message-ID: <CAMuHMdWfa_vre2Y0nOwST4FZ5D8NZj7cOmhrvk+MaMTjNYM+uA@mail.gmail.com>
Subject: Re: [PATCH 27/37] pinctrl: renesas: rzg2l: add support for different
 ds values on different groups
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch!

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S supports different drive strenght values for different power sources

strength

> and pin groups (A, B, C). On each group there could be up to 4 drive
> strength values per power source. Available power sources are 1v8, 2v5,
> 3v3. Drive strength values are fine tuned than what was previously
> available on the driver thus the necessity of having micro-amp support.
> As drive strength and power source values are linked togheter the

together

> hardware setup for these was moved at the end of
> rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
> values.
>
> The drive strength values are expected to be initialized though SoC
> specific hardware configuration data structure.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c

> @@ -133,27 +135,40 @@ struct rzg2l_register_offsets {
>         u16 sd_ch;
>  };
>
> +/* Value to be passed on drive strength arrays as invalid value. */
> +#define RZG2L_INVALID_IOLH_VAL (0xffff)

I think you can do without this (see below).

> +
>  /**
>   * enum rzg2l_iolh_index - starting indexes in IOLH specific arrays
> + * @RZG2L_IOLH_IDX_1V8: starting index for 1V8 power source
> + * @RZG2L_IOLH_IDX_2V5: starting index for 2V5 power source
>   * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
>   * @RZG2L_IOLH_IDX_MAX: maximum index
>   */
>  enum rzg2l_iolh_index {
> -       RZG2L_IOLH_IDX_3V3 = 0,
> -       RZG2L_IOLH_IDX_MAX = 4,
> +       RZG2L_IOLH_IDX_1V8 = 0,
> +       RZG2L_IOLH_IDX_2V5 = 4,
> +       RZG2L_IOLH_IDX_3V3 = 8,
> +       RZG2L_IOLH_IDX_MAX = 12,
>  };
>
>  /**
>   * struct rzg2l_hwcfg - hardware configuration data structure
>   * @regs: hardware specific register offsets
>   * @iolh_groupa_ua: IOLH group A micro amps specific values
> + * @iolh_groupb_ua: IOLH group B micro amps specific values
> + * @iolh_groupc_ua: IOLH group C micro amps specific values

uA

>   * @iolh_groupb_oi: IOLH group B output impedance specific values
> + * @drive_strength_ua: driver strenght in ua is supported (otherwise mA is supported)

drive strength in uA

>   * @func_base: base number for port function (see register PFC)
>   */
>  struct rzg2l_hwcfg {
>         const struct rzg2l_register_offsets regs;
>         u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
> +       u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
> +       u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
>         u16 iolh_groupb_oi[RZG2L_IOLH_IDX_MAX];
> +       bool drive_strength_ua;
>         u8 func_base;
>  };
>

> @@ -555,6 +584,164 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
>         spin_unlock_irqrestore(&pctrl->lock, flags);
>  }
>
> +static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps)
> +{
> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
> +       const struct rzg2l_register_offsets *regs = &hwcfg->regs;
> +       unsigned long flags;
> +       void __iomem *addr;
> +       u32 pwr_reg;
> +       u16 ps;
> +
> +       if (caps & PIN_CFG_IO_VMC_SD0)
> +               pwr_reg = SD_CH(regs->sd_ch, 0);
> +       else if (caps & PIN_CFG_IO_VMC_SD1)
> +               pwr_reg = SD_CH(regs->sd_ch, 1);
> +       else if (caps & PIN_CFG_IO_VMC_QSPI)
> +               pwr_reg = QSPI;
> +       else if (!(caps & PIN_CFG_SOFT_PS))
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&pctrl->lock, flags);

No need to take this spinlock
(it was just moved, and wasn't needed before).

> +       if (caps & PIN_CFG_SOFT_PS) {
> +               ps = pctrl->settings[pin].power_source;
> +       } else {
> +               addr = pctrl->base + pwr_reg;
> +               ps = (readl(addr) & PVDD_MASK) ? 1800 : 3300;
> +       }
> +       spin_unlock_irqrestore(&pctrl->lock, flags);

I think the above can be simplified using a new caps_to_pwr_reg()
helper:

    if (caps & PIN_CFG_SOFT_PS)
                return pctrl->settings[pin].power_source;

    addr = pctrl->base + caps_to_pwr_reg(caps);
    if (addr == (u32)-1)
            return -EINVAL;

    return (readl(addr) & PVDD_MASK) ? 1800 : 3300;

BTW, if it wasn't for the initialization of settings[pin].power_source
in rzg2l_pinctrl_register() using rzg2l_get_power_source() too, you
could always return the cached value.

> +
> +       return ps;
> +}
> +
> +static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps, u32 ps)
> +{
> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
> +       const struct rzg2l_register_offsets *regs = &hwcfg->regs;
> +       unsigned long flags;
> +       void __iomem *addr;
> +       u32 pwr_reg;
> +
> +       if (caps & PIN_CFG_IO_VMC_SD0)
> +               pwr_reg = SD_CH(regs->sd_ch, 0);
> +       else if (caps & PIN_CFG_IO_VMC_SD1)
> +               pwr_reg = SD_CH(regs->sd_ch, 1);
> +       else if (caps & PIN_CFG_IO_VMC_QSPI)
> +               pwr_reg = QSPI;
> +       else if (!(caps & PIN_CFG_SOFT_PS))
> +               return -EINVAL;
> +
> +       addr = pctrl->base + pwr_reg;
> +       spin_lock_irqsave(&pctrl->lock, flags);
> +       if (!(caps & PIN_CFG_SOFT_PS))
> +               writel((ps == 1800) ? PVDD_1800 : PVDD_3300, addr);
> +       pctrl->settings[pin].power_source = ps;
> +       spin_unlock_irqrestore(&pctrl->lock, flags);

No need to take this spinlock
(it was just moved, and wasn't needed before).

> +
> +       return 0;

This function can be simplified in a similar way.

> +}

> +static u16 rzg2l_iolh_ua_to_val(const struct rzg2l_hwcfg *hwcfg, u32 caps,
> +                               enum rzg2l_iolh_index ps_index, u16 ua)
> +{
> +       const u16 *array = NULL;
> +       u16 i;
> +
> +       if (caps & PIN_CFG_IOLH_A)
> +               array = &hwcfg->iolh_groupa_ua[ps_index];
> +
> +       if (caps & PIN_CFG_IOLH_B)
> +               array = &hwcfg->iolh_groupb_ua[ps_index];
> +
> +       if (caps & PIN_CFG_IOLH_C)
> +               array = &hwcfg->iolh_groupc_ua[ps_index];
> +
> +       if (!array)
> +               return RZG2L_INVALID_IOLH_VAL;

Just make the function return int, and return -EINVAL.

> +
> +       for (i = 0; i < 4; i++) {
> +               if (array[i] == ua)
> +                       return i;
> +       }
> +
> +       return RZG2L_INVALID_IOLH_VAL;
> +}
> +
> +static bool rzg2l_ds_supported(struct rzg2l_pinctrl *pctrl, u32 caps,

rzg2l_ds_is_supported(), for consistency with rzg2l_ps_is_supported()

> +                              enum rzg2l_iolh_index iolh_idx,
> +                              u16 ds)
> +{
> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
> +       const u16 *array = NULL;
> +       u16 i;
> +
> +       if (caps & PIN_CFG_IOLH_A)
> +               array = hwcfg->iolh_groupa_ua;
> +
> +       if (caps & PIN_CFG_IOLH_B)
> +               array = hwcfg->iolh_groupb_ua;
> +
> +       if (caps & PIN_CFG_IOLH_C)
> +               array = hwcfg->iolh_groupc_ua;
> +
> +       /* Should not happen. */
> +       if (!array)
> +               return false;
> +
> +       if (array[iolh_idx] == RZG2L_INVALID_IOLH_VAL)

If zero uA is considered an invalid value, this can be simplified to

    if (!array[iolh_idx])

> +               return false;
> +
> +       for (i = 0; i < 4; i++) {
> +               if (array[iolh_idx + i] == ds)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>                                      unsigned int _pin,
>                                      unsigned long *config)

> @@ -594,40 +779,50 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>                         return -EINVAL;
>                 break;
>
> -       case PIN_CONFIG_POWER_SOURCE: {
> -               u32 pwr_reg = 0x0;
> -
> -               if (cfg & PIN_CFG_IO_VMC_SD0)
> -                       pwr_reg = SD_CH(regs->sd_ch, 0);
> -               else if (cfg & PIN_CFG_IO_VMC_SD1)
> -                       pwr_reg = SD_CH(regs->sd_ch, 1);
> -               else if (cfg & PIN_CFG_IO_VMC_QSPI)
> -                       pwr_reg = QSPI;
> -               else
> -                       return -EINVAL;
> -
> -               spin_lock_irqsave(&pctrl->lock, flags);
> -               addr = pctrl->base + pwr_reg;
> -               arg = (readl(addr) & PVDD_MASK) ? 1800 : 3300;
> -               spin_unlock_irqrestore(&pctrl->lock, flags);
> +       case PIN_CONFIG_POWER_SOURCE:
> +               ret = rzg2l_get_power_source(pctrl, _pin, cfg);
> +               if (ret < 0)
> +                       return ret;
> +               arg = ret;
>                 break;
> -       }
>
>         case PIN_CONFIG_DRIVE_STRENGTH: {
>                 unsigned int index;
>
> -               if (!(cfg & PIN_CFG_IOLH_A))
> +               if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
>                         return -EINVAL;
>
>                 index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
> +               /*
> +                * Drive strenght mA is supported only by group A and only
> +                * for 3V3 port source.
> +                */
>                 arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
>                 break;
>         }
>
> +       case PIN_CONFIG_DRIVE_STRENGTH_UA: {
> +               enum rzg2l_iolh_index iolh_idx;
> +               u8 val;
> +
> +               if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
> +                   !hwcfg->drive_strength_ua)
> +                       return -EINVAL;
> +
> +               ret = rzg2l_get_power_source(pctrl, _pin, cfg);
> +               if (ret < 0)
> +                       return ret;
> +               iolh_idx = rzg2l_ps_to_iolh_idx(ret);
> +               val = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
> +               arg = rzg2l_iolh_val_to_ua(hwcfg, cfg, iolh_idx + val);
> +               break;
> +       }
> +
>         case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
>                 unsigned int index;
>
> -               if (!(cfg & PIN_CFG_IOLH_B))
> +               if (!(cfg & PIN_CFG_IOLH_B) ||
> +                   hwcfg->iolh_groupb_oi[0] == RZG2L_INVALID_IOLH_VAL)

    !hwcfg->iolh_groupb_oi[0]

>                         return -EINVAL;
>
>                 index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);

> @@ -730,11 +904,20 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>                         break;
>                 }
>
> +               case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +                       if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
> +                           !hwcfg->drive_strength_ua)
> +                               return -EINVAL;
> +
> +                       settings.drive_strength_ua = pinconf_to_config_argument(_configs[i]);
> +                       break;
> +
>                 case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
>                         unsigned int arg = pinconf_to_config_argument(_configs[i]);
>                         unsigned int index;
>
> -                       if (!(cfg & PIN_CFG_IOLH_B))
> +                       if (!(cfg & PIN_CFG_IOLH_B) ||
> +                           hwcfg->iolh_groupb_oi[0] == RZG2L_INVALID_IOLH_VAL)

!iolh_groupb_oi[0]

>                                 return -EINVAL;
>
>                         for (index = 0; index < ARRAY_SIZE(hwcfg->iolh_groupb_oi); index++) {
> @@ -753,6 +936,47 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>                 }
>         }
>
> +       /* Apply drive strength and power source. */
> +       if (memcmp(&settings, &pctrl->settings[_pin], sizeof(settings))) {

I'd rather invert the logic and return early here, so you can decrease
indentation below...

> +               enum rzg2l_iolh_index iolh_idx;
> +               unsigned long flags;
> +               int ret;
> +               u16 val;
> +
> +               if (settings.power_source == pctrl->settings[_pin].power_source)
> +                       goto apply_drive_strength;

... and invert the logic here to avoid the goto:

    if (settings.power_source != pctrl->settings[_pin].power_source)) {
            ...
> +
> +               ret = rzg2l_ps_is_supported(settings.power_source);
> +               if (!ret)
> +                       return -EINVAL;
> +
> +               /* Apply power source. */
> +               ret = rzg2l_set_power_source(pctrl, _pin, cfg, settings.power_source);
> +               if (ret)
> +                       return ret;
> +

    }

> +apply_drive_strength:
> +               if (settings.drive_strength_ua == pctrl->settings[_pin].drive_strength_ua)
> +                       return 0;

Same here:

    if (settings.drive_strength_ua != pctrl->settings[_pin].drive_strength_ua) {
            ...

> +
> +               iolh_idx = rzg2l_ps_to_iolh_idx(settings.power_source);
> +               ret = rzg2l_ds_supported(pctrl, cfg, iolh_idx,
> +                                        settings.drive_strength_ua);
> +               if (!ret)
> +                       return -EINVAL;
> +
> +               /* Get register value for this PS/DS tuple. */
> +               val = rzg2l_iolh_ua_to_val(hwcfg, cfg, iolh_idx, settings.drive_strength_ua);
> +               if (val == RZG2L_INVALID_IOLH_VAL)
> +                       return -EINVAL;

Make val int, and return val if it is a negative error code.

> +
> +               /* Apply drive strength. */
> +               rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, val);
> +               spin_lock_irqsave(&pctrl->lock, flags);
> +               pctrl->settings[_pin].drive_strength_ua = settings.drive_strength_ua;
> +               spin_unlock_irqrestore(&pctrl->lock, flags);

No need to take the spinlock.

> +       }
> +

And after that, you'll realize the memcmp() can just be dropped ;-)

>         return 0;
>  }
>
> @@ -1459,6 +1683,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
>
>  static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
>  {
> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>         struct pinctrl_pin_desc *pins;
>         unsigned int i, j;
>         u32 *pin_data;
> @@ -1501,6 +1726,22 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
>                 pins[index].drv_data = &pin_data[index];
>         }
>
> +       pctrl->settings = devm_kzalloc(pctrl->dev, sizeof(*pctrl->settings) * pctrl->desc.npins,
> +                                      GFP_KERNEL);

devm_kcalloc()

> +       if (!pctrl->settings)
> +               return -ENOMEM;
> +
> +       for (i = 0; hwcfg->drive_strength_ua && i < pctrl->desc.npins; i++) {
> +               if (pin_data[i] & PIN_CFG_SOFT_PS) {
> +                       pctrl->settings[i].power_source = 3300;
> +               } else {
> +                       ret = rzg2l_get_power_source(pctrl, i, pin_data[i]);
> +                       if (ret < 0)
> +                               continue;
> +                       pctrl->settings[i].power_source = ret;
> +               }
> +       }
> +
>         ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
>                                              &pctrl->pctl);
>         if (ret) {
> @@ -1574,6 +1815,8 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
>                 .sd_ch = 0x3000,
>         },
>         .iolh_groupa_ua = {
> +               /* 1v8, 2v5 power source */
> +               [RZG2L_IOLH_IDX_1V8 ... RZG2L_IOLH_IDX_3V3 - 1] = RZG2L_INVALID_IOLH_VAL,

If zero uA is considered an invalid value, the initialization above can
be dropped.

>                 /* 3v3 power source */
>                 [RZG2L_IOLH_IDX_3V3] = 2000, 4000, 8000, 12000,
>         },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
