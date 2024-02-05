Return-Path: <linux-kernel+bounces-54206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162784AC34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037E61F24884
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0E6DCED;
	Tue,  6 Feb 2024 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ohR1V/96"
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB636A02D;
	Tue,  6 Feb 2024 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186804; cv=pass; b=jbNUOTmYTztC2rUB/zBfVYnMNzC/ry0YLk/BcsEp/qLM1FG6h5F1itHrwph+4BmvOHhl6EKGGjzfHJRdffxfPKkXrZmagAKcx6h2ZtFrJfOcMBoLJTlkyY9InexuQY1Ox+M2aTliKPaAp+QlgTQuSp2gGn/MJnqg9BfZ6+Niito=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186804; c=relaxed/simple;
	bh=9i1zUHcc/q5QlkRKXG3ycDxUoXVZqKAQn/k9mZ/3SOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZuQ8PmoariHjtHrwGFoPAml3KHmdHs+FfUIkGpg8yrTwe11B+OpvEtxSFQw+qQ+W3rJWwegx4tL+0gQF9s1ANzXYKNUSl6VGfWoJXbV8l8IgzYEEAYSKOngS/m1UPpQft40K9Dp9aABO7LL2CqwFczSRkM+EadKuAuLQ2sww8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ohR1V/96; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AE800C2FF7;
	Mon,  5 Feb 2024 20:54:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 46B45C3484;
	Mon,  5 Feb 2024 20:54:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707166487; a=rsa-sha256;
	cv=none;
	b=A2cuW9r05gBW5wHwVczfhNaGr/ywVWSvXMQYrzKNlL4FH7t8H7XE6bdriPH6IboqpumEyJ
	C9DSw4lA540CXnWR4TFOxfKZRZ4oApdbx+NSByoIfh8WGju/lyp6fiaJzA5jw94rJe8u7U
	PyIQiZ1ZyZ3hBT/dr8PuceZmjd4rk3sAdTb7JfyO4W7IX2JB1srFt2AUvuOQJdkzvbi+h1
	xsZNL9y4VVbhfj4XngMPaS8b7wHWUwPyzFTqXFkuvsgP1rItxBuAtZTFT/U9zIgR9wncav
	8HrsL1yKOgPP4tTaFFIaenqSJqdD5FYtU0klYOYNH2y7ZvqpgIOQu0Rkzz4N3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707166487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2m5HnxmZJndbIZEkv0HMGpTUlFekjHz2j5udUh5/6/g=;
	b=dujzFtuNcRHrT34DlLGTvNBEsLoxQQYbkN5zgs2APuIJmakxoMgkTLtdH7HVE6ExniqSYo
	NGQgp1nN8KDc69I1hDRyFzqjKv4YJfb0RAtS0sPp9liFEQj1QLzfUiMTMGtwX+vPu7e1MC
	yKsqRmQEUs+ujIey/NiQdC+MAXCZyYYJZHJQGCrp0KZYKlWigv9OEBM4oxtZiE5ZIAX9/M
	dBjsapjCOyGxjHoclwjJz4T8bm+kEYJ8V748xGynmwLng+QZRv162c0dnoa17V/Hz1aJZD
	Ea1+pSVwMsFzvE1hP1cJTjOnSv3Hm/mobYTNPzOPe/7CWx52RjRZdrH6fL+flQ==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-fxp9g;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Wiry: 5051acbd69de6e9f_1707166487583_690020075
X-MC-Loop-Signature: 1707166487583:3233860116
X-MC-Ingress-Time: 1707166487583
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.38.211 (trex/6.9.2);
	Mon, 05 Feb 2024 20:54:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4TTJXk4Nktz94;
	Mon,  5 Feb 2024 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1707166487;
	bh=2m5HnxmZJndbIZEkv0HMGpTUlFekjHz2j5udUh5/6/g=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ohR1V/96uAqGSh8/6GJKIJPgToXnm8ONvnL9nGNV3dVZtKMdHjkWw0t/2dOw0Ek7Q
	 0sgKmzQw5AGR2MvQ9BEu2Ej4EgRliOESW5D5E/NzVVmVqkZyiYf4eE+omOzwJ/bQwg
	 6SKOiMzk2nVIQIN3+W0B2ckvqST0IZWRmS4fVq50bOGjBIoV6y6BZjO6Pmw4hxjT5J
	 NgKE551w3Q4Sp2YzO/soSDVNYq6cVvSpWpGYz7b1Hz8rCWO/EdeQCMzw1EAmfZIOdT
	 2g8+VvwPFA1+D3C8NI3Fe4SKzOA/MuWXbQBRb6IEHbyNzJwarMaVLwqSvZJXij9d+R
	 xIlbtyv6M6JDQ==
Date: Mon, 5 Feb 2024 12:54:43 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: remove CONFIG_CXL_PMU entry in drivers/cxl/Kconfig
Message-ID: <20240205205443.sottm4g4ywl55ujr@offworld>
References: <20240204094613.40687-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240204094613.40687-1-masahiroy@kernel.org>
User-Agent: NeoMutt/20220429

On Sun, 04 Feb 2024, Masahiro Yamada wrote:

>Commit 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>added the config entries for CXL_PMU in drivers/cxl/Kconfig and
>drivers/perf/Kconfig, so it can be toggled from multiple locations:
>
>[1] Device Drivers
>     -> PCI support
>       -> CXL (Compute Expres Link) Devices
>         -> CXL Performance Monitoring Unit
>
>[2] Device Drivers
>     -> Performance monitor support
>       -> CXL Performance Monitoring Unit
>
>This complicates things, and nobody else does this.
>
>I kept the one in drivers/perf/Kconfig because CONFIG_CXL_PMU controls
>the compilation of drivers/perf/cxl_pmu.c.

Completely agree. In general we should try to keep config
options minimal where possible.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>---
>
> drivers/cxl/Kconfig | 13 -------------
> 1 file changed, 13 deletions(-)
>
>diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>index 67998dbd1d46..5f3c9c5529b9 100644
>--- a/drivers/cxl/Kconfig
>+++ b/drivers/cxl/Kconfig
>@@ -144,17 +144,4 @@ config CXL_REGION_INVALIDATION_TEST
>	  If unsure, or if this kernel is meant for production environments,
>	  say N.
>
>-config CXL_PMU
>-	tristate "CXL Performance Monitoring Unit"
>-	default CXL_BUS
>-	depends on PERF_EVENTS
>-	help
>-	  Support performance monitoring as defined in CXL rev 3.0
>-	  section 13.2: Performance Monitoring. CXL components may have
>-	  one or more CXL Performance Monitoring Units (CPMUs).
>-
>-	  Say 'y/m' to enable a driver that will attach to performance
>-	  monitoring units and provide standard perf based interfaces.
>-
>-	  If unsure say 'm'.
> endif
>--
>2.40.1
>

