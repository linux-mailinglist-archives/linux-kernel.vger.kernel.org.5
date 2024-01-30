Return-Path: <linux-kernel+bounces-44929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D33842929
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE22E28468F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4F12C544;
	Tue, 30 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swRF2k0T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="enkjKcJz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8012BEB4;
	Tue, 30 Jan 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631968; cv=none; b=fheJJ9/7dNz0xI9RwHAXf9Wet7B23skgDboM6syyrKQcSRaZt7l+wcnh3agY97ffDJxuvpafs2bG/ZahKLck/DTErl6txwEXOEJ8EBBb06QuegvLcvVMo9VyGh5xfatuYYLdI/o78rRM2919KLOBo0SMXjwGhIFoGq1IuXIRQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631968; c=relaxed/simple;
	bh=5JP4M61pKtI/S1wnqNWsOdEaP7Bvck0FGyX2CmnMetw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R8hPuHjkp47SOkdSw9Ma8U6/sAXQRS3j7E2oCQ2JYQF+NljVEVMPQNlseSYMFMF3CfgOlszS0Sl0TahqBAkYvxGdItH1wcbUPi5J+cLyUJMFbCKMjjTdZDR2bYwh7n3vom9TXrnMMPLrck90V6999j9cqAWkz+d9N5Sw3Id0H5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swRF2k0T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=enkjKcJz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrPbeicNf80Vrss0kEAZARyGEYS0l8xv1IijNHHcKUg=;
	b=swRF2k0Tap+tvPM/g1ViKYNpcCE5cN/mAQRJlN7nRly/Q/+Blr18BbVJzEYCeQP1xOktnV
	ntpiVI1wCnOh998TPd8IHd9xOMjdOzm87j/6X233dcWxtFEA+y/YCELG6ZnNs1o9xtpznd
	D+7feOJseBCTwUmT9s8qIXnBt5rxyS5bZrTMaeHglooKocbE0ozipJXGyuj0c4yonyhlgZ
	ZBtSSx0a1qIqXBELwsycLbvm6rJ5FugNUT0b/PlN9uQFY2U6C2ZoXeSkK6Tlf1aew2mkzA
	mmwIs8tCAkzD1sa+2abDRfbG73dQ6EdHd35OWWaFPI5bZb9TnljHr3rg4tUlJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrPbeicNf80Vrss0kEAZARyGEYS0l8xv1IijNHHcKUg=;
	b=enkjKcJz5vMl2JkKMgVXOXaLfQxRoVBW5HDPCEyPcIfCHMGo6rAwY9Zk4SLRwfg1Pkmaag
	cCYltFBGnkYW92Aw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Introduce an SNP leaked pages list
Cc: Vlastimil Babka <vbabka@suse.cz>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-16-michael.roth@amd.com>
References: <20240126041126.1927228-16-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196394.398.12352089864887604765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8dac642999b1542e0f0abefba100d8bd11226c83
Gitweb:        https://git.kernel.org/tip/8dac642999b1542e0f0abefba100d8bd11226c83
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:15 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

x86/sev: Introduce an SNP leaked pages list

Pages are unsafe to be released back to the page-allocator if they
have been transitioned to firmware/guest state and can't be reclaimed
or transitioned back to hypervisor/shared state. In this case, add them
to an internal leaked pages list to ensure that they are not freed or
touched/accessed to cause fatal page faults.

  [ mdr: Relocate to arch/x86/virt/svm/sev.c ]

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/r/20240126041126.1927228-16-michael.roth@amd.com
---
 arch/x86/include/asm/sev.h |  2 ++-
 arch/x86/virt/svm/sev.c    | 37 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 57fd95a..60de1b4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -264,6 +264,7 @@ void snp_dump_hva_rmpentry(unsigned long address);
 int psmash(u64 pfn);
 int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immutable);
 int rmp_make_shared(u64 pfn, enum pg_level level);
+void snp_leak_pages(u64 pfn, unsigned int npages);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
@@ -275,6 +276,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
 	return -ENODEV;
 }
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
+static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 #endif
 
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 5566fb0..0dffbf3 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -65,6 +65,11 @@ static u64 probed_rmp_base, probed_rmp_size;
 static struct rmpentry *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
+static LIST_HEAD(snp_leaked_pages_list);
+static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
+
+static unsigned long snp_nr_leaked_pages;
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"SEV-SNP: " fmt
 
@@ -515,3 +520,35 @@ int rmp_make_shared(u64 pfn, enum pg_level level)
 	return rmpupdate(pfn, &state);
 }
 EXPORT_SYMBOL_GPL(rmp_make_shared);
+
+void snp_leak_pages(u64 pfn, unsigned int npages)
+{
+	struct page *page = pfn_to_page(pfn);
+
+	pr_warn("Leaking PFN range 0x%llx-0x%llx\n", pfn, pfn + npages);
+
+	spin_lock(&snp_leaked_pages_list_lock);
+	while (npages--) {
+
+		/*
+		 * Reuse the page's buddy list for chaining into the leaked
+		 * pages list. This page should not be on a free list currently
+		 * and is also unsafe to be added to a free list.
+		 */
+		if (likely(!PageCompound(page)) ||
+
+			/*
+			 * Skip inserting tail pages of compound page as
+			 * page->buddy_list of tail pages is not usable.
+			 */
+		    (PageHead(page) && compound_nr(page) <= npages))
+			list_add_tail(&page->buddy_list, &snp_leaked_pages_list);
+
+		dump_rmpentry(pfn);
+		snp_nr_leaked_pages++;
+		pfn++;
+		page++;
+	}
+	spin_unlock(&snp_leaked_pages_list_lock);
+}
+EXPORT_SYMBOL_GPL(snp_leak_pages);

