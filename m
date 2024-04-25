Return-Path: <linux-kernel+bounces-159159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456C8B2A10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0427B21A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845E153809;
	Thu, 25 Apr 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PvQQ5M0Z"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3A14F9EE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077960; cv=none; b=NNSVLZqUchMBfStD4zhPcsszN9LGCX9yXQMXxRZR/5T8IwJQozePJXk9j+6oLGYprfIHqe8831ND47jNdRU/tElzLviz7tMpm3LjxhLGOFllh3ETJadlYmu8eMEbZ21wqtjuK3/8HJMNx00D1JOu8h6xzveOPpSSKjwCkFQh1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077960; c=relaxed/simple;
	bh=hCNQR7qh6mKa3nVisqBeesg40dkL9Xi0s9DR3CFmfjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk+dQINAIxWrqIXVNimDZOtuIzAVx9w8v/42eJeDfzkLDmrf6VbYoqg81Npp1tXtUOee2Fjgh8PjLBZ5w7/rbs2xiwQPT67C1U9FuO/4iNyXC5/sb+vOFAhjgDvuZIB44MUexqh/fhfRvoNLDgiU0jCgYO36ljTSj0Ch0kNr4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PvQQ5M0Z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 16:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714077956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCNQR7qh6mKa3nVisqBeesg40dkL9Xi0s9DR3CFmfjE=;
	b=PvQQ5M0ZSVeu1joht4r0LISgeY+iMhdpXyRwjKxYOyEiUuhklCPcRL8i6+KzTdwuQB0dKW
	z83Qr+oXUiR+dZVTjEccBT+eJixfokS282a5PTxB/Y7He3oNMshdaoJa/6U8fz5ErJp0iW
	KJC5m2zK6++SrrlzeEflctZcCcC3T6c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
References: <20240425200844.work.184-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425200844.work.184-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> The /proc/allocinfo file exposes a tremendous about of information about
> kernel build details, memory allocations (obviously), and potentially
> even image layout (due to ordering). As this is intended to be consumed
> by system owners (like /proc/slabinfo), use the same file permissions as
> there: 0400.

Err...

The side effect of locking down more and more reporting interfaces is
that programs that consume those interfaces now have to run as root.

That's not what we want.

