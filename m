Return-Path: <linux-kernel+bounces-56608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E684CC86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67001F268FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC457C096;
	Wed,  7 Feb 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olTokGAj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vs44pS8y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57077C090;
	Wed,  7 Feb 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315623; cv=none; b=kaMfNKS82mSqAqaNK2f4RLh1OGGSqsqo7MCPA3EGLxDFL/bQ7F/9N3fmtOmk6eqMUHFDpaAmMPkvHVNJ+y3BXASlUuYFABTi0zsVUctNBR0LcCMYnV+WJ6xaHauq00Kn8dtpEgGhWVpuBQVbAvflZp+Beu3SteAOu7Kk5hs/nmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315623; c=relaxed/simple;
	bh=3Vya9ZSZxP6a3+Q0oC9Tpk7ndO1hOD6idDjI6YzgPjg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jfYegIPY3sMT8RzpGU6TnYZK9hEfSfLNI/bZ15L80swq3ikb2z/6VpIw6rC6i0mIHSW/ZSK1MmTUC7e8+6EooJh0YdOePrjOFERNADwZGIVp+bWHcZVlFgnqNxRcq76d84sYwFVA9KBBAF0QfSUwvJju79iZZvxVLR8zSyfJ2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olTokGAj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vs44pS8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Feb 2024 14:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707315619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kozpYU4zhzBMEJHtumcjzPqZfIppI5+WA8tw9RJk16k=;
	b=olTokGAjoJWsb51oXOR7CrCjfpCv5k/Sv9tEurxTTvM2/sA4OJpqFI/N3eSU9+k496+kHf
	98L5y0A1kl5Bz4nGfPTx6WCaRNdIisOveidmx67SP5BSo2j6/PU1aSJ9OaDrGv4dA7XXhd
	GNyg7o4ibqKLRT0nDls/0nyt/Y2cXHpkkleOdCGUMTu7C5ABdEmbripWz+vZz47q8AWW8W
	6rc+K6x8o5FTHdvxJLw0GlWjyM65dFpzteFviUlU07mkgDv5WF/hZu6kDyWwiWUxJiE97D
	4OAkH81hAnNXLYDN1tiLXxYsGPgVuSs3WOsYspEyN/A3j6vCzXfWyDxxDSp42A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707315619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kozpYU4zhzBMEJHtumcjzPqZfIppI5+WA8tw9RJk16k=;
	b=vs44pS8yMeeroPwsFFVwXRXQoe39VhBOz1k7+OS7GNBmjy3aF950m+lgK7dXtMEJwNGtqf
	HXLEQ52hEG55qfAw==
From: "tip-bot2 for Ricardo B. Marliere" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Make clockevents_subsys const
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240204-bus_cleanup-time-v1-2-207ec18e24b8@marliere.net>
References: <20240204-bus_cleanup-time-v1-2-207ec18e24b8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170731561842.398.2305673935013890574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     49f1ff50d49fb8b40bc0271177de8092226396e9
Gitweb:        https://git.kernel.org/tip/49f1ff50d49fb8b40bc0271177de8092226396e9
Author:        Ricardo B. Marliere <ricardo@marliere.net>
AuthorDate:    Sun, 04 Feb 2024 10:40:16 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 15:11:24 +01:00

clockevents: Make clockevents_subsys const

Now that the driver core can properly handle constant struct bus_type,
move the clockevents_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240204-bus_cleanup-time-v1-2-207ec18e24b8@marliere.net
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 960143b..a7ca458 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -659,7 +659,7 @@ void tick_cleanup_dead_cpu(int cpu)
 #endif
 
 #ifdef CONFIG_SYSFS
-static struct bus_type clockevents_subsys = {
+static const struct bus_type clockevents_subsys = {
 	.name		= "clockevents",
 	.dev_name       = "clockevent",
 };

