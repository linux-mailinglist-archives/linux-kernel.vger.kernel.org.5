Return-Path: <linux-kernel+bounces-165679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BC8B8F63
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90041F22819
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B11474BE;
	Wed,  1 May 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk+vzRmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D08146D5F;
	Wed,  1 May 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586821; cv=none; b=nYn9qfyeufFnhZ3P7uHoT2zf+KeMLlsdwIY9GjZMvgqqbFVQOLJTCr0ASPgmRnZHj+48+Se+C5WDlxio5eaqk2DZFroYMJVgL+t4xGIhon81ZSctSMZ9Hw6vzdQvDdAXWezNlpe6fp696rFefQZ6D4J2VrvRR0HLs0THuF9ghKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586821; c=relaxed/simple;
	bh=BJj8XRO5iS4yosKp1oeBCQudQrPdTkzhVtktCTqHKMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1bXIBQAf2F7PkihtGKYvcOTxAzlaw0TIpNL2/ZMaK+LPJOlUu6cUOOfK1YhQTeRCJDna/c9RHWzGcK1iUGk36szbib/Z1nIeCGT2ZBxZzMY7gQ93vIzlOf/ir4tEmxz3vzCVT/8uQaVxiHvgbIUvEVLgJpzJ8EiDjHH1S+SevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk+vzRmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22E4C072AA;
	Wed,  1 May 2024 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714586821;
	bh=BJj8XRO5iS4yosKp1oeBCQudQrPdTkzhVtktCTqHKMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk+vzRmv7vSAmXs8P2KRjcS9eTNnTb/bNDycB0r8nq4Gzv1uDHbdh2Qba3g/z0sGw
	 SosEWbFauf8T0O+s6CIKTHCH3je+C3Aui9xbu3rPFt9/A29Lc5djFWqvv9Z2O+qWqF
	 ypGBq+YH+lqg5WdDsukt/8kwFu9V0rjyDh57A460ZcfKn0RMq7blkgt2Xxz8ZUNezc
	 6U+xMnN6hZBKKurqHqBBdeftGoLvMzyw4n05CbQUYbk0TVLlG43eF9Jri0koGC8aAu
	 UmTYnKXJe4xDtfqOlXXxNjPWTFAqF+OZfS95NeiWpXhuicmv+ChhwWzAtlRfbg1/2x
	 +vui3Mppohsgw==
Date: Wed, 1 May 2024 19:06:56 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [net-next PATCH v3 3/9] octeontx2-pf: Create representor netdev
Message-ID: <20240501180656.GX2575892@kernel.org>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428105312.9731-4-gakula@marvell.com>

+ Dan Carpenter

On Sun, Apr 28, 2024 at 04:23:06PM +0530, Geetha sowjanya wrote:
> Adds initial devlink support to set/get the switchdev mode.
> Representor netdevs are created for each rvu devices when
> the switch mode is set to 'switchdev'. These netdevs are
> be used to control and configure VFs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Hi Geetha,

Some minor feedback from my side.

..

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c

..

> +int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> +{
> +	int rep_cnt = priv->rep_cnt;
> +	struct net_device *ndev;
> +	struct rep_dev *rep;
> +	int rep_id, err;
> +	u16 pcifunc;
> +
> +	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev), GFP_KERNEL);

It looks like the size argument should be sizeof(struct rep_dev *)
or sizeof(*priv->reps).

Flagged by Coccinelle.

Please consider limiting lines in Networking code to 80 columns wide
where it can be achieved without too much bother.

> +	if (!priv->reps)
> +		return -ENOMEM;
> +
> +	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
> +		ndev = alloc_etherdev(sizeof(*rep));
> +		if (!ndev) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF representor:%d creation failed\n",
> +					       rep_id);
> +			err = -ENOMEM;
> +			goto exit;
> +		}
> +
> +		rep = netdev_priv(ndev);
> +		priv->reps[rep_id] = rep;
> +		rep->mdev = priv;
> +		rep->netdev = ndev;
> +		rep->rep_id = rep_id;
> +
> +		ndev->min_mtu = OTX2_MIN_MTU;
> +		ndev->max_mtu = priv->hw.max_mtu;
> +		pcifunc = priv->rep_pf_map[rep_id];
> +		rep->pcifunc = pcifunc;
> +
> +		snprintf(ndev->name, sizeof(ndev->name), "r%dp%d", rep_id,
> +			 rvu_get_pf(pcifunc));
> +
> +		eth_hw_addr_random(ndev);
> +		err = register_netdev(ndev);
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD(extack, "PFVF reprentator registration failed\n");

I don't think the string passed to NL_SET_ERR_MSG_MOD needs a trailing '\n'.
I'm unsure if this also applies to NL_SET_ERR_MSG_FMT_MOD or not.

Flagged by Coccinelle.


The current ndev appears to be leaked here,
as it does not appear to be covered by the unwind loop below.

I think this can be resolved using:

			free_netdev(ndev);

> +			goto exit;
> +		}
> +	}
> +	err = rvu_rep_napi_init(priv, extack);
> +	if (err)
> +		goto exit;

Even with the above fixed, Smatch complains that:

../rep.c:180 rvu_rep_create() warn: 'ndev' from alloc_etherdev_mqs() not released on lines: 180.
../rep.c:180 rvu_rep_create() warn: 'ndev' from register_netdev() not released on lines: 180.

Where line 180 is the very last line of the funciton: return err;

I think this is triggered by the error handling above.
However, I also think it is a false positive.
I've CCed Dan Carpenter as I'd value a second opinion on this one.

> +
> +	return 0;
> +exit:
> +	while (--rep_id >= 0) {
> +		rep = priv->reps[rep_id];
> +		unregister_netdev(rep->netdev);
> +		free_netdev(rep->netdev);
> +	}
> +	return err;
> +}

..

