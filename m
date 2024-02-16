Return-Path: <linux-kernel+bounces-69391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDC85885E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA241C211D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D71482FE;
	Fri, 16 Feb 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHcf8iEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830C1482E2;
	Fri, 16 Feb 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121236; cv=none; b=sOjyD/YDLOaV8c9Rt7IK2d0+GjdfP8oFtgCTyADsAOtt6T8YDinckpZoMjskTE3ztNJWkduKWqCFXQB4F+DvLmasNx6OHs8U25O7O9B7ayq5f/PKPtSzsdmMlKRW2kFAlOxT5CINq6F1PqFzkXUHeFQTPDzSiGd0oq2vR9fcmyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121236; c=relaxed/simple;
	bh=+WrPzJ0IHMh3HzYg25ZL+Q0ZSnq4HdHf5TMRtD3SA+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=n3SE0VPSFmMh4MUU3zRwT4EW0Wu2dhkb2exVTS+RvX+gjPm4kCEnB0EkS8wkOGTF+flbTvik448b46lgfdh9SQ2hJHg87pPyz6TtO9d47/WJm7fuSK4siIuR5P9FLgQuFeAaONPQcDhlN/LlzeBrPMwX7xiQo2PGTLRzg6QGR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHcf8iEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6717AC433F1;
	Fri, 16 Feb 2024 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708121235;
	bh=+WrPzJ0IHMh3HzYg25ZL+Q0ZSnq4HdHf5TMRtD3SA+E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mHcf8iENDeEqesopXo604iob41FqlmhMYSsDUn+8ZgIzk8opsK1BcBqjsR+/ddvzP
	 JIutE9y2hTJ4KxOlItbWgXdriaiaeajMwdGIb5WXdK2S8+jgYD/UAOy/GnxLJAqdQm
	 g6rgWCCYJ1wd89yVZ0fSMNnbDrz/t3sKpMFuTCGHoOo4fbACXYfj/w69FpHU3zZqrq
	 9PGkf2VQP9sXLrpJrsq4PwrlaDTTLMvvYP3sG1rU9Uwo7pxaOCzo53QRnrWime097h
	 6KdfrnX9S6cBp6qk5912HqoYM98GCrTyQr1a144i6ztg7YA8xdFR9KQbjjhHRv6D5H
	 ySXXejiH/wcVg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Feb 2024 22:07:12 +0000
Message-Id: <CZ6UFX5R09DD.EWDFS24L16G1@seitikki>
Subject: =?utf-8?q?Re:_init=5Ftis()_takes_50_ms_on_Dell_XPS_13_9360_=E2=80=93_almo?= =?utf-8?q?st_10_%_of_whole_time_until_initrd?=
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>, "Peter Huewe" <peterhuewe@gmx.de>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <0eba23c7-f62a-4a85-a383-60dec9d198f9@molgen.mpg.de>
In-Reply-To: <0eba23c7-f62a-4a85-a383-60dec9d198f9@molgen.mpg.de>

On Wed Feb 14, 2024 at 3:10 PM UTC, Paul Menzel wrote:
> Dear Linux folks,
>
>
> Trying to optimize the boot time of Linux on the Dell XPS 13 9360,=20
> probing of MSFT0101:00 takes 52 ms, making `init_tis()` taking almost 10=
=20
> % alone until starting the initrd:
>
>      [    0.000000] Linux version 6.8.0-rc4=20
> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0,=20
> GNU ld (GNU Binutils for Debian) 2.42) #20 SMP PREEMPT_DYNAMIC Mon Feb=20
> 12 09:40:49 CET 2024
>      [=E2=80=A6]
>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0=20
> 06/02/2022
>      [=E2=80=A6]
>      [    0.320057] calling  init_tis+0x0/0x100 @ 1
>      [    0.332190] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id =
4)
>      [    0.372164] probe of MSFT0101:00 returned 0 after 52101 usecs
>      [    0.372186] initcall init_tis+0x0/0x100 returned 0 after 52127 us=
ecs
>      [=E2=80=A6]
>      [    0.588643] Freeing unused decrypted memory: 2036K
>      [    0.589068] Freeing unused kernel image (initmem) memory: 3976K
>      [    0.606115] Write protecting the kernel read-only data: 22528k
>      [    0.606527] Freeing unused kernel image (rodata/data gap)=20
> memory: 276K
>      [    0.652327] x86/mm: Checked W+X mappings: passed, no W+X pages=20
> found.
>      [    0.652329] x86/mm: Checking user space page tables
>      [    0.695968] x86/mm: Checked W+X mappings: passed, no W+X pages=20
> found.
>      [    0.696104] Run /init as init process
>      [=E2=80=A6]
>
> For users, where boot time is most important, can this be moved out of=20
> the hot path somehow?

It can't be IRQ probing as IRQ's are *disabled* by default. So we can
disclose that.

I think the delay is caused by tpm2_probe(), which is called by
tpm_tis_core_init(). It sends an idempotent TPM2 command to the TPM
chip to know whether it is TPM 1.x or TPM2 chip.

That detection is definitely required.

Even some other subsystems in the kernel require to know the correct
TPM version, like hwrng and IMA.

> Kind regards,
>
> Paul

BR, Jarkko

