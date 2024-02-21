Return-Path: <linux-kernel+bounces-74754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084685D8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3E5B214B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A969D09;
	Wed, 21 Feb 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s92/mDN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AE29AB;
	Wed, 21 Feb 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520879; cv=none; b=hjnFGG/OdwgsC0U8rnmdIvyGHrFsyofMWkIbn3FuuHWM1GuZ+W/ypLue+CG+MdWAdSmUKnTF2+0FxRntDAhuQB40Ht3/7A5IQ8LW0it3vOlSAoeZbkeV6BgP/izY19l9gIFcstu+qD2LUgn2imbngKhmmatjsmIE8OGbnf2Llz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520879; c=relaxed/simple;
	bh=7ExkksBPK+mQaI2810aWKVFf5/cXXYe8R3b49O1Z1Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjRIvDXCJdcOOwoo1I23PR6qUhm1ZZDC5Px09iPIRz87vDBd7cjQcgvpkr/dh26PAAw+TIjjxWHb7PQQ3ERb3QVws3JCVd5gmpUFVF6zW3PPfuDNPkrKgoyHPYTssSrmUcslaol2C9ImJfDTQGYhicdOVDePaXTLjuiHCDLTWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s92/mDN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266D1C433C7;
	Wed, 21 Feb 2024 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708520878;
	bh=7ExkksBPK+mQaI2810aWKVFf5/cXXYe8R3b49O1Z1Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s92/mDN039RWwaPp68GlRz9VI0Ngl2a9aSctuj4SlcRun1xy03sYMHB2aeipSAWeB
	 LIOVR1iqF+Az5W/Y2j76meVmiFbJZGBXlHJIp8PNe9n0jWIE+rQ9v7Axes2tvfRa8k
	 NQsNEwkS+xno1QR5KkV1V+7AFP2l52xq+TNv+bAE=
Date: Wed, 21 Feb 2024 14:07:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc1 review
Message-ID: <2024022140-arbitrate-freefall-81c3@gregkh>
References: <20240221125936.478639123@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125936.478639123@linuxfoundation.org>

On Wed, Feb 21, 2024 at 01:58:04PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

Oops, nope, this should have been -rc2, will fix that up and resend,
sorry for the noise.

greg k-h

