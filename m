Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EB1808631
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378774AbjLGJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:50:14 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A6122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:50:20 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c8c26cf056so4710337b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701942619; x=1702547419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIX1RNQkc6dFT3GzufGFqm5IkObG6UPnE4BiG2zpzws=;
        b=JGY43OkJ8dPiGSg/LM9PIVXUJ2A0MvHlLWMYb+4Q0e0DkIEUC6pvOjRDN2GVrSHTvM
         CAFsPeTBhY5GMRjyiNyCuuHiXH6LeNGNf1Yb1gy9NKKXOASspl6XGYzoeg4JVXU1Eoiu
         bLs2XqnTulIN8kd4YQ/bnlB54G4RFtytKq0OA6FPH5KyoQNjSJh6QP6eGPosfzpZxNnt
         kw5ztsMUb57SGZVUPGQ0+RcP7IJHNTf89IY8AF8e7CycAXvOdhU7Wjo7XY/yDc1vpm5f
         OeSGpndfs66BBIB/vyExrapfTwXu1avdkBZpfy34fgZ7ZUHmss2sOL0EnzNvpa5djdSV
         kE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701942619; x=1702547419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIX1RNQkc6dFT3GzufGFqm5IkObG6UPnE4BiG2zpzws=;
        b=F+ynLriwIk/dprLWhV5rhEegxHy6Rg7Wlai1PF7vQuoTMyuzRhoNQhDEDlf/j0zNBa
         Gw66WUGEx1btOr1RWbIaXzQgec9nqvbYPdjpFPWsJdzPcgFNBOPmU731gfLuKdJOuSoZ
         QueYKZ6KonXW7y5B/EMFAe8H7LByxGU9bXwa1eLz2H/XiqJyHpUfAe6laXWONR2c9JZr
         JGPi4fCTJ+XYuWUiaAaFoppW+7u4T0wRi2isc0h11j7y19v7IXq4FVMfDIbh2I7BIlOI
         G6tSfvbTdYmlYpQWnNmi4jpFO//IdL4Cfvvqkv9LcPZhSILTAm0VpGsaxaEqd5AEoUUs
         MgDQ==
X-Gm-Message-State: AOJu0YzRzZ/1DWn9TPB2o/jxFXz35LUfBjrU1Tv1unowlmY1nDK8YsDy
        vk7BZSLLdzFZlgwhf6/G6J7hJETNQ8QJnvYvf/wPtzWzhhLuoka1
X-Google-Smtp-Source: AGHT+IEEJzWHmSbZphkfBLVNWSrStTPwZmWuytH0kY6FxBii24pm/m34J3igBSJ8TViq0A9/s3USCc7X5N9RAXK7HsM=
X-Received: by 2002:a81:bd42:0:b0:5d3:761e:d835 with SMTP id
 n2-20020a81bd42000000b005d3761ed835mr1947189ywk.28.1701942619477; Thu, 07 Dec
 2023 01:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZhpXcx2FZYKM69j3x4dP5Nu-=3sXW+BQAw3k6c5aRrWw@mail.gmail.com> <ZW3m-KDhs39i0E5n@smile.fi.intel.com>
In-Reply-To: <ZW3m-KDhs39i0E5n@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Dec 2023 10:50:29 +0100
Message-ID: <CACRpkdaDDJfDznGZE1OGNt0Rc6Wbh0-0suu6PgL+veJea9rBRQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] pinctrl: Convert struct group_desc to use struct pingroup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Dec 04, 2023 at 03:38:43PM +0100, Linus Walleij wrote:
> > Hi Andy,
> >
> > due to compile errors on arm32 and arm64 I had to drop most of the
> > patches again but I kept the preparatory patches so your
> > patch stack don't need to be so deep.
>
> Thank you!
>
> ...
>
> > >   pinctrl: core: Make pins const unsigned int pointer in struct
> > >     group_desc
> > >   pinctrl: equilibrium: Convert to use struct pingroup
> > >   pinctrl: keembay: Convert to use struct pingroup
> > >   pinctrl: nuvoton: Convert to use struct pingroup and
> > >     PINCTRL_PINGROUP()
>
> Hmm... Why these to be dropped?

I couldn't tell apart which ones could cross depend on the others,
simple as that...

Yours,
Linus Walleij
