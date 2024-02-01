Return-Path: <linux-kernel+bounces-48234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0288458E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108821F28D50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16F5339C;
	Thu,  1 Feb 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEXUWemM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E653377;
	Thu,  1 Feb 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794207; cv=none; b=JPHq2JjVuQycUFcgAKNbLEJLXZTVg/hXag24DtrvoiLtyaoy9G/Kmr5+YY5j9hIr8zjEZfELvnygVyWo1vQae1l6X1YWUfIng/cTc3QGNG5ymXz3lRiCFVrBof/+Ha2hDFLSAOg4icAd2DMrmT5jO1Sf8PrpjjucNWeHK99J4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794207; c=relaxed/simple;
	bh=4swrM4alFmGHIV9rLYolfhNl1z4eenjzX5UGMuP51e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhF68CewDSf1BHW2wfPqVtL5uAQ69xoi1udGjgukw6tSmD61AgLmO/F253gVOTHRpJBZZabvrjcChEfMmBS6G06aYYZpNW4uTVTkDFg2WDtQw9FmVUKZKGjP4CNkn9fnnP/f2m7deAQ8/jiQdltJI22KA5mHLioqbXLBr8uUYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEXUWemM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B116C433C7;
	Thu,  1 Feb 2024 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794206;
	bh=4swrM4alFmGHIV9rLYolfhNl1z4eenjzX5UGMuP51e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEXUWemMB88V51rl7TUk+J2QCqlF4Wq5rjg3xkr0QM+eund5jsdf995s5EiPgUC4F
	 R0wXxRt9n+wuxTzIPAEbqYDpz8JjqVdhA/OTicluDgNOiTYIqiv8tiTigNYrsKSb73
	 N2LbZVMIeCGQpTWLZmE7HT5JPPrpKz94rrzn6mHxbNSuJxoXdq19PBNoRBNuUH6RmQ
	 hTSKry8JNkfog8weOGQdO0ntwFLUgvXZddYL3CpLAdZ+Or2+C51d39GZ2BVA6oLllz
	 cm567Npkg8E1bmG9AEDcJBqC/5LrvL25xn2xQiEfMnn4vG+b2a6DB2iymKkWiN9MxG
	 DOJP2aWwf8C+w==
Date: Thu, 1 Feb 2024 14:30:01 +0100
From: Simon Horman <horms@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, rogerq@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, srk@ti.com
Subject: Re: [RFC PATCH net-next 1/2] net: ethernet: ti: Introduce
 inter-core-virt-eth as RPMsg driver
Message-ID: <20240201133001.GC530335@kernel.org>
References: <20240130110944.26771-1-r-gunasekaran@ti.com>
 <20240130110944.26771-2-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130110944.26771-2-r-gunasekaran@ti.com>

On Tue, Jan 30, 2024 at 04:39:43PM +0530, Ravi Gunasekaran wrote:
> TI's K3 SoCs comprises heterogeneous processors (Cortex A, Cortex R).
> When the ethernet controller is completely managed by a core (Cortex R)
> running a flavor of RTOS, in a non virtualized environment, network traffic
> tunnelling between heterogeneous processors can be realized by means of
> RPMsg based shared memory ethernet driver. With the shared memory used
> for the data plane and the RPMsg end point channel used for control plane.
> 
> inter-core-virt-eth driver is modelled as a RPMsg based shared
> memory ethernet driver for such an use case.
> 
> As a first step, register the inter-core-virt-eth as a RPMsg driver.
> And introduce basic control messages for querying and responding.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  drivers/net/ethernet/ti/inter-core-virt-eth.c | 139 ++++++++++++++++++
>  drivers/net/ethernet/ti/inter-core-virt-eth.h |  89 +++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.c
>  create mode 100644 drivers/net/ethernet/ti/inter-core-virt-eth.h
> 
> diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.c b/drivers/net/ethernet/ti/inter-core-virt-eth.c
> new file mode 100644
> index 000000000000..d3b689eab1c0
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/inter-core-virt-eth.c
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Hi Ravi and Siddharth,

The correct style for SPDX headers in .c files is a '//' comment:

// SPDX-License-Identifier: GPL-2.0

> +/* Texas Instruments K3 Inter Core Virtual Ethernet Driver
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */

..

> diff --git a/drivers/net/ethernet/ti/inter-core-virt-eth.h b/drivers/net/ethernet/ti/inter-core-virt-eth.h

..

> +struct icve_common {
> +	struct rpmsg_device *rpdev;
> +	spinlock_t send_msg_lock;
> +	spinlock_t recv_msg_lock;

Spinlocks ought to come with an comment regarding what they lock.

> +	struct message send_msg;
> +	struct message recv_msg;
> +	struct icve_port *port;
> +	struct device *dev;
> +} __packed;
> +
> +#endif /* __INTER_CORE_VIRT_ETH_H__ */
> -- 
> 2.17.1
> 
> 

