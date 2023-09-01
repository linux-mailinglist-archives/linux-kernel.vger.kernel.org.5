Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417378F6EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbjIACDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjIACDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:03:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5F9E76
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:03:30 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85EA041D39
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693533809;
        bh=s/wncfXXHpUHQc0CZn2vZUlpcsDJ0e2lohznlvET07o=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Content-Type;
        b=wP48c2qFuIISxaFuASkqItRZxbWVxNi+okPsGG0YA0r9DnBatb7vHii0EoX3bpCyL
         trFOycTAWvtNWVy3CxRprpu9ZRuS7Vbz7Ox/w9ss9T1fjdTRcJgzE4Ln7AS4Nlor4e
         lXOF+AKdqkfkJ0I5G4x7PqxgH0Y5Sx1duTl0l/fLE2+uuAU93kj0+82SdFCeydt9/u
         b4GTrG/NRS2QEZROAdKNQj9KS8U1dJXbYTRUpif+3nwtBSmAHqsTTAYrCkEYd+tV/J
         YdZrYakVtMe24ymBccMqGoc66Ry9VyMqjCJxTYc3c7yFmrIB5CRaKsoCE+xL97Qu5z
         lC1tOxaizqmXw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26f3fce5b0bso1602318a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693533807; x=1694138607;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/wncfXXHpUHQc0CZn2vZUlpcsDJ0e2lohznlvET07o=;
        b=lh0XFeiEwviKkFJdJFpYtK2uyNQY8wM3iy/8d4ycz4ymDLBd4ZK9zJRSrlPlwfBzPN
         4bPYHD+Rnnr4x10zO0XZenAJAU+/gHCsLJczOXZd4wJGuJLRVgVDvy6HmANsVeQj4nyK
         rx6hwBEm2EhSZQ0+jsUc4HU6NeQwYuyXj769/zY0Sv6+1hTnniggc8vHi+DZ1D0sCSz2
         6zZhwS9CRbdQKo+RwxbSFpn9OL7Jf9JgTe3as6OyCSLNZNdR1IW53i0aGGBqcuQxxDt7
         /sMvLRxVJe3QOKiHXBE05Q8X8ZUf+W+t2o6dXUeGu06MK1RzWmfluTW001C9zuzWZcB8
         DMjA==
X-Gm-Message-State: AOJu0YxwskC+E0BuV/Qftql5tjT94rroIhoTmQ2tGlZdxZje8mWvP6Qd
        +YVsFW7juN0TYnZZjbrjPs31T/IX2i8qZx51KHC5JTbSg0x8fEds5rZcG6E73aTX5bM6Nkona9Z
        97C0Lv/M986aV+y53lAvB8U0zZKe4kq1XC3ySkvAd1l/ZzohnSfXRcK0fu8b1D8vj4cLn
X-Received: by 2002:a17:90a:ac10:b0:267:f094:afcf with SMTP id o16-20020a17090aac1000b00267f094afcfmr1122239pjq.12.1693533806941;
        Thu, 31 Aug 2023 19:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvznHAWaVzvjwfUYLukSV+kZuBl2QCvxc8BXda4OsyPohJRtra/+q9pIzh68dY8eOR234BD5P2JpETJFU4AgM=
X-Received: by 2002:a17:90a:ac10:b0:267:f094:afcf with SMTP id
 o16-20020a17090aac1000b00267f094afcfmr1122224pjq.12.1693533806548; Thu, 31
 Aug 2023 19:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230831190828.1171119-1-koba.ko@canonical.com>
In-Reply-To: <20230831190828.1171119-1-koba.ko@canonical.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 1 Sep 2023 10:03:15 +0800
Message-ID: <CAJB-X+W8fyFc342vkh_a2N8pJ3SP4C54NxBNLpSKzBk-Fb4pJw@mail.gmail.com>
Subject: Re: [PATCH] ata: libata: add workaround to flip LPM during suspend/resume
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Nack, due to some errors
1. unused declarations
2. missing judgement for ATA_LFLAG_NO_LPM_RECOVER

On Fri, Sep 1, 2023 at 3:08=E2=80=AFAM Koba Ko <koba.ko@canonical.com> wrot=
e:
>
> Due to TigerLake/Adler Lake AHCI controller's LPM regression,
> can't apply LPM on TigerLake/AdlerLake AHCI controller.
>
> Add a workaround to flip LPM during suspend/resume.
> When suspneding, apply LPM on TigerLake/AdlerLake AHCI.
> Restore it to target_lpm_policy after resuming.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217775
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  drivers/ata/ahci.c      | 29 +++++++++++++++++++++++++++++
>  drivers/ata/libata-eh.c |  8 ++++++++
>  include/linux/libata.h  |  1 +
>  3 files changed, 38 insertions(+)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 02503e903e4a8..5c9196cd2c738 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -95,6 +95,8 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, =
unsigned int *class,
>  #ifdef CONFIG_PM
>  static int ahci_pci_device_runtime_suspend(struct device *dev);
>  static int ahci_pci_device_runtime_resume(struct device *dev);
> +static int ahci_intel_port_suspend(struct ata_port *ap, pm_message_t mes=
g);
> +static int ahci_intel_port_resume(struct ata_port *ap);
>  #ifdef CONFIG_PM_SLEEP
>  static int ahci_pci_device_suspend(struct device *dev);
>  static int ahci_pci_device_resume(struct device *dev);
> @@ -1025,6 +1027,30 @@ static void ahci_p5wdh_workaround(struct ata_host =
*host)
>                 ap->link.flags |=3D ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_=
ATA;
>         }
>  }
> +/*
> + * Intel TGL/ADL workaround, when suspending, put port into LPM,
> + * recover to max power after resuming.
> + */
> +static void ahci_intel_ahci_workaround(struct ata_host *host)
> +{
> +       struct pci_dev *pdev =3D to_pci_dev(host->dev);
> +       int i;
> +       static const struct pci_device_id ids[] =3D {
> +               { PCI_VDEVICE(INTEL, 0xa0d3)}, /* Tiger Lake UP{3,4} AHCI=
 */
> +               { PCI_VDEVICE(INTEL, 0x7ae2)}, /* Alder Lake AHCI*/
> +               {}
> +       };
> +
> +       dev_info(&pdev->dev, "enabling Intel AHCI workaround\n");
> +
> +       if (pci_match_id(ids, pdev)) {
> +               for (i =3D 0; i < host->n_ports; i++) {
> +                       struct ata_port *ap =3D host->ports[i];
> +
> +                       ap->flags |=3D ATA_LFLAG_NO_LPM_RECOVER;
> +               }
> +       }
> +}
>
>  /*
>   * Macbook7,1 firmware forcibly disables MCP89 AHCI and changes PCI ID w=
hen
> @@ -1905,6 +1931,9 @@ static int ahci_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>         /* apply workaround for ASUS P5W DH Deluxe mainboard */
>         ahci_p5wdh_workaround(host);
>
> +       /* apply workaround for Intel AHCI */
> +       ahci_intel_ahci_workaround(host);
> +
>         /* apply gtf filter quirk */
>         ahci_gtf_filter_workaround(host);
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 159ba6ba19ebb..de29e50843f99 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4000,6 +4000,11 @@ static void ata_eh_handle_port_suspend(struct ata_=
port *ap)
>         int rc =3D 0;
>         struct ata_device *dev;
>
> +       ata_for_each_dev(dev, &ap->link, ENABLED) {
> +               ata_eh_set_lpm(&ap->link, ATA_LPM_MED_POWER_WITH_DIPM, &d=
ev);
> +       }
> +
> +
>         /* are we suspending? */
>         spin_lock_irqsave(ap->lock, flags);
>         if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
> @@ -4087,6 +4092,9 @@ static void ata_eh_handle_port_resume(struct ata_po=
rt *ap)
>         if (ap->ops->port_resume)
>                 ap->ops->port_resume(ap);
>
> +       ata_for_each_dev(dev, &ap->link, ENABLED) {
> +               ata_eh_set_lpm(&ap->link, ap->target_lpm_policy, &dev);
> +       }
>         /* tell ACPI that we're resuming */
>         ata_acpi_on_resume(ap);
>
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 52d58b13e5eee..e720fed6dbd7f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -147,6 +147,7 @@ enum {
>         ATA_LFLAG_RST_ONCE      =3D (1 << 9), /* limit recovery to one re=
set */
>         ATA_LFLAG_CHANGED       =3D (1 << 10), /* LPM state changed on th=
is link */
>         ATA_LFLAG_NO_DEBOUNCE_DELAY =3D (1 << 11), /* no debounce delay o=
n link resume */
> +       ATA_LFLAG_NO_LPM_RECOVER =3D (1 << 12), /* disable LPM on this li=
nk */
>
>         /* struct ata_port flags */
>         ATA_FLAG_SLAVE_POSS     =3D (1 << 0), /* host supports slave dev =
*/
> --
> 2.34.1
>
