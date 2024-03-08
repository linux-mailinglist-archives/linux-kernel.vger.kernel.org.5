Return-Path: <linux-kernel+bounces-96827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCB8761F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C22B210BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44C54661;
	Fri,  8 Mar 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UF7mTJaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74753392
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893653; cv=none; b=Zo/XairfDnmYJ0Imv/Lc0zypyvbnEWT2Vvs/iBjI8jE9hSyJbFkAVZxq3tW7tLunmiKYSgUn5f6Mzym1t6Dabq94sxcwJs25oiOhHwj4BzJCWcHnesltGaCOwcpSMqbIIcT23VAq37vZ7R9dRvRZp+9ghmSbDsU8kK3dkPz+mIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893653; c=relaxed/simple;
	bh=CjGPb9TSDf8MCEbyn75Ea+N8RuJSKz/a0enfxF+tBs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCSF6121P8eWknc1yELTCiPGx+LjrHt30DWIg5Y3Yi9VfqqkCh8JLEmOUl6YZl8vtpVLMTKqjeqm2OOEcBWINK4AjOYS3u2E92Gv+szcp0/1jvOh1U6lhaN8QtLTIrE5XHEAzbgIifo1dzen4DJXfsDyKhIFNXKqLxfkOGw4TFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UF7mTJaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D289AC433C7;
	Fri,  8 Mar 2024 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709893653;
	bh=CjGPb9TSDf8MCEbyn75Ea+N8RuJSKz/a0enfxF+tBs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UF7mTJaJYyPeZPvoKwzzFqCEqSRfMZRU3TQC8/usROCKwknAjkwIcr6WDnLMl/mPg
	 Cp2Z5WKmS50sDU9lp4JITL/FcESWmlpL00GGbdcabhzmt+K6uUhvYJqKkH69ZFDa0K
	 Uo9v0glujNoZdmwb0YcpQueFz/e0iDXikgCpY+do=
Date: Fri, 8 Mar 2024 10:27:30 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: Re: CVE-2023-52496: mtd: maps: vmu-flash: Fix the (mtd core) switch
 to ref counters
Message-ID: <2024030813-subscribe-smasher-aeca@gregkh>
References: <20240229155245.1571576-37-lee@kernel.org>
 <Zerjs8hlMJOXt0Sv@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zerjs8hlMJOXt0Sv@tiehlicka>

On Fri, Mar 08, 2024 at 11:08:51AM +0100, Michal Hocko wrote:
> On Thu 29-02-24 15:52:56, Lee Jones wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
> > 
> > While switching to ref counters for track mtd devices use, the vmu-flash
> > driver was forgotten. The reason for reading the ref counter seems
> > debatable, but let's just fix the build for now.
> 
> Do we really consider build fixes as CVE? 

Nope, good catch!  We reviewed this one wrong, now revoked, thanks for
the review.

greg k-h

