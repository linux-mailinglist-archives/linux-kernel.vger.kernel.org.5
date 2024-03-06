Return-Path: <linux-kernel+bounces-94340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00A873D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0828378F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6E413BAEC;
	Wed,  6 Mar 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5kTvuYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E55E08B;
	Wed,  6 Mar 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746895; cv=none; b=hCWyGodTf6f4AcZrWz7wfX4h7g7sicAt3URUGe08p2RVJtRX1AVPC8VI/OF+7mc3PwCZtlUleggXUnxJYKlSn6qPxLunVO+QpAiEMCYqS8ittBt2LcHeev5Gpx6X7mKiR2PnS8/IX0j9R0O1QnPyRnIqpUV7hxfaqX8VH+3IItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746895; c=relaxed/simple;
	bh=m5N0YnAaYwp+ECWIZ0t0tyVEcs8wyl7RLdELSeNFEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXwv1rghv0+g/h0nNFVtx6xasUEq7rgPthN4wqtTgmWaohlK5gmCtbqVzlq1KWywKOHBl/F4HNLVrrFI2lY278aiyI4U9/T86rYlmjUmcoejOWgcqVPXb6Lm9O/fj4jSHp2YlXve7QMaQZSLDBnQOrvXcr61TiZ1zhzWoMyy+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5kTvuYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4FFC433C7;
	Wed,  6 Mar 2024 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709746895;
	bh=m5N0YnAaYwp+ECWIZ0t0tyVEcs8wyl7RLdELSeNFEnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y5kTvuYK+viH7kQ/AUbT/A0c501msi+IZ6W/78AFVIx27oqsJPntm0XHdyX6CXP9R
	 ls3eX8DVpdNcbcDXAj7H0PDQnOwRCK7PJfW3Dx9nZR57KvPyeVqP7nJC9Z5K9m3H5Y
	 lJ5dh8Vrxvj33/DrzuKevd1SuZvOVEQWXdKci+lWb9v7MgyIcXREdqYYHZlJowVJlq
	 NaFaO1fFiJLv0cDef64uPUYqdXAF+K5Zs8rHPAblUdBbiaxbLE4GNzbTTI7rCwdF1v
	 lcFeKk666y6EeCvXoieSsPJ/Fdc7JGvWa/5IZZ0WVFnb7Ud7WwDwhDAYEtX9+CXqoT
	 zJTP5CfeQEYgw==
Date: Wed, 6 Mar 2024 09:41:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "almasrymina@google.com" <almasrymina@google.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "steffen.klassert@secunet.com"
 <steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>, "ian.kumlien@gmail.com" <ian.kumlien@gmail.com>,
 "Anatoli.Chechelnickiy@m.interpipe.biz"
 <Anatoli.Chechelnickiy@m.interpipe.biz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Message-ID: <20240306094133.7075c39f@kernel.org>
In-Reply-To: <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	<20240305190427.757b92b8@kernel.org>
	<7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
	<20240306072225.4a61e57c@kernel.org>
	<320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
	<20240306080931.2e24101b@kernel.org>
	<CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
	<9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 17:09:57 +0000 Dragos Tatulea wrote:
> > Does the caller need to check skb->pp_recycle? pp_recycle seems like a
> > redundant bit. We can tell whether the page is pp by checking
> > is_pp_page(page). the pages in the frag must be pp pages when
> > skb->pp_recycle is set and must be non pp pages when the
> > skb->pp_recycle is not set, so it all seems redundant to me.
> >   
> AFAIU we don't have to check for pp_recycle, at least not in this specific case.

Definitely not something we assuming in a fix that needs to go 
to stable.

So far, AFAIU, it's legal to have an skb without skb->pp_recycle
set, which holds full page refs to a PP page.

