Return-Path: <linux-kernel+bounces-138563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CDD89F3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EB31C23075
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C215ECC6;
	Wed, 10 Apr 2024 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lt2CEBeB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChTsiyYm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB82158D6B;
	Wed, 10 Apr 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754550; cv=none; b=ZUpfV6eJ+IaH5zdRfdvS/127i7SmHkZ0QgBTZecxlDSgMI7I4ecSlziQMbEPLMqxQu8EtQksocxRDHPoYOLBtlk+pSdTYRbgPUuJlZ3hor8R6N2QXZTf5wxsBY5Nx5C2ZLd+Zcfugz4F4DedXQYGEqnN53pjNGB6RqW/tzHjxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754550; c=relaxed/simple;
	bh=DVsyvZznbXxXopBYa+V2X+LKRzPLEQ+gw6dR0qVmBJo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CSpDLODZDeX+IrP2qMpHfK2oGamfUs+Rz9xaw1KP6+dtkwcNwvzqL0aCPd4ssaPNmu6ir9SdOAjN+e0CKwfaHZi3dMscZGCiR4ZBwWEszJMfFB6nmiv+P0blCxkviWOzUbdOVLNfvOC5/bLHFb+HSpCPJ3tGoCPzqkA0KGzCqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lt2CEBeB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChTsiyYm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712754547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0w73FUI0UgD5Z87XACzuGpXa+SVzEAPwn4oHcXwVmi0=;
	b=lt2CEBeBEsUD4jh6IO9nFzFXV3CKLvFuw0VgrcYVcX435bk1czZ0w6xhRNt5ZSBOY6vSh0
	NM4on6KU3vzfZOV5zcCnzEROJb4OpR/NEM11MLz+X5icyY5DWsH9EQobf5pqTvM9Ul8ySe
	Do8wFz/V6p5C/o+dvCU7hmItlbtNAykjT9YpCLGcz7iw3VP+Q4p1lRqWOTO6tRa7Ji6IdB
	M6+2nN72NMZrsfuQR0/Ip04BTcHb2AJxpeDmUr2GToHWxC1bm+EbH02VXCwOzAoqR8hcEz
	btfjT8rHAhz31uYO6QpwuaLdyrfQLAETkIxIiJBWc/TlXSD2VJ8Xem+Cd3io6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712754547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0w73FUI0UgD5Z87XACzuGpXa+SVzEAPwn4oHcXwVmi0=;
	b=ChTsiyYmuC95SSGmWOJiWEA0cGDNY/ZjCvi9ezrEVgtObUss3XkSFsmV8ILV/asvDAcpTg
	20aBT0WLz1Z7vYCQ==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/iris: Convert to platform remove
 callback returning void
Cc: u.kleine-koenig@pengutronix.de, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cadb9b0aca77d7aa8e54d0a664a4ee290834a60a1=2E17127?=
 =?utf-8?q?32665=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3Cadb9b0aca77d7aa8e54d0a664a4ee290834a60a1=2E171273?=
 =?utf-8?q?2665=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275454670.10875.3993795189807291031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     bcc0403eb4c3f5f79e3bc39bc2d65ddb1c25ffdf
Gitweb:        https://git.kernel.org/tip/bcc0403eb4c3f5f79e3bc39bc2d65ddb1c2=
5ffdf
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Wed, 10 Apr 2024 09:16:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 14:59:30 +02:00

x86/platform/iris: Convert to platform remove callback returning void

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/adb9b0aca77d7aa8e54d0a664a4ee290834a60a1.1712=
732665.git.u.kleine-koenig@pengutronix.de
---
 arch/x86/platform/iris/iris.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index b42bfda..c5f3bbd 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -62,11 +62,10 @@ static int iris_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int iris_remove(struct platform_device *pdev)
+static void iris_remove(struct platform_device *pdev)
 {
 	pm_power_off =3D old_pm_power_off;
 	printk(KERN_INFO "Iris power_off handler uninstalled.\n");
-	return 0;
 }
=20
 static struct platform_driver iris_driver =3D {
@@ -74,7 +73,7 @@ static struct platform_driver iris_driver =3D {
 		.name   =3D "iris",
 	},
 	.probe          =3D iris_probe,
-	.remove         =3D iris_remove,
+	.remove_new     =3D iris_remove,
 };
=20
 static struct resource iris_resources[] =3D {

