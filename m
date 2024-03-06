Return-Path: <linux-kernel+bounces-93525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDF873100
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F25B1F215A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E18B5D8FA;
	Wed,  6 Mar 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sztOnIMO";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="D5L7Jh0O"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2C1426B;
	Wed,  6 Mar 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714601; cv=none; b=JgEPL15835YKQETihYfNPhmEf9CxYRgDSIxlMOhwQIKHcZJL5nPK/Z3mhI8u4wk6tqDRSHCt/Tchxv0vsaTEnFkG8SnHggKJ46MbfvB2pgngnumeCvgn68sxOhmT0aZ0wzfKMbtsae8OMmYhN7uop5HvbF72NeEU7Oafn73pOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714601; c=relaxed/simple;
	bh=DyWyagf9mc/WW7PnSp7IWwZZYy1CsYm6GCvAj6tU1Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En56v6uwUhB9+/d/EpXDMfJG8pn/fPXaMlJEIUBALFmWlzgqcKu6rSdOnRHxrhUo4BogxVl3YvzXw3K/dKFECG1gRjN2zQTNN7eNCnef1RuczyfQ0iCsBY475jTHv3JUzYyaLoE+GLV9HviipBu4P5qCXLgelVqDhnmLXoHS4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sztOnIMO; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=D5L7Jh0O; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 42A85C023; Wed,  6 Mar 2024 09:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709714596; bh=u7xwVzE312BMKemiCxLar67jyUSufOvBkEGyMQYoFLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sztOnIMOlGYbekTPAYzejpv0by2HxruhYv242jrzHPap2uH10XtvWHZz6C1A3O3nS
	 0SR527hJDnc27jsWIE4CGxtjNpQU6zgR4wRnb2GQcOjQW965hAAep3NU/IFkL/N/4K
	 XNCJnGfde4rIu88SIrhFLPYMouGECWYbxZQi6zNUQUhDsJswPvG8uMWQhMEos3bBfE
	 ZmZAUOqwLSvRK89ayRcnRiYzvswVnwPtF+B9jpbaJQd6BP4LRlfPvH2b0uF6LVzn9M
	 99cQEvJv7TPVanjfBx3NTQ72E54YH9EoGgd4Dxybf1an5etG7pvD2JD47Z5FfA2WAs
	 KnLiazP3XyWBw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 423B6C009;
	Wed,  6 Mar 2024 09:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709714595; bh=u7xwVzE312BMKemiCxLar67jyUSufOvBkEGyMQYoFLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5L7Jh0OivVaFdtZJGoBrq6rNaqnVu/7vonC2N4M7G/vmMK7awNVRKjUey1Iqd9DP
	 66+tiSoz9VNGPwEXg2jm0/P5dAmGpbehirZbcn3eu/krocTdASW1LhiGTd+MQ+UvNk
	 TT8b3HJqFHAE8fdxnl11VzFM6WKSZ3HSFR17Wxgam8zrvFIqHR5KzF5i7dTlvh9p0K
	 FdEEIL8J7/SQtMVxqDAClkdR0WwKQjQuWZDaoCR19j78t7oySuLhp/VmMNTG2yod8O
	 utbguK5dYq9HY4RSsHeol5rYvyOxEcpOW3EzTVdQkTvOWVvBYzOqPIvzfl/8PgJO7a
	 YjBNf97EpkGig==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id afc6919a;
	Wed, 6 Mar 2024 08:43:05 +0000 (UTC)
Date: Wed, 6 Mar 2024 17:42:50 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/41] 5.10.212-rc2 review
Message-ID: <ZegsihJukpyoyTek@codewreck.org>
References: <20240305113119.020328586@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305113119.020328586@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Mar 05, 2024 at 11:31:49AM +0000:
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:31:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 713b6af903ad ("Linux 5.10.212-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


(For the wlan problem I described in reply to rc1, I've confirmed it's
not new, just one in a few hundred boots rare; will be fun to
investigate...)
-- 
Dominique

