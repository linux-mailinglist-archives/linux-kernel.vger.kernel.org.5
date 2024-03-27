Return-Path: <linux-kernel+bounces-121930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B15588EF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA78F29FE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B715250B;
	Wed, 27 Mar 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjKgV/Y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069464F208;
	Wed, 27 Mar 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569474; cv=none; b=TycPkHOA5aP/nuO5vLP0FYFJ0uA2WMJYddSoR4oiCZNi+CP+wYUj07a2rK6n+mFrw1pYE1AzNGsmlfwHZ0f+DE53USKRNdHsMTtyHliqnov7fox3xfyZqjeinqelJzUdwnG7c3DgOOLhNBujUSivqKrxCAu933yqHldl2WHsSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569474; c=relaxed/simple;
	bh=kQaIyV/SITVWU7gU2k5KiKhY1/EpXbcic9lKJWklJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwXNsm1+N9rJA6eDUT1nq/QaApkjgAkdoyckfb1OrRVWvIsxxdGylMrik4kGAA4MQU0uIjJWkegioeJUjdsq7SOM0EldCYhCFHc6yzM6LG/w3gOX1FReSkuP0GyLEe3D/Qyts0p2S7vaAA0dIkaxoiALpUoX8BYjoeFFh8Wy508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjKgV/Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C010C433C7;
	Wed, 27 Mar 2024 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711569473;
	bh=kQaIyV/SITVWU7gU2k5KiKhY1/EpXbcic9lKJWklJ3s=;
	h=From:To:Cc:Subject:Date:From;
	b=BjKgV/Y1KnzwEAn8i26H6x6YSgwOFvGI8U6rr91seII3072iYT1rtIQTp9P+JyAad
	 jM4okUlABJx5T6sdaHk/WKEvnrIoHfh1zPEUrWnKyL5tQbrvpHTZGGrIjc2rCPwBJT
	 f4BBdikWYHkBOGoFJHktXri46LZoFpCpubQqeOzt7HL15wzHFStVzMRpa2YXguEZ2S
	 bo7pXuX73R3D4tr5LlLrNu1SetCfpn9KJNK2/8QWvXTzwMQ8l9tYWZ9M2aHHK/KhzT
	 sDxHkbt+dd0fgXVOKCQDFUkfgXo51SiMMWUGuND3RcqvmXrHTl8biGAFMI6E839O6V
	 zL3JZlpOAF6mg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>, Samuel
 Holland <samuel.holland@sifive.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: RISC-V for-next/fixes (cont'd from PW sync)
Date: Wed, 27 Mar 2024 20:57:50 +0100
Message-ID: <87ttkro3b5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I figured I'd put some words on the "how to update the RISC-V
for-next/fixes branches [1]" that came up on the patchwork call today.

In RISC-V land, the for-next branch is used for features, and typically
sent as a couple of PRs to Linus when the merge window is open. The
fixes branch is sent as PR(s) between the RCs of a release.

Today, the baseline for for-next/fixes is the CURRENT_RELEASE-rc1, and
features/fixes are based on that.

This has IMO a couple of issues:

1. fixes is missing the non-RISC-V fixes from releases later than
   -rc1, which makes it harder for contributors.
2. for-next does not have the fixes from RISC-V/rest of the kernel,
   and it's hard for contributors to test the work on for-next (buggy,
   no fixes, and sometime missing deps).

I used to spend a whole lot of mine time in the netdev tree of the
kernel, and this is how they manage it (Thanks Kuba!):

Netdev (here exchanged to RISC-V trees), fast-forward fixes, and then
cross-merge fixes into for-next -- for every -rc.

E.g., say fixes is submitted for -rc2 to Linus, once he pulls, do:

  git push --delete origin $SOMETAG
  git tag -d $SOMETAG
  git pull --ff-only --tags git://git.kernel.org/pub/scm/linux/kernel/git/t=
orvalds/linux.git
  build / test / push out.

Then pull fixes into for-next:

  git pull --tags git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux=
git fixes


Personally (obviously biased), I think this would be easier for
contributors. Any downsides from a RISC-V perspective?


Bj=C3=B6rn


[1] git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git

