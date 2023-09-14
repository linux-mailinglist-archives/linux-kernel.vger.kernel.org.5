Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDA7A04D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbjINNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbjINNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:03:36 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF21FEA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:03:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7e904674aeso955829276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696610; x=1695301410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ob8SQM+bmq/PuBNTw6TcaVLNQ1zeeWO4ZtVc5W6iJRs=;
        b=IGxQwgySBIzXEcyRinHXjbYkau/6kt7JZpKswkhrbqGd+yJyjwTF4sQPyOKPAmaAdZ
         9uG/EB9a+UhcsYkWtc7MuF6lvGfLTaOKpF1zjw0y7vnd4cRrmdmShZpXSu1JEEvUn/Px
         hLUPou0WleMwNJIJkPb7YG2RJsSXa+p4OWcuKQHTBBTuYPvLUmFH9ndkXcZLFMH528Nj
         Gu5TazHtGOltrxgPa5DuZW8fCbINMFIf1CNd+ch/LXw5/bUy6oFkO9ickYXQfq+ID5xW
         K5aM/D75MeGWwo6HC2/KTWLStzbndPIpFYG8luJQXfq6A/XRAR0/bx/QxJ+dhuirpawc
         /uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696610; x=1695301410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ob8SQM+bmq/PuBNTw6TcaVLNQ1zeeWO4ZtVc5W6iJRs=;
        b=k0eU2DLFFzPmOBYLUdvW4k2KEo4YToV7IkkmFS5PNT8ei0uK+IhoQjvkL/TQI6OkFR
         rvHFYmlemNjGQfZh4upz/phZqr9+qYV/tq7yyxvdWNtYp4LDgu9hK5/AxaifXmMG3BCa
         w0nst19mPLk+dkYecb3bd4w5QLqdfdw2N29ji0rtbNF4kI/srwUUHkMqukamWsEFGnYF
         W8sfu6EQwlECsrUvrbhCPO//tE0/iUwOLU4RFf5uvHCcgjJS9CswGGfCbDZxJi/kAiZd
         Sx1O/njrnzmWm5elBSI5n/TKB3r+ojGQobG6aF2fhlp/2Nhq7y3d8goMHKy6m+X54D10
         dAcQ==
X-Gm-Message-State: AOJu0YxtB7Wr1OmQYemLc3HTwU9Pn/LOsl9uZgrZ8cgkXbBlPNI9yBk9
        MlyhW3tcmw/9FdrvEAjxJuqXW3Omb1KzRh+G3VL9f47JkONneIHHUxs=
X-Google-Smtp-Source: AGHT+IH6YkWJEN52KxYqwksy7XeIE77ym5oKBBQTAMc1y9A7PSsTbC4UtM+Yk0dnZEGUypdjvCxvkZRxxsrAwVPctng=
X-Received: by 2002:a25:1607:0:b0:d4c:6b49:fed7 with SMTP id
 7-20020a251607000000b00d4c6b49fed7mr4697103ybw.45.1694696609708; Thu, 14 Sep
 2023 06:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
In-Reply-To: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:53 +0200
Message-ID: <CAPDyKFoAbOjjS9H495mBNMiH6dV8eRsuoio6to5G6hz-sPY8xw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com,
        ben.chuang@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 18:01, Sven van Ashbrook <svenva@chromium.org> wrote:
>
> To improve the r/w performance of GL9763E, the current driver inhibits LPM
> negotiation while the device is active.
>
> This prevents a large number of SoCs from suspending, notably x86 systems
> which commonly use S0ix as the suspend mechanism - for example, Intel
> Alder Lake and Raptor Lake processors.
>
> Failure description:
> 1. Userspace initiates s2idle suspend (e.g. via writing to
>    /sys/power/state)
> 2. This switches the runtime_pm device state to active, which disables
>    LPM negotiation, then calls the "regular" suspend callback
> 3. With LPM negotiation disabled, the bus cannot enter low-power state
> 4. On a large number of SoCs, if the bus not in a low-power state, S0ix
>    cannot be entered, which in turn prevents the SoC from entering
>    suspend.
>
> Fix by re-enabling LPM negotiation in the device's suspend callback.
>
> Suggested-by: Stanislaw Kardach <skardach@google.com>
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - applied maintainer feedback from https://lore.kernel.org/lkml/CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com/T/#m7cea7b6b987d1ab1ca95feedf2c6f9da5783da5c
>
> Changes in v2:
> - improved symmetry and error path in s2idle suspend callback (internal review)
>
>  drivers/mmc/host/sdhci-pci-gli.c | 104 ++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 1792665c9494a..a4ccb6c3e27a6 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>         return value;
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot = chip->slots[0];
> -
> -       pci_free_irq_vectors(slot->chip->pdev);
> -       gli_pcie_enable_msi(slot);
> -
> -       return sdhci_pci_resume_host(chip);
> -}
> -
> -static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot = chip->slots[0];
> -       int ret;
> -
> -       ret = sdhci_pci_gli_resume(chip);
> -       if (ret)
> -               return ret;
> -
> -       return cqhci_resume(slot->host->mmc);
> -}
> -
> -static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
> -{
> -       struct sdhci_pci_slot *slot = chip->slots[0];
> -       int ret;
> -
> -       ret = cqhci_suspend(slot->host->mmc);
> -       if (ret)
> -               return ret;
> -
> -       return sdhci_suspend_host(slot->host);
> -}
> -#endif
> -
>  static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                           struct mmc_ios *ios)
>  {
> @@ -1029,6 +993,70 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>  }
>  #endif
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +
> +       pci_free_irq_vectors(slot->chip->pdev);
> +       gli_pcie_enable_msi(slot);
> +
> +       return sdhci_pci_resume_host(chip);
> +}
> +
> +static int gl9763e_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       int ret;
> +
> +       ret = sdhci_pci_gli_resume(chip);
> +       if (ret)
> +               return ret;
> +
> +       ret = cqhci_resume(slot->host->mmc);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Disable LPM negotiation to bring device back in sync
> +        * with its runtime_pm state.
> +        */
> +       gl9763e_set_low_power_negotiation(slot, false);
> +
> +       return 0;
> +}
> +
> +static int gl9763e_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       int ret;
> +
> +       /*
> +        * Certain SoCs can suspend only with the bus in low-
> +        * power state, notably x86 SoCs when using S0ix.
> +        * Re-enable LPM negotiation to allow entering L1 state
> +        * and entering system suspend.
> +        */
> +       gl9763e_set_low_power_negotiation(slot, true);
> +
> +       ret = cqhci_suspend(slot->host->mmc);
> +       if (ret)
> +               goto err_suspend;
> +
> +       ret = sdhci_suspend_host(slot->host);
> +       if (ret)
> +               goto err_suspend_host;
> +
> +       return 0;
> +
> +err_suspend_host:
> +       cqhci_resume(slot->host->mmc);
> +err_suspend:
> +       gl9763e_set_low_power_negotiation(slot, false);
> +       return ret;
> +}
> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -1113,8 +1141,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>         .probe_slot     = gli_probe_slot_gl9763e,
>         .ops            = &sdhci_gl9763e_ops,
>  #ifdef CONFIG_PM_SLEEP
> -       .resume         = sdhci_cqhci_gli_resume,
> -       .suspend        = sdhci_cqhci_gli_suspend,
> +       .resume         = gl9763e_resume,
> +       .suspend        = gl9763e_suspend,
>  #endif
>  #ifdef CONFIG_PM
>         .runtime_suspend = gl9763e_runtime_suspend,
> --
> 2.42.0.283.g2d96d420d3-goog
>
