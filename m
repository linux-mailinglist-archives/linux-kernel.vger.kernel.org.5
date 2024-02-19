Return-Path: <linux-kernel+bounces-71722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008A85A97B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F79B22AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF1446C0;
	Mon, 19 Feb 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5grmsz4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709D44388;
	Mon, 19 Feb 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362043; cv=none; b=XiR3q7k5mez2ykKYF+/NF4T31CGHfpFSLBNowKrbRZ2LDWRa86KMI5lG41EaifaLAyd02V4mu345wvV9kw/YW8klIVeVZHyYel62VyUXywUoukdUNonfYn+jiSk9m97IiXVlxDM+F/+PjnA7DdrUlVjeDE/NQDvQkfUsAU3gHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362043; c=relaxed/simple;
	bh=XPPEt6wCtblH7LoSRYodT/mgjuR30D08tbYVNR6SbwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCjh62BZ6vTXG7SlF/Q7IRIUSEO9bDLz3jBaBWePNI5pxNOIOVRsyKhiA2HbkceYjQEmOsnHrmuu+cT+IZqVeIPlFe5U+yTtyzHjx2NerJdUcajbF9EWQuIMasrxCQ1NJn9kCYDkwtE9Ixx22q1D9mEBVAxFmkQO58AeyYmyuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5grmsz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA21C433F1;
	Mon, 19 Feb 2024 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708362043;
	bh=XPPEt6wCtblH7LoSRYodT/mgjuR30D08tbYVNR6SbwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5grmsz4Yqu3H+DNp3b4VFSbkNje/wxgHQfyroU3XauDb5My9vZWR7kRhX1YM8RXv
	 u4IeOeWPw9mnGnOqKIwUuz4Qb7Zcv9CUQzrJ20JJh7Rc89Xpf6xdgtcGMlvEa5BXW0
	 aR8thf991KLEUKzTEg/gCo//DKZpRCng+1+6EUxTdGem4+jIyySUVtDa3TLE1hrhsV
	 s3HyrKb+lS8ddbsRgvRUX7r5torKsMu5hjhnlEkYfunbJ9qPmgLwX4s6earMm85Uu3
	 bO1IAzoSyoawecfmvM3/asqxJrKqBP85mykK49YH6WSstCu8LbXavXWQLvpEoUfWvf
	 Q5GT21b3xKpeA==
Date: Mon, 19 Feb 2024 17:00:38 +0000
From: Simon Horman <horms@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] can: softing: remove redundant NULL check
Message-ID: <20240219170038.GH40273@kernel.org>
References: <20240211150535.3529-1-d.dulov@aladdin.ru>
 <20240216172701.GP40273@kernel.org>
 <12cd0fd0-be86-4af0-8d6b-85d3a81edd2a@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12cd0fd0-be86-4af0-8d6b-85d3a81edd2a@hartkopp.net>

On Fri, Feb 16, 2024 at 08:47:43PM +0100, Oliver Hartkopp wrote:
> Hi Simon,
> 
> I have a general question on the "Fixes:" tag in this patch:
> 
> On 16.02.24 18:27, Simon Horman wrote:
> > On Sun, Feb 11, 2024 at 07:05:35AM -0800, Daniil Dulov wrote:
> > > In this case dev cannot be NULL, so remove redundant check.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> 
> IMHO this is simply an improvement which is done by all patches applied to
> the kernel but it does not really "fix" anything from a functional
> standpoint.
> 
> Shouldn't we either invent a new tag or better leave it out to not confuse
> the stable maintainers?

Hi Oliver,

sorry for missing that in my review.

Yes, I agree that this is probably not a fix, for which my
rule of thumb is something that addresses a user-visible problem.
So I agree it should not have a fixes tag.

I would suggest that we can just change the text to something that
has no tag. Something like:

..

Introduced by 03fd3cf5a179 ("can: add driver for Softing card")

Signed-of-by: ...


> 
> Best regards,
> Oliver
> 
> > > Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> > 
> > Hi Daniil,
> > 
> > I am not sure that dev cannot be NULL.
> > But I do see that the code assumes it is not, and would crash if it is.
> > So I think that, functionally, your statement is correct.
> > 
> > 	priv = netdev_priv(dev);
> > 	card = priv->card;
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> 

