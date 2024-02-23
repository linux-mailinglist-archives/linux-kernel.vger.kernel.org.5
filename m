Return-Path: <linux-kernel+bounces-78994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C4C861BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35CF1F29241
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C10143C54;
	Fri, 23 Feb 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JVl01BxN"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485113F010
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713668; cv=none; b=R4b6O8RD+sf28V/bJT2VdSm4uzHinTt8ruTyIFjRQ3bdXWdNMx/j1PZBJteTdQVgh0atluEjByYgshi+QD61Qr5Zqs5N5DJcZqDMauXHvbVEsEjML87YUZ8yHFS8ahWtL9hsRPKySopSsbDnjY9JETV+3FBZotAE+XCLY5x9upE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713668; c=relaxed/simple;
	bh=BKmU1ottIKZg7mi7mY2yCA6PoDkcs/iUSw4v0HQkrS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edaav0JT1A2WeRUpQ6Fmyjkw2G9niQrFDmIKi6Y0owYBkgFYnBkCfNocVDDxka9dfU6uFAfHhDE47po2A9v/T+tOEPlFBpSwFeXH31gydB+jOmju2QZ7870kD1+yZz5SeGV+DwD3EVulHxXcYbTG2PaYrVirDIDFgdj14lIcpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JVl01BxN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Feb 2024 13:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708713660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TtVW+3bSqdUyNHjHnisMJsaNnmBRav1E+zZ0KWEbo8k=;
	b=JVl01BxN5WobZivCOUkRPMMLHVzo7x8aYNQ5FNsgndbGS+8V1ajGL4xF/JGkyBhLNcv+1J
	A5HfAOu0GBXMAxAYhb6QderZu9l4gHgrz+KouVyM8vhplGKqmvbOJdld9YfMqiw4z25mfc
	8MqWXIEpMqAooqsXLIPsEMOaOiWKlJo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rcu@vger.kernel.org
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <jqvbwntesw7rftdw5mibgy37k3lslgn77pul6kbawbvvpt5uck@dpuhhm33vdzy>
References: <20240222203726.1101861-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222203726.1101861-1-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 22, 2024 at 08:37:23PM +0000, Matthew Wilcox (Oracle) wrote:
> Rosebush is a resizing, scalable, cache-aware, RCU optimised hash table.
> I've written a load of documentation about how it works, mostly in
> Documentation/core-api/rosebush.rst but some is dotted through the
> rosebush.c file too.
> 
> You can see this code as a further exploration of the "Linked lists are
> evil" design space.  For the workloads which a hashtable is suited to,
> it has lower overhead than either the maple tree or the rhashtable.
> It cannot support ranges (so is not a replacement for the maple tree),
> but it does have per-bucket locks so is more scalable for write-heavy
> workloads.  I suspect one could reimplement the rhashtable API on top
> of the rosebush, but I am not interested in doing that work myself.
> 
> The per-object overhead is 12 bytes, as opposed to 16 bytes for the
> rhashtable and 32 bytes for the maple tree.  The constant overhead is also
> small, being just 16 bytes for the struct rosebush.  The exact amount
> of memory consumed for a given number of objects is going to depend on
> the distribution of hashes; here are some estimated consumptions for
> power-of-ten entries distributed evenly over a 32-bit hash space in the
> various data structures:
> 
> number	xarray	maple	rhash	rosebush
> 1	3472	272	280	256
> 10	32272	784	424	256
> 100	262kB	3600	1864	2080
> 1000	[1]	34576	17224	16432
> 10k	[1]	343k	168392	131344
> 100k	[1]	3.4M	1731272	2101264

So I think the interesting numbers to see (besides performance numbers)
are going to be the fill factor numbers under real world use.

It's an interesting technique, I've played around with it a bit
(actually using it in bcachefs for the nocow locks hash table), but no
idea if it makes sense as a general purpose thing yet...

you also mentioned that a motivation was API mismatch between rhashtable
and dcache - could you elaborate on that?

