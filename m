Return-Path: <linux-kernel+bounces-44919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B88842914
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05228B2984B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578EE12838F;
	Tue, 30 Jan 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="crjcJYiV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SwRItXqC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9A6D1C8;
	Tue, 30 Jan 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631959; cv=none; b=Si81x3LRt95D559tUprf9CxZsiInaj6K3nTC5TCsq6nx8F+dNzNfVy9Bd2plpc+7/0lEE//MdTR+05FWKBY6Oc4CZjgOVj0p18TQ04hPwSOC2xWUb+GoPEsyMe0f7U+oVANK1uKrnD6cSgsv5DRcHkGIBRFePzMDbnpDr0twqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631959; c=relaxed/simple;
	bh=8GBwR7XWtquJrk1zr/FtP1Kw1ekL+3t+rU/v4OJlwMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E99t86OrTVr2XU2XJjzkqW7Pj89X3yWthOuWFKk95d76l7d4OZ5jHuIc/VF/1K5O8+O6qL7j4vYZ6jlaseyKIyslAGxABYHtqBhm4u/dVQrOI2eGfKCsBzei4gwWMsmxEFVL8Zj5AJsYT96+g3kpe48f6STN3N2P2bnz988JhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=crjcJYiV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SwRItXqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYndbFyDjCKY1d+qrJ/nAlCS0Z0PmPz4afr9p+1AxpM=;
	b=crjcJYiVfnTICJdP8YZCixwJbUpZYBl8uO0g/zhYI7C0Mkobh2MFyCrx04uEqhctt1NXZs
	dozYf6w3l0qfc2iJFGMWqvlRIKXjlDdDPbZZ/F/Yk0PZZlrr1H4i/nwDoOXKqkF07In8Hp
	AMXTehcGiJ4NA6LGTornpZ5iE+Y9EPuvRm14rol0M9nnqrJjcD8P9ksJEZOss52go9xajQ
	/zM5EDWtD47iS+VELbFYEqZF/fLXIv7QazXrYh2OsYekvBBZCxfNDUCxmhEINJX2pVWhRn
	O0xqyWmPj6Pna9yyJsd4TWUJXT8NaIGyNYOV2ImQ09877+6vde9wh5P5V41cSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYndbFyDjCKY1d+qrJ/nAlCS0Z0PmPz4afr9p+1AxpM=;
	b=SwRItXqCkn/t9z7fb8gWTr3LY1yau8gsrxxIma3ZgV97xlmyQjp0raIIk0Qgc3F4zr2ggB
	SROJvLnDJZNQ9nDg==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Add the SNP_SET_CONFIG command
Cc: Brijesh Singh <brijesh.singh@amd.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-26-michael.roth@amd.com>
References: <20240126041126.1927228-26-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663195481.398.11079109831239902715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     cb645fe478eaad32b6168059bb6b584295af863e
Gitweb:        https://git.kernel.org/tip/cb645fe478eaad32b6168059bb6b584295af863e
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:25 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:19 +01:00

crypto: ccp: Add the SNP_SET_CONFIG command

The SEV-SNP firmware provides the SNP_CONFIG command used to set various
system-wide configuration values for SNP guests, such as the reported
TCB version used when signing guest attestation reports. Add an
interface to set this via userspace.

  [ mdr: Squash in doc patch from Dionna, drop extended request/
    certificate handling and simplify this to a simple wrapper around
    SNP_CONFIG fw cmd. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-26-michael.roth@amd.com
---
 Documentation/virt/coco/sev-guest.rst | 13 +++++++++++++
 drivers/crypto/ccp/sev-dev.c          | 20 ++++++++++++++++++++
 include/uapi/linux/psp-sev.h          |  1 +
 3 files changed, 34 insertions(+)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 007ae82..14c9de9 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -162,6 +162,19 @@ SEV-SNP firmware SNP_COMMIT command. This prevents roll-back to a previously
 committed firmware version. This will also update the reported TCB to match
 that of the currently installed firmware.
 
+2.6 SNP_SET_CONFIG
+------------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Parameters (in): struct sev_user_data_snp_config
+:Returns (out): 0 on success, -negative on error
+
+SNP_SET_CONFIG is used to set the system-wide configuration such as
+reported TCB version in the attestation report. The command is similar
+to SNP_CONFIG command defined in the SEV-SNP spec. The current values of
+the firmware parameters affected by this command can be queried via
+SNP_PLATFORM_STATUS.
+
 3. SEV-SNP CPUID Enforcement
 ============================
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6e375d1..f1a5795 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2004,6 +2004,23 @@ static int sev_ioctl_do_snp_commit(struct sev_issue_cmd *argp)
 	return __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->error);
 }
 
+static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_user_data_snp_config config;
+
+	if (!sev->snp_initialized || !argp->data)
+		return -EINVAL;
+
+	if (!writable)
+		return -EPERM;
+
+	if (copy_from_user(&config, (void __user *)argp->data, sizeof(config)))
+		return -EFAULT;
+
+	return __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -2061,6 +2078,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SNP_COMMIT:
 		ret = sev_ioctl_do_snp_commit(&input);
 		break;
+	case SNP_SET_CONFIG:
+		ret = sev_ioctl_do_snp_set_config(&input, writable);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 35c2076..b7a2c2e 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -30,6 +30,7 @@ enum {
 	SEV_GET_ID2,
 	SNP_PLATFORM_STATUS,
 	SNP_COMMIT,
+	SNP_SET_CONFIG,
 
 	SEV_MAX,
 };

