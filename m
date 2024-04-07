Return-Path: <linux-kernel+bounces-134584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC73C89B33E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA561C20E58
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A523BB22;
	Sun,  7 Apr 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c9DHkc8d"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EE374F2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510343; cv=none; b=PqmU3DRk8fcXwxGFRhJGsibrIY4VLfAd2e8dbxp1NjAnIwEwcQVT8nwKYx8jhO/RltMqsENm/8DyEQTq2I8FWvan9G9iD7rAjpHlAGzptTaalzC0NLUBkmCRZhUtwTVMqlktR7W1CtwgXtA2YG1Z1a0i9jxZbeGeWDAyY9qpBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510343; c=relaxed/simple;
	bh=Qrb1ZoVYtz8rZAZsModSkPmvO6pL2nxjjCIkC+M12Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk5JCTwhZwkDHZ4WQhc+wVT/EB1gw/S5RAVFCTJCSdVGWmdC+xEPxRSBmi+BSz+3PsQoSoq7MgUH8DKEPPEcpJsvXBFJog2JehFUADKud1nk1ZKjStHR+FQ5OFmlt9LeEh9LMI5+bR3E8DLLHwg1j7S2FY46DMhiFdOMSUMvRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c9DHkc8d; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 7 Apr 2024 13:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712510338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=av8DcUEUfW87NIOByp6zq/H9IyJ+V+DhnYtX85sC2lY=;
	b=c9DHkc8dpZ0wR6BARFRpnU4Zsc9h1rf3ogpwYyvzBXQS/aLbEL9OOkCqxLf6+CFKg9Olmo
	kmmQOo/CMJBSMBDXs+45PxGQ5IkBBiioOo8tql9ihaVZuJjxlT8OswLWdU4qYtUIWapein
	ZO8UmQ9/huhgdB2AN4xNCiCGANiFesA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Klara Modin <klarasmodin@gmail.com>
Cc: akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memprofiling: explicitly include irqflags.h in
 alloc_tag.h
Message-ID: <ybgabsfgwk5ejqhfuaxifwvi75xzcxtdyuhdvzqk4kqbjppaq3@sgtnjjrx42m5>
References: <20240407133252.173636-1-klarasmodin@gmail.com>
 <w2leytfo6pdsslutpp6p3ziq2fxdu7azammphh24cp6bka2xta@ijosdg33pozv>
 <55c71868-e2ae-4095-a5ca-5cdb195d508b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c71868-e2ae-4095-a5ca-5cdb195d508b@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 07, 2024 at 07:12:04PM +0200, Klara Modin wrote:
> 
> 
> On 2024-04-07 19:01, Kent Overstreet wrote:
> > On Sun, Apr 07, 2024 at 03:32:52PM +0200, Klara Modin wrote:
> > > linux/alloc_tag.h uses the macro this_cpu_inc which eventually expands to:
> > > 
> > >   #define this_cpu_generic_to_op(pcp, val, op)				\
> > >   do {									\
> > >   	unsigned long __flags;						\
> > >   	raw_local_irq_save(__flags);					\
> > >   	raw_cpu_generic_to_op(pcp, val, op);				\
> > >   	raw_local_irq_restore(__flags);					\
> > >   } while (0)
> > > 
> > > The macros raw_local_irq_save and raw_local_irq_restore are defined in
> > > linux/irqflags.h which is not included implicitly on all configs.
> > > Therefore, include it explicitly.
> > > 
> > > Fixes: ac906a377c67 ("lib: add allocation tagging support for memory allocation profiling")
> > > Link: https://lore.kernel.org/lkml/6b8149f3-80e6-413c-abcb-1925ecda9d8c@gmail.com/
> > > Signed-off-by: Klara Modin <klarasmodin@gmail.com>
> > > ---
> > >   include/linux/alloc_tag.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > > index e867461585ff..afc9e259a2d3 100644
> > > --- a/include/linux/alloc_tag.h
> > > +++ b/include/linux/alloc_tag.h
> > > @@ -12,6 +12,7 @@
> > >   #include <asm/percpu.h>
> > >   #include <linux/cpumask.h>
> > >   #include <linux/static_key.h>
> > > +#include <linux/irqflags.h>
> > 
> > Actually, shouldn't this end up in a percpu header? Or was there a
> > problem with that?
> 
> If I understand it correctly, linux/alloc_tag.h does not include
> linux/percpu.h (which has that include) to avoid a circular dependency as
> linux/percpu.h includes linux/alloc_tag.h. It instead includes arch-specific
> asm/percpu.h, and as a consequence it doesn't always get linux/irqflags.h.
> 
> It's also entirely possible that I've mixed something up, I really don't
> have much experience developing for the kernel.

Gotcha

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

