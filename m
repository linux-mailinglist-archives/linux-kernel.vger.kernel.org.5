Return-Path: <linux-kernel+bounces-146024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5C8A5EED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729CCB21695
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223515A489;
	Mon, 15 Apr 2024 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IcxTo69K"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D7159591;
	Mon, 15 Apr 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225238; cv=none; b=o7jgWMsi1YdSf4rh1CyhT2fA33af1Llp7w/E/p0ij0hdNV+iMPQWmPPsGSmCggQZXHFkm3Tn11XD3uHuSiST9S1zBumkVn66TLhMblvDMz2oVqEqFkdIG2wrMycQikAIA6sT1NAo9m19QK4/bDAy2QH6boailPSpZ316wDuiEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225238; c=relaxed/simple;
	bh=YKNEpGupa/ZCSJsDLL1o2LJI5zl6TmROX7E4YZp3jik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzySW7vPkgm5noRkwBw1H4nvQhTroLE0Uvr48DUpUuRrnCt9HSvqsThvUddh2i5ff03iyxL7SZDQG1aO8n6rhZWjyjGi2PVimBia9G5tpGUcL3ii9wzmGnDUXQpIhoJVNonmvq7s243cg8yDMOUDZ4TbAxvIdY4utqRiVUrEhd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IcxTo69K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id DA37320FCF9D; Mon, 15 Apr 2024 16:53:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA37320FCF9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713225236;
	bh=9diPs8M1wQaux+oG7SdA4XNjDZE0S/hE1fFt6vAwrYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcxTo69KhDUB8EV6N417ddlhfoFhk0pgMzJFFUxcyYcS+p9xgoBX/EQaYW4NPjC24
	 P3OfQAnbbot9GxT515fePN7CXrp2UTT+sD9elaPg3tNLDpDZn0Til9Tohbqod2YuV2
	 ZbNDWgHw4oU1ZukKHCvpcIpen1taecSo4ijLyQBk=
Date: Mon, 15 Apr 2024 16:53:56 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 00/45] 5.15.156-rc1 review
Message-ID: <20240415235356.GC11121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240415141942.235939111@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 15, 2024 at 04:21:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.156 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

