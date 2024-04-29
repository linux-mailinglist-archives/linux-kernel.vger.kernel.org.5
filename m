Return-Path: <linux-kernel+bounces-161946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAB8B53AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0D1F21BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB092838E;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3qYQm4V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rs9i9zbt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB117C8D;
	Mon, 29 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381323; cv=none; b=aYXpsxgKbMEtaUWH8SikxVKgII22iaiyI/AJmLDxVQ+JIVYcjGC2Jxg25I+Mkbvz8QSr+2X5Zvz+Tiq2SuRTED3cnNDIhahSE4UbqXKzB48+3j9R9S4hWWzuj8QqoFbI5RI0uopwVslS7TanXcKw1mbJE6C0tE+e7Kpn3gPxA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381323; c=relaxed/simple;
	bh=y9m9l6FwfStRD/VKBQNQwbRGqY1Ehc339DtZQQUbsjI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XEo3l/pGb73pZ8kHmbA6OAhhBUM9WQw5Dbs/okPcQMyf6m7WnHJ7pGIVURbYgw5ZvDCl/OgUYBZwTp3+nFtu3rHJv4zXLjVgb9PElcSskGdISUYSSXeIUWhEP8UuHpezkKNetWVeWM6HjqwRVqgQAV45lLUZ8sawsMqyDFzM2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3qYQm4V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rs9i9zbt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ogeoc09PssNiX+ZrFo0TjrSh9rtFLEIsFW15BoHbW0Q=;
	b=M3qYQm4VT1ZnfiMleXtX1LvnPzh7NQ8zGQmn9PxB4bSSK4Wvms1RLxkPIFb4Us9A1HorXY
	5SfX5GIs7slWG7C2cWk1ybQx9ygAyrAZHHKYJ3V7FYBAN0jNr/XQs0AuJjR/hlxsWinIdt
	I0hRr2FXyE3E5+RRmaTXhIi0ZzDpYPcNMCWzWBeoAWHRnm44pvYtfjjz8KPjzPH//C52C0
	DgNgZlXlVU7XXfRMHqO9wfxTdail7m6CdDxFA4iC7yfEqhhXdVTzjqyT30sRL+KVmiiGa5
	nVStzh6aBwfp4t70NOXgQgD88wZWc0rPdiP3b6nw71n7JVOfQH69Ds1IqvyM2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ogeoc09PssNiX+ZrFo0TjrSh9rtFLEIsFW15BoHbW0Q=;
	b=Rs9i9zbtpAcYYCX0gv/5BzFW30HltGHIStkxxyXkesBdLY2F8wqJIdHKXl1hiSidm22Tx0
	lF7SsZUnRts6axDA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131342.10875.1337227132965342852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2eda374e883ad297bd9fe575a16c1dc850346075
Gitweb:        https://git.kernel.org/tip/2eda374e883ad297bd9fe575a16c1dc850346075
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:18 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:36 +02:00

x86/mm: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align 0's in invlpg_miss_ids[] ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com
---
 arch/x86/mm/init.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893e..6b43b64 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,21 +261,17 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
 	{}
 };
 

