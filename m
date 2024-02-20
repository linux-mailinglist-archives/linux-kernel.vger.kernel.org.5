Return-Path: <linux-kernel+bounces-73563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DDB85C435
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C0E283AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DE13341C;
	Tue, 20 Feb 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ob0OLPq9"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256976A01C;
	Tue, 20 Feb 2024 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455769; cv=none; b=id4r+GTSaQun7X3rRAntscTYVirc2WFL13TYoLKMwOs/P2lF512FxVCcCtfXbiIKNz2TUbCczY6xXZn4Vtlvw8CeSoLofcpefu7ztyE4wehVz4Kou683G5pZbq6SVcWRlB50VGJxuMJVlMbknvku+ssQ/XD6o3uUMddsLskdgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455769; c=relaxed/simple;
	bh=0wMgfcHkV+wa3PtUAYHIw6wHNN7TD9iunGuwyjtWmRo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OYuPUIN/sKs56Pr9l99i1Myj3efEqwUfJqwP6nzYb0yq0w3JofWKOZswaNxayZstW6yD0p0b/o7TwsoKtillgSXtWD00Sgk/NM5y79EBW9WGH0Q0LTb4wCrjk4FMCLsKqC2FLnV9xs9eoDRyVIv2a+nMiWPuFwaJsZPRTFjIUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ob0OLPq9; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708455752; bh=u7KHD7RG1W+C5tk/BT6KiPSWci7A42fZiVpBZLG4M2Q=;
	h=From:To:Cc:Subject:Date;
	b=Ob0OLPq9XFKCzbeaXKVjHV8blgDS3ddNJujPtWrDr5FB+7hGAeuLRjXwI2H9GVUiz
	 mURadnzhjer/EHqm7VZnwblxN4luPE+KfVE1quFlrFosi4Y1jhmyu8AA7Uf9J2ojPp
	 cSJCDridODME6QSqWAiHEmXFGsTuuvsSDUyf92K0=
Received: from cyy-pc.lan ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 87A7667; Wed, 21 Feb 2024 03:02:07 +0800
X-QQ-mid: xmsmtpt1708455727tbv094zbu
Message-ID: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
X-QQ-XMAILINFO: NYdHd+5EbUy1IztpfkAF9XOfYQ2NVGTyri3rjQSIy/snEhaonuY3QLUJufgv6v
	 i0sVwFO2yVlC0yzQLvN5XohOm2ODbp+JZWvB0sReiCQU9AHq8wVnqtGq6dDYUCWEDunbiLR6QcKY
	 JrSJuMWeWtOtcTzVtPFIGPeMGujjltZoBzE1/jfe7MEhEpg31EL9cpryD6B5pqzdJLSLWw2f8xMv
	 cwEfocgIzTMScbXZNItQv11F9yGw5xGZp5Jin8ZiED4IgcFnzo+zD2yisTSqVdyAkT2OZSlaxaGA
	 vdaciIrghLbTCm1opuuAQAyEXNLSxcfJApzsxr5rtipTVBtuNOiGKgPvxnzjr+8Tyzj6T/BHtuXW
	 d1YRwWDfK39GiLIike7/gSDwecJCJ7ZAMzXhrEw6Pp3bmrp3nYVEJF5lLv/BiQ8RPWHTENz0mEG0
	 V17rYYCpBeIVPjUwoJNeilvfQ8bitThMobmE3Te3ZWOrI04OGkTLygc5cjxxxQDlVYNSMM+cEHve
	 iVx+P5N4d/uXufURiD1ZnS5gvZZVARZLldNDaaxiqWb/jE0e7qVZuS+xg30PqVi+itKaA/rRgm93
	 E2j4Zc/CPCL78E8pyjij/7baNbu0v7eHjolhFgE5UDE82K15E/eHvTlWT9aWytqDeQoyriD+rdfL
	 J/feLH60fE6PuUR1uwSNrTOuANgmTj73Ldv8PGVTj4tO+JgCcH7yMIv4OD8CY3/dgqU/VWlHJp2G
	 JE9vqgjq4m+kS69Hhd8Yj0IZIevXDTNAwc3kQ087UF5SbYpUa5ZkSMmZrnawYu4/31yNTcKaE1fi
	 5ksrhME0UajffWdSVHvHABXd/YuT+3eBQMBSrxUli1wtxLplB37Nrq2Sz5/+9dqUQnHwxNhasySH
	 7+89ze/GCe2V5V67pMOtERtNyMBW45jwMij5MD0M23PvwULpni115jxI6aZER8CQcT2gazI4FLEY
	 MhmiXySCUt+bKcr9osQEbVBJGEKHsj+Mrg5einmD1g2kR1ddqL3oAB+mVyveK2CnHQsRG2mPUoWG
	 VHnK2IxT78Lya67o6P
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
Date: Wed, 21 Feb 2024 03:01:53 +0800
X-OQ-MSGID: <20240220190153.3390862-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
patch moved this configuration to entire riscv.

Although BUILTIN_DTB is not a good choice for most platforms, it is likely
to be a debug feature when some bootloader will always override something
like the memory node in the device tree to adjust the memory size from SPD
or configuration resistor, which makes it hard to do some debugging. As an
example, some platforms with numa like sg2042 only support sv39 will fail
to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we want
a kernel without this patch to boot, we need to write the memory nodes 
in the DT manually.

Also, changing DT on some platforms is not easy. For Milk-V Pioneer, the
boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
changed, OpenSBI or LinuxBoot may refuse to boot. And there is some bug on
LinuxBoot now which does not consume --dtb argument on kexec and always
uses DT from memory. So I would like to do debugging on DT using
BUILTIN_DTB, which makes it very simple, I can even install the kernel in
the distro's way and provide a kernel package for other users to test.

Yangyu Chen (1):
  riscv: dts: Allow BUILTIN_DTB for all socs

 arch/riscv/Kconfig                  | 16 ++++++++++++++-
 arch/riscv/Kconfig.socs             | 32 -----------------------------
 arch/riscv/boot/dts/Makefile        |  2 +-
 arch/riscv/boot/dts/canaan/Makefile |  2 --
 4 files changed, 16 insertions(+), 36 deletions(-)

-- 
2.43.0


