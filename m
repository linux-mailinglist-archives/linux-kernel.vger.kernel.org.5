Return-Path: <linux-kernel+bounces-84831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11986AC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAA21C2466E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3D5A105;
	Wed, 28 Feb 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2t9Bhv5+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aozq2qcW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1933CC2;
	Wed, 28 Feb 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116097; cv=none; b=INqGR88gL1Sgt1jR2MAu3n5x+tcOSzqvYpkF1B4hN7X++q7X0TCX3VXBOweiZ7B025KXaK/gySb0sUzaCmHJM7/8pA8nUSDoZOqZJ4IX2O3cF503i4JTaeoQQzkt9WMymKNAcAruMA9jKRV52CDBq5DnZ9liGSmbG5UmHpOBaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116097; c=relaxed/simple;
	bh=c7EozbE5lS8REnkr5wltySbUv2bQiI1Sc8Mhu0Q684I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MsZYdKeym5UYf3MleOoTRqqZSVLLuPeQBQiRJzbdQ/B2vzsS+GuFr34niDTdZ/U5XETgaIZyq8ebpiROp4wl7iN6RBo6UwAABmG48zWIx+98AGR+rFwWF5DTHDud2Uz2bnwD7xHuCjkKPc0aiHD5w8n5eI0C+3qJEvVRI4jsaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2t9Bhv5+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aozq2qcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 10:28:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709116093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ/ARzW2iQnxlfHDRNbOFL7Jz4fHUm/wi9/mmrRzFyo=;
	b=2t9Bhv5+8ZrR3QtyrTLsPyZgRmeFm2cdRDtC5NbtlkGaVinAFiL4xAi663iYLWAunMPUaO
	koC2jtRTWWqvEQyUg0I6kVbB1Um2+fIWcej+Kf5u+rF8qzv/6EdqcyuE1sp52mz/UVzCyJ
	hVJ7rCa1Pl4efZbMnLiCVhdIltxFHuYg4texpW16s544hCTDr+/cy4/FbeYRHEPlt+JqbL
	83PZmqycmxsT2HUt3HQG5ArsNCWG33TEWoNbua+Ak2nvh6UnJainhFFYh8H3X2bcTS9hke
	5xfpa04DSSiceAj4eWkdQDILKIUDZk4u2mr6az4sGg0BsSYa4zofCoboHmDjJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709116093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ/ARzW2iQnxlfHDRNbOFL7Jz4fHUm/wi9/mmrRzFyo=;
	b=Aozq2qcWSWl84qjcO632WVDXdrCDI0iDPxn5J9gk/wCSQ/tSI2YkCK/YZlXi6neLJvJMf2
	zWjwX/dVYanK66Dw==
From: "tip-bot2 for Jiri Bohac" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/e820: Don't reserve SETUP_RNG_SEED in e820
Cc: Jiri Bohac <jbohac@suse.cz>, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
References: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170911609255.398.9253992823992514888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9e1daa3bfcccf79ee368061d807ff541d6e2d909
Gitweb:        https://git.kernel.org/tip/9e1daa3bfcccf79ee368061d807ff541d6e2d909
Author:        Jiri Bohac <jbohac@suse.cz>
AuthorDate:    Wed, 31 Jan 2024 01:04:28 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 28 Feb 2024 11:10:31 +01:00

x86/e820: Don't reserve SETUP_RNG_SEED in e820

SETUP_RNG_SEED in setup_data is supplied by kexec and should
not be reserved in the e820 map.

Doing so reserves 16 bytes of RAM when booting with kexec.
(16 bytes because data->len is zeroed by parse_setup_data so only
sizeof(setup_data) is reserved.)

When kexec is used repeatedly, each boot adds two entries in the
kexec-provided e820 map as the 16-byte range splits a larger
range of usable memory. Eventually all of the 128 available entries
get used up. The next split will result in losing usable memory
as the new entries cannot be added to the e820 map.

Fixes: 68b8e9713c8e ("x86/setup: Use rng seeds from setup_data")
Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/ZbmOjKnARGiaYBd5@dwarf.suse.cz
---
 arch/x86/kernel/e820.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf95..b66f540 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1017,10 +1017,12 @@ void __init e820__reserve_setup_data(void)
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
-		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
-		 * to be reserved.
+		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
+		 * kexec and do not need to be reserved.
 		 */
-		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
+		if (data->type != SETUP_EFI &&
+		    data->type != SETUP_IMA &&
+		    data->type != SETUP_RNG_SEED)
 			e820__range_update_kexec(pa_data,
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);

