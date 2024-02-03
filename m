Return-Path: <linux-kernel+bounces-51166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84250848744
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B9C1F23B5A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC35F873;
	Sat,  3 Feb 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="odsXjTsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F35F843;
	Sat,  3 Feb 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975858; cv=none; b=qqvuXb134Tre7hXd92Gw8iYVyio2+2wwKuOqlJXThMMKTLpqzGNFzxaLarKUcJVedvpyxzSFW7anzZrSWw/HY3U+KoW9x01bpqZHOSp9Qu70g62c3cAgd70WGy0TU/qK0eREhDLDwvMufKRsE+zlekKluh1Krqoqgghlw8PfmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975858; c=relaxed/simple;
	bh=D40pyaNNvZZ8eA7vzQ6T2LLCMJMmMwUSeijow9n4iIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDt5kre7QKs33zRocs+V4FQCCprmjS0Epoh628yt7IsFAKJGD8DxqaOuCzzih9RjUVrHzwRHxIq+Po6yacO8cIjIxeRVohD4Hj59cYtZy5Dxzvi66J/WdiDwH+3uUn/Dg9ZC1aumVwmp5gIfNiKAUzf8b/NnZ4vEc0m4d0uIBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=odsXjTsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F0EC43394;
	Sat,  3 Feb 2024 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975858;
	bh=D40pyaNNvZZ8eA7vzQ6T2LLCMJMmMwUSeijow9n4iIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odsXjTsNRXi454GD+tcryE6Vjhmv/tGEbPKbmUfXO036VBQiMjxolGuKNRny31La9
	 nU8gqo59Gr3iYlKoAVJUE0Dhp8qgYI2AuNKl59zZQrigD99dYDhGSAe5cpE/zr3d68
	 lQWRJXvgYkbCOtVqrSd/Jay1xX4lPeUmHt7sVQew=
Date: Sat, 3 Feb 2024 07:42:06 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
Message-ID: <2024020357-morality-wifi-b331@gregkh>
References: <20240203035403.657508530@linuxfoundation.org>
 <9fa210ec-1086-615e-b972-f28a74df7b49@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fa210ec-1086-615e-b972-f28a74df7b49@applied-asynchrony.com>

On Sat, Feb 03, 2024 at 11:18:16AM +0100, Holger Hoffstätte wrote:
> On 2024-02-03 05:01, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.7.4 release.
> > There are 353 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> On my Zen2-based Thinkpad I now get the trace below on boot; this never
> happened before. The boot continues and the system seems usable.
> 
> It's out-of-order because apparently there's a workqueue involved,
> but most of the information points to the patch called
> "xhci-fix-possible-null-pointer-deref-during-xhci-urb.patch".

Will drop this now, thanks!

greg k-h

