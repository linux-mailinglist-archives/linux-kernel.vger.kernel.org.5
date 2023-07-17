Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67A756D83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGQTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGQTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:39:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD39D;
        Mon, 17 Jul 2023 12:39:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso699997966b.3;
        Mon, 17 Jul 2023 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622791; x=1692214791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOp2ZZ3wc36w9kvHwXp3awpd0wFGnA+hVpdKbz6GNXU=;
        b=DheUe9jqHtnMNx6N40uCc5AiolO11iz7WAmfwD5rCkeOqGj09Sx8tR6PZERo3jKe1m
         yaSa6GpCqRVUSf4+acnPacv2dNnsDZqeVxuPDfHw4Td6k3oLcEekxIHVL5DM7lUydvFZ
         1yH4MXeuVnqFJR6JiFjmP4gXyjIUorYoxdLot1ekrL0gkrY6mjCO0iNwacJwU8c9fBaD
         emJeHw+wYJaUYZTUsjKIXvMc6zD8+c9HU+BwD/q0gBAYdVVCZBwJXCBRrVJJgz75L9I3
         qltW9FwH9S69mpWDlwv4/kUfAUFPPoUC25iZ/kMewrK0Gq+l2iI7fBTRnFlkzWzGH6za
         OPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622791; x=1692214791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOp2ZZ3wc36w9kvHwXp3awpd0wFGnA+hVpdKbz6GNXU=;
        b=LpEVLQMzuaPNZIYkqsyBbdWUEjPgCiKQzxPelZMtRHwzGrWi9O6wzjRGi52uZyWzGn
         bgzf/oV6CLNetpbjuDegoJBQ3XcotvPY3LPeW1alaIcGy5HTgEwVG2VEM1Nu8K70u1AE
         7Co+dcyvtCAsry8QMeiRNa3FMRgoqtJzUsLaeCcD0Rx1LYqwlWAyug5pO8mLgEZZZr70
         RZCxGnjFOcP/D9e8dt3L9Y+VR0lGxmZ41+Y6iD2lkObV8b68i5Xjh9iZZ60wwStXn1pd
         OUhhEbsuG0waJUCgcr4pUqCfW4/ICzgOLVl35hQIdeqG8830UAj/G3YTnPKyyGnJKL4X
         4A1Q==
X-Gm-Message-State: ABy/qLbnvYK8DHz3oug1p1BFYr1cJ+Czc2NSfaFSK+6eUw5vUKICFEMG
        V+/NQCLk2pX9wGn4/rddNIbsUaBOVbSgxS93iuE=
X-Google-Smtp-Source: APBJJlG66q2eVrKtgpAASjhMjhczg4W5QDeuTaoOb4zn9mrNG3umEbjvgyH7X6msZHAYfZ9gd95bh+fbUtFHCcQUtj8=
X-Received: by 2002:a17:907:1c1a:b0:992:ef60:ab0d with SMTP id
 nc26-20020a1709071c1a00b00992ef60ab0dmr12390276ejc.69.1689622790750; Mon, 17
 Jul 2023 12:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com> <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
In-Reply-To: <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:39:14 +0300
Message-ID: <CAHp75VdVM87gbFX9sPKo-+eVRUsK8pmC_fyCQ-_6oMMm1aAQ9Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:14=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :

...

> Another driver where using EXPORT_GPL_DEV_PM_OPS() would make more
> sense.

OK.

...

Thank you for the review of the series!

--=20
With Best Regards,
Andy Shevchenko
