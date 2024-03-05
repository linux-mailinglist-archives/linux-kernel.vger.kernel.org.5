Return-Path: <linux-kernel+bounces-91809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E28716E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CF41F21228
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A787EF18;
	Tue,  5 Mar 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HZldMEhT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854437EEED;
	Tue,  5 Mar 2024 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623841; cv=none; b=iwQRDUW0gbQH9OshXHRvEF1g+ca5Od6UzzFwNq0fltFTNWUlVJsIRf0Ef8pgtWwhnPBlG0HSgVxOTPnOG8yE3EwDORMZzrC/wcxeYs0/trYDjZ4ZpStFoQaHHzCioOHO6FQ1FJHtyJLw1BHHkWLdvNflVFk4B92LA5OXvv3WyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623841; c=relaxed/simple;
	bh=yQIBy0qAVUfBRKGIK+sYwyQgV6nkRizUnW41Ib6QBHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhvFUp7XSidQif8sSFTt9Wl6lUCsg2oFvezVku8a8EXuA3HTmNyD7uSA0B+tqH3S0hiyQv2GAlWR1+lInFK7Vwou1xryq8ZS1CCK86xg8gZVR7pap0UkuyV5oxTtNLTBJSbqDupyGxhhmKH5jTJl71+4n7PhIgL3nxRdvyvq8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HZldMEhT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18AB61BF206;
	Tue,  5 Mar 2024 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709623836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nC0cWtvmF5x1A+WyJrGetk0ETMalgbT5tTFrwZ1CtpE=;
	b=HZldMEhTv5Go3jOyftYUklwgkm6m/xxeoYgWRP1nQtE1Db0IUTnQoaWVGjjNG9t1NaTsDp
	5NoOl3J7ecTs/+elZVygkdpDowZ7mA3mPg9IgbRWCQJoPJyRktpBbG3KAAXJbjqq7Ga36E
	kzkVSRmJqkP8PTJqo2hBtw2VUH7EQf6tVPX8H984J62JFeZDHG6EUPLb474lOo4sLmT20I
	TnpQP7ZZBHewKCMykJbEtYtj1/QI82+famTJpUoMBHiWuh8yku6mDmmpPByPNkD8T0l4yR
	XNlYEFN0R0FA7HWISFfxC54VTRIxAVe5yxrosmdT6N1ZsCUMl3XnwT2Vdr75MQ==
Date: Tue, 5 Mar 2024 08:30:34 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: at86rf230: Replace
 of_gpio.h by proper one
Message-ID: <20240305083034.3fa0c5ec@xps-13>
In-Reply-To: <20240304174218.1198411-1-andriy.shevchenko@linux.intel.com>
References: <20240304174218.1198411-1-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Mon,  4 Mar 2024 19:42:17
+0200:

> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

I guess this will be queued in wpan/next after the merge window,
probably by Stefan.

Thanks,
Miqu=C3=A8l

