Return-Path: <linux-kernel+bounces-3195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D38168ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4961FB21E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6156111B6;
	Mon, 18 Dec 2023 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="rLVZ4rwO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461111C92;
	Mon, 18 Dec 2023 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 3C6734FB;
	Mon, 18 Dec 2023 09:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702889422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7y980s7TlqjCCAo0oCLZY8k6BxPJ803Kug7xEFCoGk=;
	b=rLVZ4rwOEPGlYUtRcUAdVLk5m7XBx4vX8PZBc+L8VhucInDrJkExOLW9giC4bwcIbREtbU
	Je3WaYQXn/btQGQQqiPpyyqWcA5DRdeh21JyX5yDS/u1rYCWa45KnBM7IUGDavZRTav2Zl
	X0MH9Ty/zWgE+4zV9He07kqI56vn0wrFZaDJkyWt5UFfTcMlHLoEo7QJBhNpSIsAekAwQt
	sWrBUMuBVC+YmODug75aTaImAUbgmuPqVvVJlm347hwJ107AoXamXtaJwJaQkjz6dMnJf5
	dF6wdDqyd9iC56O6rdID2Z8HXpk5Zj3Z8CaKqC1zg0wmij/i6sGW3A5vGJgyQQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Dec 2023 09:50:21 +0100
From: Michael Walle <michael@walle.cc>
To: =?UTF-8?Q?TY=5FChang=5B=E5=BC=B5=E5=AD=90=E9=80=B8=5D?=
 <tychang@realtek.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
In-Reply-To: <be8db58b51d04043a255a702a08cdaba@realtek.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
 <23574204547646779d02f0109c20b3ff@realtek.com>
 <ZXsKAyIlY3y3tgUi@smile.fi.intel.com>
 <0f0b3b65a838aea6797ae78c47d6af49@walle.cc>
 <ZXsV96xhuvVSyc1f@smile.fi.intel.com>
 <be8db58b51d04043a255a702a08cdaba@realtek.com>
Message-ID: <3dd3a101e61f5a8f8931114ddc80cecf@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> I have looked into regmap-irq, it appears that using the default irq
> thread_fn(regmap_irq_thread) is required. However, due to hardware 
> limitation,
> we need to inspect the IRQ_TYPE to determine whether to manage the irq 
> within
> the irq handler. I think our irq portion does not perfectly fit the 
> regmap-irq.
> Moreover, it seems that the gpio-regmap.c file needs to be modified if 
> the GPIO driver
> requires debounce settings. I think the gpio-regmap may not be 
> appropriate for our driver.
> Do you have any suggestions?

Can't say anything regarding the interrupt handling but adding literally
one line to gpio-regmap shouldn't be a reason not to use it.

-michael

