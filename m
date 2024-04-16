Return-Path: <linux-kernel+bounces-146619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECE8A6841
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BDF1C20CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC912882E;
	Tue, 16 Apr 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g7Gv0BNG"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E3127E10;
	Tue, 16 Apr 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263053; cv=none; b=iMo/YnfGhWaqD7/ABXB/znHIv3STPuJTVISo8vNoOC3AAcbE8FIe+60CLphmjL9bPkluU4h6MqTtW19sKuLI4QRBM+dxNssxDUopl/ff9toGtf3n+TZriWT1QUcbNRS7JOcsBOBj7hJ98GaMEdy5W18vfif4K9IJAmMiVX8CzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263053; c=relaxed/simple;
	bh=FJtL7cNNjMF/VzoC+btZWRJGr6LfzxoABmE5FgXBdGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOK6c7WuaohNR+b9AWSCiwaBhp9ycA+VNXAOfYouFMKx6yHKP7KN8ICWH4NppTGQ+l5FBARTn3ZHNN+j70XQzh1kl2H/cKVsGw42BNQvlDoEDlKd5ouATQkGihdPvB4VyWvWxKP9qeN7tCLYx5LNDgS/X3MlwhTRF58xRObW4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g7Gv0BNG; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263052; x=1744799052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJtL7cNNjMF/VzoC+btZWRJGr6LfzxoABmE5FgXBdGQ=;
  b=g7Gv0BNGl3zKzl5n/szHXv49X0nZerXaGoidZfn0wWA4fFnbau47xBsG
   YWuA/tlsSnKTeL9+WfUGwmlZfpPgpGlSbX33ftVMSJCegJ7P4/zdTI1Dv
   Y+bFoExJFX7jyrXV5p7YnB/2iaVfyeevr9r1jX6mieSAn1GqmNYA+sKyD
   KDVxST30sUSwQ+oLyVuQyXu8vFm8OoZ8/0YJErANiwz27jOH5tGcUq93S
   RhcJ5A2QLBkJTxN/mi280pOR2tZBNQehd32EoU42J2qzsbAjaD+4+aG7j
   DR7KBBMgN6Cjkem+mF0kEhosf8tOxO8oQkRYZVt531nhA8ZKOmj0T8mTO
   Q==;
X-CSE-ConnectionGUID: jl5iqxCzQb+no5ScINq4Ng==
X-CSE-MsgGUID: jOwTB1tLQ02d0rj+SRqLdQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14321982"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:24:11 +0800
IronPort-SDR: pq1vo5Xk1TwnDJaFBnX/72Gl07t4L9EKsNp/9TmVxjp8XIVtS6HvibI9RGx3izGcKN0C6iAvxK
 kvaeS0VcCFG0T8WxezSwaNtvc0n/obi4Sjb3IsynKC+yZb/iZCjwakvttT4fCZxU0+IGV4pAOp
 lo2qbgwWL5pAacKrOVa+1vopUalxrWLRqDwe7LUkLiJYS8+xMoOoNR851HSFzDhlHUMPita/1b
 KqDWYz5xOqnrQlvgYt9oB6yF93sCxqFm1diLIwoboLGdmvkr892hzD6Pktw65vG2l0sLunowB1
 cGA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:32:31 -0700
IronPort-SDR: swG6jxW4tqkBoUWRKD88qmAvdmv+1Jbmwj0idrch1kLjBIKqNXIm+8g6uyLyQfVaOQFSK2qgY6
 qZqJYmpdi5N0ZnMiU0qVfcqoNbzivyLHxgrLL5mxlxoH8f5WKqs2/J4LTQWPg3XHIVbAORxpuZ
 CJpYJrMxShIAJkqySA4WUNtcMLkcCL5A9RI9PS1BJNBw4cH3f56CwKZxGc2RtflhtpODR1Z+DT
 LOJ6DlN6fLj5HZLSc5cw40S0NJ67VGFmBY5OuVtf6KkK8HkC1kLabraEo0qVwVNX14erlkS9rl
 lY4=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2024 03:24:09 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 3/4] scsi: ufs: core: Make use of guard(spinlock_irq)
Date: Tue, 16 Apr 2024 13:23:47 +0300
Message-ID: <20240416102348.614-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416102348.614-1-avri.altman@wdc.com>
References: <20240416102348.614-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded handling with cleanup.h guard(spinlock_irq).

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 92ac6a358365..3c62b69bbd52 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6309,10 +6309,9 @@ void ufshcd_schedule_eh_work(struct ufs_hba *hba)
 
 static void ufshcd_force_error_recovery(struct ufs_hba *hba)
 {
-	spin_lock_irq(hba->host->host_lock);
+	guard(spinlock_irq)(hba->host->host_lock);
 	hba->force_reset = true;
 	ufshcd_schedule_eh_work(hba);
-	spin_unlock_irq(hba->host->host_lock);
 }
 
 static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
-- 
2.42.0


