Return-Path: <linux-kernel+bounces-167469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48958BA9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038101C203A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA714F13D;
	Fri,  3 May 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzTvZuSm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A061367;
	Fri,  3 May 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728816; cv=none; b=Qrj49COi5Jk+T0C5RKYJkGkzaSFu0gkxuRO9skPkmhDNFil3hSlyKe6NdochGIuw7Za2Aezw18R5iXaPloSlf//mPcZwej/DNzbB0QLXTTvCJCJVO9no6vX+0aaWgF++4DiM0rL7vGfZLuvvmZNXP/4zWBr74yqGthKDxTcawic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728816; c=relaxed/simple;
	bh=v/51Kvqf2YPc7OkiFmKvzSlAQA/mzLPnt8TJCh81qMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA5pJlNgc4Ba2p06c9nymK5Yi6i3W+d1FoQqrUrgKRoDPSpXgDXavFbb6eFx2OQJKflk3nG7F/PMbTRXwRCS+T0jJj6l7FrqvYtb0aAF/mXpfrwFpIb0oWkxujeIXRLw5vebLyJ1zgxCEXx2P1NCu7zx2lUKMdqRfkRNCJaJdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzTvZuSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AF1C116B1;
	Fri,  3 May 2024 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714728816;
	bh=v/51Kvqf2YPc7OkiFmKvzSlAQA/mzLPnt8TJCh81qMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzTvZuSm/5PtavQI3wADx0KGUxs+kUgPcYMDKFHBS8l75cmt3Sy/V2D0G4j0VPRgs
	 sl4l7q9XzHK35l2cBE3PIQoa/5zCMicO7R3xH2ljQpKA0AXiP6ITfGzNCrLzr8snOY
	 llgCbhaMr8sEdG+jVUcQNX2I4kfvCcnnimTS3jiA3ZkuWIsmE4Xaq+m8yzxRm3KH9y
	 rCoUMGBu4fgPUbBUts14/BPUZjhjBWD4G7YdfYUV9oE5mUC5kpkYDHAP5WOHXV4XKL
	 F8MdOA899tm1w0tvtnwvMeL86xSSo25hcUKOAyLwCz+vIBWB7n6kXqlx4ULrkeLxEH
	 RAPClPUZzw2/w==
Date: Fri, 3 May 2024 10:33:31 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v17 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20240503093331.GN2821784@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091847.65181-2-justinlai0215@realtek.com>

On Thu, May 02, 2024 at 05:18:35PM +0800, Justin Lai wrote:
> Add pci table supported in this module, and implement pci_driver function
> to initialize this driver, remove this driver, or shutdown this driver.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

..

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> new file mode 100644
> index 000000000000..5ddb5f7abfe9
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -0,0 +1,618 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + *  rtase is the Linux device driver released for Realtek Automotive Switch
> + *  controllers with PCI-Express interface.
> + *
> + *  Copyright(c) 2023 Realtek Semiconductor Corp.
> + *
> + *  Below is a simplified block diagram of the chip and its relevant interfaces.
> + *
> + *               *************************
> + *               *                       *
> + *               *  CPU network device   *
> + *               *                       *
> + *               *   +-------------+     *
> + *               *   |  PCIE Host  |     *
> + *               ***********++************
> + *                          ||
> + *                         PCIE
> + *                          ||
> + *      ********************++**********************
> + *      *            | PCIE Endpoint |             *
> + *      *            +---------------+             *
> + *      *                | GMAC |                  *
> + *      *                +--++--+  Realtek         *
> + *      *                   ||     RTL90xx Series  *
> + *      *                   ||                     *
> + *      *     +-------------++----------------+    *
> + *      *     |           | MAC |             |    *
> + *      *     |           +-----+             |    *
> + *      *     |                               |    *
> + *      *     |     Ethernet Switch Core      |    *
> + *      *     |                               |    *
> + *      *     |   +-----+           +-----+   |    *
> + *      *     |   | MAC |...........| MAC |   |    *
> + *      *     +---+-----+-----------+-----+---+    *
> + *      *         | PHY |...........| PHY |        *
> + *      *         +--++-+           +--++-+        *
> + *      *************||****************||***********

Thanks for the diagram, I like it a lot :)

> + *
> + *  The block of the Realtek RTL90xx series is our entire chip architecture,
> + *  the GMAC is connected to the switch core, and there is no PHY in between.
> + *  In addition, this driver is mainly used to control GMAC, but does not
> + *  control the switch core, so it is not the same as DSA.
> + */

..

> +static int rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
> +{
> +	int ret;
> +	u16 i;
> +
> +	memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct msix_entry));
> +
> +	for (i = 0; i < RTASE_NUM_MSIX; i++)
> +		tp->msix_entry[i].entry = i;
> +
> +	ret = pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums);
> +	if (!ret) {

In Linux Networking code it is an idiomatic practice to keep
handle errors in branches and use the main path of execution
for the non error path.

In this case I think that would look a bit like this:

	ret = pci_enable_msix_exact(pdev, tp->msix_entry, tp->int_nums);
	if (ret)
		return ret;

	...

	return 0;

> +
> +		for (i = 0; i < tp->int_nums; i++)
> +			tp->int_vector[i].irq = pci_irq_vector(pdev, i);

pci_irq_vector() can fail, should that be handled here?

> +	}
> +
> +	return ret;
> +}
> +
> +static int rtase_alloc_interrupt(struct pci_dev *pdev,
> +				 struct rtase_private *tp)
> +{
> +	int ret;
> +
> +	ret = rtase_alloc_msix(pdev, tp);
> +	if (ret) {
> +		ret = pci_enable_msi(pdev);
> +		if (ret)
> +			dev_err(&pdev->dev,
> +				"unable to alloc interrupt.(MSI)\n");

If an error occurs then it is a good practice to unwind resource
allocations made within the context of this function call, as this
leads to more symmetric unwind paths in callers.

In this case I think any resources consumed by rtase_alloc_msix()
should be released if pci_enable_msi fails. Probably using
a goto label is appropriate here.

Likewise, I suggest that similar logic applies to errors within
rtase_alloc_msix().

> +		else
> +			tp->sw_flag |= RTASE_SWF_MSI_ENABLED;
> +	} else {
> +		tp->sw_flag |= RTASE_SWF_MSIX_ENABLED;
> +	}
> +
> +	return ret;
> +}

..

