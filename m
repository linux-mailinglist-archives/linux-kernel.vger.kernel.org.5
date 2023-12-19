Return-Path: <linux-kernel+bounces-5150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4D81872D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E041C234E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357351862F;
	Tue, 19 Dec 2023 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iarpM3as";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApkdsmIH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99F418622;
	Tue, 19 Dec 2023 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Dec 2023 12:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702988025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieRxvbVOAAUwrLCnIlp5XXn4QEhh9FonQZk2Ux2ZoSw=;
	b=iarpM3aszYJEwPUpnnc6do7JKNLqlWyW0kSeuaoDKSJ3ME9VgB91M0vtgun9Qtpw0EvQPa
	szAUN6aqUw+v6DHrMcp/U6oycGIyzvlwKmgBUDqJ329Q0HC6Q1WTDBa2W2e8UFHjTEOwRB
	VoimAdIsvfXo7t7ce3n4JijTyocMwXCL1oyhkD0mfzk741gyOXbKiSxu/+PgbD/AVMJLEg
	RQGWry7xyBw2O+z31HHo7UVorkOI6EYfiQbtj1TPxsRS3RdR9GyGzW8oy20yMU6atzYD3g
	Sc8yA8BTkcwIQvfFC3JETsSixUhkIjndiFOWuR32IMWpFbMYKXW4UFSRceLdqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702988025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieRxvbVOAAUwrLCnIlp5XXn4QEhh9FonQZk2Ux2ZoSw=;
	b=ApkdsmIHREwh0Mx5crau0pUE/uq1t2AkyVoq2orMzcCVsSw+5HP2nSsOxgPNqPn8AVHoH7
	V4BL768K5e1nKTCw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Rework CONFIG_X86_PAE dependency
Cc: Arnd Bergmann <arnd@arndb.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231204084722.3789473-2-arnd@kernel.org>
References: <20231204084722.3789473-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170298802432.398.10812365302883561661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     88a2b4edda3d0709727be53f4423b0b832d91de3
Gitweb:        https://git.kernel.org/tip/88a2b4edda3d0709727be53f4423b0b832d91de3
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 04 Dec 2023 09:47:02 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 19 Dec 2023 13:03:06 +01:00

x86/Kconfig: Rework CONFIG_X86_PAE dependency

While looking at a Xen Kconfig dependency issue, I tried to understand the
exact dependencies for CONFIG_X86_PAE, which is selected by CONFIG_HIGHMEM64G
but can also be enabled manually.

Apparently the dependencies for CONFIG_HIGHMEM64G are strictly about CPUs
that do support PAE, but the actual feature can be incorrectly enabled on
older CPUs as well. The CONFIG_X86_CMPXCHG64 dependencies on the other hand
include X86_PAE because cmpxchg8b is requried for PAE to work.

Rework this for readability and correctness, using a positive list of CPUs
that support PAE in a new X86_HAVE_PAE symbol that can serve as a dependency
for both X86_PAE and HIGHMEM64G as well as simplify the X86_CMPXCHG64
dependency list.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231204084722.3789473-2-arnd@kernel.org
---
 arch/x86/Kconfig     | 4 ++--
 arch/x86/Kconfig.cpu | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41..4692380 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1415,7 +1415,7 @@ config HIGHMEM4G
 
 config HIGHMEM64G
 	bool "64GB"
-	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !MWINCHIP3D && !MK6
+	depends on X86_HAVE_PAE
 	select X86_PAE
 	help
 	  Select this if you have a 32-bit processor and more than 4
@@ -1472,7 +1472,7 @@ config HIGHMEM
 
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
-	depends on X86_32 && !HIGHMEM4G
+	depends on X86_32 && X86_HAVE_PAE
 	select PHYS_ADDR_T_64BIT
 	select SWIOTLB
 	help
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 00468ad..b9224cf 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -362,9 +362,13 @@ config X86_TSC
 	def_bool y
 	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
 
+config X86_HAVE_PAE
+	def_bool y
+	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
+
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_PAE || X86_64 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586TSC || M586MMX || MATOM || MGEODE_LX || MGEODEGX1 || MK6 || MK7 || MK8
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.

