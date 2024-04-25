Return-Path: <linux-kernel+bounces-158773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF18B24B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F2628AC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D614B067;
	Thu, 25 Apr 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+gy4MAy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xs/pXU9+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08708149DED;
	Thu, 25 Apr 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057683; cv=none; b=s14w9/kJMLx5ozXK/elwHzSX39kLUWAuJiYgP5M+f328Lmz7TRlyaq+54f0kXONY0fgY0n+5u5qFgnDj0N9xXa+UB4VJ4L4KrIgSKXuDhxJwTNzUNs8IkAEcM3PEm92G57nv+TttqW9QIrDrTxwjEwGgrwmyMd/roJ+4RybdeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057683; c=relaxed/simple;
	bh=NNHVq9t4iKrTMq4fxSxo6DTIwdtIEd3+82VP57BUIMg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SSMsru1IKVUXjSzH3rlrZzZu4Gx3Y22bt3z4YqgW5Hhycs73ksn7kXhPoNo6bEo2pNb+9sh2t/Jdu8qSmZQ4R5fmXIU7Wjv9wI1iwBccy/CAIh7fcRWIcBJ8N1flsj/2JkdsueWRWm05MhopdgAQztUYqb7F+w//XYzpjwwSvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+gy4MAy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xs/pXU9+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 15:08:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714057680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJS7ea85x1R9XV1GCvkLnH4pfJbXmRYUWjINCnB8N3c=;
	b=N+gy4MAydGeXSwlPrcEjciHRDKzrTeijgsLzG/R5X5r1bfOfavbiGrMbBn6nz3A3i/82oI
	KYwvJE7ueSXuj4BKxprl+D1pYnlsgeYy4WoF07Y70OOk7Y2fbsyw1v43RRXEEd5sZAESsK
	65Jb57CLgacpc41xrMlJwIzrWR3R2qY9oMf1evRz9/NdVJw32U6aGzLhQmcjyu4xL30V7e
	PM3xeCnOKHgSfEkW5CL10YEBsbXwBnfM2xk+lD63YLKQVdwEnC47UpMJ0bQjh8fESM/FFI
	VDtrZXc4zs0AwfcN+SUDTbbNpKF/IvTifS8OUJiX5V5gkG2oFtUrKWBe0alwew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714057680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJS7ea85x1R9XV1GCvkLnH4pfJbXmRYUWjINCnB8N3c=;
	b=Xs/pXU9+KMMHkyPl9HyNWf9u2tpXlBfJtaJg2ojJN/+n2u3BGsqdhMdvNB8CkaV4cva5yv
	3xtzHZtJm4hgmWBg==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Shorten struct name snp_secrets_page_layout
 to snp_secrets_page
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbc8d58302c6ab66c3beeab50cce3ec2c6bd72d6c=2E17139?=
 =?utf-8?q?74291=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cbc8d58302c6ab66c3beeab50cce3ec2c6bd72d6c=2E171397?=
 =?utf-8?q?4291=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171405768009.10875.7342315793126644345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1e52550729dafb41b12652a985d3df6cfa99cb88
Gitweb:        https://git.kernel.org/tip/1e52550729dafb41b12652a985d3df6cfa99cb88
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 24 Apr 2024 10:57:57 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Apr 2024 16:13:51 +02:00

x86/sev: Shorten struct name snp_secrets_page_layout to snp_secrets_page

Ending a struct name with "layout" is a little redundant, so shorten the
snp_secrets_page_layout name to just snp_secrets_page.

No functional change.

  [ bp: Rename the local pointer to "secrets" too for more clarity. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/bc8d58302c6ab66c3beeab50cce3ec2c6bd72d6c.1713974291.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/sev.h              |  2 +-
 arch/x86/kernel/sev.c                   |  6 ++---
 drivers/virt/coco/sev-guest/sev-guest.c | 28 ++++++++++++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7f57382..48bc397 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -140,7 +140,7 @@ struct secrets_os_area {
 #define VMPCK_KEY_LEN		32
 
 /* See the SNP spec version 0.9 for secrets page format */
-struct snp_secrets_page_layout {
+struct snp_secrets_page {
 	u32 version;
 	u32 imien	: 1,
 	    rsvd1	: 31;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 38ad066..790e481 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -648,7 +648,7 @@ static u64 __init get_secrets_page(void)
 
 static u64 __init get_snp_jump_table_addr(void)
 {
-	struct snp_secrets_page_layout *layout;
+	struct snp_secrets_page *secrets;
 	void __iomem *mem;
 	u64 pa, addr;
 
@@ -662,9 +662,9 @@ static u64 __init get_snp_jump_table_addr(void)
 		return 0;
 	}
 
-	layout = (__force struct snp_secrets_page_layout *)mem;
+	secrets = (__force struct snp_secrets_page *)mem;
 
-	addr = layout->os_area.ap_jump_table_pa;
+	addr = secrets->os_area.ap_jump_table_pa;
 	iounmap(mem);
 
 	return addr;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f2418..654290a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -59,7 +59,7 @@ struct snp_guest_dev {
 	 */
 	struct snp_guest_msg secret_request, secret_response;
 
-	struct snp_secrets_page_layout *layout;
+	struct snp_secrets_page *secrets;
 	struct snp_req_data input;
 	union {
 		struct snp_report_req report;
@@ -743,26 +743,26 @@ static const struct file_operations snp_guest_fops = {
 	.unlocked_ioctl = snp_guest_ioctl,
 };
 
-static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
+static u8 *get_vmpck(int id, struct snp_secrets_page *secrets, u32 **seqno)
 {
 	u8 *key = NULL;
 
 	switch (id) {
 	case 0:
-		*seqno = &layout->os_area.msg_seqno_0;
-		key = layout->vmpck0;
+		*seqno = &secrets->os_area.msg_seqno_0;
+		key = secrets->vmpck0;
 		break;
 	case 1:
-		*seqno = &layout->os_area.msg_seqno_1;
-		key = layout->vmpck1;
+		*seqno = &secrets->os_area.msg_seqno_1;
+		key = secrets->vmpck1;
 		break;
 	case 2:
-		*seqno = &layout->os_area.msg_seqno_2;
-		key = layout->vmpck2;
+		*seqno = &secrets->os_area.msg_seqno_2;
+		key = secrets->vmpck2;
 		break;
 	case 3:
-		*seqno = &layout->os_area.msg_seqno_3;
-		key = layout->vmpck3;
+		*seqno = &secrets->os_area.msg_seqno_3;
+		key = secrets->vmpck3;
 		break;
 	default:
 		break;
@@ -897,8 +897,8 @@ static void unregister_sev_tsm(void *data)
 
 static int __init sev_guest_probe(struct platform_device *pdev)
 {
-	struct snp_secrets_page_layout *layout;
 	struct sev_guest_platform_data *data;
+	struct snp_secrets_page *secrets;
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
@@ -916,7 +916,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!mapping)
 		return -ENODEV;
 
-	layout = (__force void *)mapping;
+	secrets = (__force void *)mapping;
 
 	ret = -ENOMEM;
 	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
@@ -924,7 +924,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 		goto e_unmap;
 
 	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
+	snp_dev->vmpck = get_vmpck(vmpck_id, secrets, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
 		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
 		goto e_unmap;
@@ -938,7 +938,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, snp_dev);
 	snp_dev->dev = dev;
-	snp_dev->layout = layout;
+	snp_dev->secrets = secrets;
 
 	/* Allocate the shared page used for the request and response message. */
 	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));

