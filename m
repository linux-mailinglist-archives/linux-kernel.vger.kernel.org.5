Return-Path: <linux-kernel+bounces-155678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020D8AF586
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419A71C225F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60113DDCC;
	Tue, 23 Apr 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="pczxORJP";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="4cAusaIG"
Received: from mailrelay2-1.pub.mailoutpod3-cph3.one.com (mailrelay2-1.pub.mailoutpod3-cph3.one.com [46.30.211.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EE208A9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893403; cv=none; b=Njs6Cgz6x30nuH4dSzorKU6wEhugW4JI72TJMzcx9DKgw1mwVozm27OQ1A6c1pSA6Omxkj957CXg27RylpBEkrFCUNUIaiXJolYrVSD7ezcWrGuKk8ObhkuyE3Ym7CQahcnJiK1IM28KH5A7T1YnywOPEUZZDNbM+jP1dioBFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893403; c=relaxed/simple;
	bh=jYcbBn5vF4ZuER8uSP9pW5+/8SFtzlN0o6xJw/La4qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAaEf3y4w6GMItD3HfJFpdKz1wpO+pXKIgdelWD81whML57SD6klZVlo7UB5QIFHTJbdQCjp2rCkWtvgG9KFqeReIXuYshHXbRzq96GXyutOTmSVE/6BwrK97x7CdnUVGC9Av6pV0jW1nSr45s4KVVAgGlaV2riuLu28971iGcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=pczxORJP; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=4cAusaIG; arc=none smtp.client-ip=46.30.211.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=D6fo61WlQ8//C0LQMF7fv454gBWk7dn2mzLFUwL11UQ=;
	b=pczxORJPfl8Dp5hSrBzN0AZIerJ0ppx6sPhInVAv6nPKV6bm3Cb9/8/QYiXwy+P3hNQuQV1jdCyEE
	 Ggf2YHiulO5CLs39VzqJxG3dyAGltqZKnkfk7B0Tv8gmbISookAM9Q00xk6AuqDI53j86OC2fZ1DPo
	 4T1g2G2bdPI/JlQQYiH19wwwgpTSbHC3qfpx8VyXJ4ieHHfRllVipLQlbbYKOMD1viexlQZAKuZDw/
	 UtH8HVVSf1MuBXBWq5hsx2OC1Yn6SWC6m/jB+ly/pZsbqfEGXLERG/s/wshhn6CayOhPm7s4DXCG0J
	 6BaehF5gfJH2N8cfnsK3x5QR12wtlQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=D6fo61WlQ8//C0LQMF7fv454gBWk7dn2mzLFUwL11UQ=;
	b=4cAusaIGEucs09WFfNLTnx3e9U0vP4okJ0G0mozcOdxskPtW0HZDIr2wjK6lorwoAFP8eYcnrgM/U
	 cbPGBEGCw==
X-HalOne-ID: 11b59e8d-0197-11ef-b128-953526d7c221
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 11b59e8d-0197-11ef-b128-953526d7c221;
	Tue, 23 Apr 2024 17:29:52 +0000 (UTC)
Date: Tue, 23 Apr 2024 19:29:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] sparc/leon: Remove on-stack cpumask var
Message-ID: <20240423172943.GA903763@ravnborg.org>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
 <20240423083043.3735921-7-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423083043.3735921-7-dawei.li@shingroup.cn>

On Tue, Apr 23, 2024 at 04:30:43PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_subset() and cpumask_first_and() to avoid the need for a
> temporary cpumask on the stack.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Looks fine.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

