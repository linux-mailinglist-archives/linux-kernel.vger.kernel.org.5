Return-Path: <linux-kernel+bounces-161014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C18B45C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C5E1F21EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99FB4A990;
	Sat, 27 Apr 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBUZgizr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5F84AECE;
	Sat, 27 Apr 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216469; cv=none; b=rDibQIbAWKvrhE7ehvVPAEkNqVXFbsnXeCHC+2lQvc4x86lhOrRqEx7AH8HODvXqghcDqOGYT/s+h0soysErRTE3/pwQ9y8uSKq4ngcQk2yGJlOj8Knf5MOkbgOwq7WT+lfxTndjUTCPn35kJRqsp66l8YRkJn4zO8SGB6YiE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216469; c=relaxed/simple;
	bh=xeinqVWxnJpqr39fv+hN4qsXVFFJei/zTwxenlJPoyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD0tbESpLwV3pA/C0i1GhNNXX6SC7SfO6MCay9gM4GtvaxSsmFRSSCNvxvdqGL3BcWAMa6Av53jNjXJDrhAanBTTHEkGnXGLfsq8L1PK4/NREiRMtI15w/2d6O6I18kui8kL5jkD75BD36REloEsW8EMghtZlQCqXUz6Ovymikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBUZgizr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B383C113CE;
	Sat, 27 Apr 2024 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714216468;
	bh=xeinqVWxnJpqr39fv+hN4qsXVFFJei/zTwxenlJPoyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBUZgizrlegY/eGOA2Z+Kthv6Ru+FjKS53peUwzXhhZras1cRwHYxUt6gwl+Jb4FC
	 2z2RoAOQnQ3ZmEbuljPmULKuQz2/LdA0ZOBmDQaUZMvJEoAL+TYZX1I7rgwUPlp7nM
	 RF6ISo/d28NvZkeqbNwRRAdB0+4o3GuaoK5PXkFo=
Date: Sat, 27 Apr 2024 13:14:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [BUG] e1000e, scheduling while atomic (stable)
Message-ID: <2024042756-lushness-cupped-f19b@gregkh>
References: <2024042328-footprint-enrage-2db3@gregkh>
 <2330c23c-e99b-454a-b195-32c5b4332071@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2330c23c-e99b-454a-b195-32c5b4332071@gmx.com>

On Sat, Apr 27, 2024 at 10:54:23AM +0000, Artem S. Tashkinov wrote:
> Hello,
> 
> This fix is still not queued in 6.8 stable:

What fix?

> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8
> 
> Why?

What is the git id of the change in Linus's tree?

thanks,

greg k-h

