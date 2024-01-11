Return-Path: <linux-kernel+bounces-23460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521482AD15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2660E1F23C48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC24156D2;
	Thu, 11 Jan 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="l7DFsK+R"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32524156C1;
	Thu, 11 Jan 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Ht4MnEG5NluBwbXbW6
	vqVxhbh7xq6/A58NBUbDmjMTg=; b=l7DFsK+RIianOK3E64WVGDnuMwxWeQRI/O
	O2JGxwagNNwYIBYrv4p2YzzGRa1QgJcE5EKe7piOT6ZVMq92pipSV9ApZEXU+xqJ
	D81Z+DOHdmuIlIxk9H4rgyfW0fGhCu2fwRzJrFNsPogpEx0ugxEBcQgnNyHaOPU4
	OZK8izqxM=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3_59MzZ9l19GnAA--.21967S2;
	Thu, 11 Jan 2024 19:13:16 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	mrangankar@marvell.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi/qla4xxx: Clean up errors in ql4_nvram.c
Date: Thu, 11 Jan 2024 11:13:15 +0000
Message-Id: <20240111111315.15286-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3_59MzZ9l19GnAA--.21967S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1ruw47Gw45KF1rJFWrXwb_yoW5JFyfpF
	y8Gas8ur4Utry7urZ8tFs8ur1furyxt342kw43W3y0vF1DA3y8Ary8ZFy0vasIg3s8GF1I
	9F4qyF1rWr4UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0FAJUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGBBixWVLZWqBEQAAse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

RROR: "foo * bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/qla4xxx/ql4_nvram.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_nvram.c b/drivers/scsi/qla4xxx/ql4_nvram.c
index f08a5abcb31a..b30d119e6327 100644
--- a/drivers/scsi/qla4xxx/ql4_nvram.c
+++ b/drivers/scsi/qla4xxx/ql4_nvram.c
@@ -32,7 +32,7 @@ static inline int eeprom_no_data_bits(struct scsi_qla_host *ha)
 	return FM93C56A_DATA_BITS_16;
 }
 
-static int fm93c56a_select(struct scsi_qla_host * ha)
+static int fm93c56a_select(struct scsi_qla_host *ha)
 {
 	DEBUG5(printk(KERN_ERR "fm93c56a_select:\n"));
 
@@ -41,7 +41,7 @@ static int fm93c56a_select(struct scsi_qla_host * ha)
 	return 1;
 }
 
-static int fm93c56a_cmd(struct scsi_qla_host * ha, int cmd, int addr)
+static int fm93c56a_cmd(struct scsi_qla_host *ha, int cmd, int addr)
 {
 	int i;
 	int mask;
@@ -105,14 +105,14 @@ static int fm93c56a_cmd(struct scsi_qla_host * ha, int cmd, int addr)
 	return 1;
 }
 
-static int fm93c56a_deselect(struct scsi_qla_host * ha)
+static int fm93c56a_deselect(struct scsi_qla_host *ha)
 {
 	ha->eeprom_cmd_data = AUBURN_EEPROM_CS_0 | 0x000f0000;
 	eeprom_cmd(ha->eeprom_cmd_data, ha);
 	return 1;
 }
 
-static int fm93c56a_datain(struct scsi_qla_host * ha, unsigned short *value)
+static int fm93c56a_datain(struct scsi_qla_host *ha, unsigned short *value)
 {
 	int i;
 	int data = 0;
@@ -135,8 +135,8 @@ static int fm93c56a_datain(struct scsi_qla_host * ha, unsigned short *value)
 	return 1;
 }
 
-static int eeprom_readword(int eepromAddr, u16 * value,
-			   struct scsi_qla_host * ha)
+static int eeprom_readword(int eepromAddr, u16 *value,
+			   struct scsi_qla_host *ha)
 {
 	fm93c56a_select(ha);
 	fm93c56a_cmd(ha, FM93C56A_READ, eepromAddr);
@@ -146,7 +146,7 @@ static int eeprom_readword(int eepromAddr, u16 * value,
 }
 
 /* Hardware_lock must be set before calling */
-u16 rd_nvram_word(struct scsi_qla_host * ha, int offset)
+u16 rd_nvram_word(struct scsi_qla_host *ha, int offset)
 {
 	u16 val = 0;
 
@@ -176,7 +176,7 @@ u8 rd_nvram_byte(struct scsi_qla_host *ha, int offset)
 	return rval;
 }
 
-int qla4xxx_is_nvram_configuration_valid(struct scsi_qla_host * ha)
+int qla4xxx_is_nvram_configuration_valid(struct scsi_qla_host *ha)
 {
 	int status = QLA_ERROR;
 	uint16_t checksum = 0;
-- 
2.17.1


