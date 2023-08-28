Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB67678B721
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjH1SSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjH1SR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:17:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3613E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:17:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5694a117254so2116630a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693246675; x=1693851475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST1QjTKCc82SZdk+pNvbsP6NakS7LSM94lfvcXXT4Qg=;
        b=qQP8XUJEPoevDAA/CsB7DhvBH4Lw1P3PzFuEm1zPg3eUmryY0kG/kzqjhP8W6JfPhM
         cbJkZUcwBCuHyoOZRmidZBsJMY/jygNtYMbGEqjdV1SaRsT5uwywTrhHiVQFgxXn00+s
         HrobdMW2o8Rqf278qbVtnUUUhNRBGioSEGS8IMwoWQQQvq7RaarvGrXuW9aHYUfODmMQ
         wxhPr6AkfQ48hy+MnuLMWCGwjQAKLbMeX3CSlLrv1ipp5QJShQ5hjnYVbON9/FYJF9Ey
         jOb3T7vvH7IX0VMkG9Z1y65gZ1lYLME5NXaHszK6B5coVPAXmeGwk7aA/JZYv/ZTYoqH
         uJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693246675; x=1693851475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST1QjTKCc82SZdk+pNvbsP6NakS7LSM94lfvcXXT4Qg=;
        b=i8JgVYUUWY9tAn0tQgxlE1jcitdHOZeczmi6r6ts8E/yjaL5gj4e2k3GqwVtWzEMAB
         uHWVJYGO4ZoGQfqAy/VHo9kHtz8G06PLW51qvvzqg+40W7nHgYczHqOdQVn/24tM+gxp
         9ErQcCSXN8qdsfjpvXdRnENjYl5uELkn2lWayOLtln1PS3smYgYdZ6tPt1FSULTqFPLi
         lYY9psl69eNMDIRl4Y9ZYlNEobni7B4C3gzU9qqMgz/1My5xOilVdfUl6GMXTdu4fq1X
         poxNG91PH5yTdBwPB+0J8RiFVoWDQ+HWPlyHspXOMrVhxLPRAVeVUHsjpYbf49HrsAA+
         Ud4Q==
X-Gm-Message-State: AOJu0YwVZpnoO2UOrp4kHJNagjpqcmCySodK8/moNWeJJNL+AW1LxpFq
        rMN8fT0a1q7SUOxZHbnVSDyaK3tdBmHnfjhv/ZU=
X-Google-Smtp-Source: AGHT+IFldvTwxr1MrZWlFZtUS+bR3qje25kLJgKcGa+/Fu6RdkJkExz6Cg34NH055QMabPBepYhdiGy3F5NwscJxVMQ=
X-Received: by 2002:a17:90b:3ec8:b0:268:1b62:2f6c with SMTP id
 rm8-20020a17090b3ec800b002681b622f6cmr25435521pjb.2.1693246675300; Mon, 28
 Aug 2023 11:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-3-b39716db6b7a@pengutronix.de> <20230828164148.tm23yudt76eqefzh@pengutronix.de>
In-Reply-To: <20230828164148.tm23yudt76eqefzh@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Aug 2023 13:17:44 -0500
Message-ID: <CAHCN7xL8nMs3w82EWtxr1DGncejZtwDgVfR6KBxmkJdD7xAYQg@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/bridge: samsung-dsim: update PLL reference clock
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@pengutronix.de,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:42=E2=80=AFAM Marco Felsch <m.felsch@pengutronix=
.de> wrote:
>
> On 23-08-28, Michael Tretter wrote:
> > The PLL requires a clock between 2 MHz and 30 MHz after the pre-divider=
.
> > The reference clock for the PLL may change due to changes to it's paren=
t
> > clock. Thus, the frequency may be out of range or unsuited for
> > generating the high speed clock for MIPI DSI.
> >
> > Try to keep the pre-devider small, and set the reference clock close to
> > 30 MHz before recalculating the PLL configuration. Use a divider with a
> > power of two for the reference clock as this seems to work best in
> > my tests.
> >
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index da90c2038042..4de6e4f116db 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -611,10 +611,21 @@ static unsigned long samsung_dsim_set_pll(struct =
samsung_dsim *dsi,
> >       u16 m;
> >       u32 reg;
> >
> > -     if (dsi->pll_clk)
> > +     if (dsi->pll_clk) {
> > +             /*
> > +              * Ensure that the reference clock is generated with a po=
wer of
> > +              * two divider from its parent, but close to the PLLs upp=
er
> > +              * limit of the valid range of 2 MHz to 30 MHz.
> > +              */
> > +             fin =3D clk_get_rate(clk_get_parent(dsi->pll_clk));
> > +             while (fin > 30 * MHZ)
> > +                     fin =3D fin / 2;
>
> Really just a cosmetic nit: fin /=3D 2;
>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
>
> > +             clk_set_rate(dsi->pll_clk, fin);
> > +
> >               fin =3D clk_get_rate(dsi->pll_clk);
> > -     else
> > +     } else {
> >               fin =3D dsi->pll_clk_rate;
> > +     }

I don't have all the code style rules memorized.  Did you run it
through checkpatch?  I wonder if the braces here are appropriate for a
1-line after the else.  If checkpatch is happy, I am fine with it.

adam
> >       dev_dbg(dsi->dev, "PLL ref clock freq %lu\n", fin);
> >
> >       fout =3D samsung_dsim_pll_find_pms(dsi, fin, freq, &p, &m, &s);
> >
> > --
> > 2.39.2
> >
> >
> >
