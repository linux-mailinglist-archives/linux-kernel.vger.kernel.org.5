Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2951A783D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjHVJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjHVJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:48:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C711A1;
        Tue, 22 Aug 2023 02:47:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so5096610a12.3;
        Tue, 22 Aug 2023 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692697678; x=1693302478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=164Yv8EkcBPGG6fhxtx5OJ8UzPiDbeRCFjVvxNcTr0k=;
        b=A10iKSmjS891gKhdKH+KsMmbIJ/p1RnaoOieyOv4go2hm/pv/QkzRIf35vCQOMh3wu
         NS/KXb8gTpubUSBJFo9i07s9VRW0roywcJ8SSUjZbC2Qc05rohHgGSHK1CBdQQUD62Yx
         xMj3tg03fOJq6MbpBLtnglOIVw+CrLTvqBti6RTrvgIx4WHdfiI+jOGqQ6GXx/srUzlq
         U5aes3zm/E5+LDI6BgEAb9GuKEvjLqKU8FBm2hHve81xqrYlqY5vTPyGM//7QVoN7Tn8
         OJejtZqzuYfl7ReHzH5ECdxVVqmv7weePTkEtUV7Z/rpwGpOSui19gwMOA7xTRxeq1Yo
         WAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697678; x=1693302478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=164Yv8EkcBPGG6fhxtx5OJ8UzPiDbeRCFjVvxNcTr0k=;
        b=kpJQ0d8kOgJyX8pMrrGGIs9K2+74T2zuwfYM1kWram0BFCsa/eZVNuxE8Cdyk/ob+m
         nJ/VUo5ieZoD5UgiSGP+S4WDEzITC5FHj//st+6eIzxapVcGnw5cpIknaHU+ErxN56IC
         znRX19PtFRToIwwy+Wla4K77kNPZy42RmyfIUIQsEstKxqONx1nGUXmZ2Q9v45yAnYbx
         UxVwvSO26LZCdgZuozwf6GVQUoND0hhZ6eP2KnaFMZesrfxUYE9LPlSpN9kznr77aX3U
         yJP+X50dGfaWIznMNhAxz+bocnxUBGThj7PapcKR4VQH4STTwAcj+LreoJFQ1exG1o71
         PDAw==
X-Gm-Message-State: AOJu0Yzr0kkPw/w1hmKKFLdTwdgdGXIT3J4rPEEvtJXvwGVNZGrb2Oil
        anMP5/Uc7WodXMAK8dkga67HNB6blyys4jnsaKUSd8ug7LxvRQ==
X-Google-Smtp-Source: AGHT+IEjguRR995fEx4n1YeZ7r/m4eZtHLM+Up0KfdwWsEZtgkj3SUk9fna8jhAkU4YOvm2E4PqKaTIBkfbi7VU61V0=
X-Received: by 2002:aa7:d058:0:b0:523:338b:7977 with SMTP id
 n24-20020aa7d058000000b00523338b7977mr6823694edo.9.1692697677970; Tue, 22 Aug
 2023 02:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com> <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
In-Reply-To: <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 22 Aug 2023 17:47:38 +0800
Message-ID: <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
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

On Mon, Aug 21, 2023 at 3:04=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > +     struct regmap_field **regmap_fields =3D dwmac->regmap_fields;
> > +
> > +     if (plat->bus_id) {
> > +             regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1);
> > +             regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1);
> > +
> > +             switch (plat->phy_interface) {
> > +             case PHY_INTERFACE_MODE_RGMII:
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_TXCLK]=
, 0);
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_PWM23]=
, 0);
> > +                     break;
>
> What about the other three RGMII modes? Plain rgmii is pretty unusual,
> rgmii-id is the most used.
>
According to the LS1B datasheet, only RGMII and MII are supported.
And I can confirm that MII mode does work for LS1B.

> > +             case PHY_INTERFACE_MODE_MII:
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_TXCLK]=
, 1);
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_PWM23]=
, 1);
> > +                     break;
> > +             default:
> > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
> > +     } else {
> > +             switch (plat->phy_interface) {
> > +             case PHY_INTERFACE_MODE_RGMII:
> > +                     regmap_field_write(regmap_fields[GMAC0_USE_TXCLK]=
, 0);
> > +                     regmap_field_write(regmap_fields[GMAC0_USE_PWM01]=
, 0);
> > +                     break;
>
> same here.
>
>      Andrew



--=20
Best regards,

Keguang Zhang
