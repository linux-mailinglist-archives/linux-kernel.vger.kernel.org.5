Return-Path: <linux-kernel+bounces-137966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16D89EA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE081F240F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68240224EA;
	Wed, 10 Apr 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Hsky4j/A"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7E1CA80;
	Wed, 10 Apr 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729604; cv=none; b=a3u3uTHmy5+McyXgR/p6MDdZMlvI6QTu1A45jOpU0em2i0HT/ACqdlQNLQ0WKbc6QGdqMAFru6MS6g8TjSLfu8+sphISMn1K5hWYNqHsgXsEHBDMs/vzLdEWqN61n6BEDqfwrakyoslgTNTj6gSmPSTmYn67AFcjqFuUPynRYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729604; c=relaxed/simple;
	bh=6IeBjyCL++/tTknsNWPUYuxRZKWspJPfQ3nROpczfqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSZOkJ21+F8uGpYAG+P4u56W0skREx9Nq1ee+HupXJccyyy/4kbyeTSTPgcYftpo8ir61LSvZJfLbHYBpABibgMQCbMr47/GNJXb5sRWNk46nycIvgmecQi0R9cy10IgGA+45DiGcwro1Pz5QFEDGaBfZgVB4Pu8GSlnPGq1sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Hsky4j/A; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 4F4F660406;
	Wed, 10 Apr 2024 06:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712729596;
	bh=6IeBjyCL++/tTknsNWPUYuxRZKWspJPfQ3nROpczfqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hsky4j/AEJPLnjVBZoWhFLwRr44NG2R1Ly19zthKqNBXxGm36SbqSsqAcza9//1qM
	 nwUIGI0Y90Jiwfr54QIwS82RkGmXjD9nYDCLgSBmjaR3ZF6db6xG3cps8if1p+2cw7
	 qQ2GWlPM7zK8KoBXDlM8t3k3jJojdcHSGjPRQdHcT3NSMQ25vTpAEbVpKt3JERoMl5
	 0+t9s3tz2AOkpExBdqTUr5iI4GW14DKTOLqTT6syJqEMOxHqf+wQPCJrnKkrUa3DEg
	 zMEymjG1+BQFU5oGJ/1/kn4agkZA5pZwt3+E+JcLWg255I1xpt24jW40EUa3BKcwB+
	 1/aivQMba8rqA==
Date: Wed, 10 Apr 2024 09:12:49 +0300
From: Tony Lindgren <tony@atomide.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: ti: omap: minor whitespace cleanup
Message-ID: <20240410061249.GA5156@atomide.com>
References: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
 <20240208105146.128645-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208105146.128645-2-krzysztof.kozlowski@linaro.org>

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [240208 10:51]:
> The DTS code coding style expects exactly one space before '{'
> character.

Krzysztof, sorry for the confusion on getting this merged, please go ahead
and take it:

Acked-by: Tony Lindgren <tony@atomide.com>

