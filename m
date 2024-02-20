Return-Path: <linux-kernel+bounces-73088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A556485BD69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112A12858DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1A6A8C1;
	Tue, 20 Feb 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5xi02OP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03206A33A;
	Tue, 20 Feb 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436439; cv=none; b=BOBFT5YRHggYZsoegxpqyFY9oDZF7Nqf0m45PQwXjO8bV+/jXOYNpZ1qZ8GHzk62NChL+7aoHGMSBIpIkrvDZgySbGKNnc9CU0sATCgHdXyh4FMmlSswqjkuPY2tmWWkL49keRVkNK77XPKgLcXflsSSyqqgJugXlGJUi/yIHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436439; c=relaxed/simple;
	bh=WmAdOGNAxzm/Hmb9VmLy8HxLcULwI+z1Va4VFS0tBBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oicpMVJGFyybs/IPHBytiBzkXgez4oefOBPooAyvtb5WGxjmbfAxAmiP/yqmucXXPOdGbFH167XqOiHx7Sjmj5FmYZoq9CB0ghPeAHByiEfpVMlLQoMvHlJFaTBYeHUKVGKvRZwgGnzJFU37iaeOKBpUBrj7cFPA24RmRXuukoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5xi02OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BD3C433C7;
	Tue, 20 Feb 2024 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708436438;
	bh=WmAdOGNAxzm/Hmb9VmLy8HxLcULwI+z1Va4VFS0tBBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5xi02OP7/jZ8fKGmbZluNIUF0zr4Lpb/grZBUa6ixhJrNljZdL25pObvUDvQ4jyU
	 a9KiRZ/xYR7P9M76dX2yBYznM4skiS7KuvTedkz9rOFjzKQ3AUy7lTAOqaAtMIrFgq
	 zY4EqWK/2R5+cYdVhoP/BEMayamVkBmWOFpw4QV1ODRwc+vVArcehRbBNLw7g1GS67
	 NoMQo4PDST5ANBJL+pvxjfSmkd8XgonYr2eIOcO0zK9j3bHgfPRnB+Qxf6n3L76Z6u
	 STp5OL2BEUSgWd/ob2UnOxszHynN9iG3ezXa5pQTQvlbXLhO6IqUAvVUJLQ8JoGs6X
	 fMllqnLyBjTAw==
Date: Tue, 20 Feb 2024 13:40:34 +0000
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
Message-ID: <20240220134034.GM40273@kernel.org>
References: <20240211150535.3529-1-d.dulov@aladdin.ru>
 <20240216172701.GP40273@kernel.org>
 <12cd0fd0-be86-4af0-8d6b-85d3a81edd2a@hartkopp.net>
 <20240219170038.GH40273@kernel.org>
 <e9f2c716-51d3-4c03-a447-9fed357669c5@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f2c716-51d3-4c03-a447-9fed357669c5@hartkopp.net>

On Mon, Feb 19, 2024 at 09:37:46PM +0100, Oliver Hartkopp wrote:
> Hi Simon,
> 
> On 2024-02-19 18:00, Simon Horman wrote:
> > On Fri, Feb 16, 2024 at 08:47:43PM +0100, Oliver Hartkopp wrote:
> > > Hi Simon,
> > > 
> > > I have a general question on the "Fixes:" tag in this patch:
> > > 
> > > On 16.02.24 18:27, Simon Horman wrote:
> > > > On Sun, Feb 11, 2024 at 07:05:35AM -0800, Daniil Dulov wrote:
> > > > > In this case dev cannot be NULL, so remove redundant check.
> > > > > 
> > > > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > > > 
> > > > > Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> > > 
> > > IMHO this is simply an improvement which is done by all patches applied to
> > > the kernel but it does not really "fix" anything from a functional
> > > standpoint.
> > > 
> > > Shouldn't we either invent a new tag or better leave it out to not confuse
> > > the stable maintainers?
> > 
> > Hi Oliver,
> > 
> > sorry for missing that in my review.
> > 
> > Yes, I agree that this is probably not a fix, for which my
> > rule of thumb is something that addresses a user-visible problem.
> > So I agree it should not have a fixes tag.
> > 
> > I would suggest that we can just change the text to something that
> > has no tag. Something like:
> > 
> > ...
> > 
> > Introduced by 03fd3cf5a179 ("can: add driver for Softing card")
> > 
> 
> Yes, but the "Introduced-by:" tag would be an optional tag for people that
> like blaming others, right?

Yes, That does seem useful to me.

> IMHO we should think about completely removing the "Fixes:" tag, when it has
> no user-visible effect that might be a candidate for stable kernels. It is
> common improvement work. And it has been so for years.

Likewise, that does sound like a good idea to me.

