Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03B756D29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGQT0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGQT0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:26:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64D1B1;
        Mon, 17 Jul 2023 12:26:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so73748831fa.0;
        Mon, 17 Jul 2023 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689621995; x=1692213995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jUY1jEJmV3qWV/43bu9eEtdH4W6Xqd3vD9XFmNOjKI=;
        b=NdT8Ok/z3CyjC/m8f+adwlKtyAxdYC3w0X8v2PC6edXelaYryvjGkvvk25uVL8Ac9M
         9P60v5TzEIgoAunufAb5eKO0g4whc+Mtqr9z1yRm7W8KfnATY0YtQ985XGLLRX143cDO
         MbyjGtOACZhukJce1PPT9FM7Fmz4M1/mIQcO5Fg+H51uMJtveBeR7cmHuG8YnU1+94uP
         kTMJKEX++PzPpf1PSnOd2sY9qNU1W+up54S2meOebzWFVAUfnkjGtIIrD8tPRJaQEMc8
         C5+4eL+4dMnFh5OxbkYIkIKTHt3L3u0rvxt5lBZkz1G0yIo5YVaAFqx+Yb4N7CoazIxV
         MKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621995; x=1692213995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jUY1jEJmV3qWV/43bu9eEtdH4W6Xqd3vD9XFmNOjKI=;
        b=lUYh5Qqs3fHZgRzy8gKMtMKSgoOZ6PDJy/2+wUQporD62T+HHMeNbRxv07xsqb290Q
         go6f4tzDfymhXetHtpnBABQotrxJY/WuKXDhyoruZAiDBjd3qiPfFfnjLFBweQPM76oV
         NN1vwAS9GHotw4vY50WJ1gRWEoiHUiMRNzJe0/phuTc9YSjp5Aq1Ik5zFfsaf0p6CuPi
         95F5bCwFQ3Ikf8ZJMmG0l5UV5CAro0It9oaRIKVKssAwiHjqOcVtP5OdRI4aZcQL/7PP
         YTrilvJKVWZEZIolFVrGdsNbfOO53HLW1ncXaYz4Kfv0WmN/hyULsG3qBHrHe4jiqrg2
         mgPQ==
X-Gm-Message-State: ABy/qLZbn4PPscqlXQ5+lufunRBxsHnpwDfdgszHcgNytbAISNbYdO3w
        E75z1FiTMorqi+wdpkNWKgu8Yj3sHSPZa9Tv1HC597j8NCs=
X-Google-Smtp-Source: APBJJlH2RTaXZ3hTVITWgLRumGcexov0CNacaQ45uBlxGr0vGAsIESz+PDg2BypvK6Yznkn1rI3VBaMZjcwjiZdYXdQ=
X-Received: by 2002:a2e:8416:0:b0:2b6:a827:164f with SMTP id
 z22-20020a2e8416000000b002b6a827164fmr8225340ljg.10.1689621994680; Mon, 17
 Jul 2023 12:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-2-andriy.shevchenko@linux.intel.com> <a9c7064df30215878925206751a4017830938ede.camel@crapouillou.net>
In-Reply-To: <a9c7064df30215878925206751a4017830938ede.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:25:58 +0300
Message-ID: <CAHp75Vc2m48hcU_+3Kyt8-M-4CQUjXbpbz6VMSWpH1kbn_Fjkw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
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

On Mon, Jul 17, 2023 at 10:19=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :

...

> I'm not really sure that we need this macro, but I don't really object
> either. As long as it has callers I guess it's fine, I just don't want
> <linux/pm.h> to become too bloated and confusing.

Isn't theidea behind all helpers to simplify life of the users by the
cost of bloaring up (a bit) the common file (header and/or C file)? As
cover letter shows, despite having several LoCs added to the pm.h we
saved already a few dozens of LoCs. And this it not the end, there are
more users can come. Moreover, there are some deprecated macros and
those that starts with SET_*(). Removing them can make balance go too
negative for the pm.h (in terms of +- LoCs). So I can't really
consider above as argument.

> Anyway:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thank you!

--=20
With Best Regards,
Andy Shevchenko
