Return-Path: <linux-kernel+bounces-65340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF130854B73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8AB23F03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EE56762;
	Wed, 14 Feb 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpmmVSpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43C10A3F;
	Wed, 14 Feb 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921137; cv=none; b=Wkn2d6uGyL6kXXaZsfpgKqiABbCKQfJyXavOD3LKmDO/u+gzdH8+mrm2PWYqiGpuZWS8zrno7g5FYHzCOlLYwQxR337t9yo8gLAMZOlEWn1uQSQIGx52/Rovn8vIHHruWSzVnh/CGbCXW+DfMT+lyW/7joTnjRX+ZnpsXFDQy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921137; c=relaxed/simple;
	bh=x/BFgbLyCYuYNGhL/l9F4/hojdntua1OICmugMdR/ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6/i3MwuGPf8rpAfV4hHz+lQBsVhdcAVgQvO/K8dgHszA3kKY02QldL/AMpwpd4piW0fkje/DoDnS1EcAruGsSCQX9xlw2XzU6fZKVNuXHyeFd1WGKbezxSCOMJ1BFxkWZ4h7e6kLwXuiFBD+V3wh49S4AhSGQ86BFWh3SftQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpmmVSpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA24C433C7;
	Wed, 14 Feb 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707921136;
	bh=x/BFgbLyCYuYNGhL/l9F4/hojdntua1OICmugMdR/ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpmmVSpl02RtEp3ASMN7LCUrQNtgS9MfyJzmewGj+yz8h/1HPHxfhVQ1kMP4zvDJJ
	 /e93w2xb7J0+0baU71SMMwrycyy1Js0cKpjiGnpR16FYMV5zjlwOwHClvOKm8OVm2U
	 CpEz5MTnNM7vnFv5HK30ChlEOJ4kX6AqYxiP5kVY=
Date: Wed, 14 Feb 2024 15:32:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021402-dehydrate-stock-1f12@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
 <7c177ba2-6b0a-4203-9ee6-113e75c6bb13@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c177ba2-6b0a-4203-9ee6-113e75c6bb13@sirena.org.uk>

On Wed, Feb 14, 2024 at 01:55:43PM +0000, Mark Brown wrote:
> On Wed, Feb 14, 2024 at 02:43:48PM +0100, Jiri Kosina wrote:
> > On Wed, 14 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > > +No CVEs will be automatically assigned for unfixed security issues in
> > > +the Linux kernel; assignment will only automatically happen after a fix
> > > +is available and applied to a stable kernel tree, and it will be tracked
> > > +that way by the git commit id of the original fix. 
> 
> > I think this needs way more clarification .. how exactly is this going to 
> > work?
> 
> > Do I read this correctly that *everything* that lands in -stable will 
> > automatically get CVE assigned? If so, that's just plain crazy. Just took 
> > a random peek on the topmost -stable changelog ...
> 
> > 	ASoC: codecs: wsa883x: fix PA volume control
> > 	ASoC: codecs: lpass-wsa-macro: fix compander volume hack
> > 	ASoC: codecs: wcd938x: fix headphones volume controls
> > 	ASoC: qcom: sc8280xp: limit speaker volumes
> > 	drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'
> 
> > Only the last one can *potentially* be considered a CVE candidate, but 
> > someone would actually have to take a *deep* look. Most likely it'll be a 
> > functional issue, but not a security issue by any measures.
> 
> Not addressing your point in general but the speaker volume limiting is
> security relevant, that change prevents physical damage to the system.
> There's an argument for many headphone volume related fixes too since
> excessively large volumes can cause substantial distress and potential
> injury to users (I can't remember if that fix would be relevant to that
> issue).

And this points to the fact that we now have a way, if a
maintainer/developer says "hey, that commit could be a potential issue,
I want to call that out to others!" they now have a path to do so.  Just
email cve@kernel.org "can you assign a cve to git id XXXX because of
YYY" and we will do so.

thanks!

greg k-h

