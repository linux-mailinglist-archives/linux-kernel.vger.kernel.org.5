Return-Path: <linux-kernel+bounces-77621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92126860829
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAFC284EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63EAD4C;
	Fri, 23 Feb 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ASjsbioP"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9570C9463;
	Fri, 23 Feb 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651408; cv=none; b=YnMGbO+XLDwtcT4O0TrsaV8i5F5Q8Qurm2J0AyeaR+163OxtVrmTAU4sSSmx39n1w8Orru7IqKUqNzpPAmG5WqZOQYJkQhGuxEbyIvGvfVGFNFmAnM+NEiNkZtUen6PF9VgaVBEEcQ01AWnkNEji+YaMU9QccqlhXN0o36X1YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651408; c=relaxed/simple;
	bh=SUUpIIte2ZD7VnH5l11svZT3xq3NROveSwktGYQL4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsNNdZYnXdPILiJzpxmDwf6bDHPTNZNfojNGcJwsBbHPAcNYb0SpifWS+YjXH4nFcxuUhI44CWYNa5nUHNYaXGfWCZJSuPTLnnifNKa8fKzUbeqESWH4dMuVZWOI094bsboMnHynOjip7RmipA6m0hwpIsfq4G7fvNXIvBtw1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ASjsbioP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 6CABE20B74C0; Thu, 22 Feb 2024 17:23:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CABE20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708651401;
	bh=ILrrptC9k4HW2A4LXpN+gbGrs18rprBg0YMczIEyTCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASjsbioPInIrPZSY0XPT/NVJf6UcgnfXUz3T6qw1BSuza92AKg1bzp6GsgMYNyNBV
	 E1lxu7ULfbVVX7dSYgMNQHcSzREjhMi5L0yy8GztM0oo9fDmwTosJe4/gqxgB0LiTZ
	 Ab2umsPbTt6C27YkRYuV9XmlnNErRlYUnUGd8heE=
Date: Thu, 22 Feb 2024 17:23:21 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
Message-ID: <20240223012321.GA20295@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240221130223.073542172@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 02:03:19PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

