Return-Path: <linux-kernel+bounces-159366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDEA8B2DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8370B22479
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F4156988;
	Thu, 25 Apr 2024 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YEheUZTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B014E2EF;
	Thu, 25 Apr 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088840; cv=none; b=MGZzgu2vqTqlFrhYzXccjgyulEjeFsgdOaeliIcz3P0YKTS68NJG6Wl9UJRCteOoaK3O47JBUJU6fzHhNmefPmOEj/nLpwbzYkPY/LCujQfvwAK4llQ/Km5yv+ftxk1kiH9khGlzMDV2zYvfkMe2kiO6hIhsmCPRO7OD8XPTMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088840; c=relaxed/simple;
	bh=beAuVYStInSqKxnLk3E/kVyZbTYG4nix+yBzCApaJDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ShiRzrx8lgtc0XxH1+VenGSO2w9betFX8hylwGvEltPdghKkZkJR6HsadIoWIZS9DkRZVYrzuR3dmTRxd+QDEifWbRrxVhVRgI3NB+4kOmAGiWM1b0WoCb5/N4V6tj4KSGMbrkcms38mKiywtu5OAHD0kUhSiyHlP2SNHGhgCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YEheUZTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2102FC113CC;
	Thu, 25 Apr 2024 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714088839;
	bh=beAuVYStInSqKxnLk3E/kVyZbTYG4nix+yBzCApaJDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YEheUZThVQmfzJ+cH66dpEmbGfQvhm2WHLxdoorIxuxKL/2z1s5iFoXnh7sMjkCDh
	 vPzE0Ppm0ZZMYyp5msXChAJq9xRrdbLEeS6ODAb0ttQzkvmtk09NiOq8pyzxzs01IF
	 HF9ukneK6b5kQgqee9SDb/kWWL4Y4+C41KBEi1o4=
Date: Thu, 25 Apr 2024 16:47:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-Id: <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
In-Reply-To: <202404251532.F8860056AE@keescook>
References: <20240425200844.work.184-kees@kernel.org>
	<w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
	<ZirCbPR1XwX2WJSX@casper.infradead.org>
	<64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
	<202404251532.F8860056AE@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 15:42:30 -0700 Kees Cook <keescook@chromium.org> wrote:

> > The concern about leaking image layout could be addressed by sorting the
> > output before returning to userspace.
> 
> It's trivial to change permissions from the default 0400 at boot time.
> It can even have groups and ownership changed, etc. This is why we have
> per-mount-namespace /proc instances:
> 
> # chgrp sysmonitor /proc/allocinfo
> # chmod 0440 /proc/allocinfo
> 
> Poof, instant role-based access control. :)

Conversely, the paranoid could set it to 0400 at boot also.

> I'm just trying to make the _default_ safe.

Agree with this.

Semi-seriously, how about we set the permissions to 0000 and force
distributors/users to make a decision.


