Return-Path: <linux-kernel+bounces-60339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E7850360
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7128589D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FAD33CCC;
	Sat, 10 Feb 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="hd/XVnAi"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714229424;
	Sat, 10 Feb 2024 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551235; cv=none; b=aPIy5NyKPJDRGmWd4UTLnCnE7sACUivIN4hBKfkRw9g/Nh4g14NVMVOyQl+1eRh/XVfMGrRG891tgWNmvgKbaI/h4gXpOKtOZ6HJretsOhj6gikJCigPLC5a15Oo/wnjqY02/wa0IF1+NO0YEQ/tq+mL300i8blcNlUAiXnGxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551235; c=relaxed/simple;
	bh=ftAJHSxo5Rsx/0DaR5hsL6pNxlltkkDCUMwyIZ5u780=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs7gUV3LMyNEPiQfWWOcNBUT1gh3biIMO+bpKT5Lcn1ZIP6Ow1SyS2T4U5Yud5AMTo1hdANyBc72zfNJKHCKD1Ok08Me1N6bfWzTnmC4OdpPWy8jMncO971dVSR7T2MBgnNp7YWgc8GAFgXNiYBit9UBUTbL4pGCZqIAeoi5DMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=hd/XVnAi; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 8A86F38A067E;
	Sat, 10 Feb 2024 07:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1707551230; bh=yyUazkvkRh10ZbEGZX7/MXwA6mkniL0Aqt6WS89cGkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hd/XVnAimjrqEjNcLEHz1FnGusJEW32uyKQYnIKt5uFodkm1RM3EYTgs6lpTGn9JV
	 NUqTvBugmu1lMKqlk092oyo/KZaFN4NXF6D6VwQOuHnGQDNyHkJlsm/Y3K1oPoePvy
	 QZV1bS/HMqeEMt78NTjNT/s4ZJ5Mit6QXmA862rrT+GW/IEbkV4jDc05MIwIHszBLl
	 qQ3DEqw1ELqeViRk20ILeVQA999OVMuJBTgPCi1GAV/6n6WFVxBNt5RQKNteZvMYAV
	 Nd6fCGeU8tZamgqr5iY+Kg5XWePuTdcKYfJ88KcC7z3e0MI+Cqq9z/SQ8BZqFaKIpa
	 fVExG6myqkBA9ugvB76Adioe1PhFwNqkLWz7IEKJLd53SdCeiDNheQ5FZkxe6sFTzO
	 TPIkG+DuOaLJFNNMhgVYZxF4biAq/jAsMkO7FoqWd+MbULyheCb4tcZ5kOgxbwTRTw
	 099PvijCadI39fEEOHcDZ+1EFxNa7Q1//PZTbjIKJ9z3LC3MNALiRXdBrXMR2Jvixl
	 fgNJrSkHSAJ9P4XyfyDDhpux12a6SJLMTJqVkQZtAvSutrNijPNWpd/nf0nNdtgTPh
	 z1dEc8QNvl0DRLtQzoOK6pb2fazvjtaZYp/zHg3GkyQKdDABuu1VuJ58d9TFLa2IqZ
	 h8BhqRVSWGgAM9IACgQNk9sA=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FENJE3rEUQ0U; Sat, 10 Feb 2024 07:47:00 +0000 (UTC)
Received: from xtexx.eu.org (unknown [223.73.102.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat, 10 Feb 2024 07:47:00 +0000 (UTC)
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
Subject: [PATCH 1/2] kbuild: Abort make on install failures
Date: Sat, 10 Feb 2024 15:46:00 +0800
Message-ID: <20240210074601.5363-2-xtex@envs.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210074601.5363-1-xtex@envs.net>
References: <20240210074601.5363-1-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Bingwu <xtexchooser@duck.com>

Setting '-e' flag tells shells to exit with error exit code immediately
after any of commands fails, and causes make(1) to regard recipes as
failed.

Before this, make will still continue to succeed even after the
installation failed, for example, for insufficient permission or
directory does not exist.

Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
---
 arch/arm/boot/install.sh   | 2 ++
 arch/arm64/boot/install.sh | 2 ++
 arch/m68k/install.sh       | 2 ++
 arch/nios2/boot/install.sh | 2 ++
 arch/parisc/install.sh     | 2 ++
 arch/riscv/boot/install.sh | 2 ++
 arch/s390/boot/install.sh  | 2 ++
 arch/sparc/boot/install.sh | 2 ++
 arch/x86/boot/install.sh   | 2 ++
 9 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
index 9ec11fac7d8d..34e2c6e31fd1 100755
--- a/arch/arm/boot/install.sh
+++ b/arch/arm/boot/install.sh
@@ -17,6 +17,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ "$(basename $2)" = "zImage" ]; then
 # Compressed install
   echo "Installing compressed kernel"
diff --git a/arch/arm64/boot/install.sh b/arch/arm64/boot/install.sh
index 9b7a09808a3d..cc2f4ccca6c0 100755
--- a/arch/arm64/boot/install.sh
+++ b/arch/arm64/boot/install.sh
@@ -17,6 +17,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ "$(basename $2)" = "Image.gz" ] || [ "$(basename $2)" = "vmlinuz.efi" ]
 then
 # Compressed install
diff --git a/arch/m68k/install.sh b/arch/m68k/install.sh
index af65e16e5147..b6829b3942b3 100755
--- a/arch/m68k/install.sh
+++ b/arch/m68k/install.sh
@@ -16,6 +16,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
 fi
diff --git a/arch/nios2/boot/install.sh b/arch/nios2/boot/install.sh
index 34a2feec42c8..1161f2bf59ec 100755
--- a/arch/nios2/boot/install.sh
+++ b/arch/nios2/boot/install.sh
@@ -16,6 +16,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
 fi
diff --git a/arch/parisc/install.sh b/arch/parisc/install.sh
index 933d031c249a..664c2d77f776 100755
--- a/arch/parisc/install.sh
+++ b/arch/parisc/install.sh
@@ -16,6 +16,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ "$(basename $2)" = "vmlinuz" ]; then
 # Compressed install
   echo "Installing compressed kernel"
diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
index 4c63f3f0643d..a59639dff64f 100755
--- a/arch/riscv/boot/install.sh
+++ b/arch/riscv/boot/install.sh
@@ -17,6 +17,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ "$(basename $2)" = "Image.gz" ]; then
 # Compressed install
   echo "Installing compressed kernel"
diff --git a/arch/s390/boot/install.sh b/arch/s390/boot/install.sh
index a13dd2f2aa1c..fa41486258ee 100755
--- a/arch/s390/boot/install.sh
+++ b/arch/s390/boot/install.sh
@@ -15,6 +15,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 echo "Warning: '${INSTALLKERNEL}' command not available - additional " \
      "bootloader config required" >&2
 if [ -f "$4/vmlinuz-$1" ]; then mv -- "$4/vmlinuz-$1" "$4/vmlinuz-$1.old"; fi
diff --git a/arch/sparc/boot/install.sh b/arch/sparc/boot/install.sh
index 4f130f3f30d6..68de67c5621e 100755
--- a/arch/sparc/boot/install.sh
+++ b/arch/sparc/boot/install.sh
@@ -16,6 +16,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
 fi
diff --git a/arch/x86/boot/install.sh b/arch/x86/boot/install.sh
index 0849f4b42745..93784abcd66d 100755
--- a/arch/x86/boot/install.sh
+++ b/arch/x86/boot/install.sh
@@ -16,6 +16,8 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
+set -e
+
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
 fi
-- 
2.43.0


