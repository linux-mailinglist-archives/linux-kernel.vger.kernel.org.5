Return-Path: <linux-kernel+bounces-54356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13484AE22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0571D1F24684
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61D7F7C0;
	Tue,  6 Feb 2024 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eSLvK2AX"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867D7F464
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198053; cv=none; b=GbB91Ip6d9wb3EceF02FPBdbdLa9nltImikNbGgfYomqiq8udsWXMvs1dDM3P8qF9IcjMqL85t3ZqofR/GEleFhEM8MbVtnHTPWG8wQ0mOLNpKoadSGJbIiNneCRGrLZp/VcVaEYMnPJnf3wXhzIasjetnV1ihQHyI84Q8rT8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198053; c=relaxed/simple;
	bh=12JV3s2dxhUtF8cvsihJ6B9DhYtAGxdVgGWKspDgLfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=X3UGaYR+YHWKQ67U5Tv2pKSuxuojKG/7mADMJk8IfaPgtp/48HFt060+vFcNKPsTCmUD93xh9bArWYDHyepFpFbCimSG/QXa9xzLLhQ9LWdjD/LE1kH5FDzxdFlx3SMrxq/+nvUNWQQgjC+RZ3yEMeinPu0f2K9LUWk/WcekSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eSLvK2AX; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240206054042epoutp03beccb0e0a29e2764b7aea4eed15b5661~xL5MXUYA22587225872epoutp03r
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:40:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240206054042epoutp03beccb0e0a29e2764b7aea4eed15b5661~xL5MXUYA22587225872epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707198042;
	bh=aBBrxem7ddlekW/Lr8VprMBnc1yCIETVUD5Mt9UJ6mI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eSLvK2AXHTEnJcbkVSWa0FX5QO38bMKeHya4eQ/S0A7k/w9PKjNHI+yZGefJONLAc
	 BTcJQNuDG5iSB9/86APECX7qLQS52aQ01smt/32zD+MIUUMKmyjaBE9226g1PKl2V6
	 v9bwv1NGXqJYaWKBY9aGDU3qrFreb9acDmz6J++c=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240206054041epcas5p129aa02776cb689022cfa956bb540b871~xL5LyoY621405414054epcas5p1D;
	Tue,  6 Feb 2024 05:40:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.04.10009.956C1C56; Tue,  6 Feb 2024 14:40:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240206051218epcas5p3fddd971ec73f6ee6a2b0a5ec2709c0f7~xLgZNqanZ1031110311epcas5p31;
	Tue,  6 Feb 2024 05:12:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240206051218epsmtrp190e9b1ff2b400c54052add3c10ffcfd4~xLgZMtrm01605616056epsmtrp1b;
	Tue,  6 Feb 2024 05:12:18 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-e9-65c1c659c701
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.60.08817.2BFB1C56; Tue,  6 Feb 2024 14:12:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240206051212epsmtip225e82b14faef9cafd015458eb690d8a8~xLgTgNi6z1683216832epsmtip2s;
	Tue,  6 Feb 2024 05:12:11 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com, Onkarnath
	<onkarnath.1@samsung.com>
Subject: [PATCH 1/2] drivers: acpi: use %pe for better readability of errors
 while printing
Date: Tue,  6 Feb 2024 10:41:19 +0530
Message-Id: <20240206051120.4173475-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmlm7ksYOpBitOGlssacqwuPT4KpvF
	9JeNLBZPJ2xltrjbP5XFYufDt2wWy/f1M1pc3jWHzeLsvONsFp97jzBaHJ7fxmIx+d0zRotL
	BxYwWazo+cBqcbz3AJPFxnvZFnO/TGW22NfxgMmi48g3ZouNXz0sth79zu4g6rFm3hpGj5Z9
	t9g9Fmwq9di8Qstj06pONo871/awebzfd5XNo2/LKkaPzaerPT5vkgvgiuKySUnNySxLLdK3
	S+DK6Pv8lLFghkBFZ8sO5gbGO7xdjJwcEgImEs/77zJ3MXJxCAnsZpS4u2UNM0hCSOATo8T2
	eSoQiW+MEn8nHmSD6dg3bwM7RGIvo8TVvR3sEB1fGCXe7NcFsdkEtCRm3DnABFIkIrCFSWLJ
	pYNgHcwC5xglbkzewtrFyMEhLBArcbuzFKSBRUBVovPdJFYQm1fATmLjj3OsENvkJWZe+s4O
	EReUODnzCQuIzQwUb946G+xuCYEbHBL3Zixjh2hwkXjW2cACYQtLvDq+BSouJfGyvw3Kzpdo
	mT2LGeQGCYEaiatPVSHC9hJPLi4EO41ZQFNi/S59iLCsxNRT65gg1vJJ9P5+wgQR55XYMQ/G
	VpX4NWUq1FZpifu/50IDy0Pi3dI+aIjGSty4uI5xAqP8LCTfzELyzSyEzQsYmVcxSqYWFOem
	pxabFhjlpZbrFSfmFpfmpesl5+duYgQnQi2vHYwPH3zQO8TIxMF4iFGCg1lJhNdsx4FUId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4ryvW+emCAmkJ5akZqemFqQWwWSZODilGpgSf6yxyTacPenE
	vOAi8cCpHHmLemUvvDPxX3p805xDc0xmdF9d1Jaj0m10nUO8Vtv9wfltj45O/J1ftLfwieNt
	afVezqvPUwLmvbmqNWnTm0di3TN0oo+syPtueijWVN4v9wBLfu51lWULi7lruTbYzz2y7XD5
	iZCkwv1frvf0xXJdTljCUHHllknHjcWXeg7YxE1Nt+6ffWl+85JdBz0mrZzY7N63fEOb01S1
	wLl1klnBM97NFd8UtuyvbYrXgi4jm6e2i8Ouek6fOtH/tuCZPdWX1vFLh+vrveyQLur84TTD
	MSaoP+7RrKbX2cKRX77tV/vMmHT71LRZQVu/ZISdMlhavqTTiKtcyptJPvyJEktxRqKhFnNR
	cSIAKbYiX/MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXnfT/oOpBuunc1ssacqwuPT4KpvF
	9JeNLBZPJ2xltrjbP5XFYufDt2wWy/f1M1pc3jWHzeLsvONsFp97jzBaHJ7fxmIx+d0zRotL
	BxYwWazo+cBqcbz3AJPFxnvZFnO/TGW22NfxgMmi48g3ZouNXz0sth79zu4g6rFm3hpGj5Z9
	t9g9Fmwq9di8Qstj06pONo871/awebzfd5XNo2/LKkaPzaerPT5vkgvgiuKySUnNySxLLdK3
	S+DK6Pv8lLFghkBFZ8sO5gbGO7xdjJwcEgImEvvmbWDvYuTiEBLYzShxt3siC0RCWuLT5Tns
	ELawxMp/z6GKPjFKfJz1mRkkwSagJTHjzgEmkISIwDEmiWn9G1lAHGaBK4wSs05vYwOpEhaI
	lnj98xXYKBYBVYnOd5NYQWxeATuJjT/OsUKskJeYeek7O0RcUOLkzCdgZzADxZu3zmaewMg3
	C0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwdGlpbWDcc+qD3qHGJk4
	GA8xSnAwK4nwmu04kCrEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKY
	LBMHp1QD0+LUolbBTd8kal9JrvtaMmOm6YZFS8/dWfjs+yqtiovaz1SfXtDyWHJAiS9Mt47p
	yJfvnj+m5Z4vMHQr2Z0/O/ND7GJhZW3Bi89YvbzN/1U3TG0TbdZ/zKe79cEzl7ctYbPWnVsl
	vMTf+V+5gda5xLtaG/wUM64tvuBhef3rFqvOa01nf23PFV058dajf6UHd3VLN3098XHlC79d
	jB4fK5UUPBZMidY8P/Xr9zIRzp8pBd8NLc8aBHbm9SqYHDTbHXO0RLJqD2f87LmGK+4Wp+mI
	yN8uXRAaXqnyb17+581rDpxseZ9RK37k5Y4VMt1r/kiLy3c9/LB2Rve73ZN1XsXfzTE4/0Dn
	mG5zIZtoi4sSS3FGoqEWc1FxIgAp3TP+HQMAAA==
X-CMS-MailID: 20240206051218epcas5p3fddd971ec73f6ee6a2b0a5ec2709c0f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240206051218epcas5p3fddd971ec73f6ee6a2b0a5ec2709c0f7
References: <CGME20240206051218epcas5p3fddd971ec73f6ee6a2b0a5ec2709c0f7@epcas5p3.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

As %pe is already introduced, its better to use it inplace of (%ld) for
printing errors in logs. It would enhance redability of logs.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
 drivers/acpi/acpi_processor.c | 2 +-
 drivers/acpi/acpi_watchdog.c  | 2 +-
 drivers/acpi/pci_slot.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 4fe2ef54088c..2ddd36a21850 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -161,7 +161,7 @@ static void cpufreq_add_device(const char *name)
 
 	pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(pdev))
-		pr_info("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
+		pr_info("%s device creation failed: %pe\n", name, pdev);
 }
 
 #ifdef CONFIG_X86
diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 8e9e001da38f..14b24157799c 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -179,7 +179,7 @@ void __init acpi_watchdog_init(void)
 	pdev = platform_device_register_simple("wdat_wdt", PLATFORM_DEVID_NONE,
 					       resources, nresources);
 	if (IS_ERR(pdev))
-		pr_err("Device creation failed: %ld\n", PTR_ERR(pdev));
+		pr_err("Device creation failed: %pe\n", pdev);
 
 	kfree(resources);
 
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index d6cb2c27a23b..741bcc9d6d6a 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -111,7 +111,7 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	snprintf(name, sizeof(name), "%llu", sun);
 	pci_slot = pci_create_slot(pci_bus, device, name, NULL);
 	if (IS_ERR(pci_slot)) {
-		pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));
+		pr_err("pci_create_slot returned %pe\n", pci_slot);
 		kfree(slot);
 		return AE_OK;
 	}
-- 
2.25.1


