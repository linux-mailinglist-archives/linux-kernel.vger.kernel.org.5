Return-Path: <linux-kernel+bounces-23473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C48082AD43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2131C22541
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6F1549E;
	Thu, 11 Jan 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dpIIZg/1"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7011815483;
	Thu, 11 Jan 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=oYIJtJZyfg4O+s7Vei
	8aQJlxSwWP1pijhtijPJRzGR8=; b=dpIIZg/1cF+d+AG1FasItcx4haTsUYRy1N
	RxSCESZgvn1AKaE8/9Bk+a2Nl1nSvEAmVBw9OUpjTIqAS3ChwyRiB1xYjgw/3jsV
	tYRjg0h+jtog8q+6xqzwd/JI1G4Nzbe5K6PvRdrPicL+FpWi7XWwiqP70ZcdWuse
	eyOopUEd4=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3X9dmz59lMjg5AA--.49211S2;
	Thu, 11 Jan 2024 19:22:15 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	mrangankar@marvell.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: qla4xxx: Clean up errors in ql4_iocb.c
Date: Thu, 11 Jan 2024 11:22:13 +0000
Message-Id: <20240111112213.15635-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X9dmz59lMjg5AA--.49211S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryDWw45JFWkKFW5Jr18Xwb_yoW8JFWfpF
	4vy345Cw48AF1UuryUAFn5uFya9w1qgryUGan3Wa98AFn8uFyvvr1jyFyYkas5Wwn7GF1S
	gF1Dtry3WF1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0FAJUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhJixWVEuYG6PgADsR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo * bar" should be "foo *bar"
ERROR: space required before the open brace '{'

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/qla4xxx/ql4_iocb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_iocb.c b/drivers/scsi/qla4xxx/ql4_iocb.c
index 28eab07935ba..3b2680e91d0b 100644
--- a/drivers/scsi/qla4xxx/ql4_iocb.c
+++ b/drivers/scsi/qla4xxx/ql4_iocb.c
@@ -269,7 +269,7 @@ void qla4xxx_complete_iocb(struct scsi_qla_host *ha)
  * This routine is called by qla4xxx_queuecommand to build an ISP
  * command and pass it to the ISP for execution.
  **/
-int qla4xxx_send_command_to_isp(struct scsi_qla_host *ha, struct srb * srb)
+int qla4xxx_send_command_to_isp(struct scsi_qla_host *ha, struct srb *srb)
 {
 	struct scsi_cmnd *cmd = srb->cmd;
 	struct ddb_entry *ddb_entry;
@@ -342,7 +342,7 @@ int qla4xxx_send_command_to_isp(struct scsi_qla_host *ha, struct srb * srb)
 			cmd_entry->control_flags = CF_READ;
 
 		ha->bytes_xfered += scsi_bufflen(cmd);
-		if (ha->bytes_xfered & ~0xFFFFF){
+		if (ha->bytes_xfered & ~0xFFFFF) {
 			ha->total_mbytes_xferred += ha->bytes_xfered >> 20;
 			ha->bytes_xfered &= 0xFFFFF;
 		}
-- 
2.17.1


