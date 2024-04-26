Return-Path: <linux-kernel+bounces-159913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08C8B361A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8AF283F20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E24142E62;
	Fri, 26 Apr 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TPRvOUW6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3B144D07
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128905; cv=none; b=mPCQGhfFtI748Ww+ajDHUruk/Ab4pPXEx7nE0wa+bN/2vkIKH7trRWwu1Tdsoyk/3Z+nj7gf6UPtVSCjzNQDp9RNG4Z72DAo+6IwBo/JPtHU921YBuX/Hawectx6UIimFqkz8PpkKULEmR+5siYPtscjzYGkUHexWAVcgIZjirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128905; c=relaxed/simple;
	bh=c01xENU2uU+1k8vBYQTp+pPm8N+7PwSKwK5ub++9aFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/2A+bBqwtbx0iaKYizt3QohEXQbloEi015r7xE2JOXoXansrxVWZKSq84mdBE77IETUqwpvcwFtSh+5Gz5/xpiyFqhku6/4NR6+ZwPs0Eup3EEFdzGzUhALYrUWrtZxVvGbysa2rY+OGmzkDQyospQELgk2h0P/QF+XHyZ/mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TPRvOUW6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e50a04c317so11197485ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1714128902; x=1714733702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIPvjsINSBR4+GnLojAQen1sOb37N5r1du95uHFm3zU=;
        b=TPRvOUW6zaZj/HMYFFsg/xKR8+/k7m2N17IfqmhTRLgfWOzUEGeB+B0/oeO6M0A0Bx
         Q7wD11H5ZRS4LvyRM4YzcfmWzsqS50w5Aw9pmVp1Xx9mE2x512auxvuOz+OzAdXRPmOg
         4m+vwfABbMwAziT7DR5tQzI39Mc5KjdLLVMEKvm7BvN6X/PhiwEzakuTX/repF6phi1H
         9XBMSn/xzE+n8lmTUff7d8XAOh0Ow1OBI4Udnf24+351OYUFmBOXRiN8f2elxK+5gLAq
         /ou8UBT352OQQxzUSV78vt9tybP52+C8iDkZYrtRa7L8jjlBwUN0rquGwSkoWG3JDPwH
         r4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128902; x=1714733702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIPvjsINSBR4+GnLojAQen1sOb37N5r1du95uHFm3zU=;
        b=d78+130naP5UVJYBUnJGoJ03+tXS6s2gBzaYW14HELG73uPmgYSOX7opHpx67CSLHg
         dyAqp7pF5ttdTECyFpkhyzkSF1PZglPhnbxbExDuGp/dIx3u28K4QzCZhMm1A/Ojfxmv
         RHzs+ujXBouLQXbep/WyYP2OVsNJG2cE/IEHfGmazfa6PwyJ73DeBq5OoTXVzi0TlU/2
         C4Oq5nahLfGHJpNG4fC1VbebER7CeIkyGkJzYQQQkcEghI78ExPLha1Kq0KyLXXb7/83
         IFUmgEKQtS+rTwmMEclC+JXYlf7gfzC9FNiL3v/Qoo1yuYYT3jzs7wU/Ea2h5OUcKOoz
         tQvA==
X-Forwarded-Encrypted: i=1; AJvYcCUS2zV8SoqapjaB6bFUTOLIVkNzd+D4dao9NUcACyIphepCFisbrMfdmlP2jlc+NQE7oGaNbwdhcnlxKbbzAMZ/0rvkiMY8K6hSzlpt
X-Gm-Message-State: AOJu0YwyzwA22dlCGTC0JhKBYxn/E7A2YL36274MG3XhIMEV691cGRU1
	bS17d9hJTa1VFl3iKRM3NIbf/kE947mvRq9x5NOAkHkpPK+fGLWa0UvHKKsgtZA=
X-Google-Smtp-Source: AGHT+IF75xEpmSgYV7C2NBI+XZY3exPaVuwD2x0nM4G8d6CqOcWQfIgC9jOmgAt2AmQDdycZnmW26g==
X-Received: by 2002:a17:902:d883:b0:1e6:3577:1912 with SMTP id b3-20020a170902d88300b001e635771912mr2454417plz.25.1714128902468;
        Fri, 26 Apr 2024 03:55:02 -0700 (PDT)
Received: from C02FRH0UMD6M.cn.corp.seagroup.com (static-ip-250-9-104-152.rev.dyxnet.com. [152.104.9.250])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm15178914plb.307.2024.04.26.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:55:01 -0700 (PDT)
From: kwb <wangbing.kuang@shopee.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: chunguang.xu@shopee.com,
	kwb <wangbing.kuang@shopee.com>
Subject: [PATCH] bug-fix: nvme connect deadlock, bug report: https://bugzilla.kernel.org/show_bug.cgi?id=218777
Date: Fri, 26 Apr 2024 18:54:51 +0800
Message-Id: <20240426105451.78935-1-wangbing.kuang@shopee.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/nvme/host/core.c    | 16 ++++++++--------
 drivers/nvme/host/fabrics.c | 12 ++++++------
 drivers/nvme/host/fabrics.h | 16 +++++++---------
 drivers/nvme/host/fc.c      |  4 ++--
 drivers/nvme/host/nvme.h    |  8 ++++----
 drivers/nvme/host/pci.c     |  6 +++---
 drivers/nvme/host/rdma.c    |  4 ++--
 drivers/nvme/host/tcp.c     |  4 ++--
 drivers/nvme/target/loop.c  |  4 ++--
 9 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6aaecf2ecf97..761bc44527a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2138,7 +2138,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
 	int ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, BLK_MQ_REQ_RESERVED)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
 		if ((csts & NVME_CSTS_RDY) == bit)
@@ -2171,7 +2171,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 
@@ -2187,7 +2187,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	unsigned dev_page_min;
 	int ret;
 
-	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap, BLK_MQ_REQ_RESERVED);
 	if (ret) {
 		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
 		return ret;
@@ -2210,7 +2210,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 	return nvme_wait_ready(ctrl, ctrl->cap, true);
@@ -2226,11 +2226,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, BLK_MQ_REQ_RESERVED)) == 0) {
 		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
 			break;
 
@@ -3070,7 +3070,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
+	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs, 0);
 	if (ret) {
 		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
 		return ret;
@@ -4331,7 +4331,7 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 
 	u32 csts;
 
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, 0))
 		return false;
 
 	if (csts == ~0)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567..5d18822edd0a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd;
 	union nvme_result res;
@@ -154,7 +154,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -188,7 +188,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd = { };
 	union nvme_result res;
@@ -200,7 +200,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd = { };
 	int ret;
@@ -245,7 +245,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 561c2abd3892..3f9ed5392e36 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,12 +18,10 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
+/* Reserved for connect */
+#define NVMF_IO_RESERVED_TAGS		1
+/* Reserved for connect and keep alive and reset/delete */
+#define NVMF_ADMIN_RESERVED_TAGS	3
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
@@ -179,9 +177,9 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	return true;
 }
 
-int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
-int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
-int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
+int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags);
+int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t falgs);
+int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..36834408caf0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_fc_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->tag_set.reserved_tags = NVMF_IO_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size =
@@ -3510,7 +3510,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->admin_tag_set.reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d94774cc52bc..b7577156ed80 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,9 +493,9 @@ struct nvme_ctrl_ops {
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_PCI_P2PDMA		(1 << 2)
-	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
-	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
-	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
+	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags);
+	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags);
+	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
@@ -566,7 +566,7 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
 		return -ENOTTY;
-	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65, BLK_MQ_REQ_RESERVED);
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d820131d39b2..b614273029fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2850,19 +2850,19 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags)
 {
 	writel(val, to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags)
 {
 	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a49061f2afce..20fedf17166b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -801,7 +801,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
@@ -814,7 +814,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2d81db71aaa1..df7acb44b20c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1667,7 +1667,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
@@ -1679,7 +1679,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 2553f487c9f2..9a591ab4c810 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -353,7 +353,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->admin_tag_set.reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
@@ -527,7 +527,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_loop_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->tag_set.reserved_tags = NVMF_IO_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-- 
2.36.0


