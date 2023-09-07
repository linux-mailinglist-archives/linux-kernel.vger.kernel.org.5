Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55669796E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245027AbjIGBEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245013AbjIGBEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:04:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC219BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 18:04:37 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB9293F12F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694048674;
        bh=ft5o/B3DP4eFDUaywXFGkm/OnZfQctTMhkbEcktXXfY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GQkZl80p7IZJULJVeE9+m//B/rcRv8+cHMr/ag1YxIcg+aElkd+zan/f7oPmkEnwe
         WEccS5nS7a3qyW5PtEK1hsIj6Ss4IOE95HIXUXUQEwArevOJdJTm+LNxbUmx6vmMiM
         5iSItCu17/yiS3//UDJeHwvoaKAZa/aFNa1thF2Cu5vG8siK44wIpjsSqZb3lAe3jx
         YjEblqXWVEaHo0kSJv/AfQsDvX1Qb8jlXLNAL1co1We7oQI+RKN8rj4nSgm7i5Xqgv
         8qoTh9ESTfBhmL17gNlPyPSv8mRuleUu/JV9vUzoPHQQ3wLy55Th1W5mneT5vLs9SJ
         ReFu2HCpdT+Ug==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68a3de043b7so600341b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 18:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694048673; x=1694653473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft5o/B3DP4eFDUaywXFGkm/OnZfQctTMhkbEcktXXfY=;
        b=X4KdwvsymIHdXrs4d5VB1KjaglPE7UHFWRQyEPq2W2a6N4dWB4JmwL/ut/aJCcPyKv
         xrIy3ZEYDha2wNo56jGClxB0EpuxcmEAxYe3SR/qcRsuLiE8v+wZaAhJoPu6lEksZTjf
         FSlL+so6AUKIX2P8S5Eki5Mbbji+JlSsqTb6JW4nojEydB6W3P0IPcuy4fnUyZwuEwqV
         AuidxPUbzZTqk1OJW76xZ26+4wDBRxUaaoWSAlCcP3NKU301V892ao0fM7KzWGUR+LU9
         7TcyY0HVnRX6fStaJJpaiY2YDr8iKss8JOliRJaIAbx9llf6UOld/cHTtNaH6uBSf3LB
         1Zaw==
X-Gm-Message-State: AOJu0YxoYKu0tyw7zdV0sWcVgt/VI2kRAVZRUXmrMPmGEqM43rrwiXCo
        +uMdAs49grskMmN8rwkgytqKb9mARaVdJSJwJxTwExXg7kkJOF+Uty61Ar/3IwAT4/iPGTzkdFj
        dL9GSh6zOfKkWcRxIxscQmY3qoMz7DMTYBpkZX8SsQDXzgN/gP5BnmGradg==
X-Received: by 2002:a05:6a00:1d1f:b0:68e:3c2b:20b9 with SMTP id a31-20020a056a001d1f00b0068e3c2b20b9mr708730pfx.31.1694048673092;
        Wed, 06 Sep 2023 18:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCgxuHroCYv49GX4roxYaNeyWiZr6YuzQ/rSVig7pwb/kb9IRoyICScWKEzxySAQ4JL8kUYTNeAaJdNRxBX94=
X-Received: by 2002:a05:6a00:1d1f:b0:68e:3c2b:20b9 with SMTP id
 a31-20020a056a001d1f00b0068e3c2b20b9mr708717pfx.31.1694048672760; Wed, 06 Sep
 2023 18:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com>
In-Reply-To: <2ce258f371234b1f8a1a470d5488d00e@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 7 Sep 2023 09:04:19 +0800
Message-ID: <CAAd53p4LVL3uuNDCHPxteqM+jYD8E4atVyQvkt-HRhGKBVMoFg@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix an error access Page fault
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricky,

On Wed, Sep 6, 2023 at 4:03=E2=80=AFPM Ricky WU <ricky_wu@realtek.com> wrot=
e:
>
> an error occurs on insert SD7.0 card.
> The pci slot of rtsx_pci will Link Down when the SD7.0 card inserted,
> but the rtsx_pci not exit from runtime_idle at that time,
> then do the power_saving function to access the wrong resource

Is it possible to attach full dmesg? Maybe the issue is coming from PCI sid=
e?

Kai-Heng

>
> Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management flow")
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 14 ++++++++------
>  drivers/mmc/host/rtsx_pci_sdmmc.c  |  1 +
>  include/linux/rtsx_pci.h           |  1 +
>  3 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader=
/rtsx_pcr.c
> index a3f4b52bb159..536a3681fd5e 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1526,6 +1526,7 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>         pcr->host_sg_tbl_addr =3D pcr->rtsx_resv_buf_addr + HOST_CMDS_BUF=
_LEN;
>         pcr->card_inserted =3D 0;
>         pcr->card_removed =3D 0;
> +       pcr->is_sd_express =3D false;
>         INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
>
>         pcr->msi_en =3D msi_en;
> @@ -1735,12 +1736,13 @@ static int rtsx_pci_runtime_idle(struct device *d=
evice)
>
>         pcr->state =3D PDEV_STAT_IDLE;
>
> -       if (pcr->ops->disable_auto_blink)
> -               pcr->ops->disable_auto_blink(pcr);
> -       if (pcr->ops->turn_off_led)
> -               pcr->ops->turn_off_led(pcr);
> -
> -       rtsx_pm_power_saving(pcr);
> +       if (!pcr->is_sd_express) {
> +               if (pcr->ops->disable_auto_blink)
> +                       pcr->ops->disable_auto_blink(pcr);
> +               if (pcr->ops->turn_off_led)
> +                       pcr->ops->turn_off_led(pcr);
> +               rtsx_pm_power_saving(pcr);
> +       }
>
>         mutex_unlock(&pcr->pcr_mutex);
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 87d78432a1e0..80b2f2a31fdc 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1393,6 +1393,7 @@ static int sdmmc_init_sd_express(struct mmc_host *m=
mc, struct mmc_ios *ios)
>                 RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
>                 | RTS5261_DRIVER_ENABLE_FW,
>                 RTS5261_MCU_CLOCK_SEL_16M | RTS5261_DRIVER_ENABLE_FW);
> +       pcr->is_sd_express =3D true;
>         host->eject =3D true;
>         return 0;
>  }
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 534038d962e4..295e92224fd0 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -1262,6 +1262,7 @@ struct rtsx_pcr {
>         u8                      ocp_stat;
>         u8                      ocp_stat2;
>         u8                      rtd3_en;
> +       bool                    is_sd_express;
>  };
>
>  #define PID_524A       0x524A
> --
> 2.25.1
>
