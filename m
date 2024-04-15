Return-Path: <linux-kernel+bounces-144758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5F8A4A47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF2D282EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAE374DD;
	Mon, 15 Apr 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAFcypxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACC2263E;
	Mon, 15 Apr 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169604; cv=none; b=h2Y5K1yBbxgEQfB7cwVC5IRKJjqA/RyMW2QhlbK3yTcLyNeKwdHYKRcPK5YpIGmzjlW3tFOEXtt71nIUsf5M6PlAl8v1A80DLh1mmcjLoQy12zy7+qvK2pjwnNf1Bktv0MreYNl0bOX66az38CuC0xbA1Gp3Wx09ChgR4bTMM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169604; c=relaxed/simple;
	bh=MjLBp0N6mmnQA2FAHAYISyBAt+ExxDWZcdo0cnNQioo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WjgAaCRNnVMlasHhVYFAbZV6loFLc5rUjtvgL7qDsBIlCh+vSHG+eba9d/5xhpGFW12pLTl8PkybRXQwH5mQixfSsUqTSi0+pajTPv+B/uawfS7ZpGOm7/1dlXaGcLucYC4zNJqKJ+XXzElZ0whnmBUwGCQ5SjE+B60V23K8dpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAFcypxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6A8C113CC;
	Mon, 15 Apr 2024 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713169603;
	bh=MjLBp0N6mmnQA2FAHAYISyBAt+ExxDWZcdo0cnNQioo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=XAFcypxZVhY6JS/MvwSM4eiNZ0NnyNDzc/qvtCHlabo//I2qHhEsUPBRsYnHp6Okq
	 rnz6wc64AeleLQISJs9CoYA4rTWJO60m42CYEkSrhZdunZ+//IqaTMtNKdY8VYdgPi
	 5RMmYoM2xeQXmOebMQNT0WRiLXkpOQqdetY3b0KwY1dD5Yq2oOJHB3pAifVoKSDbJc
	 8kYiCTvNCPMlVFeElY3PuTXIrnNBSI69/TE3YkM7xqUTqOpXzwsXesuzwFb2ZZzv1K
	 gdA6Z76/7VmWfJ5TvaLcYGcmC+/ruz+jp0ussZ3bkSza6ibxEBWppGzUdZMKZo8yzT
	 OtGNEY7DV9/UQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [kpsingh:static_calls] [security]  9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <202404151225.ce542e38-lkp@intel.com>
Date: Mon, 15 Apr 2024 10:26:39 +0200
Cc: oe-lkp@lists.linux.dev,
 lkp@intel.com,
 Casey Schaufler <casey@schaufler-ca.com>,
 Kees Cook <keescook@chromium.org>,
 Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
References: <202404151225.ce542e38-lkp@intel.com>
To: kernel test robot <oliver.sang@intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 15 Apr 2024, at 07:30, kernel test robot <oliver.sang@intel.com> =
wrote:
>=20
>=20
>=20
> Hello,
>=20
> kernel test robot noticed =
"Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots" =
on:
>=20
> commit: 9e15595ed016dc9b726b7b13ec3d9b92b9e53c68 ("security: Replace =
indirect LSM hook calls with static calls")
> https://git.kernel.org/cgit/linux/kernel/git/kpsingh/linux.git =
static_calls
>=20
> in testcase: boot
>=20
> compiler: clang-17
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m =
4G
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
> =
+-----------------------------------------------------------------------+-=
-----------+------------+
> |                                                                      =
 | e2f2a7e74d | 9e15595ed0 |
> =
+-----------------------------------------------------------------------+-=
-----------+------------+
> | =
Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots | =
0          | 12         |
> =
+-----------------------------------------------------------------------+-=
-----------+------------+
>=20

This seems like an odd config which does not enable STATIC_CALL, I am =
going to make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the =
dependency explicit.

- KP



>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: =
https://lore.kernel.org/oe-lkp/202404151225.ce542e38-lkp@intel.com
>=20
>=20
> [    1.020355][    T0] x86/fpu: xstate_offset[2]:  576, =
xstate_sizes[2]:  256
> [    1.020966][    T0] x86/fpu: Enabled xstate features 0x7, context =
size is 832 bytes, using 'standard' format.
> [    1.022632][    T0] Freeing SMP alternatives memory: 32K
> [    1.023145][    T0] pid_max: default: 32768 minimum: 301
> [    1.025772][    T0] LSM: initializing lsm=3Dcapability,ima
> [    1.027282][    T0] Kernel panic - not syncing: =
lsm_static_call_init - Ran out of static slots.
> [    1.028283][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        =
        T  6.9.0-rc1-00003-g9e15595ed016 #1
> [    1.028948][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    1.028948][    T0] Call Trace:
> [ 1.028948][ T0] dump_stack_lvl =
(kbuild/src/consumer/lib/dump_stack.c:116)=20
> [ 1.028948][ T0] ? vprintk =
(kbuild/src/consumer/kernel/printk/printk_safe.c:?)

[...]


