Return-Path: <linux-kernel+bounces-23468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F882AD35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9701B276E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA80154AA;
	Thu, 11 Jan 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nhG/q6g3"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375F15482;
	Thu, 11 Jan 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=cB25jPkT/OUAqdkvrs
	8IO222AXTpToimApsiw6mRBog=; b=nhG/q6g3t7LW3hGU25I09TYd7TFgiX5ZfP
	lJ9iX+Q22F9JPdHe6WpM39X//UIM1jkTC7prdkY2tA169guD+Wl5OwdRLCYwXKCC
	eUNl7K8jY6rZB8/YuL5u3+/2uXBYfGG6r1Vhal2GmOFHkfdnuszkI5hEA+m/aXPd
	FdObKzBPM=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3P8iQzp9lG_anAA--.34371S2;
	Thu, 11 Jan 2024 19:18:41 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	mrangankar@marvell.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: qla4xxx: Clean up errors in ql4_isr.c
Date: Thu, 11 Jan 2024 11:18:39 +0000
Message-Id: <20240111111839.15463-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P8iQzp9lG_anAA--.34371S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFW7tr4kAr1rWry7uryrXrb_yoW8JF15pF
	4DJw15Zr48A3WjkFWYyF9xur15uFy0qrW7KasxW3s8ZF98Ja95Zw1DtFyY9F97W3s5AF1S
	vF1ktry5ua1UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0FAJUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhJixWVEuYG6PQAAsR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo * bar" should be "foo *bar"
ERROR: need consistent spacing around '&' (ctx:WxV)

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/qla4xxx/ql4_isr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index cf52258ecdde..e05c36168cc5 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -161,7 +161,7 @@ static void qla4xxx_status_entry(struct scsi_qla_host *ha,
 			break;
 		}
 
-		if (sts_entry->iscsiFlags &ISCSI_FLAG_RESIDUAL_UNDER) {
+		if (sts_entry->iscsiFlags & ISCSI_FLAG_RESIDUAL_UNDER) {
 			scsi_set_resid(cmd, residual);
 			if (!scsi_status && ((scsi_bufflen(cmd) - residual) <
 				cmd->underflow)) {
@@ -653,7 +653,7 @@ static void qla4xxx_default_router_changed(struct scsi_qla_host *ha,
  * This routine decodes the mailbox status during the ISR.
  * Hardware_lock locked upon entry. runs in interrupt context.
  **/
-static void qla4xxx_isr_decode_mailbox(struct scsi_qla_host * ha,
+static void qla4xxx_isr_decode_mailbox(struct scsi_qla_host *ha,
 				       uint32_t mbox_status)
 {
 	int i;
-- 
2.17.1


