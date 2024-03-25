Return-Path: <linux-kernel+bounces-117496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A688ABFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6455281F95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199C1327FF;
	Mon, 25 Mar 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Wid9Xl4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jubHcDTH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311C12CDAA;
	Mon, 25 Mar 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385210; cv=none; b=I/zxepcPozkkFPGeU1G6rukzOvBzt8z0U80smVhBhKEDjDmWP3b5zMX1uhSx8oOIvc+d6WQkq5ne6ImpCHQhe9gzCJhs19eABsgFaZa9ixRO3bC/cIWS1qdyV24D3oqj2tdN+mcDiWkySgvGO4YbuTe6Jnfy+bMtSFY4fCycFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385210; c=relaxed/simple;
	bh=lV8EjYYnI7M8SGGuZcGjU36lrqg84lzgsnzaGZj2pQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lfOg8OPrqWPGzX1xv+hY75i4n7EvptTP7m4Q/3SgxKWF3UT5/KsC1jr2llrL9ibIb8UpUwdaA7VdwbsDCelpii9fWsR/qCrSPaRNam/2gpBlwTn0wWP7m5hqbikIPfKNIu+WZv9YiQy3djMM4bsxKGZPVvrlERuopWG4oeTD298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Wid9Xl4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jubHcDTH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPEH3kSnrLsGUy39ua9UsEarBkTQHPdlqYBLg238P5Q=;
	b=1Wid9Xl4VDy5ZR5ldL/jmI39Ad/hhPiFxGnXxaZeZK7hNjYT3HDSViyeNZcwFe21KqSkDY
	HOLiO6pVT3nZaq6k8d7/S5bGQgaaOqibSt1DzWWl5xvHhRL2I0bJLugaVyPYvrRRQ0DpWe
	66xvfg866AbDdQCSqN4q/q9+8/ZpATrMljLrV8wsEggMmt4AwYD338jt1x9dwCTZhbwswm
	lhlZvAKOLH9gHLi2PVv8LjcBkRX7zHOEJh7v0I03QXfdlU7PZ7ftdLpVQcK3T2ozdkqcJF
	yMqQeBFSHjrV0Vxkt5oKr2KLxMJOuFjXJAOu80v6evV3uViJq6OO5Np6haxNUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPEH3kSnrLsGUy39ua9UsEarBkTQHPdlqYBLg238P5Q=;
	b=jubHcDTHoDPrkRlBCDR/2WhII/G+oCqB0DTMuAxW/QUly0h/r5Lmfqsm1Ldb+CWDCJW38D
	TkaJW+XDTnDaXOCg==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] MAINTAINERS: Add entry for RISC-V AIA drivers
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240307140307.646078-10-apatel@ventanamicro.com>
References: <20240307140307.646078-10-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520611.10875.10767264123435559459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f4e116b2c5eec0dc1ab65e7105c180d4f8627b39
Gitweb:        https://git.kernel.org/tip/f4e116b2c5eec0dc1ab65e7105c180d4f86=
27b39
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:07 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:29 +01:00

MAINTAINERS: Add entry for RISC-V AIA drivers

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-10-apatel@ventanamicro.=
com

---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947..4a909b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18922,6 +18922,20 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
=20
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic-*.c
+F:	drivers/irqchip/irq-riscv-aplic-*.h
+F:	drivers/irqchip/irq-riscv-imsic-*.c
+F:	drivers/irqchip/irq-riscv-imsic-*.h
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>

