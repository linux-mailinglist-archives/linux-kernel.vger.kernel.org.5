Return-Path: <linux-kernel+bounces-10469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F081D4BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2AE283E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE61DF6B;
	Sat, 23 Dec 2023 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcMjH+Sh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74EDF5C;
	Sat, 23 Dec 2023 14:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2F5C433C8;
	Sat, 23 Dec 2023 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703343460;
	bh=5dqtiaOP2sNMec4FrJol2Ut33I0VlXzW1FLMArinrtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcMjH+ShqXzKPLM6etWeeOJTMrJ/MyBXHymc9DhCFPDBPqmFUXtRjWIK1OIv/3x9d
	 Ta73xEN5b6svVnGdNwRxOL4iaB/Xo65Z4aKkWHJH/if68r09cxmUs7DFqOMGTQyriV
	 6oOZ4+PncjLMJnOahyM5Z3orI1OdwRcNPj2yg2PtncMNx7PHhZ+oDCI6Srathef647
	 0WQhm0F800YK1j1doC5rbItBgNu5lUxT4XCzQh36DF+LB5iaylJs566vD1i1rVIn7r
	 YQx7v6eTK/QaL7W0/1wDtckgC8ybeG6IB7IabXyEqjV3e9uWd/PmNotQ5w84BgA1YL
	 drPAaot5TWm9g==
Date: Sat, 23 Dec 2023 14:57:36 +0000
From: Simon Horman <horms@kernel.org>
To: deepakx.nagaraju@intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdavem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/4] net: ethernet: altera: fix indentation warnings
Message-ID: <20231223145736.GD201037@kernel.org>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
 <20231221134041.27104-1-deepakx.nagaraju@intel.com>
 <20231221134041.27104-3-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221134041.27104-3-deepakx.nagaraju@intel.com>

On Thu, Dec 21, 2023 at 09:40:39PM +0800, deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Fix indentation issues such as missing a blank line after declarations
> and alignment issues.
> 
> Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
> index 1c8763be0e4b..6a1a004ea693 100644
> --- a/drivers/net/ethernet/altera/altera_tse_main.c
> +++ b/drivers/net/ethernet/altera/altera_tse_main.c
> @@ -258,14 +258,12 @@ static int alloc_init_skbufs(struct altera_tse_private *priv)
>  	int i;
> 
>  	/* Create Rx ring buffer */
> -	priv->rx_ring = kcalloc(rx_descs, sizeof(struct tse_buffer),
> -				GFP_KERNEL);
> +	priv->rx_ring = kcalloc(rx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
>  	if (!priv->rx_ring)
>  		goto err_rx_ring;
> 
>  	/* Create Tx ring buffer */
> -	priv->tx_ring = kcalloc(tx_descs, sizeof(struct tse_buffer),
> -				GFP_KERNEL);
> +	priv->tx_ring = kcalloc(tx_descs, sizeof(struct tse_buffer), GFP_KERNEL);

Hi,

Networking still prefers code that is less than 80 columns wide.
So I think the above changes are not desirable.

The rest of the patch looks find to me, assuming the maintainers want to
take cosmetic changes of this nature. Which, personally, I lean to thinking
is ok in the context of the rest of this patch-set.

>  	if (!priv->tx_ring)
>  		goto err_tx_ring;
> 

...

