Return-Path: <linux-kernel+bounces-150896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DC48AA660
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229B128279D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D6EC3;
	Fri, 19 Apr 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1O+aZws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6A387;
	Fri, 19 Apr 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713488044; cv=none; b=FuV2CWwR+UiM/EfjU4KNdwo/fvIfHFZCnlPN/wR2eWXclXf4WjCM2S8jOfS4Yy46p3cCDow+sKYi0yYfOYl1mK8Jg4dmmVmsnDjQ95DFxkIDwUe1XFB+OkvH+tX5Keu9Mp/uUZALlRwrnK4ZBHVD+4Rxh5bq0JwZ5vX43eqcoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713488044; c=relaxed/simple;
	bh=KXn9DkRF+n5q0lG3SNE1OW6pf4niKjkgybjyyn53G9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHKWa3U29keK15A8ScRub1LzOVjHgsbc/+lP6UGVLnG5rMLY+sOdLhzdhlkQO6VqgH4spYkQ2dtT0Bm3QBdB4TYstH4Uto4K2rlHLr1RUc7VP5PiQbR/eGHhuHIYmZzh7WJBdUo18MqJzDpOj7K4Dw13O0atJryBva9Rss+Q8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1O+aZws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB1CC113CC;
	Fri, 19 Apr 2024 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713488043;
	bh=KXn9DkRF+n5q0lG3SNE1OW6pf4niKjkgybjyyn53G9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1O+aZws2MFCGAOh/6nohkFhzyEYZsZODUpdVBZg921ZpomZK/vh94lfR+iAODoHt
	 0kdw8LLpCbuXnFeSfxI8m8ladbtrvMZmtUjdqZSTzsq9UcawqgUAUylEXMhVxCDHSi
	 PjATvUFrg+J1b+Pk5t4HEh17FroA4NbC+NJsUC78nF/5dMXeVFPvnjbx2QakdZwFJC
	 2EU3bQfguQhuDYLt8544J0y0ndOpnsor+FdI9K64AqTr4BuuFGxrJ6UIMBuYOwlvHZ
	 scB5dsRoNU3xFyJE2BqovI/icxs4A04RIwZ39j2X3A2fuojx7IvaZtdxqqgXne1Atq
	 8MbSHomVfM0XA==
Date: Thu, 18 Apr 2024 21:54:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH][RFT] Re: linux-next: build failure after merge of the
 perf tree
Message-ID: <ZiHAqDX0AQfsQbb6@x1>
References: <20240402094116.79751030@canb.auug.org.au>
 <ZhlRn0TUkcDaAZT5@x1>
 <20240413124340.4d48c6d8@canb.auug.org.au>
 <ZiGRQZQGl0REHm9A@x1>
 <20240419091717.50ce0a81@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419091717.50ce0a81@canb.auug.org.au>

On Fri, Apr 19, 2024 at 09:17:17AM +1000, Stephen Rothwell wrote:
> Hi Arnaldo,
> 
> On Thu, 18 Apr 2024 18:31:45 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > 
> > And reproduced the problem, find below a patch that reverts the patch
> > that removes tools/include/uapi/linux/stat.h, with it applied in the
> > sequence above right after the merge of perf-tools-next it seems to
> > work, i.e. it builds without problems.
> > 
> > Can you please test this so that I can get it into perf-tools-next?
> 
> That works for me.  Thanks for this.
> 
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # PowerPC le incermental build
> 
> I will apply that patch to linux-next today (if you don't have time to
> update your tree before I merge it).

I'm finishing some local tests here, will push perf-tools-next after
that, some 30 minutes.

- Arnaldo

