Return-Path: <linux-kernel+bounces-71945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88385ACDC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5111C2167A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57E53E27;
	Mon, 19 Feb 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+E0kHhs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6953E14;
	Mon, 19 Feb 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373598; cv=none; b=hG99hK8cswFwZLHYdYAYEEjSBHk7zULChJkKdvs/PO8vPk/v8lG+3J40mb7WmXYFKv3MgaFpoH7CyyERvn9wxy6Os+ggYovG74GhDjeaeFNUydJdhsxgZwZMYGP8ELUQCgSnd5z3B3ssivdiXdNlndX3eunMr2xgHGT2pM0Q6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373598; c=relaxed/simple;
	bh=tx/TfnzZDoT1xc33L7S2O95jgvmeHSm+n3Hd+KXFKug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NDXshKvqL6GqBXMhiKY+JGb3gfcO6S/H60J35jdQRbue727YIIe5amixIB6mlM5tgWCB/SlbL0wOuclJhIcedxAk6G56mmji/OoMIxgv+iRWcAIO0jJLaWmypixc4gyrCluTy0VG4G2bc9OSBLTAkCw50jFm3p1Jl7KmX8SWh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+E0kHhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBF4C433C7;
	Mon, 19 Feb 2024 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708373597;
	bh=tx/TfnzZDoT1xc33L7S2O95jgvmeHSm+n3Hd+KXFKug=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F+E0kHhsWnbpdV4fYP618TSw+he67latBuAV2MowUC+oXcBU04zMlV0vllkfTjbzD
	 up4tIWcbCqgtBx5Y4SMH9Jiz3mklIxyGJ3Wq+DnQtGHOvqAFhmtCl8F/XMnE6UeBuv
	 4HxhPuE3c3r36XHap/50FJsS+y4bFOR+/p0FfsR4PCrB3aSvPaXVPOOPaZrcVNq9hJ
	 ezE3QeHhjtclg5u7LcD5JttuEwHtJd7fo90Ixo4k9ah6T5o8bfh+T3ADLSg6/KqMF4
	 2qEKuogN4WkPrvMB5R2ND6KFAhzYxip/UdUQvxDZo5q1bBxAYs2aJolUX1cj3tLjYj
	 eptSBGVuhGtyA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 20:13:14 +0000
Message-Id: <CZ9BWAZ1GRZG.96ETQPKT8ER4@seitikki>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?utf-8?q?Re:_init=5Ftis()_takes_50_ms_on_Dell_XPS_13_9360_=E2=80=93_almo?= =?utf-8?q?st_10_%_of_whole_time_until_initrd?=
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.15.2
References: <0eba23c7-f62a-4a85-a383-60dec9d198f9@molgen.mpg.de>
 <CZ6UFX5R09DD.EWDFS24L16G1@seitikki>
 <512bdab4-1779-4407-aa7b-57d1af015fc1@molgen.mpg.de>
In-Reply-To: <512bdab4-1779-4407-aa7b-57d1af015fc1@molgen.mpg.de>

On Fri Feb 16, 2024 at 10:20 PM UTC, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Thank you for your reply.
>
> Am 16.02.24 um 23:07 schrieb Jarkko Sakkinen:
> > On Wed Feb 14, 2024 at 3:10 PM UTC, Paul Menzel wrote:
>
> >> Trying to optimize the boot time of Linux on the Dell XPS 13 9360,
> >> probing of MSFT0101:00 takes 52 ms, making `init_tis()` taking almost =
10
> >> % alone until starting the initrd:
> >>
> >>       [    0.000000] Linux version 6.8.0-rc4 (build@bohemianrhapsody.m=
olgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0,
> >> GNU ld (GNU Binutils for Debian) 2.42) #20 SMP PREEMPT_DYNAMIC Mon Feb=
 12 09:40:49 CET 2024
> >>       [=E2=80=A6]
> >>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06=
/02/2022
> >>       [=E2=80=A6]
> >>       [    0.320057] calling  init_tis+0x0/0x100 @ 1
> >>       [    0.332190] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev=
-id 4)
> >>       [    0.372164] probe of MSFT0101:00 returned 0 after 52101 usecs
> >>       [    0.372186] initcall init_tis+0x0/0x100 returned 0 after 5212=
7 usecs
> >>       [=E2=80=A6]
> >>       [    0.588643] Freeing unused decrypted memory: 2036K
> >>       [    0.589068] Freeing unused kernel image (initmem) memory: 397=
6K
> >>       [    0.606115] Write protecting the kernel read-only data: 22528=
k
> >>       [    0.606527] Freeing unused kernel image (rodata/data gap) mem=
ory: 276K
> >>       [    0.652327] x86/mm: Checked W+X mappings: passed, no W+X page=
s found.
> >>       [    0.652329] x86/mm: Checking user space page tables
> >>       [    0.695968] x86/mm: Checked W+X mappings: passed, no W+X page=
s found.
> >>       [    0.696104] Run /init as init process
> >>       [=E2=80=A6]
> >>
> >> For users, where boot time is most important, can this be moved out of
> >> the hot path somehow?
> >=20
> > It can't be IRQ probing as IRQ's are *disabled* by default. So we can
> > disclose that.
> >=20
> > I think the delay is caused by tpm2_probe(), which is called by
> > tpm_tis_core_init(). It sends an idempotent TPM2 command to the TPM
> > chip to know whether it is TPM 1.x or TPM2 chip.
> >=20
> > That detection is definitely required.
> >=20
> > Even some other subsystems in the kernel require to know the correct
> > TPM version, like hwrng and IMA.
> Understood. The TPM in my laptop does not change, so could this be=20
> cached, or does a Linux CLI paramater exist, that I can specify the versi=
on?

Oops, I totally ignored tpm_chip_register() which runs more TPM commands:

1. PCR alloction: tpm2_get_pcr_allocation()
2. self-test: tpm2_do_selftest()

(in some cases also tpm2_startup())

Just probe (a single trivial TPM command doing zero calcuation) causing
that long delay would not make sense, so sorry for misleading with this!

So the problem here is in-kernel clients of TPM that initialize during
the boot such as IMA and hwrng.

The call for tpm_chip_register() is in the tail of each chip driver,
i.e. it is in the "overall" framework and thus theoretically could be
relocated to a workqueue. This requires tho changes to all clients and
error code for the case where tpm_transmit() flushes this workqueue but
initialization fails.

So *I think* (was not fully scientifical feasibility study) it is
possible but it is not as small change as you would first think.=20

> Kind regards,
>
> Paul

BR, Jarkko

