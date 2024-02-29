Return-Path: <linux-kernel+bounces-87581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77B86D623
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6171C20E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0EC16FF5D;
	Thu, 29 Feb 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myn37glh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62F16FF27;
	Thu, 29 Feb 2024 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241972; cv=none; b=H5YdI6e3xl11G8xiACboGL8RSQed0lRKI6SPywMvSxoouwjkdglxmVUYxQH/LCy73Sjw34pcQxHGIiEV+r2Gk/qyyw0nP1k7gHMah1dFNN7pbXC/tbHfDQlpNYhmO6xm0ULKe+hDyPn6F0mT/v4wNcoQBCWq6c5GfVrfquiVsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241972; c=relaxed/simple;
	bh=lJk9xa7/GLM0wwzy/lzi2jJUuy/bAoJV2ivF1DfXv6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNctVKgfJMdFez3mrH/iQMuTFm7RHnbg+3alhCTwuT9lcgWfj8I8RylG7oqPzrc20PaBaZLspCgUPQk2sPOzqAjVB4zH3MYy8B+1Z1CZwhoniN/fU1P/8ycakIc+XAa4yYPrUW9BfWwSAKKShcVK/X3LIgwVIttU3mCB9JnXDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myn37glh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB639C433C7;
	Thu, 29 Feb 2024 21:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709241972;
	bh=lJk9xa7/GLM0wwzy/lzi2jJUuy/bAoJV2ivF1DfXv6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Myn37glhD6BaHkDxAxprdk6qnpAV3DoNSW19K8dsP7vG/q3Upusjt0rIEKIBXvVYI
	 4wShmdUePwLos0+ffd3Fal3JLcN1p+Rt1W34apiGlX6bMQIAdd9uH89gx0sLfhXgPc
	 Vk3aRsZMOOMdcz0XxzTzAVNNW3+i4M4UuumDIs9x7OiU32KYgykYb2y0TdVynoVfBA
	 Oi/7xMajgQARH0tUJr5wZ84yGzRqwBPyBigaiVh+hmhouhrNcp6IuGAZDZjckSyuy8
	 fw2N9nhg6kl8o1gN7xAbmFCPikNdjWJs4G7SuiF9cEi9H3rfbBMHHRrONm6snnTbTN
	 LYsOranuOk3lQ==
Date: Thu, 29 Feb 2024 13:26:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.8-rc7
Message-ID: <20240229132610.4ea1517f@kernel.org>
In-Reply-To: <CAHk-=wizM+YawbbsvdRnFXLipMXS+iwgD3fahUu4DeyQCKzSWA@mail.gmail.com>
References: <20240229203921.3037023-1-kuba@kernel.org>
	<CAHk-=wizM+YawbbsvdRnFXLipMXS+iwgD3fahUu4DeyQCKzSWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 12:56:21 -0800 Linus Torvalds wrote:
> On Thu, 29 Feb 2024 at 12:39, Jakub Kicinski <kuba@kernel.org> wrote:
> > A few hours late, the commit on top fixes an odd "rcu_dereference()
> > needs to know full type" build issue I can't repro..  
> 
> Ugfh. That change literally makes a single load instruction be a
> function call. Pretty sad, particularly with all the crazy CPU
> mitigations causing that to be even more expensive than it is already.
> 
> I really don't see how that error can happen, it sounds very odd.
> 
> Oh well.

Another mysterious report was:

include/linux/dpll.h:179:1: warning: control reaches end of non-void function [-Wreturn-type]
https://lore.kernel.org/all/202403010245.MXVdcekk-lkp@intel.com/

which I also don't see how since the code as of the commit used was:

   173	static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
   174	{
   175	#if IS_ENABLED(CONFIG_DPLL)
   176		return rcu_dereference_rtnl(dev->dpll_pin);
   177	#else
   178		return NULL;
   179	#endif
   180	}

We'll rejig this in net-next, all the caller does is pass the result
to another function.

