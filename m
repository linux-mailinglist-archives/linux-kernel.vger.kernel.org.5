Return-Path: <linux-kernel+bounces-63483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F36853038
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47165B216CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A563A1B5;
	Tue, 13 Feb 2024 12:10:00 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22273381A1;
	Tue, 13 Feb 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826199; cv=none; b=hzH9km2RaNubVZzx1ipIzfwq1jzunwX9NByEMjLxPcw0JYx8+QMhh0EBZ4z0qzdMbHmc9c27Kmyh+ce80vTGrGWA4E2PaebKm9jDdJQGewG70o7PGWkstMzMQ5+PcG0sIzxLz63LOrmxzvB79BP6f1AnE6FaL4tuvB9HJLi4D4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826199; c=relaxed/simple;
	bh=jr2SEJXEOSmwwhBftH53FDJ6TKA4m9HF9I1JXKIasTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROm3Wq9YItgKcRgCyjYmuVALI//SmxFuRwbWR4a/vSaaqZTzOb1+PezPB/1tRjT45kDOHNhDmIt1HRE0HCZZ0mHb2nU3OAB39S4S8KK2sFDkarkpsJIsefMDigeP7y6cl6UN6d4CxXlUCaWYrofyQzQubzhUuRMrlRtoQgMs4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rZrb1-00D6ST-OQ; Tue, 13 Feb 2024 20:09:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 Feb 2024 20:09:21 +0800
Date: Tue, 13 Feb 2024 20:09:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jussi Kivilinna <jussi.kivilinna@iki.fi>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ARM: crypto: fix function cast warnings
Message-ID: <Zctb8QOtMuIfMvDT@gondor.apana.org.au>
References: <20240213101356.460376-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213101356.460376-1-arnd@kernel.org>

On Tue, Feb 13, 2024 at 11:13:44AM +0100, Arnd Bergmann wrote:
>
> Rework the sha256/sha512 code to instead go through a trivial helper
> function to preserve the calling conventions.

Why not just change the assembly function prototype?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

