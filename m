Return-Path: <linux-kernel+bounces-75361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDAB85E73D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E601C1F218E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5285C6F;
	Wed, 21 Feb 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrxh9ShF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ON8M4ABb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4785941;
	Wed, 21 Feb 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543582; cv=none; b=NPGMUXbemxvuitAaxCeL3DagKttv1cKn0SZlf3LipE+SVXS9xb9m5VZdDEagxv505WDka1NwLfMtWKL4ORNucgyzciHwYDUHt/FHoV42ZFak8s6VilnO/aS/SuwSVZibC7Oq5lz9u8IP7eH2YnyN+QcCWWRSzSxcE1tOb7acijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543582; c=relaxed/simple;
	bh=t1bg75155h9kUzdm9X36sGXHqO5aEm2RneZiYY3VhnI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fregub4d8rjrBx0ke2tx5IgkPjCjV+7P5KJ1SJouLE7hLEpHkdfUvd4ps8Bco3pcGv+aAWsUtbrhDd+hxvva7f13ex/qF32ThTbeUKQfRD2WYLtJPHgg51JGDtu8yTjdbkoRoXlkPt11/xceyc5/L99cjguwFSL9l6NAnjXSE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrxh9ShF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ON8M4ABb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Feb 2024 19:26:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708543575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWexCxPo3VvQYcBlwHoCkpQstAhTBJYFavaPPN9gzJ0=;
	b=lrxh9ShFCGQEw3leGvicwsxxstFMQGBWkyPG03QZodileqsOds+ige5Uzd8Mac2Z1NuU0G
	qNcaVtej3ZO3kva/lPdO/qwDMgbirFa/R24J0HqDfHYB+sBlopdP32/68hyn+9Md/LS/E7
	YTGtQUnmabXbezdbfGQp4gwIM99EUvGtLVzOfYiDXQXnDh8b9V1ex9wn99yzxeswqxB8/g
	/wULReV4UHwYADEl+ya9c4l2iiInvOAOCH3weay5jRsrfNjFYg5XvsxXPpAg7QVo0vppLC
	l7CET8NlNpS3pG8pmYnO3huxLncOK1dFygblOKs3wCIKInk1uKa9uEJs1J/DZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708543575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWexCxPo3VvQYcBlwHoCkpQstAhTBJYFavaPPN9gzJ0=;
	b=ON8M4ABbyAvFuY8hYan2AV82gClvV/zxxK6QnD09vQNRV0amG0iHk9nFVSvs/4sgGIMDff
	z83NiVTVYZ4eZyAQ==
From: "tip-bot2 for Kunwu Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/apm_32: Remove dead function apm_get_battery_status()
Cc: Kunwu Chan <chentao@kylinos.cn>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126030824.579711-1-chentao@kylinos.cn>
References: <20240126030824.579711-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170854357413.398.5881100037492734739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e37ae6433a5eeb5fb66e3de4b97cdda68ee2c5e8
Gitweb:        https://git.kernel.org/tip/e37ae6433a5eeb5fb66e3de4b97cdda68ee2c5e8
Author:        Kunwu Chan <chentao@kylinos.cn>
AuthorDate:    Fri, 26 Jan 2024 11:08:24 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 21 Feb 2024 19:38:03 +01:00

x86/apm_32: Remove dead function apm_get_battery_status()

This part was commented out 25 years ago in:

  commit d43c43b46ebfdb437b78206fcc1992c4d2e8c15e
  Author: linus1 <torvalds@linuxfoundation.org>
  Date:   Tue Sep 7 11:00:00 1999 -0600

      Import 2.3.26pre1

and probably no one knows why. Probably it was unused even then.

Just remove it.

  [ bp: Expand commit message. ]

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126030824.579711-1-chentao@kylinos.cn
---
 arch/x86/kernel/apm_32.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 76a5ced..b37ab10 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1055,35 +1055,6 @@ static int apm_get_power_status(u_short *status, u_short *bat, u_short *life)
 	return APM_SUCCESS;
 }
 
-#if 0
-static int apm_get_battery_status(u_short which, u_short *status,
-				  u_short *bat, u_short *life, u_short *nbat)
-{
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-	u32 esi;
-
-	if (apm_info.connection_version < 0x0102) {
-		/* pretend we only have one battery. */
-		if (which != 1)
-			return APM_BAD_DEVICE;
-		*nbat = 1;
-		return apm_get_power_status(status, bat, life);
-	}
-
-	if (apm_bios_call(APM_FUNC_GET_STATUS, (0x8000 | (which)), 0, &eax,
-			  &ebx, &ecx, &edx, &esi))
-		return (eax >> 8) & 0xff;
-	*status = ebx;
-	*bat = ecx;
-	*life = edx;
-	*nbat = esi;
-	return APM_SUCCESS;
-}
-#endif
-
 /**
  *	apm_engage_power_management	-	enable PM on a device
  *	@device: identity of device

