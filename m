Return-Path: <linux-kernel+bounces-166222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60978B97B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F7E1F27828
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0CF54646;
	Thu,  2 May 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/SX6nDL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB758502A6;
	Thu,  2 May 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642188; cv=none; b=uaa2VxyRaCRptnH0mJDgAPbWFmnj1+fJaJDpXEWSZTCMxuO1YgkeO+dxJDedAdmPBwnBKJU1h3wSaJ5UnqXnIN199neh3TyTkACKpmEttxHC26PtvNi2GNfcFxVOHM7mP5EmEjZ2r3oLF9lmbEtR0jTm/+5GyQrcYwl9DRyTVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642188; c=relaxed/simple;
	bh=4Hil5EAIT5/19YXqsZDsZAFQn41q6nuNWidh53aNE1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dte0vrufo5OSpk8cUyoBfr+D6pa8CHJZkjKYeIpLCWpkX1iQNuuRLqTH/P/TnJcOLG9lYg6UP+7OR0/ZVrT6rWlTQ9ugmzXu2N5ExMDUdEjDpf6ZHmBkiKrMJ2lznsWBCMja53NpOPl/qJHYBpUmeQTL9rvIq/tsPkRgWORdKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/SX6nDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63382C113CC;
	Thu,  2 May 2024 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642188;
	bh=4Hil5EAIT5/19YXqsZDsZAFQn41q6nuNWidh53aNE1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/SX6nDLDa52IKjwMAi8XCeazf9a6EkX+Tf8ws0UEst5W31SA89sKUEgsfum8rX6W
	 6FehZVN4dsk6nDPKNdj9eGeTBZdzgIR6jWq31F32+wE0jOX4ziWt3rrNNguU0r5GOT
	 yd4GdNqGTqfiOQDcDeFyhKYejcFHf8ynD/RQLCMfeKajgz+2fHJvUBjCdGCyo3u8po
	 8NLKehDtpItSPCjtlacchch6IjGflTirycIOmlgnozHxo8aZx4fFj+fTcUQ8Jc5I0G
	 RMDyIz3KNOEJHLVM+JdnlM4g1GNfcEjIo5liJc0NB6mcp9zIOEzkjxtejGv74NUTRa
	 y+WrEy5TY7TzA==
Date: Thu, 2 May 2024 10:29:43 +0100
From: Lee Jones <lee@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v6] checkpatch: add check for snprintf to scnprintf
Message-ID: <20240502092943.GG5338@google.com>
References: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
 <202404291249.078D924@keescook>
 <aacd7c3a5ad5bb4df71ec5dd107ef12b6ebf4079.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aacd7c3a5ad5bb4df71ec5dd107ef12b6ebf4079.camel@perches.com>

On Mon, 29 Apr 2024, Joe Perches wrote:

> On Mon, 2024-04-29 at 12:49 -0700, Kees Cook wrote:
> > On Mon, Apr 29, 2024 at 06:39:28PM +0000, Justin Stitt wrote:
> > > I am going to quote Lee Jones who has been doing some snprintf ->
> > > scnprintf refactorings:
> > > 
> > > "There is a general misunderstanding amongst engineers that
> > > {v}snprintf() returns the length of the data *actually* encoded into the
> > > destination array.  However, as per the C99 standard {v}snprintf()
> > > really returns the length of the data that *would have been* written if
> > > there were enough space for it.  This misunderstanding has led to
> > > buffer-overruns in the past.  It's generally considered safer to use the
> > > {v}scnprintf() variants in their place (or even sprintf() in simple
> > > cases).  So let's do that."
> > > 
> > > To help prevent new instances of snprintf() from popping up, let's add a
> > > check to checkpatch.pl.
> > > 
> > > Suggested-by: Finn Thain <fthain@linux-m68k.org>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > Thanks!
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> $ git grep -P '\b((v|)snprintf)\s*\(' | wc -l
> 7745
> $ git grep -P '(?:return\s+|=\s*)\b((v|)snprintf)\s*\(' | wc -l
> 1626
> 
> Given there are ~5000 uses of these that don't care
> whether or not it's snprintf or scnprintf, I think this
> is not great.
> 
> I'd much rather make sure the return value of the call
> is used before suggesting an alternative.
> 
> $ git grep  -P '\b((v|)snprintf)\s*\(.*PAGE_SIZE' | wc -l
> 515
> 
> And about 1/3 of these snprintf calls are for sysfs style
> output that ideally would be converted to sysfs_emit or
> sysfs_emit_at instead.

I am working on the migration of these (this patch was spun off from
that project in fact).  Some subsystems are currently prioritising the
status quo (a.k.a. "no churn"), but most have been accepting of the
changes.

Planning to get back to it once the CVE project has calmed a little.

Those numbers should diminish over time.

-- 
Lee Jones [李琼斯]

