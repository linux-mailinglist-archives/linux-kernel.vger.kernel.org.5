Return-Path: <linux-kernel+bounces-52878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D2849DBA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADFA1F22E79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724252C691;
	Mon,  5 Feb 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LRqzQoMw"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775772C6B7;
	Mon,  5 Feb 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145898; cv=none; b=Rik3nXkPaYh1U5PfVqiKw0Tj/nqDOKMGV00TOdAb2UepGwk1yMQvEpvm+CqHz2jMwXapB4kHK2y7IbUZrLI8kbwV7Gvw7ZhIMgLwP5fNKcQVprsRG3UTWl/6l0ZyHtf1poimMLcIOT5zSybo/wsenc3qQRh4vUmtFTM5aY+BfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145898; c=relaxed/simple;
	bh=or1mC3Cf+BGWdRGGha8GQZG8rLMB4ONTBBAhWbyuCyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K358rN8E1d2cn0DuINjIvhJj9L2bMnh34Uj7i5RdGyE+sabc2f4yQ193fHbVmLAJLk8ZpV+FO1RF35iuQNeB9dJId9q6oFohF7qy7fVUT3xPf8u35b7vXkJ3UwnyciaOHxRIH5Ec6ZPDU2weRFKPnAcvEMr56shWz7LxlTmq9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LRqzQoMw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0264C60004;
	Mon,  5 Feb 2024 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=or1mC3Cf+BGWdRGGha8GQZG8rLMB4ONTBBAhWbyuCyU=;
	b=LRqzQoMwi0LqJMn0BW7k9Q1PJnJOdm0smu8g8xANoGjCCjB4wSIO9lrD0rzsjkaW0mL4he
	Rrh0x+s78SdEpCrUOfDzXTvS1f6SvnfCoKy6cpXrqkgORMC60KGC8oQ1K76cy0nv1FDwcp
	nJx3hC9Du2oCn4qyDqL9IOYfRslZRh38kJ0tNH1hC+EQYpRSvOKhAk4FO7CF+hpyQrYvEb
	YbCVk0glppCgwpO3sEVsbCh8IjonYY2p4WiLvOZ88SQJT9z8waw/Yl/Z8eelCF+F1Wl6Eu
	i1X+9h5/XoETw2OMXInCqaxmaw2GU59MhKQcwdPb2dzKyldyOCRgcInWBTRmwQ==
Date: Mon, 5 Feb 2024 16:11:29 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 saravanak@google.com, abel.vesa@linaro.org,
 alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com,
 bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com,
 djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com,
 fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org,
 heikki.krogerus@linux.intel.com, kernel@pengutronix.de,
 linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com,
 magnus.damm@gmail.com, martin.kepplinger@puri.sm, rafal@milecki.pl,
 ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com,
 sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com,
 vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: Re: [PATCH v1 4/4] mtd: mtdpart: Allow fwnode links to NVMEM
 compatible fwnodes
Message-ID: <20240205161129.1889a943@xps-13>
In-Reply-To: <20240123014517.5787-5-mcpratt@pm.me>
References: <20240123014517.5787-1-mcpratt@pm.me>
	<20240123014517.5787-5-mcpratt@pm.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Michael,

mcpratt@pm.me wrote on Tue, 23 Jan 2024 01:47:21 +0000:

> This reverts commit fb42378dcc7f247df56f0ecddfdae85487495fbc
> ("mtd: mtdpart: Don't create platform device that'll never probe").
>=20
> That commit is a manual named exception in order to avoid fw_devlink links
> to an "nvmem-cells" compatible node which is a descendant of the fwnode
> that represents the real supplier device that probes.
>=20
> The commit does not work for newer cases, like the "fixed-layout"

Do you have plans for it? Because it is the modern description that is
now expected, so I don't feel convinced by all this work (which is
nevertheless considerable) if fixed-layouts are still broken?

> compatible nodes, but instead of adding another compatible string,
> remove this workaround as it is no longer needed after
> the previous few commits which handle the situation in a generic way
> for all supplier nodes that are a child or further descendant fwnode
> of a parent device that can probe, including when the consumer device
> has a probe attempt before the supplier device, by using an existing
> incorrect fwnode or device link to recreate the correct one.
>=20
> Signed-off-by: Michael Pratt <mcpratt@pm.me>

Thanks,
Miqu=C3=A8l

