Return-Path: <linux-kernel+bounces-15413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51687822BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF69AB21AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE9518C3F;
	Wed,  3 Jan 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCDg9s1h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952718C2E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e7c1012a42so84687877b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704279194; x=1704883994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m9p1RoQ2GuousKXYelQZcSQ3NaizCREhdBpOhRo7feA=;
        b=GCDg9s1hIIN0SfrXq+ieugM7UFhPXsEyHm95qJVTcKKdjJ3aJ8cixy1uSIWL1/8IHE
         zs9rdmM1QilBdZAsOPhgQMWQhGLWMF1XWuZtMPlcU1TY9C9nAXx2AHTDufJOmXNSNbWO
         UenBAcZ8Pne4VehgNeF0coLGiG5meHM9iTAyCfjEFCICR1m3nGajtTP+xWT47oclFAqs
         2MGn4+pH2DksTcE9qwhn85iVf6ZTfoXwurdFw48mXHyeLaTvcnvc0MhvGKtAoUZrQlML
         5NP8IjTTZOVuwabKJCvWVx7avmKdUzoeua8ZMehzn32hh3tLhWAKIk0OMf4y6NJ3Zkj8
         7T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279194; x=1704883994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9p1RoQ2GuousKXYelQZcSQ3NaizCREhdBpOhRo7feA=;
        b=Zj/XPvVPUsCT4y7YhB6aj8tgjhVNmQdTUSfwu8FKI88yjGEzZ/Saqj3A+Uh5RXZVsj
         9ynyFbNPpWgsTqHqeSWkMPlOWVijRiBPJYGl3ybcUiEfAO7vc71GnRVGefNvY91hiUkh
         ny/rGLW1nUmS8ifY3w8PpQqBy15vgWcfQx7JIBqRyHr56/yksl880BQvbhjTDHhsetZR
         9G+83OFjKgREf1AKZHMNfC6V8h3bjmBC22vP80TXclKKCvo/P2RX+B7bpn0cPRNisZX7
         pQKw263E2E7JUpvJKZz9OKya2AVssCZBI0Q5H7yBbeC8keppdNxdAX6TkZvRSDLOrhvr
         ZPCw==
X-Gm-Message-State: AOJu0YyghC2teKv5AsSxPa90jPf36JBd7DCfiNfNhm38pFJBcEasYHjX
	4QYHwoFmyBud3FTMzsU2wPpSTS5jaM/33OOfvaIDGBiqY1mOEA==
X-Google-Smtp-Source: AGHT+IFX8PwLJ/Mp4X59qcsHRT4TXjjQz+F9r1yQR3sV+ge6DyXZ8XPFMZnyX5InkRHegr0XXVCLhkjok1+pyJZX+vo=
X-Received: by 2002:a81:98d4:0:b0:5ee:f221:3266 with SMTP id
 p203-20020a8198d4000000b005eef2213266mr4992867ywg.70.1704279194162; Wed, 03
 Jan 2024 02:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221032147.434647-1-kai.heng.feng@canonical.com>
In-Reply-To: <20231221032147.434647-1-kai.heng.feng@canonical.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 11:52:37 +0100
Message-ID: <CAPDyKFo6SGV=Zsqmq=dO09tGNsJAURXuvXfbzLwf-4J3KUsC+w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 04:23, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Spamming `lspci -vv` can still observe the replay timer timeout error
> even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> replay timer timeout of AER"), albeit with a lower reproduce rate.
>
> Such AER interrupt can still prevent the system from suspending, so let
> root port mask and unmask replay timer timeout during suspend and
> resume, respectively.
>
> Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
> Cc: Ben Chuang <benchuanggli@gmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Change subject to reflect it works on GL9750 & GL9755
>  - Fix when aer_cap is missing
>
>  drivers/mmc/host/sdhci-pci-core.c |  2 +-
>  drivers/mmc/host/sdhci-pci-gli.c  | 55 +++++++++++++++++++++++++++++--
>  drivers/mmc/host/sdhci-pci.h      |  1 +
>  3 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 025b31aa712c..59ae4da72974 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -68,7 +68,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
>         return 0;
>  }
>
> -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>  {
>         int i, ret;
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 77911a57b12c..54943e9df835 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1429,6 +1429,55 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>         return sdhci_pci_resume_host(chip);
>  }
>
> +#ifdef CONFIG_PCIEAER
> +static void mask_replay_timer_timeout(struct pci_dev *pdev)
> +{
> +       struct pci_dev *parent = pci_upstream_bridge(pdev);
> +       u32 val;
> +
> +       if (!parent || !parent->aer_cap)

Wouldn't it be more correct to use pci_aer_available(), rather than
just checking the aer_cap?

If pci_aer_available() can be used, we wouldn't even need the stubs as
the is already stubs for pci_aer_available().

> +               return;
> +
> +       pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
> +       val |= PCI_ERR_COR_REP_TIMER;
> +       pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
> +}
> +
> +static void unmask_replay_timer_timeout(struct pci_dev *pdev)
> +{
> +       struct pci_dev *parent = pci_upstream_bridge(pdev);
> +       u32 val;
> +
> +       if (!parent || !parent->aer_cap)
> +               return;
> +
> +       pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
> +       val &= ~PCI_ERR_COR_REP_TIMER;
> +       pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
> +}
> +#else
> +static inline void mask_replay_timer_timeout(struct pci_dev *pdev) { }
> +static inline void unmask_replay_timer_timeout(struct pci_dev *pdev) {  }
> +#endif
> +
> +static int sdhci_pci_gl975x_suspend(struct sdhci_pci_chip *chip)
> +{
> +       mask_replay_timer_timeout(chip->pdev);
> +
> +       return sdhci_pci_suspend_host(chip);
> +}
> +
> +static int sdhci_pci_gl975x_resume(struct sdhci_pci_chip *chip)
> +{
> +       int ret;
> +
> +       ret = sdhci_pci_gli_resume(chip);
> +
> +       unmask_replay_timer_timeout(chip->pdev);
> +
> +       return ret;
> +}
> +
>  static int gl9763e_resume(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot = chip->slots[0];
> @@ -1547,7 +1596,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
>         .probe_slot     = gli_probe_slot_gl9755,
>         .ops            = &sdhci_gl9755_ops,
>  #ifdef CONFIG_PM_SLEEP
> -       .resume         = sdhci_pci_gli_resume,
> +       .suspend        = sdhci_pci_gl975x_suspend,
> +       .resume         = sdhci_pci_gl975x_resume,
>  #endif
>  };
>
> @@ -1570,7 +1620,8 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
>         .probe_slot     = gli_probe_slot_gl9750,
>         .ops            = &sdhci_gl9750_ops,
>  #ifdef CONFIG_PM_SLEEP
> -       .resume         = sdhci_pci_gli_resume,
> +       .suspend        = sdhci_pci_gl975x_suspend,
> +       .resume         = sdhci_pci_gl975x_resume,
>  #endif
>  };
>
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 153704f812ed..19253dce687d 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -190,6 +190,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
>  #endif
>  int sdhci_pci_enable_dma(struct sdhci_host *host);

Kind regards
Uffe

