Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE87B756D34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGQT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGQT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:28:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A0E1;
        Mon, 17 Jul 2023 12:28:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992b27e1c55so638564966b.2;
        Mon, 17 Jul 2023 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622083; x=1692214083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb2qmqc0S+l9zveTKecTCaBrQtpukHKGGQbHSZAWBlw=;
        b=BTRCe0wSjL4OnWcx4c9xtGoFBpUi/oxwv5MWrOI0B/XSq6Q6XSQI2iLkpgBO/zJJem
         g4HsijBeJwuB0G5miOL8aNMgnYql9PGrDXF/p+K960iFN36I2uRG/2fw+n73VrYXcmcP
         4HXYuKyxR+TuifXaPkGc1+W+j+PMZ/RSjgHjft5FFcvpOAYVYS126axP0DP/dzrRLPPa
         dxGaL1EN3Ls/gGOs6ARcG016+HkVHSQa4Ex77y5xnWiOL6xwXnaeDCpqh8iRKNhnvB3d
         rEyKL8YbqJdg17R3eE7IIoOb42Ds8aIV8yBilKk6+v04QpwU0DYKCsCvX4zlwxRYbI4l
         Xtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622083; x=1692214083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb2qmqc0S+l9zveTKecTCaBrQtpukHKGGQbHSZAWBlw=;
        b=PqvHXoZaTcFuLJm+7nJIT1ewx0DBeBg5gUUqUsQF76J3UMAxum6NMtJwTBzuh/k9cK
         iNzMX/HiBQSUIx5FjO74Xb9fKLoeg1ROLrAVHovWwFC5N6YfwuSZHJYaZvGMtN2jypsw
         A2fi2etzuNANfXaZev5Om3Oy3BjVyg8KsInHT6AKJm0DDMK261rorqcHraifjySHULYx
         PmRiy7K6T+IbVWX9o/L7zVKE6zZs7K63B0MEPB9x3wHHsToDoVi9Ec2LQGyLgJRZAyWV
         a5t9cbZbDRnOb8HDDSo8xqA8yQBQHDQvKEHk22MrVZPBwmPruaEiLP3V/omsP+zRuaFy
         98gw==
X-Gm-Message-State: ABy/qLYVNuHk0S+k+2N/j9sIzsOGFgmmoke8yjtjAk8ezBNj6n9/86XE
        pO5/CugVNTMBQgL8aWUwipgOuoXb3soyPgKi72Q=
X-Google-Smtp-Source: APBJJlGHUsCxOzwC1BXP8sKGI4zFCzyewqJILgIOQ9UMgqwwJ4S5kzJ7xxe2L/QiASSZB9oGB1E/wmdh1nID6rQCrxM=
X-Received: by 2002:a17:906:52da:b0:992:16bb:2b6e with SMTP id
 w26-20020a17090652da00b0099216bb2b6emr9690173ejn.29.1689622083203; Mon, 17
 Jul 2023 12:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-4-andriy.shevchenko@linux.intel.com> <73161288a07eb34a458061151d9d9a5c10d79c1b.camel@crapouillou.net>
In-Reply-To: <73161288a07eb34a458061151d9d9a5c10d79c1b.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:27:26 +0300
Message-ID: <CAHp75Vc6yYz94dZmf2QJ3jV1Yqqw-7_47sm5hSSU2M9B2O_BQg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] pinctrl: cherryview: Switch to use
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

On Mon, Jul 17, 2023 at 10:22=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :

...

> > +static DEFINE_NOIRQ_DEV_PM_OPS(chv_pinctrl_pm_ops,
> > chv_pinctrl_suspend_noirq, chv_pinctrl_resume_noirq);
>
> That's over 100 characters, please break this line.

If it's a problem, I prefer to shorten the names of the callbacks.
Would it work for you?

--=20
With Best Regards,
Andy Shevchenko
