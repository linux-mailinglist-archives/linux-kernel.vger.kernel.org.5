Return-Path: <linux-kernel+bounces-104542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A887CF79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C19DB21099
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246F3BBCD;
	Fri, 15 Mar 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqc0CG/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64E38FAA;
	Fri, 15 Mar 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514420; cv=none; b=sggKpqe+yhdhUr15juSTGNoo+qxH/9mOcvVFjXIqCqAWehaTAbxDO//zJ0MHTuIB7PObCmxzeeHycQclQKNEooGUvCeKesOxFVUALTMl8ikpZMnzSUYEcXeLrfwI16XRgRoWCT9c3ALZNOQGzR+29BwVkCWMIvfbVRYD/vEiCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514420; c=relaxed/simple;
	bh=V9WzBgP3erFUdwEieXh7ebjyPyGGQmShINDMG/+D6hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii1+7bC8InV1wXeiuzO4CwUZpTJ9mYhn/SrV9jD49j+KjdNEg2g8DpAGbmh+eWK7j9cUAMLbeRRbLF6f+kmyl0P/m+EwgMARNH+f2FLF9zq78kac3Y40ROmT/ZCO50HM5e2RA47UjgyJJDoDHAkKSSBihkvovY9Mkcgl2Tow1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqc0CG/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9A9C433C7;
	Fri, 15 Mar 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710514419;
	bh=V9WzBgP3erFUdwEieXh7ebjyPyGGQmShINDMG/+D6hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqc0CG/ru+sor/YHbT+Y1Xrj7wwXG1LweE8vYPxrC8QHfyF04Z0PSrdwKTHmnLet9
	 mB3hfN0+JKNXRhHgwj+RJi9gQXeP1W86pL+ijjNBE26UaXoViseiAqmwEXT/QqzcDH
	 nQ5ePDqrTfrJ5nRY5wAg0c0jPlA1RNer+pCH7iNJ3JJtFzNCk98LOYkU0aCpHZh+Jo
	 ERBSQtErB2+4Kv/Famudgf6fj4bMJCLLmOf0lm3YCrCfi5dCzVPrNw4/Xtcn7KPwFO
	 EHXbZyyOhrBf31AjNwlcYTIWvK0u8H6grOmJ5+rwzjPHEj9rvABs/qfxOkygqnYywG
	 8pyFOEMosdbkg==
Date: Fri, 15 Mar 2024 11:53:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	John Kacur <jkacur@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] tools/tracing: Use tools/build makefiles on
 latency-collector
Message-ID: <ZfRg8CB5xXL2Y-zC@x1>
References: <cover.1710512430.git.bristot@kernel.org>
 <f2851351a1561a59a273a64de561022b1af4edcf.1710512430.git.bristot@kernel.org>
 <32958f50-b713-40ba-9e12-2a1b5667a91f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32958f50-b713-40ba-9e12-2a1b5667a91f@kernel.org>

On Fri, Mar 15, 2024 at 03:48:58PM +0100, Daniel Bristot de Oliveira wrote:
> On 3/15/24 15:24, Daniel Bristot de Oliveira wrote:
> > Use tools/build/ makefiles to build latency-collector, inheriting
> > the benefits of it. For example: Before this patch, a missing
> > tracefs/traceevents headers will result in fail like this:
> > 
> > -------------------------------- %< -------------------------------
> 
> Oops, b4 is interpreting these ------ as the '---' separator, and is truncating
> the message. I will fix this in a v3.
> 
> sorry.

Yeah, that confuses scripts, that separator.

But overall I tested various versions of your patches and they look ok.

That tools/build/ was done for other tools to use and so far some tools/
living projects use it: tools/objtool, tools/lib/subcmd, etc.

I just did a:

git grep tools\/build

And there is quite a few more I didn't realize have been using bits and
pieces, good.

- Arnaldo

