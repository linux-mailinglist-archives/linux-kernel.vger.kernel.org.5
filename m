Return-Path: <linux-kernel+bounces-88665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5EB86E4FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182F7B20F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D370CB7;
	Fri,  1 Mar 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSjmfp8H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C62B9A2;
	Fri,  1 Mar 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309266; cv=none; b=QZpCODaQqWabBTTEVz9bwNKmxNZRocdIlRBO++I2d2quA1hXSpOv7oPtvCHCS9EHssROFcOmnZSIMyEc2AZokHHFhz3bj+0DsLO1UOHyKXyzX5NWxeFh71VWqsc0HVrYWGMuBBlYc0gFjq9ASZSsiV7vuvYHunFUfAw8QI+NuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309266; c=relaxed/simple;
	bh=r5ZXzcZeCkOjmfND/rIB79uZUfs9DOwUBsUxs0F34pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY+4dXCGAPuvRwao+TfpIdgbjFO3Mr80wqOpsLYNKR7T553ojhvQtBTq/npyVtSTgYBV4jGeCjBNuvTv/HlA8yxOLQ/p+t5tzB8cEWeO5BPgTI6mZ4ea6GCXdvJPVvupgqhdo2rXhbcn4VcCqBAWl5j/z9uxudJODuUDw2WG9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSjmfp8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA63FC433F1;
	Fri,  1 Mar 2024 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709309265;
	bh=r5ZXzcZeCkOjmfND/rIB79uZUfs9DOwUBsUxs0F34pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSjmfp8H0pdD32qN+AgFaOhrTjCOYBN+hCoB8PA/YMsW53+LJpfd3sNctK9X4cQbE
	 KnYMOFAdugGjT4jvwMsHuNMRCdO/RwJ/ApUGlffcc5y9D1mM1Gi8JoSnkfEj1+i/8G
	 sy7yWvEaNolOeLD/Y+4RZx8aS2Z/HJQ1E9CdMT1t0WvRWOhHHPDGVUHZJJtQRet7/c
	 HvSGv6JzBHsU2XTHAE8Kv8jjbmI5CV1n+3TSgDi4McsZltepmUPKx5JKTRLhAmxFTh
	 Ip0c1lZiuo4pDTF816V/S+QoFTr+8JbAwchqBmPmvLfs+/2mecflAeeK4JMbJtbHvn
	 8aQsfD47hTwUg==
Date: Fri, 1 Mar 2024 16:07:41 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net-next 2/2] net: bareudp: Remove generic
 .ndo_get_stats64
Message-ID: <20240301160741.GE403078@kernel.org>
References: <20240229170425.3895238-1-leitao@debian.org>
 <20240229170425.3895238-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229170425.3895238-2-leitao@debian.org>

On Thu, Feb 29, 2024 at 09:04:24AM -0800, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


