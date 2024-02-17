Return-Path: <linux-kernel+bounces-69635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B829858CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA391F226F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA914A98;
	Sat, 17 Feb 2024 01:13:43 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D5149E03;
	Sat, 17 Feb 2024 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132423; cv=none; b=nhzIEh9B22j1ncz8gUoXV0ryys9K1fpQcoXgkTVCQB+IQ3As/jVzlPv/IakNXCkKZoc3YpdMIFqjGO3RSfCzsaX0FDSNYkmffATMIEaRHjC14Cc8fQccPGO3MoypA3n8788pbLvrOCvZJ/9ZRFJymSft1J8sDFptlH/dXE5yI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132423; c=relaxed/simple;
	bh=O8VOZ4lIPXBLRx5kbz0pbVcGVCcgmMbrDf+oxrXEJ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nUqvVJzQQ6qAATH+0zbcRVs2rw9P7UU31R0+VgpXxY6tNHaSFXs9p1Z+RreA83v5Nrd7Z78GVd701qtRY3khbompnGOkg2XI2PwoKlHV0soYc9DugsNqb1yHcfDP/bjPIGOWY82Qh2/Kr133zpGmXxJfTJUe2nlIFYjz4Wt9Yco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rb9Gc-00EeO7-AU; Sat, 17 Feb 2024 09:13:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 17 Feb 2024 09:13:36 +0800
Date: Sat, 17 Feb 2024 09:13:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, john.allen@amd.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - State in dmesg that TSME is enabled
Message-ID: <ZdAIQNasie2Js6mv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205154602.21411-1-bp@alien8.de>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Borislav Petkov <bp@alien8.de> wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> In the case when only TSME is enabled, it is useful to state that fact
> too, so that users are aware that memory encryption is still enabled
> even when the corresponding software variant of memory encryption is not
> enabled.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
> drivers/crypto/ccp/psp-dev.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

