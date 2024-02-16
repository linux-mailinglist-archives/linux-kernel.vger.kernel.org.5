Return-Path: <linux-kernel+bounces-68808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1E858097
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492011F2194E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C921350C7;
	Fri, 16 Feb 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXd0r8r0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eeWMfgNp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC511339A5;
	Fri, 16 Feb 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096624; cv=none; b=PTYw+zHYP3pfz62bh0gMEimqZNbZhHJISUJVmBRfgXzl0s5TuJSBl2E/TCVlY9Jf3sRXxA94r1uAcyBsPhSoCt1rEyzfbKx+FQpw/e1o6aPYY8t2738K5ZOkA5TcP2rgZ0DgZJHbH4aG3tn5nGC+ksviS1FkFfhnzrdZT7k+P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096624; c=relaxed/simple;
	bh=xmGVUZQmR7A+48wwUhUUo2iz3g7bbitu+Slr8/DjimA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NivvrxZmvpa0aW9BdOI3gZzjwxV2a/+qasc9gQCEL3jfqFpF7l2F8nTVi1OXcB5rzEvGEsoRgajoO1rQhSKnBLvAOh5PsM+v36inweIjtqkKZM7VK1SN6a0ovvvPzbX9xNEDGYYb09x6aOqxloTD2X/7LrWYTIbPjVvrb1oRkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXd0r8r0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eeWMfgNp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgU9XkMX1iVwxGYeW6SwPP/gtNmhIR2dG3bF01DfNTQ=;
	b=kXd0r8r0A6o6pspqzctFwophBRpAJ1gMNh9JqQqZsjhMg2Uln1Zgucl8gmKWVwMuD61YaV
	jPvz8syGlekj9WVu+91adfhgw5ITNSWUx0hmhbEK4uVfS9yUztiUBpnNnvncvTAkTi5lBr
	hCAEUkeRaXvpvKtsuwauOA9Bf7en61x0dt7bYx3F6pk8iuoiyB2SmPsMgtIuNJbOBw/k0Z
	RluCiDZ5v4LCDAeWtB0hsHkAkOF3foXuMzhLBiP0JcUzDsMiD/Cml76iVysblFRV5FMwnp
	RdWwqaArAEB+PGAx0u3Ov4YkMnv00CzqowxdJ+P6w7qCenzANxIoauK9C4RyNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgU9XkMX1iVwxGYeW6SwPP/gtNmhIR2dG3bF01DfNTQ=;
	b=eeWMfgNpcmGWYyttkmLjB2AJQ08O1PHqhEb4M8+2HI8OgTfPSxvCC/qBIq8dh6YNZGHsdf
	/gk52Pnadb8SliAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/smpboot: Make error message actually useful
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.170806023@linutronix.de>
References: <20240213210252.170806023@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662021.398.14979845209789031512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6055f6cf0d462fa0d9212a8279b6b0d1130552e1
Gitweb:        https://git.kernel.org/tip/6055f6cf0d462fa0d9212a8279b6b0d1130552e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/smpboot: Make error message actually useful

"smpboot: native_kick_ap: bad cpu 33" is absolutely useless information.

Replace it with something meaningful which allows to decode the failure
condition.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.170806023@linutronix.de



---
 arch/x86/kernel/smpboot.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index bfb99b5..d850fac 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1072,9 +1072,13 @@ int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID || !test_bit(apicid, phys_cpu_present_map) ||
-	    !apic_id_valid(apicid)) {
-		pr_err("%s: bad cpu %d\n", __func__, cpu);
+	if (apicid == BAD_APICID || !apic_id_valid(apicid)) {
+		pr_err("CPU %u has invalid APIC ID %x. Aborting bringup\n", cpu, apicid);
+		return -EINVAL;
+	}
+
+	if (!test_bit(apicid, phys_cpu_present_map)) {
+		pr_err("CPU %u APIC ID %x is not present. Aborting bringup\n", cpu, apicid);
 		return -EINVAL;
 	}
 

