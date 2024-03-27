Return-Path: <linux-kernel+bounces-121350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2D88E696
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6291F30FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EEF15749C;
	Wed, 27 Mar 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+RBoB0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DF13A86C;
	Wed, 27 Mar 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545113; cv=none; b=g7z1SrU+xktTUoNsJG4qvvqx5NkHoOEYlYLxFfFO4H8sWqIDElgakopKsOCMvJXyqKZJZUZVOINIybUm84auic3DgYNaWERMYRHgUYPgGU5FLnqP6N8M+c5t5UB6uUUsTrUdnsciRJRt3SXhIBWUUqPj06UN2dgaOvtiJ2kvxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545113; c=relaxed/simple;
	bh=XBXByAYqKSi9l1Q3Qw0mS+NbNRa2h7UA7gV1ulJBMxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNPN/u0HT3hVjrdTUAllV+e/XnlfjksDYT4j2UVPzTWF7m7EtkX9BwDkxiezAzWySqD3k9xR0bBc5lyV+mh2zEmOvmguw3XBfiLzW412G4aSel20JUEjNJFWDX1YOcSMT6FCv9X8yehbdcGUdw1CISrG1Ssyzz4wWAgiRcEV3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+RBoB0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32C8C433C7;
	Wed, 27 Mar 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711545113;
	bh=XBXByAYqKSi9l1Q3Qw0mS+NbNRa2h7UA7gV1ulJBMxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+RBoB0QkHlFJQEYVM1iCcFV7qmmJU5OsY/BVDvcEn4tyszqN56uwuGTRL4dym3PG
	 72Ruh9XyRy4+ffC59YDbjOtTXBblmNYrVZpxD074dNK5Z3wvK8OrToCrtJ4oaJKGaO
	 iPjj0S/uyNbeKt9PaTnt9yrxNWpwyy6w2Rn4NIvl8mhxiMKIBIt/YZculQmrjLjaKR
	 bA6wZtQag5GywEYX5PZ3dQFPipOdnlvDBaILUX4g0cFyqcmstUu/YgGswj44tT2HOI
	 Niy7QTgptRRU3qU3NiwzMb3dZp97oQraPcKeMyBqtbnlsvcyWgK+PY9xJ38mlingEN
	 QoCDJ+wzPjrLQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513dd2d2415so7196973e87.3;
        Wed, 27 Mar 2024 06:11:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFfpmtubcjzHVjzn+ZnP6YesSkmZU4RYLFoYkHxXrh6L9KIuUu4C4iDsWk9Rajb7JK2CJoQVp510tMKiZsS2HXlqNq2KawAJNmlZjdycbkgIZ79ZYJhsN8e7nYKuYegUZWYt7di70UZQ==
X-Gm-Message-State: AOJu0YwBtQGLHRSQtze6wFOCvmnmo/x9QNHBhMl8ZunLMdeSvQqs2sCc
	txcS5KTaUurr1wnrAZNr2El43pJLWTayHCPM3QgBFMR/e9l0TR7f+zrC22MqxZ+u24nLT+uyH1H
	b3g5AI844gv00stNI43L9Rf1thQ==
X-Google-Smtp-Source: AGHT+IHe1DwmLJFbvUMV4rNFkOx8NRbsfkkQnTVJH81EDHWoxuzBfQJSW3+7yvbNnjj0T4pqDBFsJARlUwbjNs8lWaw=
X-Received: by 2002:ac2:5f99:0:b0:513:d3c0:f66 with SMTP id
 r25-20020ac25f99000000b00513d3c00f66mr1862899lfe.51.1711545111308; Wed, 27
 Mar 2024 06:11:51 -0700 (PDT)
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
 <23ed5bbb-7616-424b-96ee-3fe1c6d8ca89@roeck-us.net>
In-Reply-To: <23ed5bbb-7616-424b-96ee-3fe1c6d8ca89@roeck-us.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Mar 2024 08:11:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJd-upC4TgOwP5-DMXKL+x=X7sGC7qqiy2PTjD6pnSV7Q@mail.gmail.com>
Message-ID: <CAL_JsqJd-upC4TgOwP5-DMXKL+x=X7sGC7qqiy2PTjD6pnSV7Q@mail.gmail.com>
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

On Wed, Mar 20, 2024 at 3:06=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/20/24 12:14, Rob Herring wrote:
> > On Mon, Mar 18, 2024 at 4:31=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On 3/18/24 12:26, Rob Herring wrote:
> >>> +Stephen
> >>>
> >>> On Mon, Mar 18, 2024 at 12:09=E2=80=AFPM Guenter Roeck <linux@roeck-u=
s.net> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> >>>>> When enabling CONFIG_OF on a platform where of_root is not populate=
d by
> >>>>> firmware, we end up without a root node. In order to apply overlays=
 and
> >>>>> create subnodes of the root node, we need one. Create this root nod=
e
> >>>>> by unflattening an empty builtin dtb.
> >>>>>
> >>>>> If firmware provides a flattened device tree (FDT) then the FDT is
> >>>>> unflattened via setup_arch().  Otherwise setup_of(), which is calle=
d
> >>>>> immediately after setup_arch(), will create the default root node
> >>>>> if it does not exist.
> >>>>>
> >>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> >>>>
> >>>> This patch results in a crash on nios2.
> >>>
> >>> This patch was never applied. I assume you meant a later version of i=
t
> >>> that did get applied.
> >>>
> >>>>
> >>>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... run=
ning ...R failed (crashed)
> >>>
> >>> Booting with DT?
> >>>
> >>>> ------------
> >>>> qemu log:
> >>>> earlycon: uart8250 at MMIO32 0x18001600 (options '')
> >>>> printk: legacy bootconsole [uart8250] enabled
> >>>> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linu=
x-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT =
2024
> >>>> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed =
to allocate 72 bytes align=3D0x40
> >>>> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch=
: Failed to allocate 72 bytes align=3D0x40 ]---
> >>>
> >>> nios2 looks utterly broken to me. This change should be a nop unless
> >>> initial_boot_params is NULL. It looks like it is possible for r6 (dtb
> >>> address) to be 0 depending on kconfig options, but that would have
> >>> skipped copying and unflattening which would then panic in
> >>> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
> >>> early_init_dt_alloc_memory_arch() calls should fail when copying the
> >>> DT. So I don't see how nios2 booting with DT ever worked.
> >>>
> >>
> >> For nios2, in early_init_devtree():
> >>
> >> void __init early_init_devtree(void *params)
> >> {
> >>           __be32 *dtb =3D (u32 *)__dtb_start;
> >>          ...
> >>           if (be32_to_cpu((__be32) *dtb) =3D=3D OF_DT_HEADER)
> >>                   params =3D (void *)__dtb_start;
> >>
> >> That worked fine until this patch. Starting with this patch, __dtb_sta=
rt
> >> always points to a valid empty devicetree blob, which overrides the
> >> devicetree blob passed to early_init_devtree(). This causes the proble=
m.
> >
> > With an external DTB, it doesn't boot with or without this patch. It
> > just dies in different spots. Before it just skipped any memory
>
> No, that is incorrect.

Well, I can tell you it doesn't boot for me. So I must be doing
something different from your setup.

> Up to this patch it booted just fine with an
> external dtb using the "-initrd" command line argument, and I explained
> to you above why this is the case.

What does -initrd have to do with anything? Does that shift where the
external dtb is placed or something?

I think I see the issue. __dtb_start points to the start of *all*
built-in DTBs, not a specific one. In this case, arc, csky, loongarch,
mips, openrisc, riscv, sh, and xtensa may all be broken too (if one
picks the magic combination of booting modes and kconfig options). I
would expect all these cases have been broken forever if the DT
unittest is enabled as it too adds a built-in dtb. But I would also
expect that arch code gets linked first and link order would save us
here.

Rob

