Return-Path: <linux-kernel+bounces-117497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6188ABFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018921C39796
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A514A092;
	Mon, 25 Mar 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXO/dXTG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9j1dOZ2j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDD137929;
	Mon, 25 Mar 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385211; cv=none; b=h2yP61GTjXUbsbIy+giIezzu31FI5rihxL9nMTyWZHunADTd7yhFuLElLvEBjAoVMxiV+AdHtfkwjxtyb+23+KGPECuXanDdINRrH5rQ2MeNnLCMNyQLAOPeMMPBonF9NnmFQaNMlQ8zruZegSAk/WPcP51PXwSwayOSmzavaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385211; c=relaxed/simple;
	bh=/5cDWC+Ymd1itEg71u3T8msfsGTnjLr332mvwinnayE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=exr6sY1fsNacqHGgWKDG4nTXugYrVPdF0DldIMsiOspbZG8PCfHzBoO3IO3VeOlUKw2jLiMeNmsWU44/bNyuyZOKbmiF510zRROc2xE5I4nrG1E789/EnG50BonsIzW3p0H7qi88d33t6U1Ht0+itbxYztF3XDixn3AtKc5jI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXO/dXTG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9j1dOZ2j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuHod+42U3T0iuw3JztANPvmdrQ4FuB8dFOXpoX1x/E=;
	b=GXO/dXTGEWvJ66Nyz+OTC0kxJQfpFI+bhfcDKXhhyoscoEmdVBjX3UmrEhApRHBkIuYCMj
	Zevtc/mSK+Oea52QQ4Aq2KUhCwTwP7RRqr5FXwjMFt1dWaA9gzIENqK77r/PK30bVPs0Nh
	viSvIhkF3X8MGxn4YOFTnZpPotsT5IJ6VI5pMFV1SyqZ61iHdegte1txZpS9/3MR6jW/P5
	mjEfkbU4VilUNZjWRpY4FvO4uLLLFrrcGJHH4OVUjTiBNUxKBVcgRmLj2mW2vd0yj/y7pV
	Avfj2QtisaipGYSpH0R+WIbsgfYEHnoVOSHXGYyjhvh1XkD8K+MSh0TWSdvz8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuHod+42U3T0iuw3JztANPvmdrQ4FuB8dFOXpoX1x/E=;
	b=9j1dOZ2joJZNppiVX4dHX+hs7rX+JDONQd3cdRWC0xbCNnndrURFf987cV077NZdBPx+Eq
	h/ET5bDonED7EEAQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] RISC-V: Select APLIC and IMSIC drivers
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240307140307.646078-9-apatel@ventanamicro.com>
References: <20240307140307.646078-9-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520684.10875.18341951342452286896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0eebc69db358fd2f6fe34cc4db6428df6a540dd7
Gitweb:        https://git.kernel.org/tip/0eebc69db358fd2f6fe34cc4db6428df6a5=
40dd7
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:06 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:29 +01:00

RISC-V: Select APLIC and IMSIC drivers

The QEMU virt machine supports AIA emulation and quite a few RISC-V
platforms with AIA support are under development so select APLIC and
IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-9-apatel@ventanamicro.c=
om

---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c88..9e87287 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -173,6 +173,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC

