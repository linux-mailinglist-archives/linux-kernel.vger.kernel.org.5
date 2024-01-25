Return-Path: <linux-kernel+bounces-39111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696983CAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CDD28D0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B014198B;
	Thu, 25 Jan 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXOGBBxB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxkxGbmT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9513E204;
	Thu, 25 Jan 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206902; cv=none; b=YMduz3fGJdjr7K5w6Snna7CYdrHk0G1erBfP4VIa42aSvnfDCDDplLKrsxMGNfj9xuHFFQVwZB+tdlzAm1QDquIuQnu28DNubg688saGRs2A2g2KBYXiF4AeInZKppQbC7LjgV5fekO3sM2CmOM4h5FID0F7y8i2UecexFBNusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206902; c=relaxed/simple;
	bh=hA/Q/1c0LrLKlbAhmhPM+mx3xg6o3L9ZCQtiyfxim4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KEsgAomlVYKQ87qzZ1Wq77hLCQQpaLbuls8mT1WQH52OIzXi59dU9qGGguv/T9aqUaEK6QcdpcYfMWAYJDypYTfqzIqBMFFmZF8e88/x6arQlVUh9g8ZK9SIBKUIjmbqL9aR8lTkItOfvaSOqkZ1/WGEmvg/e7v5sDSZIl9Eulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXOGBBxB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YxkxGbmT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WnmaBS5a0hWSnssVGIzFyIIpO/RUwcz7nbt83zfsNc=;
	b=jXOGBBxBMWg76cgMaL4klbPLSiaVnxUuqny7759GPrgYfhY8Z5vtk1SBu8H8Z5fmfIPJc9
	zbIyNG9/7SbeWNXwFeEQBCZyxH9CsZ9V8F/1hv84WeXmVOhyjrizx0Om4mZuy7O1LFJQes
	2OqwqbZRWGVlfpWVTPGK2oAdKdWOIqplvXgNsZD1LwJ81I23LcvbqVr2DobbFegr6nGj+U
	CztWtles3eLLZWYXY0GCFmjDRHoU0syqmzoZkMjAJVKxauOKyrJQBlyXaR+hli6iL1wAyO
	MojRVTSEF4EAK4hz3t5haE4qxGDFoByJ9pTD9a9JCD0njDUfsUZlUBVvEgO2Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WnmaBS5a0hWSnssVGIzFyIIpO/RUwcz7nbt83zfsNc=;
	b=YxkxGbmT11ecn1PqCBmrwyWdxfyxBCOnifeP3U0CoRj+VLIZ+8dEJBuiO+U7+YSuBzpImR
	z6+oppjrhxyh6LAQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/fred: Add Kconfig option for FRED (CONFIG_X86_FRED)
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-6-xin3.li@intel.com>
References: <20231205105030.8698-6-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689730.398.3143557912818753476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     2cce95918d635126098d784c040b59333c464b20
Gitweb:        https://git.kernel.org/tip/2cce95918d635126098d784c040b59333c464b20
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:54 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:30 +01:00

x86/fred: Add Kconfig option for FRED (CONFIG_X86_FRED)

Add the configuration option CONFIG_X86_FRED to enable FRED.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-6-xin3.li@intel.com

---
 arch/x86/Kconfig |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec17..854ab38 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -496,6 +496,15 @@ config X86_CPU_RESCTRL
 
 	  Say N if unsure.
 
+config X86_FRED
+	bool "Flexible Return and Event Delivery"
+	depends on X86_64
+	help
+	  When enabled, try to use Flexible Return and Event Delivery
+	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
+	  ring transitions and exception/interrupt handling if the
+	  system supports.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"

