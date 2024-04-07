Return-Path: <linux-kernel+bounces-134578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD289B331
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB91C21A65
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05513B2A6;
	Sun,  7 Apr 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a735W5ZP"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031037703
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712509305; cv=none; b=oh2y6F7Uw5rLQC93ppYEu5Kn0OP326Pm075VFmXRLxNMOLeNcfAEdG3jEBMVWj5P+d3Z3RovJZ2iwlBhPcVS204uhgnoYcwUnd44LNfd1aw2TC2Kk+WCz0WXrTyZINQ6YS1MM1h19bdKdK4WKZd1rswW1H2CNyhuGYHb+FxMmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712509305; c=relaxed/simple;
	bh=rfQaFF9DIqQBatKH10wdndcFZRp12yRilsPlzOmw6Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqi+rQF0RomnhrafC8MRUBJ1PrNahnRd8X0cBVRRYFpY0hS66eP42B4nswTjQwMVBKZJzUU6nw1JUBv4mdBFY9u6JUuMhDHc4KsN2YkqWwIj4zqMQS4Z0b4aC/yEVnukVnExvI1zA9LYqAPp2DPwmjoQFaqDMzUXSCEZBfwh+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a735W5ZP; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 7 Apr 2024 13:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712509300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDrRDB/UkXeAYx9XmDkaIFHSFf8yLRfaEqiA1CEB3hs=;
	b=a735W5ZPKTAymghHVTT3RcykxqihE1oC4s8VX1VkaeZJyOC42aMaATXM3RC0h6NbQ0YoMQ
	FEDdL1ZpSOSnS8FsbH0ZhOMdEFBWZw3TjV+qUXAmlkDvMrR4hHcitgRdLu43lP5PXA+h+n
	PCtQaNOljcqWCj/zuGpPe+/rViVq8lg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memprofiling: explicitly include irqflags.h in
 alloc_tag.h
Message-ID: <w2leytfo6pdsslutpp6p3ziq2fxdu7azammphh24cp6bka2xta@ijosdg33pozv>
References: <20240407133252.173636-1-klarasmodin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407133252.173636-1-klarasmodin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 07, 2024 at 03:32:52PM +0200, Klara Modin wrote:
> linux/alloc_tag.h uses the macro this_cpu_inc which eventually expands to:
> 
>  #define this_cpu_generic_to_op(pcp, val, op)				\
>  do {									\
>  	unsigned long __flags;						\
>  	raw_local_irq_save(__flags);					\
>  	raw_cpu_generic_to_op(pcp, val, op);				\
>  	raw_local_irq_restore(__flags);					\
>  } while (0)
> 
> The macros raw_local_irq_save and raw_local_irq_restore are defined in
> linux/irqflags.h which is not included implicitly on all configs.
> Therefore, include it explicitly.
> 
> Fixes: ac906a377c67 ("lib: add allocation tagging support for memory allocation profiling")
> Link: https://lore.kernel.org/lkml/6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com/
> Signed-off-by: Klara Modin <klarasmodin@gmail.com>
> ---
>  include/linux/alloc_tag.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index e867461585ff..afc9e259a2d3 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -12,6 +12,7 @@
>  #include <asm/percpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/static_key.h>
> +#include <linux/irqflags.h>

Actually, shouldn't this end up in a percpu header? Or was there a
problem with that?

