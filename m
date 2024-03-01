Return-Path: <linux-kernel+bounces-88579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD6A86E3A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A928658C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D157172A;
	Fri,  1 Mar 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nureRkJd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197C70CD1;
	Fri,  1 Mar 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304261; cv=none; b=gQBnzS4V5GLZLkOFKKDHsW6wRwJYRbQFY0MdggwlQk4LQF4+qHqHc9/TspSrD8L1XJOOD/xvoM1B5oylIY5537m91JalAy4mAgnD0p1tRPebknUKntICAurQ18ew23OokrU1B8v8FG9/2DZLE2FZOEigcGc68U/tmH6RObN14vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304261; c=relaxed/simple;
	bh=8yuh0XAoNI9OAiTz2X7WtSEmZYmZer2dp7rFHu/FS3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv1j3mrbOSwh/ryVEcrNZ+dbNIxZnQ+Zuap89fv9Ksm856HSnxH9vsFbRJDTbloKWeQSEMwjMObumY2DHvsgxFBb4PRxhQYyRuHgs6DDrNNP6hlNNfq6khUfwFTFDNIQZ8HcfdR3Bt4fFV2pi+npC2Ae2M7vb2/naHGbUD/HX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nureRkJd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709304257;
	bh=8yuh0XAoNI9OAiTz2X7WtSEmZYmZer2dp7rFHu/FS3w=;
	h=From:To:Cc:Subject:Date:From;
	b=nureRkJdA9S0y+ABeJGshg3YZBc7bEV0qmW+Kz9rJ8kq4muqUuX6cY9oBiEq/0b3a
	 7aXSh1cS216OxqcaIp3EbaOPFnIxvMNmbR4AJ4AecHnYVRp7f5I7PZa1jn8WZh0nPW
	 zb2evCkXLsvyMC/R+qwofEUNNXLP2/cWoFiYO9LKpveFmU8kbP3+C9VTSDoqvY0lOM
	 O+BrwEvycA1IBSk1jjvMfwG8iHZMLsnNkn4ilWNb/NF4W5UjCKu5jY3oCJ4Vrswt32
	 mE32TA0AU1d4uo9N2tCJVYMy+PhUNvQ1+aIRpzaHrwbCeOmFdYmDuawWErirgMZB1J
	 IeJnMvsNbRlGg==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B62C537803EE;
	Fri,  1 Mar 2024 14:44:14 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Justin Tee <justin.tee@broadcom.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: correct size for cmdwqe/rspwqe for memset
Date: Fri,  1 Mar 2024 19:44:33 +0500
Message-Id: <20240301144434.2809483-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cmdwqe and rspwqe are of type lpfc_wqe128. They should be memset
with the same type.

Fixes: 61910d6a5243 ("scsi: lpfc: SLI path split: Refactor CT paths")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index d80e6e81053b0..8caf54aa20391 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -3169,10 +3169,10 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 	}
 
 	cmdwqe = &cmdiocbq->wqe;
-	memset(cmdwqe, 0, sizeof(union lpfc_wqe));
+	memset(cmdwqe, 0, sizeof(union lpfc_wqe128));
 	if (phba->sli_rev < LPFC_SLI_REV4) {
 		rspwqe = &rspiocbq->wqe;
-		memset(rspwqe, 0, sizeof(union lpfc_wqe));
+		memset(rspwqe, 0, sizeof(union lpfc_wqe128));
 	}
 
 	INIT_LIST_HEAD(&head);
-- 
2.39.2


