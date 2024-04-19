Return-Path: <linux-kernel+bounces-151009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3978AA7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184FA1C22429
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E02BE65;
	Fri, 19 Apr 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="kGLIj4zl";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="XKuHJR3l"
Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C81BA2B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713503705; cv=none; b=CRBCnoPusurV1HYNJaOlIs1xy8wWx7HlWa0f6kFfM/ptN65IOK6Ts1gC365pkSMz6sh2SnhaUbaGIMRSSh/OtLOvL5zwpt1En6s2Ho6Q0FJoZMvKreNjyPEZVlbSLPIlizjsC9y9Uzkt2h8UYeGgQrM5rM6Mo7+66vnGLFUt0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713503705; c=relaxed/simple;
	bh=uN8JfYQ/aBEsywlESJUlU0Btqt0nXX9MQQidv/c8OSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLav5zW1tCOE5yKYGlUmONaq1FDCQW+VU9RTGcO73PyymzxgvxInoKwkLfromymz9qSiCasVwteqOQW2WA32MF/aLQLJadwXixszlk27WmTOW6WsL+MYNtfXwHY4d5l/trMb5xt5d0cBaV27yx5UZjI5tleSTyFlJojifMnfoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=kGLIj4zl; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=XKuHJR3l; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=u/go6+i7e7RyNSuoXpPTIqP0/jBntZGsQA2HrLzeU90=;
	b=kGLIj4zl3nZh5NPG9HxXvsvmBgJ04w7Rum2A5Mt39cNRvmWQbP/1QE/wnztuQ/QQ2pUtg5yeAEvMt
	 kV3ADRncWjmrKbDjAPN/ihny18P9q8Xs1PYV7jiT9/TgZ0akaBWlNkSVjyTslHs2cqBHbZw35W4LTA
	 rb6sMFQvNcI+rnQl0LpautsKNovRDA7s+vq5LAIVSqV9cSsWNk3xu+6Ur2h3PjqY9EHOD3rjljrAju
	 UDNlPDsXzk/2iZcxpelBSy7Par8t4wldrx3P+gi9Ff0ePcMmub+y10rpyarIJonmbEGK6gPxpylq8K
	 9cuK9Du48/w3u9b80zfCYTvTiUFguMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=u/go6+i7e7RyNSuoXpPTIqP0/jBntZGsQA2HrLzeU90=;
	b=XKuHJR3lOYplrKFaJTtPySHfacKIGmSnuGzDgCnksG7MIX6+YIEVxQ5oZacqLgM2I9FUmdnkMwzxR
	 Mzmm3KvAg==
X-HalOne-ID: 9b761f07-fe0b-11ee-b787-bf3d7f4c9d3b
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 9b761f07-fe0b-11ee-b787-bf3d7f4c9d3b;
	Fri, 19 Apr 2024 05:13:52 +0000 (UTC)
Date: Fri, 19 Apr 2024 07:13:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove onstack cpumask var usage
Message-ID: <20240419051350.GA558245@ravnborg.org>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418104949.3606645-1-dawei.li@shingroup.cn>

Hi Dawei,

On Thu, Apr 18, 2024 at 06:49:44PM +0800, Dawei Li wrote:
> Hi,
> 
> This series aims at removing on-stack cpumask var usage for sparc arch.
> 
> Generally it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.

Took a quick look at the patches, looks good except the one the bot
already complained about.
A quick grep shows a few more cases where we have an on-stack cpumask
in sparc code.

kernel/ds.c:    cpumask_t mask;
kernel/leon_kernel.c:   cpumask_t mask;
kernel/leon_smp.c:static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
kernel/sun4d_smp.c:static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,

Do you plan to look at the other on-stack users too?
It would be nice to see them all gone in one patch-set.

	Sam

