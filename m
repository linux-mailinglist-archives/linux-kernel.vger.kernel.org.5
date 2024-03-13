Return-Path: <linux-kernel+bounces-101048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBF87A196
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B480B21DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736210A24;
	Wed, 13 Mar 2024 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liAzHQE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE310799;
	Wed, 13 Mar 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296541; cv=none; b=NxLMjZAztBJq4Mn5CJWZnJ9P/Mp6M4r6xM26ZCnViuo+ideBSjfcg2rtjLg271dLEGkSfwJLDYjS3l04lzmgfVgD3yDEv/BFPigRIFMsLO4rp+cuf1m+P2v/tw80OofDO1nUJ7PDDxpubm1nWRtqw4l4ekJhn8rr+7OaNLuFhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296541; c=relaxed/simple;
	bh=ldxtKrJbu43kvG/V9Bf8pls357tbK/PUoqfJe1t2P6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC6KlawnLnMFCWpAol6LdcpdSZjqio2YyE3yB8IUq+98ciQT5jdUCzm2qZEJdQ3lW3ZGvVxfHudnZpCtfUAFgXSW6x7pqyMDJ13DR1SUJu1AGlK66RmQ0xQ1X9VYjD8JPceZ3NQX3FWcPxzHedTU+DqkJ0acF2qpWmQOBHq2cxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liAzHQE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C785C433C7;
	Wed, 13 Mar 2024 02:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710296541;
	bh=ldxtKrJbu43kvG/V9Bf8pls357tbK/PUoqfJe1t2P6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liAzHQE54Rz+aSx7a9I8TQV7mNbI8P1U07aetWwefTj+5SPWcsE5r5BFva4oUiP3L
	 52W923SBPP/8Y8tSOP9Rg0oAu8e+Zdr6rCNYnaiSuhI1q1cbBCpp1dEs7W1bDHSJQC
	 kpy2TeYC4UDgGKks6hq8M4vt6p/+pxV8aqes+6/hoQG7PDjKk9NGtaiLbCFLxiSRZ3
	 6wuwMm4WCCTmAHO/FLfFniUG7WDHJwuo9FQ1G14ENjTXmUvvIHJQeFw6uh2OrVJrc+
	 ejNtxsVDyj27wATJ6lG3/8xhdEtvSEEzW4nk4lBiEPJZo5miTbIjbJ5CH07nsJ0gpI
	 qaEuEsDXvqkCg==
Date: Tue, 12 Mar 2024 19:22:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, sfr@canb.auug.org.au,
	v-songbaohua@oppo.com
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20240313022219.GC1148@sol.localdomain>
References: <20240313020112.GB1148@sol.localdomain>
 <20240313021211.47293-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313021211.47293-1-21cnbao@gmail.com>

On Wed, Mar 13, 2024 at 03:12:11PM +1300, Barry Song wrote:
> > The only user of comp_alg_common was the crypto stats, and it was introduced by
> > a refactoring of the crypto stats (commit 0a742389bcc0, "crypto: acomp - Count
> > error stats differently"), so it seems appropriate to remove it for now.
> > 
> > If you could go through my patch and explain what other unused code related to
> > the crypto stats you might consider to be "infrastructure" that should not be
> > removed, that would be helpful.
> 
> Hi Eric,
> that user is mm/zswap [1], apologize it was not in crypto tree. I guess you might
> just need a new version to keep that one :-)
> 
> [1] https://lore.kernel.org/linux-mm/20240222081135.173040-2-21cnbao@gmail.com/ 
> 

That code is just reading the algorithm flags, which exist regardless of whether
struct comp_alg_common does or not.  The exact way to get at those flags just
changes slightly.

- Eric

