Return-Path: <linux-kernel+bounces-102446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49587B229
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706871C254E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3824D9F0;
	Wed, 13 Mar 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+lHgNSp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3F4776A;
	Wed, 13 Mar 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359066; cv=none; b=pmthT7VxFmPBUiL+OTRNIUHMGNQyfr/FNYhbj81Sdl7Kke7FioK5H5oP4cnkt4+LNxCZBd0AFGhUuHQRvMgu1Y58cH1/lmOXMLxdVbJtdxyHqgyW9gaUSoZWg83mzpw4r8ja9d8AZ4oNu/WcAxDWoQRn8/fAmbAh8XmZoMniDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359066; c=relaxed/simple;
	bh=y4IkOkfDTy6Hf5RFlO9oP6K871NhGp6uazdYCzXOG5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjjqEgF/Ig42wOKYGZE6Esr5KjrfJXhS1FrmR/qqrjsgiV0YV0Ufhgkh/LvFLSUcAargJd9awgJqqcHpwLmz0Iveqlqif2uQAoQ+q1GlBosNDT0Kbnmguycm0ke9eURaeHFKnTOkFw49dtbgE5B7EzxTpQDQ4pwMFo+avp7xM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+lHgNSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9B6C433F1;
	Wed, 13 Mar 2024 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710359065;
	bh=y4IkOkfDTy6Hf5RFlO9oP6K871NhGp6uazdYCzXOG5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+lHgNSpmOVZFWHTL9/c1q9/BAn+Hs2c1s3lqTXVoGwnLWhY7ebljIWs+Di9lmYPq
	 qXxJTCDpoiM7OxydG+AfbATKxYHfO32qhDAHBzPR0ycn1LuXPzCJNyE8PopCBIoZ0M
	 VwhveDYuplvMxkTUkwzkykT4bQqyHomo7QVmqsp1/ZjJfE9/gcUTM1Q3+1xPmgCX7G
	 I5dWqE2e/Uh5P0Z0lGYULRAIvr/aFXnaHeV5yTMsJ1D3VxEfHcvff3RKqfp8Y3iGSm
	 eNptZnJxrvjBkgKQV7nTr0N1VrlxJ7XMFIUOIIqlrwLGQqZYj6y7WNi7DkErD8bqC8
	 uaVnhthnNyIfw==
Date: Wed, 13 Mar 2024 12:44:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Karel Balej <balejk@matfyz.cz>, dimitri.ledkov@canonical.com,
	alexandre.torgue@foss.st.com, davem@davemloft.net,
	dhowells@redhat.com, herbert@gondor.apana.org.au,
	keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
	mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, iwd@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Message-ID: <20240313194423.GA1111@sol.localdomain>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>

On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
> Hi,
> 
> On 3/13/24 1:56 AM, Johannes Berg wrote:
> > Not sure why you're CC'ing the world, but I guess adding a few more
> > doesn't hurt ...
> > 
> > On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
> > >   and I use iwd
> > This is your problem, the wireless stack in the kernel doesn't use any
> > kernel crypto code for 802.1X.
> 
> Yes, the wireless stack has zero bearing on the issue. I think that's what
> you meant by "problem".
> 
> IWD has used the kernel crypto API forever which was abruptly broken, that
> is the problem.
> 
> The original commit says it was to remove support for sha1 signed kernel
> modules, but it did more than that and broke the keyctl API.
> 

Which specific API is iwd using that is relevant here?
I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
and grepped for keyctl and AF_ALG, but there are no matches.

- Eric

