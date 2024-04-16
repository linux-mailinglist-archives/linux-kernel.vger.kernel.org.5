Return-Path: <linux-kernel+bounces-147054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BC8A6ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C091C2089A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2DF12FB07;
	Tue, 16 Apr 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U14TzebB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238612E1D3;
	Tue, 16 Apr 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278808; cv=none; b=iQSoCiOPzOYoEXfYOx+hSKIKUfhEnq/aM7LA5frwnVE3t3JIVnQpa+vfM3vy+dfJHpiO0yElDJLmKDF4kXoDCssTmbryuiued7OmMLTHwqiPM9dzD9HBANrWDODSeh2ej00qKlzOmfiQlbfNQaXkGHZuYf0svgPli1edRNpoYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278808; c=relaxed/simple;
	bh=s1wsWduYDqv05kVoGZ8o/W0Re4M928FY9n0RIrMDsAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jku8Z6x73bEsdcyKTZpEQvZm/86CacPg9qQVPK7ArQAlovh0vGALzEKbbAbGJ2wfPVHh9uk8mT+wg6AKFxVJrjRC86QoTvwp25TEYm8no111vNLF9/mgTM+wDOzc6nFWAJ6A7i0tmx/GjoYcJX2IUs0IDuCJDzeQU4cMgL8y7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U14TzebB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5BFC2BD10;
	Tue, 16 Apr 2024 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713278808;
	bh=s1wsWduYDqv05kVoGZ8o/W0Re4M928FY9n0RIrMDsAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U14TzebBmfTne1ehQMVP9Z2dPS78m0HGTEfCP612tqdwG34VJwDu0hnYhoUEepEgI
	 go5xbgywViqnoLfg24/azsnOAstHnSMo494YJTFMuUt4GAn77jFz4kWCa9hut3PT6A
	 fyVSqc3cWRpDFqUE7yGyCioMGRImgI6+IF+Ya6ek=
Date: Tue, 16 Apr 2024 16:46:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 00/45] 5.15.156-rc1 review
Message-ID: <2024041612-bacterium-scratch-22ea@gregkh>
References: <20240415141942.235939111@linuxfoundation.org>
 <f4a899db-1d5e-49bb-a92a-737ada549f9b@hardfalcon.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a899db-1d5e-49bb-a92a-737ada549f9b@hardfalcon.net>

On Tue, Apr 16, 2024 at 04:30:14PM +0200, Pascal Ernster wrote:
> [2024-04-15 16:21] Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 5.15.156 release.
> > There are 45 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.156-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Hi, 5.15.156-rc1 is running fine on a Netgear GS108T v3 (the SoC is a
> Realtek RTL8380M, which has a MIPS 4KEc core).

Note, if you respond with a "Tested-by:" type line, my tools will pick
it up and add it to the final version commit in the tree when it is
made, if you want.

thanks,

greg k-h

