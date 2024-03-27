Return-Path: <linux-kernel+bounces-122067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5D88F173
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6BE1F22B33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A61E4A8;
	Wed, 27 Mar 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRXuVS3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686744F208;
	Wed, 27 Mar 2024 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576644; cv=none; b=UaG7m24mTIP+CBprEkyK7QA2h1lXbT2fVo/vzQm4H+kUsdBJoPS3taJcJ2IZJOe1cpJTc16Sc+tSvMSVlB/cRXC/RbShYyaC4jP6xnEV2IQz8/adTcWoobZLo1CFrfmCoK4tgJ3L6QQjtQ/dkX2jUHAqqkAdJy5RUbkPlob5JT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576644; c=relaxed/simple;
	bh=kckJEpYhHgnCtBplTfHjpMjOocZjkqamf13wWZ8KnGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4eWUNVcianrr86Vv8G8Hn2+GHtFnU8bEwl1hMMWqUzavLKxUDisWec9PNpbBCGWD9XxEMupD5IcuRvtd36noHD32tb67EReyXCoUc9cuvnnyXsjQtDJNtkfZT2a+qW8KPTWdzQi1JFCKXab4VRKUMHQXdJbLLvvhDa2RnnaydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRXuVS3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF9CC43390;
	Wed, 27 Mar 2024 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711576644;
	bh=kckJEpYhHgnCtBplTfHjpMjOocZjkqamf13wWZ8KnGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pRXuVS3/1JjfYzC2eVhCcfJJeCjDnwdY00NXVwIEIS7zvDJ9tvezBJyu9TNhixL0X
	 1AjsQSJp/DouC8YbxVsjGz2kBdfzFB4eMKt5YBhuZFUJAPUGkO7VEzXbAZWZ9UwxWX
	 pDt4/nlkk7tOtdIhT+eByN9jbE3FNXup7G6jYZHATbBKbzE8ogIzbpwrfmg98Irpb5
	 RzYx0EEbCOm+hcnBiMtEzjNhBLrSm0S7uwHrUqXm/kyw6PMNsiJWvo8oF/1yJW97TL
	 WFgwdNZRBscAVO+vTlah4k8Jr0AAvtIya+eY0Mm0qY3J7HQ8QyLQ+Jf0GiMfd+P06T
	 TEXZvk0slWsdQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d485886545so4047611fa.2;
        Wed, 27 Mar 2024 14:57:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM2E2jnjHUZLbra701/jJ++SJTC4EM0T/suwcejNpRZC1lh9OnU7sxweizPjt9jUKm5SA7SrMbdi8LU4+C15pQ+vWz6CtvQRYp0B7y6k69R2HkdJC9GDWyI7KroPHMyYvnSYiyR3cgZg==
X-Gm-Message-State: AOJu0YwtdnizfWbHpEyaGn87SgVa4aimzLYD+rlyNQrs5ReuPUCHdvpU
	Qp+uIj4qjuRtjfiuHWHGELAuhA9Ej+IoeymeSzjCZvtLi4BxvAE6CSZGgre8CAo2yZH8A+Zt9gE
	kOCKg1neawoN2BUh4IFd0uNY8jg==
X-Google-Smtp-Source: AGHT+IF5TLpTdDPxkBcMlw2BkyJcmW0EZYnw6TbOF4oQ4eJk6/hik2QycCw8mbRy1BM1VfoLw+7l8jG+S62JazvnP+4=
X-Received: by 2002:a2e:a789:0:b0:2d6:f698:7eca with SMTP id
 c9-20020a2ea789000000b002d6f6987ecamr1471552ljf.5.1711576642517; Wed, 27 Mar
 2024 14:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com> <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
 <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
 <66409df9-6f5f-4fbe-ae7f-47b86665c113@roeck-us.net> <CAL_Jsq+0JHTDmBPr94ZZF_5rtQg14q8OmWH6WpRspjHMX-MZmg@mail.gmail.com>
 <23ed5bbb-7616-424b-96ee-3fe1c6d8ca89@roeck-us.net> <CAL_JsqJd-upC4TgOwP5-DMXKL+x=X7sGC7qqiy2PTjD6pnSV7Q@mail.gmail.com>
 <407867d2-2e32-4df4-96ac-f9ae84b44375@roeck-us.net> <CAL_JsqJ2DijyKa-WSWdOszZt9UfQbb1MnD2zHh3ywntx6a=N+w@mail.gmail.com>
 <932e8cb7-1874-4c4a-8fee-bc0b9dffe94c@roeck-us.net>
In-Reply-To: <932e8cb7-1874-4c4a-8fee-bc0b9dffe94c@roeck-us.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Mar 2024 16:56:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLA354A5KyQdCApOtqNrV9R239dSBOreODHseRZFU47PQ@mail.gmail.com>
Message-ID: <CAL_JsqLA354A5KyQdCApOtqNrV9R239dSBOreODHseRZFU47PQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lizhi Hou <lizhi.hou@xilinx.com>, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:47=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Wed, Mar 27, 2024 at 01:38:13PM -0500, Rob Herring wrote:
> > On Wed, Mar 27, 2024 at 9:40=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> > >
> > > On 3/27/24 06:11, Rob Herring wrote:
> > > > On Wed, Mar 20, 2024 at 3:06=E2=80=AFPM Guenter Roeck <linux@roeck-=
us.net> wrote:
> > > >>
> > > >> On 3/20/24 12:14, Rob Herring wrote:
> > > >>> On Mon, Mar 18, 2024 at 4:31=E2=80=AFPM Guenter Roeck <linux@roec=
k-us.net>
> > > >>> wrote:
> > > >>>>
> > > >>>> On 3/18/24 12:26, Rob Herring wrote:
> > > >>>>> +Stephen
> > > >>>>>
> > > >>>>> On Mon, Mar 18, 2024 at 12:09=E2=80=AFPM Guenter Roeck <linux@r=
oeck-us.net>
> > > >>>>> wrote:
> > > >>>>>>
> > > >>>>>> Hi,
> > > >>>>>>
> > > >>>>>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> > > >>>>>>> When enabling CONFIG_OF on a platform where of_root is not
> > > >>>>>>> populated by firmware, we end up without a root node. In orde=
r to
> > > >>>>>>> apply overlays and create subnodes of the root node, we need =
one.
> > > >>>>>>> Create this root node by unflattening an empty builtin dtb.
> > > >>>>>>>
> > > >>>>>>> If firmware provides a flattened device tree (FDT) then the F=
DT is
> > > >>>>>>> unflattened via setup_arch().  Otherwise setup_of(), which is
> > > >>>>>>> called immediately after setup_arch(), will create the defaul=
t root
> > > >>>>>>> node if it does not exist.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> > > >>>>>>
> > > >>>>>> This patch results in a crash on nios2.
> > > >>>>>
> > > >>>>> This patch was never applied. I assume you meant a later versio=
n of
> > > >>>>> it that did get applied.
> > > >>>>>
> > > >>>>>>
> > > >>>>>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts .=
.
> > > >>>>>> running ...R failed (crashed)
> > > >>>>>
> > > >>>>> Booting with DT?
> > > >>>>>
> > > >>>>>> ------------ qemu log: earlycon: uart8250 at MMIO32 0x18001600
> > > >>>>>> (options '') printk: legacy bootconsole [uart8250] enabled Lin=
ux
> > > >>>>>> version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linu=
x-gcc
> > > >>>>>> (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:=
59 PDT
> > > >>>>>> 2024 Kernel panic - not syncing: early_init_dt_alloc_memory_ar=
ch:
> > > >>>>>> Failed to allocate 72 bytes align=3D0x40 ---[ end Kernel panic=
 - not
> > > >>>>>> syncing: early_init_dt_alloc_memory_arch: Failed to allocate 7=
2
> > > >>>>>> bytes align=3D0x40 ]---
> > > >>>>>
> > > >>>>> nios2 looks utterly broken to me. This change should be a nop u=
nless
> > > >>>>> initial_boot_params is NULL. It looks like it is possible for r=
6 (dtb
> > > >>>>> address) to be 0 depending on kconfig options, but that would h=
ave
> > > >>>>> skipped copying and unflattening which would then panic in
> > > >>>>> setup_cpuinfo(). If initial_boot_params is not NULL, then the s=
ame
> > > >>>>> early_init_dt_alloc_memory_arch() calls should fail when copyin=
g the
> > > >>>>> DT. So I don't see how nios2 booting with DT ever worked.
> > > >>>>>
> > > >>>>
> > > >>>> For nios2, in early_init_devtree():
> > > >>>>
> > > >>>> void __init early_init_devtree(void *params) { __be32 *dtb =3D (=
u32
> > > >>>> *)__dtb_start; ...  if (be32_to_cpu((__be32) *dtb) =3D=3D OF_DT_=
HEADER)
> > > >>>> params =3D (void *)__dtb_start;
> > > >>>>
> > > >>>> That worked fine until this patch. Starting with this patch,
> > > >>>> __dtb_start always points to a valid empty devicetree blob, whic=
h
> > > >>>> overrides the devicetree blob passed to early_init_devtree(). Th=
is
> > > >>>> causes the problem.
> > > >>>
> > > >>> With an external DTB, it doesn't boot with or without this patch.=
 It
> > > >>> just dies in different spots. Before it just skipped any memory
> > > >>
> > > >> No, that is incorrect.
> > > >
> > > > Well, I can tell you it doesn't boot for me. So I must be doing som=
ething
> > > > different from your setup.
> > > >
> > >
> > > Maybe you have OF_UNITTEST enabled and it indeed results in the probl=
em you
> > > mention below. I don't have it enabled because it produces various
> > > backtraces which would hide real problems.
> >
> > I thought of that, but I don't think I did. What I suspect is the exter=
nal
> > dtb is at address 0.

Testing again, I built 10m50_defconfig without modification and ran
qemu (from debian testing):

qemu-system-nios2 -dtb
build-nios2/arch/nios2/boot/dts/10m50_devboard.dtb -kernel
build-nios2/vmlinux --nographic

I had to enable CONFIG_NIOS2_PASS_CMDLINE (which really means pass
cmdline, dtb, and initrd from bootloader) and it works and regresses
as you report.

> > > >> Up to this patch it booted just fine with an external dtb using th=
e
> > > >> "-initrd" command line argument, and I explained to you above why =
this
> > > >> is the case.
> > > >
> > > > What does -initrd have to do with anything? Does that shift where t=
he
> > > > external dtb is placed or something?
> > > >
> > >
> > > Nothing. I meant to say -dtb.
> > >
> > > > I think I see the issue. __dtb_start points to the start of *all*
> > > > built-in DTBs, not a specific one. In this case, arc, csky, loongar=
ch,
> > > > mips, openrisc, riscv, sh, and xtensa may all be broken too (if one=
 picks
> > > > the magic combination of booting modes and kconfig options). I
> > >
> > > No.
> > >
> > > - arc only picks the internal dtb if use_embedded_dtb is true. This f=
lag is
> > > only set if there is no external dtb, or if the external dtb does not
> > > provide a valid machine description.
> >
> > Right, but when it does pick the internal dtb, it is expecting its dtb =
at
> > __dtb_start. What I'm saying is that's never been a good or safe assump=
tion.
> > We just happened to add another case to trigger it. The only reliable w=
ay to
> > get a built-in DTB is if foo.dtb is built-in, then use __dtb_foo_begin =
to get
> > its address. That's what some MIPS platforms with multiple DTBs do.
> >
>
> I may be missing something, but it seems to me that most if not all
> platforms with support for configurable built-in dtbs use __dtb_start
> to get its address.

That was my concern as that only points to the 1st DTB and nothing
prevents there being more than one. But I think link order saves all
of them after all.

> > > - openrisc only picks the internal dtb if no external dtb is provided=
  -
> > > riscv only picks the internal dtb if CONFIG_BUILTIN_DTB is enabled.  =
- sh
> > > only used the internal dtb if CONFIG_USE_BUILTIN_DTB is enabled.  - x=
tensa
> > > only picks the internal dtb if there is no external dtb.
> > >
> > > However, nios2 picks the internal dtb _even if_ an external dtb is pr=
ovided
> > > if there is an internal dtb. In other words, it prefers the internal =
dtb
> > > over the external dtb. All other architectures prefer the external dt=
b over
> > > the internal dtb.
> >
> > Thanks for the analysis. I had started and abandoned common support (mo=
stly
> > Kconfig options) for built-in dtbs years ago. I decided against it beca=
use it
> > is not something we want to encourage (as the boot dtb). In the meantim=
e,
> > we've gained new architectures that have added it. Sigh. So now I'm
> > reconsidering something common (though not for v6.9).
> >
> > >
> > > > would expect all these cases have been broken forever if the DT uni=
ttest
> > > > is enabled as it too adds a built-in dtb. But I would also
> > >
> > > Even if that is correct for nios2, that hardly seems to be an argumen=
t to
> > > break nios2 boot with external dtb unconditionally.
> >
> > That wasn't an argument for breaking it. Using an external dtb should r=
eally
> > be the default and strongly preferred though.
> >
> > I'm still not sure how to fix this easily for 6.9. Something like what
> > microblaze does which puts the boot dtb under a consistent symbol name.=
 Or
> > perhaps we could iterate thru the built-in dtbs and skip ones without
> > top-level compatible.
> >
>
> I did submit a patch to only override the external dtb if support for the
> internal dtb is enabled. I copied you on it, so you should have seen it.
>
> https://lore.kernel.org/linux-kernel/20240322065419.162416-1-linux@roeck-=
us.net/

Now reviewed, thanks. Sadly, I rarely see anything outside the normal
workflow of what I can filter out. I'm copied pretty much 1:1 with
what is sent to the DT list which is a fire hose.

Rob

