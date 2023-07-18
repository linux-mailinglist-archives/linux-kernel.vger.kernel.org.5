Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94868757C45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjGRMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGRMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:53:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25441126;
        Tue, 18 Jul 2023 05:53:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9936b3d0286so802452466b.0;
        Tue, 18 Jul 2023 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689684826; x=1692276826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79kLUvgjaFzQrWOgx008zsF/7GOXg8shTx0H5AGYDQw=;
        b=Tks5q0JcRPcKf7Kf/5sMNv0WyprOQ5QOCm+wFinM49VOX0OPVPh+czO3QBSvYJlbZs
         99Dqxi9UZ0XzbWLIpQssTKSRP/ibR01+OZ6gPO8G735PMobOMqBZMJ7ItLKFDJGq4mVE
         L6Gp/kXJT7E60Vbz13h+JeVrhe9nq31SBP6WJDXk2r0HxYjdmtAFAR1q+X0fPT1ysJ1n
         U0CKU/xFTsOavOkaJci2k1okA1j1f+aPXviX7pPeDadhzYYPlWWG65eFqNiNGRDyv3yU
         WK2LkwXO09tPOZ/uycvS/9DAn9g1M57tOccnl5zRlWN8fD6udXDPzl//1L/4NA4OHolo
         Lb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684826; x=1692276826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79kLUvgjaFzQrWOgx008zsF/7GOXg8shTx0H5AGYDQw=;
        b=DeVLYelu2269a8Pkj8YNJ3JE28qpVpkxS8oppNTaxtomOywRICn/r68lXAuE+hWCH1
         2jrv3N+CTNxOh3SEXyVN1QhE1yBFZWX7Oq4Lq5EKFBduYygOq5vsx9T/HwrYNy7t1b46
         +pSZI392SwKkV4Obg1ouQQmNpLVPmi0r/cQUlKGEvCFanYVJMWPHT1Zf9ZKYOwg7Dpla
         tQLYS/HxE/JouKEgXYgi1fdSzaYQJDPIzaSf7DnMwwb4IhIspl/HTCBskCv2VKquH0AZ
         UJjQQTwmQqwZZBKbmUDUFaLMtw8bDm+HSNG7eLexbRMVR/1BouFLtPYPV5CMZrdlKoWC
         vOug==
X-Gm-Message-State: ABy/qLYMBUhWJY32F7UZgSnd67zl7nJTkafeZNP/Ow7B3zoVjt8B/yX/
        s57SNiwPAqQCeevjT98Uur6VlbMgfGL1oKzbW8Q=
X-Google-Smtp-Source: APBJJlEiNMwdGUgpHIKMmnEgRY+QNSS28oQH2q/Czd9HAANojvR1sxg1GKNIsNiHyHioOrvxRuwFkor+DKPaLczWNdQ=
X-Received: by 2002:a17:906:109:b0:967:e015:f542 with SMTP id
 9-20020a170906010900b00967e015f542mr12775335eje.44.1689684826263; Tue, 18 Jul
 2023 05:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
 <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
 <ZLZDL27zzDpY4q8E@orome> <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
In-Reply-To: <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 15:53:10 +0300
Message-ID: <CAHp75Vf3mijhiS6JNhD4Dq4EpbKmok5m8MYNaguUgpUBak9hTA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:43=E2=80=AFAM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le mardi 18 juillet 2023 =C3=A0 09:45 +0200, Thierry Reding a =C3=A9crit =
:

...

> (or better, the namespaced version)

I am all for consistency, I agree on this whenever the driver is
_already_ using namespaces. Having one macro with namespace and
disrupting tons of the drivers (MediaTek case?) is not an option in my
opinion.

--=20
With Best Regards,
Andy Shevchenko
