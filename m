Return-Path: <linux-kernel+bounces-89624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04186F32D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F77A1C211DC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FB54730;
	Sat,  2 Mar 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4ANQy2q2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4078405CF;
	Sat,  2 Mar 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709423526; cv=none; b=I0N7C5qiezdWrtjGKCePhMW9gzFNf2aiKA5BgQuNaZubmmGNlhLI1umrROwd7Er2rSR6nYp21MQqiJjiyq48DIUfT6TqiH8Wx7Jrf6MRHOnfz1fBurofOJH6OSwrkTG7yphW7zbXMaMeJ7+dLc9LHP1JTFEnVPAHWi/VblXyTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709423526; c=relaxed/simple;
	bh=75UfXwBOLYEAZwnwPETnsh0x7qMDgfb/RnAi/IQaXVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4yr5NLVmq3MV1XVVzJA24ISZ+ZlZlha94RE2RLrFePqwQDpFLcbDAydqRU9JYfTBtQh8BRjFkiY29gKONb/y4jYfrWK9HngScPdyrdiVzSCxSSorAR6gHc1jHndWW/74Ck4eO8VxTr3K6hkb+9fqFz7B2/RTYwzhtWwkw98wwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4ANQy2q2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QR73nBZskDYS5YtbCObH9ps4P06oPKKMiedOxmbejD8=; b=4ANQy2q251WQZtuShDcvDX+t9e
	LsGeacmueAzfSt74hrpqqDYCV5Yk4yFjo1QkM8Sn3BemJueIeJbYAA0KME2r7NJvG20OIFg5MEksb
	HnbDnaLz9Ah2BhE0yAh91Jgl81hmF1e3toI8TN05hawvK8QGXDDyXlnrcN6Rv2fZX7JIhtix18JyA
	SP+CAO0orjUz3GhR5y0zUehGMZ6irvo4mrfBuM5fjMpyQDMoooIN11yyN6lj7e5RKUDp/hLLLR57/
	AeyZ/4EE99vCxOHxuUm+ZnjlEoLctFlB330DyrqnloN0z5bDI/kUtqVdanskHWjMi3DzcIvDz/qHl
	5AvB63vg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgZ99-00000004gN2-06w5;
	Sat, 02 Mar 2024 23:52:03 +0000
Message-ID: <482c88c9-1598-4f51-b2ee-3a8e224eeefe@infradead.org>
Date: Sat, 2 Mar 2024 15:52:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] sparc32: Fix parport build with sparc32
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-6-1f186603c5c4@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-6-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/24 09:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> include/asm/parport.h is sparc64 specific.
> Rename it to parport_64.h and use the generic version for sparc32.
> 
> This fixed all{mod,yes}config build errors like:
> 
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
> 
> The errors occur as the sparc32 build references sparc64 symbols.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Cc: stable@vger.kernel.org # v5.18+

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.
> ---
>  arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
>  arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
>  2 files changed, 263 insertions(+), 252 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
> index 0a7ffcfd59cd..e2eed8f97665 100644
> --- a/arch/sparc/include/asm/parport.h
> +++ b/arch/sparc/include/asm/parport.h
> @@ -1,256 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* parport.h: sparc64 specific parport initialization and dma.
> - *
> - * Copyright (C) 1999  Eddie C. Dost  (ecd@skynet.be)
> - */
> +#ifndef ___ASM_SPARC_PARPORT_H
> +#define ___ASM_SPARC_PARPORT_H
>  
> -#ifndef _ASM_SPARC64_PARPORT_H
> -#define _ASM_SPARC64_PARPORT_H 1
> -
> -#include <linux/of.h>
> -#include <linux/platform_device.h>
> -
> -#include <asm/ebus_dma.h>
> -#include <asm/ns87303.h>
> -#include <asm/prom.h>
> -
> -#define PARPORT_PC_MAX_PORTS	PARPORT_MAX
> -
> -/*
> - * While sparc64 doesn't have an ISA DMA API, we provide something that looks
> - * close enough to make parport_pc happy
> - */
> -#define HAS_DMA
> -
> -#ifdef CONFIG_PARPORT_PC_FIFO
> -static DEFINE_SPINLOCK(dma_spin_lock);
> -
> -#define claim_dma_lock() \
> -({	unsigned long flags; \
> -	spin_lock_irqsave(&dma_spin_lock, flags); \
> -	flags; \
> -})
> -
> -#define release_dma_lock(__flags) \
> -	spin_unlock_irqrestore(&dma_spin_lock, __flags);
> +#if defined(__sparc__) && defined(__arch64__)
> +#include <asm/parport_64.h>
> +#else
> +#include <asm-generic/parport.h>
> +#endif
>  #endif
>  
> -static struct sparc_ebus_info {
> -	struct ebus_dma_info info;
> -	unsigned int addr;
> -	unsigned int count;
> -	int lock;
> -
> -	struct parport *port;
> -} sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
> -
> -static DECLARE_BITMAP(dma_slot_map, PARPORT_PC_MAX_PORTS);
> -
> -static inline int request_dma(unsigned int dmanr, const char *device_id)
> -{
> -	if (dmanr >= PARPORT_PC_MAX_PORTS)
> -		return -EINVAL;
> -	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
> -		return -EBUSY;
> -	return 0;
> -}
> -
> -static inline void free_dma(unsigned int dmanr)
> -{
> -	if (dmanr >= PARPORT_PC_MAX_PORTS) {
> -		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
> -		return;
> -	}
> -	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) == 0) {
> -		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
> -		return;
> -	}
> -}
> -
> -static inline void enable_dma(unsigned int dmanr)
> -{
> -	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
> -
> -	if (ebus_dma_request(&sparc_ebus_dmas[dmanr].info,
> -			     sparc_ebus_dmas[dmanr].addr,
> -			     sparc_ebus_dmas[dmanr].count))
> -		BUG();
> -}
> -
> -static inline void disable_dma(unsigned int dmanr)
> -{
> -	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 0);
> -}
> -
> -static inline void clear_dma_ff(unsigned int dmanr)
> -{
> -	/* nothing */
> -}
> -
> -static inline void set_dma_mode(unsigned int dmanr, char mode)
> -{
> -	ebus_dma_prepare(&sparc_ebus_dmas[dmanr].info, (mode != DMA_MODE_WRITE));
> -}
> -
> -static inline void set_dma_addr(unsigned int dmanr, unsigned int addr)
> -{
> -	sparc_ebus_dmas[dmanr].addr = addr;
> -}
> -
> -static inline void set_dma_count(unsigned int dmanr, unsigned int count)
> -{
> -	sparc_ebus_dmas[dmanr].count = count;
> -}
> -
> -static inline unsigned int get_dma_residue(unsigned int dmanr)
> -{
> -	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
> -}
> -
> -static int ecpp_probe(struct platform_device *op)
> -{
> -	unsigned long base = op->resource[0].start;
> -	unsigned long config = op->resource[1].start;
> -	unsigned long d_base = op->resource[2].start;
> -	unsigned long d_len;
> -	struct device_node *parent;
> -	struct parport *p;
> -	int slot, err;
> -
> -	parent = op->dev.of_node->parent;
> -	if (of_node_name_eq(parent, "dma")) {
> -		p = parport_pc_probe_port(base, base + 0x400,
> -					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
> -					  op->dev.parent->parent, 0);
> -		if (!p)
> -			return -ENOMEM;
> -		dev_set_drvdata(&op->dev, p);
> -		return 0;
> -	}
> -
> -	for (slot = 0; slot < PARPORT_PC_MAX_PORTS; slot++) {
> -		if (!test_and_set_bit(slot, dma_slot_map))
> -			break;
> -	}
> -	err = -ENODEV;
> -	if (slot >= PARPORT_PC_MAX_PORTS)
> -		goto out_err;
> -
> -	spin_lock_init(&sparc_ebus_dmas[slot].info.lock);
> -
> -	d_len = (op->resource[2].end - d_base) + 1UL;
> -	sparc_ebus_dmas[slot].info.regs =
> -		of_ioremap(&op->resource[2], 0, d_len, "ECPP DMA");
> -
> -	if (!sparc_ebus_dmas[slot].info.regs)
> -		goto out_clear_map;
> -
> -	sparc_ebus_dmas[slot].info.flags = 0;
> -	sparc_ebus_dmas[slot].info.callback = NULL;
> -	sparc_ebus_dmas[slot].info.client_cookie = NULL;
> -	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
> -	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
> -	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
> -		goto out_unmap_regs;
> -
> -	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 1);
> -
> -	/* Configure IRQ to Push Pull, Level Low */
> -	/* Enable ECP, set bit 2 of the CTR first */
> -	outb(0x04, base + 0x02);
> -	ns87303_modify(config, PCR,
> -		       PCR_EPP_ENABLE |
> -		       PCR_IRQ_ODRAIN,
> -		       PCR_ECP_ENABLE |
> -		       PCR_ECP_CLK_ENA |
> -		       PCR_IRQ_POLAR);
> -
> -	/* CTR bit 5 controls direction of port */
> -	ns87303_modify(config, PTR,
> -		       0, PTR_LPT_REG_DIR);
> -
> -	p = parport_pc_probe_port(base, base + 0x400,
> -				  op->archdata.irqs[0],
> -				  slot,
> -				  op->dev.parent,
> -				  0);
> -	err = -ENOMEM;
> -	if (!p)
> -		goto out_disable_irq;
> -
> -	dev_set_drvdata(&op->dev, p);
> -
> -	return 0;
> -
> -out_disable_irq:
> -	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
> -	ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
> -
> -out_unmap_regs:
> -	of_iounmap(&op->resource[2], sparc_ebus_dmas[slot].info.regs, d_len);
> -
> -out_clear_map:
> -	clear_bit(slot, dma_slot_map);
> -
> -out_err:
> -	return err;
> -}
> -
> -static int ecpp_remove(struct platform_device *op)
> -{
> -	struct parport *p = dev_get_drvdata(&op->dev);
> -	int slot = p->dma;
> -
> -	parport_pc_unregister_port(p);
> -
> -	if (slot != PARPORT_DMA_NOFIFO) {
> -		unsigned long d_base = op->resource[2].start;
> -		unsigned long d_len;
> -
> -		d_len = (op->resource[2].end - d_base) + 1UL;
> -
> -		ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
> -		ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
> -		of_iounmap(&op->resource[2],
> -			   sparc_ebus_dmas[slot].info.regs,
> -			   d_len);
> -		clear_bit(slot, dma_slot_map);
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id ecpp_match[] = {
> -	{
> -		.name = "ecpp",
> -	},
> -	{
> -		.name = "parallel",
> -		.compatible = "ecpp",
> -	},
> -	{
> -		.name = "parallel",
> -		.compatible = "ns87317-ecpp",
> -	},
> -	{
> -		.name = "parallel",
> -		.compatible = "pnpALI,1533,3",
> -	},
> -	{},
> -};
> -
> -static struct platform_driver ecpp_driver = {
> -	.driver = {
> -		.name = "ecpp",
> -		.of_match_table = ecpp_match,
> -	},
> -	.probe			= ecpp_probe,
> -	.remove			= ecpp_remove,
> -};
> -
> -static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
> -{
> -	return platform_driver_register(&ecpp_driver);
> -}
> -
> -#endif /* !(_ASM_SPARC64_PARPORT_H */
> diff --git a/arch/sparc/include/asm/parport_64.h b/arch/sparc/include/asm/parport_64.h
> new file mode 100644
> index 000000000000..0a7ffcfd59cd
> --- /dev/null
> +++ b/arch/sparc/include/asm/parport_64.h
> @@ -0,0 +1,256 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* parport.h: sparc64 specific parport initialization and dma.
> + *
> + * Copyright (C) 1999  Eddie C. Dost  (ecd@skynet.be)
> + */
> +
> +#ifndef _ASM_SPARC64_PARPORT_H
> +#define _ASM_SPARC64_PARPORT_H 1
> +
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/ebus_dma.h>
> +#include <asm/ns87303.h>
> +#include <asm/prom.h>
> +
> +#define PARPORT_PC_MAX_PORTS	PARPORT_MAX
> +
> +/*
> + * While sparc64 doesn't have an ISA DMA API, we provide something that looks
> + * close enough to make parport_pc happy
> + */
> +#define HAS_DMA
> +
> +#ifdef CONFIG_PARPORT_PC_FIFO
> +static DEFINE_SPINLOCK(dma_spin_lock);
> +
> +#define claim_dma_lock() \
> +({	unsigned long flags; \
> +	spin_lock_irqsave(&dma_spin_lock, flags); \
> +	flags; \
> +})
> +
> +#define release_dma_lock(__flags) \
> +	spin_unlock_irqrestore(&dma_spin_lock, __flags);
> +#endif
> +
> +static struct sparc_ebus_info {
> +	struct ebus_dma_info info;
> +	unsigned int addr;
> +	unsigned int count;
> +	int lock;
> +
> +	struct parport *port;
> +} sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
> +
> +static DECLARE_BITMAP(dma_slot_map, PARPORT_PC_MAX_PORTS);
> +
> +static inline int request_dma(unsigned int dmanr, const char *device_id)
> +{
> +	if (dmanr >= PARPORT_PC_MAX_PORTS)
> +		return -EINVAL;
> +	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static inline void free_dma(unsigned int dmanr)
> +{
> +	if (dmanr >= PARPORT_PC_MAX_PORTS) {
> +		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
> +		return;
> +	}
> +	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) == 0) {
> +		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
> +		return;
> +	}
> +}
> +
> +static inline void enable_dma(unsigned int dmanr)
> +{
> +	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
> +
> +	if (ebus_dma_request(&sparc_ebus_dmas[dmanr].info,
> +			     sparc_ebus_dmas[dmanr].addr,
> +			     sparc_ebus_dmas[dmanr].count))
> +		BUG();
> +}
> +
> +static inline void disable_dma(unsigned int dmanr)
> +{
> +	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 0);
> +}
> +
> +static inline void clear_dma_ff(unsigned int dmanr)
> +{
> +	/* nothing */
> +}
> +
> +static inline void set_dma_mode(unsigned int dmanr, char mode)
> +{
> +	ebus_dma_prepare(&sparc_ebus_dmas[dmanr].info, (mode != DMA_MODE_WRITE));
> +}
> +
> +static inline void set_dma_addr(unsigned int dmanr, unsigned int addr)
> +{
> +	sparc_ebus_dmas[dmanr].addr = addr;
> +}
> +
> +static inline void set_dma_count(unsigned int dmanr, unsigned int count)
> +{
> +	sparc_ebus_dmas[dmanr].count = count;
> +}
> +
> +static inline unsigned int get_dma_residue(unsigned int dmanr)
> +{
> +	return ebus_dma_residue(&sparc_ebus_dmas[dmanr].info);
> +}
> +
> +static int ecpp_probe(struct platform_device *op)
> +{
> +	unsigned long base = op->resource[0].start;
> +	unsigned long config = op->resource[1].start;
> +	unsigned long d_base = op->resource[2].start;
> +	unsigned long d_len;
> +	struct device_node *parent;
> +	struct parport *p;
> +	int slot, err;
> +
> +	parent = op->dev.of_node->parent;
> +	if (of_node_name_eq(parent, "dma")) {
> +		p = parport_pc_probe_port(base, base + 0x400,
> +					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
> +					  op->dev.parent->parent, 0);
> +		if (!p)
> +			return -ENOMEM;
> +		dev_set_drvdata(&op->dev, p);
> +		return 0;
> +	}
> +
> +	for (slot = 0; slot < PARPORT_PC_MAX_PORTS; slot++) {
> +		if (!test_and_set_bit(slot, dma_slot_map))
> +			break;
> +	}
> +	err = -ENODEV;
> +	if (slot >= PARPORT_PC_MAX_PORTS)
> +		goto out_err;
> +
> +	spin_lock_init(&sparc_ebus_dmas[slot].info.lock);
> +
> +	d_len = (op->resource[2].end - d_base) + 1UL;
> +	sparc_ebus_dmas[slot].info.regs =
> +		of_ioremap(&op->resource[2], 0, d_len, "ECPP DMA");
> +
> +	if (!sparc_ebus_dmas[slot].info.regs)
> +		goto out_clear_map;
> +
> +	sparc_ebus_dmas[slot].info.flags = 0;
> +	sparc_ebus_dmas[slot].info.callback = NULL;
> +	sparc_ebus_dmas[slot].info.client_cookie = NULL;
> +	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
> +	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
> +	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
> +		goto out_unmap_regs;
> +
> +	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 1);
> +
> +	/* Configure IRQ to Push Pull, Level Low */
> +	/* Enable ECP, set bit 2 of the CTR first */
> +	outb(0x04, base + 0x02);
> +	ns87303_modify(config, PCR,
> +		       PCR_EPP_ENABLE |
> +		       PCR_IRQ_ODRAIN,
> +		       PCR_ECP_ENABLE |
> +		       PCR_ECP_CLK_ENA |
> +		       PCR_IRQ_POLAR);
> +
> +	/* CTR bit 5 controls direction of port */
> +	ns87303_modify(config, PTR,
> +		       0, PTR_LPT_REG_DIR);
> +
> +	p = parport_pc_probe_port(base, base + 0x400,
> +				  op->archdata.irqs[0],
> +				  slot,
> +				  op->dev.parent,
> +				  0);
> +	err = -ENOMEM;
> +	if (!p)
> +		goto out_disable_irq;
> +
> +	dev_set_drvdata(&op->dev, p);
> +
> +	return 0;
> +
> +out_disable_irq:
> +	ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
> +	ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
> +
> +out_unmap_regs:
> +	of_iounmap(&op->resource[2], sparc_ebus_dmas[slot].info.regs, d_len);
> +
> +out_clear_map:
> +	clear_bit(slot, dma_slot_map);
> +
> +out_err:
> +	return err;
> +}
> +
> +static int ecpp_remove(struct platform_device *op)
> +{
> +	struct parport *p = dev_get_drvdata(&op->dev);
> +	int slot = p->dma;
> +
> +	parport_pc_unregister_port(p);
> +
> +	if (slot != PARPORT_DMA_NOFIFO) {
> +		unsigned long d_base = op->resource[2].start;
> +		unsigned long d_len;
> +
> +		d_len = (op->resource[2].end - d_base) + 1UL;
> +
> +		ebus_dma_irq_enable(&sparc_ebus_dmas[slot].info, 0);
> +		ebus_dma_unregister(&sparc_ebus_dmas[slot].info);
> +		of_iounmap(&op->resource[2],
> +			   sparc_ebus_dmas[slot].info.regs,
> +			   d_len);
> +		clear_bit(slot, dma_slot_map);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ecpp_match[] = {
> +	{
> +		.name = "ecpp",
> +	},
> +	{
> +		.name = "parallel",
> +		.compatible = "ecpp",
> +	},
> +	{
> +		.name = "parallel",
> +		.compatible = "ns87317-ecpp",
> +	},
> +	{
> +		.name = "parallel",
> +		.compatible = "pnpALI,1533,3",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver ecpp_driver = {
> +	.driver = {
> +		.name = "ecpp",
> +		.of_match_table = ecpp_match,
> +	},
> +	.probe			= ecpp_probe,
> +	.remove			= ecpp_remove,
> +};
> +
> +static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
> +{
> +	return platform_driver_register(&ecpp_driver);
> +}
> +
> +#endif /* !(_ASM_SPARC64_PARPORT_H */
> 

-- 
#Randy

