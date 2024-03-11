Return-Path: <linux-kernel+bounces-98607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1539877C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01931C20E21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAA17577;
	Mon, 11 Mar 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPGYambr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88417557;
	Mon, 11 Mar 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148951; cv=none; b=l1Dm+IL0IGKOv/jTGa8prfB+HI56bPvFY5eT8NjNbRZhmwQGTQJ2XhuxpDAh2sh0Su64DMm15CPVhxNezlpIFN/bGLTy3JaRZhPba27etnovRZGvmHGCHmm5/JvoDD9ip2AhKgqKbwMDdnq3dpmHprOcFpEpuXRSYp9FM1dXN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148951; c=relaxed/simple;
	bh=5jwRjzBuqHsD6PpmjxxWVJQrTPGroJenGMk4S3Kn5mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI2hkkQFNgv2VwtYUbkLUux5sNcpQ9y/NfVtGxLdyfV7rhZJ0mRFZ+cTvvLXUE7Z3mLZxX1k3LaKyl5On6hjfYadTaTPN0Reja/MNdNzQPDIh5+68DHBfIqcQRPl+YhmPKq74padciN8m5lnzYtJsvEZTi8dA7ZSWfltIcT71UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPGYambr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15C4C433C7;
	Mon, 11 Mar 2024 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148950;
	bh=5jwRjzBuqHsD6PpmjxxWVJQrTPGroJenGMk4S3Kn5mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPGYambr5jaJ6Z+mS4Splw3bUn17P/mw45+F/F4IKxxOGqgIy5tsW8sRz6KP1fZrg
	 vacdvHj1yvz9RrE1Q79OWQgXSM4pdqnD+1cT/mb/E6f0VuRItRqEw78Rhh/POdTFH3
	 mGGeZipdfIemSqwvX67bFvDrrT3tFDgCOp/7i/totLr1hopE1DVNMFNSeHtsXwp1Tj
	 z0l7wRA7ksCwKFc7EO9fsSuiDdRPt9hCgTKBvj1nPePVbLi2bXufCLO0p1V+gHcbJb
	 VfxAoU2YsFuhUrWGNlNuk02YkfrE/hE+p6ugdar+xaqB48S7QsG2XW5NzAGy+MKYcI
	 08YRBY5TWwc0A==
Date: Mon, 11 Mar 2024 09:22:23 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org,
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v2 2/2] wireguard: Remove generic
 .ndo_get_stats64
Message-ID: <20240311092223.GG24043@kernel.org>
References: <20240308112746.2290505-1-leitao@debian.org>
 <20240308112746.2290505-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308112746.2290505-2-leitao@debian.org>

On Fri, Mar 08, 2024 at 03:27:45AM -0800, Breno Leitao wrote:
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

..

