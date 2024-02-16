Return-Path: <linux-kernel+bounces-68887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35082858168
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672C51C211D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF612FB3E;
	Fri, 16 Feb 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSdhlpob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B912FB14;
	Fri, 16 Feb 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097701; cv=none; b=QdDiIwMI8gyCNSF7aCxC/6Y45kZSmwxpDBjW392SsqBRsH+OUewwuLQ2yJ0tvhvVasj89IPyJhtWkjK7Rw3eS+oLuTybcGm2nLgcVVzlhI6dERAh1KE1udJduQ0YMB6ukgjyvl2vuNJLKyPQeXsotJTy1fQ/Ya0SYYzhmbOx9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097701; c=relaxed/simple;
	bh=SS7iDD7dZDZOfWXznvwX8y8maPYyPpOM4xbYO597iD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB1lUIeTGqYCMS5mgsQVaaKzdLw3Lwq5LvzJPyWmhlO1sJ0H0nfWFMQO6345PJkTA4Zxj8pCGX/oKA/fUi75fLXNqb4w5FCoqTNbXh+E6YfFiq+VEm3CA2i+h/Fj5RHcrapGeTQkNY6Fw3X9X7fS+2fQ96+bjSXcBmaHzmx35Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSdhlpob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20284C433F1;
	Fri, 16 Feb 2024 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708097700;
	bh=SS7iDD7dZDZOfWXznvwX8y8maPYyPpOM4xbYO597iD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSdhlpobzJh7tkYVoyheKTAJ2RQJIIXsgUYWbAbqzbQHjLE7NmHurOg9OkTpfyc22
	 Ryn2vGMzQlmQhxCgtwpbivbbUmXRZOne+DYoSUVULzIrBOo9r098ubxdGbigUGYB4i
	 pYvUkHFgcbbrw0fxUSh7sWYmtArMOhZFrfvho3bE=
Date: Fri, 16 Feb 2024 16:34:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021620-retrieval-lethargic-eeca@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
 <2024021518-stature-frightful-e7fc@gregkh>
 <Zc5ZpB6jsuTKmhv5@tiehlicka>
 <2024021646-procedure-faceted-ea87@gregkh>
 <Zc9hBJuca3f_5KHx@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9hBJuca3f_5KHx@tiehlicka>

On Fri, Feb 16, 2024 at 02:20:04PM +0100, Michal Hocko wrote:
> > Right now
> > we are fixing lots and lots of things and no one notices as their
> > "traditional" path of only looking at CVEs for the kernel is totally
> > incorrect.
> 
> Right, there are quite a lot of people who consider CVE fixes much more
> important than regular fixes. Their reasoning might be completely
> misleading but there might be very good reasons to stick to minimalistic
> approach, e.g. to reduce risk of regressions.
> 
> I believe it is perfectly fair to say that whoever relies on stable
> kernels support needs to update to the latest stable kernel version to
> be covered by security and functional fixes. On the other hand I do not
> think it is an improvement to the process to swamp CVE database with any
> random fixes without a proper evaluation. If the kernel community
> doesn't believe in the CVE process then fair enough, just do not assign
> them unless you want to explicitly call out fixes with a high impact
> security implications. Having fewer good quality CVEs would definitely
> improve the process.

As you know, it's almost impossible to determine if a fix is "high
impact" or not, given that we have no idea what anyone's use case is for
the kernel.  We have documented proof of single-byte-buffer-overflows
resulting in complete system takeovers, and the same for very tiny
use-after-free issues, and the same for tiny "overflow a USB string
buffer" issues, and so on.

So as always, we need to treat "a bug is a bug is a bug" and when
looking at the bug fix, if it resolves something that is known to be
a vulnerability (again, as defined by CVE themselves), then we need to
mark it as such.

If you find that we are marking things as a CVE thatt you do not feel
should be marked as such, please let us know and we will be glad to
discuss it on a case-by-case basis.

But note, this type of classification has been happening for the kernel
stable commits for 2+ years now, by Sasha, in the GSD records, so this
isn't something new that we have been doing, it's just that only a very
small group were noticing that, and now a larger one might notice this.

thanks,

greg k-h

