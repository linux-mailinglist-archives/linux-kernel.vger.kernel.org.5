Return-Path: <linux-kernel+bounces-139819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C98A081C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DE5B2326F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284A813CA9F;
	Thu, 11 Apr 2024 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VE1tAvcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F57E9;
	Thu, 11 Apr 2024 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815837; cv=none; b=esl8wV5agu7gIehNH5CEEy4oQdmCimrppBeTJRySMSH9F60n3jgcHjzT4Fj/RhVJ7KkabRVETJOQnWvGtuqlPxWSfnfj1QEEjczmr6n165PsSIWm3F6jiIP5Zi+X4RuwzUeinplnblS7s04nTxRyuQkyoyXBAzCrRPvchUb1CHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815837; c=relaxed/simple;
	bh=pipQlZPEXvUCAR8N2lSjjo5XA/D0PbxuprjFT/UeDO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHK5zLtFns2ymVfqjhXB+mlpI/NqlierZUWVOROW8jKdhYz0F+LcDzHdA0afsAaa2TKnJ2l+NyW3vxESMpl8SrvaK6JmiTR6ZD9PzE3oDWjPNmbdnzzphfGL5Nhb5CqknzKnPecbXuygtRoN/9oTpETBmjv49xxfTw3u6b4A+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VE1tAvcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF98C433F1;
	Thu, 11 Apr 2024 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712815836;
	bh=pipQlZPEXvUCAR8N2lSjjo5XA/D0PbxuprjFT/UeDO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE1tAvcH3/sjsxshMt2csgQ9AUiarTPn6lSfjCywjJWTxwfbSv+UYX2MxLtFBN6mz
	 FwtXJx1kq9wMjY/pNmx6Jx0x/TW1LSJ3cWHxYkmaSGiauQNv0ppmIwRtxCWszmM6Ig
	 ii19pw8rKM7EyYv5+e+Lior27s/62bf4vbzhzaV0=
Date: Thu, 11 Apr 2024 08:10:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] docs: stable-kernel-rules: call mainline by its
 name and change example
Message-ID: <2024041127-attach-removed-f9f0@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <ec5dff37a62681beb74f89f8fcde41b6618152f0.1712812895.git.linux@leemhuis.info>
 <2024041156-nintendo-paddling-eaad@gregkh>
 <963811ba-6c12-47d1-942e-ba7bcf93a766@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <963811ba-6c12-47d1-942e-ba7bcf93a766@leemhuis.info>

On Thu, Apr 11, 2024 at 07:50:29AM +0200, Thorsten Leemhuis wrote:
> On 11.04.24 07:30, Greg Kroah-Hartman wrote:
> > On Thu, Apr 11, 2024 at 07:25:05AM +0200, Thorsten Leemhuis wrote:
> >>  
> >> -     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> >> +     Cc: <stable@vger.kernel.org> # after 6 weeks in a stable mainline release
> > 
> > I do not know what "stable mainline release" means here, sorry.  "after
> > 4 weeks in mainline" means "after in Linus's tree for 4 weeks, but
> > Linus's tree is not "stable mainline".
> 
> I meant a proper mainline release like 6.7 or 6.8 to make it obvious
> that this does not mean a "pre-release".
> 
> I actually had used the term "proper mainline release" earlier in a
> draft, but a quick search on the net showed that this is not really used
> out there. "stable mainline release" is not popular either, but seemed
> to be a better match; I also considered "final mainline release", but
> that felt odd.
> 
> It feels like there must be some better term my mind just stumbles to
> come up with. Please help. :-D

Well, what is the goal here?  Just put it in words, I have seen stuff
like:
	Cc: <stable@vger.kernel.org> # wait until -rc3
	Cc: <stable@vger.kernel.org> # wait until 6.1 is released
	Cc: <stable@vger.kernel.org> # after -rc2

and so on.

Just pick a specific time/release might be better?  "after X weeks" is
assuming that we all know and remember how many weeks something
happened...

thanks,

greg k-h

