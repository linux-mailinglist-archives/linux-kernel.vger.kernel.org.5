Return-Path: <linux-kernel+bounces-29923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1883153B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13FD1C245AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69512B71;
	Thu, 18 Jan 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="T2e7lANz"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E643125B0;
	Thu, 18 Jan 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568260; cv=none; b=jSGBWRdquIUuWIteEXkb8kak/sCn0TKVnpR2/XuCvTyZ4tFhmtD4g7hc2COIX+Js7dZyLcRFSjWG2N3MuUJi2rLO2R6zRa5PyK5B39JC/ylQcT1c1Y77rGyxH+3DCrTxnHAzqgY+qXbJMvZl3r8UZYD96Ecze4lBi/mgUUhXpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568260; c=relaxed/simple;
	bh=9WhcegD00ZXPQqj/9MrAzfk2OaAluGZbP3bQPxipOU4=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=lp9HIXgeY49vEJHlZ/iN4S8c+1yioOnu8/wqGKaL0twXWoCBP1vU9VHo5gb6Amqt/rxSNhJ6bMn1cQn5uRSBzWViFDG5ZfMjvcffMLg3KFESJX+ccS1LozWOhAVamOuEFyMUy/2mgSK++KB+N44Ic8IKXustDqHWQ6jIP7v4oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=T2e7lANz; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id D04B260547;
	Thu, 18 Jan 2024 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1705568258;
	bh=9WhcegD00ZXPQqj/9MrAzfk2OaAluGZbP3bQPxipOU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2e7lANzQT/C2YB/bY2N+y2QRDU/8QozfaZ5Fg0obTezvV7qAMsJivTQZ/pn3HzFV
	 maYl0rgldmWmtWchSPa3KUpV3H+22PpnAi9UG4y9K1vTnbRQIzC0lTeAAyWa4hCYzy
	 75Uww92wDZnthnayia+3wVXB8jk5WdwY/rpq56qnkCoCFm0IdDG99uUen+gVKbm4hP
	 1bzaOfBZIo1FLeMrpp69F1+Xr3OxlGkKLEIsFgO1PaLPGpbeKN9sTVQkPxbFZrezyD
	 WaiLme/dPGeknQkSsIF7KXGmi/XhMoxRUxA7Xins8tOj0vi8XqtZTFRgmC/kfCvNy8
	 cE1d215OiHmeg==
Date: Thu, 18 Jan 2024 10:57:17 +0200
From: Tony Lindgren <tony@atomide.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk,
	Paul Walmsley <paul@pwsan.com>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 00/13] ARM: OMAP2+: fix a bunch of kernel-doc warnings
Message-ID: <20240118085717.GR5185@atomide.com>
References: <20240117011004.22669-1-rdunlap@infradead.org>
 <20240117131305.GP5185@atomide.com>
 <e6692a04-142c-4df4-83dc-534ab27a55f6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6692a04-142c-4df4-83dc-534ab27a55f6@infradead.org>

* Randy Dunlap <rdunlap@infradead.org> [240117 16:52]:
> 
> 
> On 1/17/24 05:13, Tony Lindgren wrote:
> > * Randy Dunlap <rdunlap@infradead.org> [240117 01:10]:
> >> Fix many kernel-doc warnings in arch/arm/mach-omap2/:
> > 
> > Thanks for fixing these. These are unlikely to conflict with anything so
> > please queue them along with other clean-up:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > Or alternatively let me know if you want me to apply them.
> 
> Yes, please go ahead and apply them.

OK will do after -rc1.

Thanks,

Tony

