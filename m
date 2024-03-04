Return-Path: <linux-kernel+bounces-90301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563DB86FD23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115D1283541
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3118EC3;
	Mon,  4 Mar 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MFmwpgHO"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA612E73;
	Mon,  4 Mar 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544115; cv=none; b=pX2nyCIkv3ch9mF5BAbj1PMA6N6NY3PUnR8+5u+rxStDbmc0VEoLI92iltLeInchFna1BNQbG80w+hVwyqi8thvCLamIfeQBLerX/01xk7XsiaoDzr8/5c2tlsxfQ4UvmmVEROO5F+HcYbM6n9dOxOj/pST1+jmLrQs9l7han90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544115; c=relaxed/simple;
	bh=ksOqlYY4eSQHiYECRK/IIOdgenRG+JUn90uhHqMkQy8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=rEEPGBS+z8VLJHqfznWgSiRGRYDOgolLez0fI5PAMPQXaMPi0WFWsHMGHS2zH7hVKip+mVWIORfQyZlDvXlP3YLi1p4ZFPtLaNTzEql0zOanAXWuTLtc1mcyqt3K/1jzRVCMmGmbai+G8F8gO72UFHwNkJ2ZMKIOZZXc4001Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MFmwpgHO; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A4DA240002;
	Mon,  4 Mar 2024 09:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709544105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksOqlYY4eSQHiYECRK/IIOdgenRG+JUn90uhHqMkQy8=;
	b=MFmwpgHO9G6ggCW1sniaYtRNodOXdynmxY7Zm+ErNQqpN7F5sLKrBDZ3acSMw/Rc6VvZnI
	2sSiFig4GjQ7nV/rLbb33leoQ5HHcqm+8efGpdZ7tb7YWSLoQ77JXHs5qCLqU7Um4CtZX9
	iVbv+0G8pcak9bZdjUrkDNTl4mbRkUBLq7aqOtdNXlKT2qW/JAfzX6okreVGwNLtReFUbh
	griBPBlRDh86GmziyIdI04xC5DG+WZZpvIA2meSHwymGm4icc2nn9ZBA3rj8KYpfbNFusI
	ouJUn0v2SBq5tr0SXSGjLCVY9ODhPdxHU8XQpBlu3ZMhA7EDperpGE+PgZlSTQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Mar 2024 10:21:43 +0100
Message-Id: <CZKUT3B1GRAC.19GQOH3JTKT10@bootlin.com>
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Bartosz Golaszewski"
 <brgl@bgdev.pl>
To: "Linus Walleij" <linus.walleij@linaro.org>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 1/1] gpio: nomadik: Finish conversion to use firmware
 node APIs
X-Mailer: aerc 0.15.2
References: <20240302173401.217830-1-andy.shevchenko@gmail.com>
 <CACRpkdZudHHkFcdmHB9mWGriV0EtvZrjiGUHF+b7W2L=t6xmwA@mail.gmail.com>
In-Reply-To: <CACRpkdZudHHkFcdmHB9mWGriV0EtvZrjiGUHF+b7W2L=t6xmwA@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Sun Mar 3, 2024 at 9:44 AM CET, Linus Walleij wrote:
> On Sat, Mar 2, 2024 at 6:34=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> > Previously driver got a few updates in order to replace OF APIs by
> > respective firmware node, however it was not finished to the logical
> > end, e.g., some APIs that has been used are still require OF node
> > to be passed. Finish that job by converting leftovers to use firmware
> > node APIs.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > v3: used correct types for fwnode (LKP)
>
> OK took out v2 and put in v3 instead :)

I'm late to the party. Tested this v3 on Mobileye hardware, all good.

Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Have a nice day,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


