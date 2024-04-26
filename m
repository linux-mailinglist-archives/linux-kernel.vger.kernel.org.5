Return-Path: <linux-kernel+bounces-160542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27A38B3EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE1428362D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD616F29C;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UzYpEzm4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNNfQl4q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066416D4FC;
	Fri, 26 Apr 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155134; cv=none; b=Q5cXsQRkTmcegI144vPtGETvZ2YNVAGZjNy2YjC+/Z17RRPXxNzglF15x7AHPa70/Ffk0Ims/zOy0PKYiZMjuuHH5spCvViOuD8YjsVgJN/5bucFwrUeW75MH7swGQpYWHCwBeb+RPt0CBrGzmykWqxdaaWg79UUiHhuC3U5lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155134; c=relaxed/simple;
	bh=M0/6dxxn2ac9JSDjU4AYf63Fq1/AqSf8rKsVk7d53Ao=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mULpMghnBfgTCDZFls90XSi8MdY6Kprmtp5dqGIl/WH4LV2ESyqRlh24Scse1D+5v16iNxTd2GHxy44pwahGIb01UqyxOts1mSEdNO2tRK1SHvSNBaVCl9+evJk/z85inSJJf4PnIK+C7Bhsvo7Pktxqj7IjVzA5B5WM1unUyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UzYpEzm4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNNfQl4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Fr/WCnH7KDRYDhl4fl/7pSWBCY8dLowYnDkMf3DOqkA=;
	b=UzYpEzm42DKreFBqYWJ1gjPRtF2x8lqveD1tM3QiduQphOz6SWTkqRW7WiOdNdzwNk7EXE
	voZDkw8hNfVXSNHdPsUSuAMG8D8150d8/bN5TG2OhU+yuEsirwHbXSqUvNIk2BKDKHgneY
	za0R1Dic97lj8cTwqKSvcOv0pXOxQZ2HtcweaRo2XDf8YmvjHf8bUheNxSmD2K9w16t89i
	B7OHLZWjn/okKDKCDJtJgdcx+Ga2GfC4ObIl73Ba4HIXlVOO+ccpjNRsjh9fUQ/OgZREeI
	jzxP/F2PRmjhno/WZA54cxnky8aBqDnG7Ubg67W+kdS6sm2i/4ms3ppswes7hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Fr/WCnH7KDRYDhl4fl/7pSWBCY8dLowYnDkMf3DOqkA=;
	b=uNNfQl4qmsCVH8EosDJrI3xl78fFz3xcc/mRwXEwtM3LB2xtPUxi9dMZV9iFIS2QCFUPjj
	PaBsUz+vBXMP5qCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513023.10875.10143009732306505173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e063b531d4e83a5bf4f9eb8ca67963df2cc00bc6
Gitweb:        https://git.kernel.org/tip/e063b531d4e83a5bf4f9eb8ca67963df2cc00bc6
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:18 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 09:11:39 -07:00

x86/mm: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align 0's in invlpg_miss_ids[] ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
 

