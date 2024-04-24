Return-Path: <linux-kernel+bounces-156040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA58AFD09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8072B254FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5DE1C14;
	Wed, 24 Apr 2024 00:01:30 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B0193
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916890; cv=none; b=RltDxGvA0PvmuSaSP+Rz2yivJUt2XMY9CNItO0Xk4Sbr81D9/oH16Xzem+y+uODvN0LdCqE6+U2YdyuhoM+7dLqkvdynHfq9F8oS9NbYFZkOM6WeK3CaPbVZB/DxkxHR+PWTeP4P0VgEVwRj2IqhtwEyuR1fXiWcQuL3uZReP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916890; c=relaxed/simple;
	bh=yWWZtVuFVmsAHihQ0rbT6L7WRYIXUYZVJCHeb4B1eU0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdop22e6PKiL7/m/eHEJfESmuMW5KwYP7bO9SUFXsd5p0riagAOG6LShpXr8znld1T2waA9PdHrTrvha/6wLmUzoxf1FkY6qzHBnRuN3c0+5leuNyk6mongAg0DRp5ny8mcLenXCfzDWC2d8GO9TbXJ6wB3uHZCt+9Y5Dgz+DBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id cb8c8f3e-01cd-11ef-abf4-005056bdd08f;
	Wed, 24 Apr 2024 03:01:26 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 03:01:26 +0300
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
Subject: Re: [PATCH 3/4] mfd: intel_quark_i2c_gpio: Utilize i2c-designware.h
Message-ID: <ZihL1mb1OzwdLSvN@surfacebook.localdomain>
References: <20240423233622.1494708-1-florian.fainelli@broadcom.com>
 <20240423233622.1494708-4-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423233622.1494708-4-florian.fainelli@broadcom.com>

Tue, Apr 23, 2024 at 04:36:21PM -0700, Florian Fainelli kirjoitti:
> Rather than open code the i2c_designware string, utilize the newly
> defined constant in i2c-designware.h.

..

> -#define INTEL_QUARK_I2C_CONTROLLER_CLK "i2c_designware.0"
> +#define INTEL_QUARK_I2C_CONTROLLER_CLK I2C_DESIGNWARE_NAME ".0"

So, if you build a module separately for older version of the kernel (assuming
it allows you to modprobe), this won't work anymore.

-- 
With Best Regards,
Andy Shevchenko



