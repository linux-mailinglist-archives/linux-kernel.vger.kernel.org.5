Return-Path: <linux-kernel+bounces-118317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B088B7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908C71F3BC36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624F128801;
	Tue, 26 Mar 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feaME8kF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330121CA82;
	Tue, 26 Mar 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421612; cv=none; b=JEdSnQIhMiWDEINhDhdHVQtLAVjUApz+COQqy9DVZvE7CXs4UCwbSqeEXXTpqUPWDE8Ad/S8C2EnNENW4EWoQHh1gSWjz0uEzOtkqoxJ5SCThmHOWrDGzUbsS1qN9acUsnCGOGeHqfFHfo1U3migG3jJn76sk9sJZ4qrpWn6M7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421612; c=relaxed/simple;
	bh=NMtmWqWmkRPpkVqh92xHhl5pnCeC9YJGjvadE6q8bUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbyL3/lX22M7zejxYBbwBZ85trdWxpAvdlyEjVA5ss3lqhtDWj8rcUMcSCxZG6e4TonlZ16Ls1KRl+DXqYf00XjYk8I0cVvIrJzbyIGo7hNrCaunV5QhU+t3z1xYuEbzt7pfxkBJGX0bif84Xn5bAMHTzObwY1rG2bjlSiwlbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feaME8kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AA7C433F1;
	Tue, 26 Mar 2024 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711421611;
	bh=NMtmWqWmkRPpkVqh92xHhl5pnCeC9YJGjvadE6q8bUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=feaME8kFM+6WxPAut4pQ/Bn7emL0BU1lXB1zKroIW4hRuoyZIJtfnQ+vLRJyJ9hVQ
	 2bUEaunCVSB35b68jk1EaQ/SGgV93dZBRvWtbKWdrmBZjBguArONZ0DyVv0aoYhDU7
	 jF6ppgBt7stCkujcdYuUunuEhgH4pbPN8Z78cQGQD+CqbUFaj3J9G8N6w8GvGAz3dP
	 3ZcRLtLUdn14TEftof0sFV8qxu5B/qyz2uFXKHalsmDNcV1F3GLzSUNQ1VNj1syXwJ
	 BKC037PGDZ9HcqQyaqIwEsMaX0/ETFNiR4rOoG9owd7siybZturmfmmqrcPAixReR4
	 VYXjUa9D3eBmg==
Date: Mon, 25 Mar 2024 19:53:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
 <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V1] net: lan743x: Add set RFE read fifo threshold
 for PCI1x1x chips
Message-ID: <20240325195330.630b7605@kernel.org>
In-Reply-To: <20240322064650.275174-1-Raju.Lakkaraju@microchip.com>
References: <20240322064650.275174-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 12:16:50 +0530 Raju Lakkaraju wrote:
> +static int pci11x1x_set_rfe_rd_fifo_threshold(struct lan743x_adapter *adapter)

Let's make this a void function.
It only returns 0 and the caller doesn't check for errors, anyway.

> +{
> +	u16 rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
> +
> +	if (rev == ID_REV_CHIP_REV_PCI11X1X_B0_) {
> +		u32 misc_ctl;
> +
> +		misc_ctl = lan743x_csr_read(adapter, MISC_CTL_0);
> +		misc_ctl &= ~MISC_CTL_0_RFE_READ_FIFO_MASK_;
> +		misc_ctl |= FIELD_PREP(MISC_CTL_0_RFE_READ_FIFO_MASK_,
> +				       RFE_RD_FIFO_TH_3_DWORDS);
> +		lan743x_csr_write(adapter, MISC_CTL_0, misc_ctl);
> +	}
> +
> +	return 0;
> +}
> +
>  static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>  				 struct pci_dev *pdev)
>  {
> @@ -3287,6 +3306,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>  		pci11x1x_strap_get_status(adapter);
>  		spin_lock_init(&adapter->eth_syslock_spinlock);
>  		mutex_init(&adapter->sgmii_rw_lock);
> +		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
-- 
pw-bot: cr

