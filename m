Return-Path: <linux-kernel+bounces-156050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AE8AFD34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E11C22886
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843B1C36;
	Wed, 24 Apr 2024 00:11:31 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE207EF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917490; cv=none; b=J40CjfKNcJnBTV25HfdK9MQNH1t9EhVX2jhpAJmxUu5llUExa4HJUGavHIDs1l5UryohG7gtGD6FaI2NL8jCpWu2PZWxK1Linf2gy9z0UYR+zrzFfNFlMFLtXdtmTA9go9rj2zkDp292bf8Wl0yPCnQ9Ky0X8wDHvogz0UPRpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917490; c=relaxed/simple;
	bh=3pSLZFuGiJnJlY2piHPfE03X/NoaHX/iWuiekKpGI3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSG0DB94iw3BRi65oetg5xTAossp0N7tOXs/2PKYoGdW2Yd6HLGaD8Fye2F17YAYKaOvYT9VhOYEUG30Is4ZPT6nDhYLkC+JE+wHiyAitW2XYhFITZtvd/bF5/Du/sYiijnhdWYpc2vOPF42GjicR53bHFyObYtjisaFxMEeJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 31306275-01cf-11ef-b3cf-005056bd6ce9;
	Wed, 24 Apr 2024 03:11:27 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 03:11:26 +0300
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] i2c: ismt: remove printout on handled timeouts
Message-ID: <ZihOLtvtdOm90tJF@surfacebook.localdomain>
References: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
 <20240410112418.6400-28-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410112418.6400-28-wsa+renesas@sang-engineering.com>

Wed, Apr 10, 2024 at 01:24:22PM +0200, Wolfram Sang kirjoitti:
> I2C and SMBus timeouts are not something the user needs to be informed
> about on controller level. The client driver may know if that really is
> a problem and give more detailed information to the user. The controller
> should just pass this information upwards. Remove the printout.

Neither this.

-- 
With Best Regards,
Andy Shevchenko



