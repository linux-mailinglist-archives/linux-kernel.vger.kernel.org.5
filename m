Return-Path: <linux-kernel+bounces-121839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153688EE61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E191F23A86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98915150982;
	Wed, 27 Mar 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy3zhxN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB99131BB7;
	Wed, 27 Mar 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564709; cv=none; b=DKhkVtfzUOAD4V4GxzQwWqjfXTfYgLAVkRsDvnoV84oVRuvLKMLAgByWX2oDid2IzBj6VyCaT5p1gDJhJnut/E2pILwmJyiwy5Xl7cutekAI4KgGH9UzH6eeq3hafm/M0KoTJ41SMfs+HuBOGAV16zd+GF8fvai+4YvP0JpBveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564709; c=relaxed/simple;
	bh=KgM0Be4UlmnR5fOPyHIa8AJGd2RzwvmUTfV9COgyBV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5mvW2FBnTLJ9efcwk5SMb9LDoOIh8AmKsz3p8sUatVEn9Sg8yy62PWqNlOMWfvGRhQVbmXNxZ3L3njI4Q4ymmKfwslsN9LVgTX1ZPb/+TNEcBadUy6ZxEPtPrNC9fsPRa6YolRU+g4QgBtNJ2DOzb4Izbgwb9UP+FUcsx5q7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy3zhxN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32142C43390;
	Wed, 27 Mar 2024 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711564709;
	bh=KgM0Be4UlmnR5fOPyHIa8AJGd2RzwvmUTfV9COgyBV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oy3zhxN7oHwS6aVPED2B2tic9Mpx2q1S0DxMNLULWgO4dlwyk75Sfsh/tmaXPgKfb
	 3qrM+ak/rKvf/QuTxUAWUcdpnJoHGMMMw1L7r5diW3UrG0/tKXbGEocNMDAUA/mCuw
	 cbAIgaHlItpZK5XiD4OR0CjauOYsLXKO81wVwt74NTvZihprAbzvcNaEQvzeeb1z5t
	 5WCCYJpHJewdZCXW3IpiGk9Er/jz5I+LDftm+u9PyFlH3unT8rZv7V6gLwgoKc1jty
	 RHn/nx2fj+8tx8iQkSnXdV6m0yt6RnaxDybzbe1xKgj4SWHB4GcGnexaNIblAPc0p2
	 dnEEvJgNK7X8Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a97846b5so59059e87.2;
        Wed, 27 Mar 2024 11:38:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJxp5VFKzVaFe9uuXX+iACXZ1/J3VBl17rK9E4ESrizdBrt07nHVSeu8+e4E9lQCrLIzs+IOscTGYgzci7nG0LT28LnfZt/0ZrlT1wQhGdAJwkkB/f0Y1fMGX8qLLypyqm0ktnsJANNQ==
X-Gm-Message-State: AOJu0YyylgLkPUKY16gR1LtJFvNdWxugTaqWvQXfVSC/L8oY6Bpi+4lS
	zwITkvygzPvqjud87zCVMn3vOpqE1RPRzVtkZ7BrmY9P35fVTy6N0WTXSQprBT4pKFDgyrknPbc
	cCAwFGvwMYG35mIUWLcMCtZKFnw==
X-Google-Smtp-Source: AGHT+IEmic5Ou4QgBwmLCOvIwIw4VlAXkIQX74r/YTEdTe9CSv0F346hYh3rIrRhLEPzIpmHxsFfIIXFS3YjHZI/e38=
X-Received: by 2002:ac2:5e32:0:b0:513:d1b6:6f0e with SMTP id
 o18-20020ac25e32000000b00513d1b66f0emr176749lfg.36.1711564707391; Wed, 27 Mar
 2024 11:38:27 -0700 (PDT)
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
 <407867d2-2e32-4df4-96ac-f9ae84b44375@roeck-us.net>
In-Reply-To: <407867d2-2e32-4df4-96ac-f9ae84b44375@roeck-us.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Mar 2024 13:38:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2DijyKa-WSWdOszZt9UfQbb1MnD2zHh3ywntx6a=N+w@mail.gmail.com>
Message-ID: <CAL_JsqJ2DijyKa-WSWdOszZt9UfQbb1MnD2zHh3ywntx6a=N+w@mail.gmail.com>
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

On Wed, Mar 27, 2024 at 9:40=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/27/24 06:11, Rob Herring wrote:
> > On Wed, Mar 20, 2024 at 3:06=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On 3/20/24 12:14, Rob Herring wrote:
> >>> On Mon, Mar 18, 2024 at 4:31=E2=80=AFPM Guenter Roeck <linux@roeck-us=
net> wrote:
> >>>>
> >>>> On 3/18/24 12:26, Rob Herring wrote:
> >>>>> +Stephen
> >>>>>
> >>>>> On Mon, Mar 18, 2024 at 12:09=E2=80=AFPM Guenter Roeck <linux@roeck=
-us.net> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> >>>>>>> When enabling CONFIG_OF on a platform where of_root is not popula=
ted by
> >>>>>>> firmware, we end up without a root node. In order to apply overla=
ys and
> >>>>>>> create subnodes of the root node, we need one. Create this root n=
ode
> >>>>>>> by unflattening an empty builtin dtb.
> >>>>>>>
> >>>>>>> If firmware provides a flattened device tree (FDT) then the FDT i=
s
> >>>>>>> unflattened via setup_arch().  Otherwise setup_of(), which is cal=
led
> >>>>>>> immediately after setup_arch(), will create the default root node
> >>>>>>> if it does not exist.
> >>>>>>>
> >>>>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> >>>>>>
> >>>>>> This patch results in a crash on nios2.
> >>>>>
> >>>>> This patch was never applied. I assume you meant a later version of=
 it
> >>>>> that did get applied.
> >>>>>
> >>>>>>
> >>>>>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... r=
unning ...R failed (crashed)
> >>>>>
> >>>>> Booting with DT?
> >>>>>
> >>>>>> ------------
> >>>>>> qemu log:
> >>>>>> earlycon: uart8250 at MMIO32 0x18001600 (options '')
> >>>>>> printk: legacy bootconsole [uart8250] enabled
> >>>>>> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-li=
nux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PD=
T 2024
> >>>>>> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Faile=
d to allocate 72 bytes align=3D0x40
> >>>>>> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_ar=
ch: Failed to allocate 72 bytes align=3D0x40 ]---
> >>>>>
> >>>>> nios2 looks utterly broken to me. This change should be a nop unles=
s
> >>>>> initial_boot_params is NULL. It looks like it is possible for r6 (d=
tb
> >>>>> address) to be 0 depending on kconfig options, but that would have
> >>>>> skipped copying and unflattening which would then panic in
> >>>>> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
> >>>>> early_init_dt_alloc_memory_arch() calls should fail when copying th=
e
> >>>>> DT. So I don't see how nios2 booting with DT ever worked.
> >>>>>
> >>>>
> >>>> For nios2, in early_init_devtree():
> >>>>
> >>>> void __init early_init_devtree(void *params)
> >>>> {
> >>>>            __be32 *dtb =3D (u32 *)__dtb_start;
> >>>>           ...
> >>>>            if (be32_to_cpu((__be32) *dtb) =3D=3D OF_DT_HEADER)
> >>>>                    params =3D (void *)__dtb_start;
> >>>>
> >>>> That worked fine until this patch. Starting with this patch, __dtb_s=
tart
> >>>> always points to a valid empty devicetree blob, which overrides the
> >>>> devicetree blob passed to early_init_devtree(). This causes the prob=
lem.
> >>>
> >>> With an external DTB, it doesn't boot with or without this patch. It
> >>> just dies in different spots. Before it just skipped any memory
> >>
> >> No, that is incorrect.
> >
> > Well, I can tell you it doesn't boot for me. So I must be doing
> > something different from your setup.
> >
>
> Maybe you have OF_UNITTEST enabled and it indeed results in the
> problem you mention below. I don't have it enabled because it produces
> various backtraces which would hide real problems.

I thought of that, but I don't think I did. What I suspect is the
external dtb is at address 0.

> >> Up to this patch it booted just fine with an
> >> external dtb using the "-initrd" command line argument, and I explaine=
d
> >> to you above why this is the case.
> >
> > What does -initrd have to do with anything? Does that shift where the
> > external dtb is placed or something?
> >
>
> Nothing. I meant to say -dtb.
>
> > I think I see the issue. __dtb_start points to the start of *all*
> > built-in DTBs, not a specific one. In this case, arc, csky, loongarch,
> > mips, openrisc, riscv, sh, and xtensa may all be broken too (if one
> > picks the magic combination of booting modes and kconfig options). I
>
> No.
>
> - arc only picks the internal dtb if use_embedded_dtb is true. This flag
>    is only set if there is no external dtb, or if the external dtb does
>    not provide a valid machine description.

Right, but when it does pick the internal dtb, it is expecting its dtb
at __dtb_start. What I'm saying is that's never been a good or safe
assumption. We just happened to add another case to trigger it. The
only reliable way to get a built-in DTB is if foo.dtb is built-in,
then use __dtb_foo_begin to get its address. That's what some MIPS
platforms with multiple DTBs do.

> - openrisc only picks the internal dtb if no external dtb is provided.
> - riscv only picks the internal dtb if CONFIG_BUILTIN_DTB is enabled.
> - sh only used the internal dtb if CONFIG_USE_BUILTIN_DTB is enabled.
> - xtensa only picks the internal dtb if there is no external dtb.
>
> However, nios2 picks the internal dtb _even if_ an external dtb
> is provided if there is an internal dtb. In other words, it prefers
> the internal dtb over the external dtb. All other architectures
> prefer the external dtb over the internal dtb.

Thanks for the analysis. I had started and abandoned common support
(mostly Kconfig options) for built-in dtbs years ago. I decided
against it because it is not something we want to encourage (as the
boot dtb). In the meantime, we've gained new architectures that have
added it. Sigh. So now I'm reconsidering something common (though not
for v6.9).

>
> > would expect all these cases have been broken forever if the DT
> > unittest is enabled as it too adds a built-in dtb. But I would also
>
> Even if that is correct for nios2, that hardly seems to be an argument
> to break nios2 boot with external dtb unconditionally.

That wasn't an argument for breaking it. Using an external dtb should
really be the default and strongly preferred though.

I'm still not sure how to fix this easily for 6.9. Something like what
microblaze does which puts the boot dtb under a consistent symbol
name. Or perhaps we could iterate thru the built-in dtbs and skip ones
without top-level compatible.

Rob

