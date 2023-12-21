Return-Path: <linux-kernel+bounces-8835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A181BCE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C031C25D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239D62801;
	Thu, 21 Dec 2023 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2hlWxdE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07385627E0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34382C433C7;
	Thu, 21 Dec 2023 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703179076;
	bh=a8PKfR13ZFoFatiSXK9K6pcv6q4kABBQ7VlOHxwKW9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2hlWxdED7tmjneRGRZ+MgbbKkH7QPUX+ewr11BZXKspzVTHLA0j927+aJWfHZCcz
	 17MXqzhAVvt50/BaYGjAaVe1XTr7+bQyFX2C1szLTVTEHkrgYhp9W1D//NGc0lD0RO
	 HepZqq0ddbX0i3wMzAU+4CMwHiBTqDqC0ibSW7Ao=
Date: Thu, 21 Dec 2023 18:17:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] debugfs: initialize cancellations earlier
Message-ID: <2023122129-distress-sanding-8449@gregkh>
References: <20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>
 <2023122129-seclusion-qualm-3084@gregkh>
 <4b2fbac42345acb21ac2bdfe6abd4fb4a00bb8c6.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2fbac42345acb21ac2bdfe6abd4fb4a00bb8c6.camel@sipsolutions.net>

On Thu, Dec 21, 2023 at 06:10:17PM +0100, Johannes Berg wrote:
> On Thu, 2023-12-21 at 18:05 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 21, 2023 at 03:04:45PM +0100, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > Tetsuo Handa pointed out that in the (now reverted)
> > > lockdep commit I initialized the data too late.
> > 
> > As the patch isn't in any tree, what is this against?
> 
> Hm? You mean the lockdep patch? It's not relevant, but I then
> continued and wrote:
> 
> > > The same is true for the cancellation data, [...]
> 
> and then the patch goes and changes the cancellation data
> initialization?
> 
> Or do you mean the patch mentioned in the fixes?
> 
> > > Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations cancellation")
> 
> That *is* in Linus's tree, as of -rc4.
> 
> Not sure I understand the question.

But this doesn't apply against Linus's tree, or my driver-core-next
branch now, where should it go?

still confused,

greg k-h

