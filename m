Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E70783D52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjHVJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjHVJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:49:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E3CC8;
        Tue, 22 Aug 2023 02:49:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso6400219e87.0;
        Tue, 22 Aug 2023 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692697760; x=1693302560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwZo0ebIAy/6qAfj6PH8JrDbK6VDb+FB9W919sQ0Xvw=;
        b=lgfb3WPyVvWs5aAEkd2api7L2xghKe2V3zoVNUDDDMjb2w4z/2kYMuuzrY3JdHjWOf
         M8YYmps6cBFoZPqK8xdqXvusabqKo+QRGxZNcPvkq+t3HLS6c9QziroTJCdEUI60qi9X
         24djgjZw/llYtbr1vQYO1RE3xOPhcpHZh/AuxLFR3RUWUbWCUVypceot7YfVXwI6D+pl
         8SjaUkv1Qzx/hwH8fzRlnl6OoPBxWPBr/Vlx/BlCqPffdS0UpX47tayzdgz1ovvrOp8s
         7ER84x3aBuQ+zdgnQ4XbUI0+1j6AhGBhHieP+t+udeqF2tCNx1OH9GhlXy1PQV/K6yW9
         S3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697760; x=1693302560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwZo0ebIAy/6qAfj6PH8JrDbK6VDb+FB9W919sQ0Xvw=;
        b=CuqeDNno+O5ObLgThDbF952VHFA+wkmNSawL4MNd8NN4WeGqEBlvWKwa7r4XL3+RhH
         /1U6vxvDlUqghZDfIdJcSaoy94WW2Mx27JmJATRwDtsr9DCWa9NH4iMSmgjNioieBhz1
         DhLufgU+3pMsgMzbJtha1HCbp81yZWXpFYW6TCOWNDIvngPA367JbRRbrkGDt65y29BU
         9kpXHQwSnWYFFOwfPiAud7b/P6hcfKWlkVTXXWl67ITiCuubsfUwcPMU5JBspiYcr+Xi
         RDymLh+vjALHPwxlsbS7z9fi8J0NiTthd/Xygdy7Un0E/b135v9CAHG9P7IyXuyvRyiL
         TpgQ==
X-Gm-Message-State: AOJu0YzlO0U4Ey0UbsFU8YqggvYxW/Uv+oyQJ5Nmtvm11lMvTU8ZXdDW
        YsRom+ZR8K4lJBNUdUqCLTVP6+55tEKaIDw6fW8=
X-Google-Smtp-Source: AGHT+IHo6wWMmcYIz+zNQdrgoQgN25JiQSaEQqnRJr60iDMDAkm8XNOaAOcgUws1B18twUVWHUA6FXdx6jlW+mT4f8E=
X-Received: by 2002:a05:6512:1088:b0:4fb:89b3:3373 with SMTP id
 j8-20020a056512108800b004fb89b33373mr7548428lfg.43.1692697759870; Tue, 22 Aug
 2023 02:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com> <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
 <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
In-Reply-To: <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 22 Aug 2023 17:49:03 +0800
Message-ID: <CAJhJPsUpmR0R8AhGMvFbBHXvcYcUsDmjw5_yb=NnFSdzjSf5dw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 5:47=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail.=
com> wrote:
>
> On Mon, Aug 21, 2023 at 3:04=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > > +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> > > +{
> > > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > > +     struct regmap_field **regmap_fields =3D dwmac->regmap_fields;
> > > +
> > > +     if (plat->bus_id) {
> > > +             regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1);
> > > +             regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1);
> > > +
> > > +             switch (plat->phy_interface) {
> > > +             case PHY_INTERFACE_MODE_RGMII:
> > > +                     regmap_field_write(regmap_fields[GMAC1_USE_TXCL=
K], 0);
> > > +                     regmap_field_write(regmap_fields[GMAC1_USE_PWM2=
3], 0);
> > > +                     break;
> >
> > What about the other three RGMII modes? Plain rgmii is pretty unusual,
> > rgmii-id is the most used.
> >
> According to the LS1B datasheet, only RGMII and MII are supported.
> And I can confirm that MII mode does work for LS1B.
>
Sorry! The RGMII mode does work for LS1B.

> > > +             case PHY_INTERFACE_MODE_MII:
> > > +                     regmap_field_write(regmap_fields[GMAC1_USE_TXCL=
K], 1);
> > > +                     regmap_field_write(regmap_fields[GMAC1_USE_PWM2=
3], 1);
> > > +                     break;
> > > +             default:
> > > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\n"=
,
> > > +                             plat->phy_interface);
> > > +                     return -EOPNOTSUPP;
> > > +             }
> > > +
> > > +             regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
> > > +     } else {
> > > +             switch (plat->phy_interface) {
> > > +             case PHY_INTERFACE_MODE_RGMII:
> > > +                     regmap_field_write(regmap_fields[GMAC0_USE_TXCL=
K], 0);
> > > +                     regmap_field_write(regmap_fields[GMAC0_USE_PWM0=
1], 0);
> > > +                     break;
> >
> > same here.
> >
> >      Andrew
>
>
>
> --
> Best regards,
>
> Keguang Zhang



--=20
Best regards,

Keguang Zhang
