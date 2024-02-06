Return-Path: <linux-kernel+bounces-54275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA684AD28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDFD1F2448A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267F745D9;
	Tue,  6 Feb 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmTIrTVp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A58745ED;
	Tue,  6 Feb 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191657; cv=none; b=sOtk5+7RCq97pNjHAixZ4gexhmeZ0NPRhPltjSS+k9oH0HJ6zlFMsWNgyDa7CzfhWDR9SMTUF2EIKo+falWuGgeMQfwqRgWqTUe2BgF3jbbfdplPRtPrzMdpKVVJf91yckWc1tSKycK8BjqqnM1xJ+NZcsI/0+NTqdAyypiVVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191657; c=relaxed/simple;
	bh=xU6Jqk/OEqqahJjPwyGUQQ9h5QuYfirciG7QbqoOa5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHQN7geBuqQc8dsK8Kf/G4mV5tXnIwjX91bdIeswXpdeM+WRpP4yayZBviWTbinsgF/0yShRKu2mNfIu8yfZsd7/NyeITTY+RMWCaMPU83LZ02rqH/O/s9ZBVXYis+U9Idg0zp3mLDsm7yUa5wAy1Wn7GFCOXm9mefh1ji2KTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmTIrTVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C58C433C7;
	Tue,  6 Feb 2024 03:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707191656;
	bh=xU6Jqk/OEqqahJjPwyGUQQ9h5QuYfirciG7QbqoOa5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmTIrTVppxXKNPjirTNDs3FJ8TaePBk/zlCyWbGlh/EIi8HXHzMyWzkqrX3Ah8E+O
	 I9b/uO8e44M/GS/VYyydpIYnX3BMBqxNTqIdKNJMP4eYOP8Ny7ZYVVeXKVGJM4efxy
	 9tq3R0NDAQUnVlG9Sy1ZyBDMDEKNDXA6IXaMH5fqcDwfll1RNRgr56w/dBVgsDlSTG
	 JYFnCTX35agYXBnH9GmBVnlaJapnp5gBfvfahrEmLDCyi2yJEiloYXnoQuyPrdUEJS
	 nfDzxpQH/6xDJfyewy9vyca4zqPzMQ3YuvjywkDU0/X2XzW1QRf1G1MtbYcuNUT7en
	 pqDUI9JnLmE/A==
Date: Tue, 6 Feb 2024 11:54:12 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel@collabora.com, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] firmware: coreboot: Generate modalias uevent for
 devices
Message-ID: <ZcGtZHV9EB8UsNXc@google.com>
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
 <20240117-coreboot-mod-defconfig-v3-1-049565a27bba@collabora.com>
 <ZcA72dyYd9ZR8k_J@google.com>
 <2a2736e5-8788-4643-8d19-a79b9a9ec776@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a2736e5-8788-4643-8d19-a79b9a9ec776@notapiano>

On Mon, Feb 05, 2024 at 09:13:51AM -0500, Nícolas F. R. A. Prado wrote:
> On Mon, Feb 05, 2024 at 09:37:29AM +0800, Tzung-Bi Shih wrote:
> > On Wed, Jan 17, 2024 at 04:03:22PM -0300, Nícolas F. R. A. Prado wrote:
> > > Generate a modalias uevent for devices in the coreboot bus to allow
> > > userspace to automatically load the corresponding modules.
> > >
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/4] firmware: coreboot: Generate modalias uevent for devices
> >       commit: c6b0a4ceb7c9d8bb014d2967c97c8c7cbf60b006
> 
> Hi Tzung-Bi,
> 
> I was going to send a v4 with tag changed into 64 bit long as suggested by Greg:
> https://lore.kernel.org/all/2024020105-dash-antiquity-a56b@gregkh
> 
> And that includes this commit, as the modalias field would need to be 16 hex
> long.
> 
> But since you already merged this, would you prefer a change on top of this
> making it 64 bit long, or do you want to keep it 32 bits?

Oops, I overlooked `u32` in the patch thus I thought the patch is indepedent.
Please go ahead to send v4 with 64 bit long tag.  I will drop
c6b0a4ceb7c9d8bb014d2967c97c8c7cbf60b006 from the queue.

