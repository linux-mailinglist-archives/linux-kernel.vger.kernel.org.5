Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F2780942
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359568AbjHRJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359573AbjHRJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:58:52 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250722D7D;
        Fri, 18 Aug 2023 02:58:29 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44bfea78928so238331137.0;
        Fri, 18 Aug 2023 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352707; x=1692957507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTg8S8dR/qZ95KZ1/uRPsyWt1lRQtdYq1uVtLvb4cMM=;
        b=pyWsEKLEUymxtayX34Kyo7TDvGynNG1da86dP9bXsVwWyzpv9S7iwRcI0WgvtQWZUP
         K9VyQVy/bQPJuzfs044da4m6k3IMxHtOYYsTQI4A+tBl6enoSgIdhm6I2we2cS4nMNDH
         jtXxMy9ILvQa5kvxzoqA0tVwh4D3bDGgF7DoA7h2P3SJRG6Ka4rxjPDLJ7DMAyz75Ox+
         ck2jTDLP70fIFJYiH0R+qgJHUc3X7mBBRgn+0jP4lUdGBpcCbaXbv6ouywnrPUxUluLe
         iobDA93mLi1ZAIp8V38gizGvNuoiZnfbMQ68Vn3+xSfyBgKKcvBWv3sznXzBlYZiB1c8
         pjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352707; x=1692957507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTg8S8dR/qZ95KZ1/uRPsyWt1lRQtdYq1uVtLvb4cMM=;
        b=Jn8QymSjdDevO7MS6MovbvBx0BA5e45joKTOSiVO4FnEFbWR5JyIkndtfWaHnPlDSC
         dKYr1z3mu44tfolQcWlMZYNYqslKe7m4LP/1iySrpEEfdT4YoG1uWT23UhDA4Z5aFDPg
         GUvA1MJFyg1VZgL+mf+55xgzdUjnESH8O9YRPVrHETSPkmmc6WpaHrKlhFguWt9ak3Tu
         mzlmd5MSDFhNr6GkUSwMQ+3ErnidKROHTe9w2EppNyTX/kh1t36nNBKfR5Fhdt25raxM
         ITK0i9QTLqWdwWI2OoQXG1GDQd6S2dZJFY8rvZpQmjCYGFgjqqOGllMwY7U5HqptsXVX
         qqow==
X-Gm-Message-State: AOJu0Yw4A3thK/NOvREz0cywj8cgjzUkwTeQIMzc9EjniHt7voL2/ITS
        U6zFP6f20ZvXurOQLvBanz2URbVQPc9JPWHZEOM=
X-Google-Smtp-Source: AGHT+IFVy/8Mx+m0qHufjyk9ON8XcKr6RKNH0TRXL0OTuDO4iY/8DzbopVQuvDnAH7HP+pCzsCybObWbG3Ug6fJjEwU=
X-Received: by 2002:a67:fd04:0:b0:447:6f5a:5123 with SMTP id
 f4-20020a67fd04000000b004476f5a5123mr2415300vsr.30.1692352707172; Fri, 18 Aug
 2023 02:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com>
 <20230721101349.12387-4-victorshihgli@gmail.com> <CAPDyKFqFbp-rbRBZ7eYtR1HXJfYuhiCLbFM8bSv1a-9gtZd6vg@mail.gmail.com>
In-Reply-To: <CAPDyKFqFbp-rbRBZ7eYtR1HXJfYuhiCLbFM8bSv1a-9gtZd6vg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 18 Aug 2023 17:58:15 +0800
Message-ID: <CAK00qKCNyh6mtNwQLW-kH3WV=PB_eH7=b1YmK-0TCotb2hKK3A@mail.gmail.com>
Subject: Re: [PATCH V9 03/23] mmc: core: Announce successful insertion of an
 SD UHS-II card
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:25=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Authorship?
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> >
> > Update in previous version:
>
> Please, drop the above.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> > To inform the users about SD UHS-II cards, let's extend the print at ca=
rd
> > insertion with a "UHS-II" substring. Within this change, it seems
> > reasonable to convert from using "ultra high speed" into "UHS-I speed",=
 for
> > the UHS-I type, as it should makes it more clear.
> >
> > Note that, the new print for UHS-II cards doesn't include the actual
> > selected speed mode. Instead, this is going to be added from subsequent
> > change.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V7:
> >  - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
> >    mmc_card_uhs2 function.
> >
> > Updates in V4:
> >  - Make mmc_card_uhs2() take struct mmc_host* as in-param.
> >
> > ---
> >
> >  drivers/mmc/core/bus.c  | 4 +++-
> >  drivers/mmc/core/host.h | 7 +++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index cf32cf135781..d9a3b3d38d8b 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
> >         if (mmc_card_hs(card))
> >                 speed_mode =3D "high speed ";
> >         else if (mmc_card_uhs(card))
> > -               speed_mode =3D "ultra high speed ";
> > +               speed_mode =3D "UHS-I speed ";
> > +       else if (mmc_card_uhs2(card->host))
> > +               speed_mode =3D "UHS-II speed ";
> >         else if (mmc_card_ddr52(card))
> >                 speed_mode =3D "high speed DDR ";
> >         else if (mmc_card_hs200(card))
> > diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> > index 48c4952512a5..9f6e5e31dfea 100644
> > --- a/drivers/mmc/core/host.h
> > +++ b/drivers/mmc/core/host.h
> > @@ -89,5 +89,12 @@ static inline bool mmc_card_sd_express(struct mmc_ho=
st *host)
> >                 host->ios.timing =3D=3D MMC_TIMING_SD_EXP_1_2V;
> >  }
> >
> > +static inline bool mmc_card_uhs2(struct mmc_host *host)
> > +{
> > +       return host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +              host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +              host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +              host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD;
> > +}
> >  #endif
> >
>
> Kind regards
> Uffe
