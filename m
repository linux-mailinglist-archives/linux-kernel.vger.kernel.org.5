Return-Path: <linux-kernel+bounces-44921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B60842918
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959EA1C25801
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3161292F8;
	Tue, 30 Jan 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFFNDMJh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IO68FD9O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310831272B0;
	Tue, 30 Jan 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631961; cv=none; b=LrJjB8VV1+//HLXv9WlaFWozLIoZAbYraNDusQbqjdxKnOTgUi0nf0KP3fFOVmYtiUHGSrKDB9XbdgxoKBUxkyVHUbw4MPlHkGOkRVrRSBi5P92XclF0nVCefevuztypznp4R9pUU9hv9YWeSFZNfa+TEd/RwxmDqFpeUbspSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631961; c=relaxed/simple;
	bh=UcJQYfmz+AmV/INkQFWEt5kwGjBzstBKsMZg2GSeaPk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uNIvd+t6ELHvfcEUD3t2iBRZc1O1qzBNupi9PoA75hxBawBpYAzUhNPyup5hJapWbTcoE5txqXp8wjD9u+L7be6u5U1rEjHZeuWhwlS6xzOJNlqFh8GaluQdHpJ/GasmP3idKg/w007pwrJXd9sOh30suPk/0t1lCrWhbUzzFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFFNDMJh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IO68FD9O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:25:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1K6GAfsF3YDRRAkWL80zKwtOVQFiK/7QsFWsA0UGjM=;
	b=CFFNDMJhbYyKG+ZZNEby0oPrRbe5pSBSUceHMeuAjIVgHponKsDtlBVP58E39QRDwsFwsu
	mqJ2JgeXWIAp7xfiAWyP5Z1IYNST31wWZBWyXd41etRn4NiXkCdM45ZB37XV4lyqgAqIZD
	j5ruVrOkI8uLufIZkkj/t70tXk0Fbu8ey8GOv7TXgbFZ0Rpd5wnOnoLjyvsLz8TFcDCj4l
	UZztvwQ9IAqxsGTNW8Qp9AxUrJhVMklMsLa77y77ggd3d0VzDutyHQLJVu0v692KacPsAs
	eSMGRzEsCZXPw2HHXVaOGORe8k7AVy0Ay5xCOjhQMLA8UkRfX2mph8ZrdBdSQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1K6GAfsF3YDRRAkWL80zKwtOVQFiK/7QsFWsA0UGjM=;
	b=IO68FD9O5iIL57/NrLFfCu0dgy30QAed1LLlrXescmgwAYmDZw+1TBqLW2jT0TsvVA0DBv
	coZwFtbzLWhAyKDA==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Add the SNP_PLATFORM_STATUS command
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-24-michael.roth@amd.com>
References: <20240126041126.1927228-24-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663195669.398.6067703173249961671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f5db8841ebe59dbdf07fda797c88ccb51e0c893d
Gitweb:        https://git.kernel.org/tip/f5db8841ebe59dbdf07fda797c88ccb51e0c893d
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:23 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:19 +01:00

crypto: ccp: Add the SNP_PLATFORM_STATUS command

This command is used to query the SNP platform status. See the SEV-SNP
spec for more details.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-24-michael.roth@amd.com
---
 Documentation/virt/coco/sev-guest.rst | 27 ++++++++++++++-
 drivers/crypto/ccp/sev-dev.c          | 52 ++++++++++++++++++++++++++-
 include/uapi/linux/psp-sev.h          |  1 +-
 3 files changed, 80 insertions(+)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 68b0d23..6d3d5d3 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -67,6 +67,22 @@ counter (e.g. counter overflow), then -EIO will be returned.
                 };
         };
 
+The host ioctls are issued to a file descriptor of the /dev/sev device.
+The ioctl accepts the command ID/input structure documented below.
+
+::
+        struct sev_issue_cmd {
+                /* Command ID */
+                __u32 cmd;
+
+                /* Command request structure */
+                __u64 data;
+
+                /* Firmware error code on failure (see psp-sev.h) */
+                __u32 error;
+        };
+
+
 2.1 SNP_GET_REPORT
 ------------------
 
@@ -124,6 +140,17 @@ be updated with the expected value.
 
 See GHCB specification for further detail on how to parse the certificate blob.
 
+2.4 SNP_PLATFORM_STATUS
+-----------------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Parameters (out): struct sev_user_data_snp_status
+:Returns (out): 0 on success, -negative on error
+
+The SNP_PLATFORM_STATUS command is used to query the SNP platform status. The
+status includes API major, minor version and more. See the SEV-SNP
+specification for further details.
+
 3. SEV-SNP CPUID Enforcement
 ============================
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 504a221..ae02efe 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1941,6 +1941,55 @@ e_free_pdh:
 	return ret;
 }
 
+static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_data_snp_addr buf;
+	struct page *status_page;
+	void *data;
+	int ret;
+
+	if (!sev->snp_initialized || !argp->data)
+		return -EINVAL;
+
+	status_page = alloc_page(GFP_KERNEL_ACCOUNT);
+	if (!status_page)
+		return -ENOMEM;
+
+	data = page_address(status_page);
+
+	/*
+	 * Firmware expects status page to be in firmware-owned state, otherwise
+	 * it will report firmware error code INVALID_PAGE_STATE (0x1A).
+	 */
+	if (rmp_mark_pages_firmware(__pa(data), 1, true)) {
+		ret = -EFAULT;
+		goto cleanup;
+	}
+
+	buf.address = __psp_pa(data);
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &argp->error);
+
+	/*
+	 * Status page will be transitioned to Reclaim state upon success, or
+	 * left in Firmware state in failure. Use snp_reclaim_pages() to
+	 * transition either case back to Hypervisor-owned state.
+	 */
+	if (snp_reclaim_pages(__pa(data), 1, true))
+		return -EFAULT;
+
+	if (ret)
+		goto cleanup;
+
+	if (copy_to_user((void __user *)argp->data, data,
+			 sizeof(struct sev_user_data_snp_status)))
+		ret = -EFAULT;
+
+cleanup:
+	__free_pages(status_page, 0);
+	return ret;
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -1992,6 +2041,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SEV_GET_ID2:
 		ret = sev_ioctl_do_get_id2(&input);
 		break;
+	case SNP_PLATFORM_STATUS:
+		ret = sev_ioctl_do_snp_platform_status(&input);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 207e342..f1e2c55 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -28,6 +28,7 @@ enum {
 	SEV_PEK_CERT_IMPORT,
 	SEV_GET_ID,	/* This command is deprecated, use SEV_GET_ID2 */
 	SEV_GET_ID2,
+	SNP_PLATFORM_STATUS,
 
 	SEV_MAX,
 };

