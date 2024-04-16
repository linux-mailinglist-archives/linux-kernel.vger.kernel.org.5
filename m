Return-Path: <linux-kernel+bounces-146614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138398A6835
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54A4283910
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BE5127E04;
	Tue, 16 Apr 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcCd6VO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933285942;
	Tue, 16 Apr 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262961; cv=none; b=hgcRhLBHP/KRRvjIcrqPas1UC6ApbInLFciRS4O5pya9xGaSMAT8ITkGx2Bf9V0uHAsXtMNaQBtegbX8XA55ST+T6AoTFhCXecR+uPhHaU7gfr4wP8i5fgP5nezoiOF3G5EiqzpEWFfJ2N1RJFUGjCYn4IteTMw0BMK5avrnkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262961; c=relaxed/simple;
	bh=IrO7rOwEM6Sr1YJIb/ZwBhxGi+cfstj8ZXL6G7w2XXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+bRJng11zZJuRVCuL3U7V27lLbUsbO+YDrnzCkCYW7/JiPjfGg9UaQDcpcY1qL1ds/B9Z03AOo+YW6ngjzo5FhW2anyzvLI9dmGXCTtugZJlW/p6rxxIV2GzPKTYdUFApKJcaKWVwTSO8+n6p8F2W+NZdbQzqCF6qE4D9pN13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcCd6VO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D548C113CE;
	Tue, 16 Apr 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262961;
	bh=IrO7rOwEM6Sr1YJIb/ZwBhxGi+cfstj8ZXL6G7w2XXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcCd6VO7WpftEJz93S4fGZvmKGuuB+NjNep392FA1vlvfLYnj2xIkG4pYxzyjljCh
	 82KCQSq+pJZIuhEnGcUmJqXfA69jtb+V1RKd0DOB4eJXQPBezjSBbNPVQ3wtwqK0q6
	 NXCDc+e6a3Bh9FVFr6x2kyJiACwcj8oqzYcuvsrumCwPdrNd7w5x8r2RPFbplVqZIq
	 PjoEil0gnDy4nZL+eKPlWQ7mRM5tEC2aiV4T2VywTbn9EXkj5EUECg11fXzK5sbz8j
	 fx9xLzn9qHKWWp8BooX8gnvn182lDt+TQXJAMSHUtyzze2jtyfzLkJO6rEu9B/fyJA
	 gqhD/TaHmEN0g==
Date: Tue, 16 Apr 2024 11:22:36 +0100
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net-next PATCH] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Message-ID: <20240416102236.GH2320920@kernel.org>
References: <20240414105830.678293-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414105830.678293-1-saikrishnag@marvell.com>

On Sun, Apr 14, 2024 at 04:28:30PM +0530, Sai Krishna wrote:
> Added a devlink param to set/modify unicast filter count. Currently
> it's hardcoded with a macro.

Hi Sai,

I think it would be nice to provide a sample devlink command in
the patch description, as you did for:

2da489432747 ("octeontx2-pf: devlink params support to set mcam entry count")

> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

..

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c

..

> +static int otx2_dl_ucast_flt_cnt_get(struct devlink *devlink, u32 id,
> +				     struct devlink_param_gset_ctx *ctx)
> +{
> +	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
> +	struct otx2_nic *pfvf = otx2_dl->pfvf;
> +
> +	if (!pfvf->flow_cfg) {
> +		ctx->val.vu8 = 0;
> +		return 0;
> +	}
> +
> +	ctx->val.vu8 = pfvf->flow_cfg->ucast_flt_cnt;

nit: perhaps this could be more succinctly expressed as follows
     (completely untested!):

	ctx->val.vu8 = pfvf->flow_cfg ? pfvf->flow_cfg->ucast_flt_cnt : 0;

> +
> +	return 0;
> +}

..

