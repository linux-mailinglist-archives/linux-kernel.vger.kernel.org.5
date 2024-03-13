Return-Path: <linux-kernel+bounces-101050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DF87A19F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251A62838DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EFEC144;
	Wed, 13 Mar 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5jVH3Wi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3976FCB;
	Wed, 13 Mar 2024 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296955; cv=none; b=n/yw2HA3yqScjiqGBH7xYRYNClMjb/NKIdIG8C9uOqbKtH2b1L91LoIzJyRNVn07RqrajFdVVtkp/mkS+38BHLCmmozGmLyompHGOqdSTq1rWWYNlbAaA6EKgWPTRyihS3+c+W+HH58R+ikm2Pb2Si7Uab0LLG9YBAzpus+fCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296955; c=relaxed/simple;
	bh=4rGwAcnJt85Pg1C0n0uYVRoLE6oWycRlJ1Rp3ygQ5Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8WEtGdIJMylwJ4+milh6ETvffHIiyDkvw5gM7wDkp7YvFzwKnsSwJpMl2D5BABzj/rNIWSCk7nIqaiw1PJ9/sevy/4NdT+rfIPt7nUeRWsUDiJKdHlfXS1L9UpBrQ1NNNwA4T48lyGJmnqSQx4YBBGUmYKrYEsnmYc7ye0aaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5jVH3Wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D897C433F1;
	Wed, 13 Mar 2024 02:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710296954;
	bh=4rGwAcnJt85Pg1C0n0uYVRoLE6oWycRlJ1Rp3ygQ5Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5jVH3WiDcJCklPgdkYPN1JtWt3j0xGIXX4EQPw5qldiPwkKuL3ocpct5ZdVoOP5T
	 5RmNtnnCNmaQlUuDOFK84Qc/y6Rf768wMjAEvfYjYS/EZ5xm+w08lSNgJycoU68uPu
	 MGdI3DpvVOKp6UkSPg0YQi1Htu7eN82YRK4yQCImWzJECE4dsz1O8l8ial3IPV/5Op
	 g/A2AKYd6Fj+zkVh2M6wWoVlpQNvj2o46P2ehVyYHIt6co9R+7Ndq38gj0nbRv/P+2
	 EYP5vsBltW5Dybs4Rc8VsC54uyqXWred/IukXaGiwollcYKrg1MGcJrAYE/djLbVtC
	 H8DpQqS//1myA==
Date: Tue, 12 Mar 2024 19:29:12 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20240313022912.GD1148@sol.localdomain>
References: <20240313115751.36b01158@canb.auug.org.au>
 <ZfEE2GDznBOZDXs4@gondor.apana.org.au>
 <ZfEFKxl8/42oXv0i@gondor.apana.org.au>
 <20240313020112.GB1148@sol.localdomain>
 <ZfEJrBefjrvPxaIg@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfEJrBefjrvPxaIg@gondor.apana.org.au>

On Wed, Mar 13, 2024 at 10:04:28AM +0800, Herbert Xu wrote:
> On Tue, Mar 12, 2024 at 07:01:12PM -0700, Eric Biggers wrote:
> >
> > The only user of comp_alg_common was the crypto stats, and it was introduced by
> > a refactoring of the crypto stats (commit 0a742389bcc0, "crypto: acomp - Count
> > error stats differently"), so it seems appropriate to remove it for now.
> > 
> > If you could go through my patch and explain what other unused code related to
> > the crypto stats you might consider to be "infrastructure" that should not be
> > removed, that would be helpful.
> 
> The first patch should only remove code directly related to
> STATS.  Any removal of code that is rendered useless should
> be done in one or more subsequent patches.
> 
> Thanks,

comp_alg_common was part of the implementation of STATS.

I'll do the best I can to interpret your request, but if you could actually
review my original patch and let me know if there are any other specific changes
you'd like besides keeping comp_alg_common, that would be helpful as then maybe
the next version won't get reverted.

- Eric

