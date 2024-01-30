Return-Path: <linux-kernel+bounces-44930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD284292A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017221F27364
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757912C548;
	Tue, 30 Jan 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSNhC6HT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xoN/WCS8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5612BF00;
	Tue, 30 Jan 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631968; cv=none; b=saIqb+KMjJCr5NaVd9gMbOZxqyJMlKQSB8sO5fsanRo/ANwGf0FocDYaFpQL8sxWmQMlWaeRf6OKT0XSDALIoVEt55LKpKAVxlKWrJSBEqtL2/ymdMDff/XoWsY327/6XBUeldnh+jJrIRxf7ezV+UJjTziwXfvlH3SgVZC0ckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631968; c=relaxed/simple;
	bh=qXdJmy1jvlRqdVpd+2umJo9nky79o6FGLmN2lUmqlRk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ApsF9iBdofYsAmOfMb+z56lTtfPbsSUHGt6ismFKWIoZ9WhNbu0UNayAfwiY957RF6MZYi1LuBw4Ye4HllpequcS/D7ciZ1JKi0TBOiUsNaGmIciqEVMSJ1kTVYd+6/Ncza2RKsBnKZlBc8bOT4vvnelZOPK8yOiatxNjdr6mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSNhC6HT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xoN/WCS8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWYQr9hsBJZ/YWmAIH8IkBx0jeEOodvJUtJQfr7SKQ0=;
	b=oSNhC6HTBIoF6yqBP74iw8dgNkluXAZZUXufvbZFbDzehNM5H/x0Y2QYqRh/ZUOX6aCK1A
	ZVopzZ/wX4Ym+sIvkExgDuBxEf23kwDBVMs41L+qrMWuFcBJD5vA/9Wg23PM8abnl8YZYA
	FhDRTBW8lPb3Aotz7XaBATGAV8xdQgzPUU8lujGzBYcSEMUA9muwraLnnbPfE2Q5Dbc9Zq
	WxJ+5H03iuTnHvCmrpOoqb0BbBQ8BQnB3XX3JxrrNRGjINxZyDjycWRrwp46QjheXDWOE6
	OX2Qc2QyCVSFoxNIos3mz5dMtdPwNAQDuhUd8l1S4AFxTEG7qC4h/C1KV5xtvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWYQr9hsBJZ/YWmAIH8IkBx0jeEOodvJUtJQfr7SKQ0=;
	b=xoN/WCS85GaK3rLK1Ol9PcdLfeUMbr0F8LLkEk0BjJmqdNoiQEm1Bi7scBhp67xUaQXXMB
	08O+CYI3Np7bTnAw==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] crypto: ccp: Provide an API to issue SEV and SNP commands
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-15-michael.roth@amd.com>
References: <20240126041126.1927228-15-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196450.398.3374428742682760351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     18085ac2f2fbf56aee9cbf5846740150e394f4f4
Gitweb:        https://git.kernel.org/tip/18085ac2f2fbf56aee9cbf5846740150e394f4f4
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:14 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

crypto: ccp: Provide an API to issue SEV and SNP commands

Export sev_do_cmd() as a generic API for the hypervisor to issue
commands to manage an SEV or an SNP guest. The commands for SEV and SNP
are defined in the SEV and SEV-SNP firmware specifications.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-15-michael.roth@amd.com
---
 drivers/crypto/ccp/sev-dev.c |  3 ++-
 include/linux/psp-sev.h      | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 7129644..abee1a6 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -431,7 +431,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	return ret;
 }
 
-static int sev_do_cmd(int cmd, void *data, int *psp_ret)
+int sev_do_cmd(int cmd, void *data, int *psp_ret)
 {
 	int rc;
 
@@ -441,6 +441,7 @@ static int sev_do_cmd(int cmd, void *data, int *psp_ret)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(sev_do_cmd);
 
 static int __sev_init_locked(int *error)
 {
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index ef3b917..bcf9ced 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -915,6 +915,22 @@ int sev_guest_df_flush(int *error);
  */
 int sev_guest_decommission(struct sev_data_decommission *data, int *error);
 
+/**
+ * sev_do_cmd - issue an SEV or an SEV-SNP command
+ *
+ * @cmd: SEV or SEV-SNP firmware command to issue
+ * @data: arguments for firmware command
+ * @psp_ret: SEV command return code
+ *
+ * Returns:
+ * 0 if the SEV device successfully processed the command
+ * -%ENODEV    if the PSP device is not available
+ * -%ENOTSUPP  if PSP device does not support SEV
+ * -%ETIMEDOUT if the SEV command timed out
+ * -%EIO       if PSP device returned a non-zero return code
+ */
+int sev_do_cmd(int cmd, void *data, int *psp_ret);
+
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
@@ -931,6 +947,9 @@ static inline int
 sev_guest_decommission(struct sev_data_decommission *data, int *error) { return -ENODEV; }
 
 static inline int
+sev_do_cmd(int cmd, void *data, int *psp_ret) { return -ENODEV; }
+
+static inline int
 sev_guest_activate(struct sev_data_activate *data, int *error) { return -ENODEV; }
 
 static inline int sev_guest_df_flush(int *error) { return -ENODEV; }

