Return-Path: <linux-kernel+bounces-8430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED181B707
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87337286D85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50273185;
	Thu, 21 Dec 2023 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0XNbvUt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112B73167;
	Thu, 21 Dec 2023 13:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C8DC433C8;
	Thu, 21 Dec 2023 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703164206;
	bh=bqwNo3sih6dX67U+J8kDPqDIzx8u7hGCfXZ14KS4L2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0XNbvUtS54+Og/3j1U1Q525F1VpWrWIOyDcGyyD2ROhi2hlayRacda8jWR27unlQ
	 wjM20cBTpnFpvZGxpwOKlVTziWMCcgc6jh5Uait1KeDRpZvvtWsDTDyncawl8nacra
	 VAzrfCcBik/gHFlbG7DFQw3odW34LAjT/LmbYc3c=
Date: Thu, 21 Dec 2023 14:10:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>
Subject: Re: "Link in bio" instead of Link:/Closes: trailer
Message-ID: <2023122129-twisty-mumble-c667@gregkh>
References: <ZYQeZjN_3bPOdKKf@archie.me>
 <2023122112-rigging-january-7618@gregkh>
 <cc276c0e-99bb-4422-9771-d864db4287cb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc276c0e-99bb-4422-9771-d864db4287cb@gmail.com>

On Thu, Dec 21, 2023 at 07:57:21PM +0700, Bagas Sanjaya wrote:
> On 12/21/23 18:51, Greg Kroah-Hartman wrote:
> > On Thu, Dec 21, 2023 at 06:15:50PM +0700, Bagas Sanjaya wrote:
> >> Hi all,
> >>
> >> Let's say that there is a content creator who submits her first kernel
> >> patch (touching drivers/staging/ of course to get her feet wet).
> >> The patch supposes to fix a reported bug, with appropriate Fixes: tag.
> >> But instead of using Link: or Closes: tag to the actual bug report in
> >> the patch, she instead writes "Link to the bug report in my bio", as
> >> it is the norm in social media world. Here in the context, her bio is
> >> LinkedIn profile (IDK if there is a way to add arbitrary link there).
> >> The link in LinkedIn profile, when clicked, will list many links
> >> (including her usual social media campaigns and of course the bug report),
> >> which makes reviewers confused about which link to the bug report she
> >> means. In some cases, she may disambiguate by saying in the patch,
> >> "Link to the bug report no. 99", to refer to the specific link number.
> >>
> >> Is such practice a good idea?
> > 
> > No.
> 
> why?

Exactly, why?  What problem are you trying to solve here that has
actually come up in any sort of frequency?

"Link: " is something that should be used to point to a well-known and
stable reference for any future things, like red hat's bugzilla, or
lore.kernel.org.  It's not for random social-media link reputation
spamming, sorry.

The "proper" way to handle this is to have in your Linked-in, or
whatever social media site you like, a list of your committed patches in
the git.kernel.org tree, don't polute the kernel log please.

greg k-h

