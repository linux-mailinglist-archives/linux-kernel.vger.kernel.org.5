Return-Path: <linux-kernel+bounces-16240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F36B823B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D08B24F39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0412E65;
	Thu,  4 Jan 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rwLBuq1t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233CD297
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 26C683F04D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 04:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704341433;
	bh=r0hcB3RaDLd8lTvJ9no/dztI+HIZc74x3uNUcPsxxEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rwLBuq1tG6LZmsmOzdh/rycbMhCrFy8n2p9Mv7drC0PTpCKYqF2XiUqipAGZ+ic+8
	 3F4wVs5i1+CRlikUq/CsqScGyMomwyUoHhBDIniwiA+1Ykqo0Rz56X7bJazLuAaA3b
	 auBYhYM2lgCIxViKj/zAav1sKPJwEpgazwmaAhbYGpud5WanCeksfVoEdwV7P2cCrv
	 EVtzd0Fb3Dz4zHEcKbltyWdbPvTxEFICpdbWSPdNmGmJsu+dBpCqRcqjlAxWVqX/vz
	 Ljra87jFyMQwfnVH8F1d6FtCzWur0d4a4H1FODpoqmdX/4/peo7Q7x8BekL0Bdbvgm
	 iinoRp/YyaU9w==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9b266183eso93191b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 20:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704341432; x=1704946232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0hcB3RaDLd8lTvJ9no/dztI+HIZc74x3uNUcPsxxEg=;
        b=P/5f/JoGF4vnHqbdzvdNl1l6lfD2UsDdc/WOXsEYddhoOdBvMVswl+M+5dTNvl0/fJ
         iTAH3lN/7oxV+zzI97yqsSHLbl+2wr77WLY/crzWMlthQH3P0XBcc/VXx9H8eKlEfBU6
         KdVgRVGgnVO8ekdR+0djDpG6XeMV80tIQF9IRLsiEErChpOeCH6YhlAUgUTqpXhCMeGq
         /x3q+IOyFX0oVthN/1HyivnrbCrTuQev/vcVM6jmpwUclA+BRkDWEHikIl1cOoZd/xdh
         jpeqvuRWXgjiO4v73WfmYOk+U6HyJqDdnz1vX60icXeWUOL+gkGiTHoa7V+7F0HhxIG8
         lQ0Q==
X-Gm-Message-State: AOJu0YxUBUH3zYe7OGR4DqlOFayLSefcP6VlutYR54HeSMR6twsySHKv
	OINhfhaWG/OAJYita8/zQoNv6kRIOyJD1rfPQjEWEvRn+s01tFTygypCAP2RyCS76XafH5Qo3U/
	W1/NmTxy7ZmWI3R9ku49JSVwhFJ1pp/MmZ4x/fVmzief4P9zkvtcG2Fji3UWMV+Pc
X-Received: by 2002:aa7:8512:0:b0:6d9:beca:3a40 with SMTP id v18-20020aa78512000000b006d9beca3a40mr47645pfn.56.1704341431767;
        Wed, 03 Jan 2024 20:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNEuakNecLb5I0jdMO/2YQk/qQnJr9SDhVt28JjX3J/rSl2zWkKm3UZMldAMtDVv3swCv/K0x5oVbeQ5gy6cQ=
X-Received: by 2002:aa7:8512:0:b0:6d9:beca:3a40 with SMTP id
 v18-20020aa78512000000b006d9beca3a40mr47642pfn.56.1704341431443; Wed, 03 Jan
 2024 20:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221032147.434647-1-kai.heng.feng@canonical.com> <CAPDyKFo6SGV=Zsqmq=dO09tGNsJAURXuvXfbzLwf-4J3KUsC+w@mail.gmail.com>
In-Reply-To: <CAPDyKFo6SGV=Zsqmq=dO09tGNsJAURXuvXfbzLwf-4J3KUsC+w@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 4 Jan 2024 12:10:19 +0800
Message-ID: <CAAd53p7k2oBkzKv_RrNUm9rhJB5htV79sUjbdRxWHHJ46ps6HQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:53=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Thu, 21 Dec 2023 at 04:23, Kai-Heng Feng <kai.heng.feng@canonical.com>=
 wrote:
> >
> > Spamming `lspci -vv` can still observe the replay timer timeout error
> > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> > replay timer timeout of AER"), albeit with a lower reproduce rate.
> >
> > Such AER interrupt can still prevent the system from suspending, so let
> > root port mask and unmask replay timer timeout during suspend and
> > resume, respectively.
> >
> > Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Cc: Ben Chuang <benchuanggli@gmail.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Change subject to reflect it works on GL9750 & GL9755
> >  - Fix when aer_cap is missing
> >
> >  drivers/mmc/host/sdhci-pci-core.c |  2 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  | 55 +++++++++++++++++++++++++++++--
> >  drivers/mmc/host/sdhci-pci.h      |  1 +
> >  3 files changed, 55 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci=
-pci-core.c
> > index 025b31aa712c..59ae4da72974 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -68,7 +68,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chi=
p *chip)
> >         return 0;
> >  }
> >
> > -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> >  {
> >         int i, ret;
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 77911a57b12c..54943e9df835 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -1429,6 +1429,55 @@ static int sdhci_pci_gli_resume(struct sdhci_pci=
_chip *chip)
> >         return sdhci_pci_resume_host(chip);
> >  }
> >
> > +#ifdef CONFIG_PCIEAER
> > +static void mask_replay_timer_timeout(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev *parent =3D pci_upstream_bridge(pdev);
> > +       u32 val;
> > +
> > +       if (!parent || !parent->aer_cap)
>
> Wouldn't it be more correct to use pci_aer_available(), rather than
> just checking the aer_cap?

pci_aer_available() is more of a global check, so checking aer_cap is
still required for the device.

>
> If pci_aer_available() can be used, we wouldn't even need the stubs as
> the is already stubs for pci_aer_available().

A helper that checks both aer_cap and  pci_aer_available() can be
added for such purpose, but there aren't many users of that.

Kai-Heng

>
> > +               return;
> > +
> > +       pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MAS=
K, &val);
> > +       val |=3D PCI_ERR_COR_REP_TIMER;
> > +       pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MA=
SK, val);
> > +}
> > +
> > +static void unmask_replay_timer_timeout(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev *parent =3D pci_upstream_bridge(pdev);
> > +       u32 val;
> > +
> > +       if (!parent || !parent->aer_cap)
> > +               return;
> > +
> > +       pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK,=
 &val);
> > +       val &=3D ~PCI_ERR_COR_REP_TIMER;
> > +       pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK=
, val);
> > +}
> > +#else
> > +static inline void mask_replay_timer_timeout(struct pci_dev *pdev) { }
> > +static inline void unmask_replay_timer_timeout(struct pci_dev *pdev) {=
  }
> > +#endif
> > +
> > +static int sdhci_pci_gl975x_suspend(struct sdhci_pci_chip *chip)
> > +{
> > +       mask_replay_timer_timeout(chip->pdev);
> > +
> > +       return sdhci_pci_suspend_host(chip);
> > +}
> > +
> > +static int sdhci_pci_gl975x_resume(struct sdhci_pci_chip *chip)
> > +{
> > +       int ret;
> > +
> > +       ret =3D sdhci_pci_gli_resume(chip);
> > +
> > +       unmask_replay_timer_timeout(chip->pdev);
> > +
> > +       return ret;
> > +}
> > +
> >  static int gl9763e_resume(struct sdhci_pci_chip *chip)
> >  {
> >         struct sdhci_pci_slot *slot =3D chip->slots[0];
> > @@ -1547,7 +1596,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 =3D {
> >         .probe_slot     =3D gli_probe_slot_gl9755,
> >         .ops            =3D &sdhci_gl9755_ops,
> >  #ifdef CONFIG_PM_SLEEP
> > -       .resume         =3D sdhci_pci_gli_resume,
> > +       .suspend        =3D sdhci_pci_gl975x_suspend,
> > +       .resume         =3D sdhci_pci_gl975x_resume,
> >  #endif
> >  };
> >
> > @@ -1570,7 +1620,8 @@ const struct sdhci_pci_fixes sdhci_gl9750 =3D {
> >         .probe_slot     =3D gli_probe_slot_gl9750,
> >         .ops            =3D &sdhci_gl9750_ops,
> >  #ifdef CONFIG_PM_SLEEP
> > -       .resume         =3D sdhci_pci_gli_resume,
> > +       .suspend        =3D sdhci_pci_gl975x_suspend,
> > +       .resume         =3D sdhci_pci_gl975x_resume,
> >  #endif
> >  };
> >
> > diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.=
h
> > index 153704f812ed..19253dce687d 100644
> > --- a/drivers/mmc/host/sdhci-pci.h
> > +++ b/drivers/mmc/host/sdhci-pci.h
> > @@ -190,6 +190,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci=
_slot *slot)
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
> >  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
> >  #endif
> >  int sdhci_pci_enable_dma(struct sdhci_host *host);
>
> Kind regards
> Uffe

