Return-Path: <linux-kernel+bounces-57463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1181884D960
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD171C24103
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15B2E62B;
	Thu,  8 Feb 2024 04:29:52 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218222E401;
	Thu,  8 Feb 2024 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707366591; cv=none; b=fmtOHQAyks9rfFwIo0DAqNfWWPr95Pdqgcdr55JGWCm68bV4HE1gmhOsp535bGB/mVAAC9L6weuz3Il+/J83Nu4boRpCMFVIKTKfxVbuaAF9WNAlrsy2kJ9CV0tcx8tnHyRQSQu8dFFGu2TvNwjSzBoCBr2dU6ZIZbBZC18OuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707366591; c=relaxed/simple;
	bh=3dIo8cF3X/XtFxkP8MDrSokYqsaEpIXTy44owBJYHIY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3TjBWBstfnS5cgr2+uxhabgbXffuFdAjbAlKXb+NsRYoIJJK+Q/XgKxDAB1CXTQHpLNKsuMuALSArK3n2INerHVRZxuqMpdeaFiK3Mj1T/5rzXdG/rFZ2bCP7pXnnsUjXnMBIrqI4bF7taOABeM1XPpvoM+snPkgdsZTkOKPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rXw2d-00BHTV-FD; Thu, 08 Feb 2024 12:29:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Feb 2024 12:29:53 +0800
Date: Thu, 8 Feb 2024 12:29:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.8
Message-ID: <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
References: <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbstBewmaIfrFocE@gondor.apana.org.au>

Hi Linus:

The following changes since commit c5a2f74db71a849f3a60bc153d684d6d28a0c665:

  crypto: caam - fix asynchronous hash (2024-01-26 16:35:55 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p3 

for you to fetch changes up to 24c890dd712f6345e382256cae8c97abb0406b70:

  crypto: algif_hash - Remove bogus SGL free on zero-length error path (2024-02-02 18:08:12 +0800)

----------------------------------------------------------------
This push fixes regressions in cbc and algif_hash, as well as an
older NULL-pointer dereference in ccp.
----------------------------------------------------------------

Herbert Xu (2):
      crypto: cbc - Ensure statesize is zero
      crypto: algif_hash - Remove bogus SGL free on zero-length error path

Kim Phillips (1):
      crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

 crypto/algif_hash.c          |  5 +++--
 crypto/cbc.c                 |  3 +++
 drivers/crypto/ccp/sev-dev.c | 10 ++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

