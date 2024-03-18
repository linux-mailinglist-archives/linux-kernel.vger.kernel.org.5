Return-Path: <linux-kernel+bounces-106567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A950287F067
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A256BB223C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418356776;
	Mon, 18 Mar 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4cfOkSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7355C16;
	Mon, 18 Mar 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789976; cv=none; b=sKlCS1lWCTGQW5RnroUUSz0s04e8kVzb9vRrwdIHUAbgfsIpxnYF2cCWAubecA70GQ+7RHn4+eUgjNUFxeQBIJp6zMLfzo0A/D6/kwgfgdza9c5KfFbqSxm79vXxW93AtLAbp5FkPqjnlpzx6k/6JASTlmDpLBl4NC7FlGC7WUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789976; c=relaxed/simple;
	bh=B9cHjklwp//90eTgPE4lPF1npWGSNbsYf3Z3cSRgIoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5telI1MR5GKRDrTf4Cv8ctN7P1UqplFpG4JTxQ6rpVkGewHNUJVVrbh6fGHr+cB2t/GOjRxh8lWtglDhO+zNJND2UAjzgERJu0qS2c0EhADBBTku8m5wZ6nbwECFguOTMSaSIpG22hXYwEtalLfvaZkoHX4d1TLFsGgtgAYdTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4cfOkSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BAEC43390;
	Mon, 18 Mar 2024 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710789976;
	bh=B9cHjklwp//90eTgPE4lPF1npWGSNbsYf3Z3cSRgIoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W4cfOkSy7U2v6dpwFPLE99cM8xBNgqMF7rA6sHAkOEmNzgKM+Z1sLYuNZOzzzU4VX
	 ztB29OcNzVeO54jqWQYFTVeHQJp/ub5KN6SOuIVN8SSwNhxo8xF2nJf9yG4x4IJz+V
	 XNk8Sg8sGsANsEdTdAMDuik2IxG5l1j+Tu5cwIHdOTAzOeAIiNMwKg1jRi+Ww4qbOT
	 AFivVosj4ybOJjTc1Eji72XrbEsleLIEYnzpDqH/NxM80UQfreP+cyu5ji0JFST1x6
	 1ZcfvM4ZMSPSihx2kouP0reYMyKSi/8eAmzJPCJ7L7of4AK6zm3qK8tjFF6yMS3Wfa
	 QJhhZfyZW5WBQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513dc9d6938so3784050e87.2;
        Mon, 18 Mar 2024 12:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuLCNGBbEDh9bUF6xL2lSjQFN99FgZHCUSU9a2quvSrfFOhAX4CrZFYzziwDj9njG8eMLnZxlclUaYilgkkGLbJT8yfp/vA7c22usdhztLTUpYOo5iPeVj1Ad6htoLClDJc9WP3urP4w==
X-Gm-Message-State: AOJu0Yxh1ePYG6typV74xeTmeI3AdGAHay+DEiXGWqBKK4ngYwmCOrFS
	AtOBY8CP/Z2oLyX8V+AvWwcHdNS8EYW1ORVqZCR1ixGwoF6gxwJmqxIT/+WXlunhXj5sJt9wICO
	sVmzicCB/IYVDK/mghObYt4JELA==
X-Google-Smtp-Source: AGHT+IGj+OI0YXoPBlpOkSTh1OagxpY9ZORVr9LEgdvaU7YSx4uoUDyg9uWzIjYFZhWE5JBvS/EQbnIWbMp2xoT3/xo=
X-Received: by 2002:a05:6512:28c:b0:513:cadf:ef0c with SMTP id
 j12-20020a056512028c00b00513cadfef0cmr8747490lfp.18.1710789974630; Mon, 18
 Mar 2024 12:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com> <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
In-Reply-To: <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 18 Mar 2024 14:26:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
Message-ID: <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
To: Guenter Roeck <linux@roeck-us.net>, Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lizhi Hou <lizhi.hou@xilinx.com>, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Stephen

On Mon, Mar 18, 2024 at 12:09=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> Hi,
>
> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> > When enabling CONFIG_OF on a platform where of_root is not populated by
> > firmware, we end up without a root node. In order to apply overlays and
> > create subnodes of the root node, we need one. Create this root node
> > by unflattening an empty builtin dtb.
> >
> > If firmware provides a flattened device tree (FDT) then the FDT is
> > unflattened via setup_arch().  Otherwise setup_of(), which is called
> > immediately after setup_arch(), will create the default root node
> > if it does not exist.
> >
> > Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>
> This patch results in a crash on nios2.

This patch was never applied. I assume you meant a later version of it
that did get applied.

>
> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... running =
..R failed (crashed)

Booting with DT?

> ------------
> qemu log:
> earlycon: uart8250 at MMIO32 0x18001600 (options '')
> printk: legacy bootconsole [uart8250] enabled
> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc=
 (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 2024
> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to al=
locate 72 bytes align=3D0x40
> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Fai=
led to allocate 72 bytes align=3D0x40 ]---

nios2 looks utterly broken to me. This change should be a nop unless
initial_boot_params is NULL. It looks like it is possible for r6 (dtb
address) to be 0 depending on kconfig options, but that would have
skipped copying and unflattening which would then panic in
setup_cpuinfo(). If initial_boot_params is not NULL, then the same
early_init_dt_alloc_memory_arch() calls should fail when copying the
DT. So I don't see how nios2 booting with DT ever worked.

Rob

