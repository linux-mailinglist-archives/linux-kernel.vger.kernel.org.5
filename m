Return-Path: <linux-kernel+bounces-145922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909E8A5CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14FE283F34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0F156C55;
	Mon, 15 Apr 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e9jbcUcA"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43D82D93
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215842; cv=none; b=JDXau7uJrHteuuAtEtW6WImTog7a/b4BiV99ZMxoht7B4ZAoIRt3MHq4Dn28BpQDXUw7BDXiUFgx1UOWFe9KzSERC1TIH0gUdyJAjYhbvxgsIvbxkWwFa4uY+nCrFhjnhJvxW0XEkSC4i9qxzSB8RCDZmLRsxF0lRhF8mNSRRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215842; c=relaxed/simple;
	bh=n/UV1lOaJcDiiDP6HZq55kzXr38qVpECvewbDp+jy30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tLRYeOTwkMJn3maqWRQY0uV8aI92SFqRuLsqKp0gQWwzrkuG/OXNbyqiXJYo7YFxSw9w7hCpcM1A31mT/g5rq0OnBURaRi0w3/VfPqIZG/QPyuo96whG48Cy2iVzlnBI5eCDppqogsirr4kU5eiPcgueJ9YKoTK5Ku7MvbgKAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e9jbcUcA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240415211718euoutp0241af9613a2a311b5c6084ae8eca49aea~GkLpV0lpm0485804858euoutp02D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:17:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240415211718euoutp0241af9613a2a311b5c6084ae8eca49aea~GkLpV0lpm0485804858euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713215838;
	bh=ORkChA2wTbRw2dbB04fHWYzokvyhGGEPeG4l5SsOJ9U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=e9jbcUcA/NX99MPXWcNRbKXH5lY9hU+Dd/4H37OQDzLVMYpbcltMwcMBWtrb7G3XO
	 thkFhPsg6aUrOp5XlueOh/+hVNzLpDBCjZqtw0ZjeAafALwiA3Ziv/hAyL03JDzIPX
	 tmHPN+bVHy6SOitRt0nIf9qdW71vPwZlUjB0FQlQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240415211717eucas1p265b567a26594b4f1321a13a123711c19~GkLoT-WDL2242922429eucas1p25;
	Mon, 15 Apr 2024 21:17:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.2F.09620.D599D166; Mon, 15
	Apr 2024 22:17:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1~GkLnUJ-1S1437514375eucas1p19;
	Mon, 15 Apr 2024 21:17:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240415211716eusmtrp2900e9ed80641738dd8a328873d9c318e~GkLnTkrr-0308803088eusmtrp2W;
	Mon, 15 Apr 2024 21:17:16 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-48-661d995dd8ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.B3.09010.B599D166; Mon, 15
	Apr 2024 22:17:15 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240415211715eusmtip238e929d6736a7cc9fcb3bafdccf1ef91~GkLm2iS-u0268802688eusmtip2x;
	Mon, 15 Apr 2024 21:17:15 +0000 (GMT)
Message-ID: <d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com>
Date: Mon, 15 Apr 2024 23:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] tty: msm_serial: use dmaengine_prep_slave_sg()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
	Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240405060826.2521-12-jirislaby@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qxM2XTDK51M1ts67CxaF68ns3i
	3VwZi47J21ksJu4/y25xedccNoszi3vZHdg9Nq3qZPO4c20Pm8f+uWvYPT5vkgtgieKySUnN
	ySxLLdK3S+DK+DZzG3tBt1fFj5/PGBsYN1l1MXJySAiYSFxseMnWxcjFISSwglHi3olzjBDO
	F0aJGT/nsUI4nxkltj9dwAjTcvjGInaIxHJGiYk/p0K1fGSUWHf3HztIFa+AncTESZOYQGwW
	AVWJ9z/+QMUFJU7OfMICYosKyEvcvzUDLC4s4CnxtOU2M4gtIuAlcWryE7ChzAKbGSUudkxi
	BUkwC4hL3HoyH2wom4ChRNfbLjYQm1PASuL/lSXMEDXyEtvfzmEGaZYQuMIhsb/tGzPE3S4S
	36+cZoKwhSVeHd/CDmHLSPzfCTIUpKGdUWLB7/tQzgRGiYbnt6C+tpa4c+4X0DoOoBWaEut3
	6UOEHSXm7LjFChKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiGF
	yywkb85C8s4shL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKae0/+Of93BuOLV
	R71DjEwcjIcYJTiYlUR4W4Rl04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeWpGan
	phakFsFkmTg4pRqY9AR055et/F6/7rzjJC6LaTreSWdudyy6F6VfYN9ru1GpznRjype79+c6
	zmBylT/PXPvr64M9X5LNF6W0Szz2PC16bVGx974ji++8fxPMKLfq+YHKFPe1khGB+/Unljxl
	36/WNvnb0aIZUfy2ixszZAUvznyr9DF1sbzdnZcxLGm5FZ+2Mc4PCLh5UyfRqjRXSsvS93zr
	0wTvVZe3i2zXiV77lrXLhGdnxrQ5/y44OjY0Z853c5m4Y//NR7kXznts28346Kv1VQsnX+ME
	Eaa/QYZfDTgFby+fUezqePa6Q1PhYd23NQLr5n92Cp7SrSdfXXO9TSNLfMcR0x/nfcwcWn4H
	LjGep1Q/ydgyPrxKiaU4I9FQi7moOBEA6RDABawDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7rRM2XTDM49srLY1mFj0bx4PZvF
	u7kyFh2Tt7NYTNx/lt3i8q45bBZnFveyO7B7bFrVyeZx59oeNo/9c9ewe3zeJBfAEqVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8W3mNvaCbq+K
	Hz+fMTYwbrLqYuTkkBAwkTh8YxF7FyMXh5DAUkaJL/svs0EkZCROTmtghbCFJf5c62KDKHrP
	KDF15TV2kASvgJ3ExEmTmEBsFgFVifc//kDFBSVOznzCAmKLCshL3L81AywuLOAp8bTlNjOI
	LSLgJXFq8hNGkKHMApsZJTb8OQs2SEggQ2LSuwawZmYBcYlbT+aDxdkEDCW63naBXccpYCXx
	/8oSZogaM4murV2MELa8xPa3c5gnMArNQnLHLCSjZiFpmYWkZQEjyypGkdTS4tz03GIjveLE
	3OLSvHS95PzcTYzASNt27OeWHYwrX33UO8TIxMF4iFGCg1lJhLdFWDZNiDclsbIqtSg/vqg0
	J7X4EKMpMDAmMkuJJucDYz2vJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaP
	iYNTqoFpzZkHvQEJfy9Oblumn8ZeZ+pfr+dxbVHEkh5ZjgdG657N1n6o4LLQ0et26mm9VVO9
	z9Q9Zrr9OoTpw6k9D95uDLRrYlA2lz5x6PV/w5QZS+2u/jKQ1X09teoCS2e4iFD/RTfVov78
	ZS2ZrQXZHGIMt9y5D2UY+Rh1rzT4os5jmXNl6kY+QQsrHY28gohJd5tMd2Z9ajqs0Lfwh6gX
	o/eJtr4TDmd7FhSub2JdfkyQeanHBZHTrjMZzVZIX57PNeXJhNR0rbf2tg3meYo5rboHJ57S
	5u8oKl62cH8rZ1fu4R0m5/d8lIzcx9G1gPXAweviq3fv/Zk0W/PB23Td2C0VX/f0+qy9m3Oq
	qd4u10GJpTgj0VCLuag4EQBaxmvUPQMAAA==
X-CMS-MailID: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
References: <20240405060826.2521-1-jirislaby@kernel.org>
	<20240405060826.2521-12-jirislaby@kernel.org>
	<CGME20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1@eucas1p1.samsung.com>

On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
> This is a preparatory for the serial-to-kfifo switch. kfifo understands
> only scatter-gatter approach, so switch to that.
>
> No functional change intended, it's just dmaengine_prep_slave_single()
> inline expanded.
>
> And in this case, switch from dma_map_single() to dma_map_sg() too. This
> needs struct msm_dma changes. I split the rx and tx parts into an union.
> TX is now struct scatterlist, RX remains the old good phys-virt-count
> triple.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org

I've just found that this patch broke UART operation on DragonBoard 
410c. I briefly checked and didn't notice anything obviously wrong here, 
but the board stops transmitting any data from its serial port after the 
first message. I will try to analyze this issue a bit more tomorrow.

> ---
>   drivers/tty/serial/msm_serial.c | 86 +++++++++++++++++++--------------
>   1 file changed, 49 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index d27c4c8c84e1..7bf30e632313 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -161,11 +161,16 @@ enum {
>   struct msm_dma {
>   	struct dma_chan		*chan;
>   	enum dma_data_direction dir;
> -	dma_addr_t		phys;
> -	unsigned char		*virt;
> +	union {
> +		struct {
> +			dma_addr_t		phys;
> +			unsigned char		*virt;
> +			unsigned int		count;
> +		} rx;
> +		struct scatterlist tx_sg;
> +	};
>   	dma_cookie_t		cookie;
>   	u32			enable_bit;
> -	unsigned int		count;
>   	struct dma_async_tx_descriptor	*desc;
>   };
>   
> @@ -249,8 +254,12 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
>   	unsigned int mapped;
>   	u32 val;
>   
> -	mapped = dma->count;
> -	dma->count = 0;
> +	if (dma->dir == DMA_TO_DEVICE) {
> +		mapped = sg_dma_len(&dma->tx_sg);
> +	} else {
> +		mapped = dma->rx.count;
> +		dma->rx.count = 0;
> +	}
>   
>   	dmaengine_terminate_all(dma->chan);
>   
> @@ -265,8 +274,13 @@ static void msm_stop_dma(struct uart_port *port, struct msm_dma *dma)
>   	val &= ~dma->enable_bit;
>   	msm_write(port, val, UARTDM_DMEN);
>   
> -	if (mapped)
> -		dma_unmap_single(dev, dma->phys, mapped, dma->dir);
> +	if (mapped) {
> +		if (dma->dir == DMA_TO_DEVICE) {
> +			dma_unmap_sg(dev, &dma->tx_sg, 1, dma->dir);
> +			sg_init_table(&dma->tx_sg, 1);
> +		} else
> +			dma_unmap_single(dev, dma->rx.phys, mapped, dma->dir);
> +	}
>   }
>   
>   static void msm_release_dma(struct msm_port *msm_port)
> @@ -285,7 +299,7 @@ static void msm_release_dma(struct msm_port *msm_port)
>   	if (dma->chan) {
>   		msm_stop_dma(&msm_port->uart, dma);
>   		dma_release_channel(dma->chan);
> -		kfree(dma->virt);
> +		kfree(dma->rx.virt);
>   	}
>   
>   	memset(dma, 0, sizeof(*dma));
> @@ -357,8 +371,8 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
>   
>   	of_property_read_u32(dev->of_node, "qcom,rx-crci", &crci);
>   
> -	dma->virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
> -	if (!dma->virt)
> +	dma->rx.virt = kzalloc(UARTDM_RX_SIZE, GFP_KERNEL);
> +	if (!dma->rx.virt)
>   		goto rel_rx;
>   
>   	memset(&conf, 0, sizeof(conf));
> @@ -385,7 +399,7 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
>   
>   	return;
>   err:
> -	kfree(dma->virt);
> +	kfree(dma->rx.virt);
>   rel_rx:
>   	dma_release_channel(dma->chan);
>   no_rx:
> @@ -420,7 +434,7 @@ static void msm_start_tx(struct uart_port *port)
>   	struct msm_dma *dma = &msm_port->tx_dma;
>   
>   	/* Already started in DMA mode */
> -	if (dma->count)
> +	if (sg_dma_len(&dma->tx_sg))
>   		return;
>   
>   	msm_port->imr |= MSM_UART_IMR_TXLEV;
> @@ -448,12 +462,12 @@ static void msm_complete_tx_dma(void *args)
>   	uart_port_lock_irqsave(port, &flags);
>   
>   	/* Already stopped */
> -	if (!dma->count)
> +	if (!sg_dma_len(&dma->tx_sg))
>   		goto done;
>   
>   	dmaengine_tx_status(dma->chan, dma->cookie, &state);
>   
> -	dma_unmap_single(port->dev, dma->phys, dma->count, dma->dir);
> +	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
>   
>   	val = msm_read(port, UARTDM_DMEN);
>   	val &= ~dma->enable_bit;
> @@ -464,9 +478,9 @@ static void msm_complete_tx_dma(void *args)
>   		msm_write(port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
>   	}
>   
> -	count = dma->count - state.residue;
> +	count = sg_dma_len(&dma->tx_sg) - state.residue;
>   	uart_xmit_advance(port, count);
> -	dma->count = 0;
> +	sg_init_table(&dma->tx_sg, 1);
>   
>   	/* Restore "Tx FIFO below watermark" interrupt */
>   	msm_port->imr |= MSM_UART_IMR_TXLEV;
> @@ -485,19 +499,18 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	struct circ_buf *xmit = &msm_port->uart.state->xmit;
>   	struct uart_port *port = &msm_port->uart;
>   	struct msm_dma *dma = &msm_port->tx_dma;
> -	void *cpu_addr;
>   	int ret;
>   	u32 val;
>   
> -	cpu_addr = &xmit->buf[xmit->tail];
> +	sg_init_table(&dma->tx_sg, 1);
> +	sg_set_buf(&dma->tx_sg, &xmit->buf[xmit->tail], count);
>   
> -	dma->phys = dma_map_single(port->dev, cpu_addr, count, dma->dir);
> -	ret = dma_mapping_error(port->dev, dma->phys);
> +	ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
>   	if (ret)
>   		return ret;
>   
> -	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
> -						count, DMA_MEM_TO_DEV,
> +	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
> +						DMA_MEM_TO_DEV,
>   						DMA_PREP_INTERRUPT |
>   						DMA_PREP_FENCE);
>   	if (!dma->desc) {
> @@ -520,8 +533,6 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	msm_port->imr &= ~MSM_UART_IMR_TXLEV;
>   	msm_write(port, msm_port->imr, MSM_UART_IMR);
>   
> -	dma->count = count;
> -
>   	val = msm_read(port, UARTDM_DMEN);
>   	val |= dma->enable_bit;
>   
> @@ -536,7 +547,8 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	dma_async_issue_pending(dma->chan);
>   	return 0;
>   unmap:
> -	dma_unmap_single(port->dev, dma->phys, count, dma->dir);
> +	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +	sg_init_table(&dma->tx_sg, 1);
>   	return ret;
>   }
>   
> @@ -553,7 +565,7 @@ static void msm_complete_rx_dma(void *args)
>   	uart_port_lock_irqsave(port, &flags);
>   
>   	/* Already stopped */
> -	if (!dma->count)
> +	if (!dma->rx.count)
>   		goto done;
>   
>   	val = msm_read(port, UARTDM_DMEN);
> @@ -570,14 +582,14 @@ static void msm_complete_rx_dma(void *args)
>   
>   	port->icount.rx += count;
>   
> -	dma->count = 0;
> +	dma->rx.count = 0;
>   
> -	dma_unmap_single(port->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
> +	dma_unmap_single(port->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
>   
>   	for (i = 0; i < count; i++) {
>   		char flag = TTY_NORMAL;
>   
> -		if (msm_port->break_detected && dma->virt[i] == 0) {
> +		if (msm_port->break_detected && dma->rx.virt[i] == 0) {
>   			port->icount.brk++;
>   			flag = TTY_BREAK;
>   			msm_port->break_detected = false;
> @@ -588,9 +600,9 @@ static void msm_complete_rx_dma(void *args)
>   		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
>   			flag = TTY_NORMAL;
>   
> -		sysrq = uart_prepare_sysrq_char(port, dma->virt[i]);
> +		sysrq = uart_prepare_sysrq_char(port, dma->rx.virt[i]);
>   		if (!sysrq)
> -			tty_insert_flip_char(tport, dma->virt[i], flag);
> +			tty_insert_flip_char(tport, dma->rx.virt[i], flag);
>   	}
>   
>   	msm_start_rx_dma(msm_port);
> @@ -614,13 +626,13 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   	if (!dma->chan)
>   		return;
>   
> -	dma->phys = dma_map_single(uart->dev, dma->virt,
> +	dma->rx.phys = dma_map_single(uart->dev, dma->rx.virt,
>   				   UARTDM_RX_SIZE, dma->dir);
> -	ret = dma_mapping_error(uart->dev, dma->phys);
> +	ret = dma_mapping_error(uart->dev, dma->rx.phys);
>   	if (ret)
>   		goto sw_mode;
>   
> -	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->phys,
> +	dma->desc = dmaengine_prep_slave_single(dma->chan, dma->rx.phys,
>   						UARTDM_RX_SIZE, DMA_DEV_TO_MEM,
>   						DMA_PREP_INTERRUPT);
>   	if (!dma->desc)
> @@ -648,7 +660,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   
>   	msm_write(uart, msm_port->imr, MSM_UART_IMR);
>   
> -	dma->count = UARTDM_RX_SIZE;
> +	dma->rx.count = UARTDM_RX_SIZE;
>   
>   	dma_async_issue_pending(dma->chan);
>   
> @@ -668,7 +680,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   
>   	return;
>   unmap:
> -	dma_unmap_single(uart->dev, dma->phys, UARTDM_RX_SIZE, dma->dir);
> +	dma_unmap_single(uart->dev, dma->rx.phys, UARTDM_RX_SIZE, dma->dir);
>   
>   sw_mode:
>   	/*
> @@ -955,7 +967,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
>   	}
>   
>   	if (misr & (MSM_UART_IMR_RXLEV | MSM_UART_IMR_RXSTALE)) {
> -		if (dma->count) {
> +		if (dma->rx.count) {
>   			val = MSM_UART_CR_CMD_STALE_EVENT_DISABLE;
>   			msm_write(port, val, MSM_UART_CR);
>   			val = MSM_UART_CR_CMD_RESET_STALE_INT;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


