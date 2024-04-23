Return-Path: <linux-kernel+bounces-156033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1078AFCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE08DB231C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C37524D3;
	Tue, 23 Apr 2024 23:56:50 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405E524B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916610; cv=none; b=fZhNa6f0PADCXQZRjkWeUGlRVUc7QOEe5VCif8zeJEV1pr2q3nhBwdnwQwN/HsgdDDxsbjt0jkzLUdH8YNqqy/i9LDhZxsQjSXzdKysGDc+1d6jszW8sA4HoWyvvS9HXijmgMo8YUkLu1P0GmQ6SOYWQv4zQtcNzmzC4f2xwIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916610; c=relaxed/simple;
	bh=rXXYh8Ia4WTXYIq9lC5Uh3/nGLQNNjfMaOOaGBd6vmw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiNbwi+tiIeLvY8h/Yi0giTarT9w206hHtTmJU4asFz5A/crl9PzT2Ljluy9I/qP5M4DD97EZKpFb/6bhRG6VGKP3+KB1KHaUOMwUdHaxTGZOW26hj/pl9Oyq4HqgFYy+3wtun3f4ypZpAex28a1laEg86nDnvC0IbqModTDBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 1f188d5c-01cd-11ef-abf4-005056bdd08f;
	Wed, 24 Apr 2024 02:56:39 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 02:56:37 +0300
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Duanqiang Wen <duanqiangwen@net-swift.com>,
	"open list:SYNOPSYS DESIGNWARE I2C DRIVER" <linux-i2c@vger.kernel.org>,
	"open list:WANGXUN ETHERNET DRIVER" <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/4] Define i2c_designware in a header file
Message-ID: <ZihKtSble151A5mT@surfacebook.localdomain>
References: <20240423233622.1494708-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423233622.1494708-1-florian.fainelli@broadcom.com>

Tue, Apr 23, 2024 at 04:36:18PM -0700, Florian Fainelli kirjoitti:
> This patch series depends upon the following two patches being applied:
> 
> https://lore.kernel.org/all/20240422084109.3201-1-duanqiangwen@net-swift.com/
> https://lore.kernel.org/all/20240422084109.3201-2-duanqiangwen@net-swift.com/
> 
> There is no reason why each driver should have to repeat the
> "i2c_designware" string all over the place, because when that happens we
> see the reverts like the above being necessary.

Isn't that a part of ABI between drivers, i.e. whenever ones want to
request_module() or so they need to know what they are doing, no?

-- 
With Best Regards,
Andy Shevchenko



