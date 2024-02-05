Return-Path: <linux-kernel+bounces-52329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B4B8496C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277321F254C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA312B8F;
	Mon,  5 Feb 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bz1oHcMX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HsvGtviM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B212B82;
	Mon,  5 Feb 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125817; cv=none; b=kAgDZNdw+QaH9jm4DVzI1/FtGaa0QdVifBOhDP4aeYCoh+ZMimDJrspuUbut+etdfkBpnWP6VHYnS5APK18NTassqpNjc4tLj53q66u/OcBYNXb9pO45P38Y7CZ+/OMs/DCG0SnwCyfiKWqkWDc7I+yO8FzHWaUc+TlZepYEuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125817; c=relaxed/simple;
	bh=/UMKKN6NxFfb8jwEkxARmuLxv9BH3T30KPLMjbBrFAo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TMvSVsOkpAi93xltQGTVC5LAXyAyOg6aJrAH+xcXb6ZSjgxx6JGNm/Pyke50oiIy00MX6KLrTtWFlBYvclToKg/1tUhX+j8DXab5H4ispAAVEYzX/z4MA/WGmo36f3ckHfj1dUCpz7gb1jajrLuYrq/4vFSfplqINiFXvSwteGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bz1oHcMX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HsvGtviM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Feb 2024 09:36:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707125814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsNGUCXik/BBdyWTHl3ig5PONF9z/OOnIimWhvQp/sA=;
	b=Bz1oHcMX6cECLyb1tEGefhOJMvJyXfctxJ7lFZLN0nOWtPOh0HYjYmVHSlTyPrkxCnFkom
	wltvrTLji4+aZgobBphIuHQykHbbKdGMNb/LrZo/nqKgSQO/PEDsI2xiz1gGkcDvLetAqH
	r3rbv7yz3t7oEWJg/Gt3y3QJG4758P4gNkG9TPiEPaoW/JUMGzfSeFyDqn8GiwwCA5/pwH
	r+6ZaVHtm/JsufvNOhbU6Ni5IROxuMd1rGcqb5oGmML4LdaP1WMlMShG5Izrme6w/0uQmD
	o5diGei6sW9l4EqvI3SUI7tYuAe3KB2UgSch8NpAWIw8Ovwx84o3PYiwRYukfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707125814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsNGUCXik/BBdyWTHl3ig5PONF9z/OOnIimWhvQp/sA=;
	b=HsvGtviMVhaHwTHMcBUhJ6k9Giz/pPnaqfSjfR/2n1hPUfvkOcj19rTn2CaniTO563RAb2
	plYoIt9G/thFTBCg==
From: "tip-bot2 for Ricardo B. Marliere" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Make mce_subsys const
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240204-bus_cleanup-x86-v1-1-4e7171be88e8@marliere.net>
References: <20240204-bus_cleanup-x86-v1-1-4e7171be88e8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170712581333.398.15127302001154058196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a6a789165bbdb506b784f53b7467dbe0210494ad
Gitweb:        https://git.kernel.org/tip/a6a789165bbdb506b784f53b7467dbe0210494ad
Author:        Ricardo B. Marliere <ricardo@marliere.net>
AuthorDate:    Sun, 04 Feb 2024 11:32:29 -03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Feb 2024 10:26:51 +01:00

x86/mce: Make mce_subsys const

Now that the driver core can properly handle constant struct bus_type,
make mce_subsys a constant structure.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240204-bus_cleanup-x86-v1-1-4e7171be88e8@marliere.net
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252..a2f78f6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2431,7 +2431,7 @@ static void mce_enable_ce(void *all)
 		__mcheck_cpu_init_timer();
 }
 
-static struct bus_type mce_subsys = {
+static const struct bus_type mce_subsys = {
 	.name		= "machinecheck",
 	.dev_name	= "machinecheck",
 };

