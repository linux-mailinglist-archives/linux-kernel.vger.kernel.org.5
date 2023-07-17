Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC65756D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGQTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGQTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:35:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5ECBB;
        Mon, 17 Jul 2023 12:35:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9939fbb7191so1009632366b.0;
        Mon, 17 Jul 2023 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622552; x=1692214552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYJ6kOFjamhBvRAj7/wxocueNoAM4M+pGSMxfmWyQFo=;
        b=PIP2Rn6tpp78cegzxLwoIVwZ4FoBHshqHfqr5nt5sFzhQBvh53GF/tVZ6bCY4fOp/5
         KetATrSe/jBBRw8duCXzr0oy0PkUOSeVKHyxaTYZY3cg3IEcD4wp68j156/IDK7juTqa
         PUQQSHBBwReNEkc4GfkEqyqyUQbnEzxSq4K3Oj8piOrGRe4QbZF6bCw6SYmY93TDBJnm
         9LMTy0R/Cvm3TEhwgFe6oVgVZ6EDWHLMBpZoM120061PxwrCycG3JFe3B2ac4nC5MUac
         UGwJJulRDn+UFcdkYS1OBa9V09CD++NvoB3oSd7vUTk6IZqcVKkREUhTvZHhWd17hT4x
         0GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622552; x=1692214552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYJ6kOFjamhBvRAj7/wxocueNoAM4M+pGSMxfmWyQFo=;
        b=gi1F9r9h9fHiP780En7mEJh2Se4p8VCjDXJfncqZ90/Ga9DV8UHC+EFKMEFTy+fSGg
         ni9RRba1Xb57i9l2EoolwxM7swdBOX4EtJjkIe8ROrygyneJu1C4lAYrQyOIalorOLi0
         x6EzneQN+XW0pC+KNDveQRS/jvDvsbyCGJunro/uK3EGKbKBJF2BLYAalJ0oebgraTZS
         doLubK5Iz0/d6jq1J0dYW0z3fL7hRU5Iw3we8DYLexaaoKf/h6LyEtSN+8nuwqF2Lpxr
         EJjUisjL3rLk6OCvBwsu/GAXa4fHXhbNL9SN9DkCdzu22FkLFgQwhgjnv0kvPikLMQBZ
         t5Qg==
X-Gm-Message-State: ABy/qLZjHClLGacAxmseGQ/ObjfZyMwaPotTY+RxOL2ZeUMDhq6h/8Di
        VIZdMTo9Dr80cWXXlzUETswiSM07HICFixYl+vA=
X-Google-Smtp-Source: APBJJlGW4673ZXUdmH9EyALyJYqmzpqtgm1SGTb0UF42kwcQ8Wh+SSnyIk9sxfrz+X4Pht1lQFCoW9Rx+xQJMZNrq+c=
X-Received: by 2002:a17:906:1da:b0:994:54d1:ff57 with SMTP id
 26-20020a17090601da00b0099454d1ff57mr10191773ejj.4.1689622552398; Mon, 17 Jul
 2023 12:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-7-andriy.shevchenko@linux.intel.com> <e356066d5e4001d5ae26a1f55996086ce0b59cf2.camel@crapouillou.net>
In-Reply-To: <e356066d5e4001d5ae26a1f55996086ce0b59cf2.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:35:16 +0300
Message-ID: <CAHp75VfkTUjv51MsLrZf3Zsg9Pn+6E-TkqW_c7fcwggD71RHrA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] pinctrl: at91: Switch to use DEFINE_NOIRQ_DEV_PM_OPS()
 helper
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

On Mon, Jul 17, 2023 at 10:26=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :
> > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > switch the driver to use it instead of open coded variant.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thank you!

> Although you could add a bit more info in the message of this patch, to
> explain why it's OK to remove the __maybe_unused tags (the code is
> always visible) and why switch from pm_ptr() to pm_sleep_ptr() (it's
> only used for system-PM callbacks).

Sure.

--=20
With Best Regards,
Andy Shevchenko
