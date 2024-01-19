Return-Path: <linux-kernel+bounces-31584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8A833061
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C604CB23C01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CB58220;
	Fri, 19 Jan 2024 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TNhLAnRj"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB15813B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700329; cv=none; b=RqdKea2kW/x4z/lLOG57j8S8OTH4iLGoBHyS8b2QF9OCaSV/D3r0dtrzBw89XYNv0MiFI3ck+74RsVvFEboIMAiWoNfR4O5qQxi5d5nSuRMZvMTOZ4yEFXd72gtcTWo1c58FZHUqLVpmSI85LgS+YwK1YaEPvfh965GSPUKJhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700329; c=relaxed/simple;
	bh=W3FRUxqFfqkAAE7fKkvKGEQPKlvJdYnKO2tiU1ME70s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M89ZZv1jSg0ZvHfXv7AKpnNd33EdYSBZZfBLTRvdAIRmUo53D5P9rzJBiDKMYKmf/JdBYcGjXRNU+ei6YswEa30TMby1AqVh1KnbeftgKtdyKamvhzMlu90yOmTsrh9KXdb1fXZvS2oIJEDYGUp//Fa+iGsBwcF1giqjnfcacZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TNhLAnRj; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Jan 2024 16:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705700326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAbL9wbnppZtI5fUhZ/5EUcMSGPKwMXW23z8Y2gBPo8=;
	b=TNhLAnRjBJyQWjuKi3f04hZTB+lVms2Ew9yzGr/DgLfGSiuQc0RbfW7q/5ijW4kIL0K6KF
	3NMesZBxd6BvMN6ISR5ocDh9ZLYxkwtPCygrdydaA8DtnmZ29JRU7RTuRjmglAdA2Xe70N
	kuFPjfQNwZ6VYYbp49EAT0W6/UFPpDA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Whitcroft <apw@canonical.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Brian Foster <bfoster@redhat.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
Message-ID: <eesmrnrimijn5w4k634qwdoybdcoo7skik7y2apy6wdkzra2dg@m5zkjfzlmhav>
References: <202401191311.B6AA79D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401191311.B6AA79D@keescook>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 19, 2024 at 01:14:55PM -0800, Kees Cook wrote:
> Hi Linus,
> 
> Please pull this strlcpy removal for v6.8-rc1. As promised, it is the
> "part 2" of the hardening tree, late in -rc1 now that all the other trees
> with strlcpy() removals have landed. One new user appeared (in bcachefs)
> but was a trivial refactor. The kernel is now free of the strlcpy() API!
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit b0d326da462e20285236e11e4cbc32085de9f363:
> 
>   Merge tag 'sched-urgent-2024-01-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-01-18 11:57:33 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/strlcpy-removal-v6.8-rc1
> 
> for you to fetch changes up to d26270061ae66b915138af7cd73ca6f8b85e6b44:
> 
>   string: Remove strlcpy() (2024-01-19 11:59:11 -0800)
> 
> ----------------------------------------------------------------
> strlcpy removal for v6.8-rc1
> 
> - Remove of the final (very recent) user of strlcpy() (in bcachefs).
> 
> - Remove the strlcpy() API. Long live strscpy().

For the bcachefs patch
Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

