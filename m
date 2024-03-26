Return-Path: <linux-kernel+bounces-118553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83F88BC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A14283CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265A7495E5;
	Tue, 26 Mar 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gk9f9tEV"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204E3FB9B;
	Tue, 26 Mar 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442003; cv=none; b=gzZnMiQZXBZ4DYAjD9xw2rGrk86K7GmoB5CUpTeigxowsACfp4juIDyG/RCwLX6/TBV0xkvJZzqLJN5H0aU/rFMIXr0PqagsbGTQR3G3kpJGoChLBTuRgfEtXlRmHA2XuL1s6rQafmXGZ4+WtX/eI6eCpkrIYWX5/p1nxUjCaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442003; c=relaxed/simple;
	bh=L9ECRQuWWxOYBhvGRljfWbWYDuMM29Hmf/oHGt0Mqn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWo84iJxfa0a3p/SEcTOsxO2iCjWAqFO+KSjUStA+U+XH1j1XTDA/aUjQseHoGb4FZ2zIjdZDLegfwhfsq/ypXut6lz0MXNpC8PYeamt2Hz3HlNN4Jejp8+yj3F/Dqrmo3ByYAUTD61nwprTEMC8SfTZOWyPwNMofKYlJVA71/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Gk9f9tEV; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711442001; x=1742978001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9ECRQuWWxOYBhvGRljfWbWYDuMM29Hmf/oHGt0Mqn0=;
  b=Gk9f9tEV7kzCK74oMSaLznTMGfTrbsAYNg0sYhbJIt6QYbxg2r76vIzq
   y0aVjRhcn32aI/q/9v5lW/SS0vPmjfBuNm3ist2km2jtX186wwpZvpQBW
   4Ugitg0iR54jEtUNO7Vq/JTv/e07G79E18sdpN60jEzYVFbUfuuULf2Co
   Ua2KgmjZF25h4CHjptlFYX85T/3jox/xEBf3aCPStpD7VwC+2TNsIscBj
   fYtXsOadJR7TCzn/LepodNJdRNFdAor5q5j39Hm5cN+fD+5nvCkwKb0qF
   LXWYiThpKXze7npgAGKt8l5mz7AL/vqj3J+j7KVRuKK50cVUTjQHRHFwd
   Q==;
X-CSE-ConnectionGUID: vnsO3JvrRE2g1QpW1VJQGw==
X-CSE-MsgGUID: rqeSrDu2QzqevU8jIVUNqg==
X-IronPort-AV: E=Sophos;i="6.07,155,1708358400"; 
   d="scan'208";a="12495279"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 16:33:16 +0800
IronPort-SDR: 4oOtUEAr6RndZlTwpHnGNjTjzMKZAUblQ9r2Ikkrl5G0WNQXFewyXfwUugZIAeVZnMTCeUeOyt
 uTEBdUan39WQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2024 00:42:01 -0700
IronPort-SDR: 081SocrVI7iLooEdak6P7QoSIpS2VFZ8vWMI+zdCe5jSfqhGipOHoxny2mjux0iJdQJaaJ9iLf
 KDl05hg7aALw==
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Mar 2024 01:33:14 -0700
From: Avri Altman <avri.altman@wdc.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 2/2] scsi: ufs: Remove legacy tuning calls
Date: Tue, 26 Mar 2024 10:32:50 +0200
Message-ID: <20240326083253.1303-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240326083253.1303-1-avri.altman@wdc.com>
References: <20240326083253.1303-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those tunings only apply to old host controllers, Now that UFSHCI <= 2.0
has been removed, we can remove those calls as well.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c   | 96 -------------------------------------
 drivers/ufs/host/ufs-qcom.c |  3 +-
 2 files changed, 1 insertion(+), 98 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index cda1939f2d8a..d97590c1c9e7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -980,20 +980,6 @@ u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL(ufshcd_get_local_unipro_ver);
 
-static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
-{
-	/*
-	 * If both host and device support UniPro ver1.6 or later, PA layer
-	 * parameters tuning happens during link startup itself.
-	 *
-	 * We can manually tune PA layer parameters if either host or device
-	 * doesn't support UniPro ver 1.6 or later. But to keep manual tuning
-	 * logic simple, we will only do manual tuning if local unipro version
-	 * doesn't support ver1.6 or later.
-	 */
-	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
-}
-
 /**
  * ufshcd_pm_qos_init - initialize PM QoS request
  * @hba: per adapter instance
@@ -8325,83 +8311,6 @@ static void ufs_put_device_desc(struct ufs_hba *hba)
 	dev_info->model = NULL;
 }
 
-/**
- * ufshcd_tune_pa_tactivate - Tunes PA_TActivate of local UniPro
- * @hba: per-adapter instance
- *
- * PA_TActivate parameter can be tuned manually if UniPro version is less than
- * 1.61. PA_TActivate needs to be greater than or equal to peerM-PHY's
- * RX_MIN_ACTIVATETIME_CAPABILITY attribute. This optimal value can help reduce
- * the hibern8 exit latency.
- *
- * Return: zero on success, non-zero error value on failure.
- */
-static int ufshcd_tune_pa_tactivate(struct ufs_hba *hba)
-{
-	int ret = 0;
-	u32 peer_rx_min_activatetime = 0, tuned_pa_tactivate;
-
-	ret = ufshcd_dme_peer_get(hba,
-				  UIC_ARG_MIB_SEL(
-					RX_MIN_ACTIVATETIME_CAPABILITY,
-					UIC_ARG_MPHY_RX_GEN_SEL_INDEX(0)),
-				  &peer_rx_min_activatetime);
-	if (ret)
-		goto out;
-
-	/* make sure proper unit conversion is applied */
-	tuned_pa_tactivate =
-		((peer_rx_min_activatetime * RX_MIN_ACTIVATETIME_UNIT_US)
-		 / PA_TACTIVATE_TIME_UNIT_US);
-	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TACTIVATE),
-			     tuned_pa_tactivate);
-
-out:
-	return ret;
-}
-
-/**
- * ufshcd_tune_pa_hibern8time - Tunes PA_Hibern8Time of local UniPro
- * @hba: per-adapter instance
- *
- * PA_Hibern8Time parameter can be tuned manually if UniPro version is less than
- * 1.61. PA_Hibern8Time needs to be maximum of local M-PHY's
- * TX_HIBERN8TIME_CAPABILITY & peer M-PHY's RX_HIBERN8TIME_CAPABILITY.
- * This optimal value can help reduce the hibern8 exit latency.
- *
- * Return: zero on success, non-zero error value on failure.
- */
-static int ufshcd_tune_pa_hibern8time(struct ufs_hba *hba)
-{
-	int ret = 0;
-	u32 local_tx_hibern8_time_cap = 0, peer_rx_hibern8_time_cap = 0;
-	u32 max_hibern8_time, tuned_pa_hibern8time;
-
-	ret = ufshcd_dme_get(hba,
-			     UIC_ARG_MIB_SEL(TX_HIBERN8TIME_CAPABILITY,
-					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(0)),
-				  &local_tx_hibern8_time_cap);
-	if (ret)
-		goto out;
-
-	ret = ufshcd_dme_peer_get(hba,
-				  UIC_ARG_MIB_SEL(RX_HIBERN8TIME_CAPABILITY,
-					UIC_ARG_MPHY_RX_GEN_SEL_INDEX(0)),
-				  &peer_rx_hibern8_time_cap);
-	if (ret)
-		goto out;
-
-	max_hibern8_time = max(local_tx_hibern8_time_cap,
-			       peer_rx_hibern8_time_cap);
-	/* make sure proper unit conversion is applied */
-	tuned_pa_hibern8time = ((max_hibern8_time * HIBERN8TIME_UNIT_US)
-				/ PA_HIBERN8_TIME_UNIT_US);
-	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HIBERN8TIME),
-			     tuned_pa_hibern8time);
-out:
-	return ret;
-}
-
 /**
  * ufshcd_quirk_tune_host_pa_tactivate - Ensures that host PA_TACTIVATE is
  * less than device PA_TACTIVATE time.
@@ -8474,11 +8383,6 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
 
 static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
 {
-	if (ufshcd_is_unipro_pa_params_tuning_req(hba)) {
-		ufshcd_tune_pa_tactivate(hba);
-		ufshcd_tune_pa_hibern8time(hba);
-	}
-
 	ufshcd_vops_apply_dev_quirks(hba);
 
 	if (hba->dev_quirks & UFS_DEVICE_QUIRK_PA_TACTIVATE)
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 06859e17b67b..06391f923dba 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -531,8 +531,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 		 * and device TX LCC are disabled once link startup is
 		 * completed.
 		 */
-		if (ufshcd_get_local_unipro_ver(hba) != UFS_UNIPRO_VER_1_41)
-			err = ufshcd_disable_host_tx_lcc(hba);
+		err = ufshcd_disable_host_tx_lcc(hba);
 
 		break;
 	default:
-- 
2.42.0


