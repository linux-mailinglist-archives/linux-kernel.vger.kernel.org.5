Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A17BB53A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjJFKad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJFKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:30:30 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC492FF;
        Fri,  6 Oct 2023 03:30:28 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7abda795363so832060241.0;
        Fri, 06 Oct 2023 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696588227; x=1697193027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TgLZiI7aDgS25qRr3woiF/RYIv1V3MyNXKdAtoU2Rk=;
        b=RPz/o3KjBAUk6YMCjTxZrmIeT8MA43uBnAXDO5UrSGra6nCJ8zlyMi+znOmf1Mv5FD
         h9mH2C1kL13hThCh/vXGcJkS8IteUidYBwbATgpQDdbijgaaLuMjl8P5xbg1mUHeFu0M
         zIdsQuGnz4zi7AegHAH8ZifllTwp5Zbqxv1rpwp+ii32C3bkcMwQ4paFTt8CS9e9B53r
         7kCfX8lcnlqcp6c8F0/6DaGaFsev7tmIeIsd5dfB4SzdEecyPMGWMCtvOKM1Zf7BXZxp
         NLb26CXe/feDZnJV0oRI9KJqTZ2hujHS+dCyAi94I37Zb+oTBdYm94tGCvxbGNDwzRbI
         h46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588227; x=1697193027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TgLZiI7aDgS25qRr3woiF/RYIv1V3MyNXKdAtoU2Rk=;
        b=CUDXNEbly+tA5zNpAe1iKX+Dbm0zTKn+w33tGCbMG3aEQgu2tn2T89bPL9XW6wK32n
         183DXUkUL7yLeJVWLLnPMp6rhyCQgMO9wxCPB6/qF3oG/OdS4fM2GDinrtH2B8swdVkk
         G5gBTWnfyLY6p6/+nVb2xqUcMDscpwlpPmjt+GhgIsCTgDM/KZP+XXGsO8FqpPmKFPdb
         JkLykwfPuMj9bPArP96Uhuph6dcSW9U0z+DPE6ZHiD4P08XRcrjoBVuTGiWM9qMTsy97
         JK//ycTEnZ+hi3qK1eUQsEqIUnGJlGKFZayrUUPJcfq8aY+GWzY9Q8sTm59g1MuUQ/g1
         2k8Q==
X-Gm-Message-State: AOJu0Yw65SHf+p1eKTcuQ33G37lZxPZiHGIlZDuuqRQpADTVaT9yfUws
        6miRoPfke2TT1WDAQhj2bXS+kNR+52JKhWKlMDQ=
X-Google-Smtp-Source: AGHT+IEu+Q/g6jteDs8gJCJhmZzUfGhOsVVatq9qBqMgbaSNMyTg4HtvEUgc54rgt8vdR0x8zU0jWSjEJM2shaNmdVE=
X-Received: by 2002:a1f:e246:0:b0:499:dec9:e1a8 with SMTP id
 z67-20020a1fe246000000b00499dec9e1a8mr6919423vkg.14.1696588227573; Fri, 06
 Oct 2023 03:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-13-victorshihgli@gmail.com> <CAPDyKFpzuds6Ttbhw1cqZwisa+M6167DT3DUihcDqFjYJX95eA@mail.gmail.com>
In-Reply-To: <CAPDyKFpzuds6Ttbhw1cqZwisa+M6167DT3DUihcDqFjYJX95eA@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 6 Oct 2023 18:30:13 +0800
Message-ID: <CAK00qKDtXR2aV_h4KhAaWqjUfn8M2-yMsDHeFmz0ztjaF4wB=g@mail.gmail.com>
Subject: Re: [PATCH V12 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
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

On Tue, Oct 3, 2023 at 5:58=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
> > so no voltage switch required.
>
> Can you please elaborate on this? I don't get anything of the above, sorr=
y.
>
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> > Updates in V5:
> >  - Use sdhci_uhs2_mode() to simplify code in
> >    sdhci_uhs2_start_signal_voltage_switch().
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index fc37a34629c2..92fb69b7e209 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host=
 *host, unsigned char mode, un
> >         }
> >  }
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * MMC callbacks                                                      =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc=
,
> > +                                                 struct mmc_ios *ios)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +
> > +       /*
> > +        * For UHS2, the signal voltage is supplied by vdd2 which is
> > +        * already 1.8v so no voltage switch required.
> > +        */
> > +       if (sdhci_uhs2_mode(host))
> > +               return 0;
>
> This is just wrong. If we are initializing a uhs2 card, we certainly
> should call ->start_signal_voltage_switch() callback at all. This is
> for UHS-I cards, right?
>

Hi, Ulf

UHS-II does not need single_voltage.
I will modify the commit message in the next version.
sdhci_uhs2_start_signal_voltage_switch() is under
mmc_host_ops.start_signal_voltage_switch host ops,
therefore, we need to keep the UHS-I path here.

Thanks, Victor Shih

> > +
> > +       return sdhci_start_signal_voltage_switch(mmc, ios);
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > @@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host =
*host, unsigned char mode, un
> >
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> > +       host->mmc_host_ops.start_signal_voltage_switch =3D
> > +               sdhci_uhs2_start_signal_voltage_switch;
> > +
> >         return 0;
> >  }
> >
>
> Kind regards
> Uffe
