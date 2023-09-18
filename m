Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B47A4FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjIRQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjIRQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:56:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5ADB6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:55:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ad8a33fd0dso603382066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695056143; x=1695660943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mkIPCmF85o/Z4anDms5oP2/zj6Pfs9qZf8v1CyX5iac=;
        b=hLq4sP06/tCXKLY4n43QK90NBL4671OPdZbHeM9fJEW/QBI1aLhpzd3q9dDY+lu0Kp
         OhyfMnukSrYe7BcSKvfIdufFB44RK+OYK5yJs9tBcEN8C1RgI8zl/xvY6r2gX2Z3YIof
         PCFoq2SNLWUVjHrRxXqoffban4y4M4ouv5e9qu6bF4cdp4halRYkSkMM66zj8u+2KpVT
         mod3hvU93mrMcOLMsWcIVMtF/8X4JPj7/f/1w2BHID3yqzibmcqqqjmL2Z86ixlWSh6t
         qQv8ScSveFc0+VyQCfbf7RmwjrCRSVsein2hQcentSOYzrK4+TexLhJQK5Z7OcsdvHH4
         cNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056143; x=1695660943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkIPCmF85o/Z4anDms5oP2/zj6Pfs9qZf8v1CyX5iac=;
        b=AwjUc3a5p0lO61cfbeJxjjgnLSbh1BLao9d8CiCl9SdkyQFIvUQMXdHkbckk9ZZqSj
         /lALieJcYOJhDEcvTEfsxCSinWPThpXL6kcfFQn4TtPWCBvCEvzVkeXjS2aDq5aFV6mZ
         QKeeCuyS6LamnWMFfH/g97JwNZDpisLPy6r7vjmtmkdLFr/ZjZw3QNcb3CgOL9ZYSmAV
         1kGq5WDhaBGoUrBGCwBp9qYYZKYNDV42qANprFZMLnMlOx7TL/8r3dBMDBDh95TDMv7M
         ldGU9RS5ETHXj+Wvd/bOHVo+slaaUtpm2rG0Gjn2plgLoz8JvgZodVM/Frp9shnl40+Z
         9sEQ==
X-Gm-Message-State: AOJu0Yyu4p/JIjvIv4soekMcf/JLp5JVADe4PdVsgr2wZu/Go9I1yTx9
        9yqDTa+lj93ndy8+cP4kUJd45og0zcvX2A==
X-Google-Smtp-Source: AGHT+IF3pP06MbA2fpJivVwXf6I/ctosGSQGU8JcfvKJCaBMXnSJnn68HwjCizrPWA8uiNf6oFYZTQ==
X-Received: by 2002:a05:6512:1089:b0:4ff:7e80:4f1d with SMTP id j9-20020a056512108900b004ff7e804f1dmr8970145lfg.57.1695042243496;
        Mon, 18 Sep 2023 06:04:03 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e8100b00531050807a9sm1822387eda.13.2023.09.18.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 06:04:03 -0700 (PDT)
Message-ID: <fbcd27f27c37cebbc565b6a0caac44b1590b6603.camel@gmail.com>
Subject: Re: [PATCH v4 02/42] ARM: ep93xx: add swlocked prototypes
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     nikita.shubin@maquefel.me,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Sep 2023 15:04:02 +0200
In-Reply-To: <93997981fb20fd83f42b83853e258ea28575cbe1.camel@gmail.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
         <20230915-ep93xx-v4-2-a1d779dcec10@maquefel.me>
         <93997981fb20fd83f42b83853e258ea28575cbe1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Sat, 2023-09-16 at 17:38 +0200, Alexander Sverdlin wrote:
> > Add ep93xx_regmap_write and ep93xx_regmap_update_bits to make drivers
> > compilable before actual implementation is added.
>=20
> It should be possible to re-arrange the patch series so that real
> implementation comes before the drivers using it.
>=20
> We must assure that bisecting the kernel tree is possible, that
> means no matter which (initial) part of your series is applied, there is =
no
> regression allowed.
>=20

sorry for the confusion, there is no bisectability problem in it
indeed, because only new drivers use it and they are not active until
the last patches in the series swith to DT.

I'd personally probably melt commit 10 ("soc: Add SoC driver for Cirrus ep9=
3xx")
into this one, but I don't see it necessary after all.

> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0include/linux/soc/cirrus/ep93xx.h | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirr=
us/ep93xx.h
> > index 56fbe2dc59b1..8b4b8221ed4c 100644
> > --- a/include/linux/soc/cirrus/ep93xx.h
> > +++ b/include/linux/soc/cirrus/ep93xx.h
> > @@ -3,6 +3,7 @@
> > =C2=A0#define _SOC_EP93XX_H
> > =C2=A0
> > =C2=A0struct platform_device;
> > +struct regmap;
> > =C2=A0
> > =C2=A0#define EP93XX_CHIP_REV_D0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03
> > =C2=A0#define EP93XX_CHIP_REV_D1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04
> > @@ -34,4 +35,9 @@ static inline unsigned int ep93xx_chip_revision(void)=
 { return 0; }
> > =C2=A0
> > =C2=A0#endif
> > =C2=A0
> > +static inline void ep93xx_regmap_write(struct regmap *map, unsigned in=
t reg, unsigned int val) {}
> > +static inline void ep93xx_regmap_update_bits(struct regmap *map, unsig=
ned int reg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, unsigned int val=
)
> > +{ }
> > +
> > =C2=A0#endif

--=20
Alexander Sverdlin.

