Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D779CF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjILLHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjILLGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:06:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD819AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:05:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7b9de8139fso4755624276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694516708; x=1695121508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FMoBWtmvLq6bgdekThyp6v4fhBAV0YiqC8BS8aCPcE=;
        b=iLR0n9msF80qSSX64CsTjmtDEbEVqWCqg6NehBvvHfXb1Aq89f394kl3CACzlkipkf
         ENLUWyY5nYtPLe+nrl2Pva6OrMMVsAdFpIUZ4CF6bQYTz4Pu3Z0Z3GscWO4Kbg+cpgYN
         rXV12aWnx0sn7NHbMnBdtoJsP53wF88Byx7C7kCYXJ7x6oVfr6nD7WTmBpZn1Lz4EPx3
         iuoQ4Foiuf38imGpcERI+3dcc8qm/ueL2fmHGZZNrDVBnSqJoTEWRKnhqDfOR8WRSHW8
         E56W/a5cfo/4ghQvCfcyHbZ9xHWMyl8ss94fP52qtUboWFJLwhk13SNdjYKCNe3EuTG6
         H3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694516708; x=1695121508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FMoBWtmvLq6bgdekThyp6v4fhBAV0YiqC8BS8aCPcE=;
        b=DOq51psGYDyH872o8SDFBl9PdH7UtyU10GyzIAPrEYJlwxRYw4s567e1oTeYVKAP9x
         ZCEvHze01Ob3CIW9EaxAcEHDRLsvWZN4cT9+CA2xe98vpllZGNqxxD1PpeMa57UxmNWk
         QVx/cLiKrin4b6IWt/c7GSF6tW/IXrWIqLqSWkBkKtAuxxk084xvAWW0KqU+WKEc9Xtb
         3Q7b0B0ijFEtrlvcoSTTZv82zneqlW1OjkmilLUH6BFRAUKlpb5fel2Ae8x66hZ9Ipxn
         KgqOEk1IXVB0+rAeatwmfa4f/Gy0RDcr0OPCbEaQce0yyuRPKYnj2yY2gFS1jN/7YK+v
         S5eg==
X-Gm-Message-State: AOJu0Yz6BDW5LdFT23Y1XB5RWqyGwiFTT+6ybyxmR0cIiE7ng2u47BjH
        6w8/R2AhctokMpUUZV6UfoJ1+3HsumHncpVr7R1Skw==
X-Google-Smtp-Source: AGHT+IHWFG9XShCR9EYCQbjpGN6Qxg22q5tUHNLhGUJSf212PqAwCH8zHTtn0AYfPfJADbtFAnVTC3aGLAvqi8JMMgU=
X-Received: by 2002:a25:d695:0:b0:d62:6514:45b7 with SMTP id
 n143-20020a25d695000000b00d62651445b7mr11205815ybg.37.1694516708153; Tue, 12
 Sep 2023 04:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230912081527.208499-1-herve.codina@bootlin.com> <20230912101505.225899-1-herve.codina@bootlin.com>
In-Reply-To: <20230912101505.225899-1-herve.codina@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 13:04:56 +0200
Message-ID: <CACRpkdbxdMZt4E1SF1v9as-jw=TpvS1mk2TQqAgywMBLbKaNoA@mail.gmail.com>
Subject: Re: [PATCH v5 28/31] pinctrl: Add support for the Lantic PEF2256 pinmux
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

thanks for your patch!

On Tue, Sep 12, 2023 at 12:15=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
>
> This kind of component can be found in old telecommunication system.
> It was used to digital transmission of many simultaneous telephone calls
> by time-division multiplexing. Also using HDLC protocol, WAN networks
> can be reached through the framer.
>
> This pinmux support handles the pin muxing part (pins RP(A..D) and pins
> XP(A..D)) of the PEF2256.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Nice to see this as a proper pin control driver!

>  drivers/pinctrl/pinctrl-pef2256-regs.h |  65 ++++++
>  drivers/pinctrl/pinctrl-pef2256.c      | 308 +++++++++++++++++++++++++

Do you really need a separate header just for some registers?
But it's a matter of taste so I'm not gonna complain if you want
it this way.

> +config PINCTRL_PEF2256
> +       tristate "Lantiq PEF2256 (FALC56) pin controller driver"
> +       depends on OF && FRAMER_PEF2256
> +       select PINMUX

select PINCONF

> +       select GENERIC_PINCONF

This brings it in implicitly but I prefer that you just select it.

> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*

I think SPDX mandates that you start the tag with C99 comments

// SPDX-License-Identifier: GPL-2.0-only

> +       /* We map 1 group <-> 1 pin */

Also known as "the qualcomm trick", but hey: it's fine.

> +static int pef2256_register_pinctrl(struct pef2256_pinctrl *pef2256)
> +{
> +       struct pinctrl_dev      *pctrl;
> +
> +       pef2256->pctrl_desc.name    =3D dev_name(pef2256->dev);
> +       pef2256->pctrl_desc.owner   =3D THIS_MODULE;
> +       pef2256->pctrl_desc.pctlops =3D &pef2256_pctlops;
> +       pef2256->pctrl_desc.pmxops  =3D &pef2256_pmxops;
> +       if (pef2256->version =3D=3D PEF2256_VERSION_1_2) {
> +               pef2256->pctrl_desc.pins  =3D pef2256_v12_pins;
> +               pef2256->pctrl_desc.npins =3D ARRAY_SIZE(pef2256_v12_pins=
);
> +               pef2256->functions  =3D pef2256_v12_functions;
> +               pef2256->nfunctions =3D ARRAY_SIZE(pef2256_v12_functions)=
;
> +       } else {
> +               pef2256->pctrl_desc.pins  =3D pef2256_v2x_pins;
> +               pef2256->pctrl_desc.npins =3D ARRAY_SIZE(pef2256_v2x_pins=
);
> +               pef2256->functions  =3D pef2256_v2x_functions;
> +               pef2256->nfunctions =3D ARRAY_SIZE(pef2256_v2x_functions)=
;
> +       }
> +
> +       pctrl =3D devm_pinctrl_register(pef2256->dev, &pef2256->pctrl_des=
c, pef2256);
> +       if (IS_ERR(pctrl)) {
> +               dev_err(pef2256->dev, "pinctrl driver registration failed=
\n");
> +               return PTR_ERR(pctrl);
> +       }
> +
> +       return 0;

You could use
return dev_err_probe(...);

> +       pef2256_reset_pinmux(pef2256_pinctrl);
> +       ret =3D pef2256_register_pinctrl(pef2256_pinctrl);
> +       if (ret)
> +               return ret;

Or you could use it down here.

With or without these changes (because they are nitpicks)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
