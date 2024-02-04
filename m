Return-Path: <linux-kernel+bounces-51788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A825E848F4B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A57E1F2196F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879A2374C;
	Sun,  4 Feb 2024 16:32:33 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773F225D7
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064352; cv=none; b=L56NRr53XGujefB7KJcVrFYV4/M0d0mdWw0bSFNSOtJ/boUpmjzorYsGoiVDiOMTWoNAZXH8q6pCTYdK/Y/lG5KB8W/0b2JgKHETKFmii7Uj/XfmIImUWhMsQZba0EMK4qArkvbzwM9kUphg2jPO5mp7QK9zslv4cDPsr5a6C8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064352; c=relaxed/simple;
	bh=pz7fx5GLtOUnibdKLPK/ou7GqtvYfPZOc+X8kDLDlSk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwyaGSEhE9cZUWXAmFmVoSSZX38JMmmSUlZJnNx0dy03g+pivyfIZWgMUe341uw0aSl/FXo9ea4V6bs5zJ+NrZL7E0GTKHBEDBjE7kTWz0fhtTNFdKaYLomjWrfGxGeHamvLEiMwas8K0/HKuiiJW0zBu80QSRj0ujFF4YM0qsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id fbe6de40-c37a-11ee-b972-005056bdfda7;
	Sun, 04 Feb 2024 18:32:28 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:32:27 +0200
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Wu, Aaron" <Aaron.Wu@analog.com>, Olof Johansson <olof@lixom.net>,
	Lee Jones <lee@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 01/39] ARM: ep93xx: Add terminator to
 gpiod_lookup_table
Message-ID: <Zb-8G_Tgd7l4TCab@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>

Thu, Jan 18, 2024 at 11:20:44AM +0300, Nikita Shubin kirjoitti:
> Without the terminator, if a con_id is passed to gpio_find() that
> does not exist in the lookup table the function will not stop looping
> correctly, and eventually cause an oops.
> 
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I prefer @linux.intel.com (sorry if I haven't used that one for the report).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko



