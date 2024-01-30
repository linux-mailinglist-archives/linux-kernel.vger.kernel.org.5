Return-Path: <linux-kernel+bounces-44926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65905842924
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEEF28B145
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34C12BF19;
	Tue, 30 Jan 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZjlWlqNy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hM5fW8wO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC412A16E;
	Tue, 30 Jan 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631966; cv=none; b=jSDL93QKUA39drJ87chFCHNXFVk0JzG7htV+f+cj7DpGbJU7xZCUQ3ooZJYBXGwQ2MEN/0adEag3V56IzvJ/PC4XyU5YAgpn2XDzD3T5DxB5wEBNxt/7tLGn993+w1Yfd8N9mZLkDBrjfrSz8n1tPVP8UwIyB0I08O88kVXFQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631966; c=relaxed/simple;
	bh=XOSl1ccCd64PZycXJPLIChK7CkdsOYI86QYMWKKeb3c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XB4gX6bk9mUOTUlNMHAzA1Z/DGnREDJqyiGImXtUFtOA1Nljp64e67QJDelmGA9jupoRKCmBEIs+s7YSffGf5BM8B23Zkm3iOtq3mpaPw9CLHbntBJ5WzB4n6jl9pmUtH18OfZW9KkJ7OyoSF2reZTzrnS6BvVjiDKHKs5qmwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZjlWlqNy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hM5fW8wO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWbJQaBeIA4O5Jk6M5TbZAHjzr2aB/GgnAy82wAMj5o=;
	b=ZjlWlqNyD+K13zDP89TIAnIASUNKebu3DD5Zx6w2SwAuQcYTCrNflEeX9kUT0B4yZWDVK3
	3oHPfe4wUYbywITK+UrRigi6UNvgIvxzKd1344LMMBR0E1/zzL1nPko56igW2OEVynNH/a
	ifIcm7Gq4N6Q0dnsHSbERtxqYQKxQ0agyY2HsPyXqaJW8ZLEKGo9+8i+VFZo5zReELmmME
	S7ZSZxExUUS7ELAfmsZm2zInMP9Vut36co9lQgJyAZBXueg2ayrWvSRhw9ez/HH1I1Yilw
	PUc9MEZYmZZ4jzM//cj2ux+bdKvpcGi/I2R0waUm9UYFTkCR6eAlrX4k2o3b8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWbJQaBeIA4O5Jk6M5TbZAHjzr2aB/GgnAy82wAMj5o=;
	b=hM5fW8wOZN6hxZAkuEn7rN5K/1mSqpWfUCU23ItGmXu1W4KbRmNPiCnvtP7WloP1gj45TY
	pGrc9GG1al+dEUAw==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] crypto: ccp: Handle legacy SEV commands when SNP is enabled
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-19-michael.roth@amd.com>
References: <20240126041126.1927228-19-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196093.398.12489295405473544531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a867ad6b340f47b7333b80a54b8507fc2cd80aa4
Gitweb:        https://git.kernel.org/tip/a867ad6b340f47b7333b80a54b8507fc2cd80aa4
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:18 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

crypto: ccp: Handle legacy SEV commands when SNP is enabled

The behavior of legacy SEV commands is altered when the firmware is
initialized for SNP support. In that case, all command buffer memory
that may get written to by legacy SEV commands must be marked as
firmware-owned in the RMP table prior to issuing the command.

Additionally, when a command buffer contains a system physical address
that points to additional buffers that firmware may write to, special
handling is needed depending on whether:

  1) the system physical address points to guest memory
  2) the system physical address points to host memory

To handle case #1, the pages of these buffers are changed to
firmware-owned in the RMP table before issuing the command, and restored
to hypervisor-owned after the command completes.

For case #2, a bounce buffer is used instead of the original address.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-19-michael.roth@amd.com
---
 drivers/crypto/ccp/sev-dev.c | 423 +++++++++++++++++++++++++++++++++-
 drivers/crypto/ccp/sev-dev.h |   3 +-
 2 files changed, 416 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 5ec5636..a70f8b1 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -43,6 +43,15 @@
 #define SNP_MIN_API_MAJOR	1
 #define SNP_MIN_API_MINOR	51
 
+/*
+ * Maximum number of firmware-writable buffers that might be specified
+ * in the parameters of a legacy SEV command buffer.
+ */
+#define CMD_BUF_FW_WRITABLE_MAX 2
+
+/* Leave room in the descriptor array for an end-of-list indicator. */
+#define CMD_BUF_DESC_MAX (CMD_BUF_FW_WRITABLE_MAX + 1)
+
 static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
 
@@ -464,13 +473,349 @@ static void *sev_fw_alloc(unsigned long len)
 	return page_address(page);
 }
 
+/**
+ * struct cmd_buf_desc - descriptors for managing legacy SEV command address
+ * parameters corresponding to buffers that may be written to by firmware.
+ *
+ * @paddr_ptr:  pointer to the address parameter in the command buffer which may
+ *              need to be saved/restored depending on whether a bounce buffer
+ *              is used. In the case of a bounce buffer, the command buffer
+ *              needs to be updated with the address of the new bounce buffer
+ *              snp_map_cmd_buf_desc() has allocated specifically for it. Must
+ *              be NULL if this descriptor is only an end-of-list indicator.
+ *
+ * @paddr_orig: storage for the original address parameter, which can be used to
+ *              restore the original value in @paddr_ptr in cases where it is
+ *              replaced with the address of a bounce buffer.
+ *
+ * @len: length of buffer located at the address originally stored at @paddr_ptr
+ *
+ * @guest_owned: true if the address corresponds to guest-owned pages, in which
+ *               case bounce buffers are not needed.
+ */
+struct cmd_buf_desc {
+	u64 *paddr_ptr;
+	u64 paddr_orig;
+	u32 len;
+	bool guest_owned;
+};
+
+/*
+ * If a legacy SEV command parameter is a memory address, those pages in
+ * turn need to be transitioned to/from firmware-owned before/after
+ * executing the firmware command.
+ *
+ * Additionally, in cases where those pages are not guest-owned, a bounce
+ * buffer is needed in place of the original memory address parameter.
+ *
+ * A set of descriptors are used to keep track of this handling, and
+ * initialized here based on the specific commands being executed.
+ */
+static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
+					   struct cmd_buf_desc *desc_list)
+{
+	switch (cmd) {
+	case SEV_CMD_PDH_CERT_EXPORT: {
+		struct sev_data_pdh_cert_export *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->pdh_cert_address;
+		desc_list[0].len = data->pdh_cert_len;
+		desc_list[1].paddr_ptr = &data->cert_chain_address;
+		desc_list[1].len = data->cert_chain_len;
+		break;
+	}
+	case SEV_CMD_GET_ID: {
+		struct sev_data_get_id *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->address;
+		desc_list[0].len = data->len;
+		break;
+	}
+	case SEV_CMD_PEK_CSR: {
+		struct sev_data_pek_csr *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->address;
+		desc_list[0].len = data->len;
+		break;
+	}
+	case SEV_CMD_LAUNCH_UPDATE_DATA: {
+		struct sev_data_launch_update_data *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->address;
+		desc_list[0].len = data->len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	case SEV_CMD_LAUNCH_UPDATE_VMSA: {
+		struct sev_data_launch_update_vmsa *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->address;
+		desc_list[0].len = data->len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	case SEV_CMD_LAUNCH_MEASURE: {
+		struct sev_data_launch_measure *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->address;
+		desc_list[0].len = data->len;
+		break;
+	}
+	case SEV_CMD_LAUNCH_UPDATE_SECRET: {
+		struct sev_data_launch_secret *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->guest_address;
+		desc_list[0].len = data->guest_len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	case SEV_CMD_DBG_DECRYPT: {
+		struct sev_data_dbg *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->dst_addr;
+		desc_list[0].len = data->len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	case SEV_CMD_DBG_ENCRYPT: {
+		struct sev_data_dbg *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->dst_addr;
+		desc_list[0].len = data->len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	case SEV_CMD_ATTESTATION_REPORT: {
+		struct sev_data_attestation_report *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->address;
+		desc_list[0].len = data->len;
+		break;
+	}
+	case SEV_CMD_SEND_START: {
+		struct sev_data_send_start *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->session_address;
+		desc_list[0].len = data->session_len;
+		break;
+	}
+	case SEV_CMD_SEND_UPDATE_DATA: {
+		struct sev_data_send_update_data *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->hdr_address;
+		desc_list[0].len = data->hdr_len;
+		desc_list[1].paddr_ptr = &data->trans_address;
+		desc_list[1].len = data->trans_len;
+		break;
+	}
+	case SEV_CMD_SEND_UPDATE_VMSA: {
+		struct sev_data_send_update_vmsa *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->hdr_address;
+		desc_list[0].len = data->hdr_len;
+		desc_list[1].paddr_ptr = &data->trans_address;
+		desc_list[1].len = data->trans_len;
+		break;
+	}
+	case SEV_CMD_RECEIVE_UPDATE_DATA: {
+		struct sev_data_receive_update_data *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->guest_address;
+		desc_list[0].len = data->guest_len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	case SEV_CMD_RECEIVE_UPDATE_VMSA: {
+		struct sev_data_receive_update_vmsa *data = cmd_buf;
+
+		desc_list[0].paddr_ptr = &data->guest_address;
+		desc_list[0].len = data->guest_len;
+		desc_list[0].guest_owned = true;
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static int snp_map_cmd_buf_desc(struct cmd_buf_desc *desc)
+{
+	unsigned int npages;
+
+	if (!desc->len)
+		return 0;
+
+	/* Allocate a bounce buffer if this isn't a guest owned page. */
+	if (!desc->guest_owned) {
+		struct page *page;
+
+		page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(desc->len));
+		if (!page) {
+			pr_warn("Failed to allocate bounce buffer for SEV legacy command.\n");
+			return -ENOMEM;
+		}
+
+		desc->paddr_orig = *desc->paddr_ptr;
+		*desc->paddr_ptr = __psp_pa(page_to_virt(page));
+	}
+
+	npages = PAGE_ALIGN(desc->len) >> PAGE_SHIFT;
+
+	/* Transition the buffer to firmware-owned. */
+	if (rmp_mark_pages_firmware(*desc->paddr_ptr, npages, true)) {
+		pr_warn("Error moving pages to firmware-owned state for SEV legacy command.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int snp_unmap_cmd_buf_desc(struct cmd_buf_desc *desc)
+{
+	unsigned int npages;
+
+	if (!desc->len)
+		return 0;
+
+	npages = PAGE_ALIGN(desc->len) >> PAGE_SHIFT;
+
+	/* Transition the buffers back to hypervisor-owned. */
+	if (snp_reclaim_pages(*desc->paddr_ptr, npages, true)) {
+		pr_warn("Failed to reclaim firmware-owned pages while issuing SEV legacy command.\n");
+		return -EFAULT;
+	}
+
+	/* Copy data from bounce buffer and then free it. */
+	if (!desc->guest_owned) {
+		void *bounce_buf = __va(__sme_clr(*desc->paddr_ptr));
+		void *dst_buf = __va(__sme_clr(desc->paddr_orig));
+
+		memcpy(dst_buf, bounce_buf, desc->len);
+		__free_pages(virt_to_page(bounce_buf), get_order(desc->len));
+
+		/* Restore the original address in the command buffer. */
+		*desc->paddr_ptr = desc->paddr_orig;
+	}
+
+	return 0;
+}
+
+static int snp_map_cmd_buf_desc_list(int cmd, void *cmd_buf, struct cmd_buf_desc *desc_list)
+{
+	int i;
+
+	snp_populate_cmd_buf_desc_list(cmd, cmd_buf, desc_list);
+
+	for (i = 0; i < CMD_BUF_DESC_MAX; i++) {
+		struct cmd_buf_desc *desc = &desc_list[i];
+
+		if (!desc->paddr_ptr)
+			break;
+
+		if (snp_map_cmd_buf_desc(desc))
+			goto err_unmap;
+	}
+
+	return 0;
+
+err_unmap:
+	for (i--; i >= 0; i--)
+		snp_unmap_cmd_buf_desc(&desc_list[i]);
+
+	return -EFAULT;
+}
+
+static int snp_unmap_cmd_buf_desc_list(struct cmd_buf_desc *desc_list)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < CMD_BUF_DESC_MAX; i++) {
+		struct cmd_buf_desc *desc = &desc_list[i];
+
+		if (!desc->paddr_ptr)
+			break;
+
+		if (snp_unmap_cmd_buf_desc(&desc_list[i]))
+			ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+static bool sev_cmd_buf_writable(int cmd)
+{
+	switch (cmd) {
+	case SEV_CMD_PLATFORM_STATUS:
+	case SEV_CMD_GUEST_STATUS:
+	case SEV_CMD_LAUNCH_START:
+	case SEV_CMD_RECEIVE_START:
+	case SEV_CMD_LAUNCH_MEASURE:
+	case SEV_CMD_SEND_START:
+	case SEV_CMD_SEND_UPDATE_DATA:
+	case SEV_CMD_SEND_UPDATE_VMSA:
+	case SEV_CMD_PEK_CSR:
+	case SEV_CMD_PDH_CERT_EXPORT:
+	case SEV_CMD_GET_ID:
+	case SEV_CMD_ATTESTATION_REPORT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* After SNP is INIT'ed, the behavior of legacy SEV commands is changed. */
+static bool snp_legacy_handling_needed(int cmd)
+{
+	struct sev_device *sev = psp_master->sev_data;
+
+	return cmd < SEV_CMD_SNP_INIT && sev->snp_initialized;
+}
+
+static int snp_prep_cmd_buf(int cmd, void *cmd_buf, struct cmd_buf_desc *desc_list)
+{
+	if (!snp_legacy_handling_needed(cmd))
+		return 0;
+
+	if (snp_map_cmd_buf_desc_list(cmd, cmd_buf, desc_list))
+		return -EFAULT;
+
+	/*
+	 * Before command execution, the command buffer needs to be put into
+	 * the firmware-owned state.
+	 */
+	if (sev_cmd_buf_writable(cmd)) {
+		if (rmp_mark_pages_firmware(__pa(cmd_buf), 1, true))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int snp_reclaim_cmd_buf(int cmd, void *cmd_buf)
+{
+	if (!snp_legacy_handling_needed(cmd))
+		return 0;
+
+	/*
+	 * After command completion, the command buffer needs to be put back
+	 * into the hypervisor-owned state.
+	 */
+	if (sev_cmd_buf_writable(cmd))
+		if (snp_reclaim_pages(__pa(cmd_buf), 1, true))
+			return -EFAULT;
+
+	return 0;
+}
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
+	struct cmd_buf_desc desc_list[CMD_BUF_DESC_MAX] = {0};
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
 	unsigned int cmdbuff_hi, cmdbuff_lo;
 	unsigned int phys_lsb, phys_msb;
 	unsigned int reg, ret = 0;
+	void *cmd_buf;
 	int buf_len;
 
 	if (!psp || !psp->sev_data)
@@ -490,12 +835,47 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	 * work for some memory, e.g. vmalloc'd addresses, and @data may not be
 	 * physically contiguous.
 	 */
-	if (data)
-		memcpy(sev->cmd_buf, data, buf_len);
+	if (data) {
+		/*
+		 * Commands are generally issued one at a time and require the
+		 * sev_cmd_mutex, but there could be recursive firmware requests
+		 * due to SEV_CMD_SNP_PAGE_RECLAIM needing to be issued while
+		 * preparing buffers for another command. This is the only known
+		 * case of nesting in the current code, so exactly one
+		 * additional command buffer is available for that purpose.
+		 */
+		if (!sev->cmd_buf_active) {
+			cmd_buf = sev->cmd_buf;
+			sev->cmd_buf_active = true;
+		} else if (!sev->cmd_buf_backup_active) {
+			cmd_buf = sev->cmd_buf_backup;
+			sev->cmd_buf_backup_active = true;
+		} else {
+			dev_err(sev->dev,
+				"SEV: too many firmware commands in progress, no command buffers available.\n");
+			return -EBUSY;
+		}
+
+		memcpy(cmd_buf, data, buf_len);
+
+		/*
+		 * The behavior of the SEV-legacy commands is altered when the
+		 * SNP firmware is in the INIT state.
+		 */
+		ret = snp_prep_cmd_buf(cmd, cmd_buf, desc_list);
+		if (ret) {
+			dev_err(sev->dev,
+				"SEV: failed to prepare buffer for legacy command 0x%x. Error: %d\n",
+				cmd, ret);
+			return ret;
+		}
+	} else {
+		cmd_buf = sev->cmd_buf;
+	}
 
 	/* Get the physical address of the command buffer */
-	phys_lsb = data ? lower_32_bits(__psp_pa(sev->cmd_buf)) : 0;
-	phys_msb = data ? upper_32_bits(__psp_pa(sev->cmd_buf)) : 0;
+	phys_lsb = data ? lower_32_bits(__psp_pa(cmd_buf)) : 0;
+	phys_msb = data ? upper_32_bits(__psp_pa(cmd_buf)) : 0;
 
 	dev_dbg(sev->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
 		cmd, phys_msb, phys_lsb, psp_timeout);
@@ -549,15 +929,36 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 		ret = sev_write_init_ex_file_if_required(cmd);
 	}
 
-	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     buf_len, false);
-
 	/*
 	 * Copy potential output from the PSP back to data.  Do this even on
 	 * failure in case the caller wants to glean something from the error.
 	 */
-	if (data)
-		memcpy(data, sev->cmd_buf, buf_len);
+	if (data) {
+		int ret_reclaim;
+		/*
+		 * Restore the page state after the command completes.
+		 */
+		ret_reclaim = snp_reclaim_cmd_buf(cmd, cmd_buf);
+		if (ret_reclaim) {
+			dev_err(sev->dev,
+				"SEV: failed to reclaim buffer for legacy command %#x. Error: %d\n",
+				cmd, ret_reclaim);
+			return ret_reclaim;
+		}
+
+		memcpy(data, cmd_buf, buf_len);
+
+		if (sev->cmd_buf_backup_active)
+			sev->cmd_buf_backup_active = false;
+		else
+			sev->cmd_buf_active = false;
+
+		if (snp_unmap_cmd_buf_desc_list(desc_list))
+			return -EFAULT;
+	}
+
+	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
+			     buf_len, false);
 
 	return ret;
 }
@@ -1674,10 +2075,12 @@ int sev_dev_init(struct psp_device *psp)
 	if (!sev)
 		goto e_err;
 
-	sev->cmd_buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	sev->cmd_buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 1);
 	if (!sev->cmd_buf)
 		goto e_sev;
 
+	sev->cmd_buf_backup = (uint8_t *)sev->cmd_buf + PAGE_SIZE;
+
 	psp->sev_data = sev;
 
 	sev->dev = dev;
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 8550632..3e4e557 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -52,6 +52,9 @@ struct sev_device {
 	u8 build;
 
 	void *cmd_buf;
+	void *cmd_buf_backup;
+	bool cmd_buf_active;
+	bool cmd_buf_backup_active;
 
 	bool snp_initialized;
 };

