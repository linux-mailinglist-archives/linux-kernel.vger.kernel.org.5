Return-Path: <linux-kernel+bounces-117943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25F88B19D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3331C32D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B44F613;
	Mon, 25 Mar 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LycSFQbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFC1BF31
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399002; cv=none; b=YxUH42ifNpDO2QIQj0jGMwTcD8DUbFaCMJSdEm8x93I2OKTb8BWvxVduaC9koGgicI0LSqHaCPy7wNO7RvJhjlxEOCSp1NqZz1hBWzxvzqKnySkfb21glZtxj7a+oWUCpqnQ0icg4oMibi54M9zfGNHalV+1x2HgDfMB4v/sPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399002; c=relaxed/simple;
	bh=zwnHarK4iNlKkwfSVU5bMx2ampTrKvZZIDTT3lx10Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlSOSzl9th3PXWh6ZDeotfF8mTA9uKSQyF+SPSsRZ1GC3q8zayb+HFMeiUv/75Tp1477bLN4n9Lhkr2OSR8NX/+ujlWZ9GIZoj8UTq46feddlcuvq71EkEj4VZykOBAPAXhYzzpYun7FLuGLjVduclTLzid6HlUTHCJxxU16Xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LycSFQbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FBDC433F1;
	Mon, 25 Mar 2024 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399002;
	bh=zwnHarK4iNlKkwfSVU5bMx2ampTrKvZZIDTT3lx10Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LycSFQbRwWwz9SXHDl2D5AfWbdBNV/bj9h8Cx/oDdH4CCVDmUg/u8kP63/SXn5zo+
	 guLH8kvrH3CDyYLo7zTQkvD5T8IFDBtjjkUKAqEFQYycOGI/wHSGjUVIIDB24O8k54
	 9Asqxh+38LbelpsZdqYhrzdbL+W7D7p/TCyh6HgxYCnvZxuBYMcbvNj8UrbBf2+ZDH
	 VNJO4CfFMPNEs3bpAcee2Zvg+sMMwDl20UlSxDPXfpjY98PqDqR+o1I4VG1slt/TGj
	 cl4qBJUBHi1l0dYEOSyGyfp/ojNGokWXABPxcqi1B+xr7gHqFtQqhuPyKonu5gVDC+
	 PwlLb2NCCfUCA==
Date: Mon, 25 Mar 2024 21:36:39 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>
Subject: Re: [patch 1/1] MAINTAINERS: Add co-maintainers for time[rs]
Message-ID: <ZgHgVz65GUZlpbp3@pavilion.home>
References: <20240325172048.548199937@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325172048.548199937@linutronix.de>

Le Mon, Mar 25, 2024 at 06:23:17PM +0100, Thomas Gleixner a écrit :
> Anna-Maria and Frederic are working in this area for years. Volunteer them
> into co-maintainer roles.
> 
> While at it bring the file lists up to date.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> ---
>  MAINTAINERS |   35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9653,7 +9653,9 @@ L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	drivers/hid/hid-logitech-hidpp.c
>  
> -HIGH-RESOLUTION TIMERS, CLOCKEVENTS
> +HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
> +M:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> +M:	Frederic Weisbecker <frederic@kernel.org>

As someone who has to set up 5 distincts timers to guarantee I'll eventually
wake up in the morning, I consider that is quite an achievement!

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

