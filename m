Return-Path: <linux-kernel+bounces-93299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF58872DB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F2C1F26091
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66614F61;
	Wed,  6 Mar 2024 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsnsPebI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8688833;
	Wed,  6 Mar 2024 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709697035; cv=none; b=OphInKFqcwAVjx7SIUpLzPjybMLS3rpTpywRxP2eBYpGBynsEAsRMXBYEJ3n6Kox9GRq0q3xclclDk3ej0+e03jKNj45c/dmks1PyttTiVKZbAonfKoY4Z3QiehKgQwgXb0n/WMgyKGAlCsvLYMLPjRPA1XCXpDW+qO+f2cT8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709697035; c=relaxed/simple;
	bh=cOFmHYKifiuUfP2042dQ03GlPRwH0PiDqpBkDL/nBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0JKSCF3TQV7lCVuZhIdIWgnPZB9JGAJv9cwDhvFYqFG5/hMK+cjq+1aEYE5ZBJ072WmEdDSjQyQ+EUR3/IYEcykvOcji7C9Tl3PFqy5pJiON3UekUJCuLZhcvKUo3V0v3sTKhF0vNDs3hv1czOpjTEwnGuFhwKCXddnD+9KKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsnsPebI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9754C433F1;
	Wed,  6 Mar 2024 03:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709697034;
	bh=cOFmHYKifiuUfP2042dQ03GlPRwH0PiDqpBkDL/nBuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsnsPebIvgkU74ydTa5xkzioXPOObbvvtvOHQYMjtpI2Yd9EEZzAf85LXnnDsKevJ
	 +vLvHNcTJj/qvdtq/x4jRkAQgwnArS9k+wtFs/8HZ6ehrXnufVHspexKvTjIMudXZe
	 7BXI7AUjty4aaZSACnbgaNuZ3lMHWa+fv9YUr3Bqx8th9qskblpDHG38auq9ttumwp
	 doOmv3wNtJMYdTi+8K3dUObbkwqFv4Ew/z3rG1tXDfhsUpa1G/jh6o0kKoq4oQXTb5
	 YG2oM+im6YBt25ZHS7Xhm5t041cgpeDbbRYxO0imboCpY86EqJpXTHtRqNc7wqSkLX
	 qCJ3zr9pW1mSg==
Date: Tue, 5 Mar 2024 19:55:28 -0800
From: Bjorn Andersson <andersson@kernel.org>
To: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc: agross@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org, 
	mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_mojha@quicinc.com, quic_anusha@quicinc.com, 
	quic_sjaganat@quicinc.com, quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH V4] remoteproc: qcom: q6v5: Get crash reason from
 specific SMEM partition
Message-ID: <xu72amg46ogwuyleayyhhlgjlq5jqyxrdys3vj2o3zojiifeyj@xyc7zcgseulu>
References: <20231220055511.519395-1-quic_viswanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220055511.519395-1-quic_viswanat@quicinc.com>

On Wed, Dec 20, 2023 at 11:25:11AM +0530, Vignesh Viswanathan wrote:
> q6v5 fatal and watchdog IRQ handlers always retrieves the crash reason
> information from SMEM global partition (QCOM_SMEM_HOST_ANY).
> 
> For some targets like IPQ9574 and IPQ5332, crash reason information is
> present in target specific partition due to which the crash reason is
> not printed in the current implementation.
> 
> Add support to pass crash_reason_partition along with crash_reason_item
> number in qcom_q6v5_init call and use the same to get the crash
> information from SMEM in fatal and watchdog IRQ handlers.
> 
> While at it, rename all instances of "crash_reason_smem" with
> "crash_reason_item" as this reflects the proper meaning.
> 
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>

No concerns with the patch now, but as this depends on the mpd driver,
which is being refactored, please resubmit this once the driver is being
accepted.

> ---
> Changes in V4: Rename all instances of crash_reason_smem to crash_reason_item
> Changes in V3: Updated commit message.
> Changes in V2: Addressed comments in V1.

Please review go/upstream and start using b4.

Regards,
Bjorn

> 
> This patch depends on [1] which adds support for IPQ9574 and IPQ5332
> remoteproc q5v5_mpd driver.
> 
> [1]: https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/
> 
>  drivers/remoteproc/qcom_q6v5.c      | 10 +++--
>  drivers/remoteproc/qcom_q6v5.h      |  6 ++-
>  drivers/remoteproc/qcom_q6v5_adsp.c | 17 +++++----
>  drivers/remoteproc/qcom_q6v5_mpd.c  | 13 ++++---
>  drivers/remoteproc/qcom_q6v5_mss.c  |  5 ++-
>  drivers/remoteproc/qcom_q6v5_pas.c  | 59 +++++++++++++++--------------
>  drivers/remoteproc/qcom_q6v5_wcss.c | 12 +++---
>  7 files changed, 66 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 0e32f13c196d..e4a28bf25130 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -100,7 +100,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  		return IRQ_HANDLED;
>  	}
>  
> -	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
> +	msg = qcom_smem_get(q6v5->crash_reason_partition, q6v5->crash_reason_item, &len);
>  	if (!IS_ERR(msg) && len > 0 && msg[0])
>  		dev_err(q6v5->dev, "watchdog received: %s\n", msg);
>  	else
> @@ -121,7 +121,7 @@ irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  	if (!q6v5->running)
>  		return IRQ_HANDLED;
>  
> -	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
> +	msg = qcom_smem_get(q6v5->crash_reason_partition, q6v5->crash_reason_item, &len);
>  	if (!IS_ERR(msg) && len > 0 && msg[0])
>  		dev_err(q6v5->dev, "fatal error received: %s\n", msg);
>  	else
> @@ -279,14 +279,16 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
>   * Return: 0 on success, negative errno on failure
>   */
>  int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
> -		   struct rproc *rproc, int crash_reason, const char *load_state,
> +		   struct rproc *rproc, int crash_reason_partition,
> +		   int crash_reason_item, const char *load_state,
>  		   void (*handover)(struct qcom_q6v5 *q6v5))
>  {
>  	int ret;
>  
>  	q6v5->rproc = rproc;
>  	q6v5->dev = &pdev->dev;
> -	q6v5->crash_reason = crash_reason;
> +	q6v5->crash_reason_partition = crash_reason_partition;
> +	q6v5->crash_reason_item = crash_reason_item;
>  	q6v5->handover = handover;
>  
>  	init_completion(&q6v5->start_done);
> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> index 4e1bb1a68284..cd02372e9856 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -40,7 +40,8 @@ struct qcom_q6v5 {
>  	struct completion stop_done;
>  	struct completion spawn_done;
>  
> -	int crash_reason;
> +	int crash_reason_partition;
> +	int crash_reason_item;
>  
>  	bool running;
>  
> @@ -49,7 +50,8 @@ struct qcom_q6v5 {
>  };
>  
>  int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
> -		   struct rproc *rproc, int crash_reason, const char *load_state,
> +		   struct rproc *rproc, int crash_reason_partition,
> +		   int crash_reason_item, const char *load_state,
>  		   void (*handover)(struct qcom_q6v5 *q6v5));
>  void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5);
>  
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 6c67514cc493..055764aa201c 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -62,7 +62,7 @@
>  #define LPASS_EFUSE_Q6SS_EVB_SEL 0x0
>  
>  struct adsp_pil_data {
> -	int crash_reason_smem;
> +	int crash_reason_item;
>  	const char *firmware_name;
>  
>  	const char *ssr_name;
> @@ -98,7 +98,7 @@ struct qcom_adsp {
>  	struct regmap *halt_map;
>  	unsigned int halt_lpass;
>  
> -	int crash_reason_smem;
> +	int crash_reason_item;
>  	const char *info_name;
>  
>  	struct completion start_done;
> @@ -731,8 +731,9 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto disable_pm;
>  
> -	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
> -			     desc->load_state, qcom_adsp_pil_handover);
> +	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
> +			     desc->crash_reason_item, desc->load_state,
> +			     qcom_adsp_pil_handover);
>  	if (ret)
>  		goto disable_pm;
>  
> @@ -776,7 +777,7 @@ static void adsp_remove(struct platform_device *pdev)
>  }
>  
>  static const struct adsp_pil_data adsp_resource_init = {
> -	.crash_reason_smem = 423,
> +	.crash_reason_item = 423,
>  	.firmware_name = "adsp.mdt",
>  	.ssr_name = "lpass",
>  	.sysmon_name = "adsp",
> @@ -794,7 +795,7 @@ static const struct adsp_pil_data adsp_resource_init = {
>  };
>  
>  static const struct adsp_pil_data adsp_sc7280_resource_init = {
> -	.crash_reason_smem = 423,
> +	.crash_reason_item = 423,
>  	.firmware_name = "adsp.pbn",
>  	.load_state = "adsp",
>  	.ssr_name = "lpass",
> @@ -809,7 +810,7 @@ static const struct adsp_pil_data adsp_sc7280_resource_init = {
>  };
>  
>  static const struct adsp_pil_data cdsp_resource_init = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.ssr_name = "cdsp",
>  	.sysmon_name = "cdsp",
> @@ -827,7 +828,7 @@ static const struct adsp_pil_data cdsp_resource_init = {
>  };
>  
>  static const struct adsp_pil_data wpss_resource_init = {
> -	.crash_reason_smem = 626,
> +	.crash_reason_item = 626,
>  	.firmware_name = "wpss.mdt",
>  	.ssr_name = "wpss",
>  	.sysmon_name = "wpss",
> diff --git a/drivers/remoteproc/qcom_q6v5_mpd.c b/drivers/remoteproc/qcom_q6v5_mpd.c
> index b133285888c7..27c9f4317e98 100644
> --- a/drivers/remoteproc/qcom_q6v5_mpd.c
> +++ b/drivers/remoteproc/qcom_q6v5_mpd.c
> @@ -555,9 +555,9 @@ static int q6_get_outbound_irq(struct qcom_q6v5 *q6,
>  	return 0;
>  }
>  
> -static int init_irq(struct qcom_q6v5 *q6,
> -		    struct platform_device *pdev, struct rproc *rproc,
> -		    int crash_reason, const char *load_state,
> +static int init_irq(struct qcom_q6v5 *q6, struct platform_device *pdev,
> +		    struct rproc *rproc, int crash_reason_partition,
> +		    int crash_reason_item, const char *load_state,
>  		    void (*handover)(struct qcom_q6v5 *q6))
>  {
>  	int ret;
> @@ -565,7 +565,8 @@ static int init_irq(struct qcom_q6v5 *q6,
>  
>  	q6->rproc = rproc;
>  	q6->dev = &pdev->dev;
> -	q6->crash_reason = crash_reason;
> +	q6->crash_reason_partition = crash_reason_partition;
> +	q6->crash_reason_item = crash_reason_item;
>  	q6->handover = handover;
>  
>  	init_completion(&q6->start_done);
> @@ -666,7 +667,7 @@ static int q6_register_userpd(struct platform_device *pdev,
>  	if (ret)
>  		goto free_rproc;
>  
> -	ret = init_irq(&wcss->q6, userpd_pdev, rproc,
> +	ret = init_irq(&wcss->q6, userpd_pdev, rproc, WCSS_SMEM_HOST,
>  		       WCSS_CRASH_REASON, NULL, NULL);
>  	if (ret)
>  		goto free_rproc;
> @@ -725,7 +726,7 @@ static int q6_wcss_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> -	ret = qcom_q6v5_init(&wcss->q6, pdev, rproc,
> +	ret = qcom_q6v5_init(&wcss->q6, pdev, rproc, WCSS_SMEM_HOST,
>  			     WCSS_CRASH_REASON, NULL, NULL);
>  	if (ret)
>  		goto free_rproc;
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 394b2c1cb5e2..48f115f9337b 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -26,6 +26,7 @@
>  #include <linux/remoteproc.h>
>  #include <linux/reset.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/smem.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
>  
> @@ -2093,8 +2094,8 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc->need_mem_protection = desc->need_mem_protection;
>  	qproc->has_mba_logs = desc->has_mba_logs;
>  
> -	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM, "modem",
> -			     qcom_msa_handover);
> +	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
> +			     MPSS_CRASH_REASON_SMEM, "modem", qcom_msa_handover);
>  	if (ret)
>  		goto detach_proxy_pds;
>  
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 913a5d2068e8..daca648d4ddb 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -34,7 +34,7 @@
>  #define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
>  
>  struct adsp_data {
> -	int crash_reason_smem;
> +	int crash_reason_item;
>  	const char *firmware_name;
>  	const char *dtb_firmware_name;
>  	int pas_id;
> @@ -73,7 +73,7 @@ struct qcom_adsp {
>  	int pas_id;
>  	int dtb_pas_id;
>  	unsigned int minidump_id;
> -	int crash_reason_smem;
> +	int crash_reason_item;
>  	bool decrypt_shutdown;
>  	const char *info_name;
>  
> @@ -728,7 +728,8 @@ static int adsp_probe(struct platform_device *pdev)
>  		goto free_rproc;
>  	adsp->proxy_pd_count = ret;
>  
> -	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem, desc->load_state,
> +	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
> +			     desc->crash_reason_item, desc->load_state,
>  			     qcom_pas_handover);
>  	if (ret)
>  		goto detach_proxy_pds;
> @@ -777,7 +778,7 @@ static void adsp_remove(struct platform_device *pdev)
>  }
>  
>  static const struct adsp_data adsp_resource_init = {
> -		.crash_reason_smem = 423,
> +		.crash_reason_item = 423,
>  		.firmware_name = "adsp.mdt",
>  		.pas_id = 1,
>  		.auto_boot = true,
> @@ -787,7 +788,7 @@ static const struct adsp_data adsp_resource_init = {
>  };
>  
>  static const struct adsp_data sdm845_adsp_resource_init = {
> -		.crash_reason_smem = 423,
> +		.crash_reason_item = 423,
>  		.firmware_name = "adsp.mdt",
>  		.pas_id = 1,
>  		.auto_boot = true,
> @@ -798,7 +799,7 @@ static const struct adsp_data sdm845_adsp_resource_init = {
>  };
>  
>  static const struct adsp_data sm6350_adsp_resource = {
> -	.crash_reason_smem = 423,
> +	.crash_reason_item = 423,
>  	.firmware_name = "adsp.mdt",
>  	.pas_id = 1,
>  	.auto_boot = true,
> @@ -814,7 +815,7 @@ static const struct adsp_data sm6350_adsp_resource = {
>  };
>  
>  static const struct adsp_data sm6375_mpss_resource = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "modem.mdt",
>  	.pas_id = 4,
>  	.minidump_id = 3,
> @@ -829,7 +830,7 @@ static const struct adsp_data sm6375_mpss_resource = {
>  };
>  
>  static const struct adsp_data sm8150_adsp_resource = {
> -		.crash_reason_smem = 423,
> +		.crash_reason_item = 423,
>  		.firmware_name = "adsp.mdt",
>  		.pas_id = 1,
>  		.auto_boot = true,
> @@ -844,7 +845,7 @@ static const struct adsp_data sm8150_adsp_resource = {
>  };
>  
>  static const struct adsp_data sm8250_adsp_resource = {
> -	.crash_reason_smem = 423,
> +	.crash_reason_item = 423,
>  	.firmware_name = "adsp.mdt",
>  	.pas_id = 1,
>  	.auto_boot = true,
> @@ -860,7 +861,7 @@ static const struct adsp_data sm8250_adsp_resource = {
>  };
>  
>  static const struct adsp_data sm8350_adsp_resource = {
> -	.crash_reason_smem = 423,
> +	.crash_reason_item = 423,
>  	.firmware_name = "adsp.mdt",
>  	.pas_id = 1,
>  	.auto_boot = true,
> @@ -876,7 +877,7 @@ static const struct adsp_data sm8350_adsp_resource = {
>  };
>  
>  static const struct adsp_data msm8996_adsp_resource = {
> -		.crash_reason_smem = 423,
> +		.crash_reason_item = 423,
>  		.firmware_name = "adsp.mdt",
>  		.pas_id = 1,
>  		.auto_boot = true,
> @@ -890,7 +891,7 @@ static const struct adsp_data msm8996_adsp_resource = {
>  };
>  
>  static const struct adsp_data cdsp_resource_init = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -900,7 +901,7 @@ static const struct adsp_data cdsp_resource_init = {
>  };
>  
>  static const struct adsp_data sdm845_cdsp_resource_init = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -911,7 +912,7 @@ static const struct adsp_data sdm845_cdsp_resource_init = {
>  };
>  
>  static const struct adsp_data sm6350_cdsp_resource = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -927,7 +928,7 @@ static const struct adsp_data sm6350_cdsp_resource = {
>  };
>  
>  static const struct adsp_data sm8150_cdsp_resource = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -942,7 +943,7 @@ static const struct adsp_data sm8150_cdsp_resource = {
>  };
>  
>  static const struct adsp_data sm8250_cdsp_resource = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -957,7 +958,7 @@ static const struct adsp_data sm8250_cdsp_resource = {
>  };
>  
>  static const struct adsp_data sc8280xp_nsp0_resource = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -971,7 +972,7 @@ static const struct adsp_data sc8280xp_nsp0_resource = {
>  };
>  
>  static const struct adsp_data sc8280xp_nsp1_resource = {
> -	.crash_reason_smem = 633,
> +	.crash_reason_item = 633,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 30,
>  	.auto_boot = true,
> @@ -985,7 +986,7 @@ static const struct adsp_data sc8280xp_nsp1_resource = {
>  };
>  
>  static const struct adsp_data sm8350_cdsp_resource = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.pas_id = 18,
>  	.auto_boot = true,
> @@ -1001,7 +1002,7 @@ static const struct adsp_data sm8350_cdsp_resource = {
>  };
>  
>  static const struct adsp_data mpss_resource_init = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "modem.mdt",
>  	.pas_id = 4,
>  	.minidump_id = 3,
> @@ -1018,7 +1019,7 @@ static const struct adsp_data mpss_resource_init = {
>  };
>  
>  static const struct adsp_data sc8180x_mpss_resource = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "modem.mdt",
>  	.pas_id = 4,
>  	.auto_boot = false,
> @@ -1033,7 +1034,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
>  };
>  
>  static const struct adsp_data msm8996_slpi_resource_init = {
> -		.crash_reason_smem = 424,
> +		.crash_reason_item = 424,
>  		.firmware_name = "slpi.mdt",
>  		.pas_id = 12,
>  		.auto_boot = true,
> @@ -1047,7 +1048,7 @@ static const struct adsp_data msm8996_slpi_resource_init = {
>  };
>  
>  static const struct adsp_data sdm845_slpi_resource_init = {
> -		.crash_reason_smem = 424,
> +		.crash_reason_item = 424,
>  		.firmware_name = "slpi.mdt",
>  		.pas_id = 12,
>  		.auto_boot = true,
> @@ -1063,7 +1064,7 @@ static const struct adsp_data sdm845_slpi_resource_init = {
>  };
>  
>  static const struct adsp_data wcss_resource_init = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "wcnss.mdt",
>  	.pas_id = 6,
>  	.auto_boot = true,
> @@ -1073,7 +1074,7 @@ static const struct adsp_data wcss_resource_init = {
>  };
>  
>  static const struct adsp_data sdx55_mpss_resource = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "modem.mdt",
>  	.pas_id = 4,
>  	.auto_boot = true,
> @@ -1088,7 +1089,7 @@ static const struct adsp_data sdx55_mpss_resource = {
>  };
>  
>  static const struct adsp_data sm8450_mpss_resource = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "modem.mdt",
>  	.pas_id = 4,
>  	.minidump_id = 3,
> @@ -1106,7 +1107,7 @@ static const struct adsp_data sm8450_mpss_resource = {
>  };
>  
>  static const struct adsp_data sm8550_adsp_resource = {
> -	.crash_reason_smem = 423,
> +	.crash_reason_item = 423,
>  	.firmware_name = "adsp.mdt",
>  	.dtb_firmware_name = "adsp_dtb.mdt",
>  	.pas_id = 1,
> @@ -1125,7 +1126,7 @@ static const struct adsp_data sm8550_adsp_resource = {
>  };
>  
>  static const struct adsp_data sm8550_cdsp_resource = {
> -	.crash_reason_smem = 601,
> +	.crash_reason_item = 601,
>  	.firmware_name = "cdsp.mdt",
>  	.dtb_firmware_name = "cdsp_dtb.mdt",
>  	.pas_id = 18,
> @@ -1145,7 +1146,7 @@ static const struct adsp_data sm8550_cdsp_resource = {
>  };
>  
>  static const struct adsp_data sm8550_mpss_resource = {
> -	.crash_reason_smem = 421,
> +	.crash_reason_item = 421,
>  	.firmware_name = "modem.mdt",
>  	.dtb_firmware_name = "modem_dtb.mdt",
>  	.pas_id = 4,
> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
> index cff1fa07d1de..f6b6ec10d21b 100644
> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
> @@ -18,6 +18,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/smem.h>
>  #include "qcom_common.h"
>  #include "qcom_pil_info.h"
>  #include "qcom_q6v5.h"
> @@ -93,7 +94,7 @@ enum {
>  
>  struct wcss_data {
>  	const char *firmware_name;
> -	unsigned int crash_reason_smem;
> +	unsigned int crash_reason_item;
>  	u32 version;
>  	bool aon_reset_required;
>  	bool wcss_q6_reset_required;
> @@ -143,7 +144,7 @@ struct q6v5_wcss {
>  	void *mem_region;
>  	size_t mem_size;
>  
> -	unsigned int crash_reason_smem;
> +	unsigned int crash_reason_item;
>  	u32 version;
>  	bool requires_force_stop;
>  
> @@ -1047,7 +1048,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> -	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
> +	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, QCOM_SMEM_HOST_ANY,
> +			     desc->crash_reason_item, NULL, NULL);
>  	if (ret)
>  		goto free_rproc;
>  
> @@ -1085,7 +1087,7 @@ static void q6v5_wcss_remove(struct platform_device *pdev)
>  
>  static const struct wcss_data wcss_ipq8074_res_init = {
>  	.firmware_name = "IPQ8074/q6_fw.mdt",
> -	.crash_reason_smem = WCSS_CRASH_REASON,
> +	.crash_reason_item = WCSS_CRASH_REASON,
>  	.aon_reset_required = true,
>  	.wcss_q6_reset_required = true,
>  	.ops = &q6v5_wcss_ipq8074_ops,
> @@ -1093,7 +1095,7 @@ static const struct wcss_data wcss_ipq8074_res_init = {
>  };
>  
>  static const struct wcss_data wcss_qcs404_res_init = {
> -	.crash_reason_smem = WCSS_CRASH_REASON,
> +	.crash_reason_item = WCSS_CRASH_REASON,
>  	.firmware_name = "wcnss.mdt",
>  	.version = WCSS_QCS404,
>  	.aon_reset_required = false,
> -- 
> 2.41.0
> 

