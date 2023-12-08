Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8E80A1F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573618AbjLHKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbjLHKkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:40:17 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72830199A;
        Fri,  8 Dec 2023 02:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702031989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X2NYuAd/M+joW0pWe3l7KB0uDjyclgCr6MiibDFbl37Ont9KMN9Nwsq3X5MPPPGf1K
    6AB0glok9gbakX5f4QDCBYvK61Gd5vias5UYEjMfHsczZe3g1JVzFy32WCwQnRic32bl
    5Z9MOnHXierJvRHjxgxcwWetA6Kv40uQU94owMY3dq4/UltFaBjdOwVsafOHH/0FTz6c
    FqmLFh9G7s0p7xNxQn9rPKFzpkfeRQZKP/s1aUW/8JGBYwzEBxGxe1fDzGqO+prw37zq
    d4Uki5Tsx5UeSZo6sJWXa5lxYiigm7cHeUr01CZOIidBKcY3Tv7r/Lwg3OQidTKjHBAE
    E47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WshsXzYobF6aU8b/TwxHeFrJvt/30IpR0AsKITwfNw4=;
    b=l3AYDMSgOwAn3Hudhcpe6eY7D6xew2EsZOWxG0HKaa4uKI6uE5DER40x1V6zD9QgwL
    1TCpTDZSC68dEgPdSUCu9GeNEb+Yx777m3ZQaOb8xEVMdrQIt4pd17C8QSnaG8MHqio1
    072Aik7lFx9pt5mVARWEiDeZeK+qSEHV0RKcj/zeZFO0A6+6huX5cn+d3CI+aVmBu9vN
    v3bZFKhfjXxs8Vgqkmo/l5i4XzqctvOftoyEyipFYxM9rLlFNuKLpAwRdZx86LXG3kt2
    vByUO1nAbKu+A+JQ+OfiaOH9i1295OMakJdCLV8gxROF1Vuspi15q4LESSjYMRfvv+4i
    ea9Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WshsXzYobF6aU8b/TwxHeFrJvt/30IpR0AsKITwfNw4=;
    b=kEKahupk5Wo3x33mSts3H1vqJjbZ9uAK8Bjhr57FRX5+W5eQ8QHhm4cSZX9k9zdrPd
    pUZHdtqqcFBvQ2x7MQBARaRmQZhiBFVrKA/xS3d/fuHqMM+KTQ930tft+Ut+dSAks866
    d3eWtUqkCRCIPpPRCH/3/8Ha7h6b1KyTCcyosvEjy3tYfm9Dt6b+HPuP5MoFRbYcWFWn
    zehVWAzTSXwld3dxdBBm5yfTsNXbgvLRMUG29Vc+boKUEEUzUJ1ydYoaWWYpU97EIgBD
    GF9PVZyKMUsmGvlWimP+B+5ouN5dwlBuvhxy3TIY3jB3yXifTldR7vFIv1gJzqOTJov0
    Rv0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702031989;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WshsXzYobF6aU8b/TwxHeFrJvt/30IpR0AsKITwfNw4=;
    b=aAuCPI/4QCY/8fLS0DaBq3xDILgQD2bynTZihytRSrOWTFZY3H0BJ9XbX8mHMfXkYI
    XW5Mu3s9qFjATkcHz5Ag==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB8AdmBb4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Dec 2023 11:39:48 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: [PATCH v4 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Date:   Fri,  8 Dec 2023 11:39:38 +0100
Message-Id: <20231208103940.153734-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208103940.153734-1-beanhuo@iokpp.de>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add helper inline for retrieving whether UFS device is busy or not.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f0b837cb0c2b..32cfcba66d60 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -235,6 +235,13 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static inline bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
+{
+	return (hba->clk_gating.active_reqs || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
+		hba->outstanding_reqs || hba->outstanding_tasks || hba->active_uic_cmd ||
+		hba->uic_async_done);
+}
+
 static const struct ufs_dev_quirk ufs_fixups[] = {
 	/* UFS cards deviations table */
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
@@ -1917,10 +1924,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 		goto rel_lock;
 	}
 
-	if (hba->clk_gating.active_reqs
-		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->outstanding_reqs || hba->outstanding_tasks
-		|| hba->active_uic_cmd || hba->uic_async_done)
+	if (ufshcd_is_ufs_dev_busy(hba))
 		goto rel_lock;
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-- 
2.34.1

