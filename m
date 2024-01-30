Return-Path: <linux-kernel+bounces-44931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023DF84292F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271B81C25C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87012CDBB;
	Tue, 30 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05pGPqO+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/wzBmFoU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BC12BF1E;
	Tue, 30 Jan 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631970; cv=none; b=vC5DluNQUZ00YQKFuiwWO73WWiuifnLReetOnqQV2Wiqcne9yt9u7jWuO7jHsZH+nZjue0DyQShKO7MriR/vb8IsH58eMwSk9Izc+iGTUcHE/00jqJ1eiYay44nHEGC3B50FvevWnoIX0K12KRf9HN/Bu5JewUoqzlYAOg2VQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631970; c=relaxed/simple;
	bh=XoYO/RHZW0wFVhbz6rEPP4w5kg6n8UXpcDIeNyFC7hM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uXf0BAifobk1X8izX+g6Dpl7bm+2cb9l/Z7RtU9TolHLtUVFjJ+/ubQtYXA+auOwX/m09k/UBlBPh8avlfYVKOJdCu1Ejpi+BeFrXi1xgU3FAG2+wwok9y6xBslriGDgswu7dUXJdnsPcaWPmlTtiLniAVpnDPMsHgBn+p7U4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05pGPqO+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/wzBmFoU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbsX8diTl8BP4KV0FXY6wEev1eVETLcwoITGRBAQxa8=;
	b=05pGPqO+xcvOAkYR/OljEzafskuDGo/mgEwBnkgb5MqUn7YVyVWz+svUy3azz8yr7rFnea
	Pwx4fuenAUOdP8x3MYM75RpZLk3BRKZZa+Dl6dR2kXndicf4uAOgCcygvXMBcsju1SLmLz
	kWrHd9V9pdRdJiTRSTDibnueeFr/iufzTk0J8Asl74nE8ROWNsMvJmPMnRoQYZJTcqjjyg
	4Ydonh+P0T/7WDtP8T6NAu7/8rNcr9nPXUOhBj89djkHmEtplAHAWElmy4akPIpwyCkDP2
	Qf8TrgaETwVMi65OeujY2l1yojMMQEpET3/HJgdx7w2GfqKu0sri+7ZN7RaAXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbsX8diTl8BP4KV0FXY6wEev1eVETLcwoITGRBAQxa8=;
	b=/wzBmFoUZnGDigwrDQTzPsFtUYKA5i/0hyzem95u5AIgdOh0iZrlWEIZOCEBYfe8Ig9L9H
	UQ9Uivf8xsvWWsAQ==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Define the SEV-SNP commands
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-13-michael.roth@amd.com>
References: <20240126041126.1927228-13-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196572.398.17624374620485683075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     3a45dc2b419e691f3dd7fb42c2a1b1cc8146be4f
Gitweb:        https://git.kernel.org/tip/3a45dc2b419e691f3dd7fb42c2a1b1cc8146be4f
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:12 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

crypto: ccp: Define the SEV-SNP commands

AMD introduced the next generation of SEV called SEV-SNP (Secure Nested
Paging). SEV-SNP builds upon existing SEV and SEV-ES functionality while
adding new hardware security protection.

Define the commands and structures used to communicate with the AMD-SP
when creating and managing the SEV-SNP guests. The SEV-SNP firmware spec
is available at developer.amd.com/sev.

  [ mdr: update SNP command list and SNP status struct based on current
    spec, use C99 flexible arrays, fix kernel-doc issues. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-13-michael.roth@amd.com
---
 drivers/crypto/ccp/sev-dev.c |  16 ++-
 include/linux/psp-sev.h      | 265 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/psp-sev.h |  56 +++++++-
 3 files changed, 337 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e4d3f45..e38986d 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -130,6 +130,8 @@ static int sev_cmd_buffer_len(int cmd)
 	switch (cmd) {
 	case SEV_CMD_INIT:			return sizeof(struct sev_data_init);
 	case SEV_CMD_INIT_EX:                   return sizeof(struct sev_data_init_ex);
+	case SEV_CMD_SNP_SHUTDOWN_EX:		return sizeof(struct sev_data_snp_shutdown_ex);
+	case SEV_CMD_SNP_INIT_EX:		return sizeof(struct sev_data_snp_init_ex);
 	case SEV_CMD_PLATFORM_STATUS:		return sizeof(struct sev_user_data_status);
 	case SEV_CMD_PEK_CSR:			return sizeof(struct sev_data_pek_csr);
 	case SEV_CMD_PEK_CERT_IMPORT:		return sizeof(struct sev_data_pek_cert_import);
@@ -158,6 +160,20 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_GET_ID:			return sizeof(struct sev_data_get_id);
 	case SEV_CMD_ATTESTATION_REPORT:	return sizeof(struct sev_data_attestation_report);
 	case SEV_CMD_SEND_CANCEL:		return sizeof(struct sev_data_send_cancel);
+	case SEV_CMD_SNP_GCTX_CREATE:		return sizeof(struct sev_data_snp_addr);
+	case SEV_CMD_SNP_LAUNCH_START:		return sizeof(struct sev_data_snp_launch_start);
+	case SEV_CMD_SNP_LAUNCH_UPDATE:		return sizeof(struct sev_data_snp_launch_update);
+	case SEV_CMD_SNP_ACTIVATE:		return sizeof(struct sev_data_snp_activate);
+	case SEV_CMD_SNP_DECOMMISSION:		return sizeof(struct sev_data_snp_addr);
+	case SEV_CMD_SNP_PAGE_RECLAIM:		return sizeof(struct sev_data_snp_page_reclaim);
+	case SEV_CMD_SNP_GUEST_STATUS:		return sizeof(struct sev_data_snp_guest_status);
+	case SEV_CMD_SNP_LAUNCH_FINISH:		return sizeof(struct sev_data_snp_launch_finish);
+	case SEV_CMD_SNP_DBG_DECRYPT:		return sizeof(struct sev_data_snp_dbg);
+	case SEV_CMD_SNP_DBG_ENCRYPT:		return sizeof(struct sev_data_snp_dbg);
+	case SEV_CMD_SNP_PAGE_UNSMASH:		return sizeof(struct sev_data_snp_page_unsmash);
+	case SEV_CMD_SNP_PLATFORM_STATUS:	return sizeof(struct sev_data_snp_addr);
+	case SEV_CMD_SNP_GUEST_REQUEST:		return sizeof(struct sev_data_snp_guest_request);
+	case SEV_CMD_SNP_CONFIG:		return sizeof(struct sev_user_data_snp_config);
 	default:				return 0;
 	}
 
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 7fd17e8..006e4cd 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -78,6 +78,36 @@ enum sev_cmd {
 	SEV_CMD_DBG_DECRYPT		= 0x060,
 	SEV_CMD_DBG_ENCRYPT		= 0x061,
 
+	/* SNP specific commands */
+	SEV_CMD_SNP_INIT		= 0x081,
+	SEV_CMD_SNP_SHUTDOWN		= 0x082,
+	SEV_CMD_SNP_PLATFORM_STATUS	= 0x083,
+	SEV_CMD_SNP_DF_FLUSH		= 0x084,
+	SEV_CMD_SNP_INIT_EX		= 0x085,
+	SEV_CMD_SNP_SHUTDOWN_EX		= 0x086,
+	SEV_CMD_SNP_DECOMMISSION	= 0x090,
+	SEV_CMD_SNP_ACTIVATE		= 0x091,
+	SEV_CMD_SNP_GUEST_STATUS	= 0x092,
+	SEV_CMD_SNP_GCTX_CREATE		= 0x093,
+	SEV_CMD_SNP_GUEST_REQUEST	= 0x094,
+	SEV_CMD_SNP_ACTIVATE_EX		= 0x095,
+	SEV_CMD_SNP_LAUNCH_START	= 0x0A0,
+	SEV_CMD_SNP_LAUNCH_UPDATE	= 0x0A1,
+	SEV_CMD_SNP_LAUNCH_FINISH	= 0x0A2,
+	SEV_CMD_SNP_DBG_DECRYPT		= 0x0B0,
+	SEV_CMD_SNP_DBG_ENCRYPT		= 0x0B1,
+	SEV_CMD_SNP_PAGE_SWAP_OUT	= 0x0C0,
+	SEV_CMD_SNP_PAGE_SWAP_IN	= 0x0C1,
+	SEV_CMD_SNP_PAGE_MOVE		= 0x0C2,
+	SEV_CMD_SNP_PAGE_MD_INIT	= 0x0C3,
+	SEV_CMD_SNP_PAGE_SET_STATE	= 0x0C6,
+	SEV_CMD_SNP_PAGE_RECLAIM	= 0x0C7,
+	SEV_CMD_SNP_PAGE_UNSMASH	= 0x0C8,
+	SEV_CMD_SNP_CONFIG		= 0x0C9,
+	SEV_CMD_SNP_DOWNLOAD_FIRMWARE_EX = 0x0CA,
+	SEV_CMD_SNP_COMMIT		= 0x0CB,
+	SEV_CMD_SNP_VLEK_LOAD		= 0x0CD,
+
 	SEV_CMD_MAX,
 };
 
@@ -523,6 +553,241 @@ struct sev_data_attestation_report {
 	u32 len;				/* In/Out */
 } __packed;
 
+/**
+ * struct sev_data_snp_download_firmware - SNP_DOWNLOAD_FIRMWARE command params
+ *
+ * @address: physical address of firmware image
+ * @len: length of the firmware image
+ */
+struct sev_data_snp_download_firmware {
+	u64 address;				/* In */
+	u32 len;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_activate - SNP_ACTIVATE command params
+ *
+ * @gctx_paddr: system physical address guest context page
+ * @asid: ASID to bind to the guest
+ */
+struct sev_data_snp_activate {
+	u64 gctx_paddr;				/* In */
+	u32 asid;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_addr - generic SNP command params
+ *
+ * @address: physical address of generic data param
+ */
+struct sev_data_snp_addr {
+	u64 address;				/* In/Out */
+} __packed;
+
+/**
+ * struct sev_data_snp_launch_start - SNP_LAUNCH_START command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @policy: guest policy
+ * @ma_gctx_paddr: system physical address of migration agent
+ * @ma_en: the guest is associated with a migration agent
+ * @imi_en: launch flow is launching an IMI (Incoming Migration Image) for the
+ *          purpose of guest-assisted migration.
+ * @rsvd: reserved
+ * @gosvw: guest OS-visible workarounds, as defined by hypervisor
+ */
+struct sev_data_snp_launch_start {
+	u64 gctx_paddr;				/* In */
+	u64 policy;				/* In */
+	u64 ma_gctx_paddr;			/* In */
+	u32 ma_en:1;				/* In */
+	u32 imi_en:1;				/* In */
+	u32 rsvd:30;
+	u8 gosvw[16];				/* In */
+} __packed;
+
+/* SNP support page type */
+enum {
+	SNP_PAGE_TYPE_NORMAL		= 0x1,
+	SNP_PAGE_TYPE_VMSA		= 0x2,
+	SNP_PAGE_TYPE_ZERO		= 0x3,
+	SNP_PAGE_TYPE_UNMEASURED	= 0x4,
+	SNP_PAGE_TYPE_SECRET		= 0x5,
+	SNP_PAGE_TYPE_CPUID		= 0x6,
+
+	SNP_PAGE_TYPE_MAX
+};
+
+/**
+ * struct sev_data_snp_launch_update - SNP_LAUNCH_UPDATE command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @page_size: page size 0 indicates 4K and 1 indicates 2MB page
+ * @page_type: encoded page type
+ * @imi_page: indicates that this page is part of the IMI (Incoming Migration
+ *            Image) of the guest
+ * @rsvd: reserved
+ * @rsvd2: reserved
+ * @address: system physical address of destination page to encrypt
+ * @rsvd3: reserved
+ * @vmpl1_perms: VMPL permission mask for VMPL1
+ * @vmpl2_perms: VMPL permission mask for VMPL2
+ * @vmpl3_perms: VMPL permission mask for VMPL3
+ * @rsvd4: reserved
+ */
+struct sev_data_snp_launch_update {
+	u64 gctx_paddr;				/* In */
+	u32 page_size:1;			/* In */
+	u32 page_type:3;			/* In */
+	u32 imi_page:1;				/* In */
+	u32 rsvd:27;
+	u32 rsvd2;
+	u64 address;				/* In */
+	u32 rsvd3:8;
+	u32 vmpl1_perms:8;			/* In */
+	u32 vmpl2_perms:8;			/* In */
+	u32 vmpl3_perms:8;			/* In */
+	u32 rsvd4;
+} __packed;
+
+/**
+ * struct sev_data_snp_launch_finish - SNP_LAUNCH_FINISH command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @id_block_paddr: system physical address of ID block
+ * @id_auth_paddr: system physical address of ID block authentication structure
+ * @id_block_en: indicates whether ID block is present
+ * @auth_key_en: indicates whether author key is present in authentication structure
+ * @rsvd: reserved
+ * @host_data: host-supplied data for guest, not interpreted by firmware
+ */
+struct sev_data_snp_launch_finish {
+	u64 gctx_paddr;
+	u64 id_block_paddr;
+	u64 id_auth_paddr;
+	u8 id_block_en:1;
+	u8 auth_key_en:1;
+	u64 rsvd:62;
+	u8 host_data[32];
+} __packed;
+
+/**
+ * struct sev_data_snp_guest_status - SNP_GUEST_STATUS command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @address: system physical address of guest status page
+ */
+struct sev_data_snp_guest_status {
+	u64 gctx_paddr;
+	u64 address;
+} __packed;
+
+/**
+ * struct sev_data_snp_page_reclaim - SNP_PAGE_RECLAIM command params
+ *
+ * @paddr: system physical address of page to be claimed. The 0th bit in the
+ *         address indicates the page size. 0h indicates 4KB and 1h indicates
+ *         2MB page.
+ */
+struct sev_data_snp_page_reclaim {
+	u64 paddr;
+} __packed;
+
+/**
+ * struct sev_data_snp_page_unsmash - SNP_PAGE_UNSMASH command params
+ *
+ * @paddr: system physical address of page to be unsmashed. The 0th bit in the
+ *         address indicates the page size. 0h indicates 4 KB and 1h indicates
+ *         2 MB page.
+ */
+struct sev_data_snp_page_unsmash {
+	u64 paddr;
+} __packed;
+
+/**
+ * struct sev_data_snp_dbg - DBG_ENCRYPT/DBG_DECRYPT command parameters
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @src_addr: source address of data to operate on
+ * @dst_addr: destination address of data to operate on
+ */
+struct sev_data_snp_dbg {
+	u64 gctx_paddr;				/* In */
+	u64 src_addr;				/* In */
+	u64 dst_addr;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_guest_request - SNP_GUEST_REQUEST command params
+ *
+ * @gctx_paddr: system physical address of guest context page
+ * @req_paddr: system physical address of request page
+ * @res_paddr: system physical address of response page
+ */
+struct sev_data_snp_guest_request {
+	u64 gctx_paddr;				/* In */
+	u64 req_paddr;				/* In */
+	u64 res_paddr;				/* In */
+} __packed;
+
+/**
+ * struct sev_data_snp_init_ex - SNP_INIT_EX structure
+ *
+ * @init_rmp: indicate that the RMP should be initialized.
+ * @list_paddr_en: indicate that list_paddr is valid
+ * @rsvd: reserved
+ * @rsvd1: reserved
+ * @list_paddr: system physical address of range list
+ * @rsvd2: reserved
+ */
+struct sev_data_snp_init_ex {
+	u32 init_rmp:1;
+	u32 list_paddr_en:1;
+	u32 rsvd:30;
+	u32 rsvd1;
+	u64 list_paddr;
+	u8  rsvd2[48];
+} __packed;
+
+/**
+ * struct sev_data_range - RANGE structure
+ *
+ * @base: system physical address of first byte of range
+ * @page_count: number of 4KB pages in this range
+ * @rsvd: reserved
+ */
+struct sev_data_range {
+	u64 base;
+	u32 page_count;
+	u32 rsvd;
+} __packed;
+
+/**
+ * struct sev_data_range_list - RANGE_LIST structure
+ *
+ * @num_elements: number of elements in RANGE_ARRAY
+ * @rsvd: reserved
+ * @ranges: array of num_elements of type RANGE
+ */
+struct sev_data_range_list {
+	u32 num_elements;
+	u32 rsvd;
+	struct sev_data_range ranges[];
+} __packed;
+
+/**
+ * struct sev_data_snp_shutdown_ex - SNP_SHUTDOWN_EX structure
+ *
+ * @len: length of the command buffer read by the PSP
+ * @iommu_snp_shutdown: Disable enforcement of SNP in the IOMMU
+ * @rsvd1: reserved
+ */
+struct sev_data_snp_shutdown_ex {
+	u32 len;
+	u32 iommu_snp_shutdown:1;
+	u32 rsvd1:31;
+} __packed;
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 
 /**
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index b44ba7d..207e342 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -69,6 +69,12 @@ typedef enum {
 	SEV_RET_RESOURCE_LIMIT,
 	SEV_RET_SECURE_DATA_INVALID,
 	SEV_RET_INVALID_KEY = 0x27,
+	SEV_RET_INVALID_PAGE_SIZE,
+	SEV_RET_INVALID_PAGE_STATE,
+	SEV_RET_INVALID_MDATA_ENTRY,
+	SEV_RET_INVALID_PAGE_OWNER,
+	SEV_RET_INVALID_PAGE_AEAD_OFLOW,
+	SEV_RET_RMP_INIT_REQUIRED,
 	SEV_RET_MAX,
 } sev_ret_code;
 
@@ -156,6 +162,56 @@ struct sev_user_data_get_id2 {
 } __packed;
 
 /**
+ * struct sev_user_data_snp_status - SNP status
+ *
+ * @api_major: API major version
+ * @api_minor: API minor version
+ * @state: current platform state
+ * @is_rmp_initialized: whether RMP is initialized or not
+ * @rsvd: reserved
+ * @build_id: firmware build id for the API version
+ * @mask_chip_id: whether chip id is present in attestation reports or not
+ * @mask_chip_key: whether attestation reports are signed or not
+ * @vlek_en: VLEK (Version Loaded Endorsement Key) hashstick is loaded
+ * @rsvd1: reserved
+ * @guest_count: the number of guest currently managed by the firmware
+ * @current_tcb_version: current TCB version
+ * @reported_tcb_version: reported TCB version
+ */
+struct sev_user_data_snp_status {
+	__u8 api_major;			/* Out */
+	__u8 api_minor;			/* Out */
+	__u8 state;			/* Out */
+	__u8 is_rmp_initialized:1;	/* Out */
+	__u8 rsvd:7;
+	__u32 build_id;			/* Out */
+	__u32 mask_chip_id:1;		/* Out */
+	__u32 mask_chip_key:1;		/* Out */
+	__u32 vlek_en:1;		/* Out */
+	__u32 rsvd1:29;
+	__u32 guest_count;		/* Out */
+	__u64 current_tcb_version;	/* Out */
+	__u64 reported_tcb_version;	/* Out */
+} __packed;
+
+/**
+ * struct sev_user_data_snp_config - system wide configuration value for SNP.
+ *
+ * @reported_tcb: the TCB version to report in the guest attestation report.
+ * @mask_chip_id: whether chip id is present in attestation reports or not
+ * @mask_chip_key: whether attestation reports are signed or not
+ * @rsvd: reserved
+ * @rsvd1: reserved
+ */
+struct sev_user_data_snp_config {
+	__u64 reported_tcb  ;   /* In */
+	__u32 mask_chip_id:1;   /* In */
+	__u32 mask_chip_key:1;  /* In */
+	__u32 rsvd:30;          /* In */
+	__u8 rsvd1[52];
+} __packed;
+
+/**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
  * @cmd: SEV commands to execute

