Return-Path: <linux-kernel+bounces-84607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7BF86A8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D0A1F2672C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2524B41;
	Wed, 28 Feb 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="inPkxNnf"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0423776;
	Wed, 28 Feb 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105315; cv=none; b=nyJ1DqBley2lpJb5H5gfjnkCCllGwtUovaQ6x7rvQD/LoyZZWzX8Dw9ggMEaXq5qe4FsAhKxkWl9Y7D91+vkdSCHLVrLztr79Byx03R+icrLCuYWyzud/3iWyj6mWYTXO4TehkZu4lSa/utdSeKlWc3dccEB9yvHC0HKM2sOOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105315; c=relaxed/simple;
	bh=ANc8dvk1HuRXLTAqn99EVddZRnoclltcavg81hMnWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gla+ml2rNhKwRK0Uiwhnp5v3R+zISjNT3L92273//Bg+aZ+B5bTADQYcMWF7MPB6wwAfaTTwnwmpM4VJnJFwyAAjfnksKJnbcKCLKCUX0XGThgTffRSK6g3R1bUVCK4vf4vvYUZGm8/xnK3rXiyD+dLFG/sTXazLKjw5BFiOx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=inPkxNnf; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id ADF6D60429;
	Wed, 28 Feb 2024 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709105311;
	bh=ANc8dvk1HuRXLTAqn99EVddZRnoclltcavg81hMnWrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inPkxNnf+HpIvFe918cZSHkW5rJUb6YyW2/eBrn3fZrWfw+wCilZm2X5z7DYPbilg
	 Bqo7Vw7OegTxemrXfgAEM5kIY9he8H+wUl5jaa++cCqywGdjm9Mp3Z/jtsdS8jzAhh
	 aT+Gebmu7InEIQUnjngcJRiaDRaVau54dqmoL6+EsNXUCwRL8h9r4XygZHZPCubnuq
	 c6JGo8V/WYsUTUbC/yOtxNJR+tmM90UEeR3ZfJe1w4+nx75CPLHpjVjTM+SZ9+Tqta
	 Ji0pbWM4ON1dNKo4MvtHYZ5g/vP0OfdIJUDSQSF8JyijZVC3JXrgVIK3MI86LRxQwS
	 xzUhNG3NXqX8w==
Date: Wed, 28 Feb 2024 09:28:12 +0200
From: Tony Lindgren <tony@atomide.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: omap1: remove duplicated 'select ARCH_OMAP'
Message-ID: <20240228072812.GD52537@atomide.com>
References: <20240204125716.56756-1-masahiroy@kernel.org>
 <CAK7LNASC4xh5WrEaHkqFg49xzJsQMQnjLV8sCea8uceNp5EUdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASC4xh5WrEaHkqFg49xzJsQMQnjLV8sCea8uceNp5EUdQ@mail.gmail.com>

* Masahiro Yamada <masahiroy@kernel.org> [240204 13:19]:
> Just a nit.
> 
> The commit subject "arm:" should be capitalized to "ARM:"
> because it is a convention for changes under arch/arm/.
> 
> Maybe, the maintainer can cater to it?

Thanks yes applying into omap-for-v6.9/omap1 with the prefix
changed.

Regards,

Tony

