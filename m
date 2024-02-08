Return-Path: <linux-kernel+bounces-57907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D084DEDF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1FCB28B81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32377F39;
	Thu,  8 Feb 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLTTh2gU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFB78B4D;
	Thu,  8 Feb 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389591; cv=none; b=hLMGCgXSS1fPxi2u2rAgpz1klr+MISUAK6aIPaXNa8YWWo+Xe4j1INzYSRbtIhttC+y7cMp0IKtz+Vt4oe3kP3hJjbXtHs1trizSpjl7EOIZbJfCJqQ9QjT1CPXN5nn925LHRNmwB2tBJBKzXUKNr72JlJK6IhTXy0imWKCBovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389591; c=relaxed/simple;
	bh=wBeYdUBNJaBkDPT3NHcSUBRjPj9TIlvLdhLYgROCToE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foOC2e5J0l6V5eigs9s+y4fmfCg5nPOc/mzP8Akiq4rQsAgYXVFWpHW2pDnziMJiKHc8mcEw7pdgktvj0hWR9elOpihFog4goz8C5Km6gl0opDOXly+itIreyPT4L3aZGCagDKpUj3/0d672xJZU8ktnXXhcqu3J6mbZ/ArgbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLTTh2gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6034C433B1;
	Thu,  8 Feb 2024 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707389589;
	bh=wBeYdUBNJaBkDPT3NHcSUBRjPj9TIlvLdhLYgROCToE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLTTh2gUPf7X+du/kpXt5N6d8vyKMod7zdhYCpAkk8ftEkOe1iwkixVKEgx3dQaAk
	 XYU9lDce1kwLNZ7oU7X3FxsZUhpTzucTaU7M5+PDAzhZYuZ617AddRSRcd5qMxVuu4
	 1oEPcSYVk8kG8LhplCoFipC/B9Novif9PSh4JY7hYBc814/jNuaHGWjg5PuEUja2/2
	 5TiKmWuhNb3o3lczdbWr4WwVd2RbjTt2X7AKKsojlvLVnssePOhhUgfOl6ZGCyajrL
	 QcEXgbl6fw07HkyYrh/z2kBvoIn7ejWJTbr2lfVWI9XESB3nxNEDmXBAJYksLuZfJG
	 54XEt4QBk+Lfg==
Date: Thu, 8 Feb 2024 10:53:04 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/4] backlight: hx8357: Clean up and make
 OF-independent
Message-ID: <20240208105304.GI689448@google.com>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>

On Thu, 01 Feb 2024, Andy Shevchenko wrote:

> A few ad-hoc cleanups and one patch to make driver OF-independent.
> 
> Chagelog v2:
> - renamed init to init_fn and typedef accordingly (Daniel)
> - added tags (Daniel, Javier)
> 
> Andy Shevchenko (4):
>   backlight: hx8357: Make use of device properties
>   backlight: hx8357: Move OF table closer to its consumer
>   backlight: hx8357: Make use of dev_err_probe()
>   backlight: hx8357: Utilise temporary variable for struct device
> 
>  drivers/video/backlight/hx8357.c | 57 +++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 30 deletions(-)

Someone may wish to address this:

WARNING: DT compatible string "himax,hx8369" appears un-documented -- check ./Documentation/devicetree/bindings/
#58: FILE: drivers/video/backlight/hx8357.c:636:
+		.compatible = "himax,hx8369",

-- 
Lee Jones [李琼斯]

