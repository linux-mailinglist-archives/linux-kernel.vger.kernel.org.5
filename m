Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E167EF0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjKQKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:49:57 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A652C2;
        Fri, 17 Nov 2023 02:49:51 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7be55675503so724576241.1;
        Fri, 17 Nov 2023 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218190; x=1700822990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtugVttdKITBqqbOP9WWTC41X2egJw0BMcAKX1VCzrM=;
        b=LZnWEoRMNfnmOZIfYcZVRGhcDLmAXgme3Y+lF8/jpa9jsK0oiHBcizR7iSFPqCBK6V
         xTmKpt/AgkYcrZLdp5nay+Ziyegfi+rFx4nUwV2ctdpsC000pLtuNLRc9tTecUhqDJ4x
         H0PteGsGt0ORrcnTsP2ego+4K4IYmwr3215GMQXlqsgdrNsKfErDaPOOxynUypmYrw4Z
         lTSt2bmLgXGQkfsyWyZtXMamVXB8zl3VCOXIVrX5B84GfSeTWHqbC2AY8exSTjhcgNyM
         N1SaOkylKNAuIOatA6ItOAHNp9c4z8lGT/yVI7G54hlJv6eVZQqEMXh+9k1yRPk7UuVE
         lKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218190; x=1700822990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtugVttdKITBqqbOP9WWTC41X2egJw0BMcAKX1VCzrM=;
        b=spDo1kRytSh3g6IUWev0I9/BRkarVFviERGw7dNDel/fHQVw1m6tychrkDcwwUQ2jp
         HxwMCe3/QIEkiIN3UdF7yHeJ2S3vpWZePCE3eG3rP48VVGTvex/TJCpj9rx3ZhOhpILz
         OddLL4zAHR/54ZZQaep0Hs1eT5CUOez4Ki2MDpu6hEnz31H/YNbBrJ2ErQsh6SKe1FdJ
         9Juo5MZReBxT77jZyrAtEsxO4xgpqlzwNCwcr8qcZWn4uv8qvlYUl965NMi2sdccek0M
         +mB/+2zVs0QMcTOrJUvrSqSOe9kgk+LfAqGyKM3xFl8XbQxXeJAhf29rwRvfeWONh4Tp
         KNkA==
X-Gm-Message-State: AOJu0YxO4inCSi9tO7hDqBizKJ+PugPy7h8fNnNNvb13YRsIQKHLjYE7
        qTpbxvcDyo7FQQkCQM9s5quWCzon4BprZhke0gY=
X-Google-Smtp-Source: AGHT+IGgs2itO1WI0NYgLqOYV7DNORuiB6aQwCp8ILVvBxTG6pfXTlb1f9OTNKTzaDKTGZObiQ42udXPZPRt5WregvY=
X-Received: by 2002:a05:6102:20d1:b0:462:887c:1698 with SMTP id
 i17-20020a05610220d100b00462887c1698mr144708vsr.3.1700218190079; Fri, 17 Nov
 2023 02:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-11-victorshihgli@gmail.com> <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
 <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com> <CAPDyKFqidGZ242P-9xnxokSCeGxk8uziqR=AteWt=iQFz5fA9g@mail.gmail.com>
 <81bf38cd-b6a4-4a6f-a51d-bc916e3b8f96@intel.com> <CAPDyKFoc0phsXuX5W0PqFu2En57Lc9D-+MTGxAYtJhPpHcVZ2g@mail.gmail.com>
 <d76a9fff-5536-4e3e-b1c3-234de427d031@intel.com> <CAPDyKFqsu6-9U7qQRTB7oDubj5WAp+UQVzLitLytUdamDZQW6w@mail.gmail.com>
In-Reply-To: <CAPDyKFqsu6-9U7qQRTB7oDubj5WAp+UQVzLitLytUdamDZQW6w@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:49:37 +0800
Message-ID: <CAK00qKB6KjNc0vFFTSX4Sx5FcA3OWeMNyLTRCLCdSNt4gRmgbg@mail.gmail.com>
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Tue, Oct 10, 2023 at 7:08=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 10 Oct 2023 at 12:29, Adrian Hunter <adrian.hunter@intel.com> wro=
te:
> >
> > On 4/10/23 11:35, Ulf Hansson wrote:
> > > On Tue, 3 Oct 2023 at 17:03, Adrian Hunter <adrian.hunter@intel.com> =
wrote:
> > >>
> > >> On 3/10/23 15:22, Ulf Hansson wrote:
> > >>> On Tue, 3 Oct 2023 at 13:37, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> > >>>>
> > >>>> On 3/10/23 13:30, Ulf Hansson wrote:
> > >>>>> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.c=
om> wrote:
> > >>>>>>
> > >>>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >>>>>>
> > >>>>>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> > >>>>>>
> > >>>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >>>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > >>>>>> ---
> > >>>>>>
> > >>>>>> Updates in V8:
> > >>>>>>  - Adjust the position of matching brackets.
> > >>>>>>
> > >>>>>> Updates in V6:
> > >>>>>>  - Remove unnecessary functions and simplify code.
> > >>>>>>
> > >>>>>> ---
> > >>>>>>
> > >>>>>>  drivers/mmc/host/sdhci-uhs2.c | 45 ++++++++++++++++++++++++++++=
+++++++
> > >>>>>>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
> > >>>>>>  2 files changed, 47 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sd=
hci-uhs2.c
> > >>>>>> index e339821d3504..dfc80a7f1bad 100644
> > >>>>>> --- a/drivers/mmc/host/sdhci-uhs2.c
> > >>>>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> > >>>>>> @@ -10,7 +10,9 @@
> > >>>>>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > >>>>>>   */
> > >>>>>>
> > >>>>>> +#include <linux/delay.h>
> > >>>>>>  #include <linux/module.h>
> > >>>>>> +#include <linux/iopoll.h>
> > >>>>>>
> > >>>>>>  #include "sdhci.h"
> > >>>>>>  #include "sdhci-uhs2.h"
> > >>>>>> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *=
host)
> > >>>>>>  }
> > >>>>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> > >>>>>>
> > >>>>>> +/**************************************************************=
***************\
> > >>>>>> + *                                                             =
              *
> > >>>>>> + * Low level functions                                         =
              *
> > >>>>>> + *                                                             =
              *
> > >>>>>> +\**************************************************************=
***************/
> > >>>>>> +
> > >>>>>> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> > >>>>>> +{
> > >>>>>> +       return host->mmc->flags & MMC_UHS2_SUPPORT;
> > >>>>>
> > >>>>> The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think =
we
> > >>>>> should be using mmc->ios.timings, which already indicates whether=
 we
> > >>>>> are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we add=
ed
> > >>>>> this.
> > >>>>>
> > >>>>> That said, I think we should drop the sdhci_uhs2_mode() function
> > >>>>> altogether and instead use mmc_card_uhs2(), which means we should=
 move
> > >>>>> it to include/linux/mmc/host.h, so it becomes available for host
> > >>>>> drivers.
> > >>>>>
> > >>>>
> > >>>> UHS2 mode starts at UHS2 initialization and ends either when UHS2
> > >>>> initialization fails, or the card is removed.
> > >>>>
> > >>>> So it includes re-initialization and reset when the transfer mode
> > >>>> currently transitions through MMC_TIMING_LEGACY.
> > >>>>
> > >>>> So mmc_card_uhs2() won't work correctly for the host callbacks
> > >>>> unless something is done about that.
> > >>>
> > >>> Right, thanks for clarifying!
> > >>>
> > >>> In that case I wonder if we couldn't change the way we update the
> > >>> ->ios.timing for UHS2. It seems silly to have two (similar) ways to
> > >>> indicate that we have moved to UHS2.
> > >>
> > >> Perhaps something like below:
> > >>
> > >> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > >> index aacefdd6bc9e..e39d63d46041 100644
> > >> --- a/drivers/mmc/core/sd_uhs2.c
> > >> +++ b/drivers/mmc/core/sd_uhs2.c
> > >> @@ -70,7 +70,8 @@ static int sd_uhs2_power_off(struct mmc_host *host=
)
> > >>
> > >>         host->ios.vdd =3D 0;
> > >>         host->ios.clock =3D 0;
> > >> -       host->ios.timing =3D MMC_TIMING_LEGACY;
> > >> +       /* Must set UHS2 timing to identify UHS2 mode */
> > >> +       host->ios.timing =3D MMC_TIMING_UHS2_SPEED_A;
> > >>         host->ios.power_mode =3D MMC_POWER_OFF;
> > >>         if (host->flags & MMC_UHS2_SD_TRAN)
> > >>                 host->flags &=3D ~MMC_UHS2_SD_TRAN;
> > >> @@ -1095,7 +1096,8 @@ static void sd_uhs2_detect(struct mmc_host *ho=
st)
> > >>                 mmc_claim_host(host);
> > >>                 mmc_detach_bus(host);
> > >>                 sd_uhs2_power_off(host);
> > >> -               host->flags &=3D ~MMC_UHS2_SUPPORT;
> > >> +               /* Remove UHS2 timing to indicate the end of UHS2 mo=
de */
> > >> +               host->ios.timing =3D MMC_TIMING_LEGACY;
> > >>                 mmc_release_host(host);
> > >>         }
> > >>  }
> > >> @@ -1338,7 +1340,8 @@ static int sd_uhs2_attach(struct mmc_host *hos=
t)
> > >>  err:
> > >>         mmc_detach_bus(host);
> > >>         sd_uhs2_power_off(host);
> > >> -       host->flags &=3D ~MMC_UHS2_SUPPORT;
> > >> +       /* Remove UHS2 timing to indicate the end of UHS2 mode */
> > >> +       host->ios.timing =3D MMC_TIMING_LEGACY;
> > >>         return err;
> > >>  }
> > >
> > > I wouldn't mind changing to the above. But, maybe an even better
> > > option is to use the ->timing variable in the struct sdhci_host, as
> > > it's there already to keep track of the current/previous timing state=
.
> > > Would that work too?
> >
> > The host does not really have enough information.
>
> Okay, let's go with the approach you suggested above/below then!
>

Hi, Ulf and Adrian

I will update this in version 13.

Thanks, Victor Shih

> >
> > >
> > >>
> > >> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-=
uhs2.c
> > >> index 517c497112f4..d1f3318b7d3a 100644
> > >> --- a/drivers/mmc/host/sdhci-uhs2.c
> > >> +++ b/drivers/mmc/host/sdhci-uhs2.c
> > >> @@ -267,10 +267,11 @@ static void __sdhci_uhs2_set_ios(struct mmc_ho=
st *mmc, struct mmc_ios *ios)
> > >>
> > >>         /* UHS2 timing. Note, UHS2 timing is disabled when powering =
off */
> > >>         ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > >> -       if (ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > >> -           ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > >> -           ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > >> -           ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD)
> > >> +       if (ios->power_mode !=3D MMC_POWER_OFF &&
> > >> +           (ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > >> +            ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > >> +            ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > >> +            ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD))
> > >>                 ctrl_2 |=3D SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE=
;
> > >>         else
> > >>                 ctrl_2 &=3D ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENAB=
LE);
> > >>
> > >>
>
> Kind regards
> Uffe
