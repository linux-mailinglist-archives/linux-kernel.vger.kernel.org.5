Return-Path: <linux-kernel+bounces-146633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200958A688F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1103B20E74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10D127E22;
	Tue, 16 Apr 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmWN4tHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97C3FC2;
	Tue, 16 Apr 2024 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263827; cv=none; b=JUt1aTumloJFpNZ4ibCZ7vrJReQrzvVNg7lfUsm+iIBJHhyl1NATwGmN8KrDg53AZRZL9THxhd+IU2EqF04nqiQs2O1wX+eH3x2DIMhyOrfUWp3L6+AmdXx31XBwEQKRtBI3UdZ6fXfHV/firy3TJPFXvnMdVwZR6hDX82//1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263827; c=relaxed/simple;
	bh=Q17prcLTZ4z/UsT9fHA73b3ttRGaWuJzjG+Viwqifs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA50gBeaQSCnptO0v7YtQD8NSJJlvTMvnII6CLPhO3joXV8D9Wgdy7vKX8QobeUVoI2SPzj3VUytnqcuDJLai5wZs49R/O4pAlk6BtkYowOzshL6f6A3N8Cz+hVqUluU6FVlRdvisFztWa9wZDKfW71OgWu1IUJFAUwlvA7zJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmWN4tHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3544C113CE;
	Tue, 16 Apr 2024 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713263827;
	bh=Q17prcLTZ4z/UsT9fHA73b3ttRGaWuJzjG+Viwqifs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmWN4tHhWI43GRSRrNxifMOevONMzAQjGB+y+H6S0b2dl9u98KntHuN4EtaeedBti
	 DKuA60j76SwG8Q1hWCqJXYr4pOY1AbT86A9+2pVPM76NUhpzB9+hw+0hJzL285DMgE
	 z3qz5HNPaxK3HSdJHKPSahY9EFGcLlhV346FJLzEBwHtpxGSp+zcN1GXHgZaU9PWKo
	 Na/No3ZQnPhWixSnwcZSZv1NnFjO13w48bmk107YrLfa1yjrt2EXqKu1hEUJ2hnLyF
	 hD5PpQOZWjwvyI9zUWb+x8i50Pop+QmSwo+M0X4SAGF3bk6aScz5Iy/4Pmreq8XMMa
	 Lijr8/9xwCZuQ==
Date: Tue, 16 Apr 2024 11:37:02 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2] octeontx2-pf: Add support for offload tc
 with skbedit mark action
Message-ID: <20240416103702.GI2320920@kernel.org>
References: <20240414062957.18840-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414062957.18840-1-gakula@marvell.com>

On Sun, Apr 14, 2024 at 11:59:57AM +0530, Geetha sowjanya wrote:
> Support offloading of skbedit mark action.
> 
> For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
> interface:
> 
>  # tc qdisc add dev eth2 ingress
>  # tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> v1-v2: 
>   -Changed mark_flows data type to refcount_t 

Thanks Geetha,

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

..

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 87bdb93cb066..8b8ac179f3c3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -511,7 +511,15 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
>  			nr_police++;
>  			break;
>  		case FLOW_ACTION_MARK:
> +			if (act->mark & ~OTX2_RX_MATCH_ID_MASK) {
> +				NL_SET_ERR_MSG_MOD(extack, "Bad flow mark, only 16 bit supported");
> +				return -EOPNOTSUPP;
> +			}
>  			mark = act->mark;
> +			req->match_id = mark & 0xFFFFULL;

nit: Is the mask necessary here?
     act->mark was already checked against OTX2_RX_MATCH_ID_MASK
     to ensure that nothing is set in the upper 16 bits.

     If it is, could OTX2_RX_MATCH_ID_MASK be used instead of 0xFFFFULL ?
     Or perhaps use lower_16_bits().

     No need for this to block this patch, AFAIK.
     But perhaps a follow-up could be considered.

> +			req->op = NIX_RX_ACTION_DEFAULT;
> +			nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
> +			refcount_inc(&nic->flow_cfg->mark_flows);
>  			break;
>  
>  		case FLOW_ACTION_RX_QUEUE_MAPPING:

..

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> index a82ffca8ce1b..3f1d2655ff77 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
> @@ -62,6 +62,9 @@
>  #define CQ_OP_STAT_OP_ERR       63
>  #define CQ_OP_STAT_CQ_ERR       46
>  
> +/* Packet mark mask */
> +#define OTX2_RX_MATCH_ID_MASK 0x0000ffff
> +
>  struct queue_stats {
>  	u64	bytes;
>  	u64	pkts;
> -- 
> 2.25.1
> 
> 

