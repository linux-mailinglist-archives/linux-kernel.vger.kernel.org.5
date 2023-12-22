Return-Path: <linux-kernel+bounces-9351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB45381C472
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8321C217D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB417993;
	Fri, 22 Dec 2023 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z33UOvCc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D2611B;
	Fri, 22 Dec 2023 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb6921f0a08511eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FGGBhLJxG1Ho0gI1AKPJGa4uRjQTrf2xMUqPLUwAVHM=;
	b=Z33UOvCc40xcJpDlpCv8ylYTnUrLrog9Y2dFi6UBPKmneuKSKUdkzEiWhJ7t1KEx3wXaclBEVpf+xL2ZjfrzL52R8r//a38+kIUrDLVrnvcC1Jv8XU21dHWGkTz6rGmm1uekb+EfOU7KJQJljMIvGs6wPqwTSjj7uYWWk8syqxg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e229feff-2e32-47f8-bd86-d3c7f9cf7efa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:191a5e2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 2,OSH|NGT
X-CID-BAS: 2,OSH|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eb6921f0a08511eea5db2bebc7c28f94-20231222
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 380436549; Fri, 22 Dec 2023 12:52:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 12:52:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 12:52:32 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>, Johnson Wang
	<johnson.wang@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Date: Fri, 22 Dec 2023 12:52:27 +0800
Message-ID: <20231222045228.27826-9-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

To support secure video path feature, GCE have to read/write registgers
in the secure world. GCE will enable the secure access permission to the
HW who wants to access the secure content buffer.

Add CMDQ secure mailbox driver to make CMDQ client user is able to
sending their HW settings to the secure world. So that GCE can execute
all instructions to configure HW in the secure world.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/Makefile                      |    2 +-
 drivers/mailbox/mtk-cmdq-sec-mailbox.c        | 1091 +++++++++++++++++
 drivers/mailbox/mtk-cmdq-sec-tee.c            |  165 +++
 include/linux/mailbox/mtk-cmdq-mailbox.h      |    2 +
 .../linux/mailbox/mtk-cmdq-sec-iwc-common.h   |  385 ++++++
 include/linux/mailbox/mtk-cmdq-sec-mailbox.h  |  158 +++
 include/linux/mailbox/mtk-cmdq-sec-tee.h      |  105 ++
 7 files changed, 1907 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mailbox/mtk-cmdq-sec-mailbox.c
 create mode 100644 drivers/mailbox/mtk-cmdq-sec-tee.c
 create mode 100644 include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-sec-mailbox.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-sec-tee.h

diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..82da2f4ee81a 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -51,7 +51,7 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 
 obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
 
-obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
+obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o mtk-cmdq-sec-mailbox.o mtk-cmdq-sec-tee.o
 
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
 
diff --git a/drivers/mailbox/mtk-cmdq-sec-mailbox.c b/drivers/mailbox/mtk-cmdq-sec-mailbox.c
new file mode 100644
index 000000000000..c08d42bcc06f
--- /dev/null
+++ b/drivers/mailbox/mtk-cmdq-sec-mailbox.c
@@ -0,0 +1,1091 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/mailbox_controller.h>
+#include <linux/of_platform.h>
+#include <linux/sched/clock.h>
+#include <linux/timer.h>
+
+#include <linux/mailbox/mtk-cmdq-sec-mailbox.h>
+
+#define CMDQ_THR_EXEC_CNT_PA		(0x28)
+
+#define CMDQ_TIMEOUT_DEFAULT		(1000)
+#define CMDQ_NO_TIMEOUT			(0xffffffff)
+#define ADDR_METADATA_MAX_COUNT_ORIGIN	(8)
+
+struct cmdq_sec_task {
+	struct cmdq_task		task;
+
+	/* secure CMDQ */
+	bool				reset_exec;
+	u32				wait_cookie;
+	u64				engine_flag;
+	s32				scenario;
+	u64				trigger;
+	u64				exec_time;
+	struct work_struct		exec_work;
+};
+
+struct cmdq_sec_thread {
+	struct cmdq_thread		thread;
+
+	/* secure CMDQ */
+	u32				idx;
+	struct timer_list		timeout;
+	u32				timeout_ms;
+	struct work_struct		timeout_work;
+	u32				wait_cookie;
+	u32				next_cookie;
+	u32				task_cnt;
+	struct workqueue_struct		*task_exec_wq;
+};
+
+/**
+ * struct cmdq_sec_context - CMDQ secure context structure.
+ * @tgid: tgid of process context.
+ * @state: state of inter-world communicatiom.
+ * @iwc_msg: buffer for inter-world communicatiom message.
+ * @tee_ctx: context structure for tee vendor.
+ *
+ * Note it is not global data, each process has its own cmdq_sec_context.
+ */
+struct cmdq_sec_context {
+	u32				tgid;
+	enum cmdq_iwc_state_enum	state;
+	void				*iwc_msg;
+	struct cmdq_sec_tee_context	tee_ctx;
+};
+
+/**
+ * struct cmdq_sec_shared_mem - shared memory between normal and secure world
+ * @va: virtual address of share memory.
+ * @pa: physical address of share memory.
+ * @size: size of share memory.
+ *
+ */
+struct cmdq_sec_shared_mem {
+	void				*va;
+	dma_addr_t			pa;
+	u32				size;
+};
+
+struct cmdq_sec {
+	struct mbox_controller		mbox;
+	const struct gce_sec_plat	*pdata;
+	void __iomem			*base;
+	phys_addr_t			base_pa;
+	struct cmdq_sec_thread		*sec_thread;
+	struct cmdq_client		*clt;
+	struct cmdq_pkt			*clt_pkt;
+
+	atomic_t			path_res;
+	struct cmdq_sec_shared_mem	*shared_mem;
+	struct cmdq_sec_context		*context;
+	struct iwc_cmdq_cancel_task_t	cancel;
+
+	struct workqueue_struct		*timeout_wq;
+	u64				sec_invoke;
+	u64				sec_done;
+
+	bool				notify_run;
+	struct work_struct		irq_notify_work;
+	struct workqueue_struct		*notify_wq;
+	/* mutex for cmdq_sec_thread excuting cmdq_sec_task */
+	struct mutex			exec_lock;
+};
+
+static atomic_t cmdq_path_res = ATOMIC_INIT(0);
+
+static int cmdq_sec_task_submit(struct cmdq_sec *cmdq, struct cmdq_sec_task *sec_task,
+				const u32 iwc_cmd, const u32 thrd_idx, void *data);
+
+int cmdq_sec_insert_backup_cookie(struct cmdq_pkt *pkt)
+{
+	struct cmdq_client *cl = (struct cmdq_client *)pkt->cl;
+	struct cmdq_thread *thread = ((struct mbox_chan *)(cl->chan))->con_priv;
+	struct cmdq_sec_thread *sec_thread = container_of(thread, struct cmdq_sec_thread, thread);
+	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
+	struct cmdq_operand left, right;
+	dma_addr_t addr;
+
+	if (!cmdq->shared_mem)
+		return -EFAULT;
+
+	dev_dbg(cmdq->mbox.dev, "%s %d: pkt:%p thread:%u gce:%#lx",
+		__func__, __LINE__, pkt, sec_thread->idx, (unsigned long)cmdq->base_pa);
+
+	addr = (u32)(cmdq->base_pa + CMDQ_THR_BASE +
+		CMDQ_THR_SIZE * sec_thread->idx + CMDQ_THR_EXEC_CNT_PA);
+
+	cmdq_pkt_assign(pkt, CMDQ_THR_SPR_IDX1, CMDQ_ADDR_HIGH(addr));
+	cmdq_pkt_read_s(pkt, CMDQ_THR_SPR_IDX1, CMDQ_ADDR_LOW(addr), CMDQ_THR_SPR_IDX1);
+
+	left.reg = true;
+	left.idx = CMDQ_THR_SPR_IDX1;
+	right.reg = false;
+	right.value = 1;
+	cmdq_pkt_logic_command(pkt, CMDQ_THR_SPR_IDX1, &left, CMDQ_LOGIC_ADD, &right);
+
+	addr = cmdq->shared_mem->pa + CMDQ_SEC_SHARED_THR_CNT_OFFSET +
+		sec_thread->idx * sizeof(u32);
+
+	cmdq_pkt_assign(pkt, CMDQ_THR_SPR_IDX2, CMDQ_ADDR_HIGH(addr));
+	cmdq_pkt_write_s(pkt, CMDQ_THR_SPR_IDX2, CMDQ_ADDR_LOW(addr), CMDQ_THR_SPR_IDX1);
+	cmdq_pkt_set_event(pkt, cmdq->pdata->cmdq_event);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_insert_backup_cookie);
+
+static int cmdq_sec_realloc_addr_list(struct cmdq_pkt *pkt, const u32 count)
+{
+	struct cmdq_sec_data *sec_data = (struct cmdq_sec_data *)pkt->sec_data;
+	void *prev = (void *)(unsigned long)sec_data->addr_metadatas, *curr;
+
+	if (count <= sec_data->addr_metadata_max_cnt)
+		return 0;
+
+	curr = kcalloc(count, sizeof(*sec_data), GFP_KERNEL);
+	if (!curr)
+		return -ENOMEM;
+
+	if (count && sec_data->addr_metadatas)
+		memcpy(curr, prev, sizeof(*sec_data) * sec_data->addr_metadata_max_cnt);
+
+	kfree(prev);
+
+	sec_data->addr_metadatas = (uintptr_t)curr;
+	sec_data->addr_metadata_max_cnt = count;
+	return 0;
+}
+
+void cmdq_sec_pkt_free_sec_data(struct cmdq_pkt *pkt)
+{
+	kfree(pkt->sec_data);
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_pkt_free_sec_data);
+
+int cmdq_sec_pkt_alloc_sec_data(struct cmdq_pkt *pkt)
+{
+	struct cmdq_sec_data *sec_data;
+
+	if (pkt->sec_data)
+		return 0;
+
+	sec_data = kzalloc(sizeof(*sec_data), GFP_KERNEL);
+	if (!sec_data)
+		return -ENOMEM;
+
+	pkt->sec_data = (void *)sec_data;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_pkt_alloc_sec_data);
+
+static int cmdq_sec_append_metadata(struct cmdq_pkt *pkt,
+				    const enum cmdq_iwc_addr_metadata_type type,
+				    const u64 base, const u32 offset, const u32 size,
+				    const u32 port)
+{
+	struct cmdq_sec_data *sec_data;
+	struct iwc_cmdq_addr_metadata_t *meta;
+	int idx, max, ret;
+
+	pr_debug("[%s %d] pkt:%p type:%u base:%#llx offset:%#x size:%#x port:%#x",
+		 __func__, __LINE__, pkt, type, base, offset, size, port);
+
+	ret = cmdq_sec_pkt_alloc_sec_data(pkt);
+	if (ret < 0)
+		return ret;
+
+	sec_data = (struct cmdq_sec_data *)pkt->sec_data;
+	idx = sec_data->addr_metadata_cnt;
+	if (idx >= CMDQ_IWC_MAX_ADDR_LIST_LENGTH) {
+		pr_err("idx:%u reach over:%u", idx, CMDQ_IWC_MAX_ADDR_LIST_LENGTH);
+		return -EFAULT;
+	}
+
+	if (!sec_data->addr_metadata_max_cnt)
+		max = ADDR_METADATA_MAX_COUNT_ORIGIN;
+	else if (idx >= sec_data->addr_metadata_max_cnt)
+		max = sec_data->addr_metadata_max_cnt * 2;
+	else
+		max = sec_data->addr_metadata_max_cnt;
+
+	ret = cmdq_sec_realloc_addr_list(pkt, max);
+	if (ret)
+		return ret;
+
+	if (!sec_data->addr_metadatas) {
+		pr_info("addrMetadatas is missing");
+
+		meta = kzalloc(sizeof(*meta), GFP_KERNEL);
+		if (!meta)
+			return -ENOMEM;
+
+		sec_data->addr_metadatas = (uintptr_t)(void *)meta;
+	}
+	meta = (struct iwc_cmdq_addr_metadata_t *)(uintptr_t)sec_data->addr_metadatas;
+
+	meta[idx].instr_idx = pkt->cmd_buf_size / CMDQ_INST_SIZE - 1;
+	meta[idx].type = type;
+	meta[idx].base_handle = base;
+	meta[idx].offset = offset;
+	meta[idx].size = size;
+	meta[idx].port = port;
+	sec_data->addr_metadata_cnt += 1;
+	return 0;
+}
+
+int cmdq_sec_pkt_set_data(struct cmdq_pkt *pkt, const u64 dapc_engine,
+			  const u64 port_sec_engine, const enum cmdq_sec_scenario scenario)
+{
+	struct cmdq_sec_data *sec_data;
+	int ret;
+
+	if (!pkt) {
+		pr_err("invalid pkt:%p", pkt);
+		return -EINVAL;
+	}
+
+	ret = cmdq_sec_pkt_alloc_sec_data(pkt);
+	if (ret < 0)
+		return ret;
+
+	pr_debug("[%s %d] pkt:%p sec_data:%p dapc:%llu port_sec:%llu scen:%u",
+		 __func__, __LINE__, pkt, pkt->sec_data, dapc_engine, port_sec_engine, scenario);
+
+	sec_data = (struct cmdq_sec_data *)pkt->sec_data;
+	sec_data->engs_need_dapc |= dapc_engine;
+	sec_data->engs_need_sec_port |= port_sec_engine;
+	sec_data->scenario = scenario;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_pkt_set_data);
+
+int cmdq_sec_pkt_write(struct cmdq_pkt *pkt, u32 addr, u64 base,
+		       const enum cmdq_iwc_addr_metadata_type type,
+		       const u32 offset, const u32 size, const u32 port)
+{
+	int ret;
+
+	ret = cmdq_pkt_assign(pkt, CMDQ_THR_SPR_IDX0, addr);
+	if (ret)
+		return ret;
+
+	ret = cmdq_pkt_write_s_reg_value(pkt, CMDQ_THR_SPR_IDX0, (u32)base);
+	if (ret)
+		return ret;
+
+	return cmdq_sec_append_metadata(pkt, type, base, offset, size, port);
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_pkt_write);
+
+static u32 cmdq_sec_get_cookie(struct cmdq_sec *cmdq, u32 idx)
+{
+	return *(u32 *)(cmdq->shared_mem->va +
+		CMDQ_SEC_SHARED_THR_CNT_OFFSET + idx * sizeof(u32));
+}
+
+static void cmdq_sec_task_done(struct cmdq_sec_task *sec_task, int sta)
+{
+	struct cmdq_cb_data data;
+
+	data.sta = sta;
+	data.pkt = sec_task->task.pkt;
+
+	pr_debug("%s sec_task:%p pkt:%p err:%d",
+		 __func__, sec_task, sec_task->task.pkt, sta);
+
+	mbox_chan_received_data(sec_task->task.thread->chan, &data);
+
+	list_del_init(&sec_task->task.list_entry);
+	kfree(sec_task);
+}
+
+static bool cmdq_sec_irq_handler(struct cmdq_sec_thread *sec_thread,
+				 const u32 cookie, const int err)
+{
+	struct cmdq_sec_task *sec_task;
+	struct cmdq_task *task, *temp, *cur_task = NULL;
+	struct cmdq_sec *cmdq = container_of(sec_thread->thread.chan->mbox, struct cmdq_sec, mbox);
+	unsigned long flags;
+	int done;
+
+	spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
+	if (sec_thread->wait_cookie <= cookie)
+		done = cookie - sec_thread->wait_cookie + 1;
+	else if (sec_thread->wait_cookie == (cookie + 1) % CMDQ_MAX_COOKIE_VALUE)
+		done = 0;
+	else
+		done = CMDQ_MAX_COOKIE_VALUE - sec_thread->wait_cookie + 1 + cookie + 1;
+
+	list_for_each_entry_safe(task, temp, &sec_thread->thread.task_busy_list, list_entry) {
+		if (!done)
+			break;
+
+		sec_task = container_of(task, struct cmdq_sec_task, task);
+		cmdq_sec_task_done(sec_task, err);
+
+		if (sec_thread->task_cnt)
+			sec_thread->task_cnt -= 1;
+
+		done--;
+	}
+
+	cur_task = list_first_entry_or_null(&sec_thread->thread.task_busy_list,
+					    struct cmdq_task, list_entry);
+	if (err && cur_task) {
+		spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+
+		sec_task = container_of(cur_task, struct cmdq_sec_task, task);
+
+		/* for error task, cancel, callback and done */
+		memset(&cmdq->cancel, 0, sizeof(cmdq->cancel));
+		cmdq_sec_task_submit(cmdq, sec_task, CMD_CMDQ_IWC_CANCEL_TASK,
+				     sec_thread->idx, &cmdq->cancel);
+
+		cmdq_sec_task_done(sec_task, err);
+
+		spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
+
+		task = list_first_entry_or_null(&sec_thread->thread.task_busy_list,
+						struct cmdq_task, list_entry);
+		if (cur_task == task)
+			cmdq_sec_task_done(sec_task, err);
+		else
+			dev_err(cmdq->mbox.dev, "task list changed");
+
+		/*
+		 * error case stop all task for secure,
+		 * since secure tdrv always remove all when cancel
+		 */
+		while (!list_empty(&sec_thread->thread.task_busy_list)) {
+			cur_task = list_first_entry(&sec_thread->thread.task_busy_list,
+						    struct cmdq_task, list_entry);
+
+			sec_task = container_of(cur_task, struct cmdq_sec_task, task);
+			cmdq_sec_task_done(sec_task, -ECONNABORTED);
+		}
+	} else if (err) {
+		dev_dbg(cmdq->mbox.dev, "error but all task done, check notify callback");
+	}
+
+	if (list_empty(&sec_thread->thread.task_busy_list)) {
+		sec_thread->wait_cookie = 0;
+		sec_thread->next_cookie = 0;
+		sec_thread->task_cnt = 0;
+		__raw_writel(0, (void __iomem *)cmdq->shared_mem->va +
+			     CMDQ_SEC_SHARED_THR_CNT_OFFSET +
+			     sec_thread->idx * sizeof(u32));
+		spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+		del_timer(&sec_thread->timeout);
+		return true;
+	}
+
+	sec_thread->wait_cookie = cookie % CMDQ_MAX_COOKIE_VALUE + 1;
+
+	mod_timer(&sec_thread->timeout, jiffies + msecs_to_jiffies(sec_thread->timeout_ms));
+	spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+
+	return false;
+}
+
+static void cmdq_sec_irq_notify_work(struct work_struct *work_item)
+{
+	struct cmdq_sec *cmdq = container_of(work_item, struct cmdq_sec, irq_notify_work);
+	int i;
+	u32 thread_max = cmdq->pdata->secure_thread_min + cmdq->pdata->secure_thread_nr;
+
+	mutex_lock(&cmdq->exec_lock);
+
+	for (i = cmdq->pdata->secure_thread_min; i <= thread_max; i++) {
+		struct cmdq_sec_thread *sec_thread = &cmdq->sec_thread[i];
+		u32 cookie = cmdq_sec_get_cookie(cmdq, sec_thread->idx);
+
+		if (cookie < sec_thread->wait_cookie || !sec_thread->task_cnt)
+			continue;
+
+		cmdq_sec_irq_handler(sec_thread, cookie, 0);
+	}
+
+	mutex_unlock(&cmdq->exec_lock);
+}
+
+static void cmdq_sec_irq_notify_callback(struct mbox_client *cl, void *mssg)
+{
+	struct cmdq_cb_data *data = (struct cmdq_cb_data *)mssg;
+	struct cmdq_sec *cmdq = container_of(((struct cmdq_client *)data->pkt->cl)->chan->mbox,
+					     struct cmdq_sec, mbox);
+
+	if (work_pending(&cmdq->irq_notify_work)) {
+		dev_dbg(cmdq->mbox.dev, "%s last notify callback working", __func__);
+		return;
+	}
+
+	queue_work(cmdq->notify_wq, &cmdq->irq_notify_work);
+}
+
+static int cmdq_sec_irq_notify_start(struct cmdq_sec *cmdq)
+{
+	int err;
+
+	if (cmdq->notify_run)
+		return 0;
+
+	if (!cmdq->clt_pkt) {
+		cmdq->clt = cmdq_mbox_create(cmdq->mbox.dev, 0);
+		if (!cmdq->clt || IS_ERR(cmdq->clt)) {
+			dev_err(cmdq->mbox.dev, "clt mbox_create failed clt:%p index:%d",
+				cmdq->clt, CMDQ_SEC_IRQ_THREAD);
+			return -EINVAL;
+		}
+		cmdq->clt->client.rx_callback = cmdq_sec_irq_notify_callback;
+
+		cmdq->clt_pkt = cmdq_pkt_create(cmdq->clt, PAGE_SIZE);
+		if (!cmdq->clt_pkt || IS_ERR(cmdq->clt_pkt)) {
+			dev_err(cmdq->mbox.dev, "clt_pkt cmdq_pkt_create failed pkt:%p index:%d",
+				cmdq->clt_pkt, CMDQ_SEC_IRQ_THREAD);
+			return -EINVAL;
+		}
+
+		INIT_WORK(&cmdq->irq_notify_work, cmdq_sec_irq_notify_work);
+	}
+
+	cmdq_pkt_wfe(cmdq->clt_pkt, cmdq->pdata->cmdq_event, true);
+	cmdq_pkt_finalize_loop(cmdq->clt_pkt);
+	dma_sync_single_for_device(cmdq->mbox.dev,
+				   cmdq->clt_pkt->pa_base,
+				   cmdq->clt_pkt->cmd_buf_size,
+				   DMA_TO_DEVICE);
+	err = mbox_send_message(cmdq->clt->chan, cmdq->clt_pkt);
+	mbox_client_txdone(cmdq->clt->chan, 0);
+	if (err < 0) {
+		dev_err(cmdq->mbox.dev, "%s failed:%d", __func__, err);
+
+		cmdq_sec_pkt_free_sec_data(cmdq->clt_pkt);
+		cmdq_pkt_destroy(cmdq->clt_pkt);
+		cmdq_mbox_destroy(cmdq->clt);
+
+		return err;
+	}
+
+	cmdq->notify_run = true;
+	dev_dbg(cmdq->mbox.dev, "%s success!", __func__);
+
+	return 0;
+}
+
+static int cmdq_sec_session_init(struct cmdq_sec_context *context)
+{
+	int err = 0;
+
+	if (context->state >= IWC_SES_OPENED) {
+		pr_debug("session opened:%u", context->state);
+		return 0;
+	}
+
+	switch (context->state) {
+	case IWC_INIT:
+		err = cmdq_sec_init_context(&context->tee_ctx);
+		if (err)
+			return err;
+		context->state = IWC_CONTEXT_INITED;
+	fallthrough;
+	case IWC_CONTEXT_INITED:
+		if (context->iwc_msg) {
+			pr_err("iwcMessage not NULL:%p", context->iwc_msg);
+			return -EINVAL;
+		}
+
+		err = cmdq_sec_allocate_wsm(&context->tee_ctx, &context->iwc_msg,
+					    sizeof(struct iwc_cmdq_message_t));
+		if (err)
+			return err;
+
+		context->state = IWC_WSM_ALLOCATED;
+	fallthrough;
+	case IWC_WSM_ALLOCATED:
+		err = cmdq_sec_open_session(&context->tee_ctx, context->iwc_msg);
+		if (err)
+			return err;
+
+		context->state = IWC_SES_OPENED;
+	fallthrough;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cmdq_sec_fill_iwc_msg(struct cmdq_sec_context *context,
+				 struct cmdq_sec_task *sec_task, u32 thrd_idx)
+{
+	struct iwc_cmdq_message_t *iwc_msg = NULL;
+	struct cmdq_sec_data *data = (struct cmdq_sec_data *)sec_task->task.pkt->sec_data;
+	u32 size = 0, offset = 0, *instr;
+
+	iwc_msg = (struct iwc_cmdq_message_t *)context->iwc_msg;
+
+	if (sec_task->task.pkt->cmd_buf_size + 4 * CMDQ_INST_SIZE > CMDQ_TZ_CMD_BLOCK_SIZE) {
+		pr_err("sec_task:%p size:%zu > %u",
+		       sec_task, sec_task->task.pkt->cmd_buf_size, CMDQ_TZ_CMD_BLOCK_SIZE);
+		return -EFAULT;
+	}
+
+	if (thrd_idx == CMDQ_INVALID_THREAD) {
+		iwc_msg->command.cmd_size = 0;
+		iwc_msg->command.metadata.addr_list_length = 0;
+		return -EINVAL;
+	}
+
+	iwc_msg->command.thread = thrd_idx;
+	iwc_msg->command.scenario = sec_task->scenario;
+	iwc_msg->command.eng_flag = sec_task->engine_flag;
+	size = sec_task->task.pkt->cmd_buf_size;
+	memcpy(iwc_msg->command.va_base + offset, sec_task->task.pkt->va_base, size);
+	iwc_msg->command.cmd_size += size;
+	offset += size / 4;
+
+	instr = &iwc_msg->command.va_base[iwc_msg->command.cmd_size / 4 - 4];
+	if ((u64)*instr == CMDQ_EOC_CMD)
+		instr[0] = 0;
+	else
+		pr_err("%s %d: find EOC failed: %#x %#x",
+		       __func__, __LINE__, instr[1], instr[0]);
+
+	iwc_msg->command.wait_cookie = sec_task->wait_cookie;
+	iwc_msg->command.reset_exec = sec_task->reset_exec;
+
+	if (data->addr_metadata_cnt) {
+		iwc_msg->command.metadata.addr_list_length = data->addr_metadata_cnt;
+		memcpy(iwc_msg->command.metadata.addr_list,
+		       (u32 *)(unsigned long)data->addr_metadatas,
+		       data->addr_metadata_cnt * sizeof(struct iwc_cmdq_addr_metadata_t));
+	}
+
+	iwc_msg->command.metadata.engs_need_dapc = data->engs_need_dapc;
+	iwc_msg->command.metadata.engs_need_sec_port = data->engs_need_sec_port;
+	iwc_msg->command.normal_task_handle = (unsigned long)sec_task->task.pkt;
+
+	return 0;
+}
+
+static int cmdq_sec_session_send(struct cmdq_sec_context *context,
+				 struct cmdq_sec_task *sec_task, const u32 iwc_cmd,
+				 const u32 thrd_idx, struct cmdq_sec *cmdq)
+{
+	int err = 0;
+	u64 cost;
+	struct iwc_cmdq_message_t *iwc_msg = NULL;
+
+	iwc_msg = (struct iwc_cmdq_message_t *)context->iwc_msg;
+
+	memset(iwc_msg, 0, sizeof(*iwc_msg));
+	iwc_msg->cmd = iwc_cmd;
+	iwc_msg->cmdq_id = cmdq->pdata->hwid;
+	iwc_msg->command.thread = thrd_idx;
+
+	switch (iwc_cmd) {
+	case CMD_CMDQ_IWC_SUBMIT_TASK:
+		err = cmdq_sec_fill_iwc_msg(context, sec_task, thrd_idx);
+		if (err)
+			return err;
+		break;
+	case CMD_CMDQ_IWC_CANCEL_TASK:
+		iwc_msg->cancel_task.wait_cookie = sec_task->wait_cookie;
+		iwc_msg->cancel_task.thread = thrd_idx;
+		break;
+	case CMD_CMDQ_IWC_PATH_RES_ALLOCATE:
+		if (!cmdq->shared_mem || !cmdq->shared_mem->va) {
+			dev_err(cmdq->mbox.dev, "%s %d: shared_mem is NULL", __func__, __LINE__);
+			return -EFAULT;
+		}
+		iwc_msg->path_resource.size = cmdq->shared_mem->size;
+		iwc_msg->path_resource.share_memoy_pa = cmdq->shared_mem->pa;
+		iwc_msg->path_resource.use_normal_irq = 1;
+		break;
+	default:
+		break;
+	}
+
+	cmdq->sec_invoke = sched_clock();
+	dev_dbg(cmdq->mbox.dev, "%s execute cmdq:%p sec_task:%p command:%u thread:%u cookie:%d",
+		__func__, cmdq, sec_task, iwc_cmd, thrd_idx,
+		sec_task ? sec_task->wait_cookie : -1);
+
+	/* send message */
+	err = cmdq_sec_execute_session(&context->tee_ctx, iwc_cmd, CMDQ_TIMEOUT_DEFAULT);
+
+	cmdq->sec_done = sched_clock();
+	cost = div_u64(cmdq->sec_done - cmdq->sec_invoke, 1000000);
+	if (cost >= CMDQ_TIMEOUT_DEFAULT)
+		dev_err(cmdq->mbox.dev, "%s execute timeout cmdq:%p sec_task:%p cost:%lluus",
+			__func__, cmdq, sec_task, cost);
+	else
+		dev_dbg(cmdq->mbox.dev, "%s execute done cmdq:%p sec_task:%p cost:%lluus",
+			__func__, cmdq, sec_task, cost);
+
+	if (err)
+		return err;
+
+	context->state = IWC_SES_ON_TRANSACTED;
+	return 0;
+}
+
+static int cmdq_sec_session_reply(const u32 iwc_cmd, struct iwc_cmdq_message_t *iwc_msg,
+				  void *data, struct cmdq_sec_task *sec_task)
+{
+	struct iwc_cmdq_cancel_task_t *cancel = data;
+	struct cmdq_sec_data *sec_data = sec_task->task.pkt->sec_data;
+
+	if (iwc_cmd == CMD_CMDQ_IWC_SUBMIT_TASK && iwc_msg->rsp < 0) {
+		/* submit fail case copy status */
+		memcpy(&sec_data->sec_status, &iwc_msg->sec_status,
+		       sizeof(sec_data->sec_status));
+		sec_data->response = iwc_msg->rsp;
+	} else if (iwc_cmd == CMD_CMDQ_IWC_CANCEL_TASK && cancel) {
+		/* cancel case only copy cancel result */
+		memcpy(cancel, &iwc_msg->cancel_task, sizeof(*cancel));
+	}
+
+	return iwc_msg->rsp;
+}
+
+static int cmdq_sec_task_submit(struct cmdq_sec *cmdq, struct cmdq_sec_task *sec_task,
+				const u32 iwc_cmd, const u32 thrd_idx, void *data)
+{
+	struct cmdq_sec_context *context;
+	int err = 0;
+
+	if (!cmdq->context) {
+		context = kzalloc(sizeof(*cmdq->context), GFP_ATOMIC);
+		if (!context)
+			return -ENOMEM;
+
+		cmdq->context = context;
+		cmdq->context->state = IWC_INIT;
+		cmdq->context->tgid = current->tgid;
+	}
+
+	if (cmdq->context->state == IWC_INIT)
+		cmdq_sec_setup_tee_context(&cmdq->context->tee_ctx);
+
+	err = cmdq_sec_session_init(cmdq->context);
+	if (err) {
+		dev_err(cmdq->mbox.dev, "%s %d: cmdq_sec_session_init fail: %d",
+			__func__, __LINE__, err);
+		return err;
+	}
+
+	err = cmdq_sec_irq_notify_start(cmdq);
+	if (err) {
+		dev_err(cmdq->mbox.dev, "%s %d: cmdq_sec_irq_notify_start fail: %d",
+			__func__, __LINE__, err);
+		return err;
+	}
+
+	err = cmdq_sec_session_send(cmdq->context, sec_task, iwc_cmd, thrd_idx, cmdq);
+	if (err) {
+		dev_err(cmdq->mbox.dev, "%s %d: iwc_cmd:%d err:%d sec_task:%p thread:%u gce:%#lx",
+			__func__, __LINE__, iwc_cmd, err,
+			sec_task, thrd_idx, (unsigned long)cmdq->base_pa);
+		return err;
+	}
+
+	err = cmdq_sec_session_reply(iwc_cmd, cmdq->context->iwc_msg, data, sec_task);
+	if (err) {
+		dev_err(cmdq->mbox.dev, "%s %d: cmdq_sec_session_reply fail: %d",
+			__func__, __LINE__, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int cmdq_sec_suspend(struct device *dev)
+{
+	struct cmdq_sec *cmdq = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(cmdq->pdata->gce_num, cmdq->pdata->clocks);
+	return 0;
+}
+
+static int cmdq_sec_resume(struct device *dev)
+{
+	struct cmdq_sec *cmdq = dev_get_drvdata(dev);
+
+	WARN_ON(clk_bulk_prepare_enable(cmdq->pdata->gce_num, cmdq->pdata->clocks));
+	return 0;
+}
+
+static const struct dev_pm_ops cmdq_sec_pm_ops = {
+	.suspend = cmdq_sec_suspend,
+	.resume = cmdq_sec_resume,
+};
+
+static void cmdq_sec_task_exec_work(struct work_struct *work_item)
+{
+	struct cmdq_sec_task *sec_task = container_of(work_item,
+						      struct cmdq_sec_task, exec_work);
+	struct cmdq_sec_thread *sec_thread = container_of(sec_task->task.thread,
+							 struct cmdq_sec_thread, thread);
+	struct cmdq_sec *cmdq = container_of(sec_thread->thread.chan->mbox,
+					     struct cmdq_sec, mbox);
+	struct cmdq_sec_data *data;
+	unsigned long flags;
+	int err;
+
+	dev_dbg(cmdq->mbox.dev, "%s gce:%#lx sec_task:%p pkt:%p thread:%u",
+		__func__, (unsigned long)cmdq->base_pa,
+		sec_task, sec_task->task.pkt, sec_thread->idx);
+
+	if (!sec_task->task.pkt->sec_data) {
+		dev_err(cmdq->mbox.dev, "pkt:%p without sec_data", sec_task->task.pkt);
+		return;
+	}
+	data = (struct cmdq_sec_data *)sec_task->task.pkt->sec_data;
+
+	mutex_lock(&cmdq->exec_lock);
+
+	spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
+	if (!sec_thread->task_cnt) {
+		mod_timer(&sec_thread->timeout, jiffies +
+			  msecs_to_jiffies(sec_thread->timeout_ms));
+		sec_thread->wait_cookie = 1;
+		sec_thread->next_cookie = 1;
+		sec_thread->task_cnt = 0;
+		__raw_writel(0, (void __iomem *)cmdq->shared_mem->va +
+			     CMDQ_SEC_SHARED_THR_CNT_OFFSET + sec_thread->idx * sizeof(u32));
+	}
+
+	sec_task->reset_exec = sec_thread->task_cnt ? false : true;
+	sec_task->wait_cookie = sec_thread->next_cookie;
+	sec_thread->next_cookie = (sec_thread->next_cookie + 1) % CMDQ_MAX_COOKIE_VALUE;
+	list_add_tail(&sec_task->task.list_entry, &sec_thread->thread.task_busy_list);
+	sec_thread->task_cnt += 1;
+	spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+	sec_task->trigger = sched_clock();
+
+	if (!atomic_cmpxchg(&cmdq_path_res, 0, 1)) {
+		err = cmdq_sec_task_submit(cmdq, NULL, CMD_CMDQ_IWC_PATH_RES_ALLOCATE,
+					   CMDQ_INVALID_THREAD, NULL);
+		if (err) {
+			atomic_set(&cmdq_path_res, 0);
+			goto task_end;
+		}
+	}
+
+	if (sec_thread->task_cnt > CMDQ_MAX_TASK_IN_SECURE_THREAD) {
+		dev_err(cmdq->mbox.dev, "task_cnt:%u cannot more than %u sec_task:%p thread:%u",
+			sec_thread->task_cnt, CMDQ_MAX_TASK_IN_SECURE_THREAD,
+			sec_task, sec_thread->idx);
+		err = -EMSGSIZE;
+		goto task_end;
+	}
+
+	err = cmdq_sec_task_submit(cmdq, sec_task, CMD_CMDQ_IWC_SUBMIT_TASK,
+				   sec_thread->idx, NULL);
+	if (err)
+		dev_err(cmdq->mbox.dev, "cmdq_sec_task_submit err:%d sec_task:%p thread:%u",
+			err, sec_task, sec_thread->idx);
+
+task_end:
+	if (err) {
+		struct cmdq_cb_data cb_data;
+
+		cb_data.sta = err;
+		cb_data.pkt = sec_task->task.pkt;
+		mbox_chan_received_data(sec_thread->thread.chan, &cb_data);
+
+		spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
+		if (!sec_thread->task_cnt)
+			dev_err(cmdq->mbox.dev, "thread:%u task_cnt:%u cannot below zero",
+				sec_thread->idx, sec_thread->task_cnt);
+		else
+			sec_thread->task_cnt -= 1;
+
+		sec_thread->next_cookie = (sec_thread->next_cookie - 1 +
+			CMDQ_MAX_COOKIE_VALUE) % CMDQ_MAX_COOKIE_VALUE;
+		list_del(&sec_task->task.list_entry);
+		dev_dbg(cmdq->mbox.dev, "gce:%#lx err:%d sec_task:%p pkt:%p",
+			(unsigned long)cmdq->base_pa, err, sec_task, sec_task->task.pkt);
+		dev_dbg(cmdq->mbox.dev, "thread:%u task_cnt:%u wait_cookie:%u next_cookie:%u",
+			sec_thread->idx, sec_thread->task_cnt,
+			sec_thread->wait_cookie, sec_thread->next_cookie);
+		spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+
+		kfree(sec_task);
+	}
+
+	mutex_unlock(&cmdq->exec_lock);
+}
+
+static int cmdq_sec_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data;
+	struct cmdq_sec_data *sec_data = (struct cmdq_sec_data *)pkt->sec_data;
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+	struct cmdq_sec_thread *sec_thread = container_of(thread, struct cmdq_sec_thread, thread);
+	struct cmdq_sec_task *sec_task;
+
+	if (!sec_data)
+		return -EINVAL;
+
+	sec_task = kzalloc(sizeof(*sec_task), GFP_ATOMIC);
+	if (!sec_task)
+		return -ENOMEM;
+
+	sec_task->task.pkt = pkt;
+	sec_task->task.thread = thread;
+	sec_task->scenario = sec_data->scenario;
+	sec_task->engine_flag = sec_data->engs_need_dapc | sec_data->engs_need_sec_port;
+
+	INIT_WORK(&sec_task->exec_work, cmdq_sec_task_exec_work);
+	queue_work(sec_thread->task_exec_wq, &sec_task->exec_work);
+	return 0;
+}
+
+static void cmdq_sec_thread_timeout(struct timer_list *t)
+{
+	struct cmdq_sec_thread *sec_thread = from_timer(sec_thread, t, timeout);
+	struct cmdq_sec *cmdq = container_of(sec_thread->thread.chan->mbox, struct cmdq_sec, mbox);
+
+	if (!work_pending(&sec_thread->timeout_work))
+		queue_work(cmdq->timeout_wq, &sec_thread->timeout_work);
+}
+
+static void cmdq_sec_task_timeout_work(struct work_struct *work_item)
+{
+	struct cmdq_sec_thread *sec_thread = container_of(work_item,
+							  struct cmdq_sec_thread, timeout_work);
+	struct cmdq_sec *cmdq = container_of(sec_thread->thread.chan->mbox,
+					     struct cmdq_sec, mbox);
+	struct cmdq_task *task;
+	struct cmdq_sec_task *sec_task;
+	unsigned long flags;
+	u64 duration;
+	u32 cookie;
+
+	mutex_lock(&cmdq->exec_lock);
+
+	spin_lock_irqsave(&sec_thread->thread.chan->lock, flags);
+	if (list_empty(&sec_thread->thread.task_busy_list)) {
+		dev_err(cmdq->mbox.dev, "thread:%u task_list is empty", sec_thread->idx);
+		spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+		goto done;
+	}
+
+	task = list_first_entry(&sec_thread->thread.task_busy_list,
+				struct cmdq_task, list_entry);
+	sec_task = container_of(task, struct cmdq_sec_task, task);
+	duration = div_u64(sched_clock() - sec_task->trigger, 1000000);
+	if (duration < sec_thread->timeout_ms) {
+		mod_timer(&sec_thread->timeout, jiffies +
+			  msecs_to_jiffies(sec_thread->timeout_ms - duration));
+		spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+		goto done;
+	}
+
+	cookie = cmdq_sec_get_cookie(cmdq, sec_thread->idx);
+	spin_unlock_irqrestore(&sec_thread->thread.chan->lock, flags);
+
+	dev_err(cmdq->mbox.dev, "%s duration:%llu cookie:%u thread:%u",
+		__func__, duration, cookie, sec_thread->idx);
+	cmdq_sec_irq_handler(sec_thread, cookie, -ETIMEDOUT);
+
+done:
+	mutex_unlock(&cmdq->exec_lock);
+}
+
+static int cmdq_sec_mbox_startup(struct mbox_chan *chan)
+{
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+	struct cmdq_sec_thread *sec_thread = container_of(thread,
+							  struct cmdq_sec_thread, thread);
+	char name[20];
+
+	timer_setup(&sec_thread->timeout, cmdq_sec_thread_timeout, 0);
+
+	INIT_WORK(&sec_thread->timeout_work, cmdq_sec_task_timeout_work);
+	snprintf(name, sizeof(name), "task_exec_wq_%u", sec_thread->idx);
+	sec_thread->task_exec_wq = create_singlethread_workqueue(name);
+	return 0;
+}
+
+static void cmdq_sec_mbox_shutdown(struct mbox_chan *chan)
+{
+}
+
+static int cmdq_sec_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
+{
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
+	int i;
+	u32 thread_max = cmdq->pdata->secure_thread_min + cmdq->pdata->secure_thread_nr;
+
+	mutex_lock(&cmdq->exec_lock);
+
+	if (list_empty(&thread->task_busy_list)) {
+		mutex_unlock(&cmdq->exec_lock);
+		return 0;
+	}
+
+	for (i = cmdq->pdata->secure_thread_min; i < thread_max; i++) {
+		struct cmdq_sec_thread *sec_thread = &cmdq->sec_thread[i];
+		u32 cookie = cmdq_sec_get_cookie(cmdq, sec_thread->idx);
+
+		if (cookie < sec_thread->wait_cookie || !sec_thread->task_cnt)
+			continue;
+
+		cmdq_sec_irq_handler(sec_thread, cookie, -ECONNABORTED);
+	}
+
+	mutex_unlock(&cmdq->exec_lock);
+	return 0;
+}
+
+static const struct mbox_chan_ops cmdq_sec_mbox_chan_ops = {
+	.send_data = cmdq_sec_mbox_send_data,
+	.startup = cmdq_sec_mbox_startup,
+	.shutdown = cmdq_sec_mbox_shutdown,
+	.flush = cmdq_sec_mbox_flush,
+};
+
+static struct mbox_chan *cmdq_sec_mbox_of_xlate(struct mbox_controller *mbox,
+						const struct of_phandle_args *sp)
+{
+	struct cmdq_thread *thread;
+	struct cmdq_sec_thread *sec_thread;
+	int idx = sp->args[0];
+
+	if (mbox->num_chans <= idx) {
+		pr_err("invalid thrd-idx:%u", idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	thread = (struct cmdq_thread *)mbox->chans[idx].con_priv;
+	thread->chan = &mbox->chans[idx];
+	thread->priority = sp->args[1];
+	sec_thread = container_of(thread, struct cmdq_sec_thread, thread);
+	sec_thread->timeout_ms = CMDQ_NO_TIMEOUT;
+
+	return &mbox->chans[idx];
+}
+
+static int cmdq_sec_probe(struct platform_device *pdev)
+{
+	int i, err;
+	struct cmdq_sec *cmdq;
+	struct device *dev = &pdev->dev;
+	struct device *gce_dev;
+	struct resource *res;
+
+	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
+	if (!cmdq)
+		return -ENOMEM;
+
+	cmdq->pdata = (struct gce_sec_plat *)pdev->dev.platform_data;
+	if (!cmdq->pdata) {
+		dev_err(dev, "no valid gce platform data!\n");
+		return -EINVAL;
+	}
+
+	gce_dev = cmdq->pdata->gce_dev;
+	cmdq->base = devm_platform_get_and_ioremap_resource(to_platform_device(gce_dev),
+							    0, &res);
+	if (IS_ERR(cmdq->base))
+		return PTR_ERR(cmdq->base);
+
+	cmdq->base_pa = res->start;
+
+	cmdq->mbox.dev = gce_dev;
+	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->pdata->thread_nr,
+					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
+	if (!cmdq->mbox.chans)
+		return -ENOMEM;
+
+	cmdq->mbox.ops = &cmdq_sec_mbox_chan_ops;
+	cmdq->mbox.num_chans = cmdq->pdata->thread_nr;
+	cmdq->mbox.of_xlate = cmdq_sec_mbox_of_xlate;
+
+	/* make use of TXDONE_BY_ACK */
+	cmdq->mbox.txdone_irq = false;
+	cmdq->mbox.txdone_poll = false;
+
+	cmdq->sec_thread = devm_kcalloc(dev, cmdq->pdata->thread_nr,
+					sizeof(*cmdq->sec_thread), GFP_KERNEL);
+	if (!cmdq->sec_thread)
+		return -ENOMEM;
+
+	mutex_init(&cmdq->exec_lock);
+	for (i = 0; i < cmdq->pdata->thread_nr; i++) {
+		cmdq->sec_thread[i].thread.base = cmdq->base + CMDQ_THR_BASE + CMDQ_THR_SIZE * i;
+		INIT_LIST_HEAD(&cmdq->sec_thread[i].thread.task_busy_list);
+		cmdq->sec_thread[i].idx = i;
+		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->sec_thread[i].thread;
+	}
+
+	cmdq->notify_wq = create_singlethread_workqueue("mtk_cmdq_sec_notify_wq");
+	cmdq->timeout_wq = create_singlethread_workqueue("mtk_cmdq_sec_timeout_wq");
+	err = devm_mbox_controller_register(dev, &cmdq->mbox);
+	if (err)
+		return err;
+
+	cmdq->shared_mem = devm_kzalloc(dev, sizeof(*cmdq->shared_mem), GFP_KERNEL);
+	if (!cmdq->shared_mem)
+		return -ENOMEM;
+
+	cmdq->shared_mem->va = dma_alloc_coherent(dev, PAGE_SIZE,
+						  &cmdq->shared_mem->pa, GFP_KERNEL);
+	cmdq->shared_mem->size = PAGE_SIZE;
+
+	platform_set_drvdata(pdev, cmdq);
+	WARN_ON(clk_bulk_prepare_enable(cmdq->pdata->gce_num, cmdq->pdata->clocks));
+
+	return 0;
+}
+
+static int cmdq_sec_remove(struct platform_device *pdev)
+{
+	struct cmdq_sec *cmdq = platform_get_drvdata(pdev);
+
+	if (cmdq->context)
+		cmdq_sec_free_wsm(&cmdq->context->tee_ctx, &cmdq->context->iwc_msg);
+
+	mbox_controller_unregister(&cmdq->mbox);
+
+	clk_bulk_disable_unprepare(cmdq->pdata->gce_num, cmdq->pdata->clocks);
+	return 0;
+}
+
+static struct platform_driver cmdq_sec_drv = {
+	.probe = cmdq_sec_probe,
+	.remove = cmdq_sec_remove,
+	.driver = {
+		.name = "mtk-cmdq-sec",
+		.pm = &cmdq_sec_pm_ops,
+	},
+};
+
+static int __init cmdq_sec_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&cmdq_sec_drv);
+	if (err)
+		pr_err("platform_driver_register failed:%d", err);
+	return err;
+}
+
+rootfs_initcall(cmdq_sec_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/mailbox/mtk-cmdq-sec-tee.c b/drivers/mailbox/mtk-cmdq-sec-tee.c
new file mode 100644
index 000000000000..e3f5ba6aaaaa
--- /dev/null
+++ b/drivers/mailbox/mtk-cmdq-sec-tee.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#include <linux/math64.h>
+#include <linux/sched/clock.h>
+
+#include <linux/mailbox/mtk-cmdq-sec-tee.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+/* lock to protect atomic secure task execution */
+static DEFINE_MUTEX(cmdq_sec_exec_lock);
+
+void cmdq_sec_setup_tee_context(struct cmdq_sec_tee_context *tee)
+{
+	/* 09010000 0000 0000 0000000000000000 */
+	memset(tee->uuid, 0, sizeof(tee->uuid));
+	tee->uuid[0] = 0x9;
+	tee->uuid[1] = 0x1;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_setup_tee_context);
+
+static int tee_dev_match(struct tee_ioctl_version_data *t, const void *v)
+{
+	if (t->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+
+	return 0;
+}
+
+int cmdq_sec_init_context(struct cmdq_sec_tee_context *tee)
+{
+	tee->tee_context = tee_client_open_context(NULL, tee_dev_match, NULL, NULL);
+	if (!tee->tee_context) {
+		pr_err("[%s][%d] tee_client_open_context failed!", __func__, __LINE__);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_init_context);
+
+int cmdq_sec_deinit_context(struct cmdq_sec_tee_context *tee)
+{
+	if (tee && tee->tee_context)
+		tee_client_close_context(tee->tee_context);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_deinit_context);
+
+int cmdq_sec_allocate_wsm(struct cmdq_sec_tee_context *tee, void **wsm_buffer, u32 size)
+{
+	void *buffer;
+
+	if (!wsm_buffer)
+		return -EINVAL;
+
+	if (size == 0)
+		return -EINVAL;
+
+	buffer = kmalloc(size, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	tee->shared_mem = tee_shm_register_kernel_buf(tee->tee_context, buffer, size);
+	if (!tee->shared_mem) {
+		kfree(buffer);
+		return -ENOMEM;
+	}
+
+	*wsm_buffer = buffer;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_allocate_wsm);
+
+int cmdq_sec_free_wsm(struct cmdq_sec_tee_context *tee, void **wsm_buffer)
+{
+	if (!wsm_buffer)
+		return -EINVAL;
+
+	tee_shm_put(tee->shared_mem);
+	tee->shared_mem = NULL;
+	kfree(*wsm_buffer);
+	*wsm_buffer = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_free_wsm);
+
+int cmdq_sec_open_session(struct cmdq_sec_tee_context *tee, void *wsm_buffer)
+{
+	struct tee_ioctl_open_session_arg osarg = {0};
+	struct tee_param params = {0};
+	int ret = 0;
+
+	if (!wsm_buffer)
+		return -EINVAL;
+
+	osarg.num_params = 1;
+	memcpy(osarg.uuid, tee->uuid, sizeof(osarg.uuid));
+	osarg.clnt_login = 0;
+
+	ret = tee_client_open_session(tee->tee_context, &osarg, &params);
+	if (ret)
+		return -EFAULT;
+
+	if (!osarg.ret)
+		tee->session = osarg.session;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_open_session);
+
+int cmdq_sec_close_session(struct cmdq_sec_tee_context *tee)
+{
+	tee_client_close_session(tee->tee_context, tee->session);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_close_session);
+
+int cmdq_sec_execute_session(struct cmdq_sec_tee_context *tee, u32 cmd, s32 timeout_ms)
+{
+	struct tee_ioctl_invoke_arg invoke_arg = {0};
+	struct tee_param params = {0};
+	u64 ts = sched_clock();
+	int ret = 0;
+
+	mutex_lock(&cmdq_sec_exec_lock);
+
+	params.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+	params.u.memref.shm = tee->shared_mem;
+	params.u.memref.shm_offs = 0;
+	params.u.memref.size = tee->shared_mem->size;
+
+	invoke_arg.num_params = 1;
+	invoke_arg.session = tee->session;
+	invoke_arg.func = cmd;
+
+	ret = tee_client_invoke_func(tee->tee_context, &invoke_arg, &params);
+	if (ret) {
+		pr_err("tee_client_invoke_func failed, ret=%d\n", ret);
+		return -EFAULT;
+	}
+
+	ret = invoke_arg.ret;
+
+	mutex_unlock(&cmdq_sec_exec_lock);
+
+	ts = div_u64(sched_clock() - ts, 1000000);
+
+	if (ret != 0)
+		pr_err("[SEC]execute: TEEC_InvokeCommand:%u ret:%d cost:%lluus", cmd, ret, ts);
+	else if (ts > timeout_ms)
+		pr_err("[SEC]execute: TEEC_InvokeCommand:%u ret:%d cost:%lluus", cmd, ret, ts);
+	else
+		pr_debug("[SEC]execute: TEEC_InvokeCommand:%u ret:%d cost:%lluus", cmd, ret, ts);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cmdq_sec_execute_session);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 43eae45a08c9..d29916d17110 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -22,6 +22,7 @@
 #define CMDQ_SUBSYS_SHIFT		16
 #define CMDQ_OP_CODE_SHIFT		24
 #define CMDQ_JUMP_PASS			CMDQ_INST_SIZE
+#define CMDQ_EOC_CMD			0x4000000000000001ULL
 
 #define CMDQ_WFE_UPDATE			BIT(31)
 #define CMDQ_WFE_UPDATE_VALUE		BIT(16)
@@ -84,6 +85,7 @@ struct cmdq_pkt {
 	size_t			buf_size; /* real buffer size */
 	void			*cl;
 	bool			loop;
+	void			*sec_data;
 };
 
 struct cmdq_thread {
diff --git a/include/linux/mailbox/mtk-cmdq-sec-iwc-common.h b/include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
new file mode 100644
index 000000000000..655185ea8a82
--- /dev/null
+++ b/include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#ifndef __CMDQ_SEC_IWC_COMMON_H__
+#define __CMDQ_SEC_IWC_COMMON_H__
+
+/**
+ * CMDQ_SEC_SHARED_THR_CNT_OFFSET - shared memory offset to store thread count.
+ */
+#define CMDQ_SEC_SHARED_THR_CNT_OFFSET		0x100
+
+/**
+ * CMDQ_TZ_CMD_BLOCK_SIZE - total command buffer size copy from normal world to secure world.
+ * maximum 20 pages may be requested for MDP readback.
+ */
+#define CMDQ_TZ_CMD_BLOCK_SIZE		(20 << 12)
+
+/**
+ * CMDQ_IWC_MAX_CMD_LENGTH - max length of u32 array to store commanad buffer.
+ */
+#define CMDQ_IWC_MAX_CMD_LENGTH		(CMDQ_TZ_CMD_BLOCK_SIZE / sizeof(u32))
+
+/**
+ * CMDQ_IWC_MAX_ADDR_LIST_LENGTH - max length of addr metadata list.
+ */
+#define CMDQ_IWC_MAX_ADDR_LIST_LENGTH	(30)
+
+/**
+ * CMDQ_IWC_CLIENT_NAME - length for caller_name in iwc_cmdq_command_t.
+ */
+#define CMDQ_IWC_CLIENT_NAME		(16)
+
+/**
+ * CMDQ_MAX_READBACK_ENG - length for readback_engs in iwc_cmdq_command_t.
+ */
+#define CMDQ_MAX_READBACK_ENG		(8)
+
+/**
+ * CMDQ_SEC_MESSAGE_INST_LEN - length for sec_inst in iwc_cmdq_sec_status_t.
+ */
+#define CMDQ_SEC_MESSAGE_INST_LEN	(8)
+
+/**
+ * CMDQ_SEC_DISPATCH_LEN - length for dispatch in iwc_cmdq_sec_status_t.
+ */
+#define CMDQ_SEC_DISPATCH_LEN		(8)
+
+/*
+ * IWC Command IDs - ID for normal world(TLC or linux kernel) to secure world.
+ */
+#define CMD_CMDQ_IWC_SUBMIT_TASK	(1) /* submit current task */
+#define CMD_CMDQ_IWC_CANCEL_TASK	(3) /* cancel current task */
+#define CMD_CMDQ_IWC_PATH_RES_ALLOCATE	(4) /* create global resource for secure path */
+
+/**
+ * enum cmdq_iwc_addr_metadata_type - address medadata type to be converted in secure world.
+ * @CMDQ_IWC_H_2_PA: secure handle to sec PA.
+ * @CMDQ_IWC_H_2_MVA: secure handle to sec MVA.
+ * @CMDQ_IWC_NMVA_2_MVA: map normal MVA to secure world.
+ * @CMDQ_IWC_PH_2_MVA: session protected handle to sec MVA.
+ *
+ * To tell secure world waht operation to use for converting address in metadata list.
+ */
+enum cmdq_iwc_addr_metadata_type {
+	CMDQ_IWC_H_2_PA		= 0,
+	CMDQ_IWC_H_2_MVA	= 1,
+	CMDQ_IWC_NMVA_2_MVA	= 2,
+	CMDQ_IWC_PH_2_MVA	= 3,
+};
+
+/*
+ * enum cmdq_sec_engine_enum - the flag for HW engines need to be proteced in secure world.
+ * Each enum is a bit in a u64 engine flag variable.
+ */
+enum cmdq_sec_engine_enum {
+	/* MDP */
+	CMDQ_SEC_MDP_RDMA0		= 0,
+	CMDQ_SEC_MDP_RDMA1		= 1,
+	CMDQ_SEC_MDP_WDMA		= 2,
+	CMDQ_SEC_MDP_RDMA2		= 3,
+	CMDQ_SEC_MDP_RDMA3		= 4,
+	CMDQ_SEC_MDP_WROT0		= 5,
+	CMDQ_SEC_MDP_WROT1		= 6,
+	CMDQ_SEC_MDP_WROT2		= 7,
+	CMDQ_SEC_MDP_WROT3		= 8,
+	CMDQ_SEC_MDP_HDR0		= 9,
+	CMDQ_SEC_MDP_HDR1		= 10,
+	CMDQ_SEC_MDP_HDR2		= 11,
+	CMDQ_SEC_MDP_HDR3		= 12,
+	CMDQ_SEC_MDP_AAL0		= 13,
+	CMDQ_SEC_MDP_AAL1		= 14,
+	CMDQ_SEC_MDP_AAL2		= 15,
+	CMDQ_SEC_MDP_AAL3		= 16,
+
+	/* DISP (VDOSYS0) */
+	CMDQ_SEC_DISP_RDMA0		= 17,
+	CMDQ_SEC_DISP_RDMA1		= 18,
+	CMDQ_SEC_DISP_WDMA0		= 19,
+	CMDQ_SEC_DISP_WDMA1		= 20,
+	CMDQ_SEC_DISP_OVL0		= 21,
+	CMDQ_SEC_DISP_OVL1		= 22,
+	CMDQ_SEC_DISP_OVL2		= 23,
+	CMDQ_SEC_DISP_2L_OVL0		= 24,
+	CMDQ_SEC_DISP_2L_OVL1		= 25,
+	CMDQ_SEC_DISP_2L_OVL2		= 26,
+
+	/* DSIP (VDOSYS1) */
+	CMDQ_SEC_VDO1_DISP_RDMA_L0	= 27,
+	CMDQ_SEC_VDO1_DISP_RDMA_L1	= 28,
+	CMDQ_SEC_VDO1_DISP_RDMA_L2	= 29,
+	CMDQ_SEC_VDO1_DISP_RDMA_L3	= 30,
+
+	/* VENC */
+	CMDQ_SEC_VENC_BSDMA		= 31,
+	CMDQ_SEC_VENC_CUR_LUMA		= 32,
+	CMDQ_SEC_VENC_CUR_CHROMA	= 33,
+	CMDQ_SEC_VENC_REF_LUMA		= 34,
+	CMDQ_SEC_VENC_REF_CHROMA	= 35,
+	CMDQ_SEC_VENC_REC		= 36,
+	CMDQ_SEC_VENC_SUB_R_LUMA	= 37,
+	CMDQ_SEC_VENC_SUB_W_LUMA	= 38,
+	CMDQ_SEC_VENC_SV_COMV		= 39,
+	CMDQ_SEC_VENC_RD_COMV		= 40,
+	CMDQ_SEC_VENC_NBM_RDMA		= 41,
+	CMDQ_SEC_VENC_NBM_WDMA		= 42,
+	CMDQ_SEC_VENC_NBM_RDMA_LITE	= 43,
+	CMDQ_SEC_VENC_NBM_WDMA_LITE	= 44,
+	CMDQ_SEC_VENC_FCS_NBM_RDMA	= 45,
+	CMDQ_SEC_VENC_FCS_NBM_WDMA	= 46,
+
+	CMDQ_SEC_MAX_ENG_COUNT
+};
+
+/**
+ * struct iwc_cmdq_addr_metadata_t - metadata structure for converting address of secure buffer.
+ * @instr_idx: index of instruction.
+ * @type: addr metadata type.
+ * @base_handle: secure address handle.
+ * @block_offset: block offset from handle(PA) to current block(plane).
+ * @offset: buffser offset to secure handle.
+ * @size: buffer size.
+ * @port: HW port id (i.e. M4U port id)
+ */
+struct iwc_cmdq_addr_metadata_t {
+	/**
+	 * @instr_idx: update its arg_b value to real PA/MVA in secure world.
+	 */
+	u32 instr_idx;
+
+	/**
+	 * @type: address medadata type to be converted in secure world.
+	 */
+	u32 type;
+
+	/**
+	 * @base_handle:
+	 * @block_offset:
+	 * @offset:
+	 * @size:
+	 * these members are used to store the buffer and offset relationship.
+	 *
+	 *   -------------
+	 *   |     |     |
+	 *   -------------
+	 *   ^     ^  ^  ^
+	 *   A     B  C  D
+	 *
+	 *  A: base_handle
+	 *  B: base_handle + block_offset
+	 *  C: base_handle + block_offset + offset
+	 *  A~B or B~D: size
+	 */
+	u64 base_handle;
+	u32 block_offset;
+	u32 offset;
+	u32 size;
+
+	/**
+	 * @port: [IN]
+	 *
+	 * used to configure M4U port id.
+	 */
+	u32 port;
+};
+
+/**
+ * struct iwc_cmdq_metadata_t - metadata structure for converting a list of secure buffer address.
+ * @addr_list_length: length of metadata address list.
+ * @addr_list: array of metadata address list.
+ * @engs_need_dapc: HW engines need to be protected by dapc.
+ * @engs_need_sec_port: HW engines need to be protected by secure larb port.
+ */
+struct iwc_cmdq_metadata_t {
+	u32 addr_list_length;
+	struct iwc_cmdq_addr_metadata_t addr_list[CMDQ_IWC_MAX_ADDR_LIST_LENGTH];
+	u64 engs_need_dapc;
+	u64 engs_need_sec_port;
+};
+
+/**
+ * enum sec_extension_iwc - extension HW engine flag to be protcted in secure world.
+ * @IWC_MDP_AAL: for MDP AAL engine.
+ * @IWC_MDP_TDSHP: for MDP TDSHP engine.
+ */
+enum sec_extension_iwc {
+	IWC_MDP_AAL = 0,
+	IWC_MDP_TDSHP,
+};
+
+/**
+ * struct readback_engine - readback engine parameters.
+ * @engine: HW engine flag for readback.
+ * @start: start address pa of readback buffer.
+ * @count: u32 size count of readback buffer.
+ * @param: other parameters need in secure world.
+ */
+struct readback_engine {
+	u32 engine;
+	u32 start;
+	u32 count;
+	u32 param;
+};
+
+/**
+ * struct iwc_cmdq_command_t - structure for excuting cmdq task in secure world.
+ * @thread: GCE secure thread index to execute command.
+ * @scenario: scenario to execute command.
+ * @priority: priority of GCE secure thread.
+ * @cmd_size: command size used in command buffer.
+ * @eng_flag: HW engine flag need to enable protection configuration.
+ * @va_base: command buffer
+ * @wait_cookie: index in thread's task list, it should be (nextCookie - 1).
+ * @reset_exec: reset HW thread.
+ * @caller_pid: pid of client module.
+ * @caller_name: name of client module.
+ * @metadata: metadata structure for converting a list of secure buffer address.
+ * @extension: extension HW engine flag to be protcted in secure world.
+ * @readback_pa: readback buffer pa.
+ * @normal_task_handle: handle to reference task in normal world.
+ * @mdp_extension: extension MDP HW engine flag to be protcted in secure world.
+ * @readback_engs: array of readback engines parameters.
+ * @readback_cnt: count of readback_engs array.
+ */
+struct iwc_cmdq_command_t {
+	/* basic execution data */
+	u32 thread;
+	u32 scenario;
+	u32 priority;
+	u32 cmd_size;
+	u64 eng_flag;
+	u32 va_base[CMDQ_IWC_MAX_CMD_LENGTH];
+
+	/* exec order data */
+	u32 wait_cookie;
+	bool reset_exec;
+
+	/* client info */
+	s32 caller_pid;
+	char caller_name[CMDQ_IWC_CLIENT_NAME];
+
+	/* metadata */
+	struct iwc_cmdq_metadata_t metadata;
+
+	/* client extension bits */
+	u64 extension;
+	u64 readback_pa;
+
+	/* debug */
+	u64 normal_task_handle;
+
+	/* SVP HDR */
+	u32 mdp_extension;
+	struct readback_engine readback_engs[CMDQ_MAX_READBACK_ENG];
+	u32 readback_cnt;
+};
+
+/**
+ * struct iwc_cmdq_cancel_task_t - structure for canceling cmdq task in the secure world.
+ * @thread: [IN] GCE secure thread index.
+ * @wait_cookie: [IN] execute count cookie to wait.
+ * @throw_aee: [OUT] AEE has thrown.
+ * @has_reset: [OUT] current secure thread has been reset
+ * @irq_status: [OUT] global secure IRQ flag.
+ * @irq_flag: [OUT] thread IRQ flag.
+ * @err_instr: [OUT] err_instr[0] = instruction low bits, err_instr[1] = instruction high bits.
+ * @reg_value: [OUT] value of error register.
+ * @pc: [OUT] current pc.
+ *
+ * used to allocate share memory from secure world.
+ */
+struct iwc_cmdq_cancel_task_t {
+	s32 thread;
+	u32 wait_cookie;
+	bool throw_aee;
+	bool has_reset;
+	s32 irq_status;
+	s32 irq_flag;
+	u32 err_instr[2];
+	u32 reg_value;
+	u32 pc;
+};
+
+/**
+ * struct iwc_cmdq_path_resource_t - Inter-World Communication resource allocation structure.
+ * @share_memoy_pa: use long long for 64 bit compatible support.
+ * @size: size of share memory.
+ * @use_normal_irq: use normal IRQ in secure world.
+ *
+ * used to allocate share memory from secure world.
+ */
+struct iwc_cmdq_path_resource_t {
+	long long share_memoy_pa;
+	u32 size;
+	bool use_normal_irq;
+};
+
+/**
+ * struct iwc_cmdq_debug_config_t - debug config structure for secure debug log.
+ *
+ * @log_level: log level in secure world.
+ * @enable_profile: enable profile in secure world.
+ */
+struct iwc_cmdq_debug_config_t {
+	s32 log_level;
+	s32 enable_profile;
+};
+
+/**
+ * struct iwc_cmdq_sec_status_t - secure status from secure world.
+ *
+ * @step: the step in secure cmdq TA.
+ * @status: the status in secure cmdq TA.
+ * @args: the status arguments in secure cmdq TA.
+ * @sec_inst: current instruction in secure cmdq TA.
+ * @inst_index: current instruction index in secure cmdq TA.
+ * @dispatch: current HW engine configuring in secure cmdq TA.
+ */
+struct iwc_cmdq_sec_status_t {
+	u32 step;
+	s32 status;
+	u32 args[4];
+	u32 sec_inst[CMDQ_SEC_MESSAGE_INST_LEN];
+	u32 inst_index;
+	char dispatch[CMDQ_SEC_DISPATCH_LEN];
+};
+
+/**
+ * struct iwc_cmdq_message_t - Inter-World Communication message structure.
+ * @cmd: [IN] iwc command id.
+ * @rsp: [OUT] respond from secureworld, 0 for success, < 0 for error.
+ * @command: [IN] structure for excuting cmdq task in secure world.
+ * @cancel_task: [IN] structure for canceling cmdq task in the secure world.
+ * @path_resource: [IN]
+ * @debug: [IN] debug config structure for secure debug log.
+ * @sec_status: [OUT] secure status from secure world.
+ * @cmdq_id: [IN] GCE core id.
+ *
+ * Both Linex kernel and mobicore have their own MMU tables for mapping
+ * world shared memory and physical addresses, so mobicore does not understand
+ * linux virtual address mapping.
+ * If we want to transact a large buffer in TCI/DCI, there are 2 ways (both require 1 copy):
+ * 1. Ue mc_map to map the normal world buffer to WSM and pass secure_virt_addr in TCI/DCI buffer.
+ *    Note that mc_map implies a memcopy to copy the content from normal world to WSM.
+ * 2. Declare a fixed-length array in TCI/DCI struct and its size must be < 1M.
+ */
+struct iwc_cmdq_message_t {
+	union {
+		u32 cmd;
+		s32 rsp;
+	};
+
+	union {
+		struct iwc_cmdq_command_t command;
+		struct iwc_cmdq_cancel_task_t cancel_task;
+		struct iwc_cmdq_path_resource_t path_resource;
+	};
+
+	struct iwc_cmdq_debug_config_t debug;
+	struct iwc_cmdq_sec_status_t sec_status;
+
+	u8 cmdq_id;
+};
+#endif /* __CMDQ_SEC_IWC_COMMON_H__ */
diff --git a/include/linux/mailbox/mtk-cmdq-sec-mailbox.h b/include/linux/mailbox/mtk-cmdq-sec-mailbox.h
new file mode 100644
index 000000000000..01a842d713e6
--- /dev/null
+++ b/include/linux/mailbox/mtk-cmdq-sec-mailbox.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#ifndef __MTK_CMDQ_SEC_MAILBOX_H__
+#define __MTK_CMDQ_SEC_MAILBOX_H__
+
+#include <linux/kernel.h>
+
+#include <linux/mailbox/mtk-cmdq-mailbox.h>
+#include <linux/mailbox/mtk-cmdq-sec-iwc-common.h>
+#include <linux/mailbox/mtk-cmdq-sec-tee.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#define CMDQ_INVALID_THREAD		(-1)
+#define CMDQ_MAX_TASK_IN_SECURE_THREAD	(16)
+#define CMDQ_SEC_IRQ_THREAD		(15)
+
+/**
+ * CMDQ_MAX_COOKIE_VALUE - max value of CMDQ_THR_EXEC_CNT_PA (value starts from 0)
+ */
+#define CMDQ_MAX_COOKIE_VALUE           (0xffff)
+
+/**
+ * enum cmdq_sec_scenario - scenario settings for cmdq TA.
+ * @CMDQ_SEC_SCNR_PRIMARY_DISP: primary display vdo mode enable.
+ * @CMDQ_SEC_SCNR_SUB_DISP: external display vdo mode enable.
+ * @CMDQ_SEC_SCNR_PRIMARY_DISP_DISABLE: primary display vdo mode disable.
+ * @CMDQ_SEC_SCNR_SUB_DISP_DISABLE: external display vdo mode disable.
+ * @CMDQ_SEC_SCNR_MAX: the end of enum.
+ *
+ * These states are used to record the state of IWC message structure.
+ */
+enum cmdq_sec_scenario {
+	CMDQ_SEC_SCNR_PRIMARY_DISP		= 1,
+	CMDQ_SEC_SCNR_SUB_DISP			= 4,
+	CMDQ_SEC_SCNR_PRIMARY_DISP_DISABLE	= 18,
+	CMDQ_SEC_SCNR_SUB_DISP_DISABLE		= 19,
+	CMDQ_SEC_SCNR_MAX,
+};
+
+/**
+ * enum cmdq_iwc_state_enum - state of Inter-world Communication(IWC) message
+ * @IWC_INIT: state of initializing tee context, means tee context has not initialized.
+ * @IWC_CONTEXT_INITED: tee context has initialized.
+ * @IWC_WSM_ALLOCATED: world share memory has allocated.
+ * @IWC_SES_OPENED: session to the tee context has opend.
+ * @IWC_SES_ON_TRANSACTED: session to the tee context has transacted.
+ * @IWC_STATE_MAX: the end of enum.
+ *
+ * These states are used to record the state of IWC message structure.
+ */
+enum cmdq_iwc_state_enum {
+	IWC_INIT,
+	IWC_CONTEXT_INITED,
+	IWC_WSM_ALLOCATED,
+	IWC_SES_OPENED,
+	IWC_SES_ON_TRANSACTED,
+	IWC_STATE_MAX,
+};
+
+/**
+ * struct gce_sec_plat - used to pass platform data from cmdq driver.
+ * @gce_dev: pointer to GCE device.
+ * @hwid: GCE core id.
+ * @gce_num: number of GCE core.
+ * @clocks: GCE clocks.
+ * @thread_nr: number of thread in each GCE core.
+ * @secure_thread_nr: number of secure thread.
+ * @secure_thread_min: min index of secure thread.
+ * @cmdq_event: secure EOF event id.
+ */
+struct gce_sec_plat {
+	struct device *gce_dev;
+	u32 hwid;
+	u32 gce_num;
+	struct clk_bulk_data *clocks;
+	u32 thread_nr;
+	u8 secure_thread_nr;
+	u8 secure_thread_min;
+	u32 cmdq_event;
+};
+
+/**
+ * struct cmdq_sec_data - used to translate secure buffer PA related instruction
+ * @addr_metadata_cnt: count of element in addr_list.
+ * @addr_metadatas: array of iwc_cmdq_addr_metadata_t.
+ * @addr_metadata_max_cnt: Reserved.
+ * @scenario: scenario config for secure world.
+ * @engs_need_dapc: engine falgs that need to config dapc in secure world.
+ * @engs_need_sec_port: engine falgs that need to config secure larb port in secure world.
+ * @response: return value from secure world.
+ * @sec_status: current iwc message status from secure world.
+ *
+ */
+struct cmdq_sec_data {
+	u32 addr_metadata_cnt;
+	u64 addr_metadatas;
+	u32 addr_metadata_max_cnt;
+	enum cmdq_sec_scenario scenario;
+	u64 engs_need_dapc;
+	u64 engs_need_sec_port;
+	s32 response;
+	struct iwc_cmdq_sec_status_t sec_status;
+};
+
+/**
+ * cmdq_sec_pkt_free_sec_data() - free sec_data for CMDQ packet.
+ * @pkt:	the CMDQ packet.
+ */
+void cmdq_sec_pkt_free_sec_data(struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_sec_pkt_alloc_sec_data() - allocate sec_data for CMDQ packet.
+ * @pkt:	the CMDQ packet.
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_sec_pkt_alloc_sec_data(struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_sec_insert_backup_cookie() - append backup cookie related instructions.
+ * @pkt:	the CMDQ packet.
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_sec_insert_backup_cookie(struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_sec_pkt_set_data() - set secure configuration to sec_data in CDMQ packet.
+ * @pkt:	the CMDQ packet.
+ * @dapc_engine:	the engine flag for dapc protection.
+ * @port_sec_engine:	the engine flag for secure larb prot protection.
+ * @scenario:		the scenario to CMDQ TA.
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_sec_pkt_set_data(struct cmdq_pkt *pkt, const u64 dapc_engine,
+			  const u64 port_sec_engine, const enum cmdq_sec_scenario scenario);
+
+/**
+ * cmdq_sec_pkt_write() - append write secure buffer related instructions.
+ * @pkt:	  the CMDQ packet.
+ * @addr:	the register to be configured.
+ * @base:	the secure handle of secure buffer.
+ * @type:	the address metadata conversion type.
+ * @offset:	the address offset of secure buffer.
+ * @size:	the secure buffer size.
+ * @port:	the HW port id to M4U TA.
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_sec_pkt_write(struct cmdq_pkt *pkt, u32 addr, u64 base,
+		       const enum cmdq_iwc_addr_metadata_type type,
+		       const u32 offset, const u32 size, const u32 port);
+
+#endif /* __MTK_CMDQ_SEC_MAILBOX_H__ */
diff --git a/include/linux/mailbox/mtk-cmdq-sec-tee.h b/include/linux/mailbox/mtk-cmdq-sec-tee.h
new file mode 100644
index 000000000000..d2c97a137e01
--- /dev/null
+++ b/include/linux/mailbox/mtk-cmdq-sec-tee.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#ifndef __MTK_CMDQ_SEC_TEE_H__
+#define __MTK_CMDQ_SEC_TEE_H__
+
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/tee_drv.h>
+
+/**
+ * struct cmdq_sec_tee_context - context for tee vendor
+ * @uuid: Universally Unique Identifier of secure world.
+ * @tee_context: basic tee context.
+ * @session: session handle.
+ * @shared_mem: shared memory.
+ */
+struct cmdq_sec_tee_context {
+	u8			uuid[TEE_IOCTL_UUID_LEN];
+	struct tee_context	*tee_context;
+	u32			session;
+	struct tee_shm		*shared_mem;
+};
+
+/**
+ * cmdq_sec_setup_tee_context() - setup the uuid for the tee context to communicate with
+ * @tee:	context for tee vendor
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+void cmdq_sec_setup_tee_context(struct cmdq_sec_tee_context *tee);
+
+/**
+ * cmdq_sec_init_context() - initialize the tee context
+ * @tee:	context for tee vendor
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_init_context(struct cmdq_sec_tee_context *tee);
+
+/**
+ * cmdq_sec_deinit_context() - de-initialize the tee context
+ * @tee:	context for tee vendor
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_deinit_context(struct cmdq_sec_tee_context *tee);
+
+/**
+ * cmdq_sec_allocate_wsm() - allocate the world share memory to pass message to tee
+ * @tee:	context for tee vendor
+ * @wsm_buffer:	world share memory buffer with parameters pass to tee
+ * @size:	size to allocate
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_allocate_wsm(struct cmdq_sec_tee_context *tee, void **wsm_buffer, u32 size);
+
+/**
+ * cmdq_sec_free_wsm() - free the world share memory
+ * @tee:	context for tee vendor
+ * @wsm_buffer:	world share memory buffer with parameters pass to tee
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_free_wsm(struct cmdq_sec_tee_context *tee, void **wsm_buffer);
+
+/**
+ * cmdq_sec_open_session() - open session to the tee context
+ * @tee:	context for tee vendor
+ * @wsm_buffer:	world share memory buffer with parameters pass to tee
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_open_session(struct cmdq_sec_tee_context *tee, void *wsm_buffer);
+
+/**
+ * cmdq_sec_close_session() - close session to the tee context
+ * @tee:	context for tee vendor
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_close_session(struct cmdq_sec_tee_context *tee);
+
+/**
+ * cmdq_sec_execute_session() - execute session to the tee context
+ * @tee:	context for tee vendor
+ * @cmd:	tee invoke cmd id
+ * @timeout_ms:	timeout ms to current tee invoke cmd
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ */
+int cmdq_sec_execute_session(struct cmdq_sec_tee_context *tee, u32 cmd, s32 timeout_ms);
+
+#endif	/* __MTK_CMDQ_SEC_TEE_H__ */
-- 
2.18.0


