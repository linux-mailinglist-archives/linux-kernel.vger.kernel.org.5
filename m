Return-Path: <linux-kernel+bounces-60338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C693C85035C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8923A2857DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722F2B9D0;
	Sat, 10 Feb 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="BHyKVslw"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9E288B0;
	Sat, 10 Feb 2024 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551231; cv=none; b=tzZ1TPoajkAhw3sewlQuWPe7FFpgA/SSTK7kSgw8ESP5LfASNRnAPdUvagxFQLfTmKwHo2c+UlK8XmEKOyC3ecPoxt6xjQaglTN98hnQmLqlFNMmJfegHTONgHX9JEfFAwRykaqNnzul4zq3/9HWtZyS8CVsljf4hf+WZyiHhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551231; c=relaxed/simple;
	bh=JON8F2LhEpKeCfNUzxa5Cw3iz9OiKleIBXDTxpGM5Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4AGlXHYX4uXuXDhxVlxtrAntn7oRmie1totdIR7AQK+oVdncRNBKpRSLfVP9OSGfNhrCUxXD8JZFg/gy6N1igj2U3JcnjtmyHeKeh3qbgR4w6nAolwX8TVzVHo6hKYCMpuU496BrrES41EVHfD/2CMSC12Lhrg4z/a3c1MkS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=BHyKVslw; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id EC9A538A0669;
	Sat, 10 Feb 2024 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1707551218; bh=B10Vnlot+2ilvHh7OCvlmhyXD6mosKAEgX9C4cq3ecg=;
	h=From:To:Cc:Subject:Date:From;
	b=BHyKVslwdL2RbJki6trr7V1cE+cbklBCioJup0TiYv412ptDhgE2fjt9lYE/d/fFA
	 Cz1w+6hkQ8cXPkGa1zFHBj5Weha9RyeoQClD5I+GyKxk4wlSFDcW+myI/UlJVWNIG9
	 hmKB2RkGQRDC4zEGXZENTHKaAQiISqv7dY7Ua+QI3j+OLEUs50+gi4SYvb+FLTicGh
	 rrnQvy+DDOQX66lzlVh7+KRjVTyhgRUnadkv0y0oty+cgAr9g7iMjE+gKqMpDt7kPp
	 ZoS6KtJdtrkI2e6ECI5s6CWMJ+fSz/DtZwJgDcF80COmLVvRuOYJ6ROnUFo083lh4B
	 QfjTvAn9Ejs74dyGDoe6zJ91YPkgNi0aGGAZny98tNCoQEdQfXdYB4h0+l2MUbWIDr
	 iueWpVRix1LCQXJ57a1Nsm16givXVaSyhXkeUWtJj9dBgaBSDPzxn2k7DUZsJBeC6s
	 MCgwofjJSxeC0ZHRmhqoc0erGdJlmGI54cFaNOKgQ49n6yY2YOq6LBFhKgfPZCiGCs
	 ONXpAgkORRJQzNqipwuYpdNzhEYr8NJ64k7v40/66WQZwi7KWrrtdHFcr5PnVgOEZW
	 NChobvVcTbpIyWw2B0RCN4q5bm9KJa5fbZyrcyzCda7DEWj0hraUQ+I6558RXGLEYS
	 I4Cq2Emxz6uouFP7bmdIqLPU=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7q0JDr8gKqlZ; Sat, 10 Feb 2024 07:46:47 +0000 (UTC)
Received: from xtexx.eu.org (unknown [223.73.102.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat, 10 Feb 2024 07:46:47 +0000 (UTC)
From: Zhang Bingwu <xtex@envs.net>
To: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zhang Bingwu <xtexchooser@duck.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 0/2] kbuild: Fix install errors when INSTALL_PATH does not exist
Date: Sat, 10 Feb 2024 15:45:59 +0800
Message-ID: <20240210074601.5363-1-xtex@envs.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Bingwu <xtexchooser@duck.com>

When running 'make zinstall INSTALL_PATH=somepath'
 where 'somepath' does not exist, the install
 scripts (install.sh) print error messages
 but also return a success status code.
This will make 'make' regard 'install' (and 'zinstall', etc)
 succeeded.
When there are also other targets at the same time,
 for example, 'make zinstall dtbs_install modules_install',
 make will keep going on and other outputs will fill stdout,
 and make the error message hard to find.

dtbs_install and modules_install creates the target directory
 if it does not exist. install, zinstall and others should
 have the same behaviour.

If INSTALL_PATH is not a valid directory, we should create it.
If the installation process still fails with errors, for example,
 insufficient space on disk or permission denied, make should regard
 the install target failed, stop as soon as possible,
 and exit with error.

Zhang Bingwu (2):
  kbuild: Abort make on install failures
  kbuild: Create INSTALL_PATH directory if it does not exist

 arch/arm/boot/install.sh   | 2 ++
 arch/arm64/boot/install.sh | 2 ++
 arch/m68k/install.sh       | 2 ++
 arch/nios2/boot/install.sh | 2 ++
 arch/parisc/install.sh     | 2 ++
 arch/riscv/boot/install.sh | 2 ++
 arch/s390/boot/install.sh  | 2 ++
 arch/sparc/boot/install.sh | 2 ++
 arch/x86/boot/install.sh   | 2 ++
 scripts/install.sh         | 4 ++++
 10 files changed, 22 insertions(+)


base-commit: d0f86d080e3d7d5e1e75a56d88daf8e5f56a4146
-- 
2.43.0


