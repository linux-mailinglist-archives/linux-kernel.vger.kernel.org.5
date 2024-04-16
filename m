Return-Path: <linux-kernel+bounces-146620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE58A6843
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63D61F21BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7E127E3A;
	Tue, 16 Apr 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dxh1bB8D"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF6127E28;
	Tue, 16 Apr 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263068; cv=none; b=bv8yGezOLrjBky3WpE2ypvwk7p7RI/2DmTYEcBTMiZePMoo8salBi/FC59OZbdkjmy6WD4n34aeHtobra6/rVeOX4S09agbtKwPgydhZWfLQ9GhSvICGv3LLWzshJCeUouZSDSozbeMpJCKpypKQWH+laZSK1T5+yCtG653TIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263068; c=relaxed/simple;
	bh=hTcCxJ81W6DpF6AmJDnsbXoTrSkwCNqtFbf41sEPkZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBHK3GkEY7M9Lh0fmw9V6eO9Ecb1Kr3n7cPvj0n4OPMnW0vsVoI6MI+p/983ROzeU/oxVHg9wuIoepDuvzWZGGmFzGrIvxo97fZZ/ABv362MTCAiXrCBWl3SuPGr/E0b99sjXEQU5LK2aLIjNtruKF2iuxWyqTuoTXaDGlALS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dxh1bB8D; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263066; x=1744799066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTcCxJ81W6DpF6AmJDnsbXoTrSkwCNqtFbf41sEPkZs=;
  b=dxh1bB8D7AgwoysOn7ASQ8w+moJCFcotaJmLEZf2ehnaFd0hpP+f2Gdz
   DTV2x2gxa3pZhZ1VcS2LzgQU550SR73tonS/aQ0j7qVqTL0wNN2dZAdNU
   Z8ED3q7L2eKPfiX6th2V62+usCTmQ73zl9njzyO9H17zAFqi+ZQvQFLdZ
   TFriYhP8mMW5jRM5Ji+irCxGUAhUG4AVK5JavIRPMzGah/UpcDc8RC2hV
   EZRJhmCtk+qj8AvAfPHlvpiReQYdH2mmPA8ZPvmBrjt4scoh1p6qufUkw
   FIaSAtzxCO13dw9ZO/mBuDpdrc9GUFsZ1hxTRiEpmLpOqH5FST0U0lrrr
   Q==;
X-CSE-ConnectionGUID: +UgUWEwHSEeQN7R4duybgw==
X-CSE-MsgGUID: nmW7dhJnStiVgCQk9+a/XQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796379"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:24:25 +0800
IronPort-SDR: S9EzlP8rGimqOvlQBymaOb1hpbL/GsejJ+awZAWUqE+L6Att5pQukYob02+9D3JVid9VkInjRE
 877yLG2odv0g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:27:03 -0700
IronPort-SDR: QieiRUn5/lbHJYF3wN3c7A0+5ShprdOBLi5+H1V0jxVwd/YvfnlSu7NvCZ+AB+ouGasTG0rJZo
 3yhjtGfPVAYhxbB5iNHos1LV/9fNh12D39gC8CFDkDREowNe6Rd08phorO7HtFHLM0v1my7tP5
 YJj3cO1ScnPp48zu8CFNTHzJ2Ij0wGdeOowEXrhDZCSmYbDJjivzNzTMYyonHaC5Om+ywaP8G/
 1bYF4y6BSQYkxlScRl4zOy+D/pJubrsHb8F/ai+plOrymqTI1huGFSOOHS90kQTEWG7kpT97ld
 DUs=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2024 03:24:23 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 4/4] scsi: ufs: core: Make use of guard(mutex)
Date: Tue, 16 Apr 2024 13:23:48 +0300
Message-ID: <20240416102348.614-5-avri.altman@wdc.com>
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

Replace few lock/unlock instances.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3c62b69bbd52..c4b6b8276c20 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4240,7 +4240,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 	int ret;
 	bool reenable_intr = false;
 
-	mutex_lock(&hba->uic_cmd_mutex);
+	guard(mutex)(&hba->uic_cmd_mutex);
+
 	ufshcd_add_delay_before_dme_cmd(hba);
 
 	scoped_guard(spinlock_irqsave, hba->host->host_lock) {
@@ -4310,8 +4311,6 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		}
 	}
 
-	mutex_unlock(&hba->uic_cmd_mutex);
-
 	return ret;
 }
 
@@ -5682,9 +5681,8 @@ int ufshcd_write_ee_control(struct ufs_hba *hba)
 {
 	int err;
 
-	mutex_lock(&hba->ee_ctrl_mutex);
+	guard(mutex)(&hba->ee_ctrl_mutex);
 	err = __ufshcd_write_ee_control(hba, hba->ee_ctrl_mask);
-	mutex_unlock(&hba->ee_ctrl_mutex);
 	if (err)
 		dev_err(hba->dev, "%s: failed to write ee control %d\n",
 			__func__, err);
@@ -5697,7 +5695,7 @@ int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
 	u16 new_mask, ee_ctrl_mask;
 	int err = 0;
 
-	mutex_lock(&hba->ee_ctrl_mutex);
+	guard(mutex)(&hba->ee_ctrl_mutex);
 	new_mask = (*mask & ~clr) | set;
 	ee_ctrl_mask = new_mask | *other_mask;
 	if (ee_ctrl_mask != hba->ee_ctrl_mask)
@@ -5707,7 +5705,6 @@ int ufshcd_update_ee_control(struct ufs_hba *hba, u16 *mask,
 		hba->ee_ctrl_mask = ee_ctrl_mask;
 		*mask = new_mask;
 	}
-	mutex_unlock(&hba->ee_ctrl_mutex);
 	return err;
 }
 
@@ -6316,11 +6313,10 @@ static void ufshcd_force_error_recovery(struct ufs_hba *hba)
 
 static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
 {
-	mutex_lock(&hba->wb_mutex);
+	guard(mutex)(&hba->wb_mutex);
 	down_write(&hba->clk_scaling_lock);
 	hba->clk_scaling.is_allowed = allow;
 	up_write(&hba->clk_scaling_lock);
-	mutex_unlock(&hba->wb_mutex);
 }
 
 static void ufshcd_clk_scaling_suspend(struct ufs_hba *hba, bool suspend)
-- 
2.42.0


