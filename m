Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0CA797763
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjIGQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244981AbjIGQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:23:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75385A5FD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:14:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-502934c88b7so1420812e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694103216; x=1694708016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpIRckm+wlKPG4865Y0AKN4K9nVyXpI6Pdl7EWBzfrE=;
        b=AJUv8RhJvDldMv66xU5kUly4vYQDkQzA/GJNGCRT40YLPkPZhVEOGGFp1cDcoddnqR
         x0tHK/V8C35wkUPnPFpRnu0LCz3EkqZqKxJpYlBO5LB03EcZ1BfRY2g5otSklhgEXoIz
         WANw27/FBR7aemyT4rScX5dlar3j+YlFnD/oGdzrWrTbrCAtHrMTdBSxO6cyrR1X1RGd
         S8RQE7Ddl34Ld3i2JJPWnqSnO3j+Lx6cIf3T1ZvYVbk06NhPRN91297lphkyNwh91GrB
         Qqj5w0Rv/OyEBiYtOd6ZAMHTY09JkSRAiCZ6vgCmomEkrAhpwAbZzhR9kcsFSYMn/J2M
         RXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103216; x=1694708016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpIRckm+wlKPG4865Y0AKN4K9nVyXpI6Pdl7EWBzfrE=;
        b=RQyvlo8/Y547nSaq6vMxm1n+i4DSlthT+1lpsxjXmAIlRTn6FtcvwPxEbniWVxYe2e
         gVmNry9EmZ9z6t7cb5jRvQ2kOKxHp3kcHpzSXVBC5L08a++EWwhdQIrhQGVgkDjWY7li
         KPUq0xSZoyNnXe8jfNXlp/Q8kXU61iINLEPjOAcdbBeeR6Ln43E3z2BppgijN/j3nX1o
         aqhenavYmIuH9pcH54aN6bsLSqpnjpo1yE1rY+Ecz7yds31aAyAZUkFnqcMmfuuTayq4
         RZ0MbkWv12/kP1/Roey7EVC+US7VMOofN1C11U36L5vsjQDlJhJHlsP4do/tsmgYo97x
         MM6g==
X-Gm-Message-State: AOJu0YwsIoULgid2FD7I9lJ2AivOnoxjvRcHKn4jQt7Pf/PaysZwkjm+
        6Y8HiZKRnS8xjxqytlNKAEAbOQUfaQ+QyoPjKLHJWT1kCJFEE4zHOFM=
X-Google-Smtp-Source: AGHT+IFmLWgZp5Q2SDD27ttHJ6ry0qaiGdpravXN90uYPS+vLCslFsUFRRI6GqJeGd4wBCjPav+DjkI12vLXHAZSa+Y=
X-Received: by 2002:a5d:43d0:0:b0:319:82c9:8e7d with SMTP id
 v16-20020a5d43d0000000b0031982c98e7dmr4700503wrr.31.1694088951761; Thu, 07
 Sep 2023 05:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop> <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud> <DBAPR08MB5783AED8329E38D840B7015D9C2DA@DBAPR08MB5783.eurprd08.prod.outlook.com>
 <CAMj1kXEkL0gF8uGcy2AjJvD-yZHmyLX9jiVVDtR+uBAYf+BfUg@mail.gmail.com> <CAN3iYbMsUNMH27kdtwPwLeBSUfH0gTvyqjZ8ExZaoGcuv8CBdA@mail.gmail.com>
In-Reply-To: <CAN3iYbMsUNMH27kdtwPwLeBSUfH0gTvyqjZ8ExZaoGcuv8CBdA@mail.gmail.com>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Thu, 7 Sep 2023 20:15:40 +0800
Message-ID: <CAEEQ3w=N+Ey++XWPkseSZTc-GiD6bRXAotw-XyF5iDCWPBkpLg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Dong Wei <Dong.Wei@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "jrtc27@jrtc27.com" <jrtc27@jrtc27.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "yc.hung@mediatek.com" <yc.hung@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "allen-kh.cheng@mediatek.com" <allen-kh.cheng@mediatek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "tinghan.shen@mediatek.com" <tinghan.shen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "weidong.wd@bytedance.com" <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,


On Tue, Jul 11, 2023 at 12:03=E2=80=AFAM =E8=91=9B=E5=A3=AB=E5=BB=BA <geshi=
jian@bytedance.com> wrote:
>
> On Sat, Jul 8, 2023 at 4:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Fri, 7 Jul 2023 at 18:21, Dong Wei <Dong.Wei@arm.com> wrote:
> > >
> > > On Arm systems today, the ACPI RSDP is found using the UEFI Configura=
tion Table. This is true for all Arm SystemReady compliant systems: 1) Syst=
emReady LS: LBBRv1 is using a minimal UEFI FW to load LinuxBoot, that minim=
al UEFI FW is producing the UEFI Configuration Table. We are working on LBB=
Rv2. LBBRv2 is based on Coreboot loading LinuxBoot. But we do not have a wa=
y today to get CoreBoot to produce this pointer to ACPI RSDP. Arm does not =
support x86 E820 BIOS interface. 2) SystemReady IR: this solution uses DT r=
ather than ACPI. 3) SystemReady ES: this solution can use UBoot or EDK2, an=
d it requires ACPI. Since both UBoot and EDK2 support UEFI now, so ACPI RSD=
P can be found using the UEFI Configuration Table. 4) SystemReady SR: this =
solution typically uses EDK2 and requires ACPI, so no issue finding RSDP vi=
a UEFI Configuration Table.
> > >
> > >
> > >
> > > So the ACPI RSDP issue only exist if we want to remove the minimum UE=
FI FW and go to CoreBoot completely to load LinuxBoot. We are currently exp=
loring how to solve that issue=E2=80=A6
> > >
> >
> > Hello Dong,
> >
> > This fixes the RSDP issue perhaps, but that is not the only problem. I
> > have mentioned this many times already, but let me mention it again
> > for completeness:
> >
> > ACPI does not have a memory map, and ARM is much more finicky about
> > mapping memory regions with the right attributes, given that uncached
> > accesses don't snoop the caches like they do on x86. This means it is
> > essential that memory mappings constructed from AML code (which
> > doesn't provide any context pertaining to the memory type either) are
> > created with the right memory type.
> >
> > Currently, the Linux/arm64 glue code for the ACPI core
> > cross-references every memory mapping created from a SystemMemory
> > OpRegion by AML code against the EFI memory map, and uses the EFI
> > memory type and attributes to infer the memory type to program into
> > the page tables. So simply providing the RSDP is *not* sufficient: on
> > arm64, more work is needed and currently, booting ACPI without a EFI
> > memory map results in SystemMemory OpRegions not working at all.
> >
> > Of course, we might be able to work around that by providing a
> > 'coreboot' memory map for doing ACPI on arm64, but that results in
> > more fragmentation and an inflated validation matrix, which puts the
> > burden on the Linux subsystem maintainers to make sure that all these
> > different combinations remain supported.
> >
> > AIUI, this memory type issue does not exist for RISC-V today, but I'd
> > suggest to the RISC-V maintainers to take a careful look at arm64's
> > acpi_os_ioremap() implementation and decide whether or not RISC-V
> > needs similar logic.
>
> Thanks Ard and Sunil,
>
> You are right, we need to work out a coreboot memory map for doing
> ACPI on ARM64.
> BTW, I don't suggest binding ACPI and UEFI together. On RISC-V,  the
> current solution works well based on our experience, anyway, we will
> study memory with DTS and update later.
>
> Thanks,
> -Nill

Let's move on to this patchset,
Regarding the so-called risc-v spec
(https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spe=
c.adoc#32-boot-process)
that we discussed before, it is outdated , the patchset is not
constrained by the spec.
See:
https://github.com/riscv/riscv-platform-specs/pull/91#issuecomment-17090442=
15

So please help to review this patchset, thank you!


Thanks,
Yunhui
