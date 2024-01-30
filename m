Return-Path: <linux-kernel+bounces-45208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1554842CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A421F2093F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1E7B3EE;
	Tue, 30 Jan 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="XkCZL0T1"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2DF7B3F2;
	Tue, 30 Jan 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643395; cv=none; b=Y8SHTyVsCojEfmOj3izXGuvUkEB8I+0gAZooW+ihWzmMqdy3UR0sAfToOoIkurFPQKhQDPm1dOECyUbSyCHgwZ9hkjUXf/wWzjYxY/JcVJiUxBQHV7oPn1BXubmEj8g1MR1yXdTKMIXYb1j7UgymKURElOPeo6RuMNIy1ez5Q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643395; c=relaxed/simple;
	bh=BEEx4gwRs1iKnUvPL+DNQPwugqIAQBhuDJjeH0AXavw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuzskdCsdkXF4kiv66u2pk/MviJXdOucqIm9KonJPF9PD3bULiNboUQZfMcNfp+AhJb+0fct/fHMn2y63BURkxMT3flJu/b/oyeeXp1g/brM6np0ifON4MAuMGpQrVIrTR9gpZKmrdyaD8iuX77YKqiMMQzDrTSMzCOFRYN5Q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=XkCZL0T1 reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1706643384; bh=BEEx4gwRs1iKnUvPL+DNQPwugqIAQBhuDJjeH0AXavw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkCZL0T1Ic9+FBUE62JW+/ktECjWhYSnNULt00KRgvzUoIrXAcpADfmW2G9+W4Srk
	 4D3l9Xu95fkdHbhQNl/DxRUEvwEMwedKXEY4vQkGlPXcdHsaJYxjLi6wH0BRmNqWuL
	 7/nJmkipBcqeQyB6Zv2F+xyk3h1i9LrS3ndskK580O5zoqJx8D+OMzvtJqVkbBDiRr
	 M/4Km9TP6Rqy4rjBQqTonDiFps3H1vfIE1qzpLTBjQrQ540UtL0qNpSkwwUjJmdSYf
	 gU1qrmdmuT7YeK8Cr8mjU1b/KSnNOV4hRlSAzG3eZ1kGPymFmLwcYLjPPljMTkKoJu
	 +bi7WjpjCrcrw==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 8F8BC3C95A9;
	Tue, 30 Jan 2024 20:36:23 +0100 (CET)
Date: Tue, 30 Jan 2024 20:36:22 +0100
From: Manuel Traut <manut@mecka.net>
To: Dang Huynh <danct12@riseup.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Segfault <awarnecke002@hotmail.com>,
	Arnaud Ferraris <aferraris@debian.org>, Ondrej Jirman <megi@xff.cz>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/4] arm64: rockchip: Pine64 PineTab2 support
Message-ID: <ZblPtrW7suT3RRXc@mecka.net>
References: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
 <6035442.lOV4Wx5bFT@melttower>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6035442.lOV4Wx5bFT@melttower>

Hi Dang,

On Sat, Jan 27, 2024 at 06:35:50PM +0700, Dang Huynh wrote:
> Hi Manuel,
> 
> Since the BOE patches have been accepted to next, you do not need to include 
> it in this patch series.

sorry, I thought patches to LKML shall be against Linux master since the
patches are still only in drm-next I considered to keep them in the queue.

Regards
Manuel

> On Saturday, January 27, 2024 4:48:41 PM +07 Manuel Traut wrote:
> > - BOE TH101MB31IG002 LCD Panel:
> >   * Picked patches from https://anongit.freedesktop.org/git/drm/drm-misc.git
> > (drm-misc-next)
> 
> 

