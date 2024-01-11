Return-Path: <linux-kernel+bounces-23479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4582AD50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D941C2309F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E0154BD;
	Thu, 11 Jan 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="p4Npi6b7"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48402154AE;
	Thu, 11 Jan 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=r2mRilxOzWr0QOwJkt
	E+hPAsQZmw8pw9Sysb6KyWArg=; b=p4Npi6b7/17VCpT8F0yoB71JLy4LWHz19Z
	FgTGRC4eoISiZJ2fu1E+QWWW99uk0EnNGjkv3dlC5pw/q3ncxCUogZL24zQHkFuj
	qVhhkpRU9rcLwpsdR5jZmxCsq8Bnh/zkFNBs5IkQwNlw4jarFY1d3/7FKTZ3Q6l6
	xgkKEdf4c=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3P6ki0J9loTc5AA--.32143S2;
	Thu, 11 Jan 2024 19:25:22 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	aacraid@microsemi.com,
	martin.petersen@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: aacraid: Clean up errors in aachba.c
Date: Thu, 11 Jan 2024 11:25:21 +0000
Message-Id: <20240111112521.15723-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P6ki0J9loTc5AA--.32143S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWrGw4fZrWrGF4kCry8Xwb_yoWDXrX_ur
	43twn7GryUCFsakrn8Cw18ZFyjvan7XrnYvF4Fg3y7AayDZF1xAr40vrnxA34rWF4093Wr
	Aw4jqFn2kwnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiqXd5UUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGANixWVLZWqkSgAAsz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/aacraid/aachba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 70e1cac1975e..29a12a952e25 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -224,7 +224,7 @@ static long aac_build_sghba(struct scsi_cmnd *scsicmd,
 static int aac_convert_sgraw2(struct aac_raw_io2 *rio2,
 				int pages, int nseg, int nseg_new);
 static void aac_probe_container_scsi_done(struct scsi_cmnd *scsi_cmnd);
-static int aac_send_srb_fib(struct scsi_cmnd* scsicmd);
+static int aac_send_srb_fib(struct scsi_cmnd *scsicmd);
 static int aac_send_hba_fib(struct scsi_cmnd *scsicmd);
 #ifdef AAC_DETAILED_STATUS_INFO
 static char *aac_get_status_string(u32 status);
-- 
2.17.1


