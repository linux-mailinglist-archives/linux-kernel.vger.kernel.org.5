Return-Path: <linux-kernel+bounces-93663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F9873305
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC34D1C25EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58CA5F841;
	Wed,  6 Mar 2024 09:47:44 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369A5F467;
	Wed,  6 Mar 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718464; cv=none; b=J2w7ZAw+hfdoeUurUxAjTxJplCPvY8yJvxgR5N56vNRHXlSLOnGkcayyROpM7rhqptPUyDv6vL+CyyLc/kTriOzP3E+EFgzU+V/Cj3IKEv1cBe2XBymNfGRD2XVTFhk70n6Gp8tvirbDZSS/A7Jg+W4guVvxmBEG/kvN4ewurLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718464; c=relaxed/simple;
	bh=l6hUZC8Id6TcIs72184GnXjWFsML70AR2ab+dSEGB4w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkx5KLo42NGw/1ozsT1GidRNv7y1bTrKL7BU8Oizl/jGkoqcyqVGH05pcOC8uMrTd1i6KvGddaX2ajrwfpne15gf0QdSXn1vWQIbmEEO4SdqjX5CnscDuWfKMzbte7stMnhfui247Qlo/BSGwIm05lX45U7W6nyIgu+FJ6sMn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rhnrw-003ysg-LN; Wed, 06 Mar 2024 17:47:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Mar 2024 17:47:40 +0800
Date: Wed, 6 Mar 2024 17:47:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.8
Message-ID: <Zeg7vD6GeVHAxYWf@gondor.apana.org.au>
References: <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au>
 <ZbstBewmaIfrFocE@gondor.apana.org.au>
 <ZcRYwZHASH4Cv5Bn@gondor.apana.org.au>
 <ZdW+GCkO4s3MSeLX@gondor.apana.org.au>
 <Zd7p36CRWPsYhA2G@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd7p36CRWPsYhA2G@gondor.apana.org.au>

Hi Linus:

The following changes since commit 1c0cf6d19690141002889d72622b90fc01562ce4:

  crypto: arm64/neonbs - fix out-of-bounds access on short input (2024-02-24 08:37:24 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.8-p6 

for you to fetch changes up to c0afb6b88fbbc177fa322a835f874be217bffe45:

  crypto: rk3288 - Fix use after free in unprepare (2024-03-01 18:33:29 +0800)

----------------------------------------------------------------
This push fixes potential use-after-frees in rk3288 and sun8i-ce.
----------------------------------------------------------------

Andrey Skvortsov (1):
      crypto: sun8i-ce - Fix use after free in unprepare

Herbert Xu (1):
      crypto: rk3288 - Fix use after free in unprepare

 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    | 34 +++++++++++-----------
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |  4 +--
 2 files changed, 19 insertions(+), 19 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

