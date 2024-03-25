Return-Path: <linux-kernel+bounces-116769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1788A3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699D61F3BC41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904814A4E0;
	Mon, 25 Mar 2024 10:42:28 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47816F263;
	Mon, 25 Mar 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360065; cv=none; b=jHDwmjN8q5z0a85UFkdhpRysQpUDmMdQ1H+Q3QzUTZbvhK0nP7hwMHlH656R6ILnM9mW2BeasEddFFryyE73SwvxFLvCA5h6tundxhctvoVKHNOmOvONNI8bbRcxcggwFITFbP/5F1hJSjlBxoKsfQb8JNLV88E99JXsyEO3bSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360065; c=relaxed/simple;
	bh=USPymelYD+iIwe8DOvv3myV5AkRbTm81BeyP5oHuoTQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT8i/zkNwa4bI9Hu3MzgMjsqne4B9HrfKgTqBtfC4cnEzVgHLxtR34Wpp8yFTYQYSpWvJUwft9+fXxzu6EtaB9S8lgaqZN8n4L4Zg7xGcmewfgaDBegd7KS3MG38CyQ+XJWpwdlR2MD3G6fFJY3cdJ6TrV6vszMPc98NhG3/UeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rogvO-00AWel-LE; Mon, 25 Mar 2024 17:47:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 25 Mar 2024 17:47:43 +0800
Date: Mon, 25 Mar 2024 17:47:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.9
Message-ID: <ZgFIP3x1w294DIxQ@gondor.apana.org.au>
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

The following changes since commit 6a8dbd71a70620c42d4fa82509204ba18231f28d:

  Revert "crypto: remove CONFIG_CRYPTO_STATS" (2024-03-13 09:49:37 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.9-p2 

for you to fetch changes up to 5a7e89d3315d1be86aff8a8bf849023cda6547f7:

  crypto: iaa - Fix nr_cpus < nr_iaa case (2024-03-22 19:42:20 +0800)

----------------------------------------------------------------
This push fixes a regression that broke iwd as well as a divide by
zero in iaa.
----------------------------------------------------------------

Eric Biggers (1):
      Revert "crypto: pkcs7 - remove sha1 support"

Tom Zanussi (1):
      crypto: iaa - Fix nr_cpus < nr_iaa case

 crypto/asymmetric_keys/mscode_parser.c     |  3 ++
 crypto/asymmetric_keys/pkcs7_parser.c      |  4 ++
 crypto/asymmetric_keys/public_key.c        |  3 +-
 crypto/asymmetric_keys/signature.c         |  2 +-
 crypto/asymmetric_keys/x509_cert_parser.c  |  8 +++
 crypto/testmgr.h                           | 80 ++++++++++++++++++++++++++++++
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 10 ++--
 include/linux/oid_registry.h               |  4 ++
 kernel/module/Kconfig                      |  5 ++
 9 files changed, 114 insertions(+), 5 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

