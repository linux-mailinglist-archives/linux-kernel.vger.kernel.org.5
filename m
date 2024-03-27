Return-Path: <linux-kernel+bounces-120185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9E88D3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DD71F34B42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654CB1D530;
	Wed, 27 Mar 2024 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CimFlNhZ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75418C36;
	Wed, 27 Mar 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504224; cv=none; b=KR2ZZBbccUhd0zPzYG43WNYTL6VFfsfxGaNUIIDXq/VBCH7BhfMXZnfjIqKpqHWUl/K86VjWrhtUbfyemJpKTzX9zemuLjNu/f8USNRA9XIaOGBMgrvdqeNukSWbxVC0S5YWrtkoRIuSRedzIY3YtgQNd3YcMYapvlAAuvO6e9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504224; c=relaxed/simple;
	bh=1shEOPXfw/1FS1izIYCMAU0x1rXYrFMbBdkFhyNHPjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cojJJY75y6R4oHa4Y1ETQiK6VkjmyOrj47OJSuzeNZMr7De+qa+bFVLaPk7wXjfbfZITzdnu79amEvoro6KZDOhEc2ZJChll/AmKN+MU6cfWDvNPGlUzzQjS4osW8YPISln5w8XNy0S4I3e9YUtdkzacqj+f4RprcsXmJ1utpxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CimFlNhZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 3ABD22084420; Tue, 26 Mar 2024 18:50:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3ABD22084420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711504223;
	bh=i4ded9Y4ODDhouO9GhkDNxtb/iwxw1nLCSE3/aswxZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CimFlNhZxEfVA2tboqYQCWIdHVzdxCKbsPsaq4cJTMubQRYu7PDCkVOuaOk1eq7fL
	 lEcsSrn3d9QKCSlHkh2qC0ZDzUPHaZ92qxgOucYOR3jSm7G3C0OK39b6KHc/b8yR1l
	 brNTHfcS07I792fnOOLO7yUopAQqGtkakU61nQFE=
Date: Tue, 26 Mar 2024 18:50:23 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
Message-ID: <20240327015023.GC7502@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240325115928.1765766-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 25, 2024 at 07:59:28AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
> 
 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com>

