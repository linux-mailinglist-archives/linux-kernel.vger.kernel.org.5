Return-Path: <linux-kernel+bounces-23454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F082AD07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B789B25BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D914F97;
	Thu, 11 Jan 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GWDvW8kf"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5F14F88;
	Thu, 11 Jan 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=5sjLwUPk7GW0AYnZdr
	pWLEmyQy7eYTGg/d7DZKCHq6w=; b=GWDvW8kfl9KDvl1mm6occPSzLG1Ba9xq+0
	fCwM9WnqnZ7XRaRNeGYL2DLUks0Q3naNm89ugpnZqqxxJ/BhD3HWCUlYrBx+mSgG
	3wf/QZr+BSd5g9448yOrgAick6GhE7gNQs6EOmoG/GwpmeyXRr3dPD9v1AGLDPtP
	E2t+mJTvY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3H3fLzJ9lxzinAA--.14213S2;
	Thu, 11 Jan 2024 19:11:07 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: jejb@linux.ibm.com,
	njavali@marvell.com,
	martin.petersen@oracle.com,
	mrangankar@marvell.com
Cc: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] scsi: qla4xxx: Clean up errors in ql4_def.h
Date: Thu, 11 Jan 2024 11:11:06 +0000
Message-Id: <20240111111106.15200-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3H3fLzJ9lxzinAA--.14213S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr17trykAFW3JryDur1xXwb_yoW5uF4DpF
	WUtas8Wa1DtFnFgFWkKrs8Crn3KFn2qa4UKas2gw48tFn0y3y0yryruFyY9FyfJw1kXF1f
	JF4kXFWrCw42grUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0FAJUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGA9ixWVLZWp60gAAs5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/scsi/qla4xxx/ql4_def.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_def.h b/drivers/scsi/qla4xxx/ql4_def.h
index 5e683ba49fa5..af466834dc3b 100644
--- a/drivers/scsi/qla4xxx/ql4_def.h
+++ b/drivers/scsi/qla4xxx/ql4_def.h
@@ -918,54 +918,54 @@ static inline int adapter_up(struct scsi_qla_host *ha)
 	       (!test_bit(AF_LOOPBACK, &ha->flags));
 }
 
-static inline struct scsi_qla_host* to_qla_host(struct Scsi_Host *shost)
+static inline struct scsi_qla_host *to_qla_host(struct Scsi_Host *shost)
 {
 	return (struct scsi_qla_host *)iscsi_host_priv(shost);
 }
 
-static inline void __iomem* isp_semaphore(struct scsi_qla_host *ha)
+static inline void __iomem *isp_semaphore(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u1.isp4010.nvram :
 		&ha->reg->u1.isp4022.semaphore);
 }
 
-static inline void __iomem* isp_nvram(struct scsi_qla_host *ha)
+static inline void __iomem *isp_nvram(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u1.isp4010.nvram :
 		&ha->reg->u1.isp4022.nvram);
 }
 
-static inline void __iomem* isp_ext_hw_conf(struct scsi_qla_host *ha)
+static inline void __iomem *isp_ext_hw_conf(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u2.isp4010.ext_hw_conf :
 		&ha->reg->u2.isp4022.p0.ext_hw_conf);
 }
 
-static inline void __iomem* isp_port_status(struct scsi_qla_host *ha)
+static inline void __iomem *isp_port_status(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u2.isp4010.port_status :
 		&ha->reg->u2.isp4022.p0.port_status);
 }
 
-static inline void __iomem* isp_port_ctrl(struct scsi_qla_host *ha)
+static inline void __iomem *isp_port_ctrl(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u2.isp4010.port_ctrl :
 		&ha->reg->u2.isp4022.p0.port_ctrl);
 }
 
-static inline void __iomem* isp_port_error_status(struct scsi_qla_host *ha)
+static inline void __iomem *isp_port_error_status(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u2.isp4010.port_err_status :
 		&ha->reg->u2.isp4022.p0.port_err_status);
 }
 
-static inline void __iomem * isp_gp_out(struct scsi_qla_host *ha)
+static inline void __iomem *isp_gp_out(struct scsi_qla_host *ha)
 {
 	return (is_qla4010(ha) ?
 		&ha->reg->u2.isp4010.gp_out :
@@ -979,9 +979,9 @@ static inline int eeprom_ext_hw_conf_offset(struct scsi_qla_host *ha)
 		offsetof(struct eeprom_data, isp4022.ext_hw_conf) / 2);
 }
 
-int ql4xxx_sem_spinlock(struct scsi_qla_host * ha, u32 sem_mask, u32 sem_bits);
-void ql4xxx_sem_unlock(struct scsi_qla_host * ha, u32 sem_mask);
-int ql4xxx_sem_lock(struct scsi_qla_host * ha, u32 sem_mask, u32 sem_bits);
+int ql4xxx_sem_spinlock(struct scsi_qla_host *ha, u32 sem_mask, u32 sem_bits);
+void ql4xxx_sem_unlock(struct scsi_qla_host *ha, u32 sem_mask);
+int ql4xxx_sem_lock(struct scsi_qla_host *ha, u32 sem_mask, u32 sem_bits);
 
 static inline int ql4xxx_lock_flash(struct scsi_qla_host *a)
 {
-- 
2.17.1


