Return-Path: <linux-kernel+bounces-163096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10A08B658C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAAD28317C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67C519069B;
	Mon, 29 Apr 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3jStbhO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALepUeQp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD54177992;
	Mon, 29 Apr 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429165; cv=none; b=l327o3UpyFSVrSOuejNubElkTIzDFtDOJkuQvmizDFcr9j9lWn1+mT+xdrHKeSziIq4xdxyrLt/cK4DgTBXRjTPlPYTo/6tHiB2tHHhO8ipJsG9pEDDJC2tcHUeCbuk3B7sXkkcIupiDxXTC8V60SjallMW4hZ87z2BrC/bclm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429165; c=relaxed/simple;
	bh=8w4f6x4HM58zOXZcFn15vnRf47Rfc2cLm2sIIgBjOaw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J1FUiv6kxRtXJHa7/Mfm1kWsGS8xH1AZQ9vuDX/yaZbyrR3/yM6SpYugYs0z5Vm+cETW0A/cPpAYG3Nxc9iI4k+/jQA+E7blMuIBnU0G87XVBNDCWa20skGulWnTImTbJrT/hoalx89CVMDZegv1Pxg/M24OuXFyNVbOaFfPtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3jStbhO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALepUeQp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 22:19:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714429161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3y+8X/qFhPSTPOYWMQ1YatuSiWkW5K5mEJAPZe9vqM=;
	b=a3jStbhO2G4TOWQ4c4d8Y5ysivZ5kPTRzEge1/qxNr6FYrBZ4XnLKQIZQnXHNCF578YdCw
	MFgFspOPVT5DFq4cWU4eJ34wS98yIhDUHCKf0hOPhFK8JoQicIQMi6p0LBbjiKdcss48Ls
	v3q5J1O+eoFSAMF8Nm0CzQUVJsh4qQUkEtGpgZrvfeNGHczKcIJ8/TeFCAVviLjkAVZpVG
	okiB8K6XtICdSQHumonvzeChJk/+12oMOwubjjFAKog/NDvZ4bzn0U4xmLhbvwzcNJo4kC
	2nbQ8z6I7EkNIU/rUmsnjaniVQ5ttlqjOnXG/ZNhX1pQFLIVP1CkdJWTbP5Yzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714429161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3y+8X/qFhPSTPOYWMQ1YatuSiWkW5K5mEJAPZe9vqM=;
	b=ALepUeQpdNQTHODdukgQT0IC/dtbvIHNcMjoh4D+VgFDG8ooUnuuq7AiihOafyrCTZPP2R
	nyvcNAF5nAUnIlAw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Make the int help prompt unit
 readable in ncurses
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240428102143.26764-1-bp@kernel.org>
References: <20240428102143.26764-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171442916066.10875.8581984899215904013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     54db412e618e9c43e5167f809a901f554e8c43e2
Gitweb:        https://git.kernel.org/tip/54db412e618e9c43e5167f809a901f554e8=
c43e2
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 28 Apr 2024 12:21:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:12:22 +02:00

clocksource: Make the int help prompt unit readable in ncurses

When doing

  make menuconfig

and searching for the CLOCKSOURCE_WATCHDOG_MAX_SKEW_US config item, the
help says:

  =E2=94=82 Symbol: CLOCKSOURCE_WATCHDOG_MAX_SKEW_US [=3D125]
  =E2=94=82 Type  : integer
  =E2=94=82 Range : [50 1000]
  =E2=94=82 Defined at kernel/time/Kconfig:204
  =E2=94=82   Prompt: Clocksource watchdog maximum allowable skew (in   s)
  							      ^^^

  =E2=94=82   Depends on: GENERIC_CLOCKEVENTS [=3Dy] && CLOCKSOURCE_WATCHDOG =
[=3Dy]

because on some terminals, it cannot display the '=CE=BC' char, unicode
number 0x3bc.

So simply write it out so that there's no trouble.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20240428102143.26764-1-bp@kernel.org
---
 kernel/time/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index fc3b1a0..8ebb6d5 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -202,7 +202,7 @@ config HIGH_RES_TIMERS
 	  the size of the kernel image.
=20
 config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
-	int "Clocksource watchdog maximum allowable skew (in =CE=BCs)"
+	int "Clocksource watchdog maximum allowable skew (in microseconds)"
 	depends on CLOCKSOURCE_WATCHDOG
 	range 50 1000
 	default 125

