Return-Path: <linux-kernel+bounces-40463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B628483E0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C0B1F2594D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC5208A2;
	Fri, 26 Jan 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ph9WnwmX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748B200A6;
	Fri, 26 Jan 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291496; cv=none; b=nd0df51tMxmwo1FCaohOtTx/xBuruOwb9l0XmXrmvE2yql1RTgFFn8JYz3iY6BYinaTxcC/Q1ze04Kdek3OOqzuN2Sx8Yf21LhX6hblzN12sxxcH4dnpOBP4P+826oxU68essS1vkGddxb+yz6UM5+/Ja+FoYau5L7aNbOkdNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291496; c=relaxed/simple;
	bh=LYvMUputdwdvP/aIsl4R2ghGE0eEPA6qkCmbDEfZC68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8VdHMVU5S9ENxwf+QlQod6ZmsHLJ+hRnjCMDOBcCdCDHIB4FINmbV6fX2G5j9SpD8cRuuEmrs8VKgBCYdhJETX2bYCCIMhyH9xviLthrEhez60WOlQSJOKNjm5hQTfMhOvHgzTN1UMOSzX3lkznMX8QCzg8pJJFgZLNmpn042Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ph9WnwmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDF7C433C7;
	Fri, 26 Jan 2024 17:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706291495;
	bh=LYvMUputdwdvP/aIsl4R2ghGE0eEPA6qkCmbDEfZC68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ph9WnwmXolCDd5LJFKynGbbuCHGspzhxwGRaY1Tif8kom1Mgt+WcTlyAnT6xkEpup
	 D2/XJF7j1fOHip0mvVC9CcfJSEq5P1jbdNWdg4ksbB9NSy7P3r1gArYpYwyAI1ZonB
	 kGbwGILGFGDHMW2FAoYf8xV0gX1ZGitDphrgeJv0=
Date: Fri, 26 Jan 2024 09:51:34 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <2024012636-clubbed-radial-1997@gregkh>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>

On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
> On 1/22/24 15:55, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.209 release.
> > There are 286 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> 
> > zhenwei pi <pizhenwei@bytedance.com>
> >      virtio-crypto: implement RSA algorithm
> > 
> 
> Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
> It is quite beyond a bug fix. Also, unless I am really missing something,
> the series (or at least this patch) was not applied to v5.15.y, so we now
> have functionality in v5.10.y which is not in v5.15.y.

See the commit text, it was a dependency of a later fix and documented
as such.

Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
gladly accepted :)

thanks,

greg k-h

