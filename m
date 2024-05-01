Return-Path: <linux-kernel+bounces-165542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6AF8B8DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C03B227C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B013049B;
	Wed,  1 May 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOTfPEIL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E534CE1F;
	Wed,  1 May 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579692; cv=none; b=C8hRYiy7WNuf0YDuev8KM/eWbKTiKCc2JhTFFJs6pfXXaZKQ5DLSMpZsMVPRHPA9gfmHH60Dj+2Z1ZBk5MEA/MH1gbJUuzY6t2GZmdSgsP7+todtUaSkBRPkMfI3unjHA/Rqyl+4qzd3aH57ZL7Mk+BBVXdYlCMj2jTV8XTZ3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579692; c=relaxed/simple;
	bh=Iey2iVH1MIhrk7WU5n9kwLcgqdG/28gxVMTeDEIBfOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRPnVZN4pQhUnOJXZGBVJmYkjKuSVafJDZQkf/4KghXaUrgtuoaSZWoV61g0zxDd12lA8ZZOUp0lHrBmMujObZKGpIT9nMSJbIZ0L27AAXVjJIYZXSPDGOEG5b7CrkxZbxP/g2W+mXVeUA5iZhYyImkSn9XjX+yv20be/Y1h92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOTfPEIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CCCC113CC;
	Wed,  1 May 2024 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714579692;
	bh=Iey2iVH1MIhrk7WU5n9kwLcgqdG/28gxVMTeDEIBfOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOTfPEILul9GgwLwVzI08ADSnYF3WZ7Yn7KJxwHjapMUQm7fmgWUnyZkmX58hOCut
	 Qk88ysylEyLMUFMdH7RASGzWCNTCBxEK/Pe5C0xhPwgZdn3a98FdKbCE/UNXUHae54
	 99pO5crWIscgPmcFff1NW7kIcZiJ5FGbtlKXSvcoSqqXl+RdsHaF0jGtl5rCF4R5Gm
	 25hdTp+iBC+lPsIo5O57Kh/JZBhTuuxBA/O3930KRca3l+DdxObHvfxVq5tQ8X0jCX
	 jUTNFZvkq3UEhIpfvm0WYiFqonjxvaN4DF4maSCGPVGplL722OK5c+FoyucpQ1Epv8
	 T1u8Ud8afbvqQ==
Date: Wed, 1 May 2024 17:06:37 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v3 2/9] octeontx2-pf: RVU representor driver
Message-ID: <20240501160637.GW2575892@kernel.org>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428105312.9731-3-gakula@marvell.com>

On Sun, Apr 28, 2024 at 04:23:05PM +0530, Geetha sowjanya wrote:
> This patch adds basic driver for the RVU representor.
> Driver on probe does pci specific initialization and does hw
> resources configuration.
> Introduces RVU_ESWITCH kernel config to enable/disable
> this driver. Representor and NIC shares the code but representors
> netdev support subset of NIC functionality. Hence "otx2_rep_dev"
> api helps to skip the features initialization that are not supported
> by the representors.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

..

> +static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct otx2_nic *priv;
> +	struct otx2_hw *hw;
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(dev, "Failed to enable PCI device\n");
> +		return err;
> +	}
> +
> +	err = pci_request_regions(pdev, DRV_NAME);
> +	if (err) {
> +		dev_err(dev, "PCI request regions failed 0x%x\n", err);
> +		return err;
> +	}
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +	if (err) {
> +		dev_err(dev, "DMA mask config failed, abort\n");
> +		goto err_release_regions;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		goto err_release_regions;

Hi Geetha,

This goto will result in the function returning err.
But err is 0 here. Perhaps it should be set to -ENOMEM?

Flagged by Smatch.

> +
> +	pci_set_drvdata(pdev, priv);
> +	priv->pdev = pdev;
> +	priv->dev = dev;
> +	priv->flags |= OTX2_FLAG_INTF_DOWN;
> +	priv->flags |= OTX2_FLAG_REP_MODE_ENABLED;
> +
> +	hw = &priv->hw;
> +	hw->pdev = pdev;
> +	hw->max_queues = OTX2_MAX_CQ_CNT;
> +	hw->rbuf_len = OTX2_DEFAULT_RBUF_LEN;
> +	hw->xqe_size = 128;
> +
> +	err = otx2_init_rsrc(pdev, priv);
> +	if (err)
> +		goto err_release_regions;
> +
> +	err = rvu_get_rep_cnt(priv);
> +	if (err)
> +		goto err_detach_rsrc;
> +
> +	err = rvu_rep_rsrc_init(priv);
> +	if (err)
> +		goto err_detach_rsrc;
> +
> +	return 0;
> +
> +err_detach_rsrc:
> +	if (priv->hw.lmt_info)
> +		free_percpu(priv->hw.lmt_info);
> +	if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
> +		qmem_free(priv->dev, priv->dync_lmt);
> +	otx2_detach_resources(&priv->mbox);
> +	otx2_disable_mbox_intr(priv);
> +	otx2_pfaf_mbox_destroy(priv);
> +	pci_free_irq_vectors(pdev);
> +err_release_regions:
> +	pci_set_drvdata(pdev, NULL);
> +	pci_release_regions(pdev);
> +	return err;
> +}

..

