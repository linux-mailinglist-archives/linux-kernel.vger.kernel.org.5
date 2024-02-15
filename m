Return-Path: <linux-kernel+bounces-66853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613118562EA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66033B2DE37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32212B171;
	Thu, 15 Feb 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lm/I/tjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59312C7E0;
	Thu, 15 Feb 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998435; cv=none; b=sZkd+9RObX//8UtsZqLfyQKGeaNLYO203NLfM7zUp9z2bpTvvb/d+3Gv3WCaMTkOrOd0wkY1rwxOQhstg0DrwbS6H8znfapmHwvbZCYVR13dHc6GecTX6+Sr295FJSbVXQIpcS/vVK9nmMHYsZJ/I9NQD418WX51ri8TGG/yapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998435; c=relaxed/simple;
	bh=B9sdvAQJJMB9RqXnzsjqng2GlNXXY0IjB5e/gLIb84g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RECf7VcbW63bBf0ptgNT/iYOy5ZbTBNCkrPc07BsiD/XVHs8eq4+8eCEvpCg/Ky8mUL4d6IMkkcOwZJMuHCFfQ2m3VFguZj8rmZJIg/exrizJWWqTb6fYtneCxhiATIMZMS/TWA5O5l8KBGJl861KrZdNWlnmjMBE5JSjvNdE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lm/I/tjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E33C433C7;
	Thu, 15 Feb 2024 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707998435;
	bh=B9sdvAQJJMB9RqXnzsjqng2GlNXXY0IjB5e/gLIb84g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm/I/tjduKHW171pZMH4vmsQ7SkG3vN/LLAqalkve2CsJjDZJfB8lDbf1RlrAnzBO
	 xyytx78IV/+uDC2pH2+BZXCg7p+hRSPHzWCacxiUq+awYHlDbVpPVStMoPo+eu1uQ6
	 kxzmZLJaobEYjtK7+HzFgdc3p/bIZS4V/dcA91Qw=
Date: Thu, 15 Feb 2024 13:00:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021524-profanity-relearn-38d2@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <75f89fc2-4b43-4311-bc84-03738dead5cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f89fc2-4b43-4311-bc84-03738dead5cc@kernel.org>

On Wed, Feb 14, 2024 at 02:10:07PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2024 09:00, Greg Kroah-Hartman wrote:
> > The Linux kernel project now has the ability to assign CVEs to fixed
> > issues, so document the process and how individual developers can get a
> > CVE if one is not automatically assigned for their fixes.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > v3: fix up wording in security-bugs.rst based on the changes to the cve
> >     assignment process from v1, thanks to a private reviewer for
> >     pointing that out.
> > v2: Grammer fixes based on review from Randy
> >     Updated paragraph about how CVE identifiers will be assigned
> >     (automatically when added to stable trees, or ask us for one
> >     directly before that happens if so desired)
> > 
> >  Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
> >  Documentation/process/index.rst         |   1 +
> >  Documentation/process/security-bugs.rst |   5 +-
> 
> Great direction! Finally all these bugs we are fixing every release
> (thus in stable trees) will get proper attention via assigned CVEs.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for the review!

greg k-h

