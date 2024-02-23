Return-Path: <linux-kernel+bounces-79011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB6861C35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4AC1C226A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C014263A;
	Fri, 23 Feb 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gSJOHz8G"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB971735
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714798; cv=none; b=Rp6UWMRlUtuvlXmk903Heae7UXVwmAvWKolYdqckDd2Q4M19GZSONXT8baQz6JPJFJ7Yh8XuepXsdytuJ7VAytIuFvggLgcjLCJetn4Gd1OMMmbni+ifO7YKrcyhJw3s37q288S8MrOE/FeoM9F8ODr6DZwT+sUWGQTVzCdXIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714798; c=relaxed/simple;
	bh=7UqDuwBDaflgwCxw652350Ulcmu75Iyquu+SWNAvWw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjed5s6ZkllPRJ2j0554kH0fBEPzpgU5vY9xAuvHGoE2gqAk0mzVrZ/H8sxHpYtFubBmuUIu3oueh5k+lrNFWCG0jw79wYg503/hfWCjZZNYr9WvZEK8+Fho0ZrYL+S+3PTj9jp8++hS5TMPIWPOCHpUU7E4whuzaBbReubbOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gSJOHz8G; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id dad3rSWmGAVWCdad3rWYDQ; Fri, 23 Feb 2024 19:50:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708714238;
	bh=b2nzjyV92V5xFcCR433HxBvfMH7+kUtrO9FWeyeWOCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gSJOHz8G0WmTpVutXKnIFVjcLbBB1QIclwwVEQyQ4j6idFD9JbNJap3o6UKPBJVZz
	 cqMFD/y4EvOF8qWOv8Y8+4Qy1CHhsbC2ahw9ZY+oHwAwBojDPKbLC+0eARYERsT9kZ
	 J8MljnZMQYF9Ed3LsOYxwkorekwBuoSpdxNXoEfegcDpWAKJ/8I6lQGCdD5v3FdVWp
	 qo8FRhlWim+zAOeryHLsfiwrcj1wkkTTeNGWvmNwMpDTDfoPGJkMYbh8KayxOMxHWG
	 NjB7hOFJZMC9iA/hGqmcSxgeeNpY5s+jus6lwGJZpxVEzbWBI1yZ87CD5L9VV1q6tH
	 oiJ1FRv0DTNCA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Feb 2024 19:50:38 +0100
X-ME-IP: 92.140.202.140
Message-ID: <530912d2-aa44-494d-bd51-dcac6147b78a@wanadoo.fr>
Date: Fri, 23 Feb 2024 19:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V8 2/2] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-MW
To: Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nishad Saraf <nishads@amd.com>, nishad.saraf@amd.com,
 sonal.santan@amd.com, max.zhen@amd.com
References: <1708707403-47386-1-git-send-email-lizhi.hou@amd.com>
 <1708707403-47386-3-git-send-email-lizhi.hou@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1708707403-47386-3-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 17:56, Lizhi Hou a écrit :
> From: Nishad Saraf <nishads@amd.com>
> 
> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
> Accelerator devices.
>      https://www.xilinx.com/applications/data-center/v70.html
> 
> The QDMA subsystem is used in conjunction with the PCI Express IP block
> to provide high performance data transfer between host memory and the
> card's DMA subsystem.
> 
>              +-------+       +-------+       +-----------+
>     PCIe     |       |       |       |       |           |
>     Tx/Rx    |       |       |       |  AXI  |           |
>   <=======>  | PCIE  | <===> | QDMA  | <====>| User Logic|
>              |       |       |       |       |           |
>              +-------+       +-------+       +-----------+
> 
> The primary mechanism to transfer data using the QDMA is for the QDMA
> engine to operate on instructions (descriptors) provided by the host
> operating system. Using the descriptors, the QDMA can move data in both
> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
> The QDMA provides a per-queue basis option whether DMA traffic goes
> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
> 
> The hardware detail is provided by
>      https://docs.xilinx.com/r/en-US/pg302-qdma
> 
> Implements dmaengine APIs to support MM DMA transfers.
> - probe the available DMA channels
> - use dma_slave_map for channel lookup
> - use virtual channel to manage dmaengine tx descriptors
> - implement device_prep_slave_sg callback to handle host scatter gather
>    list
> - implement descriptor metadata operations to set device address for DMA
>    transfer
> 
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---

..

> +static void qdma_free_qintr_rings(struct qdma_device *qdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < qdev->qintr_ring_num; i++) {
> +		if (!qdev->qintr_rings[i].base)
> +			continue;
> +
> +		dma_free_coherent(&qdev->pdev->dev, QDMA_INTR_RING_SIZE,
> +				  qdev->qintr_rings[i].base,
> +				  qdev->qintr_rings[i].dev_base);
> +	}
> +}
> +
> +static int qdma_alloc_qintr_rings(struct qdma_device *qdev)
> +{
> +	u32 ctxt[QDMA_CTXT_REGMAP_LEN];
> +	struct device *dev = &qdev->pdev->dev;
> +	struct qdma_intr_ring *ring;
> +	struct qdma_ctxt_intr intr_ctxt;
> +	u32 vector;
> +	int ret, i;
> +
> +	qdev->qintr_ring_num = qdev->queue_irq_num;
> +	qdev->qintr_rings = devm_kcalloc(dev, qdev->qintr_ring_num,
> +					 sizeof(*qdev->qintr_rings),
> +					 GFP_KERNEL);
> +	if (!qdev->qintr_rings)
> +		return -ENOMEM;
> +
> +	vector = qdev->queue_irq_start;
> +	for (i = 0; i < qdev->qintr_ring_num; i++, vector++) {
> +		ring = &qdev->qintr_rings[i];
> +		ring->qdev = qdev;
> +		ring->msix_id = qdev->err_irq_idx + i + 1;
> +		ring->ridx = i;
> +		ring->color = 1;
> +		ring->base = dma_alloc_coherent(dev, QDMA_INTR_RING_SIZE,
> +						&ring->dev_base,
> +						GFP_KERNEL);

Hi,

Does it make sense to use dmam_alloc_coherent() and remove 
qdma_free_qintr_rings()?

If yes, maybe the function could be renamed as qdmam_alloc_qintr_rings() 
or devm_qdma_alloc_qintr_rings() to show that it is fully managed.

CJ

> +		if (!ring->base) {
> +			qdma_err(qdev, "Failed to alloc intr ring %d", i);
> +			ret = -ENOMEM;
> +			goto failed;
> +		}
> +		intr_ctxt.agg_base = QDMA_INTR_RING_BASE(ring->dev_base);
> +		intr_ctxt.size = (QDMA_INTR_RING_SIZE - 1) / 4096;
> +		intr_ctxt.vec = ring->msix_id;
> +		intr_ctxt.valid = true;
> +		intr_ctxt.color = true;
> +		ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
> +					QDMA_CTXT_CLEAR, ring->ridx, NULL);
> +		if (ret) {
> +			qdma_err(qdev, "Failed clear intr ctx, ret %d", ret);
> +			goto failed;
> +		}
> +
> +		qdma_prep_intr_context(qdev, &intr_ctxt, ctxt);
> +		ret = qdma_prog_context(qdev, QDMA_CTXT_INTR_COAL,
> +					QDMA_CTXT_WRITE, ring->ridx, ctxt);
> +		if (ret) {
> +			qdma_err(qdev, "Failed setup intr ctx, ret %d", ret);
> +			goto failed;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, vector, NULL,
> +						qdma_queue_isr, IRQF_ONESHOT,
> +						"amd-qdma-queue", ring);
> +		if (ret) {
> +			qdma_err(qdev, "Failed to request irq %d", vector);
> +			goto failed;
> +		}
> +	}
> +
> +	return 0;
> +
> +failed:
> +	qdma_free_qintr_rings(qdev);
> +	return ret;
> +}

..

