Return-Path: <linux-kernel+bounces-68708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEF857EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86438285A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A679A12CD9A;
	Fri, 16 Feb 2024 14:09:19 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506512C532;
	Fri, 16 Feb 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092558; cv=none; b=o8VzgD8EPZdZITilq1DO7vFUYT6LHTt4tHTEpTB9dCH/RqLjiJa1fWOENQKpmucbmB3H2gbdSwzrRkMEakrPMcXAoHDc+QD1FF28D0CT6tl04BDFV/rqH2ATv2dwVMKQo5wE2udX+CnXsVKjRimj6XEJyHdNQ2uoeMq7wIaeyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092558; c=relaxed/simple;
	bh=6eRRGWcuKtCSc+G/DZEJV8Pimt8eiwkc+VVsbhQtN0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXziR56RJELmWmOb4b4btkN51KyuRAPNcSXxwgpsa9AKZCgFHvyEJfjnEYG4ATYyPrnh28Uc/RQkxzZTV5TlrHfwDACo5LtkTUnX1llxTfQrDaMKfUdS0LDlrgOwkQErYyCdYReNUN5LFLkbxzvbBZhvgISRvZZG6DXPw2te+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso2035021276.2;
        Fri, 16 Feb 2024 06:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092554; x=1708697354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NGPNWGXhQCmL81nSfQ8SEDPWu5OVVjPB1FdMYO5vCY=;
        b=VAKLAqjtY0x29x4Q/hzGoZXeWtp0HTU9v0CM+3lxuWdf/cYgomTrYMOKhKHzKrMIrm
         Rtr6HMqli4Rvhmx8dy9d/TZhwPTkz9Rdxo1fBWnp7NPIYp/1z4N+fZfra5t6CbMNdEjv
         GT5iBsheklPnKxPT3lBkRr5Ah9ZcU53fz1ey498PKUdapcdB7xGBrR73rGTYMzzXi/xp
         zWmqfWhXCz7pCF9qdbyzFiAHRIRGoGIpuvi7GjNe5HzLfoURPjV5sjX9xFpwMctpZy25
         23x3xU/pWp5xfaawq8yjQ8I0SnhSdZmpo9ZNXlqFCtWkil3hK+WMdhs8xu1+OJIzNQ75
         P70A==
X-Forwarded-Encrypted: i=1; AJvYcCWqWHWsnhIxEEXGD+h1hu0/QijjkljoJp8hfHaOQz1jAPZsRrZsl5h2k6uMUxcU50ogrkGQcgc7vMt3NciIKae8XwkxgXXFRd2r9I1rNFxpUsWKnwe6+qy/n2Cu9DRnQd6wcr4EX7BO44pDTKnQUIaOwdoUrr3WmNvrqcvcPPhfDzskYJ3lKLjBRtuq6xrAjtvGPppp184ijxuW9+KEWEZ+KFUz+TK+
X-Gm-Message-State: AOJu0YzZFkIQGVsjAf7l8bwQRWDZ6cR0hSYJ0ZEyNZOTmHgZEWsK1vF8
	dxKPAx7on6C4kR7d8lBaV3Ir9mLVBGbUjW0e1SzG0NrcJVFswNK/XbMyEtMvhTU=
X-Google-Smtp-Source: AGHT+IFl98+pBYgh2SR6JBZTGrxZWTOUWGtvNK5ooQWdz0ZWrIxf6Qxn2nFbSgQGryJLiJPJlDcujA==
X-Received: by 2002:a05:6902:2310:b0:dc7:5157:d43d with SMTP id do16-20020a056902231000b00dc75157d43dmr5149495ybb.42.1708092553862;
        Fri, 16 Feb 2024 06:09:13 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id k4-20020a056902024400b00dcd9e3d3fd0sm314002ybs.19.2024.02.16.06.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:09:12 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607ec539525so12780857b3.0;
        Fri, 16 Feb 2024 06:09:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/LOI70g9t8e0p3HBrBLz4D06cvZTs6BSGNHTA7AgILKOcyisNJotrbVn+54i1RT5n8O3Ck3/6jAxV9YqYIaQYKfGE0VBNNuF4ndLIuNNeC8t6fZftIM1t1t9Q7f44U+LZPQxtzTddLnAR5T1E4GUehDZ6tnwpfyX3jP6v/1f3pxY9DiwWzYhIDz/VTFK9iBDFoTFX4wH7q9oEMEgG9rlHMv85xKJG
X-Received: by 2002:a81:5253:0:b0:607:8812:1088 with SMTP id
 g80-20020a815253000000b0060788121088mr4690013ywb.1.1708092552316; Fri, 16 Feb
 2024 06:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:08:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWdJ9jN9-cko2zSoqSS0acbwYB77aBWvenJHMrFTXhdWg@mail.gmail.com>
Message-ID: <CAMuHMdWdJ9jN9-cko2zSoqSS0acbwYB77aBWvenJHMrFTXhdWg@mail.gmail.com>
Subject: Re: [PATCH 07/17] clk: renesas: rzg2l: Extend power domain support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
> power when clocks are disabled by activating module standby. This is done
> through MSTOP-specific registers that are part of CPG. Each individual
> module has one or more bits associated with one MSTOP register (see table
> "Registers for Module Standby Mode" from HW manuals). Hardware manual
> associates modules' clocks with one or more MSTOP bits. There are 3 mappi=
ngs
> available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW manuals):
>
> case 1: N clocks mapped to N MSTOP bits (with N=3D{0, ..., X})
> case 2: N clocks mapped to 1 MSTOP bit  (with N=3D{0, ..., X})
> case 3: N clocks mapped to M MSTOP bits (with N=3D{0, ..., X}, M=3D{0, ..=
, Y})
>
> Case 3 has been currently identified on RZ/V2L for the VCPL4 module.
>
> To cover all three cases, the individual platform drivers will provide to
> clock driver MSTOP register offset and associated bits in this register
> as a bitmask and the clock driver will apply this bitmask to proper
> MSTOP register.
>
> Apart from MSTOP support, RZ/G3S can save more power by powering down the
> individual IPs (after MSTOP has been set) if proper bits in
> CPG_PWRDN_IP{1,2} registers are set.
>
> The MSTOP and IP power down support were implemented through power
> domains. Platform-specific clock drivers will register an array of
> type struct rzg2l_cpg_pm_domain_init_data, which will be used to
> instantiate properly the power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1559,9 +1556,34 @@ static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cpg_p=
riv *priv,
>         return true;
>  }
>
> +/**
> + * struct rzg2l_cpg_pm_domain - RZ/G2L PM domains data structure
> + * @domains: generic PM domains
> + * @onecell_data: cell data
> + */
> +struct rzg2l_cpg_pm_domain {

rzg2l_cpg_pm_domains (plural)?

> +       struct generic_pm_domain **domains;
> +       struct genpd_onecell_data onecell_data;
> +};

Using a flexible array like

    struct rzg2l_cpg_pm_domains {
            struct genpd_onecell_data onecell_data;
            struct generic_pm_domain *domains[];
    };

would let you allocate the structure and the array in a single step,
using devm_kzalloc(..., struct_size(...), ...).

> +
> +/**
> + * struct rzg2l_cpg_pd - RZ/G2L power domain data structure
> + * @priv: pointer to CPG private data structure
> + * @genpd: generic PM domain
> + * @conf: CPG PM domain configuration info
> + * @id: RZ/G2L power domain ID
> + */
> +struct rzg2l_cpg_pd {
> +       struct rzg2l_cpg_priv *priv;
> +       struct generic_pm_domain genpd;

Please make genpd the first member, for simpler conversion between
rzg2l_cpg_pd and generic_pm_domain pointers.

> +       struct rzg2l_cpg_pm_domain_conf conf;
> +       u16 id;
> +};

> +static int __init rzg2l_cpg_add_pm_domains(struct rzg2l_cpg_priv *priv)
> +{
> +       const struct rzg2l_cpg_info *info =3D priv->info;
> +       struct device *dev =3D priv->dev;
> +       struct device_node *np =3D dev->of_node;
> +       struct rzg2l_cpg_pm_domain *domains;
> +       struct generic_pm_domain *parent;

Missing initialization parent =3D NULL;

> +       u32 ncells;
> +       int ret;
> +
> +       ret =3D of_property_read_u32(np, "#power-domain-cells", &ncells);
> +       if (ret)
> +               return ret;
> +
> +       /* For backward compatibility. */
> +       if (!ncells)
> +               return rzg2l_cpg_add_clk_domain(priv);
> +
> +       domains =3D devm_kzalloc(priv->dev, sizeof(*domains), GFP_KERNEL)=
;
> +       if (!domains)
> +               return -ENOMEM;
> +
> +       domains->domains =3D devm_kcalloc(priv->dev, info->num_pm_domains=
,
> +                                       sizeof(struct generic_pm_domain *=
), GFP_KERNEL);
> +       if (!domains->domains)
> +               return -ENOMEM;
> +
> +       domains->onecell_data.domains =3D domains->domains;
> +       domains->onecell_data.num_domains =3D info->num_pm_domains;
> +       domains->onecell_data.xlate =3D rzg2l_cpg_pm_domain_xlate;
> +
> +       ret =3D devm_add_action_or_reset(dev, rzg2l_cpg_genpd_remove, &do=
mains->onecell_data);
> +       if (ret)
> +               return ret;
> +
> +       for (unsigned int i =3D 0; i < info->num_pm_domains; i++) {
> +               bool always_on =3D !!(info->pm_domains[i].flags & RZG2L_P=
D_F_ALWAYS_ON);
> +               struct rzg2l_cpg_pd *pd;
> +
> +               pd =3D devm_kzalloc(priv->dev, sizeof(*pd), GFP_KERNEL);
> +               if (!pd)
> +                       return -ENOMEM;
> +
> +               pd->genpd.name =3D info->pm_domains[i].name;
> +               pd->conf =3D info->pm_domains[i].conf;
> +               pd->id =3D info->pm_domains[i].id;
> +               pd->priv =3D priv;
> +
> +               ret =3D rzg2l_cpg_pd_setup(pd, always_on);
> +               if (ret)
> +                       return ret;
> +
> +               if (always_on) {
> +                       ret =3D rzg2l_cpg_power_on(&pd->genpd);
> +                       if (ret)
> +                               return ret;
> +               }
> +
> +               domains->domains[i] =3D &pd->genpd;
> +               /* Parent should be on the very first entry of info->pm_d=
omains[]. */
> +               if (info->pm_domains[i].flags & RZG2L_PD_F_PARENT) {
> +                       parent =3D &pd->genpd;
> +                       continue;
> +               }
> +
> +               ret =3D pm_genpd_add_subdomain(parent, &pd->genpd);
> +               if (ret)
> +                       return ret;

I think you can simplify/generalize the above logic without needing
the RZG2L_PD_F_PARENT flag:

    if (i) {
            ret =3D pm_genpd_add_subdomain(domains->domains[0], &pd->genpd)=
;
            if (ret)
                    return ret;
    }

> +       }
> +
> +       ret =3D of_genpd_add_provider_onecell(np, &domains->onecell_data)=
;
> +       if (ret)
> +               return ret;
> +
> +       /* Prepare for power down the BUSes in power down mode. */
> +       if (info->pm_domain_pwrdn_mstop)
> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MST=
OP);
> +
> +       return 0;
>  }
>
>  static int __init rzg2l_cpg_probe(struct platform_device *pdev)

> --- a/drivers/clk/renesas/rzg2l-cpg.h
> +++ b/drivers/clk/renesas/rzg2l-cpg.h
> @@ -27,6 +27,16 @@
>  #define CPG_PL6_ETH_SSEL       (0x418)
>  #define CPG_PL5_SDIV           (0x420)
>  #define CPG_RST_MON            (0x680)
> +#define CPG_ACPU_MSTOP         (0xB60)
> +#define CPG_MCPU2_MSTOP                (0xB68)
> +#define CPG_PERI_COM_MSTOP     (0xB6C)
> +#define CPG_PERI_CPU_MSTOP     (0xB70)
> +#define CPG_PERI_DDR_MSTOP     (0xB74)
> +#define CPG_REG1_MSTOP         (0xB80)
> +#define CPG_TZCDDR_MSTOP       (0xB84)
> +#define CPG_PWRDN_IP1          (0xBB0)
> +#define CPG_PWRDN_IP2          (0xBB4)
> +#define CPG_PWRDN_MSTOP                (0xBC0)

Please name these CPG_BUS_*, to match the documentation.

>  #define CPG_OTHERFUNC1_REG     (0xBE8)
>
>  #define CPG_SIPLL5_STBY_RESETB         BIT(0)

> @@ -234,6 +246,54 @@ struct rzg2l_reset {
>  #define DEF_RST(_id, _off, _bit)       \
>         DEF_RST_MON(_id, _off, _bit, -1)
>
> +/**
> + * struct rzg2l_cpg_pm_domain_conf - PM domain configuration data struct=
ure
> + * @mstop: MSTOP configuration (MSB =3D register offset, LSB =3D bitmask=
)
> + * @pwrdn: PWRDN configuration (MSB =3D register offset, LSB =3D registe=
r bit)
> + */
> +struct rzg2l_cpg_pm_domain_conf {
> +       u32 mstop;
> +       u32 pwrdn;

Why not

    u16 mstop_off;
    u16 mstop_mask;
    u16 pwrdn_off;
    u16 pwrdn_mask;

so you can drop the MSTOP*() and PWRDN*() macros below?

> +};
> +
> +/**
> + * struct rzg2l_cpg_pm_domain_init_data - PM domain init data
> + * @name: PM domain name
> + * @conf: PM domain configuration
> + * @flags: RZG2L PM domain flags (see RZG2L_PD_F_*)
> + * @id: PM domain ID (similar to the ones defined in
> + *      include/dt-bindings/clock/<soc-id>-cpg.h)
> + */
> +struct rzg2l_cpg_pm_domain_init_data {
> +       const char * const name;
> +       struct rzg2l_cpg_pm_domain_conf conf;
> +       u32 flags;

With a single flag left, this can become "bool always_on"
(and be moved after "id" to improve packing).

> +       u16 id;
> +};
> +
> +#define DEF_PD(_name, _id, _mstop_conf, _pwrdn_conf, _flags) \
> +       { \
> +               .name =3D (_name), \
> +               .id =3D (_id), \
> +               .conf =3D { \
> +                       .mstop =3D (_mstop_conf), \
> +                       .pwrdn =3D (_pwrdn_conf), \
> +               }, \
> +               .flags =3D (_flags), \
> +       }
> +
> +#define MSTOP(name, bitmask)   ((CPG_##name##_MSTOP) << 16 | (bitmask))
> +#define MSTOP_OFF(conf)                ((conf) >> 16)
> +#define MSTOP_MASK(conf)       ((conf) & GENMASK(15, 0))
> +
> +#define PWRDN(name, bit)       ((CPG_PWRDN_##name) << 16 | BIT(bit))
> +#define PWRDN_OFF(conf)                ((conf) >> 16)
> +#define PWRDN_MASK(conf)       ((conf) & GENMASK(15, 0))
> +
> +/* Power domain flags. */
> +#define RZG2L_PD_F_PARENT      BIT(0)
> +#define RZG2L_PD_F_ALWAYS_ON   BIT(1)
> +
>  /**
>   * struct rzg2l_cpg_info - SoC-specific CPG Description
>   *

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

