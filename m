Return-Path: <linux-kernel+bounces-157995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73F8B19F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C02B2372D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2C39FF2;
	Thu, 25 Apr 2024 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAHevjKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825642C1A0;
	Thu, 25 Apr 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019789; cv=none; b=mbTtP6Aq+5zq384BaGjrF+8ADW4/w6xkPLKgl8cOV/EBFigNxsY+kPy3xFnpc9bEEQlqaCPlzLQrOKeul4qd9gMNdP79poNFJNcy/lujZgn7GFF4bp+x46Xd2lkjb6VbQ7ZA/+BURzIKACE5WIhRRZVOCheb2sTPqf7qSYlIScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019789; c=relaxed/simple;
	bh=fXdQuGCBF2mrkoHKGOX0W2cFyTyXQUKOpwOkndJhb9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F424teixsyS52t3aP78ZBGek+k0MgXcmitcn87SgXezcb8w69p7FO5eM1v1ybzRsIJLRRNjWOIBDi/bBu48gbi1m5TUC8YyDl7thC5AnlorEZfWEWlXNnNVp19TEWvXMKrAB7UXgSaen1yLGbYUVk/zhpowUrQfWaSvUJY+vvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAHevjKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696C9C113CC;
	Thu, 25 Apr 2024 04:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714019789;
	bh=fXdQuGCBF2mrkoHKGOX0W2cFyTyXQUKOpwOkndJhb9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAHevjKbXf2UfwyP5tbjwKQr2sMEGEL1/GHCAUbca7NqRDYJ8u+UNDDd2XdiLsE8I
	 8uHW4A002O2jP4evNpdbiRR/lQDw55yZtoth0hDStGE2v3mECyRtiRDj34tCCLDoRW
	 FpDXvvumIOolvmVxBOzmJko5cSSSqkD4TJE9Gejg8Cz+jHsuRBWoDmO6bDcRNAvad0
	 YoAv3eU2AOOoMzQvkVJ4do2XL/iovdMGPtZBzca0RgzCdwH/dvT0yMKAluA1rxAu0N
	 a+PvW7ZLeMCkAxiiHJFCBF4YcgTIdvONco7ruTJ5NaSIwkFPJbTth7Ag1fOAtqphRl
	 cUt5V7XTyoUvA==
Date: Wed, 24 Apr 2024 21:36:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v17 20/21] Documentation: add ipe documentation
Message-ID: <20240425043626.GF1401@sol.localdomain>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>
 <20240425041351.GD1401@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425041351.GD1401@sol.localdomain>

On Wed, Apr 24, 2024 at 09:13:51PM -0700, Eric Biggers wrote:
> > +.. [#dmveritydigests] These hash algorithms are based on values accepted by dm-verity,
> > +                      specifically ``crypto_alloc_ahash`` in ``verity_ctr``; ``veritysetup``
> > +                      does support more algorithms than the list above. IPE does not impose
> > +                      any restrictions on the digest algorithm itself; thus, this list
> > +                      may be out of date.
> 
> References to specific functions and locations in the code tend to get out of
> date.  I think you mean something like: any hash algorithm that's supported by
> the Linux crypto API is supported.
> 

Also, this scheme looks buggy because it's directly reusing the crypto API's
algorithm name string as the digest name.  The crypto API lets you specify the
name of an algorithm, like "sha256", but it also lets you specify the name of a
particular *implementation* of an algorithm, like "sha256-ni" for the SHA-NI
accelerated implementation of sha256.  It looks like dm-verity just passes
through the name directly to the crypto API, and as a result it accepts names
like sha256-ni.  Since you're directly passing the same name into the
security_bdev_setintegrity() LSM hook, that would result in IPE being told that
the hash is "sha256-ni".  That doesn't make sense.  I think you want to be
passing in crypto_ahash_alg_name(v->tfm), not v->alg_name.

- Eric

