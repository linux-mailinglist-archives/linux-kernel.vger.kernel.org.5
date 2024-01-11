Return-Path: <linux-kernel+bounces-23464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5AF82AD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5BA1C20A38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771C14F9B;
	Thu, 11 Jan 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Y0oWSKdD"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3814F80;
	Thu, 11 Jan 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=tvTGsctEpaQmgcM111
	a9YFZe1/B7Al7AlizSY3uBAZU=; b=Y0oWSKdDLAZ2tRMwDLggzLHm7qdfgCzfhi
	2JAUZdWjvoLQz5nQWqwHdCh/Elp/69jjVsXJhNCaMviy5ETG6VrIpPg6x34/kSMp
	FgpldrXV+o2MUfEHK7yzvm0lpu1hXdzvJUgxf2d4jKEdrErepaeJEzU1D2EOUN7j
	ZroTYdE5E=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDXf3fRzZ9lSFOnAA--.12694S2;
	Thu, 11 Jan 2024 19:15:30 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	mrangankar@marvell.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: qla4xxx: Clean up errors in ql4_mbx.c
Date: Thu, 11 Jan 2024 11:15:28 +0000
Message-Id: <20240111111528.15374-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXf3fRzZ9lSFOnAA--.12694S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1ruw48JF1ktw1DuF4xXrb_yoW8ur1fpF
	WkXa1Ykr4jkr9YgrWUAF45Crnxur10qry7Kas5Gw1FkF4YyFZ5urWjkFWruF95G34kX3WS
	gF1jyrWrWF4DXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0FAJUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhNixWVEuYGwJAAAsD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

RROR: "foo * bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/qla4xxx/ql4_mbx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index 249f1d7021d4..fcd03dbcea8b 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -616,7 +616,7 @@ qla4xxx_update_local_ifcb(struct scsi_qla_host *ha,
  * qla4xxx_initialize_fw_cb - initializes firmware control block.
  * @ha: Pointer to host adapter structure.
  **/
-int qla4xxx_initialize_fw_cb(struct scsi_qla_host * ha)
+int qla4xxx_initialize_fw_cb(struct scsi_qla_host *ha)
 {
 	struct addr_ctrl_blk *init_fw_cb;
 	dma_addr_t init_fw_cb_dma;
@@ -698,7 +698,7 @@ int qla4xxx_initialize_fw_cb(struct scsi_qla_host * ha)
  * qla4xxx_get_dhcp_ip_address - gets HBA ip address via DHCP
  * @ha: Pointer to host adapter structure.
  **/
-int qla4xxx_get_dhcp_ip_address(struct scsi_qla_host * ha)
+int qla4xxx_get_dhcp_ip_address(struct scsi_qla_host *ha)
 {
 	struct addr_ctrl_blk *init_fw_cb;
 	dma_addr_t init_fw_cb_dma;
@@ -737,7 +737,7 @@ int qla4xxx_get_dhcp_ip_address(struct scsi_qla_host * ha)
  * qla4xxx_get_firmware_state - gets firmware state of HBA
  * @ha: Pointer to host adapter structure.
  **/
-int qla4xxx_get_firmware_state(struct scsi_qla_host * ha)
+int qla4xxx_get_firmware_state(struct scsi_qla_host *ha)
 {
 	uint32_t mbox_cmd[MBOX_REG_COUNT];
 	uint32_t mbox_sts[MBOX_REG_COUNT];
@@ -768,7 +768,7 @@ int qla4xxx_get_firmware_state(struct scsi_qla_host * ha)
  * qla4xxx_get_firmware_status - retrieves firmware status
  * @ha: Pointer to host adapter structure.
  **/
-int qla4xxx_get_firmware_status(struct scsi_qla_host * ha)
+int qla4xxx_get_firmware_status(struct scsi_qla_host *ha)
 {
 	uint32_t mbox_cmd[MBOX_REG_COUNT];
 	uint32_t mbox_sts[MBOX_REG_COUNT];
-- 
2.17.1


