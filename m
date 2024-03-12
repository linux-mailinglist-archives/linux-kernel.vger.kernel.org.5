Return-Path: <linux-kernel+bounces-99759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A46878CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD02B21A47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EE6FCA;
	Tue, 12 Mar 2024 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKkAFQ06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A653A1;
	Tue, 12 Mar 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209704; cv=none; b=RcKlHVQPPlBQk38ycuLunpDdCsPB0buC0kpCC1dnZPwue6yyfRAcZ/PHjP0GzlVX6p8hSvt7C+CCnUcMQ7Sv5x4MTAvvlfov4weMHciYC1DLzXdPgcNjzPz8Y5k7J0JEjsLlMAfMQhCFjosdKYw4Fn+m0y7CZCXdplMt38DKfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209704; c=relaxed/simple;
	bh=PJovpp2A+JaRMOnogNorzQ2dH5WkxIAjttZeU5mf2+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4m8U70bgTOnYUTyPvLO0ZpViAMwzyVRaEaR0OQIoo4I3iGdaBZB+EDvqlHTFLo/RF4lIWh6la/x5k+PBCbOPZm5RgcKGVPfqxIHUKEQoRshGYFodYa2/6sScQcZScsn3PArbpuO4bF1832Sn0Wgr0EjTUeLu4pn2wB7oMOsqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKkAFQ06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C475AC433C7;
	Tue, 12 Mar 2024 02:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710209704;
	bh=PJovpp2A+JaRMOnogNorzQ2dH5WkxIAjttZeU5mf2+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKkAFQ06PHlEUHbibzQjppazuw2ho4yAVBApbsT5E0z3RuR6Mnmc+9tJKvBXyTdFO
	 4CCjYd1/mkFtSs1Ym1fJuRrld/n+DfzS6pr4XhO/DE6IcLc5qUaP3i6L9cfy3jCz+t
	 uayY/pY2TRXh5blsEqSEFTsYKlT2NkXhAUAPq7lL0n3qCqVvEmh32B7sSlVu/aS2PU
	 Px0ubjorDH87kuBNC/JECWUonlQ19hDkuA0NIVZKM0N650+Q2i60PbRIvQ1gn8XQ4x
	 J5/fXmG9J8A2bYuz02Q68ILhR+OuwKbrkFP4UNdVXdNdnJkhIDx/2qQnT8872xoCpJ
	 D91ps8Df7kGng==
Date: Mon, 11 Mar 2024 19:15:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net, x86@kernel.org
Subject: Re: [PATCH] crypto: x86/aesni - Update aesni_set_key() to return void
Message-ID: <20240312021502.GB1182@sol.localdomain>
References: <20230607053558.GC941@sol.localdomain>
 <20240311213232.128240-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311213232.128240-1-chang.seok.bae@intel.com>

On Mon, Mar 11, 2024 at 02:32:32PM -0700, Chang S. Bae wrote:
> The aesni_set_key() implementation has no error case, yet its prototype
> specifies to return an error code.
> 
> Modify the function prototype to return void and adjust the related code.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Previously, Eric identified a similar case in my AES-KL code [1]. Then,
> this parallel issue was realized.
> 
> [1]: https://lore.kernel.org/lkml/20230607053558.GC941@sol.localdomain/
> ---
>  arch/x86/crypto/aesni-intel_asm.S  | 5 ++---
>  arch/x86/crypto/aesni-intel_glue.c | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

