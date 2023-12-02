Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6E801A2A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjLBDBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLBDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:01:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C299
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:01:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139B5C433CB;
        Sat,  2 Dec 2023 03:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701486068;
        bh=t27rEY+6maqfIT5T618pr60BoAoj4X+/LJupan5IS9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t7+z2dMD//OguANgbHD9kluXtwwk3uYqteeVY8cE6LOvF3jRYcYmb0IepHhduor69
         iMw6hRQRbqTCF/WbOyJvRHLy8yd34cuWwxtZz+Q2cjSIv6FEnQCXMa25tn7WeWFz/W
         SVpjbwzj3bil5K1+ko8ziLkGe7Zea1juauRVejsjtDfS4yhJEkZeU8xkYTh132XmeE
         pBlBsPeCpxm6fGhklnYIfdHjOvXN0viatnRmpFjVTpEt8PPUGs9BtoV1LjkM4EeiAn
         PPBIPXJOVpQ9DvB7x3Srk5Eolb0L/whYasTc7Wpm8uN41ALkwK9o+5vnKYzTZ5zBoG
         IoDWj5iCy+/2A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54b450bd014so3285593a12.3;
        Fri, 01 Dec 2023 19:01:08 -0800 (PST)
X-Gm-Message-State: AOJu0YxvP/bd/ymWh2r1N1COYhfZJrkzCQUlxsWWIcDEr3rxLwInoAZl
        lkWMCONRLuTTN9PiQ7ge07qotC5H1a1Jmx4GPjU=
X-Google-Smtp-Source: AGHT+IHx60LG+C825T47CTbaw6kGVVRIjeuGz/L9ZiAmATFSxPGIdRfUvi/7aH6gMoK0W9SOaLx6oDlld7p3z0geV/U=
X-Received: by 2002:a50:cd4c:0:b0:54a:f1db:c290 with SMTP id
 d12-20020a50cd4c000000b0054af1dbc290mr1741306edj.9.1701486066428; Fri, 01 Dec
 2023 19:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20231201115028.84351-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20231201115028.84351-1-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 2 Dec 2023 11:01:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6+goYrqQ_LAPMFZ9gJrr-tDHSkesnTwAdqCYNdB_GPZQ@mail.gmail.com>
Message-ID: <CAAhV-H6+goYrqQ_LAPMFZ9gJrr-tDHSkesnTwAdqCYNdB_GPZQ@mail.gmail.com>
Subject: Re: [PATCH v6] pci: loongson: Workaround MIPS firmware MRRS settings
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Fri, Dec 1, 2023 at 7:50=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>
> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.
>
> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
>
> It must be done at device enablement stage because MRRS setting
> may get lost if the parent bridge lost PCI_COMMAND_MASTER, and
> we are only sure parent bridge is enabled at this point.
>
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v4: Improve commit message
> v5:
>         - Improve commit message and comments.
>         - Style fix from Huacai's off-list input.
> v6: Fix a typo
> ---
>  drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controll=
er/pci-loongson.c
> index d45e7b8dc530..e181d99decf1 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -80,13 +80,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>                         DEV_LS7A_LPC, system_bus_quirk);
>
> +/*
> + * Some Loongson PCIe ports have h/w limitations of maximum read
> + * request size. They can't handle anything larger than this.
> + * Sane firmware will set proper MRRS at boot, so we only need
> + * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
> + * won't set MRRS properly, and we have to enforce maximum safe
> + * MRRS, which is 256 bytes.
> + */
> +#ifdef CONFIG_MIPS
> +static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
> +{
> +       struct pci_bus *bus =3D pdev->bus;
> +       struct pci_dev *bridge;
> +       static const struct pci_device_id bridge_devids[] =3D {
> +               { PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +               { PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> +               { 0, },
> +       };
> +
> +       /* look for the matching bridge */
> +       while (!pci_is_root_bus(bus)) {
> +               bridge =3D bus->self;
> +               bus =3D bus->parent;
> +
> +               if (pci_match_id(bridge_devids, bridge)) {
> +                       if (pcie_get_readrq(pdev) > 256) {
> +                               pci_info(pdev, "limiting MRRS to 256\n");
> +                               pcie_set_readrq(pdev, 256);
> +                       }
> +                       break;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_q=
uirk);
> +#endif
> +
>  static void loongson_mrrs_quirk(struct pci_dev *pdev)
>  {
> -       /*
> -        * Some Loongson PCIe ports have h/w limitations of maximum read
> -        * request size. They can't handle anything larger than this. So
> -        * force this limit on any devices attached under these ports.
> -        */
>         struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus=
);
>
>         bridge->no_inc_mrrs =3D 1;
> --
> 2.34.1
>
