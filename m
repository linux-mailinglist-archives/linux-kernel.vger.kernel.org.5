Return-Path: <linux-kernel+bounces-94147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F13873A92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68B11C214F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6E61350DD;
	Wed,  6 Mar 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6JdyTqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E45DF1D;
	Wed,  6 Mar 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738547; cv=none; b=ulEk7mAn1Q2kGpBp+HE27einJKGvCMOFfG/vcUa42VEQp2439Sy1BVyWHStx4dPym5zuxiBW2xyKMfW5VvE99lAe1n4aqTUj2f/YQ9NkUkZOzeiKSCvCguUZNNUH+/qNkMRMupqs3CsD6dZsoaWq7WpziDxGpPb1TGqzM5aZpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738547; c=relaxed/simple;
	bh=1LgluQv1M0MpfLZxjv6T5+z/3k7YjbHLdzNPN3vfxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGQrb9o7FEaweItTyXV72QmO03s7dXmiJrHxkPE5N2+gQk17Lio93rjkPBocnFajD8PLG/gW3Po0vm2IZzlJJW4ZAbeplx3IFEl63Kyq0auQU6OShLHElbPf5IIJigt39oT9EaXMngIElcTn2rJf0Vr66zbUKRWhk0Fuo4LXADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6JdyTqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485FBC433F1;
	Wed,  6 Mar 2024 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709738546;
	bh=1LgluQv1M0MpfLZxjv6T5+z/3k7YjbHLdzNPN3vfxrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c6JdyTqKkKCGVZO+Af70uAEJ2llNw5TNzY1aRj2xHJxozsPCsV1pgOOSipXDvyvq6
	 GDThdToWSVOc2K8DbA+kXsJxWcmMSqGjFsbeFkXODveioXeAcIGuJDZ6AZcJjm9ayr
	 HABbgzUMl+9BJSSxST3RY6mrbhlxactZcuGMjaIsYB80+X9bjUVUXxgyBbPl34vhvw
	 GdnhXLPMMIGq6ToRkab8kNPm8wR/3/xKA0I9jxp99/AjIzOlf8flMBwF9jfLbWSbwJ
	 rzw1wqDYtL4wT62bPQ3tTQWoO2vDAth/HtrW+NeAe3PGcG9agGH0tTqWXQ8eCOh038
	 qMXHTOGI4c1TA==
Date: Wed, 6 Mar 2024 07:22:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "almasrymina@google.com" <almasrymina@google.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "steffen.klassert@secunet.com"
 <steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "ian.kumlien@gmail.com" <ian.kumlien@gmail.com>,
 "Anatoli.Chechelnickiy@m.interpipe.biz"
 <Anatoli.Chechelnickiy@m.interpipe.biz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Message-ID: <20240306072225.4a61e57c@kernel.org>
In-Reply-To: <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	<20240305190427.757b92b8@kernel.org>
	<7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 13:05:14 +0000 Dragos Tatulea wrote:
> On Tue, 2024-03-05 at 19:04 -0800, Jakub Kicinski wrote:
> > On Mon, 4 Mar 2024 11:48:52 +0200 Dragos Tatulea wrote: =20
> > > When the skb is reorganized during esp_output (!esp->inline), the pag=
es
> > > coming from the original skb fragments are supposed to be released ba=
ck
> > > to the system through put_page. But if the skb fragment pages are
> > > originating from a page_pool, calling put_page on them will trigger a
> > > page_pool leak which will eventually result in a crash. =20
> >=20
> > So it just does: skb_shinfo(skb)->nr_frags =3D 1;
> > and assumes that's equivalent to owning a page ref on all the frags?
> >  =20
> My understanding is different: it sets nr_frags to 1 because it's swappin=
g out
> the old page frag in fragment 0 with the new xfrag page frag and will use=
 this
> "new" skb from here. It does take a page reference for the xfrag page fra=
g.

Same understanding, I'm just bad at explaining :)

> > Fix looks more or less good, we would need a new wrapper to avoid
> > build issues without PAGE_POOL,=C2=A0
> >  =20
> Ack. Which component would be best location for this wrapper: page_pool?

Hm, that's a judgment call.
Part of me wants to put it next to napi_frag_unref(), since we
basically need to factor out the insides of this function.
When you post the patch the page pool crowd will give us
their opinions.

> > but I wonder if we wouldn't be better
> > off changing the other side. Instead of "cutting off" the frags -
> > walking them and dealing with various page types. Because Mina and co.
> > will step onto this landmine as well. =20
> The page frags are still stored and used in the sg scatterlist. If we rel=
ease
> them at the moment when the skb is "cut off", the pages in the sg will be
> invalid. At least that's my understanding.

I was thinking something along the lines of:

	for each frag()
		if (is_pp_page()) {
			get_page();
			page_pool_unref_page(1);
		}

so that it's trivial to insert another check for "is this a zero-copy"
page in there, and error our. But on reflection the zero copy check may
be better placed in __skb_to_sgvec(), so ignore this. Just respin
what you got with a new helper.

