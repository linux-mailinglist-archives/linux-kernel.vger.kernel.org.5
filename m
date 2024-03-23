Return-Path: <linux-kernel+bounces-112351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864918878CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCA51C22888
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0E3D57A;
	Sat, 23 Mar 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y9O+cQuR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9q8WkKA8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE111A38F4;
	Sat, 23 Mar 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200300; cv=none; b=gL1YI3M99jSnRM0fyDQ3rgkCgD7HjmYcUufK60k81gZtQiISEQlOq0s1MrxmxS21IV5uEPR0HIfhcWHMAtoBDsm97LP5TpAWYYauX/Et4BQyPWD8jQCZL+ScBEAgyGfJrWN9ySP3JY/B70Niw9LZtVUFPwo4KvsSNQwDaL42ntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200300; c=relaxed/simple;
	bh=PUegoWtVbVsTOssF/F6A0QiL3Yc+be7NTlizNkiEBpI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gS5eWdLdz7SGEya+gXu1ak+mpxIfpLG2FLIviHwDnUYF4Vg4aQnGLu2zedy6/Sff8u8p4/v39CaxdvkqonVPFh6m0oP9pt3bYIH6Z0F1uOmUqWmN46gnbJvo1qNZTf5qRAvRUDwwIo4SrBXVh1JkhYsZFaosjVWexZX6GJlAKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y9O+cQuR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9q8WkKA8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Mar 2024 13:24:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711200289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nf1eieQ1PpZ/ZqZr7mlBm08sfKGoHQOuoGoF0oSLuFU=;
	b=Y9O+cQuRh1I7BzwONpoAeZynQJ1VeiOkSB9rqsRqo2w06oSQL0IveHZi1bw44maQZtPgqc
	FYKQUBUJ5/AzMtjJmjge1jb3EGwSeG2mjYU6W6XQ+NbJNu9yi1umOvCOGLzVjJtzIHy0n7
	XSRLxk4VqnxcAnUiXRsxEC0cUeNLuRfcAfU3GniMPE+A2TyPXNystZTvujofpe52QsULRA
	a9xC4D7FfWjfO3AbutetcgxmF27NykcnIUaSxbh6JFurJKSWQr2Djkrg8DF3UbIgmiUAZs
	IyqTjQBtkNj++fkP87c4ZbIgPLdbrn3ksquSLUjENelEntK8CA70WK84glTY9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711200289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nf1eieQ1PpZ/ZqZr7mlBm08sfKGoHQOuoGoF0oSLuFU=;
	b=9q8WkKA8NadBMfEulqW5IkjMuIo3PLO5DSKXYbiYCC37fOjQyTFz3IWKUD/7IgIG+lkQ4Q
	i3ZhNuff3qyT/vAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mpparse: Register APIC address only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322185305.297774848@linutronix.de>
References: <20240322185305.297774848@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171120028858.10875.13533785282906224484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f2208aa12c27bfada3c15c550c03ca81d42dcac2
Gitweb:        https://git.kernel.org/tip/f2208aa12c27bfada3c15c550c03ca81d42dcac2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Mar 2024 19:56:39 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 23 Mar 2024 12:41:48 +01:00

x86/mpparse: Register APIC address only once

The APIC address is registered twice. First during the early detection and
afterwards when actually scanning the table for APIC IDs. The APIC and
topology core warn about the second attempt.

Restrict it to the early detection call.

Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240322185305.297774848@linutronix.de
---
 arch/x86/kernel/mpparse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 1ccd30c..e89171b 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -197,12 +197,12 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
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

