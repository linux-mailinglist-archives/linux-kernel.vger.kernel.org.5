Return-Path: <linux-kernel+bounces-35757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A649839610
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7A1C23EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85A7FBB8;
	Tue, 23 Jan 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBWw90jb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136B5F845;
	Tue, 23 Jan 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029993; cv=none; b=uBH3KkZU+Jftv6/GNXGkjxCNm8VlcUOjdpL0A/CAcFV2m6CvtZLsjJeUTNYC+8sjp0/HL4YTV+Zaaq7FsROUGE9O0a8AAdNknCtk+YXQyTdJAR4iGupIvBTAYvyALMwCjt1CVVDDPYD0lngiE0A6/qZxeLawbgFTNfvzKvnsB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029993; c=relaxed/simple;
	bh=Xjxxwo97OkceC6n83UJzqEpt+lwD2L3ZNHvo0XwofWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP4Vnb+vhKubVAaFU2Mr/g5E90rBaZGCYD1vqTRX3Kia/F/P0tzyazXIJaoU23z2q8h5WxLTCNlYyDFy6XwBvUdKeqkS1qgxVaE1KVrTNILkMCajbb1Py/zGGMxczsQJyMy/FV4Hn/rZHzTVii9SPa6lnCrddiTsBN+NHidig54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBWw90jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC66C433F1;
	Tue, 23 Jan 2024 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706029992;
	bh=Xjxxwo97OkceC6n83UJzqEpt+lwD2L3ZNHvo0XwofWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBWw90jb/wZKUpZ53h0HG+2RJfw8HsPg0YEnPI4Y8gMWihoqcg9yefGC0Rx9CjUcZ
	 YmdPaxTEBl1Bt9NPddQvebM+6mYyP37BHbBlfZYx1j35z+lefFpSGb5+LlHgOqdioN
	 WXPbNXwJk403D8WqxhHIYUER1yN0v8A0j4CTfvP8=
Date: Tue, 23 Jan 2024 09:13:05 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/374] 5.15.148-rc1 review
Message-ID: <2024012303-ellipse-playing-795d@gregkh>
References: <20240122235744.598274724@linuxfoundation.org>
 <29eb6dc6-8fdf-48b6-8f60-1162da175b7c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29eb6dc6-8fdf-48b6-8f60-1162da175b7c@nvidia.com>

On Tue, Jan 23, 2024 at 03:35:24PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 22/01/2024 23:54, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.148 release.
> > There are 374 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> ...
> > Douglas Anderson <dianders@chromium.org>
> >      r8152: Choose our USB config with choose_configuration() rather than probe()
> 
> 
> The above commit is causing a boot regression on the Tegra210 Jetson TX1
> board and reverting this commit fixes it. This also happens with
> linux-6.1.y, linux-6.6.y and linux-6.7.y. I am not seeing this on the
> mainline.

Ok, thanks for letting us know, I was a bit "worried" about these
changes, so I'll back them out and push out new -rc releases.   If the
ChromeOS developers want them backported, I'll let them provide a
working series.

thanks!

greg k-h

