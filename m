Return-Path: <linux-kernel+bounces-7453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6721F81A814
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B9B1C2170A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB851495D0;
	Wed, 20 Dec 2023 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KM5mJvai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9yrPcUg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF3495C1;
	Wed, 20 Dec 2023 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 21:32:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703107937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/OsDjhXqr/1LDHw58uXvplzo2hKo0Qi2ivibH7zQ8U=;
	b=KM5mJvaiDQsqwO7XPgAUsfws1QdC+cs3q6BgEVvnOBn1Goygjq1qBOKlvcJHE8DZHxE3jk
	wkLC9gK360cMWtOP3d/4YYmAdlNLJZvALEw92YlHH1JlCqf4N1PaqVF2xvVw3/qhyDM97z
	2KNmhB8oIDgBk1k+rO9uP1Xr1EPl+ggTbwreZJ5r2TWuwSev3/qrAMGB1jqNR0N2WSrOpx
	nZippK4Th8JZlCMqjAUbbX8kdCWdVt9cAtdGPPztNEUpLcrCKqnBWjarYaOIAoWTfYU7ZU
	7N8NmAYScRu5dGlbdN5lzWNgDYUwX0SO0miiy757P3sf3AFGI/7zjhSbaW9Ybw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703107937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/OsDjhXqr/1LDHw58uXvplzo2hKo0Qi2ivibH7zQ8U=;
	b=s9yrPcUgmdGNbnGIYtS/xf+2iT541w1NtRzNMnWUczo9ioD4IlXxRQ39TRLZ45GLt/UjkF
	cwS0O+JTyEgdWJCQ==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Remove redundant initialization of the
 'delta' variable in strcmp()
Cc: Colin Ian King <colin.i.king@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231219141304.367200-1-colin.i.king@gmail.com>
References: <20231219141304.367200-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170310793651.398.15795585015869596291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     257ca14f4d780e27a0605fd68053d2cc3178a232
Gitweb:        https://git.kernel.org/tip/257ca14f4d780e27a0605fd68053d2cc3178a232
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 19 Dec 2023 14:13:04 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 22:23:33 +01:00

x86/boot: Remove redundant initialization of the 'delta' variable in strcmp()

The 'delta' variable is zero-initialized, but never
read before the real initialization happens.

The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231219141304.367200-1-colin.i.king@gmail.com
---
 arch/x86/boot/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 1c8541a..c23f3b9 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -49,7 +49,7 @@ int strcmp(const char *str1, const char *str2)
 {
 	const unsigned char *s1 = (const unsigned char *)str1;
 	const unsigned char *s2 = (const unsigned char *)str2;
-	int delta = 0;
+	int delta;
 
 	while (*s1 || *s2) {
 		delta = *s1 - *s2;

