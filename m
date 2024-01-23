Return-Path: <linux-kernel+bounces-35079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3DD838B91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745EA1F23195
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2E5A78C;
	Tue, 23 Jan 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+UzPuFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YossnZ+O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3A5A11A;
	Tue, 23 Jan 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005109; cv=none; b=Uy1pOsPFFIZCmxtpAI8l9WjEyqsVIuzxOuD6RkK7NNI3a653GiSNBjj2n6ojHZ4xqi1KJgymXtKMjhi02lBytksqCuirTImwvIzOSHoa5nOXDTItwlTEJZNlzYoni57DbMKlrerKV79AyLujw/F9Ca/d0qsebRBjT6NWh9OfqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005109; c=relaxed/simple;
	bh=Ufi5+y3xMcTXZnStrHXggv74oAy3/6nMZaYLI8lehX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qo4f8upcxadzzwzpIG9VlV5+ZC+8W8/pPAG4KbOv5j09pAnuH5g9YAHq7I6QDblj3dui0zPQn6TuMu75KIWsCipMW6gAw/B9+xpOl60XJxL/aDikmR7NlrihKFzmmobk0xfe3C+6e11faVfsaWCmBAt+nlRzWRjAxdukSGHd6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+UzPuFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YossnZ+O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Jan 2024 10:18:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706005105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPUC4ccz7rJ9IclgL6ZQAnv9OAIyK95gf/85qpVL1BI=;
	b=w+UzPuFFBakKLHqxYC5g1hnsls3F8u+tZ5MUa/yIuvSlgujOLMe48RwG+oYqZY4rjuQcx8
	09fbYAzVcOFP0Yk5pqbHHI2dl6MkMqstE50WlGE9H+GCfL751R8pG0uiAUoWQgVXG4oltj
	1ZwGXfqjxzhJ5ZM0cy+G3Debu++0U0jqX4os3zAYIFl825/zrGW7n3CgDaKxJXXr1GFUUE
	IvjY5+cXfeUr/9oxmFxHV8kKB5fgVFnpoM4yyUw8l8V7mfcnZNVazKmCgI8WDWuwVFPZLC
	N4GAFXla8KP7FgLMWx2/mpZt1pJLIXr2+UX6u1rbj+6qvosBfHdV8YdqJcobZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706005105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPUC4ccz7rJ9IclgL6ZQAnv9OAIyK95gf/85qpVL1BI=;
	b=YossnZ+OQ0ysNQufulDr8O5rWrA+4vis8CYJ6HrlxYslyGrfeRXh6KY0V8bUw3svI0Evn/
	OAHPMq7IYGh9NBBQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add model number for Intel Clearwater
 Forest processor
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240117191844.56180-1-tony.luck@intel.com>
References: <20240117191844.56180-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170600510450.398.6705864231763807910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     090e3bec01763e415bccae445f5bfe3d0c61b629
Gitweb:        https://git.kernel.org/tip/090e3bec01763e415bccae445f5bfe3d0c61b629
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Jan 2024 11:18:44 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 23 Jan 2024 11:08:08 +01:00

x86/cpu: Add model number for Intel Clearwater Forest processor

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240117191844.56180-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 1973161..b65e9c4 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -162,6 +162,8 @@
 #define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
 #define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */

