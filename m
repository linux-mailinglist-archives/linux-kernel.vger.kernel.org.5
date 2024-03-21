Return-Path: <linux-kernel+bounces-109898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9C88577D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F366A1C21275
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5A56B85;
	Thu, 21 Mar 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dlIcq+v3"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F23FB2C;
	Thu, 21 Mar 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017185; cv=none; b=KJGf1Xvaj2KQVHwzpxNEWbhco1jfigaAMMvVUh1qUKm3PJHuhV8nhFxGoYUiiFrRD8gO5Wr5Ug1u6aXiXZpBsR+YzBkgUsvLuP/eG7+FFRuQ1CunOBpaHn1pOQPwuMYRjhAMp10iEIgQBZ8DiKpn5a3wYS5gh1+cudd6ycOpfnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017185; c=relaxed/simple;
	bh=IsgJgtM80y8zcZyOXFGzCleStLkUBxOtrcW1tHKq1gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRj6QUh1UoZGmbKQpGTQLag3HwL/9k5mrJKEPg7EqDHgShOGbgcDyBfWk0km7Xnl1wZUze9nBAAQNS/MRjBhyq7P5CcdgVU7+SWff5Vd0J03MQUn6fDNJAWye4QrH9zBp+SiXwfoFQUwha7o4lRZJiM7R5NKJ6GDhiUHSnZu9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dlIcq+v3; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CD3A20011;
	Thu, 21 Mar 2024 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711017178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsgJgtM80y8zcZyOXFGzCleStLkUBxOtrcW1tHKq1gc=;
	b=dlIcq+v3fizKnPeaA0kQitG/JgzXMJFdLMAD7QAu1EKxz+DWSEMqtZjf2z1jeyXakioAWx
	JUPTnbYVxnTMJ0d2vKYOGEuooEKou3UVIFwTTaR/4oY/RZ/JUBJFPuUZHG34rnBjS6O87e
	aI5egh1vEAGDy1hEdDzLGPoN7UTa2HHkuXQJv9hcucmT9aR8EA1wBajbp0P3I8SfE95Fl7
	CjEOdsyoj8vij8jOcJw8KnbQ4l9JDSL0l5ZqB4Ku10MQ4wyu8rM6aeAfadtlkBSaVqY5FG
	K3q5N4ANRhmQVRw1/1VVUhPkRs193dI1a0M9g45k53uot/G9drB29mzWUTDXMg==
Date: Thu, 21 Mar 2024 11:32:56 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: limit OTP NVMEM Cell parse to non Nand devices
Message-ID: <20240321113256.7e66ac0f@xps-13>
In-Reply-To: <20240321095522.12755-1-ansuelsmth@gmail.com>
References: <20240321095522.12755-1-ansuelsmth@gmail.com>
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

Hi Christian,

ansuelsmth@gmail.com wrote on Thu, 21 Mar 2024 10:55:13 +0100:

> MTD OTP logic is very fragile and can be problematic with some specific
> kind of devices.
>=20
> NVMEM across the years had various iteration on how Cells could be
> declared in DT and MTD OTP probably was left behind and
> add_legacy_fixed_of_cells was enabled without thinking of the consequence=
s.
>=20
> That option enables NVMEM to scan the provided of_node and treat each
> child as a NVMEM Cell, this was to support legacy NVMEM implementation
> and don't cause regression.
>=20
> This is problematic if we have devices like Nand where the OTP is
> triggered by setting a special mode in the flash. In this context real
> partitions declared in the Nand node are registered as OTP Cells and
> this cause probe fail with -EINVAL error.
>=20
> This was never notice due to the fact that till now, no Nand supported
> the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> access for MX30LFxG18AC") this changed and coincidentally this Nand is
> used on an FritzBox 7530 supported on OpenWrt.
>=20
> Alternative and more robust way to declare OTP Cells are already
> prossible by using the fixed-layout node or by declaring a child node
> with the compatible set to "otp-user" or "otp-factory".
>=20
> To fix this and limit any regression with other MTD that makes use of
> declaring OTP as direct child of the dev node, disable
> add_legacy_fixed_of_cells if we have a node called nand since it's the
> standard property name to identify Nand devices attached to a Nand
> Controller.

You forgot to update the commit log :-)

Thanks,
Miqu=C3=A8l

