Return-Path: <linux-kernel+bounces-157755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6818B155F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AECF28308C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515B157A70;
	Wed, 24 Apr 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSqcKRxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854A2B9C9;
	Wed, 24 Apr 2024 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995700; cv=none; b=uS39PsbhO3etYtgUvqqz/uxdFZEcuPbpP9QCXLCSwXbEv9B+BYEICH62eo+QSiGXCHf8J0aCAoJBzn5TW83Uj6F/lNmMW2T3MH2Pldm0vwdZwRbpYXBfu1lLmuyX4QOPKw0GM/BjuKKOAUQbrI84gGG6ynh8D5q7ArxXTfLYFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995700; c=relaxed/simple;
	bh=wKg8z1iS1q3WlH+t61PUrgDi6z87hCpISUOPX2OOyJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNDmJ5/NVgIO3WrbIP0l4l5gYI6rMt4t7AreF6TuhC2UpfK/vdWhHdo0oeA7K/zzejgf4GZxYE6XtJZoFQRLoX9VPGHTBH6gvrKNGQhStshhI0PGyPyIq9cszfUIeU5vChwlxxawKf6k6UDda7hjSkSZQyUx0RR+t7ecKoVIkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSqcKRxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60563C113CD;
	Wed, 24 Apr 2024 21:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713995699;
	bh=wKg8z1iS1q3WlH+t61PUrgDi6z87hCpISUOPX2OOyJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSqcKRxVDglG3ZDx/QqvW49CguxHg3nhkvJSvc7RfVamxtCiDEhbN9bBI1grIcZvb
	 LaKFWh1ihYP6koL1jN+3wVKqszJgqZvotEyqIrdRzRkyOCFQjVHVP6T4KJO7vWknjc
	 DKOjiqY7KiDcIb9rsPeA8p1q3YsXRMgwv9Lp0gLw=
Date: Wed, 24 Apr 2024 14:54:42 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
Message-ID: <2024042435-prior-exfoliate-59ca@gregkh>
References: <20240423213855.696477232@linuxfoundation.org>
 <ZikNwksfty_Y_dhi@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZikNwksfty_Y_dhi@finisterre.sirena.org.uk>

On Wed, Apr 24, 2024 at 10:48:50PM +0900, Mark Brown wrote:
> On Tue, Apr 23, 2024 at 02:37:17PM -0700, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.29 release.
> > There are 158 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> This and all the other -rcs break the build of the arm64 selftests due
> to this:
> 
> > Oleg Nesterov <oleg@redhat.com>
> >     selftests/timers/posix_timers: Reimplement check_timer_distribution()
> 
> which was identified as breaking in -next and fixed with 16767502aa990c
> ("selftests: kselftest: Fix build failure with NOLIBC").

THanks, now queued up.

greg k-h

