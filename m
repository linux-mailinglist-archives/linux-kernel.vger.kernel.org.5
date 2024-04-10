Return-Path: <linux-kernel+bounces-137859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123389E859
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAFF1C226B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDE8F62;
	Wed, 10 Apr 2024 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/qjir1e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4646B5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712718541; cv=none; b=cO3bDGMy4NjABZxt819OZavfS60WXp7T+OWh35eg/7DUXGe3O8l69WNmB2ptwrdtSSU+QV9ukhWvYeyiA4qXob5yqDw2rQ9vj/LhHKTiYruDzpVhsAo+isXdTIcgzCpPsna0sNSCAh6n8RsjqJwJfmnAVWFo5VQf/QNfPX9x3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712718541; c=relaxed/simple;
	bh=EM7nowdjdbNVWh8bciK9Ha2EeZjxwFBLgso2R6SZNRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMwX5I1yYSnh/KRVrzjBzK1Cl+gbW6O78YdWgQcmO61hs/9Rbifai9IXxZiUAppbTlt5DH1Ao3H3n/58IaGV5pWUe0e3LqqeEVAvN01rJIwk7Bu/LeBrU7JXTDtCwJ41juSVt9PrckDg3WanzYUN7cy9h/q0IjlMxVLQVQL1B30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/qjir1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96534C433F1;
	Wed, 10 Apr 2024 03:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712718540;
	bh=EM7nowdjdbNVWh8bciK9Ha2EeZjxwFBLgso2R6SZNRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/qjir1eLQpUmzvGiwsCTcuX7poh7q1n53pOsndQLCaN8N08FgGHZcHyWtnwJiTDk
	 tdhP1pdvZXueZIu/RWYU1GQerDJdaFwLNP+mrwEQU0ShPPRvc+XwEj0gPfNdKGX6eV
	 7Oa5rqAbGBrMGnEAqhQr7WgS6E7UQ9BPehhk4pMig6+WpuzBZitbu68SXwBdF1YIQt
	 PpKBGmlQsvxl5fKqKMHy0/A07G4tsGhk7ytmAT3um1HUHkpOhW4wmNPjgIGV2TWIor
	 469kgbwXHWwsXVrU3rxum8qXLWfV9YQ9x+vO6TYzbQ0dhd06mtbwJl4liAzvPTHcwJ
	 XzEx46LDJ1y/w==
Date: Tue, 9 Apr 2024 21:08:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Holger Huo <holgerhuo@outlook.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Holger Huo <i@holger.one>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Message-ID: <ZhYCyuP6vTJq-TZq@kbusch-mbp.dhcp.thefacebook.com>
References: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
 <ZhWhshq7hpPd9XrI@kbusch-mbp.dhcp.thefacebook.com>
 <ME3P282MB2481C1DC0506D154FA3AA3D2B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ME3P282MB2481C1DC0506D154FA3AA3D2B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>

On Wed, Apr 10, 2024 at 10:05:46AM +0800, Holger Huo wrote:
> On Wednesday, April 10, 2024 4:14:42 AM +08 Keith Busch wrote:
> > On Wed, Apr 10, 2024 at 03:28:50AM +0800, Holger Huo wrote:
> > > This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
> > > Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
> > > 4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
> > > notebooks. This SSD produces all-zero nguid.
> > > 
> > > Other SSDs manufatured by Shenzhen Unionmemory Information System
> > > Ltd are likely to face similar issues, but I currently have no
> > > device to test.
> > 
> > Are you using the most recent stable kernel and still need this patch?
> > These quirks shouldn't be necessary anymore unless it's advertising
> > multipath capabilities, and it doesn't sound like this one should be
> > doing that.
> 
> Yes. My current Linux kernel version is 6.8.4 by arch. After further 
> investigation I found these quirks truly had no effects.
> But my nvme drive still freezes with Device not ready; aborting reset, 
> CSTS=0x1 failures and AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 ...] 
> waking from s0 (s2idle) sleep. Are there any other quirks or what that I 
> should try

I've seen the IO_PAGE_FAULT error reported before, but all I've heard is
that it means the device attempts to access a memory address that it is
not allowed to. I don't know why that would happen, though. I've never
first hand experience with this condition, I'm just as confused.

