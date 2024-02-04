Return-Path: <linux-kernel+bounces-51804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DD848F77
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537521C21889
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D123754;
	Sun,  4 Feb 2024 16:56:59 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C338249FC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065818; cv=none; b=Nt45EAOuZO46NqSsly43hd+xc+Zv4oBIkglK/y5T6koBPXu8WwEthStrFcGnZSdjeIEmttpMNaJvEiY24DQzU8O1SvlzTc75CVA/CAavSFW8WVlytyJuDAJkZLVbcAMX/08dBB4jRCw+OKd04+B6YgjuEPZE7HaHCsqgSRfq0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065818; c=relaxed/simple;
	bh=bZ8bjQpZ59VayxASzq5NATV3v9fjcUF2G9PKgSj9FK8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqBFyAWyNTqJdccE++eef2Wy8jS9bFIUv8KC5zySjQsNb1IAu9vS9KbNvZ/3Nj01WHnFiPz73zomf+wdJpcmJKn2Nh5eNH+ZiH/NeCdFdmlegtj/p1h7PRjRB/uef8lBSUxrFF6UT/TmX2uzBf9+K8AoxAaJLnw4OplRJHN0byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6641b5d9-c37e-11ee-abf4-005056bdd08f;
	Sun, 04 Feb 2024 18:56:55 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:56:54 +0200
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 05/39] pinctrl: add a Cirrus ep93xx SoC pin controller
Message-ID: <Zb_B1mpHrfAhL6Zl@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-5-d953846ae771@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-ep93xx-v7-5-d953846ae771@maquefel.me>

Thu, Jan 18, 2024 at 11:20:48AM +0300, Nikita Shubin kirjoitti:
> Add a pin control (only multiplexing) driver for ep93xx SoC so
> we can fully convert ep93xx to device tree.
> 
> This driver is capable of muxing ep9301/ep9302/ep9307/ep9312/ep9315
> variants, this is chosen based on "compatible" in device tree.

..

> +static const unsigned int ide_9312_pins[] = {
> +	78, 301, 302, 321, 322, 342,
> +	257, 295, 296, 334,
> +	4, 24, 25, 45, 46, 66, 314, 333,
> +};

In other cases you locate 8 per each line, why this one is unaligned with that
pattern?

-- 
With Best Regards,
Andy Shevchenko



