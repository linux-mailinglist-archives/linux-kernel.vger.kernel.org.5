Return-Path: <linux-kernel+bounces-122764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2D88FCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802411C2E87A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5187C0B5;
	Thu, 28 Mar 2024 10:22:16 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3145FBAF;
	Thu, 28 Mar 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621335; cv=none; b=MDxgYe6/oXpwVEJtJoDHO1iRZ801/Hyos5X8kxoDk3l0tTSeuqCYdKbo3SNM12eyC1nzvG9ynttvvBBG5mxh+m3hu+RKJhQ3PiuujXjfHKhZT30gPdcP1BjCUrUmakMPA0ZGpu9VBiUssZppYI6k+waN8KdsZNlHFOrHKakLY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621335; c=relaxed/simple;
	bh=xi+5DcczHvycuxHFqyLiS+KzYxv8gqLhxcO/MAGfco8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBEeFTDyEUW1d23jF1tWkpI12dsTBK7ZZy33dhuPdlpdVDE8OO8/HMP8eiAwfWSJOUk3yD/gsLIcN/60QYoVvR89oEB9/v/owDTPJStpMcFO+z8pfuK463Ws6LcLXN0OrvDFcB/2SfLIx6aJcYX/Eca508aAiP5PxiT09Wcvv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpmYr-00C7A1-No; Thu, 28 Mar 2024 18:00:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:00:58 +0800
Date: Thu, 28 Mar 2024 18:00:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] crypto: algboss: remove NULL check in
 cryptomgr_schedule_probe()
Message-ID: <ZgU/2p5Z3HwEdHz3@gondor.apana.org.au>
References: <20240306072908.5234-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306072908.5234-1-r.smirnov@omp.ru>

On Wed, Mar 06, 2024 at 10:29:08AM +0300, Roman Smirnov wrote:
> The variable i will never be zero, so the check can be removed.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.

Are you sure about this? It does not seem obvious that i cannot
be zero.  If the tool is correct you need to provide the reasoning
for it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

