Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D27DD0FD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjJaPyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbjJaPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:54:18 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A048F;
        Tue, 31 Oct 2023 08:54:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A01FC6000D;
        Tue, 31 Oct 2023 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698767650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFpuhFdEBzHaLiA0OeJ+8Qf/mgpHnhSrpmbF/xo4GW0=;
        b=JHsOAC+H3igsiQMlOeBjGjQxduzkExQYnyjrg+5kZ90nf+FVEeKWVAJlfAxE2yU8EwbdaC
        bVTNPziOMVzhcxKXd6pW+BX+lm4/IsOVxOjnnIzYNmU7inGzoPR6wXNHen8qi5VU6Rc5dx
        VFA0BODYV79rl3OuPgQmgNx+pBkE0urd9NwaAjXw5Ib1mnXVrdBR4iEeea5easVrDiV3jI
        qnKGR5hM41dbmNPXsiniPLo7gYaCC2BdGKDMWhfesoDqY/b/L3ZoyKwDnPQ/Gsf33YPNkS
        QQstiaHt0OrRFQ4Hp+eKXsLmrn9sQUWYiShXik7oAj7pczWpT5LJBkIZ38hfFA==
Date:   Tue, 31 Oct 2023 16:54:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        quic_srichara@quicinc.com, qpic_varada@quicinc.com
Subject: Re: [RFC PATCH 3/5] mtd: nand: qpic_common: Add support for qpic
 common API
Message-ID: <20231031165406.33e486a3@xps-13>
In-Reply-To: <20231031120307.1600689-4-quic_mdalam@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
        <20231031120307.1600689-4-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

quic_mdalam@quicinc.com wrote on Tue, 31 Oct 2023 17:33:05 +0530:

> Add qpic command API in sperate file so that it will be
> use by both spi and request and raw nand request.

		nand?

>=20
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> ---
>  drivers/mtd/nand/qpic_common.c       | 840 +++++++++++++++++++++++++++
>  include/linux/mtd/nand-qpic-common.h | 641 ++++++++++++++++++++
>  2 files changed, 1481 insertions(+)
>  create mode 100644 drivers/mtd/nand/qpic_common.c
>  create mode 100644 include/linux/mtd/nand-qpic-common.h
>=20
> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_commo=
n.c
> new file mode 100644
> index 000000000000..983768a1ea94
> --- /dev/null
> +++ b/drivers/mtd/nand/qpic_common.c
> @@ -0,0 +1,840 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * QPIC common API file.
> + * Copyright (C) 2023  Qualcomm Inc.
> + * Authors:	Md sadre Alam		<quic_mdalam@quicinc.com>
> + *		Sricharan R		<quic_srichara@quicinc.com>
> + */
> +
> +#include <linux/mtd/nand-qpic-common.h>
> +
> +/* Frees the BAM transaction memory */
> +void free_bam_transaction(struct qcom_nand_controller *nandc)

This is not a generic object, it's not meant to be shared with spi. So
if it's meant to be used in a single place, please don't share it.
Otherwise please use a more generic name.

> +{
> +	struct bam_transaction *bam_txn =3D nandc->bam_txn;
> +
> +	devm_kfree(nandc->dev, bam_txn);
> +}
> +EXPORT_SYMBOL(free_bam_transaction);
> +
> +/* Callback for DMA descriptor completion */
> +void qpic_bam_dma_done(void *data)
> +{
> +	struct bam_transaction *bam_txn =3D data;

Just provide the right pointer in the first place.

> +
> +	/*
> +	 * In case of data transfer with NAND, 2 callbacks will be generated.

What if we are not dealing with a NAND?

> +	 * One for command channel and another one for data channel.
> +	 * If current transaction has data descriptors
> +	 * (i.e. wait_second_completion is true), then set this to false

Why do you need a boolean for that if having a data descriptor is the
condition you want to check against?

> +	 * and wait for second DMA descriptor completion.
> +	 */
> +	if (bam_txn->wait_second_completion)
> +		bam_txn->wait_second_completion =3D false;

This looks very racy.

> +	else
> +		complete(&bam_txn->txn_done);
> +}
> +EXPORT_SYMBOL(qpic_bam_dma_done);
> +
> +u32 nandc_read(struct qcom_nand_controller *nandc, int offset)
> +{
> +	return ioread32(nandc->base + offset);

I don't see the need for that.

> +}
> +EXPORT_SYMBOL(nandc_read);
> +
> +void nandc_write(struct qcom_nand_controller *nandc, int offset,
> +			       u32 val)
> +{
> +	iowrite32(val, nandc->base + offset);

Same here.

> +}
> +EXPORT_SYMBOL(nandc_write);
> +
> +void nandc_read_buffer_sync(struct qcom_nand_controller *nandc,
> +					  bool is_cpu)
> +{
> +	if (!nandc->props->is_bam)
> +		return;

I thought BAM was a per transaction thing, and here you check it
against a controller parameter. It looks wrong.

> +
> +	if (is_cpu)

Whuut? naming, naming, naming, naming. Please.

> +		dma_sync_single_for_cpu(nandc->dev, nandc->reg_read_dma,
> +					MAX_REG_RD *

Remove this new line

> +					sizeof(*nandc->reg_read_buf),

Are you sure this sizeof() is safe?

> +					DMA_FROM_DEVICE);
> +	else
> +		dma_sync_single_for_device(nandc->dev, nandc->reg_read_dma,
> +					   MAX_REG_RD *
> +					   sizeof(*nandc->reg_read_buf),
> +					   DMA_FROM_DEVICE);
> +}

You better have a really good reason to sync in the middle of an
operation...

> +EXPORT_SYMBOL(nandc_read_buffer_sync);
> +
> +__le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
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
> +	case NAND_FLASH_SPI_CFG:
> +		return &regs->spi_cfg;
> +	case NAND_NUM_ADDR_CYCLES:
> +		return &regs->num_addr_cycle;
> +	case NAND_BUSY_CHECK_WAIT_CNT:
> +		return &regs->busy_wait_cnt;
> +	case NAND_MSTR_CONFIG:
> +		return &regs->mstr_cfg;
> +	case NAND_FLASH_FEATURES:
> +		return &regs->flash_feature;

Just... no? What is the point of using an intermediate int here? just
dereference the right value?

> +	default:
> +		return NULL;
> +	}
> +}
> +EXPORT_SYMBOL(offset_to_nandc_reg);
> +
> +/* reset the register read buffer for next NAND operation */
> +void clear_read_regs(struct qcom_nand_controller *nandc)
> +{
> +	nandc->reg_read_pos =3D 0;
> +	nandc_read_buffer_sync(nandc, false);
> +}
> +EXPORT_SYMBOL(clear_read_regs);
> +
> +int prep_adm_dma_desc(struct qcom_nand_controller *nandc, bool read,

adm?


Please always prefix your symbols (especially when exporting them) with
a decent a easy to recognize prefix.

> +			     int reg_off, const void *vaddr, int size,
> +			     bool flow_control)
> +{
> +	struct desc_info *desc;
> +	struct dma_async_tx_descriptor *dma_desc;
> +	struct scatterlist *sgl;
> +	struct dma_slave_config slave_conf;
> +	struct qcom_adm_peripheral_config periph_conf =3D {};
> +	enum dma_transfer_direction dir_eng;
> +	int ret;
> +
> +	desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	sgl =3D &desc->adm_sgl;
> +
> +	sg_init_one(sgl, vaddr, size);
> +
> +	if (read) {
> +		dir_eng =3D DMA_DEV_TO_MEM;
> +		desc->dir =3D DMA_FROM_DEVICE;
> +	} else {
> +		dir_eng =3D DMA_MEM_TO_DEV;
> +		desc->dir =3D DMA_TO_DEVICE;
> +	}
> +
> +	ret =3D dma_map_sg(nandc->dev, sgl, 1, desc->dir);
> +	if (ret =3D=3D 0) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	memset(&slave_conf, 0x00, sizeof(slave_conf));
> +
> +	slave_conf.device_fc =3D flow_control;
> +	if (read) {
> +		slave_conf.src_maxburst =3D 16;
> +		slave_conf.src_addr =3D nandc->base_dma + reg_off;
> +		if (nandc->data_crci) {
> +			periph_conf.crci =3D nandc->data_crci;
> +			slave_conf.peripheral_config =3D &periph_conf;
> +			slave_conf.peripheral_size =3D sizeof(periph_conf);
> +		}
> +	} else {
> +		slave_conf.dst_maxburst =3D 16;
> +		slave_conf.dst_addr =3D nandc->base_dma + reg_off;
> +		if (nandc->cmd_crci) {
> +			periph_conf.crci =3D nandc->cmd_crci;
> +			slave_conf.peripheral_config =3D &periph_conf;
> +			slave_conf.peripheral_size =3D sizeof(periph_conf);
> +		}
> +	}
> +
> +	ret =3D dmaengine_slave_config(nandc->chan, &slave_conf);
> +	if (ret) {
> +		dev_err(nandc->dev, "failed to configure dma channel\n");
> +		goto err;
> +	}
> +
> +	dma_desc =3D dmaengine_prep_slave_sg(nandc->chan, sgl, 1, dir_eng, 0);
> +	if (!dma_desc) {
> +		dev_err(nandc->dev, "failed to prepare desc\n");
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	desc->dma_desc =3D dma_desc;
> +
> +	list_add_tail(&desc->node, &nandc->desc_list);
> +
> +	return 0;
> +err:

your error path is missing steps

> +	kfree(desc);
> +
> +	return ret;
> +}
> +
> +/* helpers to submit/free our list of dma descriptors */
> +int submit_descs(struct qcom_nand_controller *nandc)
> +{
> +	struct desc_info *desc;
> +	dma_cookie_t cookie =3D 0;
> +	struct bam_transaction *bam_txn =3D nandc->bam_txn;
> +	int r;
> +
> +	if (nandc->props->is_bam) {
> +		if (bam_txn->rx_sgl_pos > bam_txn->rx_sgl_start) {
> +			r =3D prepare_bam_async_desc(nandc, nandc->rx_chan, 0);
> +			if (r)
> +				return r;
> +		}
> +
> +		if (bam_txn->tx_sgl_pos > bam_txn->tx_sgl_start) {
> +			r =3D prepare_bam_async_desc(nandc, nandc->tx_chan,
> +						   DMA_PREP_INTERRUPT);
> +			if (r)
> +				return r;
> +		}
> +
> +		if (bam_txn->cmd_sgl_pos > bam_txn->cmd_sgl_start) {
> +			r =3D prepare_bam_async_desc(nandc, nandc->cmd_chan,
> +						   DMA_PREP_CMD);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	list_for_each_entry(desc, &nandc->desc_list, node)
> +		cookie =3D dmaengine_submit(desc->dma_desc);
> +
> +	if (nandc->props->is_bam) {
> +		bam_txn->last_cmd_desc->callback =3D qpic_bam_dma_done;
> +		bam_txn->last_cmd_desc->callback_param =3D bam_txn;
> +		if (bam_txn->last_data_desc) {
> +			bam_txn->last_data_desc->callback =3D qpic_bam_dma_done;
> +			bam_txn->last_data_desc->callback_param =3D bam_txn;
> +			bam_txn->wait_second_completion =3D true;
> +		}
> +
> +		dma_async_issue_pending(nandc->tx_chan);
> +		dma_async_issue_pending(nandc->rx_chan);
> +		dma_async_issue_pending(nandc->cmd_chan);
> +
> +		if (!wait_for_completion_timeout(&bam_txn->txn_done,
> +						 QPIC_NAND_COMPLETION_TIMEOUT))
> +			return -ETIMEDOUT;
> +	} else {
> +		if (dma_sync_wait(nandc->chan, cookie) !=3D DMA_COMPLETE)
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(submit_descs);
> +
> +void free_descs(struct qcom_nand_controller *nandc)
> +{
> +	struct desc_info *desc, *n;
> +
> +	list_for_each_entry_safe(desc, n, &nandc->desc_list, node) {
> +		list_del(&desc->node);
> +
> +		if (nandc->props->is_bam)
> +			dma_unmap_sg(nandc->dev, desc->bam_sgl,
> +				     desc->sgl_cnt, desc->dir);
> +		else
> +			dma_unmap_sg(nandc->dev, &desc->adm_sgl, 1,
> +				     desc->dir);
> +
> +		kfree(desc);
> +	}
> +}
> +EXPORT_SYMBOL(free_descs);
> +
> +/*
> + * Maps the scatter gather list for DMA transfer and forms the DMA descr=
iptor
> + * for BAM. This descriptor will be added in the NAND DMA descriptor que=
ue
> + * which will be submitted to DMA engine.
> + */
> +int prepare_bam_async_desc(struct qcom_nand_controller *nandc,
> +				  struct dma_chan *chan,
> +				  unsigned long flags)
> +{
> +	struct desc_info *desc;
> +	struct scatterlist *sgl;
> +	unsigned int sgl_cnt;
> +	int ret;
> +	struct bam_transaction *bam_txn =3D nandc->bam_txn;
> +	enum dma_transfer_direction dir_eng;
> +	struct dma_async_tx_descriptor *dma_desc;
> +
> +	desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	if (chan =3D=3D nandc->cmd_chan) {
> +		sgl =3D &bam_txn->cmd_sgl[bam_txn->cmd_sgl_start];
> +		sgl_cnt =3D bam_txn->cmd_sgl_pos - bam_txn->cmd_sgl_start;
> +		bam_txn->cmd_sgl_start =3D bam_txn->cmd_sgl_pos;
> +		dir_eng =3D DMA_MEM_TO_DEV;
> +		desc->dir =3D DMA_TO_DEVICE;
> +	} else if (chan =3D=3D nandc->tx_chan) {
> +		sgl =3D &bam_txn->data_sgl[bam_txn->tx_sgl_start];
> +		sgl_cnt =3D bam_txn->tx_sgl_pos - bam_txn->tx_sgl_start;
> +		bam_txn->tx_sgl_start =3D bam_txn->tx_sgl_pos;
> +		dir_eng =3D DMA_MEM_TO_DEV;
> +		desc->dir =3D DMA_TO_DEVICE;
> +	} else {
> +		sgl =3D &bam_txn->data_sgl[bam_txn->rx_sgl_start];
> +		sgl_cnt =3D bam_txn->rx_sgl_pos - bam_txn->rx_sgl_start;
> +		bam_txn->rx_sgl_start =3D bam_txn->rx_sgl_pos;
> +		dir_eng =3D DMA_DEV_TO_MEM;
> +		desc->dir =3D DMA_FROM_DEVICE;
> +	}
> +
> +	sg_mark_end(sgl + sgl_cnt - 1);
> +	ret =3D dma_map_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
> +	if (ret =3D=3D 0) {
> +		dev_err(nandc->dev, "failure in mapping desc\n");
> +		kfree(desc);
> +		return -ENOMEM;
> +	}
> +
> +	desc->sgl_cnt =3D sgl_cnt;
> +	desc->bam_sgl =3D sgl;
> +
> +	dma_desc =3D dmaengine_prep_slave_sg(chan, sgl, sgl_cnt, dir_eng,
> +					   flags);
> +
> +	if (!dma_desc) {
> +		dev_err(nandc->dev, "failure in prep desc\n");
> +		dma_unmap_sg(nandc->dev, sgl, sgl_cnt, desc->dir);
> +		kfree(desc);
> +		return -EINVAL;
> +	}
> +
> +	desc->dma_desc =3D dma_desc;
> +
> +	/* update last data/command descriptor */
> +	if (chan =3D=3D nandc->cmd_chan)
> +		bam_txn->last_cmd_desc =3D dma_desc;
> +	else
> +		bam_txn->last_data_desc =3D dma_desc;
> +
> +	list_add_tail(&desc->node, &nandc->desc_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(prepare_bam_async_desc);
> +
> +/*
> + * Prepares the command descriptor for BAM DMA which will be used for NA=
ND
> + * register reads and writes. The command descriptor requires the command
> + * to be formed in command element type so this function uses the command
> + * element from bam transaction ce array and fills the same with required

ce?

> + * data. A single SGL can contain multiple command elements so
> + * NAND_BAM_NEXT_SGL will be used for starting the separate SGL
> + * after the current command element.
> + */
> +int prep_bam_dma_desc_cmd(struct qcom_nand_controller *nandc, bool read,
> +				 int reg_off, const void *vaddr,
> +				 int size, unsigned int flags)
> +{
> +	int bam_ce_size;
> +	int i, ret;
> +	struct bam_cmd_element *bam_ce_buffer;
> +	struct bam_transaction *bam_txn =3D nandc->bam_txn;
> +
> +	bam_ce_buffer =3D &bam_txn->bam_ce[bam_txn->bam_ce_pos];
> +
> +	/* fill the command desc */
> +	for (i =3D 0; i < size; i++) {
> +		if (read)
> +			bam_prep_ce(&bam_ce_buffer[i],
> +				    nandc_reg_phys(nandc, reg_off + 4 * i),
> +				    BAM_READ_COMMAND,
> +				    reg_buf_dma_addr(nandc,
> +						     (__le32 *)vaddr + i));
> +		else
> +			bam_prep_ce_le32(&bam_ce_buffer[i],
> +					 nandc_reg_phys(nandc, reg_off + 4 * i),
> +					 BAM_WRITE_COMMAND,
> +					 *((__le32 *)vaddr + i));

The _le handling looks really fragile.

> +	}
> +
> +	bam_txn->bam_ce_pos +=3D size;
> +
> +	/* use the separate sgl after this command */
> +	if (flags & NAND_BAM_NEXT_SGL) {
> +		bam_ce_buffer =3D &bam_txn->bam_ce[bam_txn->bam_ce_start];
> +		bam_ce_size =3D (bam_txn->bam_ce_pos -
> +				bam_txn->bam_ce_start) *
> +				sizeof(struct bam_cmd_element);
> +		sg_set_buf(&bam_txn->cmd_sgl[bam_txn->cmd_sgl_pos],
> +			   bam_ce_buffer, bam_ce_size);
> +		bam_txn->cmd_sgl_pos++;
> +		bam_txn->bam_ce_start =3D bam_txn->bam_ce_pos;
> +
> +		if (flags & NAND_BAM_NWD) {
> +			ret =3D prepare_bam_async_desc(nandc, nandc->cmd_chan,
> +						     DMA_PREP_FENCE |
> +						     DMA_PREP_CMD);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(prep_bam_dma_desc_cmd);
> +
> +/*
> + * Prepares the data descriptor for BAM DMA which will be used for NAND
> + * data reads and writes.
> + */
> +int prep_bam_dma_desc_data(struct qcom_nand_controller *nandc, bool read,
> +				  const void *vaddr,
> +				  int size, unsigned int flags)
> +{
> +	int ret;
> +	struct bam_transaction *bam_txn =3D nandc->bam_txn;
> +
> +	if (read) {
> +		sg_set_buf(&bam_txn->data_sgl[bam_txn->rx_sgl_pos],
> +			   vaddr, size);
> +		bam_txn->rx_sgl_pos++;
> +	} else {
> +		sg_set_buf(&bam_txn->data_sgl[bam_txn->tx_sgl_pos],
> +			   vaddr, size);
> +		bam_txn->tx_sgl_pos++;
> +
> +		/*
> +		 * BAM will only set EOT for DMA_PREP_INTERRUPT so if this flag
> +		 * is not set, form the DMA descriptor
> +		 */
> +		if (!(flags & NAND_BAM_NO_EOT)) {
> +			ret =3D prepare_bam_async_desc(nandc, nandc->tx_chan,
> +						     DMA_PREP_INTERRUPT);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(prep_bam_dma_desc_data);
> +
> +/*
> + * read_reg_dma:	prepares a descriptor to read a given number of
> + *			contiguous registers to the reg_read_buf pointer
> + *
> + * @first:		offset of the first register in the contiguous block
> + * @num_regs:		number of registers to read
> + * @flags:		flags to control DMA descriptor preparation
> + */
> +int read_reg_dma(struct qcom_nand_controller *nandc, int first,
> +			int num_regs, unsigned int flags)
> +{
> +	bool flow_control =3D false;
> +	void *vaddr;
> +
> +	vaddr =3D nandc->reg_read_buf + nandc->reg_read_pos;
> +	nandc->reg_read_pos +=3D num_regs;
> +
> +	if (first =3D=3D NAND_DEV_CMD_VLD || first =3D=3D NAND_DEV_CMD1)
> +		first =3D dev_cmd_reg_addr(nandc, first);
> +
> +	if (nandc->props->is_bam)
> +		return prep_bam_dma_desc_cmd(nandc, true, first, vaddr,
> +					     num_regs, flags);
> +
> +	if (first =3D=3D NAND_READ_ID || first =3D=3D NAND_FLASH_STATUS)
> +		flow_control =3D true;

This flow_control property really bothers me.

> +
> +	return prep_adm_dma_desc(nandc, true, first, vaddr,
> +				 num_regs * sizeof(u32), flow_control);
> +}
> +EXPORT_SYMBOL(read_reg_dma);
> +
> +/*
> + * write_reg_dma:	prepares a descriptor to write a given number of
> + *			contiguous registers
> + *
> + * @first:		offset of the first register in the contiguous block
> + * @num_regs:		number of registers to write
> + * @flags:		flags to control DMA descriptor preparation
> + */
> +int write_reg_dma(struct qcom_nand_controller *nandc, int first,
> +			 int num_regs, unsigned int flags)
> +{
> +	bool flow_control =3D false;
> +	struct nandc_regs *regs =3D nandc->regs;
> +	void *vaddr;
> +
> +	vaddr =3D offset_to_nandc_reg(regs, first);
> +
> +	if (first =3D=3D NAND_ERASED_CW_DETECT_CFG) {
> +		if (flags & NAND_ERASED_CW_SET)
> +			vaddr =3D &regs->erased_cw_detect_cfg_set;
> +		else
> +			vaddr =3D &regs->erased_cw_detect_cfg_clr;
> +	}
> +
> +	if (first =3D=3D NAND_EXEC_CMD)
> +		flags |=3D NAND_BAM_NWD;
> +
> +	if (first =3D=3D NAND_FLASH_SPI_CFG || first =3D=3D NAND_NUM_ADDR_CYCLES
> +		|| first =3D=3D NAND_BUSY_CHECK_WAIT_CNT
> +		|| first =3D=3D NAND_MSTR_CONFIG)
> +		first =3D dev_cmd_reg_addr(nandc, first);
> +
> +	if (first =3D=3D NAND_DEV_CMD1_RESTORE || first =3D=3D NAND_DEV_CMD1)
> +		first =3D dev_cmd_reg_addr(nandc, NAND_DEV_CMD1);
> +
> +	if (first =3D=3D NAND_DEV_CMD_VLD_RESTORE || first =3D=3D NAND_DEV_CMD_=
VLD)
> +		first =3D dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD);
> +

What about a switch case here?

> +	if (nandc->props->is_bam)
> +		return prep_bam_dma_desc_cmd(nandc, false, first, vaddr,
> +					     num_regs, flags);
> +
> +	if (first =3D=3D NAND_FLASH_CMD)
> +		flow_control =3D true;
> +
> +	return prep_adm_dma_desc(nandc, false, first, vaddr,
> +				 num_regs * sizeof(u32), flow_control);
> +}
> +EXPORT_SYMBOL(write_reg_dma);
> +
> +/*
> + * read_data_dma:	prepares a DMA descriptor to transfer data from the
> + *			controller's internal buffer to the buffer 'vaddr'
> + *
> + * @reg_off:		offset within the controller's data buffer
> + * @vaddr:		virtual address of the buffer we want to write to
> + * @size:		DMA transaction size in bytes
> + * @flags:		flags to control DMA descriptor preparation
> + */
> +int read_data_dma(struct qcom_nand_controller *nandc, int reg_off,
> +			 const u8 *vaddr, int size, unsigned int flags)
> +{
> +	if (nandc->props->is_bam)
> +		return prep_bam_dma_desc_data(nandc, true, vaddr, size, flags);
> +
> +	return prep_adm_dma_desc(nandc, true, reg_off, vaddr, size, false);
> +}
> +EXPORT_SYMBOL(read_data_dma);
> +
> +/*
> + * write_data_dma:	prepares a DMA descriptor to transfer data from
> + *			'vaddr' to the controller's internal buffer
> + *
> + * @reg_off:		offset within the controller's data buffer
> + * @vaddr:		virtual address of the buffer we want to read from
> + * @size:		DMA transaction size in bytes
> + * @flags:		flags to control DMA descriptor preparation
> + */
> +int write_data_dma(struct qcom_nand_controller *nandc, int reg_off,
> +			  const u8 *vaddr, int size, unsigned int flags)
> +{
> +	if (nandc->props->is_bam)
> +		return prep_bam_dma_desc_data(nandc, false, vaddr, size, flags);
> +
> +	return prep_adm_dma_desc(nandc, false, reg_off, vaddr, size, false);
> +}
> +EXPORT_SYMBOL(write_data_dma);
> +
> +void nandc_set_reg(struct qcom_nand_controller *nandc, int offset,
> +			  u32 val)
> +{
> +	struct nandc_regs *regs =3D nandc->regs;
> +	__le32 *reg;
> +
> +	reg =3D offset_to_nandc_reg(regs, offset);
> +	if (reg)
> +		*reg =3D cpu_to_le32(val);
> +}
> +EXPORT_SYMBOL(nandc_set_reg);
> +
> +/* Allocates and Initializes the BAM transaction */
> +struct bam_transaction *
> +alloc_bam_transaction(struct qcom_nand_controller *nandc)
> +{
> +	struct bam_transaction *bam_txn;
> +	size_t bam_txn_size;
> +	unsigned int num_cw =3D nandc->max_cwperpage;
> +	void *bam_txn_buf;
> +
> +	bam_txn_size =3D
> +		sizeof(*bam_txn) + num_cw *
> +		((sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS) +
> +		(sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL) +
> +		(sizeof(*bam_txn->data_sgl) * QPIC_PER_CW_DATA_SGL));
> +
> +	bam_txn_buf =3D devm_kzalloc(nandc->dev, bam_txn_size, GFP_KERNEL);
> +	if (!bam_txn_buf)
> +		return NULL;
> +
> +	bam_txn =3D bam_txn_buf;
> +	bam_txn_buf +=3D sizeof(*bam_txn);
> +
> +	bam_txn->bam_ce =3D bam_txn_buf;
> +	bam_txn_buf +=3D
> +		sizeof(*bam_txn->bam_ce) * QPIC_PER_CW_CMD_ELEMENTS * num_cw;
> +
> +	bam_txn->cmd_sgl =3D bam_txn_buf;
> +	bam_txn_buf +=3D
> +		sizeof(*bam_txn->cmd_sgl) * QPIC_PER_CW_CMD_SGL * num_cw;
> +
> +	bam_txn->data_sgl =3D bam_txn_buf;
> +
> +	init_completion(&bam_txn->txn_done);
> +
> +	return bam_txn;
> +}
> +EXPORT_SYMBOL(alloc_bam_transaction);
> +
> +/* Clears the BAM transaction indexes */
> +void clear_bam_transaction(struct qcom_nand_controller *nandc)
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
> +
> +	sg_init_table(bam_txn->cmd_sgl, nandc->max_cwperpage *
> +		      QPIC_PER_CW_CMD_SGL);
> +	sg_init_table(bam_txn->data_sgl, nandc->max_cwperpage *
> +		      QPIC_PER_CW_DATA_SGL);
> +
> +	reinit_completion(&bam_txn->txn_done);
> +}
> +EXPORT_SYMBOL(clear_bam_transaction);
> +
> +/* one time setup of a few nand controller registers */

Does this needs to be shared?

> +int qcom_nandc_setup(struct qcom_nand_controller *nandc)
> +{
> +	u32 nand_ctrl;
> +
> +	/* kill onenand */
> +	if (!nandc->props->is_qpic)
> +		nandc_write(nandc, SFLASHC_BURST_CFG, 0);
> +
> +	if (!nandc->props->qpic_v2)
> +		nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
> +			    NAND_DEV_CMD_VLD_VAL);
> +
> +	/* enable ADM or BAM DMA */
> +	if (nandc->props->is_bam) {
> +		nand_ctrl =3D nandc_read(nandc, NAND_CTRL);
> +
> +		/*
> +		 *NAND_CTRL is an operational registers, and CPU
> +		 * access to operational registers are read only
> +		 * in BAM mode. So update the NAND_CTRL register
> +		 * only if it is not in BAM mode. In most cases BAM
> +		 * mode will be enabled in bootloader
> +		 */
> +		if (!(nand_ctrl & BAM_MODE_EN))
> +			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
> +	} else {
> +		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
> +	}
> +
> +	/* save the original values of these registers */
> +	if (!nandc->props->qpic_v2) {
> +		nandc->cmd1 =3D nandc_read(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD=
1));
> +		nandc->vld =3D NAND_DEV_CMD_VLD_VAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qcom_nandc_setup);
> +
> +void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
> +{
> +	if (nandc->props->is_bam) {
> +		if (!dma_mapping_error(nandc->dev, nandc->reg_read_dma))
> +			dma_unmap_single(nandc->dev, nandc->reg_read_dma,
> +					 MAX_REG_RD *
> +					 sizeof(*nandc->reg_read_buf),
> +					 DMA_FROM_DEVICE);
> +
> +		if (nandc->tx_chan)
> +			dma_release_channel(nandc->tx_chan);
> +
> +		if (nandc->rx_chan)
> +			dma_release_channel(nandc->rx_chan);
> +
> +		if (nandc->cmd_chan)
> +			dma_release_channel(nandc->cmd_chan);
> +	} else {
> +		if (nandc->chan)
> +			dma_release_channel(nandc->chan);
> +	}
> +}
> +EXPORT_SYMBOL(qcom_nandc_unalloc);
> +
> +int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
> +{
> +	int ret;
> +
> +	ret =3D dma_set_coherent_mask(nandc->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(nandc->dev, "failed to set DMA mask\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * we use the internal buffer for reading ONFI params, reading small
> +	 * data like ID and status, and preforming read-copy-write operations

performing

Please run checkpatch.pl, I believe the tool should catch these.

> +	 * when writing to a codeword partially. 532 is the maximum possible
> +	 * size of a codeword for our nand controller
> +	 */
> +	nandc->buf_size =3D 532;
> +
> +	nandc->data_buffer =3D devm_kzalloc(nandc->dev, nandc->buf_size,
> +					GFP_KERNEL);
> +	if (!nandc->data_buffer)
> +		return -ENOMEM;
> +
> +	nandc->regs =3D devm_kzalloc(nandc->dev, sizeof(*nandc->regs),
> +					GFP_KERNEL);
> +	if (!nandc->regs)
> +		return -ENOMEM;
> +
> +	nandc->reg_read_buf =3D devm_kcalloc(nandc->dev,
> +				MAX_REG_RD, sizeof(*nandc->reg_read_buf),
> +				GFP_KERNEL);
> +	if (!nandc->reg_read_buf)
> +		return -ENOMEM;
> +
> +	if (nandc->props->is_bam) {

It's probably the 10th time I ask, but what the heck is this is_bam
parameter showing? It looks like you're handling two different
controllers in the same driver without using different compatibles.

> +		nandc->reg_read_dma =3D
> +			dma_map_single(nandc->dev, nandc->reg_read_buf,
> +				       MAX_REG_RD *
> +				       sizeof(*nandc->reg_read_buf),
> +				       DMA_FROM_DEVICE);
> +		if (dma_mapping_error(nandc->dev, nandc->reg_read_dma)) {
> +			dev_err(nandc->dev, "failed to DMA MAP reg buffer\n");
> +			return -EIO;
> +		}
> +
> +		nandc->tx_chan =3D dma_request_chan(nandc->dev, "tx");
> +		if (IS_ERR(nandc->tx_chan)) {
> +			ret =3D PTR_ERR(nandc->tx_chan);
> +			nandc->tx_chan =3D NULL;
> +			dev_err_probe(nandc->dev, ret,
> +				      "tx DMA channel request failed\n");
> +			goto unalloc;
> +		}
> +
> +		nandc->rx_chan =3D dma_request_chan(nandc->dev, "rx");
> +		if (IS_ERR(nandc->rx_chan)) {
> +			ret =3D PTR_ERR(nandc->rx_chan);
> +			nandc->rx_chan =3D NULL;
> +			dev_err_probe(nandc->dev, ret,
> +				      "rx DMA channel request failed\n");
> +			goto unalloc;
> +		}
> +
> +		nandc->cmd_chan =3D dma_request_chan(nandc->dev, "cmd");
> +		if (IS_ERR(nandc->cmd_chan)) {
> +			ret =3D PTR_ERR(nandc->cmd_chan);
> +			nandc->cmd_chan =3D NULL;
> +			dev_err_probe(nandc->dev, ret,
> +				      "cmd DMA channel request failed\n");
> +			goto unalloc;
> +		}
> +
> +		/*
> +		 * Initially allocate BAM transaction to read ONFI param page.
> +		 * After detecting all the devices, this BAM transaction will
> +		 * be freed and the next BAM tranasction will be allocated with

Typo

> +		 * maximum codeword size
> +		 */
> +		nandc->max_cwperpage =3D 1;
> +		nandc->bam_txn =3D alloc_bam_transaction(nandc);
> +		if (!nandc->bam_txn) {
> +			dev_err(nandc->dev,
> +				"failed to allocate bam transaction\n");
> +			ret =3D -ENOMEM;
> +			goto unalloc;
> +		}
> +	} else {
> +		nandc->chan =3D dma_request_chan(nandc->dev, "rxtx");
> +		if (IS_ERR(nandc->chan)) {
> +			ret =3D PTR_ERR(nandc->chan);
> +			nandc->chan =3D NULL;
> +			dev_err_probe(nandc->dev, ret,
> +				      "rxtx DMA channel request failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	INIT_LIST_HEAD(&nandc->desc_list);
> +	INIT_LIST_HEAD(&nandc->host_list);
> +
> +	return 0;
> +unalloc:
> +	qcom_nandc_unalloc(nandc);
> +	return ret;
> +}
> +EXPORT_SYMBOL(qcom_nandc_alloc);
> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nan=
d-qpic-common.h
> new file mode 100644
> index 000000000000..c461c1781330
> --- /dev/null
> +++ b/include/linux/mtd/nand-qpic-common.h

...

> +	u32 cmd1, vld;
> +	bool exec_opwrite;
> +};
> +
> +/*
> + * NAND chip structure

qcom_nand_host is a nand chip structure?

> + *
> + * @boot_partitions:		array of boot partitions where offset and size of =
the
> + *				boot partitions are stored
> + *
> + * @chip:			base NAND chip structure
> + * @node:			list node to add itself to host_list in
> + *				qcom_nand_controller
> + *
> + * @nr_boot_partitions:		count of the boot partitions where spare data i=
s not
> + *				protected by ECC
> + *
> + * @cs:				chip select value for this chip
> + * @cw_size:			the number of bytes in a single step/codeword
> + *				of a page, consisting of all data, ecc, spare
> + *				and reserved bytes
> + * @cw_data:			the number of bytes within a codeword protected
> + *				by ECC
> + * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> + *				chip
> + *
> + * @last_command:		keeps track of last command on this chip. used
> + *				for reading correct status
> + *
> + * @cfg0, cfg1, cfg0_raw..:	NANDc register configurations needed for
> + *				ecc/non-ecc mode for the current nand flash
> + *				device
> + *
> + * @status:			value to be returned if NAND_CMD_STATUS command
> + *				is executed
> + * @codeword_fixup:		keep track of the current layout used by
> + *				the driver for read/write operation.
> + * @use_ecc:			request the controller to use ECC for the
> + *				upcoming read/write
> + * @bch_enabled:		flag to tell whether BCH ECC mode is used
> + */
> +struct qcom_nand_host {
> +	struct qcom_nand_boot_partition *boot_partitions;
> +
> +	struct nand_chip chip;
> +	struct list_head node;
> +
> +	int nr_boot_partitions;
> +
> +	int cs;
> +	int cw_size;
> +	int cw_data;
> +	int ecc_bytes_hw;
> +	int spare_bytes;
> +	int bbm_size;
> +
> +	int last_command;
> +
> +	u32 cfg0, cfg1;
> +	u32 cfg0_raw, cfg1_raw;
> +	u32 ecc_buf_cfg;
> +	u32 ecc_bch_cfg;
> +	u32 clrflashstatus;
> +	u32 clrreadstatus;
> +
> +	u8 status;
> +	bool codeword_fixup;
> +	bool use_ecc;
> +	bool bch_enabled;
> +};
> +

I would like to see how useful are all these exports. I believe the
current NAND controller driver already has some of these functions
defined, could you please move the functions rather than adding them
here without removing them in the other driver?

Thanks, Miqu=C3=A8l
