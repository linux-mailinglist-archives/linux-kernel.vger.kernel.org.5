Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A854C757C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGRMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGRMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:48:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7905E1701;
        Tue, 18 Jul 2023 05:48:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52176fdad9dso5353305a12.0;
        Tue, 18 Jul 2023 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689684517; x=1692276517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxhlaudfrVWECFV1Jg1vpXKt16R6kpyS29S9patDTO4=;
        b=fVSpB/MPdEPpD5mWKQe0IChxg2s3WZfPkNpBCHhqpZjj648drB+NvNhNdLf85e3P+t
         0s63bmVRtfumS6L0d/MRmrwu86sA2uLxAKLyz9QRrK5/s49KBSJWYnmLYhpCXbqBCZvk
         RrP4iHQjDESXl09EiBVtu0DemVK/sav+ATktJDcFoPczdqpBsmXHqkwZGwlxhnFDTXSH
         bF/cPlbGrlKDRBayoydjMjGSuheaUtq9JXeABTLysP33Gm3Lvjc5E47bBTCAZ4AF9xgV
         IlAjyPE2P37RsWLGpAqO92h+UeQcyhh4GVGl0aAMp7GeO05y+zo1ltv4mE6txeUEiIhI
         CXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684517; x=1692276517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxhlaudfrVWECFV1Jg1vpXKt16R6kpyS29S9patDTO4=;
        b=Fr/x4wxBMVbvOe5dh7/EOrGSOHxSSVbNbynk8juMhgd4tUg219HLjUBHJ2ZYcp9QK/
         dCXlGAAkIN0R/IU19Q0xloN8B3TCex9ZBB0eHTD8D991HetZ0BeB2Jo9qlyY5zTRJow4
         BTEjFTSX+ZYOfU0KkuyLlnBGGYyxvXY1yu+SIuB0H09MiipqRW/Ngjkr9NUEgpyf1HDV
         RePALCE5SWgsJHgY5cYGNMNXX0rU+IoH7dWInlQti8WXbJqCoJvnevwsVZ/soxlG7PsQ
         X/hc/tzLd61RhiXlDXB7e0cqo2A+uWej1I74ZX0xsGyh/PO8bc6LM8JPv9Pk8SGfcJQN
         IppQ==
X-Gm-Message-State: ABy/qLavzmxZZ5WxYAvqwcRqhMk1P4Fff01vKZEbwzV9A358O3VmGlmJ
        bYCBh3EvYSmIjIzWBk8ddg6Gs+tdEN0QHkdGbIw=
X-Google-Smtp-Source: APBJJlFHZoGo5cMXz5ZPoaXb8GQZF2yrH4fr5l8DeDddHglvOBiZmH4dtEo+coI2p2aE1zI2oNE0z2/uarXLB4bzRvc=
X-Received: by 2002:a17:907:e92:b0:975:63f4:4b with SMTP id
 ho18-20020a1709070e9200b0097563f4004bmr2250208ejc.36.1689684516758; Tue, 18
 Jul 2023 05:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
 <f48a35d596694839665bc5883260cbae3ae01d9c.camel@crapouillou.net>
 <CAHp75VfSd6giH0Hvt4m_cai5+qhhBfMa6R0fDhzpN4U7WxYzSw@mail.gmail.com> <7dc59ec83ceb6b7c101039570652fb9c8122d15a.camel@crapouillou.net>
In-Reply-To: <7dc59ec83ceb6b7c101039570652fb9c8122d15a.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 15:48:00 +0300
Message-ID: <CAHp75VdehQnE+NvD1Pj_VZrj-gdHZow+kqyud_T8=3Z-YB-C7g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:57=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 22:36 +0300, Andy Shevchenko a =C3=A9crit=
 :
> > On Mon, Jul 17, 2023 at 10:07=E2=80=AFPM Paul Cercueil <paul@crapouillo=
u.net>
> > wrote:
> > > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9=
crit :

...

> > > > +DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops,
> > > > mtk_paris_suspend,
> > > > mtk_paris_resume);
> > >
> > > It's a bit more work, but I think you should use
> > > EXPORT_GPL_DEV_PM_OPS
> > > (or even better, EXPORT_NS_GPL_DEV_PM_OPS) so that the dev_pm_ops
> > > is
> > > conditionally exported. All callers would have to be updated to use
> > > pm_ptr().
> >
> > Why pm_ptr()? What did I miss?
> > The rest is OK.
>
> Or pm_sleep_ptr(). As I said in my answer to the other patch,
> EXPORT_*_DEV_PM_OPS() currently only exports on CONFIG_PM, so it
> doesn't really matter which one you use.

Yes, I need to think about it. I don't like the inconsistency the
EXPORT*PM_OPS() brings in this case.

--=20
With Best Regards,
Andy Shevchenko
