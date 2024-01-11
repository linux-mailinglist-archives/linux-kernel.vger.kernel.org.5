Return-Path: <linux-kernel+bounces-23471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7482AD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7471F23C70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8715482;
	Thu, 11 Jan 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ArgySdPj"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACCD14F90;
	Thu, 11 Jan 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=osRvs2ABfqQWX1//Y6
	hqf42lJUeYhd9C83o9qjjOFpQ=; b=ArgySdPj6VLq5h4FzKkD2GeKTNzPCM4iqI
	4dHGfHRo3C30RDbvUjhOaaAnkNDy+I64DdrTJDH6JMRi+tU1qjxZAX2Koef47m2f
	AQydzvjL6vHDBfg2MnYyGwOQLkmAOpShp7GSpdPb7bJyweCH75En+N6HI1ome2zD
	sw9R1/Xpc=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wC3v2AYz59lmACoAA--.37053S2;
	Thu, 11 Jan 2024 19:20:56 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	mrangankar@marvell.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: qla4xxx: Clean up errors in ql4_glbl.c
Date: Thu, 11 Jan 2024 11:20:54 +0000
Message-Id: <20240111112054.15549-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wC3v2AYz59lmACoAA--.37053S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWrGw4fZrWrGF4kCF45Jrb_yoWDJrc_uw
	4jvr97Gw17tF1fX34DZFyfA3WSvFnYqF109F1rK3s3u3s3ZrnxJrnxZrWfZ3WFq3y7AFWf
	Aw4DXryYyr15XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUxu4UUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhJixWVEuYG6PgABsT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/qla4xxx/ql4_glbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_glbl.h b/drivers/scsi/qla4xxx/ql4_glbl.h
index c0873381508d..8e7216d4e065 100644
--- a/drivers/scsi/qla4xxx/ql4_glbl.h
+++ b/drivers/scsi/qla4xxx/ql4_glbl.h
@@ -44,7 +44,7 @@ int qla4xxx_get_fwddb_entry(struct scsi_qla_host *ha,
 			    uint16_t *tcp_source_port_num,
 			    uint16_t *connection_id);
 
-int qla4xxx_set_ddb_entry(struct scsi_qla_host * ha, uint16_t fw_ddb_index,
+int qla4xxx_set_ddb_entry(struct scsi_qla_host *ha, uint16_t fw_ddb_index,
 			  dma_addr_t fw_ddb_entry_dma, uint32_t *mbx_sts);
 uint8_t qla4xxx_get_ifcb(struct scsi_qla_host *ha, uint32_t *mbox_cmd,
 			 uint32_t *mbox_sts, dma_addr_t init_fw_cb_dma);
-- 
2.17.1


