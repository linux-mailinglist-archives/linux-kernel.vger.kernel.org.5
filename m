Return-Path: <linux-kernel+bounces-44928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C41842928
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D31F222DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678312C531;
	Tue, 30 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lZgopD7B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1UTC0dos"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389A12BEA8;
	Tue, 30 Jan 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631967; cv=none; b=i15jRZqL33eAglC3gBfUBWBxEGhOM8oUfJxWCmAY4EZ3XSB02iXW4PY2kPKD3CtadhMPPxa80Bmlqcz/CU5TaZwPTSNUSlvqi/PTAGz4YqDA71LDlLRgH1eM6H3HuhZihjCzgF3/TdbqvvfAH7SMptM1vTDOiY0hP6NGYH2aDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631967; c=relaxed/simple;
	bh=839WY41jTdZu1n09+gr3O/FvwyEVJBzb4fZESw4Waes=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rhayw9sL6iUKDazWf7ZVpI5hBTtRTd8jiPqY63imnC8LAMODOMDJDByzO9Eq02SlSgrQIucz/dLb1ISNsKBV9mw2ItkI/7QOGvXMzRpZREmHA+CK0eWPvQi3j/4VXqyi3m9AxcjVnYyZ4bRrqqK2dTlif6g9bTlsZRknH0tLt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lZgopD7B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1UTC0dos; arc=none smtp.client-ip=193.142.43.55
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
	bh=LPfRwdY8cKO09eRcyDhb43IC5NRJzN1n2eed6jd2pBY=;
	b=lZgopD7Bt91GUGcEQ8GJDI/2GSeeSWT96BH5gRU22hMGHKxzQxiCCl2JzCHh2eohtTkTJx
	QXMjIKRv121ZA0466F4fiHxZEaV7mJfGeMN/+gphccTH8FQRbX0PBhueiYyNH+OcryKDB5
	OrcuWCF8/i/qfl89oeguiFmFVyk4y0M6rJpTaReoGOSSIkd+TH/QXde0ulwEcjbE69WjEY
	PndMi78XiEFqBC43GZJg/XmUEEw8y+f7O85VKr8iql6DNP+qkQoXblY2+nHAEAPdApZ1rZ
	Cx3GIW9M7EVtVpUALfmx2bbJ4v1fIIQenOB0/WD6HyJo3bOGI4rYuCNWtGF0GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631964;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPfRwdY8cKO09eRcyDhb43IC5NRJzN1n2eed6jd2pBY=;
	b=1UTC0dos51TtTHj4OdtbILjYiZk5wN9zkKboojK1Zq0iHHAosc/naDxfIV/iCTANNBsV2+
	e7jm3Jst6kZX8rAg==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Handle the legacy TMR allocation when SNP
 is enabled
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-17-michael.roth@amd.com>
References: <20240126041126.1927228-17-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196323.398.4233160033064909038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     24512afa4336a1c14de750238abe32759cfba4b0
Gitweb:        https://git.kernel.org/tip/24512afa4336a1c14de750238abe32759cfba4b0
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:16 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

crypto: ccp: Handle the legacy TMR allocation when SNP is enabled

The behavior and requirement for the SEV-legacy command is altered when
the SNP firmware is in the INIT state. See SEV-SNP firmware ABI
specification for more details.

Allocate the Trusted Memory Region (TMR) as a 2MB-sized/aligned region
when SNP is enabled to satisfy new requirements for SNP. Continue
allocating a 1MB-sized region for !SNP configuration.

  [ bp: Carve out TMR allocation into a helper. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-17-michael.roth@amd.com
---
 drivers/crypto/ccp/sev-dev.c | 193 +++++++++++++++++++++++++++++-----
 include/linux/psp-sev.h      |   9 ++-
 2 files changed, 176 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index abee1a6..70aabd1 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -30,6 +30,7 @@
 #include <asm/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/e820/types.h>
+#include <asm/sev.h>
 
 #include "psp-dev.h"
 #include "sev-dev.h"
@@ -73,9 +74,14 @@ static int psp_timeout;
  *   The TMR is a 1MB area that must be 1MB aligned.  Use the page allocator
  *   to allocate the memory, which will return aligned memory for the specified
  *   allocation order.
+ *
+ * When SEV-SNP is enabled the TMR needs to be 2MB aligned and 2MB sized.
  */
-#define SEV_ES_TMR_SIZE		(1024 * 1024)
+#define SEV_TMR_SIZE		(1024 * 1024)
+#define SNP_TMR_SIZE		(2 * 1024 * 1024)
+
 static void *sev_es_tmr;
+static size_t sev_es_tmr_size = SEV_TMR_SIZE;
 
 /* INIT_EX NV Storage:
  *   The NV Storage is a 32Kb area and must be 4Kb page aligned.  Use the page
@@ -192,17 +198,6 @@ static int sev_cmd_buffer_len(int cmd)
 	return 0;
 }
 
-static void *sev_fw_alloc(unsigned long len)
-{
-	struct page *page;
-
-	page = alloc_pages(GFP_KERNEL, get_order(len));
-	if (!page)
-		return NULL;
-
-	return page_address(page);
-}
-
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
 	struct file *fp;
@@ -333,6 +328,142 @@ static int sev_write_init_ex_file_if_required(int cmd_id)
 	return sev_write_init_ex_file();
 }
 
+/*
+ * snp_reclaim_pages() needs __sev_do_cmd_locked(), and __sev_do_cmd_locked()
+ * needs snp_reclaim_pages(), so a forward declaration is needed.
+ */
+static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret);
+
+static int snp_reclaim_pages(unsigned long paddr, unsigned int npages, bool locked)
+{
+	int ret, err, i;
+
+	paddr = __sme_clr(ALIGN_DOWN(paddr, PAGE_SIZE));
+
+	for (i = 0; i < npages; i++, paddr += PAGE_SIZE) {
+		struct sev_data_snp_page_reclaim data = {0};
+
+		data.paddr = paddr;
+
+		if (locked)
+			ret = __sev_do_cmd_locked(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
+		else
+			ret = sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
+
+		if (ret)
+			goto cleanup;
+
+		ret = rmp_make_shared(__phys_to_pfn(paddr), PG_LEVEL_4K);
+		if (ret)
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	/*
+	 * If there was a failure reclaiming the page then it is no longer safe
+	 * to release it back to the system; leak it instead.
+	 */
+	snp_leak_pages(__phys_to_pfn(paddr), npages - i);
+	return ret;
+}
+
+static int rmp_mark_pages_firmware(unsigned long paddr, unsigned int npages, bool locked)
+{
+	unsigned long pfn = __sme_clr(paddr) >> PAGE_SHIFT;
+	int rc, i;
+
+	for (i = 0; i < npages; i++, pfn++) {
+		rc = rmp_make_private(pfn, 0, PG_LEVEL_4K, 0, true);
+		if (rc)
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	/*
+	 * Try unrolling the firmware state changes by
+	 * reclaiming the pages which were already changed to the
+	 * firmware state.
+	 */
+	snp_reclaim_pages(paddr, i, locked);
+
+	return rc;
+}
+
+static struct page *__snp_alloc_firmware_pages(gfp_t gfp_mask, int order)
+{
+	unsigned long npages = 1ul << order, paddr;
+	struct sev_device *sev;
+	struct page *page;
+
+	if (!psp_master || !psp_master->sev_data)
+		return NULL;
+
+	page = alloc_pages(gfp_mask, order);
+	if (!page)
+		return NULL;
+
+	/* If SEV-SNP is initialized then add the page in RMP table. */
+	sev = psp_master->sev_data;
+	if (!sev->snp_initialized)
+		return page;
+
+	paddr = __pa((unsigned long)page_address(page));
+	if (rmp_mark_pages_firmware(paddr, npages, false))
+		return NULL;
+
+	return page;
+}
+
+void *snp_alloc_firmware_page(gfp_t gfp_mask)
+{
+	struct page *page;
+
+	page = __snp_alloc_firmware_pages(gfp_mask, 0);
+
+	return page ? page_address(page) : NULL;
+}
+EXPORT_SYMBOL_GPL(snp_alloc_firmware_page);
+
+static void __snp_free_firmware_pages(struct page *page, int order, bool locked)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	unsigned long paddr, npages = 1ul << order;
+
+	if (!page)
+		return;
+
+	paddr = __pa((unsigned long)page_address(page));
+	if (sev->snp_initialized &&
+	    snp_reclaim_pages(paddr, npages, locked))
+		return;
+
+	__free_pages(page, order);
+}
+
+void snp_free_firmware_page(void *addr)
+{
+	if (!addr)
+		return;
+
+	__snp_free_firmware_pages(virt_to_page(addr), 0, false);
+}
+EXPORT_SYMBOL_GPL(snp_free_firmware_page);
+
+static void *sev_fw_alloc(unsigned long len)
+{
+	struct page *page;
+
+	page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(len));
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
@@ -456,7 +587,7 @@ static int __sev_init_locked(int *error)
 		data.tmr_address = __pa(sev_es_tmr);
 
 		data.flags |= SEV_INIT_FLAGS_SEV_ES;
-		data.tmr_len = SEV_ES_TMR_SIZE;
+		data.tmr_len = sev_es_tmr_size;
 	}
 
 	return __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
@@ -479,7 +610,7 @@ static int __sev_init_ex_locked(int *error)
 		data.tmr_address = __pa(sev_es_tmr);
 
 		data.flags |= SEV_INIT_FLAGS_SEV_ES;
-		data.tmr_len = SEV_ES_TMR_SIZE;
+		data.tmr_len = sev_es_tmr_size;
 	}
 
 	return __sev_do_cmd_locked(SEV_CMD_INIT_EX, &data, error);
@@ -623,9 +754,27 @@ static int __sev_snp_init_locked(int *error)
 	sev->snp_initialized = true;
 	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
 
+	sev_es_tmr_size = SNP_TMR_SIZE;
+
 	return rc;
 }
 
+static void __sev_platform_init_handle_tmr(struct sev_device *sev)
+{
+	if (sev_es_tmr)
+		return;
+
+	/* Obtain the TMR memory area for SEV-ES use */
+	sev_es_tmr = sev_fw_alloc(sev_es_tmr_size);
+	if (sev_es_tmr) {
+		/* Must flush the cache before giving it to the firmware */
+		if (!sev->snp_initialized)
+			clflush_cache_range(sev_es_tmr, sev_es_tmr_size);
+	} else {
+			dev_warn(sev->dev, "SEV: TMR allocation failed, SEV-ES support unavailable\n");
+	}
+}
+
 static int __sev_platform_init_locked(int *error)
 {
 	int rc, psp_ret = SEV_RET_NO_FW_CALL;
@@ -639,16 +788,7 @@ static int __sev_platform_init_locked(int *error)
 	if (sev->state == SEV_STATE_INIT)
 		return 0;
 
-	if (!sev_es_tmr) {
-		/* Obtain the TMR memory area for SEV-ES use */
-		sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
-		if (sev_es_tmr)
-			/* Must flush the cache before giving it to the firmware */
-			clflush_cache_range(sev_es_tmr, SEV_ES_TMR_SIZE);
-		else
-			dev_warn(sev->dev,
-				 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
-		}
+	__sev_platform_init_handle_tmr(sev);
 
 	if (sev_init_ex_buffer) {
 		rc = sev_read_init_ex_file();
@@ -1546,8 +1686,9 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 		/* The TMR area was encrypted, flush it from the cache */
 		wbinvd_on_all_cpus();
 
-		free_pages((unsigned long)sev_es_tmr,
-			   get_order(SEV_ES_TMR_SIZE));
+		__snp_free_firmware_pages(virt_to_page(sev_es_tmr),
+					  get_order(sev_es_tmr_size),
+					  false);
 		sev_es_tmr = NULL;
 	}
 
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index bcf9ced..84eabbf 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -932,6 +932,8 @@ int sev_guest_decommission(struct sev_data_decommission *data, int *error);
 int sev_do_cmd(int cmd, void *data, int *psp_ret);
 
 void *psp_copy_user_blob(u64 uaddr, u32 len);
+void *snp_alloc_firmware_page(gfp_t mask);
+void snp_free_firmware_page(void *addr);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -959,6 +961,13 @@ sev_issue_cmd_external_user(struct file *filep, unsigned int id, void *data, int
 
 static inline void *psp_copy_user_blob(u64 __user uaddr, u32 len) { return ERR_PTR(-EINVAL); }
 
+static inline void *snp_alloc_firmware_page(gfp_t mask)
+{
+	return NULL;
+}
+
+static inline void snp_free_firmware_page(void *addr) { }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */

