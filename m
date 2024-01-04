Return-Path: <linux-kernel+bounces-16153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A338239BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21EE1C24AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624CA7F6;
	Thu,  4 Jan 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ypR1iSDn";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Xii5xfrp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E618EC3;
	Thu,  4 Jan 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id F2511C01C; Thu,  4 Jan 2024 01:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704328849; bh=EvHaKmz8eam6ki0dCTTWgEw9z5+VdjhYEvVWokrATN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ypR1iSDnCUYKtMVNL4FtjTR7zvQXtHkHT41oGHnjD1I1ODaNVLdJWHK5hQHXGAb+o
	 UO/aaIkDNjuJ6D4sdH01GlJocNjKoLxqzdDVpY4O4EqhREECqREMyqd1Zuf7/jtbcs
	 Xf9RZ0noNpCtwplwJ8rocy8ykh+9Q2dqMhc56R4N0uWCiSCD2Amh1urmDd27+nG91s
	 kx5Wa7qOsjRW1EyAOrZwNL6zF5R0PQDNejR2wLLbi68C28kKJlGQqexQ93gSIBp1is
	 6tmHR4MaJXmt9GocdYaMu+PPqx1UzqKNaPwFFTezXl4tu6m6Y143FAq7/3KfUUe6lI
	 HTTzvoD7RE9lQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id BB493C009;
	Thu,  4 Jan 2024 01:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704328848; bh=EvHaKmz8eam6ki0dCTTWgEw9z5+VdjhYEvVWokrATN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xii5xfrpRa3v7n+jTer6FeFz6xNJxfBuJDcGa8R3Bj1hVzmLYnPdVrOT9x2TgWgfA
	 e3/bnUeT28n80FqCU+atrxltsannNE6pijkE1g2bOx19SDHqcQEuD4CFfWRYD/SBjN
	 HT/8QapeUTO74TQObye2bRSDsX5JcJBZ7t6sS+wap4KMVwWWnPN5+u1ijOSsuh2E7p
	 HgoEV7xMA7LOLQptr/cH6yABXQCbPI9wk5MYzAvPLWKd+46+tl+RTTiltt6pMP3ZAx
	 crDJTmq4OJM7m5rydzDOWO6ArPvy78/8d5x5Li7V5PS2akkZl9khDQzZYNhoGiU2Wa
	 N4zhPQlNcGj0A==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id b55ae3ed;
	Thu, 4 Jan 2024 00:40:40 +0000 (UTC)
Date: Thu, 4 Jan 2024 09:40:25 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/75] 5.10.206-rc1 review
Message-ID: <ZZX-eRRSZbv1qmcP@codewreck.org>
References: <20240103164842.953224409@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>

Greg Kroah-Hartman wrote on Wed, Jan 03, 2024 at 05:54:41PM +0100:
> This is the start of the stable review cycle for the 5.10.206 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.206-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 6ed2e58a1d40 ("Linux 5.10.206-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


-- 
Dominique Martinet | Asmadeus

