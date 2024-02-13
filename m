Return-Path: <linux-kernel+bounces-63680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21E85332D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859CC1F274FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42E1E4B4;
	Tue, 13 Feb 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNSeHLKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66robOIf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050865F;
	Tue, 13 Feb 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834650; cv=none; b=OUvDSnrxWd15MdlNa3biPWBGYYmEx4wsiUZkX7vk0hyRGnjCB90dllWlV8bZLEwPzb1wUg9jIlJeejJjdc/1EA8zDjxz5yZz3w20iac8gxVM5fsxdTmvodlQj3AASwRjXWaNuGnzEwtEI82S8BJ3jI2kHt0GMO1HrvA1Sfr3/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834650; c=relaxed/simple;
	bh=c9rRowDIABkZ6H4WTk42Hcfmhnp+h138c7zkGcSRjiM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jb8dBQC4bvwnWKEf7labjaXFvJDXeMzVnhirLyVQppMw3qio/fHGc0vQ17fJ+iCEZmpmKrrzx28ZW5yswHqxiOX/TZXHrcf290QuK8yoqGhLdDBnJHKUub3TsFr0aG9wQ0slR60EJlY/vA3wIkjMkQyrUVqgkEQSyphW9ntOVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNSeHLKk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66robOIf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 14:30:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707834646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g07uhJRgsO8dhPnSV6zio+HFjoQMa4U7iOiNbyMNWYg=;
	b=ZNSeHLKkXPH7O7g/qYuw4CTjxqSmysbGaiGJ+e8Lt5+TZOg/9wE1PPe4NLTplvfp0JXvze
	9/gidJwRC9nV80eD8iLYgNVLFuiQJjR76WK2nAgJd9u5zqIy/HOH8I8vaOo0h7Kw2G00lm
	Rz7X0FHef6Ce9pYsZ9LOthlZ18FfSRObBUeY8KQqQzF9NDDZb5dNUyEllREg+BDZWcojx9
	loFvRMVXY4oqyRAftwPMfFeQYC6x+gxbKnCw08cgf9rnDm4u8Gxj5UgjSsRN1iMTlnZFjI
	GhMiWZNdtfR4fj10DSrh2G0ZciO+5gFJIlVahsTV9wsj2u33QMT8qechOK1Y7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707834646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g07uhJRgsO8dhPnSV6zio+HFjoQMa4U7iOiNbyMNWYg=;
	b=66robOIfivDYq6Loc4ftjAt2jjC7AV1tFED5PgmPr2UaZiyJNEF6/gbtWA1STU48bOU/a0
	sOVpJbb1hAvOcVAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] Documentation/maintainer-tip: Add C++ tail comments exception
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
References: <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170783464515.398.17242273988924436595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     7dd0a21ccb5a937ca9f798afad34de4ba030f8d4
Gitweb:        https://git.kernel.org/tip/7dd0a21ccb5a937ca9f798afad34de4ba030f8d4
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 12 Feb 2024 16:41:42 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Feb 2024 13:19:40 +01:00

Documentation/maintainer-tip: Add C++ tail comments exception

Document when C++-style, tail comments should be used.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local
---
 Documentation/process/maintainer-tip.rst | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 7993592..497bb39 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -480,7 +480,7 @@ Multi-line comments::
 	 * Larger multi-line comments should be split into paragraphs.
 	 */
 
-No tail comments:
+No tail comments (see below):
 
   Please refrain from using tail comments. Tail comments disturb the
   reading flow in almost all contexts, but especially in code::
@@ -501,6 +501,34 @@ No tail comments:
 	/* This magic initialization needs a comment. Maybe not? */
 	seed = MAGIC_CONSTANT;
 
+  Use C++ style, tail comments when documenting structs in headers to
+  achieve a more compact layout and better readability::
+
+        // eax
+        u32     x2apic_shift    :  5, // Number of bits to shift APIC ID right
+                                      // for the topology ID at the next level
+                                : 27; // Reserved
+        // ebx
+        u32     num_processors  : 16, // Number of processors at current level
+                                : 16; // Reserved
+
+  versus::
+
+	/* eax */
+	        /*
+	         * Number of bits to shift APIC ID right for the topology ID
+	         * at the next level
+	         */
+         u32     x2apic_shift    :  5,
+		 /* Reserved */
+				 : 27;
+
+	/* ebx */
+		/* Number of processors at current level */
+	u32     num_processors  : 16,
+		/* Reserved */
+				: 16;
+
 Comment the important things:
 
   Comments should be added where the operation is not obvious. Documenting

