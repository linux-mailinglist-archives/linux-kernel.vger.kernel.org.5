Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE1756D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGQTjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGQTi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:38:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71A170F;
        Mon, 17 Jul 2023 12:38:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9891c73e0fbso1007621866b.1;
        Mon, 17 Jul 2023 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622723; x=1692214723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzvnaxwBwwORvQbS7D5g0+aYIhp8HhzVz5H7C8pRFBw=;
        b=FiRiQHHwJkvt69aqh+jOHbOkpeDUm9bJCZzo/bIzNvXv33+g8pfIgIF2ZYvKOkquae
         /ffDOMzSAn/cmRXkDPeGd/FpoyNgYPuqE9K5CPWtlDQjOTZX3L0ghvt4T1I47WnD+ci4
         33PQkxXqiUurlTLVNfjrY0BaTMm9DB+40F00udddUtlL2ohyESp4gm9yAgKrHmUyNVlU
         LAH38/mclJRvw7bS9aeaWHbk7IpokVI242eiBf2MSoiGouOzivPeFx5B3hbcrh61WKD0
         FuqnDHgfqqGpbH3D/09tfpPwr6Sb6kFh2fjf29ddMPLPC/b3StAf1LsqPjoFysvEB/xB
         k12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622723; x=1692214723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzvnaxwBwwORvQbS7D5g0+aYIhp8HhzVz5H7C8pRFBw=;
        b=b18QQAscBdu2AOsJW7LyuL9SzR/ZAtnVy+/5BO9J9gKVrcSgXsP2m6I2ry8Hc01Hi+
         YKq0s2FqjzTfwxkOmpk0XPqR5y88ynv7g3ViLbKLgM2laxZGhmpTIF95H4OrSMQV+dR9
         bRCg8XIyIwpkplWt1o+E0Wt5tx4nVJ51EOpQhOUdpdY7kgaB+mYj0fkxu12a9CHnc3q0
         9pEEXWaug4wOJX03WBwwiyBGH7A14uHxiTOZCGA2ekYVeBu90Fwm1b78guplyFZxSP/Q
         WcAh4jF4n0TlJlxAwHhu9X0HH0DToGf865i+NJEp9+4kaX7DscY9If1z2zCCkYeiC1vK
         26tw==
X-Gm-Message-State: ABy/qLYqtzba7tvxLGTtPpQ8B3o1e2AumeJu6ZNlU0vagj1Sih8X83Z+
        DZ57KVuPEfXPMksrcpMFWt151z6MTB0NyiEPuGk=
X-Google-Smtp-Source: APBJJlE+VHLj7mC4ECfhwTbu4NFaO7sKnyH5XVNAzPprNo79TW0VvqfrC6d6hAbtJKJm4KRjeiwR0QctV4B0Sd+swhY=
X-Received: by 2002:a17:907:7f88:b0:992:103c:43fa with SMTP id
 qk8-20020a1709077f8800b00992103c43famr15701919ejc.30.1689622723578; Mon, 17
 Jul 2023 12:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-10-andriy.shevchenko@linux.intel.com> <03592cf5d6854dd5e534e0416de946fd38e4380c.camel@crapouillou.net>
In-Reply-To: <03592cf5d6854dd5e534e0416de946fd38e4380c.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:38:07 +0300
Message-ID: <CAHp75VetZ-+AFGzEQzx42cmTrHxyr7pGBy8kSxHUM9cJzp2o=A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] pinctrl: renesas: Switch to use
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

On Mon, Jul 17, 2023 at 10:12=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :

...

> I think you could do:
>
> .pm =3D IF_PTR(IS_ENABLED(CONFIG_ARM_PSCI_FW), pm_sleep_ptr(&sh_pfc_pm)),
>
> Then you wouldn't need the #if defined(CONFIG_ARM_PSCI_FW) guard either
> (as long as the code still compiles fine when that config option is
> disabled), and you wouldn't need those dummy callbacks.

Thanks for the hint, but it's ugly looking code.
If we go this direction, we would need local arm_psci_fw_ptr() macro or so.

--=20
With Best Regards,
Andy Shevchenko
