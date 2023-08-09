Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874377560A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHIJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHIJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:01:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9D81FD0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:01:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so104686511fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691571679; x=1692176479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xldZ4A9/T2Mauv2RO3zxv83wv8+YuSEyW6kLCiZaGg=;
        b=DG10bjqOzIM469nOXp1BVAG95svwVtadEWGSLj7XRCjfgh3iHLy5taMF2QG7z362Kc
         A6jOR8Y5JnzwQ617+S/n5GcEiwv/QTBXQMh6D4jr3+fG15LbAHfN65l8vnvhPyuOWsUn
         8CJfEs+v+gS22iBIc0bZ027FNYOBV33eXwFHWf5MkMrG7A3hTljnt0XsGpzmFItnYnaE
         JKqmJtqJxIpRdX/jGUyKvzI3yOdxxjpjPXEyG23ZOMR9nr/6NBYLuNSuxjnn/p+uy0JD
         4/6oyTk5yYoj2c6r6C06Vmw17pvrqg/xzLeeT2o5g0vaT3f/fATNF12Cnq9AdpUUp6Rc
         n+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691571679; x=1692176479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xldZ4A9/T2Mauv2RO3zxv83wv8+YuSEyW6kLCiZaGg=;
        b=ipVeeXD2BtOVr5w784BmoeC1mq3u2o94HjrWvPxb8klwcIQ3TGvUjZJABBaLXvDMy8
         gOANsr+XegBWR2ao5el8wQEl/HkxLiHLzU8RKOmgb7UulmUlIpWP/lrAR9L0PPYnbG1+
         htu6C9gkwNE5r99wmoYIwK7oZbH17QnK8DuguhyP3LdrHCaU5FilCr1qPdOUF41tA4f0
         fOjTG8F43n97zL8OacI1Uj08l2zDO0Kf967ILVoeWmrqKzxE62iXWsgLBuNibmgZa92Y
         MFRXnGS93M7Vk7fqiqACV0N3uZnpX24tnYQSzMntDl+DlsFvCVjXFKy6gtukG0GBnEyt
         pyLw==
X-Gm-Message-State: AOJu0Yy+EmwPdx67M7g0VCvV0HmXb1UEoYbLXaOKAW3Ru36eIMtAE4ss
        WlBGjgm7C01bwGaKDuB1QXchUGDvsWqsMLil+E+mSQ==
X-Google-Smtp-Source: AGHT+IG161QRxmDkM4CQkSVbq4nK781aDej06ILDM1nhtr/p7rmwyUp6OJ33TvWbxbW8R2YX/1pyQrENd1CM6JVmWj8=
X-Received: by 2002:a2e:7006:0:b0:2b4:6bc2:a540 with SMTP id
 l6-20020a2e7006000000b002b46bc2a540mr1456307ljc.15.1691571678686; Wed, 09 Aug
 2023 02:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-purse-hydrant-6f44f77364b0@wendy> <20230802-detention-second-82ab2b53e07a@wendy>
 <CAHBxVyGgSJ66zMj65tRup2u23KP4=RJ5zN7hj5=K9e91NA9eog@mail.gmail.com> <20230808-handbag-mushily-f884178d29f5@spud>
In-Reply-To: <20230808-handbag-mushily-f884178d29f5@spud>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Wed, 9 Aug 2023 02:01:07 -0700
Message-ID: <CAHBxVyFNng2JOAQNfJSnabeq=+NYCSefk7OJEzkGMXEFY1tmFg@mail.gmail.com>
Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:39=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Aug 08, 2023 at 12:54:11AM -0700, Atish Kumar Patra wrote:
> > On Wed, Aug 2, 2023 at 4:14=E2=80=AFAM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
> > >
> > > Add an erratum for versions [v0.8 to v1.3) of OpenSBI which fail to a=
dd
> > > the "no-map" property to the reserved memory nodes for the regions it
> > > has protected using PMPs.
> > >
> > > Our existing fix sweeping hibernation under the carpet by marking it
> > > NONPORTABLE is insufficient as there are other ways to generate
> > > accesses to these reserved memory regions, as Petr discovered [1]
> > > while testing crash kernels & kdump.
> > >
> > > Intercede during the boot process when the afflicted versions of Open=
SBI
> > > are present & set the "no-map" property in all "mmode_resv" nodes bef=
ore
> > > the kernel does its reserved memory region initialisation.
> > >
> >
> > We have different mechanisms of DT being passed to the kernel.
> >
> > 1. A prior stage(e.g U-Boot SPL) to M-mode runtime firmware (e.g.
> > OpenSBI, rustSBI) passes the DT to M-mode runtime firmware and it
> > passes to the next stage.
> > In this case, M-mode runtime firmware gets a chance to update the
> > no-map property in DT that the kernel can parse.
> >
> > 2. User loads the DT from the boot loader (e.g EDK2, U-Boot proper).
> > Any DT patching done by the M-mode firmware is useless. If these DTBs
> > don't have the no-map
> > property, hibernation or EFI booting will have issues as well.
> >
>
> > We are trying to solve only one part of problem #1 in this patch.
>
> Correct.
>
> If someone's second stage is also providing an incorrect devicetree
> then, yeah, this approach would fall apart - but it's the firmware
> provided devicetree being incorrect that I am trying to account for
> here. If a person incorrectly constructed one, I am not really sure what
> we can do for them, they incorrect described their hardware /shrug
> My patch should of course help in some of the scenarios you mention above
> if the name of the reserved memory region from OpenSBI is propagated by
> the second-stage bootloader, but that is just an extension of case 1,
> not case 2.
>
> > I
> > don't think any other M-mode runtime firmware patches DT with no-map
> > property as well.
> > Please let me know if I am wrong about that. The problem is not
> > restricted to [v0.8 to v1.3) of OpenSBI.
>
> It comes down to Alex's question - do we want to fix this kind of
> firmware issue in the kernel? Ultimately this is a policy decision that
> "somebody" has to make. Maybe the list of firmwares that need this

IMO, we shouldn't as this is a slippery slope. Kernel can't fix every
firmware bug by having erratas.
I agree with your point below about firmware in shipping products. I
am not aware of any official products shipping anything other than
OpenSBI
either. However, I have seen users using other firmwares in their dev
environment.
IMHO, this approach sets a bad precedent for the future especially
when it only solves one part of the problem.
We shouldn't hide firmware bugs in the kernel when an upgraded
firmware is already available.

This bug is well documented in various threads and fixed in the latest
version of OpenSBI.
I am assuming other firmwares will follow it as well.

Anybody facing hibernation or efi related booting issues should just
upgrade to the latest version of firmware (e.g OpenSBI v1.3)
Latest version of Qemu will support(if not happened already) the
latest version of OpenSBI.

This issue will only manifest in kernels 6.4 or higher. Any user
facing these with the latest kernel can also upgrade the firmware.
Do you see any issue with that ?

> grows, but hopefully this bug will be fixed everywhere going forward,
> since, as you say, we now have a document.
> The reason I've only targeted OpenSBI here is that it's what is being
> shipped on people's SBCs etc by default & is also what is in the
> versions of QEMU that people seem to be using. Unless there's some
> example that I am missing, other firmwares are either not affected or
> not actually being shipped on to consumers?
>
> > The booting doc now says that no-map property must be set and any
> > usage of DTBs without that (via #1 or #2) will have unintended
> > consequences.
>
> Which is great. It unfortunately does not help one iota with stuff
> that's already in the wild.
>
> Thanks,
> Conor.
>
> > > Reported-by: Song Shuai <suagrfillet@gmail.com>
> > > Link: https://lore.kernel.org/all/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+=
vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > > Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKf=
A6z8
> > > Reported-by: Petr Tesarik <petrtesarik@huaweicloud.com>
> > > Closes: https://lore.kernel.org/linux-riscv/76ff0f51-d6c1-580d-f943-0=
61e93073306@huaweicloud.com/ [1]
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/include/asm/sbi.h |  5 +++++
> > >  arch/riscv/kernel/sbi.c      | 42 ++++++++++++++++++++++++++++++++++=
+-
> > >  arch/riscv/mm/init.c         |  3 +++
> > >  3 files changed, 49 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sb=
i.h
> > > index 5b4a1bf5f439..5360f3476278 100644
> > > --- a/arch/riscv/include/asm/sbi.h
> > > +++ b/arch/riscv/include/asm/sbi.h
> > > @@ -252,6 +252,9 @@ enum sbi_pmu_ctr_type {
> > >  #define SBI_ERR_ALREADY_STARTED -7
> > >  #define SBI_ERR_ALREADY_STOPPED -8
> > >
> > > +/* SBI implementation IDs */
> > > +#define SBI_IMP_OPENSBI        1
> > > +
> > >  extern unsigned long sbi_spec_version;
> > >  struct sbiret {
> > >         long error;
> > > @@ -259,6 +262,8 @@ struct sbiret {
> > >  };
> > >
> > >  void sbi_init(void);
> > > +void sbi_apply_reserved_mem_erratum(void *dtb_va);
> > > +
> > >  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> > >                         unsigned long arg1, unsigned long arg2,
> > >                         unsigned long arg3, unsigned long arg4,
> > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > index c672c8ba9a2a..aeb27263fa53 100644
> > > --- a/arch/riscv/kernel/sbi.c
> > > +++ b/arch/riscv/kernel/sbi.c
> > > @@ -5,8 +5,10 @@
> > >   * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> > >   */
> > >
> > > +#include <linux/acpi.h>
> > >  #include <linux/bits.h>
> > >  #include <linux/init.h>
> > > +#include <linux/libfdt.h>
> > >  #include <linux/pm.h>
> > >  #include <linux/reboot.h>
> > >  #include <asm/sbi.h>
> > > @@ -583,6 +585,40 @@ long sbi_get_mimpid(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
> > >
> > > +static long sbi_firmware_id;
> > > +static long sbi_firmware_version;
> > > +
> > > +/*
> > > + * For devicetrees patched by OpenSBI a "mmode_resv" node is added t=
o cover
> > > + * the region OpenSBI has protected by means of a PMP. Some versions=
 of OpenSBI,
> > > + * [v0.8 to v1.3), omitted the "no-map" property, but this trips up =
hibernation
> > > + * among other things.
> > > + */
> > > +void __init sbi_apply_reserved_mem_erratum(void *dtb_pa)
> > > +{
> > > +       int child, reserved_mem;
> > > +
> > > +       if (sbi_firmware_id !=3D SBI_IMP_OPENSBI)
> > > +               return;
> > > +
> > > +       if (!acpi_disabled)
> > > +               return;
> > > +
> > > +       if (sbi_firmware_version >=3D 0x10003 || sbi_firmware_version=
 < 0x8)
> > > +               return;
> > > +
> > > +       reserved_mem =3D fdt_path_offset((void *)dtb_pa, "/reserved-m=
emory");
> > > +       if (reserved_mem < 0)
> > > +               return;
> > > +
> > > +       fdt_for_each_subnode(child, (void *)dtb_pa, reserved_mem) {
> > > +               const char *name =3D fdt_get_name((void *)dtb_pa, chi=
ld, NULL);
> > > +
> > > +               if (!strncmp(name, "mmode_resv", 10))
> > > +                       fdt_setprop((void *)dtb_pa, child, "no-map", =
NULL, 0);
> > > +       }
> > > +};
> > > +
> > >  void __init sbi_init(void)
> > >  {
> > >         int ret;
> > > @@ -596,8 +632,12 @@ void __init sbi_init(void)
> > >                 sbi_major_version(), sbi_minor_version());
> > >
> > >         if (!sbi_spec_is_0_1()) {
> > > +               sbi_firmware_id =3D sbi_get_firmware_id();
> > > +               sbi_firmware_version =3D sbi_get_firmware_version();
> > > +
> > >                 pr_info("SBI implementation ID=3D0x%lx Version=3D0x%l=
x\n",
> > > -                       sbi_get_firmware_id(), sbi_get_firmware_versi=
on());
> > > +                       sbi_firmware_id, sbi_firmware_version);
> > > +
> > >                 if (sbi_probe_extension(SBI_EXT_TIME)) {
> > >                         __sbi_set_timer =3D __sbi_set_timer_v02;
> > >                         pr_info("SBI TIME extension detected\n");
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 70fb31960b63..cb16bfdeacdb 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -29,6 +29,7 @@
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/sections.h>
> > >  #include <asm/soc.h>
> > > +#include <asm/sbi.h>
> > >  #include <asm/io.h>
> > >  #include <asm/ptdump.h>
> > >  #include <asm/numa.h>
> > > @@ -253,6 +254,8 @@ static void __init setup_bootmem(void)
> > >          * in the device tree, otherwise the allocation could end up =
in a
> > >          * reserved region.
> > >          */
> > > +
> > > +       sbi_apply_reserved_mem_erratum(dtb_early_va);
> > >         early_init_fdt_scan_reserved_mem();
> > >
> > >         /*
> > > --
> > > 2.40.1
> > >
