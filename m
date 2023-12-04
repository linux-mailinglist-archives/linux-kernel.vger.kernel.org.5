Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5605A8037CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjLDO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345709AbjLDOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:35:44 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76A1BC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:35:47 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2013641276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701700547; x=1702305347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp0IjsfcwvSP4xwYPboGJw1FyStABvBFv/P2infLWSw=;
        b=xlwGKnLUhlTO8JDe7S+9heelQijfnKnpHBMF33ed/RornzLZ5KReX5iDfiW/J/VORC
         qB4uyclZMxXAg3vyZpjD75I7qO8Xwzl8GcTIjkHVeZZz1ZaMZVoJk+HgZof7KL0+SfWJ
         m4SLEsDowCcrOKRQHtoAvuZTP5KHAmD2CYNapRHCq7kDzD7U9IYTlrGqbB5tIPPffCv9
         71tzj4pHKFga5son8ICGtp1LEnOhcZpNpol/Od25UsrD/sJHuim0I0DCGY+N02w5suj3
         yF2jpGJlwWwMao2iSsvC8hWey/R1GpWFV6Yy+nhEHwblHVQN7+dxLLaSdhSAg6ywtMz0
         vsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700547; x=1702305347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xp0IjsfcwvSP4xwYPboGJw1FyStABvBFv/P2infLWSw=;
        b=bc0Je8m0oih0VKj6kTMyxd+7p/qAO7UObeL7HdISsmS4CHnHEeSWBMwOE85cK38aOb
         0tri0THsq4jAHF3CKeVw4BkQDRe0C8tVytGlPP0Yu8hNDFVdkdGhIqcruzuuy0YMQjim
         SVoTkM0dISfehl11BuVhOAhr84upc+PLT9ajGftJaIpgL0U1fLGZhEkPjZQ4GkBwGmZb
         mX5ZBQ+MrXJmQHIZ0PcloGob1QgGZ2ckUtzLEqWbEwVwbpYHRGrsUfLQymaY+4onHtxg
         1NEHDN/RahaLg3TSHRDz9NPiwZo8JSuffLvkJQlSWM0E87IvOuBXAebA3upHv6sTOLdQ
         Mi5A==
X-Gm-Message-State: AOJu0YxW44e2lo9Euc3ntm2Bx44MQvhU9qjcjiZ76clowHbtVO4GhvSJ
        zM0U8ey7CgELMbhDzjdQWt1sMcBauItzou8Vm/1V+g==
X-Google-Smtp-Source: AGHT+IGlzR6jMdp+UQm1IidwrnLTDQIh/k3Qz3N9UjI37v6TipIB4xIDPl1uX1mVMB9Ef/A4gLOOuoKxBOrzTG+rKVg=
X-Received: by 2002:a25:ad4a:0:b0:db7:dacf:4d49 with SMTP id
 l10-20020a25ad4a000000b00db7dacf4d49mr1286460ybe.69.1701700546895; Mon, 04
 Dec 2023 06:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZAriTP3iOgmwvoAH-3-aO_ugoEkBHE7mHH5YLxhMXSXg@mail.gmail.com> <b2175abe-b989-4b77-891e-67e8240ba0be@linaro.org>
In-Reply-To: <b2175abe-b989-4b77-891e-67e8240ba0be@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 15:35:35 +0100
Message-ID: <CACRpkdaTKAwCN_dbcAn_qKLi2R15=BzJjpg85XtL=Ap6ORSgUQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] pinctrl: Convert struct group_desc to use struct pingroup
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 8:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 01/12/2023 15:05, Linus Walleij wrote:
> > On Wed, Nov 29, 2023 at 5:15=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> >> The struct group_desc has a lot of duplication with struct pingroup.
> >> Deduplicate that by embeddind the latter in the former and convert
> >> users.
> >>
> >> Linus, assuming everything is fine, I can push this to my tree.
> >> Or you can apply it (assumming all CIs and people are happy with
> >> the series).
> >
> > I applied the series to devel so we get some rotation in linux-next,
> > augmenting the relevant commit messages as discussed!
> >
>
> ... and this next fails to build on standard defconfig:
> https://krzk.eu/#/builders/76/builds/420/steps/9/logs/stdio
>
> I did not bisect yet, so I am just guessing that error looks like
> something introduced here.

Ooops how unfortunate.

I actually thought the autobuilders grabbing patches from the mail lists
would have warned.

I dropped the majority of the patches (not the preparatory patches)
from my tree again, rinse and repeat.

Yours,
Linus Walleij
