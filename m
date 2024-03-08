Return-Path: <linux-kernel+bounces-96509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B61875D41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3991C20C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE12E62E;
	Fri,  8 Mar 2024 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rfet6cuv"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C12C1A6;
	Fri,  8 Mar 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873384; cv=none; b=T3cV6s7e7lSUd5+pLH7n2UM/KK+J+tzGYu3v/qdD1/ks1045caN3seivM7Gdxxdm3WLS3aNiUyunLsPQnXxWCrXypGzaLP/s1QS43mvTXfFmV1q/3I2xNUbb0EALYtBokHAE6mQq8LqyR48ok9bBYHg+uqTuJ/9OslOJM4Ghdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873384; c=relaxed/simple;
	bh=C7fGMxVCHCVaH+yWPQn7SeaE7kn0BDYqx0kmPz3bdSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFw994ji/YW9tINxqPnd4ZJSc+a6BRnDB7iX5F/xGgyG3yjRFSbfS8UGZGmzzENRXgARJFNnZqDvD0pymrt29Fy6l9Asxr5BwWOGXKXd4SW88it1WY8BsQPVo7uiszp97LUG68a1duOnlObqpZzvZOzc0vonC2iiVmNrK1iyo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rfet6cuv; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709873379; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cTn5awRb+yOa5Pwccwuxc60eJ89VlixI2n5TbpC45PI=;
	b=Rfet6cuvnzIChn/P7l2TCgzGCs7bzDh8qWfagfFKt4ILczxkorp8NCexe/xIm2TKzhFFc6WQTrMYtD2Dm0lVPN5PVrpedphq6wxDCeM270sFvlpZxgJRz5FRIVq9koy6ZgbQZ9tR7yL/8VqnhJ55tr/jzGsM8EUrM9ZYvfHwxyI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W21SW6f_1709873377;
Received: from 30.221.132.183(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W21SW6f_1709873377)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 12:49:38 +0800
Message-ID: <7b804a97-3fa7-42af-8d15-30c99febc200@linux.alibaba.com>
Date: Fri, 8 Mar 2024 12:49:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
 guohanjun@huawei.com, sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tyler Baicar <baicar@os.amperecomputing.com>
References: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
 <20240304111517.33001-2-tianruidong@linux.alibaba.com>
 <86wmqi19pg.wl-maz@kernel.org>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <86wmqi19pg.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/4 20:07, Marc Zyngier 写道:
> On Mon, 04 Mar 2024 11:15:16 +0000,
> Ruidong Tian <tianruidong@linux.alibaba.com> wrote:
>>
>> From: Tyler Baicar <baicar@os.amperecomputing.com>
>>
>> Add support for parsing the ARM Error Source Table and basic handling of
>> errors reported through both memory mapped and system register interfaces.
>>
>> Assume system register interfaces are only registered with private
>> peripheral interrupts (PPIs); otherwise there is no guarantee the
>> core handling the error is the core which took the error and has the
>> syndrome info in its system registers.
>>
>> All detected errors will be collected to a workqueue in irq context and
>> print error information later.
>>
>> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>> ---
>>   MAINTAINERS                  |  11 +
>>   arch/arm64/include/asm/ras.h |  38 ++
>>   drivers/acpi/arm64/Kconfig   |  10 +
>>   drivers/acpi/arm64/Makefile  |   1 +
>>   drivers/acpi/arm64/aest.c    | 723 +++++++++++++++++++++++++++++++++++
>>   include/linux/acpi_aest.h    |  91 +++++
>>   include/linux/cpuhotplug.h   |   1 +
>>   7 files changed, 875 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/ras.h
>>   create mode 100644 drivers/acpi/arm64/aest.c
>>   create mode 100644 include/linux/acpi_aest.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2a7a90eeec49..5df845763a9c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -329,6 +329,17 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	drivers/acpi/arm64
>>   
>> +ACPI AEST
>> +M:	Tyler Baicar <baicar@os.amperecomputing.com>
>> +M:	Ruidong Tian <tianruidond@linux.alibaba.com>
>> +L:	linux-acpi@vger.kernel.org
>> +L:	linux-arm-kernel@lists.infradead.org
>> +S:	Supported
>> +F:	arch/arm64/include/asm/ras.h
>> +F:	drivers/acpi/arm64/aest.c
>> +F:	include/linux/acpi_aest.h
>> +
>> +
>>   ACPI FOR RISC-V (ACPI/riscv)
>>   M:	Sunil V L <sunilvl@ventanamicro.com>
>>   L:	linux-acpi@vger.kernel.org
>> diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
>> new file mode 100644
>> index 000000000000..2fb0d9741567
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/ras.h
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_RAS_H
>> +#define __ASM_RAS_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/bits.h>
>> +
>> +#define ERR_STATUS_AV		BIT(31)
>> +#define ERR_STATUS_V		BIT(30)
>> +#define ERR_STATUS_UE		BIT(29)
>> +#define ERR_STATUS_ER		BIT(28)
>> +#define ERR_STATUS_OF		BIT(27)
>> +#define ERR_STATUS_MV		BIT(26)
>> +#define ERR_STATUS_CE		(BIT(25) | BIT(24))
>> +#define ERR_STATUS_DE		BIT(23)
>> +#define ERR_STATUS_PN		BIT(22)
>> +#define ERR_STATUS_UET		(BIT(21) | BIT(20))
>> +#define ERR_STATUS_CI		BIT(19)
>> +#define ERR_STATUS_IERR 	GENMASK_ULL(15, 8)
>> +#define ERR_STATUS_SERR 	GENMASK_ULL(7, 0)
> 
> All these bits need to be defined in arch/arm64/tools/sysreg as
> ERXSTATUS_EL1 fields.

This file only describes the system register, but RAS MMIO registers
use these bits too. Would it be appropriate to define them in
arch/arm64/tools/sysreg?

> 
>> +
>> +/* These bit is write-one-to-clear */
>> +#define ERR_STATUS_W1TC 	(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE | \
>> +				ERR_STATUS_ER | ERR_STATUS_OF | ERR_STATUS_MV | \
>> +				ERR_STATUS_CE | ERR_STATUS_DE | ERR_STATUS_PN | \
>> +				ERR_STATUS_UET | ERR_STATUS_CI)
>> +
>> +#define RAS_REV_v1_1		0x1
> 
> What is this? We already have ID_AA64PFR1_EL1.RAS_frac.

I will delete it in v2.

> 
>> +
>> +struct ras_ext_regs {
>> +	u64 err_fr;
>> +	u64 err_ctlr;
>> +	u64 err_status;
>> +	u64 err_addr;
>> +	u64 err_misc[4];
>> +};
>> +
>> +#endif	/* __ASM_RAS_H */
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index b3ed6212244c..639db671c5cf 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -21,3 +21,13 @@ config ACPI_AGDI
>>   
>>   config ACPI_APMT
>>   	bool
>> +
>> +config ACPI_AEST
>> +	bool "ARM Error Source Table Support"
>> +
>> +	help
>> +	  The Arm Error Source Table (AEST) provides details on ACPI
>> +	  extensions that enable kernel-first handling of errors in a
>> +	  system that supports the Armv8 RAS extensions.
>> +
>> +	  If set, the kernel will report and log hardware errors.
>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>> index 726944648c9b..5ea82b196b90 100644
>> --- a/drivers/acpi/arm64/Makefile
>> +++ b/drivers/acpi/arm64/Makefile
>> @@ -6,3 +6,4 @@ obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>>   obj-$(CONFIG_ARM_AMBA)		+= amba.o
>>   obj-y				+= dma.o init.o
>>   obj-y				+= thermal_cpufreq.o
>> +obj-$(CONFIG_ACPI_AEST) 	+= aest.o
>> diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
>> new file mode 100644
>> index 000000000000..be0883316449
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/aest.c
>> @@ -0,0 +1,723 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ARM Error Source Table Support
>> + *
>> + * Copyright (c) 2021, Ampere Computing LLC
>> + * Copyright (c) 2021-2024, Alibaba Group.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/acpi_aest.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/kernel.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/llist.h>
>> +#include <acpi/actbl.h>
>> +#include <asm/ras.h>
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "ACPI AEST: " fmt
>> +
>> +#define CASE_READ_CLEAR(x, clear)					\
>> +	case (x): {							\
>> +		res = read_sysreg_s(SYS_##x##_EL1);			\
>> +		if (clear)						\
>> +			write_sysreg_s(0, SYS_##x##_EL1);		\
>> +		break;							\
>> +	}
> 
> Please don't use macros with side effects. This is horrible to debug.
> Instead, *return* the value from the macro, or pass the variable you
> want to affect as a parameter.

OK, I will pass **res** as a parameter like this:

   #define CASE_READ_CLEAR(res, x, clear)        \
       case (x): {                        	\
           res = read_sysreg_s(SYS_##x##_EL1);   \
           if (clear)                       	\
               write_sysreg_s(0, SYS_##x##_EL1); \
           break;                    		\
       }

> 
> Also, what ensures the synchronisation of this write? How is the W1TC
> aspect enforced?

aest_proc is just call in irq context, one ras error is just routed to
one core, so it is thread safe. And this is a Write-After-Read (WAR)
Hazards with dependence，can i assume that pipeline would guarantee
the order of writing and reading?

> 
>> +
>> +#define CASE_WRITE(val, x)						\
>> +	case (x): {							\
>> +		write_sysreg_s((val), SYS_##x##_EL1);			\
>> +		break;							\
>> +	}
>> +
>> +static struct acpi_table_header *aest_table;
>> +
>> +static struct aest_node __percpu **ppi_data;
>> +
>> +static int *ppi_irqs;
>> +static u8 num_ppi;
>> +static u8 ppi_idx;
>> +
>> +static struct work_struct aest_work;
>> +
>> +static struct gen_pool *aest_node_pool;
>> +static struct llist_head aest_node_llist;
>> +
>> +/*
>> + * This memory pool is only to be used to save AEST node in AEST irq context.
>> + * Use 8 pages to save AEST node for now (~500 AEST node at most).
>> + */
>> +#define AEST_NODE_POOLSZ	(8 * PAGE_SIZE)
> 
> This doesn't make sense. PAGE_SIZE is a variable concept (ranging from
> 4 to 64kB). What is this "~500" number coming from? If you want to
> store a given number of records, allocate the size you actually want.

Use AEST_NODE_MAX_NUM as the max number AEST nodes can be allocated in
genpool instead of AEST_NODE_POOLSZ in v2.

> 
>> +
>> +static u64 aest_sysreg_read_clear(u64 base, u32 offset, bool clear)
>> +{
>> +	u64 res;
>> +
>> +	switch (offset) {
>> +	CASE_READ_CLEAR(ERXFR, clear)
>> +	CASE_READ_CLEAR(ERXCTLR, clear)
>> +	CASE_READ_CLEAR(ERXSTATUS, clear)
>> +	CASE_READ_CLEAR(ERXADDR, clear)
>> +	CASE_READ_CLEAR(ERXMISC0, clear)
>> +	CASE_READ_CLEAR(ERXMISC1, clear)
>> +	CASE_READ_CLEAR(ERXMISC2, clear)
>> +	CASE_READ_CLEAR(ERXMISC3, clear)
>> +	default :
>> +		res = 0;
>> +	}
>> +	return res;
>> +}
>> +
>> +static void aest_sysreg_write(u64 base, u32 offset, u64 val)
>> +{
>> +	switch (offset) {
>> +	CASE_WRITE(val, ERXFR)
>> +	CASE_WRITE(val, ERXCTLR)
>> +	CASE_WRITE(val, ERXSTATUS)
>> +	CASE_WRITE(val, ERXADDR)
>> +	CASE_WRITE(val, ERXMISC0)
>> +	CASE_WRITE(val, ERXMISC1)
>> +	CASE_WRITE(val, ERXMISC2)
>> +	CASE_WRITE(val, ERXMISC3)
>> +	default :
>> +		return;
>> +	}
>> +}
>> +
>> +static u64 aest_iomem_read_clear(u64 base, u32 offset, bool clear)
>> +{
>> +	u64 res;
>> +
>> +	res = readq((void *)(base + offset));
>> +	if (clear)
>> +		writeq(0, (void *)(base + offset));
> 
> Do you need the explicit synchronisation? What ordering are you trying
> to guarantee?

This read and write use the same address, pipeline would guarantee
the order of writing and reading.

> 
>> +	return res;
>> +}
>> +
>> +static void aest_iomem_write(u64 base, u32 offset, u64 val)
>> +{
>> +	writeq(val, (void *)(base + offset));
> 
> Same question.

This function just privides aest access method, caller need explict 
synchronisation if needed.

> 
>> +}
>> +
>> +static void aest_print(struct aest_node_llist *lnode)
>> +{
>> +	static atomic_t seqno;
> 
> Uninitialised atomic?

Fix it next version.

> 
>> +	unsigned int curr_seqno;
>> +	char pfx_seq[64];
> 
> Magic number?

Fix it next version.

> 
>> +	int index;
>> +	struct ras_ext_regs *regs;
>> +
>> +	curr_seqno = atomic_inc_return(&seqno);
>> +	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
>> +	pr_info("%sHardware error from %s\n", pfx_seq, lnode->node_name);
>> +
>> +	switch (lnode->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		pr_err("%s Error from CPU%d\n", pfx_seq, lnode->id0);
>> +		break;
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +		pr_err("%s Error from memory at SRAT proximity domain 0x%x\n",
>> +			pfx_seq, lnode->id0);
>> +		break;
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +		pr_err("%s Error from SMMU IORT node 0x%x subcomponent 0x%x\n",
>> +			pfx_seq, lnode->id0, lnode->id1);
>> +		break;
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +		pr_err("%s Error from vendor hid 0x%x uid 0x%x\n",
>> +			pfx_seq, lnode->id0, lnode->id1);
>> +		break;
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +		pr_err("%s Error from GIC type 0x%x instance 0x%x\n",
>> +			pfx_seq, lnode->id0, lnode->id1);
>> +		break;
>> +	default:
>> +		pr_err("%s Unknown AEST node type\n", pfx_seq);
>> +		return;
>> +	}
>> +
>> +	index = lnode->index;
>> +	regs = &lnode->regs;
>> +
>> +	pr_err("%s  ERR%uFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
>> +	pr_err("%s  ERR%uCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
>> +	pr_err("%s  ERR%uSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
>> +	if (regs->err_status & ERR_STATUS_AV)
>> +		pr_err("%s  ERR%uADDR: 0x%llx\n", pfx_seq, index, regs->err_addr);
>> +
>> +	if (regs->err_status & ERR_STATUS_MV) {
>> +		pr_err("%s  ERR%uMISC0: 0x%llx\n", pfx_seq, index, regs->err_misc[0]);
>> +		pr_err("%s  ERR%uMISC1: 0x%llx\n", pfx_seq, index, regs->err_misc[1]);
>> +		pr_err("%s  ERR%uMISC2: 0x%llx\n", pfx_seq, index, regs->err_misc[2]);
>> +		pr_err("%s  ERR%uMISC3: 0x%llx\n", pfx_seq, index, regs->err_misc[3]);
>> +	}
>> +}
>> +
>> +
>> +static void aest_node_pool_process(struct work_struct *__unused)
>> +{
>> +	struct llist_node *head;
>> +	struct aest_node_llist *lnode, *tmp;
>> +
>> +	head = llist_del_all(&aest_node_llist);
>> +	if (!head)
>> +		return;
>> +
>> +	head = llist_reverse_order(head);
>> +	llist_for_each_entry_safe(lnode, tmp, head, llnode) {
>> +		aest_print(lnode);
>> +		gen_pool_free(aest_node_pool, (unsigned long)lnode,
>> +				sizeof(*lnode));
>> +	}
>> +}
>> +
>> +static int aest_node_gen_pool_add(struct aest_node *node, int index,
>> +				struct ras_ext_regs *regs)
>> +{
>> +	struct aest_node_llist *list;
>> +
>> +	if (!aest_node_pool)
>> +		return -EINVAL;
>> +
>> +	list = (void *)gen_pool_alloc(aest_node_pool, sizeof(*list));
>> +	if (!list)
>> +		return -ENOMEM;
>> +
>> +	list->type = node->type;
>> +	list->node_name = node->name;
>> +	switch (node->type) {
>> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
>> +		list->id0 = node->spec.processor.processor_id;
>> +		if (node->spec.processor.flags & (ACPI_AEST_PROC_FLAG_SHARED |
>> +						ACPI_AEST_PROC_FLAG_GLOBAL))
>> +			list->id0 = smp_processor_id();
>> +
>> +		list->id1 = node->spec.processor.resource_type;
>> +		break;
>> +	case ACPI_AEST_MEMORY_ERROR_NODE:
>> +		list->id0 = node->spec.memory.srat_proximity_domain;
>> +		break;
>> +	case ACPI_AEST_SMMU_ERROR_NODE:
>> +		list->id0 = node->spec.smmu.iort_node_reference;
>> +		list->id1 = node->spec.smmu.subcomponent_reference;
>> +		break;
>> +	case ACPI_AEST_VENDOR_ERROR_NODE:
>> +		list->id0 = node->spec.vendor.acpi_hid;
>> +		list->id1 = node->spec.vendor.acpi_uid;
>> +		break;
>> +	case ACPI_AEST_GIC_ERROR_NODE:
>> +		list->id0 = node->spec.gic.interface_type;
>> +		list->id1 = node->spec.gic.instance_id;
>> +		break;
>> +	default:
>> +		list->id0 = 0;
>> +		list->id1 = 0;
>> +	}
>> +
>> +	memcpy(&list->regs, regs, sizeof(*regs));
> 
> You have vmalloced the record. Why do you need to copy it instead of
> simply pointing to it?

Yes you are right, it will be fixed next version.

> 
>> +	list->index = index;
>> +	llist_add(&list->llnode, &aest_node_llist);
>> +
>> +	return 0;
>> +}
>> +
>> +static int aest_node_pool_init(void)
>> +{
>> +	unsigned long addr, size;
>> +	int rc;
>> +
>> +	if (aest_node_pool)
>> +		return 0;
>> +
>> +	aest_node_pool = gen_pool_create(ilog2(sizeof(struct aest_node_llist)), -1);
>> +	if (!aest_node_pool)
>> +		return -ENOMEM;
>> +
>> +	size = PAGE_ALIGN(AEST_NODE_POOLSZ);
>> +	addr = (unsigned long)vmalloc(size);
>> +	if (!addr)
>> +		goto err_pool_alloc;
>> +
>> +	rc = gen_pool_add(aest_node_pool, addr, size, -1);
>> +	if (rc)
>> +		goto err_pool_add;
>> +
>> +	return 0;
>> +
>> +err_pool_add:
>> +	vfree((void *)addr);
>> +
>> +err_pool_alloc:
>> +	gen_pool_destroy(aest_node_pool);
>> +
>> +	return -ENOMEM;
>> +}
>> +
>> +static void aest_log(struct aest_node *node, int index, struct ras_ext_regs *regs)
>> +{
>> +	if (!aest_node_gen_pool_add(node, index, regs))
>> +		schedule_work(&aest_work);
>> +}
>> +
>> +/*
>> + * you must select cpu number first in order to operate RAS register belonged
>> + * that cpu.
>> + */
>> +static void aest_select_cpu(struct aest_node *node, int i)
>> +{
>> +	if (node->interface.type == ACPI_AEST_NODE_SYSTEM_REGISTER) {
>> +		write_sysreg_s(i, SYS_ERRSELR_EL1);
> 
> ERRSELR_EL1 doesn't select a CPU. It selects a RAS record. How records
> and CPUs are mapped isn't specified in the architecture.
> 

Yes, I'm wrong, and change aest_select_cpu to aest_select_record in v2.

>> +		isb();
>> +	}
>> +}
>> +
>> +static void aest_proc(struct aest_node *node)
>> +{
>> +	struct ras_ext_regs regs = {0};
>> +	struct aest_access *access;
>> +	int i;
>> +	u64 regs_p;
>> +
>> +
>> +	for (i = node->interface.record_start; i < node->interface.record_end; i++) {
>> +		/* 1b: Error record at i index is not implemented */
>> +		if (test_bit(i, &node->interface.record_implemented))
>> +			continue;
>> +
>> +		aest_select_cpu(node, i);
>> +
>> +		access = node->access;
>> +		regs_p = (u64)&node->interface.regs[i];
>> +
>> +		regs.err_status = access->read_clear(regs_p, ERXSTATUS, false);
>> +		if (!(regs.err_status & ERR_STATUS_V))
>> +			continue;
>> +
>> +		if (regs.err_status & ERR_STATUS_AV)
>> +			regs.err_addr = access->read_clear(regs_p, ERXADDR, false);
>> +
>> +		regs.err_fr = access->read_clear(regs_p, ERXFR, false);
>> +		regs.err_ctlr = access->read_clear(regs_p, ERXCTLR, false);
>> +
>> +		if (regs.err_status & ERR_STATUS_MV) {
>> +			bool clear = node->interface.flags & ACPI_AEST_INTERFACE_CLEAR_MISC;
>> +
>> +			regs.err_misc[0] = access->read_clear(regs_p, ERXMISC0, clear);
>> +			regs.err_misc[1] = access->read_clear(regs_p, ERXMISC1, clear);
>> +			regs.err_misc[2] = access->read_clear(regs_p, ERXMISC2, clear);
>> +			regs.err_misc[3] = access->read_clear(regs_p, ERXMISC3, clear);
>> +		}
>> +
>> +		aest_log(node, i, &regs);
>> +
>> +		if (regs.err_status & ERR_STATUS_UE)
>> +			panic("AEST: uncorrectable error encountered");
>> +
>> +		/* Write-one-to-clear the bits we've seen */
>> +		regs.err_status &= ERR_STATUS_W1TC;
>> +
>> +		/* Multi bit filed need to write all-ones to clear. */
>> +		if (regs.err_status & ERR_STATUS_CE)
>> +			regs.err_status |= ERR_STATUS_CE;
>> +
>> +		/* Multi bit filed need to write all-ones to clear. */
>> +		if (regs.err_status & ERR_STATUS_UET)
>> +			regs.err_status |= ERR_STATUS_UET;
>> +
>> +		access->write(regs_p, ERXSTATUS, regs.err_status);
>> +	}
>> +}
>> +
>> +static irqreturn_t aest_irq_func(int irq, void *input)
>> +{
>> +	struct aest_node *node = input;
>> +
>> +	aest_proc(node);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int __init aest_register_gsi(u32 gsi, int trigger, void *data,
>> +					irq_handler_t aest_irq_func)
>> +{
>> +	int cpu, irq;
>> +
>> +	irq = acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
>> +
>> +	if (irq == -EINVAL) {
>> +		pr_err("failed to map AEST GSI %d\n", gsi);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (gsi < 16) {
>> +		pr_err("invalid GSI %d\n", gsi);
>> +		return -EINVAL;
>> +	} else if (gsi < 32) {
>> +		if (ppi_idx >= AEST_MAX_PPI) {
>> +			pr_err("Unable to register PPI %d\n", gsi);
>> +			return -EINVAL;
>> +		}
>> +		ppi_irqs[ppi_idx] = irq;
>> +		enable_percpu_irq(irq, IRQ_TYPE_NONE);
> 
> Enabling the PPI before requesting it? Looks... great. And how does
> this work on a system that supports EPPIs, which are in the
> [1119:1056] range?

It is better to enable it after request it, i will fix it next version.
My machine do not use EPPI as RAS interrupt, i can not test it now. Can
we support EPPI in later patch?

> 
> Also, if you get a trigger as a parameter, why the IRQ_TYPE_NONE?

Sorry，I do not really understand this comment, should I use
(IRQ_LEVEL | IRQ_PER_CPU)?

> 
> 
>> +		for_each_possible_cpu(cpu) {
>> +			memcpy(per_cpu_ptr(ppi_data[ppi_idx], cpu), data,
>> +			       sizeof(struct aest_node));
>> +		}
>> +		if (request_percpu_irq(irq, aest_irq_func, "AEST",
>> +				       ppi_data[ppi_idx++])) {
>> +			pr_err("failed to register AEST IRQ %d\n", irq);
>> +			return -EINVAL;
>> +		}
>> +	} else if (gsi < 1020) {
>> +		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
>> +				data)) {
> 
> Why SHARED? Who would share a RAS interrupt?????

Multi AEST nodes may use the same interrupt, for example, one DDRC with
a RAS interrupt has two sub channels, these two sub channel is described
as two AEST node in AEST table, so they share the same one. In another
case, SMMU has two RAS node, TCU and TBU, they may also share the same
interrupt.

> 
>> +			pr_err("failed to register AEST IRQ %d\n", irq);
>> +			return -EINVAL;
> 
> Same question about extended SPIs.
> 
> All in all, this whole logic is totally useless. It isn't the driver's
> job to classify the GIC INTIDs...

AEST use both PPI and SPI, it seems that AEST driver must recognize
INTID in order to request irq number with different function, do you
have better solution here?

> 
> 	M.
> 

