Return-Path: <linux-kernel+bounces-62832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B628526AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40531C24F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C91612CF;
	Tue, 13 Feb 2024 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4hVa7CJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF624B23;
	Tue, 13 Feb 2024 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786174; cv=none; b=QVUyapG7sSV7DGBGa4rwszvBBRHHTnKUbCKCcS7tCmuU4ktvC5OcgQYGYrhbmt9tVHTDqBAYV7aZssGz7OkRy+P8+c6CCAVvJUmJ66PmlYe7I1ddANC7UXMToergzlHIpm7qy+XRKR3po4JYIKLekzR1fvKmabQnOoDUJOPSarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786174; c=relaxed/simple;
	bh=iDPXLQ+QAA4sNBOgwos8SKpEyCmdUavp1j7CpWHBJAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=da0u/rYRvvkFzJzaY3u7c79sOnczXMKvjYMt5kfFkw6OdnOluGT6jnH+zcoS6GRGvEDkPrqvvAIDMBlnOQccQhT95Q1A+z3Lu50zCaKK6SnZDOZR9gTeoJBrbvutmFcOdgejtixn/Sa2NIaeKXq/KBxiOV1a6Pdv6dh6wG2pVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4hVa7CJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FBEC433C7;
	Tue, 13 Feb 2024 01:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786174;
	bh=iDPXLQ+QAA4sNBOgwos8SKpEyCmdUavp1j7CpWHBJAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c4hVa7CJ+LbCRONT+XU52v7lq5ZiUUVnU0/tjEu9078af4as2HXZp4YgtQAqOcmn/
	 bYu833ywt2XR8TxQD18OBOKGDFwm6F8xfRaMoR2T1ZB7ll53ELmWhSNVCCXGsn2xLN
	 46johqmQaNNFls/GrfG37aY/3OLukS661jTumVBhgtl2tP1o7sjXlRtCRsc7Vyh4wT
	 wCV7DB4I8MIkvsVgXSIr07IdVTUjKnpLeXTT3tZC7JdGt5qcTVmUi7LYfL3g0tKj/z
	 vCf/fym09Q2pYoVArrsXpfYgM+BPiP6rUtrze/y8kKUAZoKCJEZm+J281iGdA6OYg4
	 Qnm0F1Vcma2zA==
Date: Mon, 12 Feb 2024 17:02:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Qian Cai
 <quic_qiancai@quicinc.com>, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] configs/debug: add NET debug config
Message-ID: <20240212170253.77a7be7c@kernel.org>
In-Reply-To: <202402121039.E14DF37@keescook>
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
	<202402121039.E14DF37@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 10:39:55 -0800 Kees Cook wrote:
> > Notes:
> >   - It looks like this debug.config doesn't have a specific maintainer.
> >     If this patch is not rejected, I don't know if this modification can
> >     go through the net tree, or if it should be handled by Andrew.
> >     Probably the latter? I didn't add [net-next] in the subject for this
> >     reason.  
> 
> Adding these seem reasonable. I touched debug.config last, so I can take
> it via the kernel hardening tree if netdev doesn't want to take it.

I'd prefer to have it in net-next sooner rather than later, because
when our CI hits an issue we can tell people:

	make defconfig debug.config
	make

otherwise I have to explain what options to twiddle with. And the
refcount options do catch bugs, I had to do this exact the explaining
last Friday :(

So I'd offer these three options:
 - we put it on a shared branch and both pull in
 - you send to Linus within a week and we'll get it soon that way
 - we take it to net-next directly

What's your preference?

