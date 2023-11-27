Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C024D7FA360
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjK0Osr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjK0Oso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:48:44 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDBA1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:48:50 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35cc155a467so4195595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701096530; x=1701701330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3FLX3YynhvX8mGBDXZEVUPH4OcHBZ2EUZ4Lk2rEt1c=;
        b=a7pYE2aWifuoFRXSQ6zcnLuYt2Sy2I9bDprPt9EY4fq6088lhrMaYlFdNbO7UdURf7
         svn+etxDHXIcX71dsZOmAVmFQI/zR8dEtVudgIu2SSouRSASnqUJKdMkyh1gVruPU4xV
         NyEX8r06w72PHkJnYM5wZ7EvMOsMlpmXH2KN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096530; x=1701701330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3FLX3YynhvX8mGBDXZEVUPH4OcHBZ2EUZ4Lk2rEt1c=;
        b=W0afg9hjD+ZWQAB6ZAZMPSJbeiswLNlAALlbIUApK/zBVEsY8mtg9FkxEjkh+uwmo8
         d7D4Q1nrkEqF/4zLEEE7/WNol2AlytWkug7OSRRMF8V/tDNz0aXjUhFek/XFF5XwCUto
         mfUirwjaUAlQ0T1zY0UNfpxQFyJjM4z/2vjfnmQddfhEXsyWoj5QLAtp8i7oy4OQD1I7
         4lJD/lf4OsHxFu2Q4jwfGTgfWJtRGlVYIG/6mwNLznIbA7iCqExKF/UpJClipC016XJ6
         Z/d+uej37bHM3RaY6Fb3fRefm3Q0nrJT2aZIR0FnDBc6sYG22fF22+nDUB3en9jKC/tL
         xubw==
X-Gm-Message-State: AOJu0YyYM7/7yiBHJ/AQhq3eP5s4jpC+rIWHOpvWJhQL849Xr2Vf1CVk
        D0NpZQk1g2ndBtdI/kn2uTd8lDix4s+GA4Qj7gi4oA==
X-Google-Smtp-Source: AGHT+IGcnqezwlGNDh2RQ7YHJ0GhpoAmyujmyGpF9m9aXpMS1mAWqIijhV4vdV0EDPLxT8+wxU+ENK4jUdVRZpXfG9I=
X-Received: by 2002:a05:6e02:20eb:b0:35c:7b32:2425 with SMTP id
 q11-20020a056e0220eb00b0035c7b322425mr11231186ilv.8.1701096530125; Mon, 27
 Nov 2023 06:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20231117095531.1693753-1-treapking@chromium.org> <CAPDyKFqjcP2pAH8uo61Yc7wU76NM1aCMN6P1TaAoafCFfZSeWw@mail.gmail.com>
In-Reply-To: <CAPDyKFqjcP2pAH8uo61Yc7wU76NM1aCMN6P1TaAoafCFfZSeWw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Mon, 27 Nov 2023 22:48:39 +0800
Message-ID: <CAEXTbpd7qD4qzY0p3rDD92eTMVCeu+ZsOWBMwJA8cOYe8=JvgA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        ot_shunxi.zhang@mediatek.corp-partner.google.com,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Fri, Nov 24, 2023 at 1:13=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 17 Nov 2023 at 10:55, Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > This log message is necessary for debugging, so enable it by default to
> > debug issues that are hard to reproduce locally.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> >  drivers/mmc/host/mtk-sd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 97f7c3d4be6e..4469003f571e 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1150,7 +1150,7 @@ static void msdc_recheck_sdio_irq(struct msdc_hos=
t *host)
> >  static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_com=
mand *cmd)
> >  {
> >         if (host->error)
> > -               dev_dbg(host->dev, "%s: cmd=3D%d arg=3D%08X; host->erro=
r=3D0x%08X\n",
> > +               dev_err(host->dev, "%s: cmd=3D%d arg=3D%08X; host->erro=
r=3D0x%08X\n",
> >                         __func__, cmd->opcode, cmd->arg, host->error);
>
> How critical is this? Should we perhaps use a dev_warn instead?

After rechecking the driver, I agree that dev_warn() is probably
enough as the driver tries to reset the hardware to recover from the
bad state when this error happens.

I'll wait a few days before sending out v2 to see if Mediatek people
can confirm this.

Thanks and regards,
Pin-yen
>
> >  }
> >
>
> Kind regards
> Uffe
