Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD83B7D305E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJWKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:49:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF939D5D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:48:54 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 833EC6606F51;
        Mon, 23 Oct 2023 11:48:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698058133;
        bh=pYbIaVGwksfO86YAFnKvv292v8VHTlO0sgOygIPd/2s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YHM4BxKGvkse5uh/aK4E/H9ZUdectLavVoAhT25CJpgNlqENHXzujEuWyxpJRHncP
         HnISI8ukegODvKT1TzHmEvm/qcQyBDEZENJ+VXPmsvzWkdhjMF65p6POscTR4YyArx
         0YfbhjWjduzjnRpLDFOx7SdjgFs8KhpNMWzQ1vhntt2q+pN1nsoDkjLgFIRIVjxKPN
         bDDAiCyp1FQ1GHacmq+9xkYDpR4aWKK1+bKYDtQ/XKwuB6ScIw0t1KEdhfDTq1HVIp
         uQMY43jAvYhLF4I5S5/H3hLf4LoEd6A+aB0cTB8pRoLe19ddUNC5ImmvdMaeM9d3vK
         91uaUNbm9bggw==
Message-ID: <cc01d80a-b96c-4e99-9277-b2db2f82dee0@collabora.com>
Date:   Mon, 23 Oct 2023 12:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-9-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023043751.17114-9-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 06:37, Jason-JH.Lin ha scritto:
> To support secure video path feature, GCE have to read/write registgers
> in the secure world. GCE will enable the secure access permission to the
> HW who wants to access the secure content buffer.
> 
> Add CMDQ secure mailbox driver to make CMDQ client user is able to
> sending their HW settings to the secure world. So that GCE can execute
> all instructions to configure HW in the secure world.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

This driver needs to be cleaned up quite a bit, and I'd expect this to take a few
versions before being upstreamable.

> ---
>   drivers/mailbox/Makefile                      |    2 +-
>   drivers/mailbox/mtk-cmdq-sec-mailbox.c        | 1102 +++++++++++++++++
>   drivers/mailbox/mtk-cmdq-sec-tee.c            |  202 +++
>   include/linux/mailbox/mtk-cmdq-mailbox.h      |    2 +
>   .../linux/mailbox/mtk-cmdq-sec-iwc-common.h   |  293 +++++
>   include/linux/mailbox/mtk-cmdq-sec-mailbox.h  |   83 ++
>   include/linux/mailbox/mtk-cmdq-sec-tee.h      |   31 +
>   7 files changed, 1714 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/mailbox/mtk-cmdq-sec-mailbox.c
>   create mode 100644 drivers/mailbox/mtk-cmdq-sec-tee.c
>   create mode 100644 include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
>   create mode 100644 include/linux/mailbox/mtk-cmdq-sec-mailbox.h
>   create mode 100644 include/linux/mailbox/mtk-cmdq-sec-tee.h
> 
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index fc9376117111..82da2f4ee81a 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -51,7 +51,7 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
>   
>   obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
>   
> -obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
> +obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o mtk-cmdq-sec-mailbox.o mtk-cmdq-sec-tee.o
>   
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
>   
> diff --git a/drivers/mailbox/mtk-cmdq-sec-mailbox.c b/drivers/mailbox/mtk-cmdq-sec-mailbox.c
> new file mode 100644
> index 000000000000..dac867386cf1
> --- /dev/null
> +++ b/drivers/mailbox/mtk-cmdq-sec-mailbox.c
> @@ -0,0 +1,1102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2019 MediaTek Inc.
> +

Fix comment style please:

// SPDX...
/*
  * Copyright ...
  */

> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/of_platform.h>
> +#include <linux/sched/clock.h>
> +#include <linux/timer.h>
> +
> +#include <linux/mailbox/mtk-cmdq-sec-mailbox.h>
> +
> +#define CMDQ_THR_BASE		(0x100)
> +#define CMDQ_THR_SIZE		(0x80)

Those two definitions are the same as in mtk-cmdq-mailbox.c: please avoid code
duplication around, it's harder to maintain.

> +#define CMDQ_THR_EXEC_CNT_PA	(0x28)
> +
> +#define CMDQ_BUF_ALLOC_SIZE		(PAGE_SIZE)
> +#define CMDQ_TIMEOUT_DEFAULT		(1000)
> +#define CMDQ_NO_TIMEOUT			(0xffffffff)
> +#define ADDR_METADATA_MAX_COUNT_ORIGIN	(8)
> +
> +/*
> + * CMDQ secure context struct
> + * note it is not global data, each process has its own CMDQ sec context
> + */

This structure is practically fully documented: please use kerneldoc at this point.

> +struct cmdq_sec_context {
> +	struct list_head		listEntry;

listEntry -> list_entry or listentry - no camelcase please.

> +
> +	/* basic info */
> +	u32				tgid; /* tgid of process context */
> +	u32				referCount; /* reference count for open cmdq device node */
> +

referCount -> refcount?

> +	/* iwc state */
> +	enum cmdq_iwc_state_enum	state;

iwc_state

> +
> +	/* iwc information */
> +	void				*iwc_msg; /* message buffer */
> +
> +	struct cmdq_sec_tee_context	tee; /* trustzone parameters */

tee_ctx

> +};
> +
> +struct cmdq_sec_task {
> +	struct list_head	list_entry;
> +	dma_addr_t		pa_base;
> +	struct cmdq_sec_thread	*thread;
> +	struct cmdq_pkt		*pkt;
> +	u64			exec_time;
> +	struct work_struct	exec_work;
> +
> +	bool			resetExecCnt;

Again no camelcase - here and everywhere else.

Also, I see a pattern in all of the _sec_ structures: those seem to be the same
as the non-sec ones, as defined in mtk-cmdq-mailbox, but with more params.

I understand the memory concerns, but there's an easy way out of this... we could
get this done like:

struct cmdq_sec_task {
	struct cmdq_task	tsk;

	/* Secure CMDQ */
	u32			wait_cookie;
	s32			scenario;
	u64			engine_flag;
	u64			trigger;
}

...and this can be done for all of the _sec_ variants of the cmdq mbox structs
as far as I can see.

> +	u32			waitCookie;
> +
> +	u64			engineFlag;
> +	s32			scenario;
> +	u64			trigger;
> +};
> +
> +struct cmdq_sec_thread {
> +	struct mbox_chan	*chan;
> +	void __iomem		*base;
> +	struct list_head	task_list;
> +	struct timer_list	timeout;
> +	u32			timeout_ms;
> +	struct work_struct	timeout_work;
> +	u32			priority;
> +	u32			idx;
> +	bool			occupied;
> +
> +	/* following part only secure ctrl */
> +	u32			wait_cookie;
> +	u32			next_cookie;
> +	u32			task_cnt;
> +	struct workqueue_struct	*task_exec_wq;
> +};
> +
> +/**

This is not valid kerneldoc.

> + * shared memory between normal and secure world
> + */
> +struct cmdq_sec_shared_mem {
> +	void		*va;
> +	dma_addr_t	pa;
> +	u32		size;
> +};
> +
> +struct cmdq_sec {
> +	struct mbox_controller		mbox;
> +	void __iomem			*base;
> +	phys_addr_t			base_pa;
> +	u32				hwid;
> +	u32				gce_num;
> +	struct clk_bulk_data		*clocks;
> +	u32				thread_nr;
> +	struct cmdq_sec_thread		*thread;
> +	struct cmdq_client		*clt;
> +	struct cmdq_pkt			*clt_pkt;
> +
> +	atomic_t			path_res;
> +	struct cmdq_sec_shared_mem	*shared_mem;
> +	struct cmdq_sec_context		*context;
> +	struct iwcCmdqCancelTask_t	cancel;
> +
> +	struct workqueue_struct		*timeout_wq;
> +	u64				sec_invoke;
> +	u64				sec_done;
> +
> +	bool				notify_run;
> +	struct work_struct		irq_notify_work;
> +	struct workqueue_struct		*notify_wq;
> +	u32				cmdq_event;
> +	/* mutex for cmdq_sec_thread excuting cmdq_sec_task */
> +	struct mutex			exec_lock;
> +};
> +
> +static atomic_t cmdq_path_res = ATOMIC_INIT(0);
> +
> +static int cmdq_sec_task_submit(struct cmdq_sec *cmdq, struct cmdq_sec_task *task,
> +				const u32 iwc_cmd, const u32 thrd_idx, void *data);
> +
> +static inline void cmdq_sec_setup_tee_context_base(struct cmdq_sec_context *context)

You don't need this function, as it's just wrapping over another one: you can just
call cmdq_sec_setup_tee_context.

> +{
> +	cmdq_sec_setup_tee_context(&context->tee);
> +}
> +
> +static inline int cmdq_sec_init_context_base(struct cmdq_sec_context *context)
> +{
> +	int status;
> +
> +	status = cmdq_sec_init_context(&context->tee);
> +	if (status < 0)
> +		return status;

if (a < 0) return a;
else return a;

really? :-)

Besides, again, you don't need this wrapper function.

> +
> +	return status;
> +}
> +
> +int cmdq_sec_insert_backup_cookie(struct cmdq_pkt *pkt)
> +{
> +	struct cmdq_client *cl = (struct cmdq_client *)pkt->cl;
> +	struct cmdq_sec_thread *thread = ((struct mbox_chan *)(cl->chan))->con_priv;
> +	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
> +	struct cmdq_operand left, right;
> +	dma_addr_t addr;
> +
> +	if (!thread->occupied || !cmdq->shared_mem)
> +		return -EFAULT;
> +
> +	pr_debug("%s %d: pkt:%p thread:%u gce:%#lx",

All those pr_xxxx shall become dev_debug, dev_err, etc.

> +		 __func__, __LINE__, pkt, thread->idx, (unsigned long)cmdq->base_pa);
> +
> +	addr = (u32)(cmdq->base_pa + CMDQ_THR_BASE +
> +		CMDQ_THR_SIZE * thread->idx + CMDQ_THR_EXEC_CNT_PA);
> +
> +	cmdq_pkt_assign(pkt, CMDQ_THR_SPR_IDX1, CMDQ_ADDR_HIGH(addr));
> +	cmdq_pkt_read_s(pkt, CMDQ_THR_SPR_IDX1, CMDQ_ADDR_LOW(addr), CMDQ_THR_SPR_IDX1);
> +
> +	left.reg = true;
> +	left.idx = CMDQ_THR_SPR_IDX1;
> +	right.reg = false;
> +	right.value = 1;
> +	cmdq_pkt_logic_command(pkt, CMDQ_LOGIC_ADD, CMDQ_THR_SPR_IDX1, &left, &right);
> +
> +	addr = cmdq->shared_mem->pa + CMDQ_SEC_SHARED_THR_CNT_OFFSET +
> +		thread->idx * sizeof(u32);

Fits in one line.

> +
> +	cmdq_pkt_assign(pkt, CMDQ_THR_SPR_IDX2, CMDQ_ADDR_HIGH(addr));
> +	cmdq_pkt_write_s(pkt, CMDQ_THR_SPR_IDX2, CMDQ_ADDR_LOW(addr), CMDQ_THR_SPR_IDX1);
> +	cmdq_pkt_set_event(pkt, cmdq->cmdq_event);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_sec_insert_backup_cookie);
> +
> +static int cmdq_sec_realloc_addr_list(struct cmdq_pkt *pkt, const u32 count)
> +{
> +	struct cmdq_sec_data *sec_data = (struct cmdq_sec_data *)pkt->sec_data;
> +	void *prev = (void *)(unsigned long)sec_data->addrMetadatas, *curr;
> +
> +	if (count <= sec_data->addrMetadataMaxCount)
> +		return 0;
> +
> +	curr = kcalloc(count, sizeof(*sec_data), GFP_KERNEL);
> +	if (!curr)
> +		return -ENOMEM;
> +
> +	if (count && sec_data->addrMetadatas)
> +		memcpy(curr, prev, sizeof(*sec_data) * sec_data->addrMetadataMaxCount);
> +
> +	kfree(prev);
> +
> +	sec_data->addrMetadatas = (uintptr_t)curr;
> +	sec_data->addrMetadataMaxCount = count;
> +	return 0;
> +}
> +
> +static int cmdq_sec_check_sec(struct cmdq_pkt *pkt)

This is not just a check: it is *allocating* memory, so please either find a better
name for this function, or just make sure that the sec_data is already allocated
before calling into functions that are calling this one, as I can foresee memory
leaks because of confusion deriving from this function.

> +{
> +	struct cmdq_sec_data *sec_data;
> +
> +	if (pkt->sec_data)
> +		return 0;
> +
> +	sec_data = kzalloc(sizeof(*sec_data), GFP_KERNEL);
> +	if (!sec_data)
> +		return -ENOMEM;
> +
> +	pkt->sec_data = (void *)sec_data;
> +
> +	return 0;
> +}
> +
> +static int cmdq_sec_append_metadata(struct cmdq_pkt *pkt,
> +				    const enum cmdq_iwc_addr_metadata_type type,
> +				    const u64 base, const u32 offset, const u32 size,
> +				    const u32 port)
> +{
> +	struct cmdq_sec_data *sec_data;
> +	struct iwcCmdqAddrMetadata_t *meta;

No camelcase please.

> +	int idx, max, ret;
> +
> +	pr_debug("[%s %d] pkt:%p type:%u base:%#llx offset:%#x size:%#x port:%#x",
> +		 __func__, __LINE__, pkt, type, base, offset, size, port);
> +
> +	ret = cmdq_sec_check_sec(pkt);
> +	if (ret < 0)
> +		return ret;
> +
> +	sec_data = (struct cmdq_sec_data *)pkt->sec_data;
> +	idx = sec_data->addrMetadataCount;
> +	if (idx >= CMDQ_IWC_MAX_ADDR_LIST_LENGTH) {
> +		pr_err("idx:%u reach over:%u", idx, CMDQ_IWC_MAX_ADDR_LIST_LENGTH);
> +		return -EFAULT;
> +	}
> +
> +	if (!sec_data->addrMetadataMaxCount)
> +		max = ADDR_METADATA_MAX_COUNT_ORIGIN;
> +	else if (idx >= sec_data->addrMetadataMaxCount)
> +		max = sec_data->addrMetadataMaxCount * 2;
> +	else
> +		max = sec_data->addrMetadataMaxCount;
> +
> +	ret = cmdq_sec_realloc_addr_list(pkt, max);
> +	if (ret)
> +		return ret;
> +
> +	if (!sec_data->addrMetadatas) {
> +		pr_info("addrMetadatas is missing");
> +
> +		meta = kzalloc(sizeof(*meta), GFP_KERNEL);
> +		if (!meta)
> +			return -ENOMEM;
> +
> +		sec_data->addrMetadatas = (uintptr_t)(void *)meta;
> +	}
> +	meta = (struct iwcCmdqAddrMetadata_t *)(uintptr_t)sec_data->addrMetadatas;
> +
> +	meta[idx].instrIndex = pkt->cmd_buf_size / CMDQ_INST_SIZE - 1;
> +	meta[idx].type = type;
> +	meta[idx].baseHandle = base;
> +	meta[idx].offset = offset;
> +	meta[idx].size = size;
> +	meta[idx].port = port;
> +	sec_data->addrMetadataCount += 1;
> +	return 0;
> +}
> +
> +int cmdq_sec_pkt_set_data(struct cmdq_pkt *pkt, const u64 dapc_engine,
> +			  const u64 port_sec_engine, const enum cmdq_sec_scenario scenario)
> +{
> +	struct cmdq_sec_data *sec_data;
> +	int ret;
> +
> +	if (!pkt) {
> +		pr_err("invalid pkt:%p", pkt);
> +		return -EINVAL;
> +	}
> +
> +	ret = cmdq_sec_check_sec(pkt);
> +	if (ret < 0)
> +		return ret;
> +
> +	pr_debug("[%s %d] pkt:%p sec_data:%p dapc:%llu port_sec:%llu scen:%u",
> +		 __func__, __LINE__, pkt, pkt->sec_data, dapc_engine, port_sec_engine, scenario);
> +
> +	sec_data = (struct cmdq_sec_data *)pkt->sec_data;
> +	sec_data->enginesNeedDAPC |= dapc_engine;
> +	sec_data->enginesNeedPortSecurity |= port_sec_engine;
> +	sec_data->scenario = scenario;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_sec_pkt_set_data);
> +
> +int cmdq_sec_pkt_write(struct cmdq_pkt *pkt, u32 addr, u64 base,
> +		       const enum cmdq_iwc_addr_metadata_type type,
> +		       const u32 offset, const u32 size, const u32 port)
> +{
> +	int ret;
> +
> +	ret = cmdq_pkt_assign(pkt, CMDQ_THR_SPR_IDX0, addr);
> +	if (ret)
> +		return ret;
> +
> +	ret = cmdq_pkt_write_s_reg_value(pkt, CMDQ_THR_SPR_IDX0, (u32)base);
> +	if (ret)
> +		return ret;
> +
> +	return cmdq_sec_append_metadata(pkt, type, base, offset, size, port);
> +}
> +EXPORT_SYMBOL(cmdq_sec_pkt_write);
> +
> +static u32 cmdq_sec_get_cookie(struct cmdq_sec *cmdq, u32 idx)
> +{
> +	return *(u32 *)(cmdq->shared_mem->va +
> +		CMDQ_SEC_SHARED_THR_CNT_OFFSET + idx * sizeof(u32));
> +}
> +
> +static void cmdq_sec_task_done(struct cmdq_sec_task *task, int sta)
> +{
> +	struct cmdq_cb_data data;
> +
> +	data.sta = sta;
> +	data.pkt = task->pkt;
> +
> +	pr_debug("%s task:%p pkt:%p err:%d",
> +		 __func__, task, task->pkt, sta);
> +
> +	mbox_chan_received_data(task->thread->chan, &data);
> +
> +	list_del_init(&task->list_entry);
> +	kfree(task);
> +}
> +
> +static bool cmdq_sec_irq_handler(struct cmdq_sec_thread *thread, const u32 cookie, const int err)
> +{
> +	struct cmdq_sec_task *task, *temp, *cur_task = NULL;
> +	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
> +	unsigned long flags;
> +	int done;
> +
> +	spin_lock_irqsave(&thread->chan->lock, flags);
> +	if (thread->wait_cookie <= cookie)
> +		done = cookie - thread->wait_cookie + 1;
> +	else if (thread->wait_cookie == (cookie + 1) % CMDQ_MAX_COOKIE_VALUE)
> +		done = 0;
> +	else
> +		done = CMDQ_MAX_COOKIE_VALUE - thread->wait_cookie + 1 +
> +			cookie + 1;
> +
> +	list_for_each_entry_safe(task, temp, &thread->task_list, list_entry) {
> +		if (!done)
> +			break;
> +
> +		cmdq_sec_task_done(task, err);
> +
> +		if (thread->task_cnt)
> +			thread->task_cnt -= 1;
> +
> +		done--;
> +	}
> +
> +	cur_task = list_first_entry_or_null(&thread->task_list,
> +					    struct cmdq_sec_task, list_entry);
> +
> +	if (err && cur_task) {
> +		spin_unlock_irqrestore(&thread->chan->lock, flags);
> +
> +		/* for error task, cancel, callback and done */
> +		memset(&cmdq->cancel, 0, sizeof(cmdq->cancel));
> +		cmdq_sec_task_submit(cmdq, cur_task, CMD_CMDQ_IWC_CANCEL_TASK,
> +				     thread->idx, &cmdq->cancel);
> +
> +		cmdq_sec_task_done(task, err);
> +
> +		spin_lock_irqsave(&thread->chan->lock, flags);
> +
> +		task = list_first_entry_or_null(&thread->task_list,
> +						struct cmdq_sec_task, list_entry);
> +		if (cur_task == task)
> +			cmdq_sec_task_done(cur_task, err);
> +		else
> +			pr_err("task list changed");
> +
> +		/*
> +		 * error case stop all task for secure,
> +		 * since secure tdrv always remove all when cancel
> +		 */
> +		while (!list_empty(&thread->task_list)) {
> +			cur_task = list_first_entry(&thread->task_list,
> +						    struct cmdq_sec_task, list_entry);
> +
> +			cmdq_sec_task_done(cur_task, -ECONNABORTED);
> +		}
> +	} else if (err) {
> +		pr_debug("error but all task done, check notify callback");
> +	}
> +
> +	if (list_empty(&thread->task_list)) {
> +		thread->wait_cookie = 0;
> +		thread->next_cookie = 0;
> +		thread->task_cnt = 0;
> +		__raw_writel(0, (void __iomem *)cmdq->shared_mem->va +
> +			     CMDQ_SEC_SHARED_THR_CNT_OFFSET +
> +			     thread->idx * sizeof(u32));
> +		spin_unlock_irqrestore(&thread->chan->lock, flags);
> +		del_timer(&thread->timeout);
> +		return true;
> +	}
> +
> +	thread->wait_cookie = cookie % CMDQ_MAX_COOKIE_VALUE + 1;
> +
> +	mod_timer(&thread->timeout, jiffies + msecs_to_jiffies(thread->timeout_ms));
> +	spin_unlock_irqrestore(&thread->chan->lock, flags);
> +
> +	return false;
> +}
> +
> +static void cmdq_sec_irq_notify_work(struct work_struct *work_item)
> +{
> +	struct cmdq_sec *cmdq = container_of(work_item, struct cmdq_sec, irq_notify_work);
> +	int i;
> +
> +	mutex_lock(&cmdq->exec_lock);
> +
> +	for (i = 0; i < CMDQ_MAX_SECURE_THREAD_COUNT; i++) {
> +		struct cmdq_sec_thread *thread = &cmdq->thread[CMDQ_MIN_SECURE_THREAD_ID + i];
> +		u32 cookie = cmdq_sec_get_cookie(cmdq, thread->idx);
> +
> +		if (cookie < thread->wait_cookie || !thread->task_cnt)
> +			continue;
> +
> +		cmdq_sec_irq_handler(thread, cookie, 0);
> +	}
> +
> +	mutex_unlock(&cmdq->exec_lock);
> +}
> +
> +static void cmdq_sec_irq_notify_callback(struct mbox_client *cl, void *mssg)
> +{
> +	struct cmdq_cb_data *data = (struct cmdq_cb_data *)mssg;
> +	struct cmdq_sec *cmdq = container_of(((struct cmdq_client *)data->pkt->cl)->chan->mbox,
> +					     struct cmdq_sec, mbox);
> +

	if (work_pending...) {
		dev_dbg
		return;
	}

	queue_work

> +	if (!work_pending(&cmdq->irq_notify_work))
> +		queue_work(cmdq->notify_wq, &cmdq->irq_notify_work);
> +	else
> +		pr_debug("%s last notify callback working", __func__);
> +}
> +
> +static int cmdq_sec_irq_notify_start(struct cmdq_sec *cmdq)
> +{
> +	int err;
> +
> +	if (cmdq->notify_run)
> +		return 0;
> +
> +	if (!cmdq->clt_pkt) {
> +		cmdq->clt = cmdq_mbox_create(cmdq->mbox.dev, 0);
> +		if (!cmdq->clt || IS_ERR(cmdq->clt)) {
> +			pr_err("clt mbox_create failed clt:%p index:%d",
> +			       cmdq->clt, CMDQ_SEC_IRQ_THREAD);
> +			return -EINVAL;
> +		}
> +		cmdq->clt->client.rx_callback = cmdq_sec_irq_notify_callback;
> +
> +		cmdq->clt_pkt = cmdq_pkt_create(cmdq->clt, CMDQ_BUF_ALLOC_SIZE);
> +		if (!cmdq->clt_pkt || IS_ERR(cmdq->clt_pkt)) {
> +			pr_err("clt_pkt cmdq_pkt_create failed pkt:%p index:%d",
> +			       cmdq->clt_pkt, CMDQ_SEC_IRQ_THREAD);
> +			return -EINVAL;
> +		}
> +
> +		INIT_WORK(&cmdq->irq_notify_work, cmdq_sec_irq_notify_work);
> +	}
> +
> +	cmdq_pkt_wfe(cmdq->clt_pkt, cmdq->cmdq_event, true);
> +	cmdq_pkt_finalize_loop(cmdq->clt_pkt);
> +	dma_sync_single_for_device(cmdq->mbox.dev,
> +				   cmdq->clt_pkt->pa_base,
> +				   cmdq->clt_pkt->cmd_buf_size,
> +				   DMA_TO_DEVICE);
> +	err = mbox_send_message(cmdq->clt->chan, cmdq->clt_pkt);
> +	mbox_client_txdone(cmdq->clt->chan, 0);
> +	if (err < 0) {
> +		pr_err("%s failed:%d", __func__, err);
> +		cmdq_pkt_destroy(cmdq->clt_pkt);
> +		cmdq_mbox_destroy(cmdq->clt);

		return err;
	}
	cmdq->notify_run = true;

> +	} else {
> +		cmdq->notify_run = true;
> +		pr_debug("%s success!", __func__);
> +	}
> +
> +	return err;

return 0 here

> +}
> +
> +static int cmdq_sec_session_init(struct cmdq_sec_context *context)
> +{
> +	int err = 0;
> +
> +	if (context->state >= IWC_SES_OPENED) {
> +		pr_debug("session opened:%u", context->state);
> +		return err;

		return 0;

> +	}
> +
> +	switch (context->state) {
> +	case IWC_INIT:
> +		err = cmdq_sec_init_context_base(context);
> +		if (err)
		if (err)
			return err;

> +			break;
> +		context->state = IWC_CONTEXT_INITED;
> +	fallthrough;
> +	case IWC_CONTEXT_INITED:
> +		if (context->iwc_msg) {
> +			pr_err("iwcMessage not NULL:%p", context->iwc_msg);
> +			err = -EINVAL;

return -EINVAL;

> +			break;
> +		}
> +
> +		err = cmdq_sec_allocate_wsm(&context->tee, &context->iwc_msg,
> +					    sizeof(struct iwcCmdqMessage_t));
> +		if (err)
> +			break;

return err

> +
> +		context->state = IWC_WSM_ALLOCATED;
> +	fallthrough;
> +	case IWC_WSM_ALLOCATED:
> +		err = cmdq_sec_open_session(&context->tee, context->iwc_msg);
> +		if (err)
> +			break;

return err

> +
> +		context->state = IWC_SES_OPENED;
> +	fallthrough;
> +	default:
> +		break;
> +	}

	return 0;

> +	return err;
> +}
> +
> +static int cmdq_sec_fill_iwc_msg(struct cmdq_sec_context *context,
> +				 struct cmdq_sec_task *task, u32 thrd_idx)
> +{
> +	struct iwcCmdqMessage_t *iwc_msg = NULL;
> +	struct cmdq_sec_data *data = (struct cmdq_sec_data *)task->pkt->sec_data;
> +	u32 size = 0, offset = 0, *instr;
> +
> +	iwc_msg = (struct iwcCmdqMessage_t *)context->iwc_msg;
> +
> +	if (task->pkt->cmd_buf_size + 4 * CMDQ_INST_SIZE > CMDQ_TZ_CMD_BLOCK_SIZE) {
> +		pr_err("task:%p size:%zu > %u",
> +		       task, task->pkt->cmd_buf_size, CMDQ_TZ_CMD_BLOCK_SIZE);
> +		return -EFAULT;
> +	}
> +
> +	if (thrd_idx == CMDQ_INVALID_THREAD) {
> +		iwc_msg->command.commandSize = 0;
> +		iwc_msg->command.metadata.addrListLength = 0;
> +		return 0;

if invalid thread, return 0?! Are you sure?!

> +	}
> +

	if (iwc_msg->command.size == 0 && task->pkt->cmd_buf_size == 0) {
		dev_dbg(...... command size is zero)

		return (something);
	}

> +	iwc_msg->command.thread = thrd_idx;
> +	iwc_msg->command.scenario = task->scenario;
> +	iwc_msg->command.engineFlag = task->engineFlag;
> +	size = task->pkt->cmd_buf_size;
> +	memcpy(iwc_msg->command.pVABase + offset, task->pkt->va_base, size);
> +	iwc_msg->command.commandSize += size;
> +	offset += size / 4;
> +
> +	if (iwc_msg->command.commandSize == 0) {
> +		pr_err("%s %d: commandSize is 0\n", __func__, __LINE__);

So this being zero is valid? Again, are you sure?

> +		return 0;
> +	}
> +
> +	instr = &iwc_msg->command.pVABase[iwc_msg->command.commandSize / 4 - 4];
> +	if (instr[0] == 0x1 && instr[1] == 0x40000000)

Please define this, I guess that instr[] is a 64-bits instruction, is it?

So this could be... #define SOMETHING 0x140000000ULL
...but however you choose to define it is fine, just .. define it please :-)

> +		instr[0] = 0;
> +	else
> +		pr_err("%s %d: find EOC failed: %#x %#x",
> +		       __func__, __LINE__, instr[1], instr[0]);
> +
> +	iwc_msg->command.waitCookie = task->waitCookie;
> +	iwc_msg->command.resetExecCnt = task->resetExecCnt;
> +
> +	if (data->addrMetadataCount) {
> +		iwc_msg->command.metadata.addrListLength = data->addrMetadataCount;
> +		memcpy(iwc_msg->command.metadata.addrList,
> +		       (u32 *)(unsigned long)data->addrMetadatas,
> +		       data->addrMetadataCount * sizeof(struct iwcCmdqAddrMetadata_t));
> +	}
> +
> +	iwc_msg->command.metadata.enginesNeedDAPC = data->enginesNeedDAPC;
> +	iwc_msg->command.metadata.enginesNeedPortSecurity =
> +		data->enginesNeedPortSecurity;
> +	iwc_msg->command.hNormalTask = (unsigned long)task->pkt;
> +
> +	return 0;
> +}
> +
> +static int cmdq_sec_session_send(struct cmdq_sec_context *context,
> +				 struct cmdq_sec_task *task, const u32 iwc_cmd,
> +				 const u32 thrd_idx, struct cmdq_sec *cmdq)
> +{
> +	int err = 0;
> +	u64 cost;
> +	struct iwcCmdqMessage_t *iwc_msg = NULL;
> +
> +	iwc_msg = (struct iwcCmdqMessage_t *)context->iwc_msg;
> +
> +	memset(iwc_msg, 0, sizeof(*iwc_msg));
> +	iwc_msg->cmd = iwc_cmd;
> +	iwc_msg->cmdq_id = cmdq->hwid;
> +	iwc_msg->command.thread = thrd_idx;
> +
> +	switch (iwc_cmd) {
> +	case CMD_CMDQ_IWC_SUBMIT_TASK:
> +		err = cmdq_sec_fill_iwc_msg(context, task, thrd_idx);
> +		if (err)
> +			return err;
> +		break;
> +	case CMD_CMDQ_IWC_CANCEL_TASK:
> +		iwc_msg->cancelTask.waitCookie = task->waitCookie;
> +		iwc_msg->cancelTask.thread = thrd_idx;
> +		break;
> +	case CMD_CMDQ_IWC_PATH_RES_ALLOCATE:
> +		if (!cmdq->shared_mem || !cmdq->shared_mem->va) {
> +			pr_err("%s %d: shared_mem is NULL", __func__, __LINE__);
> +			return -EFAULT;
> +		}
> +		iwc_msg->pathResource.size = cmdq->shared_mem->size;
> +		iwc_msg->pathResource.shareMemoyPA = cmdq->shared_mem->pa;
> +		iwc_msg->pathResource.useNormalIRQ = 1;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	cmdq->sec_invoke = sched_clock();
> +	pr_debug("%s execute cmdq:%p task:%lx command:%u thread:%u cookie:%d",
> +		 __func__, cmdq, (unsigned long)task, iwc_cmd, thrd_idx,
> +		 task ? task->waitCookie : -1);
> +
> +	/* send message */
> +	err = cmdq_sec_execute_session(&context->tee, iwc_cmd, CMDQ_TIMEOUT_DEFAULT);
> +
> +	cmdq->sec_done = sched_clock();
> +	cost = div_u64(cmdq->sec_done - cmdq->sec_invoke, 1000000);
> +	if (cost >= CMDQ_TIMEOUT_DEFAULT)
> +		pr_err("%s execute timeout cmdq:%p task:%lx cost:%lluus",
> +		       __func__, cmdq, (unsigned long)task, cost);
> +	else
> +		pr_debug("%s execute done cmdq:%p task:%lx cost:%lluus",
> +			 __func__, cmdq, (unsigned long)task, cost);
> +

	if (err)
		return err;

	context->state = IWC_SES_ON_TRANSACTED;
	return 0;

> +	if (err == 0)
> +		context->state = IWC_SES_ON_TRANSACTED;
> +
> +	return err;
> +}
> +
> +static int cmdq_sec_session_reply(const u32 iwc_cmd, struct iwcCmdqMessage_t *iwc_msg,
> +				  void *data, struct cmdq_sec_task *task)
> +{
> +	struct iwcCmdqCancelTask_t *cancel = data;
> +	struct cmdq_sec_data *sec_data = task->pkt->sec_data;
> +
> +	if (iwc_cmd == CMD_CMDQ_IWC_SUBMIT_TASK) {

	if (iwc_cmd == CMD_CMDQ_IWC_SUBMIT_TASK && iwc_msg->rsp < 0) {
		....
	} else if (...) {
		....
	}

	return ...

> +		if (iwc_msg->rsp < 0) {
> +			/* submit fail case copy status */
> +			memcpy(&sec_data->sec_status, &iwc_msg->secStatus,
> +			       sizeof(sec_data->sec_status));
> +			sec_data->response = iwc_msg->rsp;
> +		}
> +	} else if (iwc_cmd == CMD_CMDQ_IWC_CANCEL_TASK && cancel) {
> +		/* cancel case only copy cancel result */
> +		memcpy(cancel, &iwc_msg->cancelTask, sizeof(*cancel));
> +	}
> +
> +	return iwc_msg->rsp;
> +}
> +
> +static int cmdq_sec_task_submit(struct cmdq_sec *cmdq, struct cmdq_sec_task *task,
> +				const u32 iwc_cmd, const u32 thrd_idx, void *data)
> +{
> +	struct cmdq_sec_context *context;
> +	int err;
> +
> +	do {
> +		if (!cmdq->context) {
> +			context = kzalloc(sizeof(*cmdq->context), GFP_ATOMIC);
> +			if (!context) {
> +				err = -ENOMEM;
> +				break;
> +			}
> +			cmdq->context = context;
> +			cmdq->context->state = IWC_INIT;
> +			cmdq->context->tgid = current->tgid;
> +		}
> +
> +		if (cmdq->context->state == IWC_INIT)
> +			cmdq_sec_setup_tee_context_base(cmdq->context);
> +
> +		err = cmdq_sec_session_init(cmdq->context);
> +		if (err) {
> +			pr_err("%s %d: cmdq_sec_session_init fail", __func__, __LINE__);
> +			break;
> +		}
> +
> +		err = cmdq_sec_irq_notify_start(cmdq);
> +		if (err < 0) {
> +			pr_err("%s %d: cmdq_sec_irq_notify_start fail", __func__, __LINE__);
> +			break;
> +		}
> +
> +		err = cmdq_sec_session_send(cmdq->context, task, iwc_cmd, thrd_idx, cmdq);
> +		if (err)
> +			pr_err("%s %d: cmdq_sec_session_send fail: %d\n", __func__, __LINE__, err);
> +		else
> +			err = cmdq_sec_session_reply(iwc_cmd, cmdq->context->iwc_msg, data, task);
> +	} while (0);

Seriously? do { ... } while(0) ?!?!?!

No!!!!

> +
> +	if (err)
> +		pr_err("%s %d: sec invoke err:%d task:%p thread:%u gce:%#lx",
> +		       __func__, __LINE__, err, task, thrd_idx, (unsigned long)cmdq->base_pa);
> +
> +	return err;
> +}
> +
> +static int cmdq_sec_suspend(struct device *dev)
> +{
> +	struct cmdq_sec *cmdq = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(cmdq->gce_num, cmdq->clocks);
> +	return 0;
> +}
> +
> +static int cmdq_sec_resume(struct device *dev)
> +{
> +	struct cmdq_sec *cmdq = dev_get_drvdata(dev);
> +
> +	WARN_ON(clk_bulk_prepare_enable(cmdq->gce_num, cmdq->clocks));
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cmdq_sec_pm_ops = {
> +	.suspend = cmdq_sec_suspend,
> +	.resume = cmdq_sec_resume,
> +};
> +
> +static void cmdq_sec_task_exec_work(struct work_struct *work_item)
> +{
> +	struct cmdq_sec_task *task = container_of(work_item, struct cmdq_sec_task, exec_work);
> +	struct cmdq_sec *cmdq = container_of(task->thread->chan->mbox, struct cmdq_sec, mbox);
> +	struct cmdq_sec_data *data;
> +	unsigned long flags;
> +	int err;
> +
> +	pr_debug("%s gce:%#lx task:%p pkt:%p thread:%u",
> +		 __func__, (unsigned long)cmdq->base_pa, task, task->pkt, task->thread->idx);
> +
> +	if (!task->pkt->sec_data) {
> +		pr_err("pkt:%p without sec_data", task->pkt);
> +		return;
> +	}
> +	data = (struct cmdq_sec_data *)task->pkt->sec_data;
> +
> +	mutex_lock(&cmdq->exec_lock);
> +
> +	spin_lock_irqsave(&task->thread->chan->lock, flags);
> +	if (!task->thread->task_cnt) {
> +		mod_timer(&task->thread->timeout, jiffies +
> +			msecs_to_jiffies(task->thread->timeout_ms));
> +		task->thread->wait_cookie = 1;
> +		task->thread->next_cookie = 1;
> +		task->thread->task_cnt = 0;
> +		__raw_writel(0, (void __iomem *)cmdq->shared_mem->va +
> +			     CMDQ_SEC_SHARED_THR_CNT_OFFSET +
> +			     task->thread->idx * sizeof(u32));
> +	}
> +
> +	task->resetExecCnt = task->thread->task_cnt ? false : true;
> +	task->waitCookie = task->thread->next_cookie;
> +	task->thread->next_cookie = (task->thread->next_cookie + 1) % CMDQ_MAX_COOKIE_VALUE;
> +	list_add_tail(&task->list_entry, &task->thread->task_list);
> +	task->thread->task_cnt += 1;
> +	spin_unlock_irqrestore(&task->thread->chan->lock, flags);
> +	task->trigger = sched_clock();
> +
> +	if (!atomic_cmpxchg(&cmdq_path_res, 0, 1)) {
> +		err = cmdq_sec_task_submit(cmdq, NULL, CMD_CMDQ_IWC_PATH_RES_ALLOCATE,
> +					   CMDQ_INVALID_THREAD, NULL);
> +		if (err) {
> +			atomic_set(&cmdq_path_res, 0);
> +			goto task_err_callback;
> +		}
> +	}
> +
> +	if (task->thread->task_cnt > CMDQ_MAX_TASK_IN_SECURE_THREAD) {
> +		pr_err("task_cnt:%u cannot more than %u task:%p thrd-idx:%u",
> +		       task->thread->task_cnt, CMDQ_MAX_TASK_IN_SECURE_THREAD,
> +		       task, task->thread->idx);
> +		err = -EMSGSIZE;
> +		goto task_err_callback;
> +	}
> +
> +	err = cmdq_sec_task_submit(cmdq, task, CMD_CMDQ_IWC_SUBMIT_TASK, task->thread->idx, NULL);
> +	if (err)
> +		pr_err("task submit CMD_CMDQ_IWC_SUBMIT_TASK failed:%d gce:%#lx task:%p thread:%u",
> +		       err, (unsigned long)cmdq->base_pa, task, task->thread->idx);
> +
> +task_err_callback:

end:

> +	if (err) {
> +		struct cmdq_cb_data cb_data;
> +
> +		cb_data.sta = err;
> +		cb_data.pkt = task->pkt;
> +		mbox_chan_received_data(task->thread->chan, &cb_data);
> +
> +		spin_lock_irqsave(&task->thread->chan->lock, flags);
> +		if (!task->thread->task_cnt)
> +			pr_err("thread:%u task_cnt:%u cannot below zero",
> +			       task->thread->idx, task->thread->task_cnt);
> +		else
> +			task->thread->task_cnt -= 1;
> +
> +		task->thread->next_cookie = (task->thread->next_cookie - 1 +
> +			CMDQ_MAX_COOKIE_VALUE) % CMDQ_MAX_COOKIE_VALUE;
> +		list_del(&task->list_entry);
> +		pr_debug("gce:%#lx err:%d task:%p pkt:%p thread:%u task_cnt:%u wait_cookie:%u next_cookie:%u",
> +			 (unsigned long)cmdq->base_pa, err, task, task->pkt,
> +			 task->thread->idx, task->thread->task_cnt,
> +			 task->thread->wait_cookie, task->thread->next_cookie);
> +		spin_unlock_irqrestore(&task->thread->chan->lock, flags);
> +		kfree(task);
> +	}
> +	mutex_unlock(&cmdq->exec_lock);
> +}
> +
> +static int cmdq_sec_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data;
> +	struct cmdq_sec_data *sec_data = (struct cmdq_sec_data *)pkt->sec_data;
> +	struct cmdq_sec_thread *thread = (struct cmdq_sec_thread *)chan->con_priv;
> +	struct cmdq_sec_task *task;
> +
> +	if (!sec_data)
> +		return -EINVAL;
> +
> +	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> +	if (!task)
> +		return -ENOMEM;
> +
> +	task->pkt = pkt;
> +	task->thread = thread;
> +	task->scenario = sec_data->scenario;
> +	task->engineFlag = sec_data->enginesNeedDAPC | sec_data->enginesNeedPortSecurity;
> +
> +	INIT_WORK(&task->exec_work, cmdq_sec_task_exec_work);
> +	queue_work(thread->task_exec_wq, &task->exec_work);
> +	return 0;
> +}
> +
> +static void cmdq_sec_thread_timeout(struct timer_list *t)
> +{
> +	struct cmdq_sec_thread *thread = from_timer(thread, t, timeout);
> +	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
> +
> +	if (!work_pending(&thread->timeout_work))
> +		queue_work(cmdq->timeout_wq, &thread->timeout_work);
> +}
> +
> +static void cmdq_sec_task_timeout_work(struct work_struct *work_item)
> +{
> +	struct cmdq_sec_thread *thread = container_of(work_item, struct cmdq_sec_thread,
> +						      timeout_work);
> +	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
> +	struct cmdq_sec_task *task;
> +	unsigned long flags;
> +	u64 duration;
> +	u32 cookie;
> +
> +	mutex_lock(&cmdq->exec_lock);
> +
> +	spin_lock_irqsave(&thread->chan->lock, flags);
> +	if (list_empty(&thread->task_list)) {
> +		pr_err("thread:%u task_list is empty", thread->idx);
> +		spin_unlock_irqrestore(&thread->chan->lock, flags);
> +		goto done;
> +	}
> +
> +	task = list_first_entry(&thread->task_list, struct cmdq_sec_task, list_entry);
> +	duration = div_u64(sched_clock() - task->trigger, 1000000);
> +	if (duration < thread->timeout_ms) {
> +		mod_timer(&thread->timeout, jiffies +
> +			  msecs_to_jiffies(thread->timeout_ms - duration));
> +		spin_unlock_irqrestore(&thread->chan->lock, flags);
> +		goto done;
> +	}
> +
> +	cookie = cmdq_sec_get_cookie(cmdq, thread->idx);
> +	spin_unlock_irqrestore(&thread->chan->lock, flags);
> +
> +	pr_err("%s duration:%llu cookie:%u thread:%u",
> +	       __func__, duration, cookie, thread->idx);
> +	cmdq_sec_irq_handler(thread, cookie, -ETIMEDOUT);
> +
> +done:
> +	mutex_unlock(&cmdq->exec_lock);
> +}
> +
> +static int cmdq_sec_mbox_startup(struct mbox_chan *chan)
> +{
> +	struct cmdq_sec_thread *thread = (struct cmdq_sec_thread *)chan->con_priv;
> +	char name[20];
> +
> +	timer_setup(&thread->timeout, cmdq_sec_thread_timeout, 0);
> +
> +	INIT_WORK(&thread->timeout_work, cmdq_sec_task_timeout_work);
> +	snprintf(name, sizeof(name), "task_exec_wq_%u", thread->idx);
> +	thread->task_exec_wq = create_singlethread_workqueue(name);
> +	thread->occupied = true;
> +	return 0;
> +}
> +
> +static void cmdq_sec_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct cmdq_sec_thread *thread = (struct cmdq_sec_thread *)chan->con_priv;
> +
> +	thread->occupied = false;
> +}
> +
> +static int cmdq_sec_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
> +{
> +	struct cmdq_sec_thread *thread = (struct cmdq_sec_thread *)chan->con_priv;
> +	struct cmdq_sec *cmdq = container_of(thread->chan->mbox, struct cmdq_sec, mbox);
> +	int i;
> +
> +	mutex_lock(&cmdq->exec_lock);
> +
> +	if (list_empty(&thread->task_list))

if (list_empty..) {
	mutex_unlock(...)
	return 0;
}

> +		goto out;
> +
> +	for (i = 0; i < CMDQ_MAX_SECURE_THREAD_COUNT; i++) {
> +		struct cmdq_sec_thread *thread = &cmdq->thread[CMDQ_MIN_SECURE_THREAD_ID + i];
> +		u32 cookie = cmdq_sec_get_cookie(cmdq, thread->idx);
> +
> +		if (cookie < thread->wait_cookie || !thread->task_cnt)
> +			continue;
> +
> +		cmdq_sec_irq_handler(thread, cookie, -ECONNABORTED);
> +	}
> +
> +out:
> +	mutex_unlock(&cmdq->exec_lock);
> +	return 0;
> +}
> +
> +static bool cmdq_sec_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	return true;

Noupe. This is a hack.

You want to do some check here to return if the last TX is done, you can't
just return true and call it a day.

> +}
> +
> +static const struct mbox_chan_ops cmdq_sec_mbox_chan_ops = {
> +	.send_data = cmdq_sec_mbox_send_data,
> +	.startup = cmdq_sec_mbox_startup,
> +	.shutdown = cmdq_sec_mbox_shutdown,
> +	.flush = cmdq_sec_mbox_flush,
> +	.last_tx_done = cmdq_sec_mbox_last_tx_done,
> +};
> +
> +static struct mbox_chan *cmdq_sec_mbox_of_xlate(struct mbox_controller *mbox,
> +						const struct of_phandle_args *sp)
> +{
> +	struct cmdq_sec_thread *thread;
> +	int idx = sp->args[0];
> +
> +	if (mbox->num_chans <= idx) {
> +		pr_err("invalid thrd-idx:%u", idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	thread = (struct cmdq_sec_thread *)mbox->chans[idx].con_priv;
> +	thread->chan = &mbox->chans[idx];
> +	thread->timeout_ms = CMDQ_NO_TIMEOUT;
> +	thread->priority = sp->args[1];
> +
> +	return &mbox->chans[idx];
> +}
> +
> +static int cmdq_sec_probe(struct platform_device *pdev)
> +{
> +	int i, err;
> +	struct cmdq_sec *cmdq;
> +	struct cmdq_sec_plat *plat_data;
> +	struct device *dev = &pdev->dev;
> +
> +	plat_data = (struct cmdq_sec_plat *)pdev->dev.platform_data;
> +	if (!plat_data) {
> +		dev_err(dev, "no valid platform data!\n");
> +		return -EINVAL;
> +	}
> +
> +	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
> +	if (!cmdq)
> +		return -ENOMEM;
> +
> +	cmdq->base_pa = plat_data->base_pa;
> +	cmdq->base = plat_data->base;
> +	cmdq->thread_nr = plat_data->thread_nr;
> +	cmdq->gce_num = plat_data->gce_num;
> +	cmdq->clocks = devm_kcalloc(dev, cmdq->gce_num,
> +				    sizeof(struct clk_bulk_data), GFP_KERNEL);
> +	if (!cmdq->clocks)
> +		return -ENOMEM;
> +
> +	for (i = 0 ; i < cmdq->gce_num; i++)
> +		cmdq->clocks[i] = plat_data->clocks[i];
> +
> +	cmdq->hwid = plat_data->hwid;
> +	cmdq->cmdq_event = plat_data->cmdq_event;
> +
> +	cmdq->mbox.dev = plat_data->gce_dev;
> +	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
> +					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
> +	if (!cmdq->mbox.chans)
> +		return -ENOMEM;
> +
> +	cmdq->mbox.ops = &cmdq_sec_mbox_chan_ops;
> +	cmdq->mbox.num_chans = cmdq->thread_nr;
> +	cmdq->mbox.of_xlate = cmdq_sec_mbox_of_xlate;
> +
> +	/* make use of TXDONE_BY_ACK */
> +	cmdq->mbox.txdone_irq = false;
> +	cmdq->mbox.txdone_poll = false;
> +
> +	cmdq->thread = devm_kcalloc(dev, cmdq->thread_nr,
> +				    sizeof(*cmdq->thread), GFP_KERNEL);
> +	if (!cmdq->thread)
> +		return -ENOMEM;
> +
> +	mutex_init(&cmdq->exec_lock);
> +	for (i = 0; i < cmdq->thread_nr; i++) {
> +		cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE + CMDQ_THR_SIZE * i;
> +		INIT_LIST_HEAD(&cmdq->thread[i].task_list);
> +		cmdq->thread[i].idx = i;
> +		cmdq->thread[i].occupied = false;
> +		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
> +	}
> +
> +	cmdq->notify_wq = create_singlethread_workqueue("mtk_cmdq_sec_notify_wq");
> +	cmdq->timeout_wq = create_singlethread_workqueue("mtk_cmdq_sec_timeout_wq");
> +	err = devm_mbox_controller_register(dev, &cmdq->mbox);
> +	if (err)
> +		return err;
> +
> +	cmdq->shared_mem = devm_kzalloc(dev, sizeof(*cmdq->shared_mem), GFP_KERNEL);
> +	if (!cmdq->shared_mem)
> +		return -ENOMEM;
> +
> +	cmdq->shared_mem->va = dma_alloc_coherent(dev, PAGE_SIZE,
> +						  &cmdq->shared_mem->pa, GFP_KERNEL);
> +	cmdq->shared_mem->size = PAGE_SIZE;
> +
> +	platform_set_drvdata(pdev, cmdq);
> +	WARN_ON(clk_bulk_prepare_enable(cmdq->gce_num, cmdq->clocks));
> +
> +	return 0;
> +}
> +
> +static int cmdq_sec_remove(struct platform_device *pdev)
> +{
> +	struct cmdq_sec *cmdq = platform_get_drvdata(pdev);
> +
> +	if (cmdq->context)
> +		cmdq_sec_free_wsm(&cmdq->context->tee, &cmdq->context->iwc_msg);
> +
> +	mbox_controller_unregister(&cmdq->mbox);
> +
> +	clk_bulk_disable_unprepare(cmdq->gce_num, cmdq->clocks);
> +	return 0;
> +}
> +
> +static struct platform_driver cmdq_sec_drv = {
> +	.probe = cmdq_sec_probe,
> +	.remove = cmdq_sec_remove,
> +	.driver = {
> +		.name = "mtk_cmdq_sec",

"mtk-cmdq-secure"

> +		.pm = &cmdq_sec_pm_ops,
> +	},
> +};
> +
> +static int __init cmdq_sec_init(void)
> +{
> +	int err;
> +
> +	err = platform_driver_register(&cmdq_sec_drv);
> +	if (err)
> +		pr_err("platform_driver_register failed:%d", err);
> +	return err;
> +}
> +
> +arch_initcall(cmdq_sec_init);

Do you *really* need this to be an arch_initcall?! That's a bit early, and I don't
really see any reason for this.

> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mailbox/mtk-cmdq-sec-tee.c b/drivers/mailbox/mtk-cmdq-sec-tee.c
> new file mode 100644
> index 000000000000..e42e9dba343c
> --- /dev/null
> +++ b/drivers/mailbox/mtk-cmdq-sec-tee.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2019 MediaTek Inc.

// SPDX...
/*
  * Copyright..
  */


> +
> +#include <linux/math64.h>
> +#include <linux/sched/clock.h>
> +
> +#include <linux/mailbox/mtk-cmdq-sec-tee.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +/* lock to protect atomic secure task execution */
> +static DEFINE_MUTEX(cmdq_sec_exec_lock);
> +
> +static void cmdq_sec_lock_secure_path(void)
> +{
> +	mutex_lock(&cmdq_sec_exec_lock);
> +	smp_mb();	/*memory barrier*/

I'm sure that you don't need a memory barrier after locking this mutex.

Besides, you don't need this function at all: just call mutex_lock and mutex_unlock
where appropriate.

> +}
> +
> +static void cmdq_sec_unlock_secure_path(void)
> +{
> +	mutex_unlock(&cmdq_sec_exec_lock);
> +}
> +
> +void cmdq_sec_setup_tee_context(struct cmdq_sec_tee_context *tee)
> +{
> +	/* 09010000 0000 0000 0000000000000000 */
> +	memset(tee->uuid, 0, sizeof(tee->uuid));
> +	tee->uuid[0] = 0x9;
> +	tee->uuid[1] = 0x1;
> +}
> +EXPORT_SYMBOL(cmdq_sec_setup_tee_context);
> +
> +#if IS_ENABLED(CONFIG_TEE)

Can this driver really work if CONFIG_TEE=n ?!

I guess it wouldn't, so this is not right at all. The solution is to depend on
CONFIG_TEE to *even compile* this driver....

> +static int tee_dev_match(struct tee_ioctl_version_data *t, const void *v)
> +{
> +#if IS_ENABLED(CONFIG_OPTEE)
> +	if (t->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +#endif
> +	return 0;
> +}
> +#endif
> +

..snip..

> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index fdda995a69ce..997a75c529fb 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -7,6 +7,7 @@
>   #ifndef __MTK_CMDQ_MAILBOX_H__
>   #define __MTK_CMDQ_MAILBOX_H__
>   
> +#include <linux/mailbox_controller.h>

Why are you adding this header?

No implicit inclusions in drivers please.

>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> @@ -77,6 +78,7 @@ struct cmdq_pkt {
>   	size_t			buf_size; /* real buffer size */
>   	void			*cl;
>   	bool			loop;
> +	void			*sec_data;
>   };
>   
>   struct cmdq_sec_plat {
> diff --git a/include/linux/mailbox/mtk-cmdq-sec-iwc-common.h b/include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
> new file mode 100644
> index 000000000000..addc515df279
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-cmdq-sec-iwc-common.h
> @@ -0,0 +1,293 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#ifndef __CMDQ_SEC_IWC_COMMON_H__
> +#define __CMDQ_SEC_IWC_COMMON_H__
> +
> +/*
> + * shared DRAM
> + * bit x = 1 means thread x raise IRQ
> + */
> +#define CMDQ_SEC_SHARED_IRQ_RAISED_OFFSET	0
> +#define CMDQ_SEC_SHARED_THR_CNT_OFFSET		0x100
> +#define CMDQ_SEC_SHARED_TASK_VA_OFFSET		0x200
> +#define CMDQ_SEC_SHARED_OP_OFFSET		0x300
> +#define CMDQ_SEC_SHARED_SUSPEND_CNT		0x304
> +#define CMDQ_SEC_SHARED_RESET_CNT		0x308
> +
> +/* commanad buffer & metadata */
> +#define CMDQ_TZ_CMD_BLOCK_SIZE		(20 << 12) /* MDP readback may request 20 pages */
> +#define CMDQ_IWC_MAX_CMD_LENGTH		(CMDQ_TZ_CMD_BLOCK_SIZE / 4)
> +
> +#define CMDQ_IWC_MAX_ADDR_LIST_LENGTH	(30)
> +
> +#define CMDQ_IWC_CLIENT_NAME		(16)
> +
> +#define CMDQ_SEC_MESSAGE_INST_LEN	(8)
> +#define CMDQ_SEC_DISPATCH_LEN		(8)
> +#define CMDQ_MAX_READBACK_ENG		(8)
> +
> +/*
> + * Command IDs for normal world(TLC or linux kernel) to secure world
> + */
> +/* submit current task */
> +#define CMD_CMDQ_IWC_SUBMIT_TASK	(1)
> +/* (not used)release resource in secure path per session */

If this is unused, it shouldn't be here at all.

Also, you don't need those parenthesis, remove.

> +#define CMD_CMDQ_IWC_RES_RELEASE	(2)
> +/* cancel current task */
> +#define CMD_CMDQ_IWC_CANCEL_TASK	(3)
> +/* create global resource for secure path */
> +#define CMD_CMDQ_IWC_PATH_RES_ALLOCATE	(4)
> +/* destroy globacl resource for secure path */
> +#define CMD_CMDQ_IWC_PATH_RES_RELEASE	(5)
> +
> +/*
> + * ERROR code number (ERRNO)
> + * note the error result returns negative value, i.e, -(ERRNO)
> + */
> +#define CMDQ_ERR_NOMEM					(12) /* out of memory */
> +#define CMDQ_ERR_FAULT					(14) /* bad address */
> +
> +#define CMDQ_ERR_ADDR_CONVERT_HANDLE_2_PA		(1000)
> +#define CMDQ_ERR_ADDR_CONVERT_ALLOC_MVA			(1100)
> +#define CMDQ_ERR_ADDR_CONVERT_ALLOC_MVA_N2S		(1101)
> +#define CMDQ_ERR_ADDR_CONVERT_FREE_MVA			(1200)
> +#define CMDQ_ERR_PORT_CONFIG				(1300)
> +
> +/* param check */
> +#define CMDQ_ERR_UNKNOWN_ADDR_METADATA_TYPE		(1400)
> +#define CMDQ_ERR_TOO_MANY_SEC_HANDLE			(1401)
> +/* security check */
> +#define CMDQ_ERR_SECURITY_INVALID_INSTR			(1500)
> +#define CMDQ_ERR_SECURITY_INVALID_SEC_HANDLE		(1501)
> +#define CMDQ_ERR_SECURITY_INVALID_DAPC_FALG		(1502)
> +#define CMDQ_ERR_INSERT_DAPC_INSTR_FAILED		(1503)
> +#define CMDQ_ERR_INSERT_PORT_SECURITY_INSTR_FAILED	(1504)
> +#define CMDQ_ERR_INVALID_SECURITY_THREAD		(1505)
> +#define CMDQ_ERR_PATH_RESOURCE_NOT_READY		(1506)
> +#define CMDQ_ERR_NULL_TASK				(1507)
> +#define CMDQ_ERR_SECURITY_INVALID_SOP			(1508)
> +#define CMDQ_ERR_SECURITY_INVALID_SEC_PORT_FALG		(1511)
> +

Fully documented enumeration, but no kerneldoc? :-)

> +enum cmdq_iwc_addr_metadata_type {
> +	CMDQ_IWC_H_2_PA		= 0, /* sec handle to sec PA */
> +	CMDQ_IWC_H_2_MVA	= 1, /* sec handle to sec MVA */
> +	CMDQ_IWC_NMVA_2_MVA	= 2, /* map normal MVA to secure world */
> +	CMDQ_IWC_PH_2_MVA	= 3, /* protected handle to sec MVA */
> +};
> +
> +enum cmdq_sec_engine_enum {
> +	/* MDP */
> +	CMDQ_SEC_MDP_RDMA0		= 0,
> +	CMDQ_SEC_MDP_RDMA1		= 1,
> +	CMDQ_SEC_MDP_WDMA		= 2,
> +	CMDQ_SEC_MDP_RDMA2		= 3,
> +	CMDQ_SEC_MDP_RDMA3		= 4,
> +	CMDQ_SEC_MDP_WROT0		= 5,
> +	CMDQ_SEC_MDP_WROT1		= 6,
> +	CMDQ_SEC_MDP_WROT2		= 7,
> +	CMDQ_SEC_MDP_WROT3		= 8,
> +	CMDQ_SEC_MDP_HDR0		= 9,
> +	CMDQ_SEC_MDP_HDR1		= 10,
> +	CMDQ_SEC_MDP_HDR2		= 11,
> +	CMDQ_SEC_MDP_HDR3		= 12,
> +	CMDQ_SEC_MDP_AAL0		= 13,
> +	CMDQ_SEC_MDP_AAL1		= 14,
> +	CMDQ_SEC_MDP_AAL2		= 15,
> +	CMDQ_SEC_MDP_AAL3		= 16,
> +
> +	/* DISP (VDOSYS0) */
> +	CMDQ_SEC_DISP_RDMA0		= 17,
> +	CMDQ_SEC_DISP_RDMA1		= 18,
> +	CMDQ_SEC_DISP_WDMA0		= 19,
> +	CMDQ_SEC_DISP_WDMA1		= 20,
> +	CMDQ_SEC_DISP_OVL0		= 21,
> +	CMDQ_SEC_DISP_OVL1		= 22,
> +	CMDQ_SEC_DISP_OVL2		= 23,
> +	CMDQ_SEC_DISP_2L_OVL0		= 24,
> +	CMDQ_SEC_DISP_2L_OVL1		= 25,
> +	CMDQ_SEC_DISP_2L_OVL2		= 26,
> +
> +	/* DSIP (VDOSYS1) */
> +	CMDQ_SEC_VDO1_DISP_RDMA_L0	= 27,
> +	CMDQ_SEC_VDO1_DISP_RDMA_L1	= 28,
> +	CMDQ_SEC_VDO1_DISP_RDMA_L2	= 29,
> +	CMDQ_SEC_VDO1_DISP_RDMA_L3	= 30,
> +
> +	/* VENC */
> +	CMDQ_SEC_VENC_BSDMA		= 31,
> +	CMDQ_SEC_VENC_CUR_LUMA		= 32,
> +	CMDQ_SEC_VENC_CUR_CHROMA	= 33,
> +	CMDQ_SEC_VENC_REF_LUMA		= 34,
> +	CMDQ_SEC_VENC_REF_CHROMA	= 35,
> +	CMDQ_SEC_VENC_REC		= 36,
> +	CMDQ_SEC_VENC_SUB_R_LUMA	= 37,
> +	CMDQ_SEC_VENC_SUB_W_LUMA	= 38,
> +	CMDQ_SEC_VENC_SV_COMV		= 39,
> +	CMDQ_SEC_VENC_RD_COMV		= 40,
> +	CMDQ_SEC_VENC_NBM_RDMA		= 41,
> +	CMDQ_SEC_VENC_NBM_WDMA		= 42,
> +	CMDQ_SEC_VENC_NBM_RDMA_LITE	= 43,
> +	CMDQ_SEC_VENC_NBM_WDMA_LITE	= 44,
> +	CMDQ_SEC_VENC_FCS_NBM_RDMA	= 45,
> +	CMDQ_SEC_VENC_FCS_NBM_WDMA	= 46,
> +
> +	CMDQ_SEC_MAX_ENG_COUNT		/* keep in the end */
> +};
> +
> +/*
> + * IWC message

kerneldoc please

> + */
> +struct iwcCmdqAddrMetadata_t {
...and no camelcase.

> +	/*
> +	 * [IN] index of instruction
> +	 * Update its arg_b value to real PA/MVA in secure world
> +	 */
> +	u32 instrIndex;
> +


..snip..

> diff --git a/include/linux/mailbox/mtk-cmdq-sec-mailbox.h b/include/linux/mailbox/mtk-cmdq-sec-mailbox.h
> new file mode 100644
> index 000000000000..17ee0ae646ab
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-cmdq-sec-mailbox.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_CMDQ_SEC_MAILBOX_H__
> +#define __MTK_CMDQ_SEC_MAILBOX_H__
> +
> +#include <linux/kernel.h>
> +
> +#include <linux/mailbox/mtk-cmdq-mailbox.h>
> +#include <linux/mailbox/mtk-cmdq-sec-iwc-common.h>
> +#include <linux/mailbox/mtk-cmdq-sec-tee.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#define CMDQ_INVALID_THREAD		(-1)
> +#define CMDQ_MAX_TASK_IN_SECURE_THREAD	(16)
> +#define CMDQ_SEC_IRQ_THREAD		(15)
> +
> +/* This define should sync with cmdq_sec_def.h in secure world */
> +#define CMDQ_MIN_SECURE_THREAD_ID	(8)

As you wrote, this shall be in sync with secure world, so this will either break
at the next SoC, or at the next secure world update.

This means that those definitions shall be in platform data for this driver.

> +#define CMDQ_MAX_SECURE_THREAD_ID	(10)
> +#define CMDQ_MAX_SECURE_THREAD_COUNT	(CMDQ_MAX_SECURE_THREAD_ID - CMDQ_MIN_SECURE_THREAD_ID)
> +
> +/* Max value of CMDQ_THR_EXEC_CMD_CNT (value starts from 0) */
> +#define CMDQ_MAX_COOKIE_VALUE           (0xffff)
> +
> +enum cmdq_sec_scenario {
> +	CMDQ_SEC_PRIMARY_DISP		= 1,
> +	CMDQ_SEC_SUB_DISP		= 4,
> +	CMDQ_SEC_PRIMARY_DISP_DISABLE	= 18,
> +	CMDQ_SEC_SUB_DISP_DISABLE	= 19,
> +
> +	CMDQ_MAX_SEC_COUNT	/* keep in the end */
> +};
> +
> +/* Inter-world communication state */
> +enum cmdq_iwc_state_enum {
> +	IWC_INIT,
> +	IWC_CONTEXT_INITED,
> +	IWC_WSM_ALLOCATED,
> +	IWC_SES_OPENED,
> +	IWC_SES_ON_TRANSACTED,
> +
> +	IWC_STATE_END_OF_ENUM,

Usually "END_OF_ENUM" is "MAX", so rename this to IWC_STATE_MAX

> +};
> +
> +/*

kerneldoc please.

> + * Address metadata, used to translate secure buffer PA
> + * related instruction in secure world.
> + */
> +struct cmdq_sec_data {
> +	u32 addrMetadataCount;	/* [IN] count of element in addrList */
> +	u64 addrMetadatas;		/* [IN] array of iwcCmdqAddrMetadata_t */
> +	u32 addrMetadataMaxCount;	/* [Reserved] */
> +
> +	enum cmdq_sec_scenario scenario;
> +
> +	u64 enginesNeedDAPC;
> +	u64 enginesNeedPortSecurity;
> +
> +	/*
> +	 * [Reserved]
> +	 * This is task index in thread's tasklist for CMDQ driver usage.
> +	 * Not for client. -1 means not in tasklist.
> +	 */
> +	s32 waitCookie;
> +	/* [Reserved] reset HW thread in secure world */
> +	bool resetExecCnt;
> +
> +	/* [OUT] response */
> +	s32 response;
> +	struct iwcCmdqSecStatus_t sec_status;
> +};
> +

Please document all those functions that you're exporting with kerneldoc.

> +int cmdq_sec_insert_backup_cookie(struct cmdq_pkt *pkt);
> +int cmdq_sec_pkt_set_data(struct cmdq_pkt *pkt, const u64 dapc_engine,
> +			  const u64 port_sec_engine, const enum cmdq_sec_scenario scenario);
> +int cmdq_sec_pkt_write(struct cmdq_pkt *pkt, u32 addr, u64 base,
> +		       const enum cmdq_iwc_addr_metadata_type type,
> +		       const u32 offset, const u32 size, const u32 port);
> +
> +#endif /* __MTK_CMDQ_SEC_MAILBOX_H__ */
> diff --git a/include/linux/mailbox/mtk-cmdq-sec-tee.h b/include/linux/mailbox/mtk-cmdq-sec-tee.h
> new file mode 100644
> index 000000000000..77090921cdf6
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-cmdq-sec-tee.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_CMDQ_SEC_TEE_H__
> +#define __MTK_CMDQ_SEC_TEE_H__
> +
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/tee_drv.h>
> +
> +/* context for tee vendor */

kerneldoc please.

> +struct cmdq_sec_tee_context {
> +	/* Universally Unique Identifier of secure world */
> +	u8			uuid[TEE_IOCTL_UUID_LEN];
> +	struct tee_context	*tee_context; /* basic context */
> +	u32			session; /* session handle */
> +	struct tee_shm		*shared_mem; /* shared memory */
> +};
> +

Also here, please document those functions.

> +void cmdq_sec_setup_tee_context(struct cmdq_sec_tee_context *tee);
> +int cmdq_sec_init_context(struct cmdq_sec_tee_context *tee);
> +int cmdq_sec_deinit_context(struct cmdq_sec_tee_context *tee);
> +int cmdq_sec_allocate_wsm(struct cmdq_sec_tee_context *tee, void **wsm_buffer, u32 size);
> +int cmdq_sec_free_wsm(struct cmdq_sec_tee_context *tee, void **wsm_buffer);
> +int cmdq_sec_open_session(struct cmdq_sec_tee_context *tee, void *wsm_buffer);
> +int cmdq_sec_close_session(struct cmdq_sec_tee_context *tee);
> +int cmdq_sec_execute_session(struct cmdq_sec_tee_context *tee, u32 cmd, s32 timeout_ms);
> +
> +#endif	/* __MTK_CMDQ_SEC_TEE_H__ */



Regards,
Angelo
