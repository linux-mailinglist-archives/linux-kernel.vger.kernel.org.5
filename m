Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F136E75311B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjGNFWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGNFVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:21:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB335A2;
        Thu, 13 Jul 2023 22:21:31 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E3rDLc014386;
        Fri, 14 Jul 2023 05:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5vSd/hopfSax2ciPgaKnIsL4ltsNrpB5Jy7Wxvdh6c8=;
 b=TTjxS4hXawxHNW1/s+3AbXxrg/PMZQgVGG1215OlW5t5oyzatRWcsO6+sY15b0f+TRpH
 3Nl114RvYOTLDb+YHmYAxfKR77hB6F1inqkYU2H0+zGookDGUYMJHnbYwBGbbVuMBNDg
 l8Pq6JGYdG9wu2eiOgtY+Lw6krxQ9dreLUS+nWOkqIakfuBD6sAxfj3pQzDksmrE7+7r
 6uiIusa3T9kW/1W4BNHH8vi90UsNq0TG/ggJLRbb0HMYPLPV/42outD5KktjC3MDdlBs
 egU5AyaYBKTF/W26XCUMCMuQR5GJca9Rg4BjYLMRUPeHXD6QMKm37X6GWDA/fwAYYKix gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptr0x5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:21:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E5LRFI005099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:21:27 GMT
Received: from [10.216.22.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 22:21:23 -0700
Message-ID: <17ed194b-ce5e-78a2-1409-591a9393fb88@quicinc.com>
Date:   Fri, 14 Jul 2023 10:51:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/2] spi: spi-geni-qcom: Add SPI Device mode support
 for GENI based QuPv3
Content-Language: en-CA
To:     Praveen Talari <quic_ptalari@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_arandive@quicinc.com>
References: <20230714042203.14251-1-quic_ptalari@quicinc.com>
 <20230714042203.14251-3-quic_ptalari@quicinc.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <20230714042203.14251-3-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I635cV5sCeKoChkYu3qkrnXnvSfThlp1
X-Proofpoint-GUID: I635cV5sCeKoChkYu3qkrnXnvSfThlp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140049
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With no knowledge of spi slave setup, I should say this looks good to me.

A few nits below which can be added in if there is going to be a v8, 
otherwise can be done later...



On 7/14/2023 9:52 AM, Praveen Talari wrote:
> Currently spi geni driver supports only master mode operation.
>
> Add spi device mode support to GENI based QuPv3.
>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
> v6 -> v7:
> - corrected author mail
>
> v4 -> v5:
> - added code comments
> - dropped get_spi_master api.
>
> v3 -> v4:
> - Used existing property spi-slave.
>
> v2 -> v3:
> - modified commit message to use device mode instead of slave mode
>
> v1 -> v2
> - modified the commit message
> - added the code changes for code comments
> ---
>   drivers/spi/spi-geni-qcom.c | 53 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 206cc04bb1ed..06b114f3f21a 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>   #include <linux/soc/qcom/geni-se.h>
>   #include <linux/spi/spi.h>
>   #include <linux/spinlock.h>
> @@ -52,6 +53,9 @@
>   #define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
>   #define SPI_CS_CLK_DELAY_SHFT		10
>   
> +#define SE_SPI_SLAVE_EN				(0x2BC)
> +#define SPI_SLAVE_EN				BIT(0)
> +

perhaps correct indentation here?

please check in an editor which uses correct number of spaces for a tab

>   /* M_CMD OP codes for SPI */
>   #define SPI_TX_ONLY		1
>   #define SPI_RX_ONLY		2
> @@ -99,6 +103,16 @@ struct spi_geni_master {
>   	int cur_xfer_mode;
>   };
>   
> +static void spi_slv_setup(struct spi_geni_master *mas)
> +{
> +	struct geni_se *se = &mas->se;
> +
> +	writel(SPI_SLAVE_EN, se->base + SE_SPI_SLAVE_EN);
> +	writel(GENI_IO_MUX_0_EN, se->base + GENI_OUTPUT_CTRL);
> +	writel(START_TRIGGER, se->base + SE_GENI_CFG_SEQ_START);
> +	dev_dbg(mas->dev, "spi slave setup done\n");
> +}
> +
>   static int get_spi_clk_cfg(unsigned int speed_hz,
>   			struct spi_geni_master *mas,
>   			unsigned int *clk_idx,
> @@ -140,12 +154,22 @@ static void handle_se_timeout(struct spi_master *spi,
>   	const struct spi_transfer *xfer;
>   
>   	spin_lock_irq(&mas->lock);
> -	reinit_completion(&mas->cancel_done);

good to see reinit moved to after newly added goto

>   	if (mas->cur_xfer_mode == GENI_SE_FIFO)
>   		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>   
>   	xfer = mas->cur_xfer;
>   	mas->cur_xfer = NULL;
> +
> +	if (spi->slave) {
> +		/*
> +		 * skip CMD Cancel sequnece since spi slave
> +		 * doesn`t support CMD Cancel sequnece

typo for sequence in 2 lines.

Or better, a more concise comment...

/* spi slave doesnt support CMD_CANCEL sequence */

> +		 */
> +		spin_unlock_irq(&mas->lock);
> +		goto unmap_if_dma;
> +	}
> +
> +	reinit_completion(&mas->cancel_done);
>   	geni_se_cancel_m_cmd(se);
>   	spin_unlock_irq(&mas->lock);
>   
> @@ -542,6 +566,10 @@ static bool geni_can_dma(struct spi_controller *ctlr,
>   	if (mas->cur_xfer_mode == GENI_GPI_DMA)
>   		return true;
>   
> +	/* Set SE DMA mode for SPI slave. */
> +	if (ctlr->slave)
> +		return true;
> +
>   	len = get_xfer_len_in_words(xfer, mas);
>   	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
>   
> @@ -619,6 +647,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
>   
>   static int spi_geni_init(struct spi_geni_master *mas)
>   {
> +	struct spi_master *spi = dev_get_drvdata(mas->dev);
>   	struct geni_se *se = &mas->se;
>   	unsigned int proto, major, minor, ver;
>   	u32 spi_tx_cfg, fifo_disable;
> @@ -627,7 +656,14 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   	pm_runtime_get_sync(mas->dev);
>   
>   	proto = geni_se_read_proto(se);
> -	if (proto != GENI_SE_SPI) {
> +
> +	if (spi->slave) {
> +		if (proto != GENI_SE_SPI_SLAVE) {
> +			dev_err(mas->dev, "Invalid proto %d\n", proto);
> +			goto out_pm;
> +		}
> +		spi_slv_setup(mas);
> +	} else if (proto != GENI_SE_SPI) {
>   		dev_err(mas->dev, "Invalid proto %d\n", proto);
>   		goto out_pm;
>   	}
> @@ -677,9 +713,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   	}
>   
>   	/* We always control CS manually */
> -	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> -	spi_tx_cfg &= ~CS_TOGGLE;
> -	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	if (!spi->slave) {
> +		spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> +		spi_tx_cfg &= ~CS_TOGGLE;
> +		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +	}
>   
>   out_pm:
>   	pm_runtime_put(mas->dev);
> @@ -1072,6 +1110,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
>   	pm_runtime_enable(dev);
>   
> +	if (device_property_read_bool(&pdev->dev, "spi-slave"))
> +		spi->slave = true;
> +
>   	ret = geni_icc_get(&mas->se, NULL);
>   	if (ret)
>   		goto spi_geni_probe_runtime_disable;
> @@ -1092,7 +1133,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	 * for dma (gsi) mode, the gsi will set cs based on params passed in
>   	 * TRE
>   	 */
> -	if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +	if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)
>   		spi->set_cs = spi_geni_set_cs;
>   
>   	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);

Thank you...

-Vijay/


