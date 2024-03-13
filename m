Return-Path: <linux-kernel+bounces-101040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F0487A138
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB231F22086
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F5BE66;
	Wed, 13 Mar 2024 02:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsRWOK0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A8BA27;
	Wed, 13 Mar 2024 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295274; cv=none; b=YdvQbDeVY89udMDHkYVWljR7TsqlVn+DycGULj/2ZitxjE4tO3ebwa/YqaW7Lv8toWkTGdHvzK2nRKOGvzsYpM9A7EKx0RXXLb4dnjFp69dQZzXRc1Dels5bRkgkM2dANxQVDr3ZHFvZoTMw84v5uKJVJVDhwf+L+MCskKithr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295274; c=relaxed/simple;
	bh=vTj6c7lYUYxxzCjHXy7wpZDaEnI23La6H27WpOf7WCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3NLrJsiW6xFGs44GIf04OGD5RW7c0BoesgO8OH52U37Dwni9w2EmeQguyL7fP4oHZGx/aAwZG9eFJVRw2eYgY9+noG3xVIq5L5Oy5WiePdxbbVs8bIC3QVdTqyRhMPjhrwENP6OVmhqVlENCLFPXosgKBfpq9gXH1hYhv7z0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsRWOK0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE2C433C7;
	Wed, 13 Mar 2024 02:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710295274;
	bh=vTj6c7lYUYxxzCjHXy7wpZDaEnI23La6H27WpOf7WCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsRWOK0+qLb4R3vnX1x4P3cd063/uYm919hMnV1S0OUyyL10KxlMNinH6Qt2QNodu
	 fejMkhz7bCUIvevjTWNA10XKuIfJEk++Do3mnlnbAWiX6gGwoaI+uPmF9/c6EBPo9T
	 ClyDXIWZtpXL6NZt71tEYRy0+nCVUbrmi7B9oqADqvpl8mLBpxSzM7lQ5TE68dkXWV
	 XreL4NpGGpOrtZLCViC8Pf3+x4v/XAfrNsR45bH/A6xrKfSycY17jaWnt22S53Wd6Z
	 Yr7qq440ZSgnKOzxD6V1HW0/d4DnaSaVyO86uRqgbYBp3RG9LXSN8VjCw21F420doU
	 fAzWcMR+5Zw/w==
Date: Tue, 12 Mar 2024 19:01:12 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20240313020112.GB1148@sol.localdomain>
References: <20240313115751.36b01158@canb.auug.org.au>
 <ZfEE2GDznBOZDXs4@gondor.apana.org.au>
 <ZfEFKxl8/42oXv0i@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfEFKxl8/42oXv0i@gondor.apana.org.au>

Hi Herbert,

On Wed, Mar 13, 2024 at 09:45:15AM +0800, Herbert Xu wrote:
> On Wed, Mar 13, 2024 at 09:43:52AM +0800, Herbert Xu wrote:
> >
> > Instead of using the non-existent crypto_comp_alg_common, it
> > should do something like
> > 
> > 		return crypto_acomp_tfm(tfm)->__crt_alg->cra_flags & ...
> 
> Nevermind, the stats revert should not have removed acomp infrastructure
> like this.
> 
> I'll revert it.
> 
> Thanks,

The only user of comp_alg_common was the crypto stats, and it was introduced by
a refactoring of the crypto stats (commit 0a742389bcc0, "crypto: acomp - Count
error stats differently"), so it seems appropriate to remove it for now.

If you could go through my patch and explain what other unused code related to
the crypto stats you might consider to be "infrastructure" that should not be
removed, that would be helpful.

- Eric

