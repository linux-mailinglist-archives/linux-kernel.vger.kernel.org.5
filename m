Return-Path: <linux-kernel+bounces-80235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFEF862C5A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A41B21193
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9919BCA;
	Sun, 25 Feb 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ckuTE90Q"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065F18B1B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882573; cv=none; b=md6urpwa67HmyHcVizIaD1lQX1w8stAi933nk1TYUHp5RU6ZE/JaQJ6rfUYCsgBwLYQP12XrLXHHMmWRPrGkeMy0OADa3Abc7BoLqF5gXmIBceYyt1samEveonDBYM608jvsx/x9TrAjvQxabcJIsNK1SDpmtznWkXuUJhc2s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882573; c=relaxed/simple;
	bh=4lhzB69Iuo/Z5wWUbCxtDG7+U02BeKBwQXu94Rz2GIE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVBrXcMRjyioeCaxq0My+/G+zwTl78s7+ueYQqiz0BL/zO2Y0MCMMQu6y2z9b4oX/CBoHxyQiyIlhObiA94E2hvhaWpJ63KUKcuf0Y79fK+tFUs5eQPTdhIxa6OZrFyo7wwO+n/gMvmOe9Zw8sw4P3XQWeGAJ3LC3gAB6WL7lI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ckuTE90Q; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1708882562; x=1709141762;
	bh=4lhzB69Iuo/Z5wWUbCxtDG7+U02BeKBwQXu94Rz2GIE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ckuTE90Qbek7pBioZbbkC4yupNCWVCg+l681yf8ZG7EaCekoSF6o9t0bGmDmodiqo
	 PWBvUXUxZ+TuidO+5syld+5p/217N9QNqnWpHqlZP1QhLOZW7AJXOWvnx571J0wpsv
	 8tBSrXxJyasYNuah1513j+TEzms/bpFv3T8WfW3H1YcW7rLbz60NjabO9ld9mmUK7K
	 pNGqNU3WMP2RvwkeOv65G2wEG5BDYabUl2vOnM5hPMdlk2nBEqrI8A05CZqTIIbBUO
	 8J5zdVbb1d5c+Armpd/QknubgxBXzUee9M+VijGZbmksJYpvM1J0z6hFqJJib2Jh3w
	 0yg9um4rItQtQ==
Date: Sun, 25 Feb 2024 17:35:43 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, saravanak@google.com, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: Re: [PATCH v1 4/4] mtd: mtdpart: Allow fwnode links to NVMEM compatible fwnodes
Message-ID: <vNvsSK54-CaXTGbXYWK5uzLwvW8tGEOBE4h9drvazsF0GMNS7GpS6uFn_3OsLEZEu-jdZ5hYg7-43lbYaxqtNYuK9tMcmVuc5_7i77kyb2Q=@pm.me>
In-Reply-To: <20240205161129.1889a943@xps-13>
References: <20240123014517.5787-1-mcpratt@pm.me> <20240123014517.5787-5-mcpratt@pm.me> <20240205161129.1889a943@xps-13>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Sorry for the wait in replying.


On Monday, February 5th, 2024 at 10:11, Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
=20
>=20
> Hi Michael,
>=20
> mcpratt@pm.me wrote on Tue, 23 Jan 2024 01:47:21 +0000:
>=20
> > This reverts commit fb42378dcc7f247df56f0ecddfdae85487495fbc
> > ("mtd: mtdpart: Don't create platform device that'll never probe").
> >=20
> > That commit is a manual named exception in order to avoid fw_devlink li=
nks
> > to an "nvmem-cells" compatible node which is a descendant of the fwnode
> > that represents the real supplier device that probes.
> >=20
> > The commit does not work for newer cases, like the "fixed-layout"
>=20
>=20
> Do you have plans for it? Because it is the modern description that is
> now expected, so I don't feel convinced by all this work (which is
> nevertheless considerable) if fixed-layouts are still broken?
>=20


Sorry for the misunderstanding, I was referring to the already existing com=
mit
cited in the message when saying "The commit does not work for newer cases.=
."
which is why reverting it in this patch is part of the series. I'll reword =
it.

>=20
>=20
> Thanks,
> Miqu=C3=A8l

