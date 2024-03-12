Return-Path: <linux-kernel+bounces-100661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8690879B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D46A283DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2A213C9F9;
	Tue, 12 Mar 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx6xWRPX"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB813B791;
	Tue, 12 Mar 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268356; cv=none; b=FLZmdbtd0D46Ohzx7BF/OjZ66l25HQ390GPg6U37yrQOrL5SC6he9FQb76Hgygk/5zdhkinH3vvHCuB38Pi4t5IlMPhYW88ZPAoxAxY50xsjxLmNcS6FrmQrbzjcmv1M+dDi/G83NnouTR7NwZxVbLLkiu4jkGh6NOLL1rn0et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268356; c=relaxed/simple;
	bh=yEXm95J5wvGnUMUtqcXy7Ftllk3x5/GMp5heKqnYsHA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY0qjS4S5Gp+RxDExNvmXLYhYec90u6wzSbxWEwfsikXyoFqc2Np3vQObDBg55mpy5Mmy3plWv7tvSXv7Qn+7rC16+FiCoqgTwVxuOKMUt4X9i2X42lm6Jtyh9GChHX72eH6o20WPZ+gcIfmHtwUWKOsLEuENtxJbVRiBEBTJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx6xWRPX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c88a2173daso8363239f.0;
        Tue, 12 Mar 2024 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710268354; x=1710873154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqU8vwf+tbdTSkXAgzjKJdEijPq7ApphWIX0SIRCQzk=;
        b=Tx6xWRPXaLRsXGvcZcjAEL0ivLXuLZuf/uKXYZQk33G1cMijavtnpASkRvhIFXjBGP
         blNvUGbEbCH6qvIEHpApW9Bt22PjBPAMUcQLssxCll+BjucY2CosOVa1Flx/TDr5Qp+P
         AOqtl5d3NqNw8MxIDyRIv0KZ63GG5cI4c97RnvHkYfi5cdRLCKRWAE9aIyG9vLJdvgeb
         GpCMJw+8gqHM9MYLb3OZNZI96s//0E78hlsS6gE20OgeKzV/xibkQuUhOFW/nVjyxP8O
         +jHeTQJp2mhZYvFufbi7EqoxOQuA6y8U80EeG79Tk8KbpkCmxFbYS0IjPWWo19EFCTql
         0joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268354; x=1710873154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqU8vwf+tbdTSkXAgzjKJdEijPq7ApphWIX0SIRCQzk=;
        b=vxD/IivbmGMdULnVYH4jeEbWdexEeaYTXd/XgoCjMZSiB2+hkKYcukcf8TI3Ty+z/7
         YuQ3iwVTPgWUXVxKxd8U7n50Tpp/awYMHeVzFOEuIRVNZtOigUe3sWSXpI3BaHD+QEus
         Kd5QDGQPkhzA2juXVLfChg7ysQKgUb71eqXYghWv4RQa+r3Bp7OJMm73PAEYM1gXtx9f
         2VE/ZyhKqMNJOP4onFZZY80AH8mNJabhlYVbhlaNeWbNhgXTaS8+6q8UaEgM+cK3IWjt
         TTRtZL/uar3tmbCB+42d/PXMxgsCdJtIGMSw45fPOa5ORrYfShlR9Ecz51jfHmsUWwud
         w6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYDRHSEUPWixRKkyqmpUEHfLYkKM6satrH0esz4relotG0PKZ3OgV1v+tbAO5ybpTGhPTz4RoB6Bmwz4pjIpE6XpArUSDjun1RmCbKjWJmo0iwLH9fIO2kLeF/FMFmaWwtEdVz+1RFUfWiPej/QKA+OF3nme1UjbRwV99PvHJATHF3kwA=
X-Gm-Message-State: AOJu0YyD83P9c9yM2GScCTbHbfZxJ0GLDP/DiQqKLPG85aC8KDjEh0w9
	KOPdFLT/q9GAeAvUXK/hKguGb0XdX9NljDp5M/kIFW6t+rF215JJnnBbKz1V
X-Google-Smtp-Source: AGHT+IHQ91EGeIfz2oaj8S9TucVWBSI/m7YsmBPoTA68buP0uVHpq6iN4yvUa+DL1kIPCUmvF0cgcw==
X-Received: by 2002:a6b:5c12:0:b0:7c8:c9b8:f976 with SMTP id z18-20020a6b5c12000000b007c8c9b8f976mr1280322ioh.21.1710268353693;
        Tue, 12 Mar 2024 11:32:33 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id c18-20020a02c9d2000000b00474fab2523dsm2436749jap.62.2024.03.12.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:32:33 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 12 Mar 2024 11:32:17 -0700
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
	jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [RFC PATCH v7 10/12] ACPI:RAS2: Add common library for RAS2 PCC
 interfaces
Message-ID: <ZfCfsZARb_QY7bA5@debian>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-11-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223143723.1574-11-shiju.jose@huawei.com>

On Fri, Feb 23, 2024 at 10:37:21PM +0800, shiju.jose@huawei.com wrote:
> From: A Somasundaram <somasundaram.a@hpe.com>
> 
> The code contains PCC interfaces for RAS2 table, functions to send
> RAS2 commands as per ACPI 6.5 & upwards revision.
> 
> References for this implementation,
> ACPI specification 6.5 section 5.2.21 for RAS2 table and chapter 14
> for PCC (Platform Communication Channel).
> 
> Driver uses PCC interfaces to communicate to the ACPI HW. This code
> implements PCC interfaces and the functions to send the RAS2 commands
> to be used by OSPM.
> 
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig            |  14 ++
>  drivers/acpi/Makefile           |   1 +
>  drivers/acpi/ras2_acpi_common.c | 272 ++++++++++++++++++++++++++++++++
>  include/acpi/ras2_acpi.h        |  59 +++++++
>  4 files changed, 346 insertions(+)
>  create mode 100755 drivers/acpi/ras2_acpi_common.c
>  create mode 100644 include/acpi/ras2_acpi.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 3c3f8037ebed..6f69c9976c4f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -284,6 +284,20 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
>  
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	depends on ACPI_PROCESSOR
> +	select MAILBOX
> +	select PCC
> +	help
> +	  The driver adds support for PCC (platform communication
> +	  channel) interfaces to communicate with the ACPI complaint
> +	  hardware platform supports RAS2(RAS2 Feature table).
> +	  The driver adds support for RAS2(extraction of RAS2
> +	  tables from OS system table), PCC interfaces and OSPM interfaces
> +	  to send RAS2 commands. Driver adds platform device which
> +	  binds to the RAS2 memory driver.
> +
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || ARM64 || LOONGARCH
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 12ef8180d272..b12fba9cff06 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
> +obj-$(CONFIG_ACPI_RAS2)		+= ras2_acpi_common.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/ras2_acpi_common.c b/drivers/acpi/ras2_acpi_common.c
> new file mode 100755
> index 000000000000..c6e4ed96cd81
> --- /dev/null
> +++ b/drivers/acpi/ras2_acpi_common.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ACPI RAS2 table processing common functions
> + *
> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + *
> + * Support for
> + * RAS2 - ACPI 6.5 Specification, section 5.2.21
> + * PCC(Platform Communications Channel) - ACPI 6.5 Specification,
> + * chapter 14.
> + *
> + * Code contains common functions for RAS2.
> + * PCC(Platform communication channel) interfaces for the RAS2
> + * and the functions for sending RAS2 commands to the ACPI HW.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/delay.h>
> +#include <linux/ktime.h>
> +#include <linux/platform_device.h>
> +#include <acpi/ras2_acpi.h>
> +#include <acpi/acpixf.h>
> +
> +static int ras2_check_pcc_chan(struct ras2_context *ras2_ctx)
> +{
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), ras2_ctx->deadline);
> +
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		/*
> +		 * As per ACPI spec, the PCC space wil be initialized by

s/wil/will/

Fan
> +		 * platform and should have set the command completion bit when
> +		 * PCC can be used by OSPM
> +		 */
> +		if (readw_relaxed(&generic_comm_base->status) & RAS2_PCC_CMD_COMPLETE)
> +			return 0;
> +		/*
> +		 * Reducing the bus traffic in case this loop takes longer than
> +		 * a few retries.
> +		 */
> +		udelay(10);
> +	}
> +
> +	return -EIO;
> +}
> +
> +/**
> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
> + * @ras2_ctx:	pointer to the ras2 context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_context *ras2_ctx, u16 cmd)
> +{
> +	int ret;
> +	struct acpi_ras2_shared_memory  *generic_comm_base =
> +		(struct acpi_ras2_shared_memory *)ras2_ctx->pcc_comm_addr;
> +	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
> +	struct mbox_chan *pcc_channel;
> +	static int mpar_count;
> +	unsigned int time_delta;
> +
> +	if (cmd == RAS2_PCC_CMD_EXEC) {
> +		ret = ras2_check_pcc_chan(ras2_ctx);
> +		if (ret)
> +			return ret;
> +	}
> +	pcc_channel = ras2_ctx->pcc_chan->mchan;
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time(MRTT)
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds"
> +	 */
> +	if (ras2_ctx->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
> +		if (ras2_ctx->pcc_mrtt > time_delta)
> +			udelay(ras2_ctx->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, we will follow the spec and just
> +	 * not send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window
> +	 */
> +	if (ras2_ctx->pcc_mpar) {
> +		if (mpar_count == 0) {
> +			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				dev_dbg(ras2_ctx->dev,
> +					"PCC cmd not sent due to MPAR limit");
> +				return -EIO;
> +			}
> +			last_mpar_reset = ktime_get();
> +			mpar_count = ras2_ctx->pcc_mpar;
> +		}
> +		mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region. */
> +	writew_relaxed(cmd, &generic_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &generic_comm_base->status);
> +
> +	/* Ring doorbell */
> +	ret = mbox_send_message(pcc_channel, &cmd);
> +	if (ret < 0) {
> +		dev_err(ras2_ctx->dev,
> +			"Err sending PCC mbox message. cmd:%d, ret:%d\n",
> +			cmd, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * For READs we need to ensure the cmd completed to ensure
> +	 * the ensuing read()s can proceed. For WRITEs we dont care
> +	 * because the actual write()s are done before coming here
> +	 * and the next READ or WRITE will check if the channel
> +	 * is busy/free at the entry of this call.
> +	 *
> +	 * If Minimum Request Turnaround Time is non-zero, we need
> +	 * to record the completion time of both READ and WRITE
> +	 * command for proper handling of MRTT, so we need to check
> +	 * for pcc_mrtt in addition to CMD_READ
> +	 */
> +	if (cmd == RAS2_PCC_CMD_EXEC || ras2_ctx->pcc_mrtt) {
> +		ret = ras2_check_pcc_chan(ras2_ctx);
> +		if (ras2_ctx->pcc_mrtt)
> +			last_cmd_cmpl_time = ktime_get();
> +	}
> +
> +	if (pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_channel, ret);
> +	else
> +		mbox_client_txdone(pcc_channel, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +/**
> + * ras2_register_pcc_channel() - Register PCC channel
> + * @ras2_ctx:	pointer to the ras2 context structure
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_register_pcc_channel(struct ras2_context *ras2_ctx)
> +{
> +	u64 usecs_lat;
> +	unsigned int len;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *ras2_mbox_cl;
> +	struct acpi_pcct_hw_reduced *ras2_ss;
> +
> +	ras2_mbox_cl = &ras2_ctx->mbox_client;
> +	if (!ras2_mbox_cl || ras2_ctx->pcc_subspace_idx < 0)
> +		return -EINVAL;
> +
> +	pcc_chan = pcc_mbox_request_channel(ras2_mbox_cl,
> +					    ras2_ctx->pcc_subspace_idx);
> +
> +	if (IS_ERR(pcc_chan)) {
> +		dev_err(ras2_ctx->dev,
> +			"Failed to find PCC channel for subspace %d\n",
> +			ras2_ctx->pcc_subspace_idx);
> +		return -ENODEV;
> +	}
> +	ras2_ctx->pcc_chan = pcc_chan;
> +	/*
> +	 * The PCC mailbox controller driver should
> +	 * have parsed the PCCT (global table of all
> +	 * PCC channels) and stored pointers to the
> +	 * subspace communication region in con_priv.
> +	 */
> +	ras2_ss = pcc_chan->mchan->con_priv;
> +
> +	if (!ras2_ss) {
> +		dev_err(ras2_ctx->dev, "No PCC subspace found for RAS2\n");
> +		pcc_mbox_free_channel(ras2_ctx->pcc_chan);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * This is the shared communication region
> +	 * for the OS and Platform to communicate over.
> +	 */
> +	ras2_ctx->comm_base_addr = ras2_ss->base_address;
> +	len = ras2_ss->length;
> +	dev_dbg(ras2_ctx->dev, "PCC subspace for RAS2=0x%llx len=%d\n",
> +		ras2_ctx->comm_base_addr, len);
> +
> +	/*
> +	 * ras2_ss->latency is just a Nominal value. In reality
> +	 * the remote processor could be much slower to reply.
> +	 * So add an arbitrary amount of wait on top of Nominal.
> +	 */
> +	usecs_lat = RAS2_NUM_RETRIES * ras2_ss->latency;
> +	ras2_ctx->deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
> +	ras2_ctx->pcc_mrtt = ras2_ss->min_turnaround_time;
> +	ras2_ctx->pcc_mpar = ras2_ss->max_access_rate;
> +	ras2_ctx->pcc_comm_addr = acpi_os_ioremap(ras2_ctx->comm_base_addr,
> +						  len);
> +	dev_dbg(ras2_ctx->dev, "pcc_comm_addr=%p\n",
> +		ras2_ctx->pcc_comm_addr);
> +
> +	/* Set flag so that we dont come here for each CPU. */
> +	ras2_ctx->pcc_channel_acquired = true;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ras2_register_pcc_channel);
> +
> +/**
> + * ras2_unregister_pcc_channel() - Unregister PCC channel
> + * @ras2_ctx:	pointer to the ras2 context structure
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_unregister_pcc_channel(struct ras2_context *ras2_ctx)
> +{
> +	if (!ras2_ctx->pcc_chan)
> +		return -EINVAL;
> +
> +	pcc_mbox_free_channel(ras2_ctx->pcc_chan);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ras2_unregister_pcc_channel);
> +
> +/**
> + * ras2_add_platform_device() - Add a platform device for RAS2
> + * @name:	name of the device we're adding
> + * @data:	platform specific data for this platform device
> + * @size:	size of platform specific data
> + *
> + * Returns: pointer to platform device on success, an error otherwise
> + */
> +struct platform_device *ras2_add_platform_device(char *name, const void *data,
> +						 size_t size)
> +{
> +	int ret;
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return NULL;
> +
> +	ret = platform_device_add_data(pdev, data, size);
> +	if (ret)
> +		goto dev_put;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto dev_put;
> +
> +	return pdev;
> +
> +dev_put:
> +	platform_device_put(pdev);
> +
> +	return ERR_PTR(ret);
> +}
> diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h
> new file mode 100644
> index 000000000000..5e9ac788670a
> --- /dev/null
> +++ b/include/acpi/ras2_acpi.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RAS2 ACPI driver header file
> + *
> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
> + *
> + * Copyright (c) 2024 HiSilicon Limited
> + */
> +
> +#ifndef _RAS2_ACPI_H
> +#define _RAS2_ACPI_H
> +
> +#include <linux/acpi.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/types.h>
> +#include <acpi/pcc.h>
> +
> +#define RAS2_PCC_CMD_COMPLETE 1
> +
> +/* RAS2 specific PCC commands */
> +#define RAS2_PCC_CMD_EXEC 0x01
> +
> +#define RAS2_FAILURE 0
> +#define RAS2_SUCCESS 1
> +
> +/*
> + * Arbitrary Retries for PCC commands because the
> + * remote processor could be much slower to reply.
> + */
> +#define RAS2_NUM_RETRIES 600
> +
> +/*
> + * Data structures for PCC communication and RAS2 table
> + */
> +struct ras2_context {
> +	struct device *dev;
> +	int id;
> +	struct mbox_client mbox_client;
> +	struct pcc_mbox_chan *pcc_chan;
> +	void __iomem *pcc_comm_addr;
> +	u64 comm_base_addr;
> +	int pcc_subspace_idx;
> +	bool pcc_channel_acquired;
> +	ktime_t deadline;
> +	unsigned int pcc_mpar;
> +	unsigned int pcc_mrtt;
> +	/* Lock to provide mutually exclusive access to PCC channel */
> +	spinlock_t spinlock;
> +	struct device *scrub_dev;
> +	const struct ras2_hw_scrub_ops *ops;
> +};
> +
> +struct platform_device *ras2_add_platform_device(char *name, const void *data,
> +						 size_t size);
> +int ras2_send_pcc_cmd(struct ras2_context *ras2_ctx, u16 cmd);
> +int ras2_register_pcc_channel(struct ras2_context *ras2_ctx);
> +int ras2_unregister_pcc_channel(struct ras2_context *ras2_ctx);
> +#endif /* _RAS2_ACPI_H */
> -- 
> 2.34.1
> 

