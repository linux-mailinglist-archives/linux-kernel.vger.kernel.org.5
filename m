Return-Path: <linux-kernel+bounces-68639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D4857DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509BF2888B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD0129A99;
	Fri, 16 Feb 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng6pjzTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76B1292C4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090003; cv=none; b=HHE6PeNZ+mEHOqSFFubvWzsvvSskLjpJGk9KNx+riUVLt+XYnFRMa+vfP3y1RXKQNgG9h8sSpx0MG2t46K8MmIj29HTmbrtThNEyLo8tEFiQCiQ6g3jYRDRNB6IQ5tZ5bEZvF0v58lRKslryeKworqGfZHCEn/0AN4s29Xo1vD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090003; c=relaxed/simple;
	bh=L+zWcKXu5rAFw6ba1pojZ+9nUXWlollmWlUww2vrm5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEBaV/mrYm2IFIv52EVo8nFMkVdU+deLlpTsrA7CA4PqASqrcXBTBS1mPrJiM38CJ8zj6J5R/xKgX9Z40M//8X7NftPsXXaSx8lnsd/MUqXYrRj3vV9qMlZlNCpTWCEJV22okMnaL1USgiU2CTtRfNRyLwcHEuLew3HWmbTZbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng6pjzTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24375C433F1;
	Fri, 16 Feb 2024 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708090003;
	bh=L+zWcKXu5rAFw6ba1pojZ+9nUXWlollmWlUww2vrm5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ng6pjzTBfYDThdI1L7wuSshOBayj6W96MOGO3ROg9KRTHrHB2jJqr5X6BfLhMBx7Z
	 tR7Zs1CtXpHtRwppPKPywID2OYEKHKtQWUUU4V5VkW2ir+CPHmlmNQgxsEsSfFmsLs
	 KCjJ2HMVBemy+huKm7v3K8UyxUdx4HK4Q9L8EegXaInjwmXYjWCTKoJARmZJBj5Zgn
	 whPkn0hVyGaf+mR8ggSSAgwQHZE0BzN/+QJL1gexMtsqOk2N3ZXqxGjvtxvWG1rizd
	 155UTM2KDbfqWBfH+JqI9zexYdD7kPZUkYvo3FpI/SS09BriWRLDgnFZLAXUYlAnq2
	 ldGv1PdTjOFEA==
Date: Fri, 16 Feb 2024 14:26:38 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [RFC PATCH v1 0/5] VT: Add ability to get font requirements
Message-ID: <Zc9ijvUofv4PCLw_@example.org>
References: <cover.1708011391.git.legion@kernel.org>
 <d7743747-1ec2-4557-9f2f-4cffd77284b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7743747-1ec2-4557-9f2f-4cffd77284b3@kernel.org>

On Fri, Feb 16, 2024 at 08:21:38AM +0100, Jiri Slaby wrote:
> On 15. 02. 24, 16:37, Alexey Gladkov wrote:
> > We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
> > loaded. No console driver supports tall fonts.
> 
> I thought fbcon can, no? If not, we should likely remove all the 
> KD_FONT_OP_SET_TALL checks here and there.

I thought so too until kbd users started trying to use such fonts. A month
after adding KD_FONT_OP_SET_TALL, support for large fonts was turned off
in fbcon:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=2b09d5d364986f724f17001ccfe4126b9b43a0be

But I don't think we need to remove KD_FONT_OP_SET_TALL completely. Maybe
support for large fonts can be fixed.

I suggested GET_INFO to solve the problem in general. Even if there is no
SET_TALL, the problem still remains. For example newport only supports
8x16 fonts.

> > Unfortunately, userspace
> > cannot distinguish the lack of support in the driver from errors in the
> > font itself. In all cases, EINVAL will be returned.
> 
> Yeah, AFAIR userspace just tries many possibilities and sees what trial 
> worked.

Yep. In case of big font, I don’t know how to improve the error message in
setfont. The EINVAL is very confusing for users.

> > How about adding another operator to get the supported font size so that
> > userspace can handle this situation correctly?
> 
> The whole font interface is horrid (and we got rid of v1 interface only 
> recently). Like (ab)using height = vpitch in KD_FONT_OP_SET_TALL :(.

Yep.

> So perhaps, as a band-aid, this might be fine (note you give no 
> opportunity to find out supported vpitch for example).

The vpitch can be 32 or if the height is greater, then vpitch = fnt_height

> Eventually, we need to invent a v3 interface with some better font_op
> struct with reserved fields for future use and so on.

Yes, yes, yes! Can we discuss this, pleeeeese? :)

> 
> > I mean something like this proof-of-concept.
> > 
> > ---
> > 
> > Alexey Gladkov (5):
> >    VT: Add KD_FONT_OP_GET_INFO operation
> >    newport_con: Allow to get max font width and height
> >    sticon: Allow to get max font width and height
> >    vgacon: Allow to get max font width and height
> >    fbcon: Allow to get max font width and height
> > 
> >   drivers/tty/vt/vt.c                 | 27 +++++++++++++++++++++++++++
> >   drivers/tty/vt/vt_ioctl.c           |  2 +-
> >   drivers/video/console/newport_con.c | 21 +++++++++++++++++----
> >   drivers/video/console/sticon.c      | 21 +++++++++++++++++++--
> >   drivers/video/console/vgacon.c      | 17 ++++++++++++++++-
> >   drivers/video/fbdev/core/fbcon.c    | 18 +++++++++++++++++-
> >   include/linux/console.h             |  1 +
> >   include/uapi/linux/kd.h             |  1 +
> >   8 files changed, 99 insertions(+), 9 deletions(-)
> > 
> 
> -- 
> js
> suse labs
> 

-- 
Rgrds, legion


