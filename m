Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22A7DD084
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbjJaP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJaP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:29:07 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CEC9F;
        Tue, 31 Oct 2023 08:29:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 363031C000B;
        Tue, 31 Oct 2023 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698766141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPYUkZNPreY88VDhOmVn3AFyOFRRtuLzyph5YgbM3vw=;
        b=eP6LsbtTgo6LDa5+lKR/f83CNNGqISbapv0U2I6aLXb3X2fCHkzNPjvbXI1xd8xmC8qEsu
        ZP+B3iYZkLiCfqYxfwRtRmYIgodRCtj5xUMpZ3+md0+S3mkMWhz3PmgtFW8ZtViHj+2oA7
        0Fr17W394i8zUeZPr8rGCvn86z/D01hN4L1Hj/MfJUbqhT33IcrHURRtb4+JEzcNukl009
        UNfV5KwMIhT5KmeWzzo1hY1mHENs+Of8aq//RVhE9iono7AxX+yNSFJLx18/ot9RPr/qEc
        xNLLGDLNcQaWDcmYUZQa22+G2wydV42L2Qq+LzH0euWuFOiOUQMIlhiu7as/qQ==
Date:   Tue, 31 Oct 2023 16:28:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        quic_srichara@quicinc.com, qpic_varada@quicinc.com
Subject: Re: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine
 Driver
Message-ID: <20231031162856.1d9e3246@xps-13>
In-Reply-To: <20231031120307.1600689-2-quic_mdalam@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
        <20231031120307.1600689-2-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

quic_mdalam@quicinc.com wrote on Tue, 31 Oct 2023 17:33:03 +0530:

Commit log is missing.

> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>

If Sricharan is a co developer you need to use the right tags. Please
have a look at the documentation. Using the two SoB here does not mean
anything.

> ---
>  drivers/mtd/nand/Kconfig    |   7 ++
>  drivers/mtd/nand/Makefile   |   1 +
>  drivers/mtd/nand/ecc-qcom.c | 198 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/mtd/nand/ecc-qcom.c
>=20
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 5b0c2c95f10c..333cec8187c8 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -61,6 +61,13 @@ config MTD_NAND_ECC_MEDIATEK
>  	help
>  	  This enables support for the hardware ECC engine from Mediatek.
> =20
> +config MTD_NAND_ECC_QCOM
> +	tristate "Qualcomm hardware ECC engine"
> +	depends on ARCH_QCOM

Same comment as Mark regarding COMPILE_TEST

> +	select MTD_NAND_ECC
> +	help
> +	  This enables support for the hardware ECC engine from Qualcomm.
> +
>  endmenu
> =20
>  endmenu
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 19e1291ac4d5..c73b8a3456ec 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -3,6 +3,7 @@
>  nandcore-objs :=3D core.o bbt.o
>  obj-$(CONFIG_MTD_NAND_CORE) +=3D nandcore.o
>  obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) +=3D ecc-mtk.o
> +obj-$(CONFIG_MTD_NAND_ECC_QCOM) +=3D ecc-qcom.o qpic_common.o
> =20
>  obj-y	+=3D onenand/
>  obj-y	+=3D raw/
> diff --git a/drivers/mtd/nand/ecc-qcom.c b/drivers/mtd/nand/ecc-qcom.c
> new file mode 100644
> index 000000000000..a85423ed368a
> --- /dev/null
> +++ b/drivers/mtd/nand/ecc-qcom.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * QCOM ECC Engine  Driver.
> + * Copyright (C) 2023  Qualcomm Inc.
> + * Authors:	Md sadre Alam		<quic_mdalam@quicinc.com>
> + *		Sricharan R		<quic_srichara@quicinc.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/mutex.h>
> +#include <linux/mtd/nand-qpic-common.h>
> +
> +
> +
> +/* ECC modes supported by the controller */
> +#define ECC_NONE        BIT(0)
> +#define ECC_RS_4BIT     BIT(1)
> +#define ECC_BCH_4BIT    BIT(2)
> +#define ECC_BCH_8BIT    BIT(3)
> +
> +struct qpic_ecc_caps {
> +	u32 err_mask;
> +	u32 err_shift;
> +	const u8 *ecc_strength;
> +	const u32 *ecc_regs;
> +	u8 num_ecc_strength;
> +	u8 ecc_mode_shift;
> +	u32 parity_bits;
> +	int pg_irq_sel;
> +};
> +
> +
> +struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct qcom_nand_host, chip);
> +}
> +EXPORT_SYMBOL(to_qcom_nand_host);
> +
> +struct qcom_nand_controller *
> +get_qcom_nand_controller(struct nand_chip *chip)
> +{
> +	return container_of(chip->controller, struct qcom_nand_controller,
> +			    controller);
> +}
> +EXPORT_SYMBOL(get_qcom_nand_controller);
> +
> +static struct qpic_ecc *qpic_ecc_get(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct qpic_ecc *ecc;
> +
> +	pdev =3D of_find_device_by_node(np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	ecc =3D platform_get_drvdata(pdev);
> +	if (!ecc) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	return ecc;
> +}
> +
> +struct qpic_ecc *of_qpic_ecc_get(struct device_node *of_node)
> +{
> +	struct qpic_ecc *ecc =3D NULL;
> +	struct device_node *np;
> +
> +	np =3D of_parse_phandle(of_node, "nand-ecc-engine", 0);
> +	/* for backward compatibility */

There is no backward compatibility to handle upstream

> +	if (!np)
> +		np =3D of_parse_phandle(of_node, "ecc-engine", 0);
> +	if (np) {
> +		ecc =3D qpic_ecc_get(np);
> +		of_node_put(np);
> +	}
> +
> +	return ecc;
> +}
> +EXPORT_SYMBOL(of_qpic_ecc_get);
> +
> +int qcom_ecc_config(struct qpic_ecc  *ecc, int ecc_strength,
> +			bool wide_bus)
> +{
> +	ecc->ecc_modes =3D (ECC_RS_4BIT | ECC_BCH_8BIT);
> +
> +	if (ecc_strength >=3D 8) {

If your engine does not support more than an 8-bit strength this
condition seems a bit strange.

> +		/* 8 bit ECC defaults to BCH ECC on all platforms */
> +		ecc->bch_enabled =3D true;
> +		ecc->ecc_mode =3D 1;

ecc_modes above, ecc_mode here, not very clear what this is.
Please give meaningful names to your variables, not just the bit name
that this is capturing because here it's unclear what this is.

> +
> +		if (wide_bus) {
> +			ecc->ecc_bytes_hw =3D 14;
> +			ecc->spare_bytes =3D 0;

Spare bytes depend on the flash, you can't use constant values like
that.

I also don't understand what wide_bus is and why it has an impact of
only 1 on the number of ECC bytes. Please make all this more explicit.

> +			ecc->bbm_size =3D 2;
> +		} else {
> +			ecc->ecc_bytes_hw =3D 13;
> +			ecc->spare_bytes =3D 2;
> +			ecc->bbm_size =3D 1;
> +		}
> +	} else {
> +		/*
> +		 * if the controller supports BCH for 4 bit ECC, the controller
> +		 * uses lesser bytes for ECC. If RS is used, the ECC bytes is
> +		 * always 10 bytes
> +		 */
> +		if (ecc->ecc_modes & ECC_BCH_4BIT) {
> +			/* BCH */
> +			ecc->bch_enabled =3D true;
> +			ecc->ecc_mode =3D 0;
> +			if (wide_bus) {
> +				ecc->ecc_bytes_hw =3D 8;
> +				ecc->spare_bytes =3D 2;
> +				ecc->bbm_size =3D 2;
> +			} else {
> +				ecc->ecc_bytes_hw =3D 7;
> +				ecc->spare_bytes =3D 4;
> +				ecc->bbm_size =3D 1;
> +			}
> +		} else {
> +			/* RS */
> +			ecc->ecc_bytes_hw =3D 10;
> +			if (wide_bus) {
> +				ecc->spare_bytes =3D 0;
> +				ecc->bbm_size =3D 2;
> +			} else {
> +				ecc->spare_bytes =3D 1;
> +				ecc->bbm_size =3D 1;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(qcom_ecc_config);

Thanks,
Miqu=C3=A8l
