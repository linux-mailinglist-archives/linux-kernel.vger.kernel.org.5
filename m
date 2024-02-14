Return-Path: <linux-kernel+bounces-65896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076AE855374
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F99285295
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4F213DB85;
	Wed, 14 Feb 2024 19:48:28 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03017E767;
	Wed, 14 Feb 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940108; cv=none; b=Lsuwk5MQEoP3TUZBtIhlL2f2bhQjJu5mXkPipFPbSaXilqsDHGW0uZYxF3wnGoSJLDuyFW57BZcdnNdMg5pxJa2WgRw5WxQd5PrVFlKa814BoSyqb4ubFsEFSIvKwEaqa5pxtXDVTcp3Mg17/OXVP6QXuyAjRbISAp6vyLfeh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940108; c=relaxed/simple;
	bh=NC8mTAJ2+Ru4a70SXpBDjYkA5AKa1yGpczglRB9UknU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV8XEkPPhfNsYWiCF/KO1/HmhbQfrcFwb8/gR3bYlsW7wK71ptrBnOMZQgH7vZMQOlojms7tdpn1bf00B7JbYDmZgAsW+UX0vdu536feQC7MtnEfSQQkAcFd22xj9T7G4DllPy9z+swiKJZSCqVVlHqMG9KG+rpWJwi4ngxaer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1raLEy-0000vd-00; Wed, 14 Feb 2024 20:48:20 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id EC942C0267; Wed, 14 Feb 2024 20:14:27 +0100 (CET)
Date: Wed, 14 Feb 2024 20:14:27 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 03/14] MIPS: Allows relocation exception vectors
 everywhere
Message-ID: <Zc0RE8NE0sfYYmZN@alpha.franken.de>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
 <20240205153503.574468-4-gregory.clement@bootlin.com>
 <ZcTE8nKCaKuaUvAe@alpha.franken.de>
 <87plwzj8jw.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plwzj8jw.fsf@BL-laptop>

On Wed, Feb 14, 2024 at 05:48:51PM +0100, Gregory CLEMENT wrote:
> Jiaxun Yang sent a series to address it [1]. I managed to rebase my
> series on top of this one.
> 
> Do you agree with these 8 patches?

first glance looked good ;-)

> Can I send my next series with the assumption that it will be merged?

yes, I'll start applying next week.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

