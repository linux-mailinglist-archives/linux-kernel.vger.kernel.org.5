Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B280F9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377701AbjLLWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377669AbjLLWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:08:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB50BD;
        Tue, 12 Dec 2023 14:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702418917; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JW+YCINULW0jrItvp1Fumqhh29Lt/58ytXslXDFFaiMIJA1OwtCVj7VO6yic5CKA07
    jrghIyfXlruw/6koDOGsHF5sFnwj5Ft3We9cpJqUJy80KLx6t8mcI+07wGWnKQFqpiMv
    Vit9HKjTarL7cEPr/VPIJubLNyE7g99TinqZ2eXjtMjXCngK9h/E2auTXC0GnVfXkk4B
    0qOaViIdUIkCIJQRt97fQ37fRnOGkIlNinbJyaQvqZ2qKtuSs80OmtkI6pfsUCpklNgP
    67lhPFksj1Xce6cemLcVWvgN2oCiWjQjC5HLwSk0p1MjlO8ikGOitvR3aUATBrqz3yBC
    TJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418917;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mBCAB6o0k8GwOVt8D+hswHcmUf0LGPeHv5+q47SCwak=;
    b=IsOHXVVY2tHvNdVDPLZasVaiy/1QIlKpMhGeB8CDcqS+lDsiBkE128BbWrcU+iTNAN
    m9levfos3yGBWJ9kb1Ms32A38Otv3LL3PKgdX9OsdpkizwXKhfKOWA44eYYJfOJo5pUG
    ydBSU0K+XYvGlhfzJWhaKN/6dJOY3ZiIDKbW25roWwMJWG51VDBfmbWNYpx9G3bwAtC4
    PDI5ooHBLQE6MNWSpFuL12nD92tDUpo7dNMIHpZC3CNlJ9Q6dbGGlMkR8gIQUZ6/s3fL
    +lPI44h5pLG/38Rjw1cQ7OhhOYFIu+R800+25Ya6VI7zK0WR/GvNVBv2BNanKZrssJnr
    3Qbg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418917;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mBCAB6o0k8GwOVt8D+hswHcmUf0LGPeHv5+q47SCwak=;
    b=NaXtvCfbtF5KT6UG5fUU+zIXp5i0uWYJasQwqTLxLVb45B/C5bbEVu72T7Ja8v+Sp+
    BCyRJH11rNRg2hKeEqN6cus/mUfZy01klXgW5Yi8l0Vx+YDCqT7Mxd+I+bs4jEoG0LtH
    0TmII54OkdNaGEKMwMYOzcXpvTDUDT35uCn3AE/AEIfya6zAT30FZU+db43IIKCKdbAZ
    mn3VKZLrFyK/G+oIE8GKVAT7KRoHDXxF+OSXu+qhPrQbxMc5N7IKM+GFA0JOvzRHrlky
    DU3J9F6E1rVeGhYZxc2aeDcyscp4G6ZFLXxcMi8G09vfEVkGoI5IAFdoQm/fm7xYgf9B
    cmTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702418917;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mBCAB6o0k8GwOVt8D+hswHcmUf0LGPeHv5+q47SCwak=;
    b=N0V4BZuauNbJ2d+JtZqHeWqL5N1BuzfjPeEp0ZWXLkouSHEA25CgbOrxdiwj2cvBVp
    qCPxWjP2o1HSKRTx/sDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1krW49WPrbTU8waUHk0CK6S5K43N4UTp8lPg"
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zBCM8bNVz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Dec 2023 23:08:37 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 1/3] scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
Date:   Tue, 12 Dec 2023 23:08:23 +0100
Message-Id: <20231212220825.85255-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212220825.85255-1-beanhuo@iokpp.de>
References: <20231212220825.85255-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
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
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ufs/core/ufshcd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f0b837cb0c2b..43140699bc29 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -235,6 +235,12 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static bool ufshcd_is_ufs_dev_busy(struct ufs_hba *hba)
+{
+	return (hba->clk_gating.active_reqs || hba->outstanding_reqs || hba->outstanding_tasks ||
+		hba->active_uic_cmd || hba->uic_async_done);
+}
+
 static const struct ufs_dev_quirk ufs_fixups[] = {
 	/* UFS cards deviations table */
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
@@ -1917,10 +1923,7 @@ static void ufshcd_gate_work(struct work_struct *work)
 		goto rel_lock;
 	}
 
-	if (hba->clk_gating.active_reqs
-		|| hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL
-		|| hba->outstanding_reqs || hba->outstanding_tasks
-		|| hba->active_uic_cmd || hba->uic_async_done)
+	if (ufshcd_is_ufs_dev_busy(hba) || hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
 		goto rel_lock;
 
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-- 
2.34.1

