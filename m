Return-Path: <linux-kernel+bounces-90273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A886FCB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7781F2168B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926CE1BF3D;
	Mon,  4 Mar 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GAj+fQta"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625501A58B;
	Mon,  4 Mar 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543191; cv=none; b=HqbEkQuM9VLg2nFbyDeCkMWI8Meo3iqu3hi/x7JeUUnltzNH3TJ6vwu/ZBQJOVOnjw2a/syJ0jEdzmBHu2fP4ZOltJoIyuSf9F7RaaNaPf7aGahrbiMq/y9sZw7p5Zx0MYYrgGEGcNA1PpjBIOvjnNaY6kwWlJqZvLndokw4a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543191; c=relaxed/simple;
	bh=GCuw5Sm9pjw8RPsF+AZn1B/kTPwUEgdiAsqcOZ4ANW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+F0nfqV8n4FGanRatN6e+RD5tQd1kgVzUdAmD9AixJ750rsGuWF/warwoy21g5Ndo3xgPt5HhFGZHu9TLZrqv8/T6O4k6/QAm1bWDB+zpnPfi5NCagiPsSCvv74wdL5H3bvJASyCU22hZofLv0KRlPE+bgvTqbnvNiOnrd2984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GAj+fQta; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709543188;
	bh=GCuw5Sm9pjw8RPsF+AZn1B/kTPwUEgdiAsqcOZ4ANW4=;
	h=From:To:Cc:Subject:Date:From;
	b=GAj+fQtaM6u3iin5ZbT5b0HjMjDpd/odSbjNw77qL0jim7x03ptPzJ3bAn2cN7C4R
	 RUhQyBKG4m5ZeDvxb18qKB6sFfIH9e90sYI+neWLEe6F0yURn8zBzKGUulqISlmwBQ
	 XxV3K0kgY+E6imnSaPWHGnyw36w4DWbvtI3BR88NCiRrDf8hY02+T+Zaj2sAag6Kot
	 Gz96q1i1YBfXSQGnD7tdvpdbhT+gdyoLdJWooHAMAzWI8tAPFk+Noj//Q/Cutvcgih
	 6RpS3PiGj43mprxgFFChFZ4PPKIBfO6NH4UM4Rq7JnY4NYOWP6rS0m6sAnm00Kmk68
	 EBHE8sb39w5dQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BD3A53781FE9;
	Mon,  4 Mar 2024 09:06:25 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: lpfc: correct size for wqe for memset
Date: Mon,  4 Mar 2024 14:06:48 +0500
Message-Id: <20240304090649.833953-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wqe is of type lpfc_wqe128. It should be memset with the same type.

Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Use *wqe instead of type to find sizeof
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 8258b771bd009..561ced5503c63 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(*wqe));
 
 		ctx_buf->iocbq->cmd_dmabuf = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);
-- 
2.39.2


