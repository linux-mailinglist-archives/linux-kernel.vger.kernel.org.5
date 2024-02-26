Return-Path: <linux-kernel+bounces-81318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63A867429
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108FCB246EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FCB5B020;
	Mon, 26 Feb 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="CscYpYUV"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180921CFA7;
	Mon, 26 Feb 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948741; cv=none; b=qXAWQsSijuAQWqQwv3+MsUIWGyTC80TZkor54K8gnVZckFWMEHYfG8H0i+S+bMn0IWRBWP/ABjjBsLLKikM1DAT13vDOYrcBrxN47BYnkJRVBMHFFc6v4uDvSS8NWVwY40OmxFFPe9JaqhA5wmzKI0hMiRaidvDMp0CurlA9j/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948741; c=relaxed/simple;
	bh=NUmJx1FCV8BWdfgpJMrSm3cXD9TOZaTRvkGICB6GVk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX9ZiphLex9u7DjfVrJ7dZEL1PIVtCLak41MqM0T64fbwsACBd0g4czNhlu49W0qfxJ4gObbaHf5VkJg5Z9KYz3beiobURg4Upf2/2SB7s3QOmIP9eU4CZV9s8VMjk+dBAaeirnyy27V/vl/aL651po81eDQ1mfu3IT06xcCHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=CscYpYUV; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 52A5D604E8;
	Mon, 26 Feb 2024 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708948739;
	bh=NUmJx1FCV8BWdfgpJMrSm3cXD9TOZaTRvkGICB6GVk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CscYpYUV1O7CBS5suvnxe8AJD9kpf1J44Vi50icMc6M8IA2jIp2FlQNyJsaJ8zgUS
	 4NBrP2QAM+bTvF+5IuRptem0o8nTHXi0HBGz13SLGgl8CrscBaekNTaBgWbRAuI3vj
	 qUz5e66i8WPOPxj1yN7x7QLwZfyq8ccPdGd8epJQHNg/bK6HTsVhGVQHypPygKwtYv
	 /TwB0M5ZhWKpnj8H2URLmQcQZh7olK2sgO6txobH3NE8ddkARStQtqviqksgNeYTNW
	 MPMllyRU2YjZeT60tsmZVXzC/nvYZZSnt1yMMBNyWG2Bh5dXE/9Uh79ay48zVJRrom
	 iSoZi9TB8Y+cA==
Date: Mon, 26 Feb 2024 13:58:34 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Mark Jackson <mpfj@newflow.co.uk>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org, Marc Murphy <marc.murphy@sancloud.com>,
	Paul Barker <paul.barker@sancloud.com>
Subject: Re: [PATCH] ARM: dts: omap: Switch over to https:// url
Message-ID: <20240226115834.GZ52537@atomide.com>
References: <20240109195500.3833121-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109195500.3833121-1-nm@ti.com>

* Nishanth Menon <nm@ti.com> [240109 21:55]:
> Move the pending urls back to https:// and mark the ones that are no
> longer accessible (http or https) as defunct.

Applying into omap-for-v6.9/dt thanks.

Tony

