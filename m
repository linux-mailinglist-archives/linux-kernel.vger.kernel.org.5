Return-Path: <linux-kernel+bounces-36213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC0839D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5DD1F27E09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18BFA3D;
	Wed, 24 Jan 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j475eZk9"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC115A5;
	Wed, 24 Jan 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055583; cv=none; b=VEZOwKJ01R/O2/KzWFSA9t0UaOcE32p2ewzsODgblIbJE4jRU2ES5e9W8U0SGAaYHEMq5PBHvSMheFZwzx33Oag1EFpQDSzuN5+EsHwRxO0Vkbgb8xYbEN9npBGARoypwNTbBou2L9jtmkWK3fBReNCK/VTNsdGJa3OO+ZJHrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055583; c=relaxed/simple;
	bh=RVzLzGa13JUWspmKQnmqhYumD1HwcORCf04C8wDU7XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm0fEh8RF35xAheXNICNHfX6pBPq47GNAtyNY8/6Nc6hyvNgEj6h6PXjcpJ4JArU8GtJ716drhXsm/KEL32s2DfquZ+3nWIFADmRcMTBrIWN2aBDZK+gLpz30N6pBiR+SYf+gYhCJxlsVmCgZCa0xfzt9g6543fgF1pO2S/gEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j475eZk9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 37CBB20E34D0; Tue, 23 Jan 2024 16:19:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37CBB20E34D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706055581;
	bh=LcuPl/gpJOHyUKQbldFKG4ijednIRR72EjOD0pLxyiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j475eZk95byHJg5TwvCIGM4NEk5a9+Qnryz50GnuPl1CJa3pYrqA8zDO7TDYbtROy
	 GSKB0hbGWaTt7Z2HZtj4fnCNDQ+mYsB4dVOnJztLHMPatOLMjyURowqLznNEjzHnJK
	 c/k4D1mSeBJ7iojtljcFIkmPYS15jqUemuwC09Tc=
Date: Tue, 23 Jan 2024 16:19:41 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
Message-ID: <20240124001941.GA24616@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240123174510.372863442@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 23, 2024 at 09:47:46AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

