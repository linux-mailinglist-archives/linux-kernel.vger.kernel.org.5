Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F23756D74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGQThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:37:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F83A9D;
        Mon, 17 Jul 2023 12:37:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso641204066b.1;
        Mon, 17 Jul 2023 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622630; x=1692214630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I8tWuOCSAKoVEcr3ABsrBviosGy8IVjZCqtWlU4uYU=;
        b=Xn8/9u6umMxdhgyMQrkVzTfwZbVc3CSoo01rUE0MOFuZoIqDsjCe35rMOqsc7u/U8d
         NgZ/n//yzSKJwZYlQauLDrzecOJpB+a2wLgqD7B5FU1EKRQhzucEFmSjIs4nAHGqREW0
         h4VYQ/1Mtq86XhqjxCqWBQrdZoeE5Gm7kVnZ48vJViIi6zgBhcxXbika88j9GZjxVDiP
         x9zH4ECmS8gWniDjEp2Xyomj9lyBEQ6q1xY/m8CzhsMrmzmMTgZMDg2jWnO1udo1/blr
         KQHhAFB8ZoCE9oS0c4M7xQaZLYfHNhCH9ulj2RCcRz5KJQV3TP0EKRRMUfw0uw0OZJKG
         dlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622630; x=1692214630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I8tWuOCSAKoVEcr3ABsrBviosGy8IVjZCqtWlU4uYU=;
        b=Z8c05kUYBshFXjp8Ry35X9vRH53rYJweNb6TFmbYjVPeMBC0O9wAuDArxVLAAUSHMn
         cR8vUmR9MJE9gvTVMbDkBsvRGzgBnes4fhbAaAJK8MZDEl5isHAI+oQ9Kjw/1ibvRhCY
         XLThz+hcNJaTRa2W/Hln+e/MGMU4+U5Sp6L6KzuYCA8I4oeOA/1U/Pf7tBRnBChRXL5o
         IsGsse4jVYgvGnz7xDjDEm8WfOJQkZvIhBSp6T0225/xNMDUWulXrzLDpSFna/qNdj41
         HL3RDDanlBKPBjTMgZmevHSP9ZaYeSSw4H3Jpraw+HRS97/bGblOmikpys80w/78qOzL
         5rHA==
X-Gm-Message-State: ABy/qLZTmho+/67lopHdgWFb5CkwjZsocXMDsH6SkpdeGNI2Zdx48cvA
        OS4HklrtydoOmvnqN80vluLd6A5CeVkswXDA0vM=
X-Google-Smtp-Source: APBJJlEDMaQglJp0zHLnSAANuJWSE2xOez2T+ELk8R/+NG+8JrC1cfjD9INONXiEfrURSQaDOsm7LxITDgeIeKE9KAI=
X-Received: by 2002:a17:907:3c1e:b0:993:d6e8:2381 with SMTP id
 gh30-20020a1709073c1e00b00993d6e82381mr10091030ejc.23.1689622630101; Mon, 17
 Jul 2023 12:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-8-andriy.shevchenko@linux.intel.com> <f48a35d596694839665bc5883260cbae3ae01d9c.camel@crapouillou.net>
In-Reply-To: <f48a35d596694839665bc5883260cbae3ae01d9c.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:36:33 +0300
Message-ID: <CAHp75VfSd6giH0Hvt4m_cai5+qhhBfMa6R0fDhzpN4U7WxYzSw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: mediatek: Switch to use
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

On Mon, Jul 17, 2023 at 10:07=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :

...

> > +DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops, mtk_paris_suspend,
> > mtk_paris_resume);
>
> It's a bit more work, but I think you should use EXPORT_GPL_DEV_PM_OPS
> (or even better, EXPORT_NS_GPL_DEV_PM_OPS) so that the dev_pm_ops is
> conditionally exported. All callers would have to be updated to use
> pm_ptr().

Why pm_ptr()? What did I miss?
The rest is OK.

--=20
With Best Regards,
Andy Shevchenko
