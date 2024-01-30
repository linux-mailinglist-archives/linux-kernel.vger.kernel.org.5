Return-Path: <linux-kernel+bounces-45396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C5842FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325931F24700
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6B14AAA;
	Tue, 30 Jan 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Yf0nWzS7"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78357BAE9;
	Tue, 30 Jan 2024 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653660; cv=none; b=Zq42yn41+m13CFPVqy6iiGXVnV5/StpsuqHTF4daELq9MLq5R+ZSUYOlFnwi4EvfcYQlIF6yi2Nptlau5eqmHTMQjko2BiyHubZSPgxVXl+kNA/GEMuCUAdwfO7ihvWUGEbWNsNfLsvJiA2B0u+KB0iBNMB8uc2NmBa8ynfT3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653660; c=relaxed/simple;
	bh=odsSJ8S5NvyFn0jzm7lpFj3fwWCNQzRHikQo4nA/s9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyvxyTIsdFWqNJo4egLTAOpFYNjjFiZjrwkLK6liozKnLsffQZ/SIMt7t5HaG534uIwzzxWDx/RO5477Dsf3gKBi/hKgb3hWanZSjtcZtcDT6rXM8GS/RsLrFba5c8dEe7dldHNPgJTx6NNUrUUVqN7/ox7UhWZM2k/Vwld9iFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Yf0nWzS7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 759562057C0C; Tue, 30 Jan 2024 14:27:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 759562057C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706653658;
	bh=IhmYcp0Wl8WZQP/UXfniR1imHq1HIZ5hrN7R5uXfAL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yf0nWzS7bf9htQWKkZyl/ESjXAJ8z5Q1Y3PAJVc1unrzmlmIprbCpi/TxESii3seQ
	 SsQLq7cFJqOQYnG9iiHYpWBERAD0pYjXesIyiYNQsp6rdTjXKIg1oOBNj0kpoKsyDv
	 INrCgC9aLyjr9V31ufL+HbJzBSced6Y/1mGvxdHU=
Date: Tue, 30 Jan 2024 14:27:38 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/186] 6.1.76-rc2 review
Message-ID: <20240130222738.GB14930@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240130183318.454044155@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130183318.454044155@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 30, 2024 at 10:47:38AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Feb 2024 18:32:32 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you.

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

