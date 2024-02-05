Return-Path: <linux-kernel+bounces-52302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB7849686
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D28DB22685
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB912B8C;
	Mon,  5 Feb 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KuyfgaT7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15718134C7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125565; cv=none; b=nO78Mm6v86ZgkLvIzp7yzXNyq7Ws+2HKgEd6mIfJa8rd5NyXHXoEnuNHUzV2h62NSkqVzyaDukfqVYyQVKZkwjIpT5n8c4A8M+0vNVFVEdSftSkBW7Egs0P9mAV0RGBRNEdWnUNrqbIk+WAShR26AKaYGHALYmPlDZ+7oJLR30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125565; c=relaxed/simple;
	bh=duBQJWb5n6DgJh9NDCi0lDNsnNYE4fIsp+B5mHRyHTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaP9VjenXiryE81n+WCsTdrXt4/Y70lMx5SSdIp5EoMgSEAZAA0pCUpUi5QFwssj/DfQ4aNdzwj7RLOH7yBXyTkNVCU6Lr1ETIMjykEtuXByLzS/JyDo+xbcLiSLfKnjsKAhMl2rEwNOc9jINbosh967TbMfcQZyfAcZduZ1nZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KuyfgaT7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51124e08565so6324562e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707125560; x=1707730360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVZry8n33b0WHskESeVtXV0w9cCtNPi/Dge/gmziDPQ=;
        b=KuyfgaT7m3FGxKqKDFH0AbsOy/U32vnYrLraH1VEHL/xr+S2iWrEU+IYBJPj34zq9y
         QrSkDA4hzfcVlN6NvLeoRVax9INgxHGj+EanOctsZ8dB1rXhcbP2184B1DYoimTshjjl
         mI82B8gzPXowDNxVqTRslXYj0fOlUZO/AdCNhoBulpFi0oytez4HSe6b5HXZvU0vS85y
         /dSvlnBHyWGLefPuPJL5fSmxWIFRgZ99dHj6e4JXSiPhzPpUkEULOvl/9OcK3I+7oagT
         MtM6U7H1f6LmjgZPTiftMQRh2dwlFfSV6jifmxOl87bIMejssbombQGlaXjU4xIQJyoB
         WCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125560; x=1707730360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVZry8n33b0WHskESeVtXV0w9cCtNPi/Dge/gmziDPQ=;
        b=AYiaQWahMRW3bAIRwXr7LweNHa7M4QQCdp65pjq/oEArwCLNdS5oqiaZB39S8d2751
         q46ohkVjjvFNgaQPRJUR0RX002dbBTxo7pOthEUDG8nzkqmWkYR0DNlCocM1IfgPX2xA
         alavZYJv0HDV1iEdQweVNZ/rWIOr9minnK8pgQfQq7h52QTX3sADRuR2fRQM7xyHHayq
         IfxE8ragYDuuowA1pH/GK9omiZ7/2is1kyIVe1JfdiOymVO5EAMBrD4YKx/sRYoISJyI
         Z8qyxsvn4B6t6zRYC/vMbF1YaCG5qXKDIieS2mj4lB9fjDlvu78GY0zNxjIpLUoyQbZg
         WX3g==
X-Gm-Message-State: AOJu0YxZqB5GtAfpSKUae8L3xxl25zkU0PExGa3YvjsTEqyWQPs6tHvF
	5QTUGm6YEJMCN21rfc81K+SOUzNXpY32t6TBeusUVofmIbaAf5Fi/IY/coTY1hHYYPN909uxkzR
	APrJvbjK+k0MI7HOzDojyGO70EXTcUzHWmyzUKQ==
X-Google-Smtp-Source: AGHT+IGJtt3ctxY+h8i6j3P5dgJUYa3KuaK9C2dnqDHV2fJJh3i3ISjqNYBLXV7kPnHjw70SrQ3O8lgkERpEm8n+edM=
X-Received: by 2002:a19:7509:0:b0:511:4f67:7d4d with SMTP id
 y9-20020a197509000000b005114f677d4dmr383850lfe.15.1707125559904; Mon, 05 Feb
 2024 01:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
 <CAHVXubhhxpzHDM-n91V_rceY5t_VqLvrwZj3RP_tNL2=F9mqjQ@mail.gmail.com>
 <CAK9=C2WVOpSqtt8r1U4hnzSZ=cc1PocpukgQjNyahP2XuPhozw@mail.gmail.com>
 <d0087922-4721-ccf1-80bf-9f74099d0948@ghiti.fr> <CAPqJEFr6MgUyARfbWAo7EeQKLVd4xRJz_LOYN68UC-kPD1Hr5A@mail.gmail.com>
 <20240118082346.GB31078@hsinchu15> <CAHVXubiQ5N+ngdy=Fk3j-hS_KkOEg272b++-hB4-oGeSSZKtNQ@mail.gmail.com>
 <CAHh=Yk-WCMbNWg7UCbXtZZzPmOHnh1-pv4fqykwnpJGtwTcc=A@mail.gmail.com>
In-Reply-To: <CAHh=Yk-WCMbNWg7UCbXtZZzPmOHnh1-pv4fqykwnpJGtwTcc=A@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 5 Feb 2024 10:32:28 +0100
Message-ID: <CAHVXubhE=RmFQ5gGo7J+H-mOEZKZQbCCH6F43UYMOy=Kgw+nug@mail.gmail.com>
Subject: Re: Fwd: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear mapping
To: Nylon Chen <nylon.chen@sifive.com>
Cc: alex@ghiti.fr, apatel@ventanamicro.com, catalin.marinas@arm.com, 
	will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com, 
	rppt@kernel.org, akpm@linux-foundation.org, anup@brainfault.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-mm@kvack.org, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nylon,

On Fri, Jan 19, 2024 at 10:27=E2=80=AFAM Nylon Chen <nylon.chen@sifive.com>=
 wrote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> =E6=96=BC 2024=E5=B9=B41=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:01=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Nylon,
> Hi Alexandre, thanks for your feedback,
> >
> > On Thu, Jan 18, 2024 at 9:23=E2=80=AFAM Nylon Chen <nylon.chen@sifive.c=
om> wrote:
> > >
> > > > On 3/23/23 15:55, Anup Patel wrote:
> > > > > On Thu, Mar 23, 2023 at 6:24=E2=80=AFPM Alexandre Ghiti <alexghit=
i@rivosinc.com> wrote:
> > > > >> Hi Anup,
> > > > >>
> > > > >> On Thu, Mar 23, 2023 at 1:18=E2=80=AFPM Anup Patel <apatel@venta=
namicro.com> wrote:
> > > > >>> Hi Alex,
> > > > >>>
> > > > >>> On Thu, Mar 16, 2023 at 6:48=E2=80=AFPM Alexandre Ghiti <alexgh=
iti@rivosinc.com> wrote:
> > > > >>>> This patchset intends to improve tlb utilization by using huge=
pages for
> > > > >>>> the linear mapping.
> > > > >>>>
> > > > >>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, =
we must
> > > > >>>> take care of isolating the kernel text and rodata so that they=
 are not
> > > > >>>> mapped with a PUD mapping which would then assign wrong permis=
sions to
> > > > >>>> the whole region: it is achieved by introducing a new memblock=
 API.
> > > > >>>>
> > > > >>>> Another patch makes use of this new API in arm64 which used so=
me sort of
> > > > >>>> hack to solve this issue: it was built/boot tested successfull=
y.
> > > > >>>>
> > > > >>>> base-commit-tag: v6.3-rc1
> > > > >>>>
> > > > >>>> v8:
> > > > >>>> - Fix rv32, as reported by Anup
> > > > >>>> - Do not modify memblock_isolate_range and fixes comment, as s=
uggested by Mike
> > > > >>>> - Use the new memblock API for crash kernel too in arm64, as s=
uggested by Andrew
> > > > >>>> - Fix arm64 double mapping (which to me did not work in v7), b=
ut ends up not
> > > > >>>>    being pretty at all, will wait for comments from arm64 revi=
ewers, but
> > > > >>>>    this patch can easily be dropped if they do not want it.
> > > > >>>>
> > > > >>>> v7:
> > > > >>>> - Fix Anup bug report by introducing memblock_isolate_memory w=
hich
> > > > >>>>    allows us to split the memblock mappings and then avoid to =
map the
> > > > >>>>    the PUD which contains the kernel as read only
> > > > >>>> - Add a patch to arm64 to use this newly introduced API
> > > > >>>>
> > > > >>>> v6:
> > > > >>>> - quiet LLVM warning by casting phys_ram_base into an unsigned=
 long
> > > > >>>>
> > > > >>>> v5:
> > > > >>>> - Fix nommu builds by getting rid of riscv_pfn_base in patch 1=
, thanks
> > > > >>>>    Conor
> > > > >>>> - Add RB from Andrew
> > > > >>>>
> > > > >>>> v4:
> > > > >>>> - Rebase on top of v6.2-rc3, as noted by Conor
> > > > >>>> - Add Acked-by Rob
> > > > >>>>
> > > > >>>> v3:
> > > > >>>> - Change the comment about initrd_start VA conversion so that =
it fits
> > > > >>>>    ARM64 and RISCV64 (and others in the future if needed), as =
suggested
> > > > >>>>    by Rob
> > > > >>>>
> > > > >>>> v2:
> > > > >>>> - Add a comment on why RISCV64 does not need to set initrd_sta=
rt/end that
> > > > >>>>    early in the boot process, as asked by Rob
> > > > >>>>
> > > > >>>> Alexandre Ghiti (4):
> > > > >>>>    riscv: Get rid of riscv_pfn_base variable
> > > > >>>>    mm: Introduce memblock_isolate_memory
> > > > >>>>    arm64: Make use of memblock_isolate_memory for the linear m=
apping
> > > > >>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
> > > > >>> Kernel boot fine on RV64 but there is a failure which is still =
not
> > > > >>> addressed. You can see this failure as following message in
> > > > >>> kernel boot log:
> > > > >>>      0.000000] Failed to add a System RAM resource at 80200000
> > > > >> Hmmm I don't get that in any of my test configs, would you mind
> > > > >> sharing yours and your qemu command line?
> > > > > Try alexghiti_test branch at
> > > > > https://github.com/avpatel/linux.git
> > > > >
> > > > > I am building the kernel using defconfig and my rootfs is
> > > > > based on busybox.
> > > > >
> > > > > My QEMU command is:
> > > > > qemu-system-riscv64 -M virt -m 512M -nographic -bios
> > > > > opensbi/build/platform/generic/firmware/fw_dynamic.bin -kernel
> > > > > ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram rw
> > > > > console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4
> > > >
> > > >
> > > > So splitting memblock.memory is the culprit, it "confuses" the reso=
urces
> > > > addition and I can only find hacky ways to fix that...
> > > Hi Alexandre,
> > >
> > > We encountered the same error as Anup. After adding your patch
> > > (3335068f87217ea59d08f462187dc856652eea15), we will not encounter the
> > > error again.
> > >
> > > What I have observed so far is
> > >
> > > - before your patch
> > > When merging consecutive memblocks, if the memblock types are differe=
nt,
> > > they will be merged into reserved
> > > - after your patch
> > > When consecutive memblocks are merged, if the memblock types are
> > > different, they will be merged into memory.
> > >
> > > Such a result will cause the memory location of OpenSBI to be changed
> > > from reserved to memory. Will this have any side effects?
> >
> > I guess it will end up in the memory pool and pages from openSBI
> > region will be allocated, so we should see very quickly bad stuff
> > happening (either PMP violation or M-mode ecall never
> > returning/trapping/etc).
> >
> > But I don't observe the same thing, I always see the openSBI region
> > being reserved:
> >
> > reserved[0x0] [0x0000000080000000-0x000000008007ffff],
> > 0x0000000000080000 bytes flags: 0x0
> >
> > Can you elaborate a bit more about "When consecutive memblocks are
> > merged, if the memblock types are different, they will be merged into
> > memory"? Where/when does this merge happen? Can you give me a config
> > file and a kernel revision so that I can take a look?
> Ok, If you want to reproduce the same results you just need to modify Ope=
nSBI
>
> [ lib/sbi/sbi_domain.c ]
> +#define TEST_SIZE 0x200000
>
> -                                 (scratch->fw_size - scratch->fw_rw_offs=
et),
> +                                 (TEST_SIZE - scratch->fw_rw_offset),
>
> In addition, you can insert checks in the kernel merged function
> [ mm/memblock.c ]
> static void __init_memblock memblock_merge_regions(struct memblock_type *=
type)
>         while (i < type->cnt - 1) {
>          ...
>                 /* move forward from next + 1, index of which is i + 2 */
>                 memmove(next, next + 1, (type->cnt - (i + 2)) * sizeof(*n=
ext));
>                 type->cnt--;
>         }
> +       pr_info("Merged memblock_type: cnt =3D %lu, max =3D %lu,
> total_size =3D 0x%llx\n",type->cnt, type->max, type->total_size);
> +       for (i =3D 0; i < type->cnt; i++) {
> +               const char *region_type =3D
> memblock_is_memory(type->regions[i].base) ? "memory" : "reserve";
> +               pr_info("Region %d: base =3D 0x%llx, size =3D 0x%llx, typ=
e
> =3D %s\n", i, type->regions[i].base, type->regions[i].size,
> region_type);
> +       }
>  }
> This is kernel boot log
> - before your patch
> ...
> [    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size =3D 0=
x200000
> [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size =
=3D 0x1628501
> [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1600000, type =
=3D reserve
> ...
>
> - after your patch
> ...
> [    0.000000] OF: fdt: Reserving memory: base =3D 0x80000000, size =3D 0=
x200000
> [    0.000000] Merged memblock_type: cnt =3D 4, max =3D 128, total_size =
=3D 0x180c42e
> [    0.000000] Region 0: base =3D 0x80000000, size =3D 0x1800000, type =
=3D memory

So the openSBI region is marked as memory, and not reserved because
this region is now described as nomap, and memblock_mark_nomap() does
not move this region into the reserved memblock list, but keep it in
the memory list with the nomap flag
(https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L479).
But as stated in the description of memblock_mark_nomap()
(https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L969),
the pages associated with the region will be marked as PageReserved
and the region will not be covered in the linear mapping.

So to me, this is normal and we are safe. Let me know if I made a mistake.

And sorry for the long delay, that slipped my mind!

Thanks,

Alex

> ...
> [    0.000000] Failed to add a system RAM resource at 80200000
> ...
> >
> > Thanks,
> >
> > Alex
> >
> > > >
> > > > So given that the arm64 patch with the new API is not pretty and th=
at
> > > > the simplest solution is to re-merge the memblock regions afterward=
s
> > > > (which is done by memblock_clear_nomap), I'll drop the new API and =
the
> > > > arm64 patch to use the nomap API like arm64: I'll take advantage of=
 that
> > > > to clean setup_vm_final which I have wanted to do for a long time.
> > > >
> > > > @Mike Thanks for you reviews!
> > > >
> > > > @Anup Thanks for all your bug reports on this patchset, I have to
> > > > improve my test flow (it is in the work :)).
> > > >
> > > >
> > > > > Regards,
> > > > > Anup
> > > > >
> > > > >> Thanks
> > > > >>
> > > > >>> Regards,
> > > > >>> Anup
> > > > >>>
> > > > >>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
> > > > >>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
> > > > >>>>   arch/riscv/mm/init.c          | 53 +++++++++++++++++++++++++=
+++-------
> > > > >>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
> > > > >>>>   drivers/of/fdt.c              | 11 ++++----
> > > > >>>>   include/linux/memblock.h      |  1 +
> > > > >>>>   mm/memblock.c                 | 20 +++++++++++++
> > > > >>>>   7 files changed, 119 insertions(+), 26 deletions(-)
> > > > >>>>
> > > > >>>> --
> > > > >>>> 2.37.2
> > > > >>>>
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

