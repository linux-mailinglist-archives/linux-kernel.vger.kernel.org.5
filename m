Return-Path: <linux-kernel+bounces-104364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7387CCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDF4B21C34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074231BC22;
	Fri, 15 Mar 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MwAvTPay"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B481BC59;
	Fri, 15 Mar 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503124; cv=none; b=V9hD6SxiOm0iIyQgUDJIxJmHkKG99hr29x8nJHNgCI1+biW+vdmm56y5sWAOnWDYL0o32JdfDMYkJrPh0GrOniudd4x0pfvJ/bHF9vHRbKJ6GSuSFG4XOsxZGtSCuco97GzOtShbFoutQhHGA+hxFiT60lwfF5dHoDVtvMP/7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503124; c=relaxed/simple;
	bh=xADKVOnSLQ/eSoxk0F4pbiiTRO2FBYoibk1GxdCL7Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFpIZAM3G/V6LH5nmJlrGlN0Ge+oON62uEtKOXuGkvt8K2siTMGd7sMNDRuF3Et6J5CXzutgX8gwqX9FSY0whfGhZAdwCb9yPc4x9/ZLZYTa6cLGXWrxqnfIurcSTQFZlKMHRxZ7R2vbRmKX38GlHP79tKodKdma8KH0zlTpNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MwAvTPay; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CFDBE0005;
	Fri, 15 Mar 2024 11:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710503120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0kqNtL6G3XJ3YlpCpRDs+8Ulm0OGWV3L8/ec8/EvgA=;
	b=MwAvTPaym4uwlN1C1EKgYc3IKFvTxnhIr+kXMPITBXU9heEQTwKc5yqIMpdk4aDLrsHsFr
	EMDVVDpRFOb71CDe8L7p5WJkkCEUlEj07gGU1kjv7/NSUeCrpkPEIKkEGMZgLlZx70O7LF
	F4JTHrNdYsnCy0kGE/VSaK8rjaVTOS4f5+gVih9kw3MDFbYvhLwXKDjTYk+lpyY9tRGfdj
	OrTvX+x2Tw+5/DFixsU306TRTcsuszxO1Pvrx10j1ycpHpRK96t2KP3baGsi7Bp9Q78tr0
	MJdjRBo3stvEKHJL9Dj74IHYauC5nn3YgYYKHN9HfT5mzCJ/K0K+uqEuK4Y8rA==
Date: Fri, 15 Mar 2024 12:45:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 neil.armstrong@linaro.org, daniel@makrotopia.org, arnd@arndb.de,
 chris.packham@alliedtelesis.co.nz, christophe.kerello@foss.st.com,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com
Subject: Re: [PATCH v4 2/5] drivers: mtd: nand: Add qpic_common API file
Message-ID: <20240315124517.4a546ce9@xps-13>
In-Reply-To: <20240308091752.16136-3-quic_mdalam@quicinc.com>
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
	<20240308091752.16136-3-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> +/**
> + * qcom_qpic_bam_dma_done() - Callback for DMA descriptor completion
> + * @data: data pointer
> + *
> + * This function is a callback for DMA descriptor completion
> + */
> +void qcom_qpic_bam_dma_done(void *data)
> +{
> +	struct bam_transaction *bam_txn =3D data;
> +
> +	/*
> +	 * In case of data transfer with NAND, 2 callbacks will be generated.
> +	 * One for command channel and another one for data channel.
> +	 * If current transaction has data descriptors
> +	 * (i.e. wait_second_completion is true), then set this to false
> +	 * and wait for second DMA descriptor completion.
> +	 */
> +	if (bam_txn->wait_second_completion)
> +		bam_txn->wait_second_completion =3D false;
> +	else
> +		complete(&bam_txn->txn_done);

Can't you just call "wait" and "complete" twice? It's supposed to be
handled by the API. This is totally racy.

> +}
> +
> +/**
> + * qcom_nandc_read_buffer_sync() - Check for dma sync for cpu or device
> + * @nandc: qpic nand controller
> + * @is_cpu: cpu or Device

? the naming is really strange dev_to_mem or something like that would
probably be more helpful.

> + *
> + * This function will check for dma sync for cpu or device
> + */
> +void qcom_nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
> +				 bool is_cpu)
> +{
> +	if (!nandc->props->is_bam)
> +		return;
> +
> +	if (is_cpu)
> +		dma_sync_single_for_cpu(nandc->dev, nandc->reg_read_dma,
> +					MAX_REG_RD *
> +					sizeof(*nandc->reg_read_buf),
> +					DMA_FROM_DEVICE);
> +	else
> +		dma_sync_single_for_device(nandc->dev, nandc->reg_read_dma,
> +					   MAX_REG_RD *
> +					   sizeof(*nandc->reg_read_buf),
> +					   DMA_FROM_DEVICE);
> +}
> +
> +/**
> + * qcom_offset_to_nandc_reg() - Get the actual offset
> + * @regs: pointer to nandc_reg structure
> + * @offset: register offset
> + *
> + * This function will reurn the actual offset for qpic controller regist=
er
> + */
> +__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset)
> +{
> +	switch (offset) {
> +	case NAND_FLASH_CMD:
> +		return &regs->cmd;
> +	case NAND_ADDR0:
> +		return &regs->addr0;
> +	case NAND_ADDR1:
> +		return &regs->addr1;
> +	case NAND_FLASH_CHIP_SELECT:
> +		return &regs->chip_sel;
> +	case NAND_EXEC_CMD:
> +		return &regs->exec;
> +	case NAND_FLASH_STATUS:
> +		return &regs->clrflashstatus;
> +	case NAND_DEV0_CFG0:
> +		return &regs->cfg0;
> +	case NAND_DEV0_CFG1:
> +		return &regs->cfg1;
> +	case NAND_DEV0_ECC_CFG:
> +		return &regs->ecc_bch_cfg;
> +	case NAND_READ_STATUS:
> +		return &regs->clrreadstatus;
> +	case NAND_DEV_CMD1:
> +		return &regs->cmd1;
> +	case NAND_DEV_CMD1_RESTORE:
> +		return &regs->orig_cmd1;
> +	case NAND_DEV_CMD_VLD:
> +		return &regs->vld;
> +	case NAND_DEV_CMD_VLD_RESTORE:
> +		return &regs->orig_vld;
> +	case NAND_EBI2_ECC_BUF_CFG:
> +		return &regs->ecc_buf_cfg;
> +	case NAND_READ_LOCATION_0:
> +		return &regs->read_location0;
> +	case NAND_READ_LOCATION_1:
> +		return &regs->read_location1;
> +	case NAND_READ_LOCATION_2:
> +		return &regs->read_location2;
> +	case NAND_READ_LOCATION_3:
> +		return &regs->read_location3;
> +	case NAND_READ_LOCATION_LAST_CW_0:
> +		return &regs->read_location_last0;
> +	case NAND_READ_LOCATION_LAST_CW_1:
> +		return &regs->read_location_last1;
> +	case NAND_READ_LOCATION_LAST_CW_2:
> +		return &regs->read_location_last2;
> +	case NAND_READ_LOCATION_LAST_CW_3:
> +		return &regs->read_location_last3;

Why do you need this indirection?

> +	default:
> +		return NULL;
> +	}
> +}
> +

..

> +/**
> + * qcom_clear_bam_transaction() - Clears the BAM transaction
> + * @nandc: qpic nand controller
> + *
> + * This function will clear the BAM transaction indexes.
> + */
> +void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc)
> +{
> +	struct bam_transaction *bam_txn =3D nandc->bam_txn;
> +
> +	if (!nandc->props->is_bam)
> +		return;
> +
> +	bam_txn->bam_ce_pos =3D 0;
> +	bam_txn->bam_ce_start =3D 0;
> +	bam_txn->cmd_sgl_pos =3D 0;
> +	bam_txn->cmd_sgl_start =3D 0;
> +	bam_txn->tx_sgl_pos =3D 0;
> +	bam_txn->tx_sgl_start =3D 0;
> +	bam_txn->rx_sgl_pos =3D 0;
> +	bam_txn->rx_sgl_start =3D 0;
> +	bam_txn->last_data_desc =3D NULL;
> +	bam_txn->wait_second_completion =3D false;

What about using memset here?

> +
> +	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
> +		      QPIC_PER_CW_CMD_SGL);
> +	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
> +		      QPIC_PER_CW_DATA_SGL);
> +
> +	reinit_completion(&bam_txn->txn_done);
> +}

..

> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nan=
d-qpic-common.h
> new file mode 100644
> index 000000000000..aced15866627
> --- /dev/null
> +++ b/include/linux/mtd/nand-qpic-common.h
> @@ -0,0 +1,486 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * QCOM QPIC common APIs header file
> + *
> + * Copyright (c) 2023 Qualcomm Inc.
> + * Authors:     Md sadre Alam           <quic_mdalam@quicinc.com>
> + *		Sricharan R             <quic_srichara@quicinc.com>
> + *		Varadarajan Narayanan   <quic_varada@quicinc.com>
> + *
> + */
> +#ifndef __MTD_NAND_QPIC_COMMON_H__
> +#define __MTD_NAND_QPIC_COMMON_H__
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma/qcom_adm.h>
> +#include <linux/dma/qcom_bam_dma.h>
> +#include <linux/module.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/rawnand.h>

You really need this?

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/* NANDc reg offsets */
> +#define	NAND_FLASH_CMD			0x00
> +#define	NAND_ADDR0			0x04
> +#define	NAND_ADDR1			0x08
> +#define	NAND_FLASH_CHIP_SELECT		0x0c
> +#define	NAND_EXEC_CMD			0x10
> +#define	NAND_FLASH_STATUS		0x14
> +#define	NAND_BUFFER_STATUS		0x18
> +#define	NAND_DEV0_CFG0			0x20
> +#define	NAND_DEV0_CFG1			0x24
> +#define	NAND_DEV0_ECC_CFG		0x28
> +#define	NAND_AUTO_STATUS_EN		0x2c
> +#define	NAND_DEV1_CFG0			0x30
> +#define	NAND_DEV1_CFG1			0x34
> +#define	NAND_READ_ID			0x40
> +#define	NAND_READ_STATUS		0x44
> +#define	NAND_DEV_CMD0			0xa0
> +#define	NAND_DEV_CMD1			0xa4
> +#define	NAND_DEV_CMD2			0xa8
> +#define	NAND_DEV_CMD_VLD		0xac
> +#define	SFLASHC_BURST_CFG		0xe0
> +#define	NAND_ERASED_CW_DETECT_CFG	0xe8
> +#define	NAND_ERASED_CW_DETECT_STATUS	0xec
> +#define	NAND_EBI2_ECC_BUF_CFG		0xf0
> +#define	FLASH_BUF_ACC			0x100
> +

..

> +/*
> + * This data type corresponds to the NAND controller properties which va=
ries
> + * among different NAND controllers.
> + * @ecc_modes - ecc mode for NAND

Should this member be an enum?

> + * @dev_cmd_reg_start - NAND_DEV_CMD_* registers starting offset
> + * @is_bam - whether NAND controller is using BAM

has_bam_support? supports_bam?

> + * @is_qpic - whether NAND CTRL is part of qpic IP

CTRL? do you mean controller?

> + * @qpic_v2 - flag to indicate QPIC IP version 2
> + * @use_codeword_fixup - whether NAND has different layout for boot part=
itions

The doc is clear but the member name is terrible. Please clarify the
naming.

> + */
> +struct qcom_nandc_props {
> +	u32 ecc_modes;
> +	u32 dev_cmd_reg_start;
> +	bool is_bam;
> +	bool is_qpic;
> +	bool qpic_v2;
> +	bool use_codeword_fixup;
> +};
> +
> +void config_nand_page_read(struct nand_chip *chip);
> +void qcom_qpic_bam_dma_done(void *data);
> +void qcom_nandc_read_buffer_sync(struct qcom_nand_controller *nandc, boo=
l is_cpu);
> +__le32 *qcom_offset_to_nandc_reg(struct nandc_regs *regs, int offset);
> +int qcom_prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,
> +			   int reg_off, const void *vaddr, int size,
> +			bool flow_control);
> +int qcom_submit_descs(struct qcom_nand_controller *nandc);
> +int qcom_prepare_bam_async_desc(struct qcom_nand_controller *nandc,
> +				struct dma_chan *chan, unsigned long flags);
> +int qcom_prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool =
read,
> +			       int reg_off, const void *vaddr,
> +			int size, unsigned int flags);
> +int qcom_prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool=
 read,
> +				const void *vaddr,
> +			int size, unsigned int flags);
> +int qcom_read_reg_dma(struct qcom_nand_controller *nandc, int first,
> +		      int num_regs, unsigned int flags);
> +int qcom_write_reg_dma(struct qcom_nand_controller *nandc, int first,
> +		       int num_regs, unsigned int flags);
> +int qcom_read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
> +		       const u8 *vaddr, int size, unsigned int flags);
> +int qcom_write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
> +			const u8 *vaddr, int size, unsigned int flags);
> +struct bam_transaction *qcom_alloc_bam_transaction(struct qcom_nand_cont=
roller *nandc);
> +void qcom_clear_bam_transaction(struct qcom_nand_controller *nandc);
> +void qcom_nandc_unalloc(struct qcom_nand_controller *nandc);
> +int qcom_nandc_alloc(struct qcom_nand_controller *nandc);
> +void qcom_clear_read_regs(struct qcom_nand_controller *nandc);
> +void qcom_free_bam_transaction(struct qcom_nand_controller *nandc);
> +#endif

I made several requests on code that already exists, please add these
changes to your series.


Also, this patching being big, please split:
1- rename your all your symbols to start with the same prefix
(qcom_nand_ instead of nothing or just qcom)
2- then perform the move, which should not require changing the names
of all the functions everywhere.

Thanks,
Miqu=C3=A8l

