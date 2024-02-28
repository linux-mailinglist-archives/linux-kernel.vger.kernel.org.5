Return-Path: <linux-kernel+bounces-84651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8486A984
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23401F24961
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F8286AD;
	Wed, 28 Feb 2024 08:08:04 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CC25601;
	Wed, 28 Feb 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107683; cv=none; b=bf/8MNTiEupwEQaHpDRuNL4yBs6GWdXhNg/FYgSSSpplN4K1FzhSvnG6rPP1VDvxg8no2mCfMHqrugt1nBunmX7cf/5H9944xRSYmEg9ASqT+HXb976yml/vK1laJgegJPKUBtgL/qPbhRUH7H6a5xKNcRvXJW6DE60v+YOt67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107683; c=relaxed/simple;
	bh=gs3X6kzy02az3MYYcXdILjOE/NfEe2sHH8OPDWZSq0U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPuHJbKFWZ5KJtxmr7NN1IEXa8Qo9BfKFaAPaZTMUMhjSHDPX4iO3Bp9RhXpNfefiBNdycUni1NYfp0X0H6JGdrTOEajjOVL4yAMRujJDuMvUDn7WzvCf0ktGp9y0NrW/sA9V/jUV5uzD1pYgthNatN7IO4JEc06gIIvSJcYevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfEye-001ARI-GX; Wed, 28 Feb 2024 16:07:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Feb 2024 16:07:59 +0800
Date: Wed, 28 Feb 2024 16:07:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.8
Message-ID: <Zd7p36CRWPsYhA2G@gondor.apana.org.au>
References: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
 <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
 <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>

Hi Linus:

The following changes since commit c0ec2a712daf133d9996a8a1b7ee2d4996080363:

  crypto: virtio/akcipher - Fix stack overflow on memcpy (2024-02-09 12:55:53 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p5 

for you to fetch changes up to 1c0cf6d19690141002889d72622b90fc01562ce4:

  crypto: arm64/neonbs - fix out-of-bounds access on short input (2024-02-24 08:37:24 +0800)

----------------------------------------------------------------
This push fixes a regression in lskcipher and an out-of-bound
access in arm64/neonbs.
----------------------------------------------------------------

Ard Biesheuvel (1):
      crypto: arm64/neonbs - fix out-of-bounds access on short input

Herbert Xu (1):
      crypto: lskcipher - Copy IV in lskcipher glue code always

 arch/arm64/crypto/aes-neonbs-glue.c | 11 +++++++++++
 crypto/lskcipher.c                  |  6 ++----
 2 files changed, 13 insertions(+), 4 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

