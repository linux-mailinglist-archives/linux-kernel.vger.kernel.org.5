Return-Path: <linux-kernel+bounces-161287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2E8B4A22
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9FD1F21B44
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C044EB37;
	Sun, 28 Apr 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="YqMN88om"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA891DFE8
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714286094; cv=none; b=Qy0Yt8tShv9/9XscyHO2cQRE+Tju1DmIZfiYuoCjmnkuw31ksEHXfXBcR0/7Sn7+TMBAwNU34doh3R5/bZBEK7a6smZ4FWyTZ2oV5QDenn3Pi4IwFy0sPuWvsSIMVaxEZXuE9ZHzN3OgOkkQJPcUQr1gWLAu2jw9uoCJS2UwQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714286094; c=relaxed/simple;
	bh=HpIlPKW9LrbWJWPumsMVTs2rEeOYDrqINgQtcd2LQdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6A+AjthYk5sYlQwYcmvrPheP1xb7V458+AFNC7FhLfaqXb13x7NI/GZbbn9OsoHDIqsD1Im7pY34yDv8c8Z0iALzFbwilAHOXpPPP73p6MhhlBZhTwGlQr+x9mqXeLyGroqS0Om7HRokDa01dJEu+OegIeRgjUIZSvsTkhZc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=YqMN88om; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c84bb69c6fso1922612b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1714286091; x=1714890891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb/i4ywpXCUSCDXyZPQpmxyo3+vnXX4jvRs8tdQ+7Tk=;
        b=YqMN88om7UBGRSHdmBUWS1kn+yeKYIeOzm68OyOd1RfOM0tMo3Ql4VbBM23QR8+UPP
         1/hKpHkyNyPPHGnj1ScfFbpdqDwPHdrzr5lFad3z0u7LVZaoi5TLVpoBshZBZKwHeoXS
         QX+tC6aVAzKID6K44dfX8sZbSQzjXu75hpQYR+HLQ/Y52hYwSRkI/Qqel8nIl+ZfGHmA
         1o+ZwJIMds6Jez1Rs2vu2uUbk//uPIpO5p919hcdbs3sE0eNauZYbGQqiefUYnPiMYt4
         vgczvHnQ2uPXQBAfgyvdhHVFhgqRmlncAOGTbUXRIUlEZbhkDNerh2il3teM916qGD7c
         XIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714286091; x=1714890891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rb/i4ywpXCUSCDXyZPQpmxyo3+vnXX4jvRs8tdQ+7Tk=;
        b=Npq2icTR7RNKKa2aX4M1Bu4nwxo4jrz/N22cyl6JmFHaykw/ZYhzqR7S0NTCQcMO4t
         x8PX2gSs2tXmCE5LMApxdrfyOSfl9Z26VQWDdj+Am0mxR55txhAl+iO6RaeJ9O4iyx3k
         z7YH8rX2ALbJp8eDI0mRsP7pqbyGC8Zh0VEW9NkLxB7sRbbS2FYsNbfcLnl9e9CuTXrW
         sjNPUUO60VgN4QjfV1GqMP+rbaBMAxz3KWkf1/Y5gRjtXReoOTogp5XL7/R4jL8fQude
         d186CA/OiaRlxIuwMNf1pwqE8Mg2tYqKmZ7BfsXsfMXMXdEtQ30jmDJuM7CX223xjdXs
         X/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUAHXPn0T0kVt5xoG+kCzEGx5M4lqKNekz7CRIkrCsOj7ReC8qMt+qaLcMgbmjhPq3Al83zYdvQ9dd+1fARTyJ7tIVtUmSeUlP8J97+
X-Gm-Message-State: AOJu0YwvTymLG3IEqkS3TehlP2/jmwaqbcALR6gMF1PannfwU6gpr/we
	yv5cbl3XUGVBOcv3GN/PHW84eZrFdCE5MYEb1o/p4Jn3py3xWKU+nEc1fQnk2B40Jwn4vA44Nn4
	T
X-Google-Smtp-Source: AGHT+IELCTRAfn4Q3j5bkoEKsJmTJ0sElaOKbp2cdJoLDBMzu4CJ1I4mXsTIKkTvkDQkCbEZVskYhQ==
X-Received: by 2002:a05:6808:2a0d:b0:3c8:6957:fbae with SMTP id ez13-20020a0568082a0d00b003c86957fbaemr31832oib.17.1714286091039;
        Sat, 27 Apr 2024 23:34:51 -0700 (PDT)
Received: from C02FRH0UMD6M.cn.corp.seagroup.com ([143.92.118.30])
        by smtp.gmail.com with ESMTPSA id t3-20020a635343000000b005f077dce0f6sm17075109pgl.31.2024.04.27.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 23:34:50 -0700 (PDT)
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
Subject: [Bug Report] nvme connect deadlock in allocating tag
Date: Sun, 28 Apr 2024 14:31:48 +0800
Message-Id: <20240428063147.88058-1-wangbing.kuang@shopee.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
We found nvme connect will dealock when it cannot alloc tag in admin queue. So we reproduce it and find a way to work around. The solution is to utilize reserve tag for connecting.
Here is the deadlock environment:
1. the process [kworker/u129:1+nvme-wq] want to connect wait for geting tag, but tag is used up:
[<0>] blk_mq_get_tag+0x11d/0x2d0
[<0>] __blk_mq_alloc_request+0x92/0x180
[<0>] blk_mq_alloc_request+0x7c/0xc0
[<0>] nvme_alloc_request+0x28/0x100 [nvme_core]
[<0>] __nvme_submit_sync_cmd+0x1ea/0x230 [nvme_core]
[<0>] nvmf_reg_read64+0x62/0xa0 [nvme_fabrics]
[<0>] nvme_enable_ctrl+0x25/0xb0 [nvme_core]
[<0>] nvme_tcp_setup_ctrl+0x257/0x340 [nvme_tcp]
[<0>] nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
[<0>] process_one_work+0x228/0x3d0
[<0>] worker_thread+0x4d/0x3f0
[<0>] kthread+0x127/0x150
[<0>] ret_from_fork+0x1f/0x30
2. many processes (here is nvme list) is waiting for connecting:
[<0>] blk_execute_rq+0x8d/0x110
[<0>] nvme_execute_passthru_rq+0x60/0x1f0 [nvme_core]
[<0>] nvme_submit_user_cmd+0x23e/0x400 [nvme_core]
[<0>] nvme_user_cmd+0x163/0x1d0 [nvme_core]
[<0>] nvme_ctrl_ioctl+0x2e/0x40 [nvme_core]
[<0>] __nvme_ioctl+0x78/0xc0 [nvme_core]
[<0>] nvme_ioctl+0x1e/0x20 [nvme_core]
[<0>] blkdev_ioctl+0x126/0x260
[<0>] block_ioctl+0x4a/0x60
[<0>] __x64_sys_ioctl+0x91/0xc0
[<0>] do_syscall_64+0x59/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Reproduce method is very eazy:
1. call many nvme list
2. make nvme io timeout to recover connection
3. trick is to make reconnect-delay much time, eg:30s

The solution is the appending patch. it is tested and also consider keepalive and reset/showdown tag reserve.

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


