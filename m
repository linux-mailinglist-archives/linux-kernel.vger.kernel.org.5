Return-Path: <linux-kernel+bounces-111972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD2887376
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C561EB2350A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27B76C83;
	Fri, 22 Mar 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mm2ZrNSJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hXTFtEVe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03176C64
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133803; cv=none; b=g+qqxDkfs5ZejkhSjRdQkbDGTxGwj+ExvZSreKmtRCz3oH1GNVtTUBoj0FS7WNCQUHwwr3l8rEyBYLjBBKMKdZ96icY7cspvRdzoJ8H450sP2iPztkXDxts7el3r/6QPKfWxX0cutVp5p3jq3yh+zQatlsTHXDG7w0YyxQOoRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133803; c=relaxed/simple;
	bh=mxq6yoPCsn4NmvEILlkVTNrX+N37V4MD2chnGDWz2Rk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GknxAIEjedrjlK3qfT3xNU3zBjtAzavNc3DFT1po4zNYnleH4MEqFae7QOVtBc2y1rYRjaLYLmbtfLsRz0XYhn9PDjSAwZs3qoCgAjg/4DTzd+ZG+FfBkV6xo7JGt+rom/ZBi4AyR+Nn0N6bh08p/XIhymkKxMFlIwa3fZEw45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mm2ZrNSJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hXTFtEVe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240322185305.297774848@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711133799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mTgiiqmXpDlu2wr754bEzodBYm+Wxgin5W5FXRk38D4=;
	b=Mm2ZrNSJgE9OAdDPFrUY+7HQ5w/BQ5G6fso+vIUmXbgeBCG7JSCqx6dYtN/6E/riuqR4y6
	mQ++gXpNL4teNlTJbAU5Nv2FTPE4mNl1f9GrPI8U2Bn7TzfQk7ouyNdkivw12RRajEH1Ax
	NdtiXMRu900pWb3K9LtP7/8+rPz4rd7hul6ahR+md6ns4Fqwat8TGXxjfv5bgFX/lPgddJ
	/Eb+H1nox6ZDACoeYUOAgStv1mj2BMUBbw5CVCMSaaEy7zFiIt05TJWP3zYDLI73X6W5XD
	jW1kzA/wMf/JB6JP8IgWbhD1ZJIIPXQZfvtTRBgJ2Sfl95uCOeDwAbmCrCJPHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711133799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mTgiiqmXpDlu2wr754bEzodBYm+Wxgin5W5FXRk38D4=;
	b=hXTFtEVe6KvrhKPlJwAyLdTuffKGKaZfPloANB5XDhE35V9abgORQNy4KZoSgkpaXI5mnI
	ns/ofbVdS6gb/BBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 4/4] x86/mpparse: Register APIC address only once
References: <20240322184944.141421692@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Mar 2024 19:56:39 +0100 (CET)

The APIC address is registered twice. First during the early detection and
afterwards when actually scanning the table for APIC IDs. The APIC and
topology core warn about the second attempt.

Restrict it to the early detection call.

Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/mpparse.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -197,12 +197,12 @@ static int __init smp_read_mpc(struct mp
 	if (!smp_check_mpc(mpc, oem, str))
 		return 0;
 
-	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
-		register_lapic_address(mpc->lapic);
-
-	if (early)
+	if (early) {
+		/* Initialize the lapic mapping */
+		if (!acpi_lapic)
+			register_lapic_address(mpc->lapic);
 		return 1;
+	}
 
 	/* Now process the configuration blocks. */
 	while (count < mpc->length) {


