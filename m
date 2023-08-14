Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92477B714
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjHNKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHNKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:50:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71A18F;
        Mon, 14 Aug 2023 03:50:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe11652b64so6404529e87.0;
        Mon, 14 Aug 2023 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692010249; x=1692615049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdzw0rHpRr91l8BAcXFT84UEK+jpp9hS9qWwexkoFFI=;
        b=NmPp/20s/8vM+ZwsIYdJOdGC62ty7spi+o//yCDIw7eV+WtVltjdUNm1GGqB7HtOw6
         maAiEFD8FuFnIHynzdsuaEixLZGznc6mwRG2bHcr4HU58eU5E6PfhXXRq0lIqqh8Cp6D
         0l9gIIt6ojU9awjNQC/hmZWGGdkplUZTmOPItR4pDYPb4cqz7da0AgrnOV/LF/orhjut
         YkE8m3149AoSPwqL3Cssu27ELbAmE6sUxq1+660NRw2KQWaSbJkoJymj06j7zrTWEHnq
         KJnIyVMeLR4Pv5EUzuNDQmhbr00j3jbLhB7neqC88XmVaD1y9glSQprWUZC+6GWleoq2
         TafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692010249; x=1692615049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdzw0rHpRr91l8BAcXFT84UEK+jpp9hS9qWwexkoFFI=;
        b=MSoNGlGcIudhEtndDd+vzLZhIP256uDJHRGqaq6jStqbgbIgpgGBtYR/baZXw0ZtF5
         1HdwePuJySFLjA+97T0Ui7rzNEb4zrGBKKhr8VUmtml7eyAWE2E42nyipq9/AjeYgg6R
         r+STLA+5PfmDRb/CWVnK4wH0wniA3ZOoSX1Fhr6tMUqV59p+3KBqaxD92WTEGSx1BeZa
         DvPp4F/1i0si9IK5yWpg3SSUyRJvtKSYn0E6u4sKWcU8prB/nPFW6PYamhoVvbGMrr95
         vR4NkLzaGGr0l/VjduE5Y8PxaCL0h4tJ9qZw1MZ+7j3WnnCJAkB35xBIqEE5hK40buOs
         LgLA==
X-Gm-Message-State: AOJu0YwbUXqaRJiOVc2l0w+FObqRfs1QbTNWlNvdBh8L2K3vsWRPH3rJ
        q4JTeyU1TIBCVkmBkgkIDGM4Gsknkuz02WGazNs=
X-Google-Smtp-Source: AGHT+IH+lmfKPWRI9A8rGnFGRYYJU7cvFv8MbgRMB14ww/vT51xVFwFoqjwMMqEahd51AXKqIih0ZuZ1P98cjYlt25U=
X-Received: by 2002:a05:6512:3b0f:b0:4fb:cab9:ddf with SMTP id
 f15-20020a0565123b0f00b004fbcab90ddfmr7501155lfv.57.1692010249295; Mon, 14
 Aug 2023 03:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-5-keguang.zhang@gmail.com> <ZNkfz1yKD90XmTFL@vergenet.net>
In-Reply-To: <ZNkfz1yKD90XmTFL@vergenet.net>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 14 Aug 2023 18:50:32 +0800
Message-ID: <CAJhJPsXOUOB_0kWcKC0Sy8F9qPbkU+NfVFRz-Hkk8eS-YuUS7w@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: stmmac: Add glue layer for Loongson-1 SoC
To:     Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 2:24=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sat, Aug 12, 2023 at 11:11:34PM +0800, Keguang Zhang wrote:
> > This glue driver is created based on the arch-code
> > implemented earlier with the platform-specific settings.
> >
> > Use syscon for SYSCON register access.
> >
> > Partialy based on the previous work by Serge Semin.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>
> ...
>
> Hi Keguang Zhang,
>
> some minor feedback from my side.
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>
> ...
>
> > +const struct reg_field ls1b_dwmac_syscon_regfields[] =3D {
> > +     [GMAC1_USE_UART1]       =3D REG_FIELD(LS1X_SYSCON0, 4, 4),
> > +     [GMAC1_USE_UART0]       =3D REG_FIELD(LS1X_SYSCON0, 3, 3),
> > +     [GMAC1_SHUT]            =3D REG_FIELD(LS1X_SYSCON1, 13, 13),
> > +     [GMAC0_SHUT]            =3D REG_FIELD(LS1X_SYSCON1, 12, 12),
> > +     [GMAC1_USE_TXCLK]       =3D REG_FIELD(LS1X_SYSCON1, 3, 3),
> > +     [GMAC0_USE_TXCLK]       =3D REG_FIELD(LS1X_SYSCON1, 2, 2),
> > +     [GMAC1_USE_PWM23]       =3D REG_FIELD(LS1X_SYSCON1, 1, 1),
> > +     [GMAC0_USE_PWM01]       =3D REG_FIELD(LS1X_SYSCON1, 0, 0)
> > +};
>
> nit: Perhaps ls1b_dwmac_syscon_regfields should be static.
>
> > +
> > +const struct reg_field ls1c_dwmac_syscon_regfields[] =3D {
> > +     [GMAC_SHUT]             =3D REG_FIELD(LS1X_SYSCON0, 6, 6),
> > +     [PHY_INTF_SELI]         =3D REG_FIELD(LS1X_SYSCON1, 28, 30)
> > +};
>
> Likewise, perhaps ls1c_dwmac_syscon_regfields should be static.
>
Will do.
Thanks!
> ...
>
> > +static const struct of_device_id ls1x_dwmac_syscon_match[] =3D {
> > +     { .compatible =3D "loongson,ls1b-syscon", .data =3D &ls1b_dwmac_s=
yscon },
> > +     { .compatible =3D "loongson,ls1c-syscon", .data =3D &ls1c_dwmac_s=
yscon },
> > +     { }
> > +};o
>
> I am seeing a warning about ls1x_dwmac_syscon_match being unused.
> I think this is due to CONFIG_OF being unset.

Will fix these warnings.
>
> > +
> > +static int ls1x_dwmac_probe(struct platform_device *pdev)
> > +{
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     struct stmmac_resources stmmac_res;
> > +     struct device_node *syscon_np;
> > +     const struct of_device_id *match;
> > +     struct regmap *regmap;
> > +     struct ls1x_dwmac *dwmac;
> > +     const struct ls1x_dwmac_syscon *syscon;
> > +     size_t size;
> > +     int ret;
> > +
> > +     ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Probe syscon */
> > +     syscon_np =3D of_parse_phandle(pdev->dev.of_node, "syscon", 0);
> > +     if (!syscon_np)
> > +             return -ENODEV;
> > +
> > +     match =3D of_match_node(ls1x_dwmac_syscon_match, syscon_np);
> > +     if (!match) {
> > +             of_node_put(syscon_np);
> > +             return -EINVAL;
> > +     }
> > +     syscon =3D (const struct ls1x_dwmac_syscon *)match->data;
> > +
> > +     regmap =3D syscon_node_to_regmap(syscon_np);
> > +     of_node_put(syscon_np);
> > +     if (IS_ERR(regmap)) {
> > +             ret =3D PTR_ERR(regmap);
> > +             dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     size =3D syscon->nr_reg_fields * sizeof(struct regmap_field *);
> > +     dwmac =3D devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP_KER=
NEL);
> > +     if (!dwmac)
> > +             return -ENOMEM;
> > +
> > +     plat_dat =3D stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > +     if (IS_ERR(plat_dat)) {
> > +             dev_err(&pdev->dev, "dt configuration failed\n");
> > +             return PTR_ERR(plat_dat);
> > +     }
> > +
> > +     plat_dat->bsp_priv =3D dwmac;
> > +     plat_dat->init =3D ls1x_dwmac_init;
> > +     dwmac->dev =3D &pdev->dev;
> > +     dwmac->plat_dat =3D plat_dat;
> > +     dwmac->syscon =3D syscon;
> > +     dwmac->regmap =3D regmap;
> > +
> > +     ret =3D stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> > +     if (ret)
> > +             goto err_remove_config_dt;
> > +
> > +     return 0;
> > +
> > +err_remove_config_dt:
> > +     if (pdev->dev.of_node)
> > +             stmmac_remove_config_dt(pdev, plat_dat);
> > +
> > +     return ret;
> > +}
>
> ...



--=20
Best regards,

Keguang Zhang
