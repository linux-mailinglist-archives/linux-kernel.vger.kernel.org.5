Return-Path: <linux-kernel+bounces-125574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6A8928EE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213AF1F21D98
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC471C3D;
	Sat, 30 Mar 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zf7iLigK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A117CD
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766765; cv=none; b=Hzv1491AvBIamls9a44/8XfQiq7lNCP3Hxe01flXGCaSDzDA9kU0Xx/sjCfJMMaPP5tTisBUfgEDaWVG2okMwG/b30hJoYOndRCz7+HmMUcPgkQpOX+RF24JPuR9bo5KKViNxurqc2bxT2Wk++8P6tKP17B/ff7Ufv0mQwV3LZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766765; c=relaxed/simple;
	bh=lPHesGQ9ntzE76wd4G9UYsmxSrbSZgPjy+CBUxsph34=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K+3YKYp2TRjMhkiNri/5Wt1CEksR7Pv9nvV2iFhcHPllL/Fi/TXY9GiceEJrN3yCVw2qNdpNTB/CMTn3FulUb1YuuLLjULozuY6GyDMMNvUKt+aCvsbEV6F3xR8675ldwUFG3/KrGorYwERVhnHvGSVmuVZSvs7rHQ+HlQERLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zf7iLigK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5D0C433F1;
	Sat, 30 Mar 2024 02:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711766764;
	bh=lPHesGQ9ntzE76wd4G9UYsmxSrbSZgPjy+CBUxsph34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zf7iLigKYS7qLOxRZfVxsSIYIs31bu3QCArnvVmpkgU99N4mj8Rd9GP9yMYMNbl/b
	 +9LwMuecnNK8rFH5GUxiE+nAOakusuaM7yM38FZs5zfQGpMRajY5Am2/+PmKxCvFBN
	 fevs0A3M6VW6+9GiFdcSjwpy36DU6cNy8BnXDVn4=
Date: Fri, 29 Mar 2024 19:46:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nathan Royce <nroycea+kernel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Allmodconfig - logic_outb - Boot Panic
Message-Id: <20240329194603.ed67a334f75ba3c933cc8876@linux-foundation.org>
In-Reply-To: <CALaQ_hrVM0dMaFqLshW5NTkkomGSvGnpyLOPx8E0QpniewyxUA@mail.gmail.com>
References: <CALaQ_hrVM0dMaFqLshW5NTkkomGSvGnpyLOPx8E0QpniewyxUA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 13:38:08 -0500 Nathan Royce <nroycea+kernel@gmail.com> wrote:

> [  119.456901][    T1] Call trace:
> [  119.457377][    T1]  logic_outb+0x6c/0x140
> [  119.458155][    T1]  isapnp_wait+0x34/0x80
> [  119.458849][    T1]  isapnp_isolate_rdp_select+0x38/0x240
> [  119.459818][    T1]  isapnp_isolate+0x58/0x340
> [  119.460567][    T1]  isapnp_init+0x1ec/0x480
> [  119.461263][    T1]  do_one_initcall+0x1e0/0x900
> [  119.462061][    T1]  do_initcall_level+0x118/0x204
> [  119.462974][    T1]  do_initcalls+0xb4/0x180
> [  119.463632][    T1]  do_basic_setup+0xa0/0xc0
> [  119.464421][    T1]  kernel_init_freeable+0x2b0/0x500
> [  119.465282][    T1]  kernel_init+0x3c/0x37c
> [  119.466081][    T1]  ret_from_fork+0x10/0x40
> [  119.466777][    T1] Code: d50332bf f2df7fe8 f2ffffe8 8b080268 (39000114)
> [  119.467808][    T1] ---[ end trace 0000000000000000 ]---
> [  119.468585][    T1] Kernel panic - not syncing: Oops: Fatal exception
> [  119.469539][    T1] SMP: stopping secondary CPUs
> [  119.470327][    T1] Kernel Offset: disabled
> [  119.470991][    T1] CPU features: 0x0,c0000000,7002814a,2101720b
> [  119.471862][    T1] Memory Limit: none
> [  119.472529][    T1] ---[ end Kernel panic - not syncing: Oops: Fatal

Could be that the logic_pio driver is crashing when the hardware isn't there.

