Return-Path: <linux-kernel+bounces-72775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D173A85B895
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237A2B27C35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769DE62160;
	Tue, 20 Feb 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJtwup74"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584960881
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423626; cv=none; b=Sb+rlRuufDOOuQFe86uDMFiN2gLeaiDyDsxh5avvxfGEsfx9zGatsZd0sFFROsA1yDiLBMSM54kiHTSrU+a522lHGbPY25fOkEajqXHsGOqfHhTh+b98IZfnteLHJ5pK3cuRXVWkLQB4zngdtVeQvxwser1oCInHw9gllN+JmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423626; c=relaxed/simple;
	bh=vfsBzlvDSKZlgnd0dC5lHTjvH7sh9tVzDUOPiFEh3K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3KkhfuhtHXDVfHTOPOa8K3swg8RGs9F1ZCdxE1g6gJDtLGc4dmUmglbZKAb4fMTNuJjxMlLZhvL1t+k4V935+mU0/W3axArOJO0zK83lnjIWS2daVU/9dWJqQ2QAfdEyx+TFSClfCIpozCy1jZfXxChwcmOdMjvWYWJ+dWXa8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJtwup74; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EACEC000D;
	Tue, 20 Feb 2024 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708423622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfsBzlvDSKZlgnd0dC5lHTjvH7sh9tVzDUOPiFEh3K4=;
	b=RJtwup7441NP8SZ24w+gxrC99nCEvg7FFQzXF8A2z2zUzN+evmbndKm73xMnqJpzucoaMh
	UzN3yjA/dL0nMh3Rw0+EIfmE85b5/5vzqJPBXVpPTXDbF4I2JTdEIYvBW4psJHh8yShPCg
	+FEeqwtCb8ZaTtjwzfZBm8l9ZHlLx0/1Q78nTvqcVmEPVnN0ef00u8Jv5JEVumzZERAqA1
	OunMaR2AD+LpGZKRddLdN+4cYzJqpqGOaOpA5w8cnXm7feDEvApoo9mIsnBrpvASmdVA7N
	3XMIlNqSeiYAhc2IT4zhIDzK4kJkpGyyFx6Ive9z+WZUjv4d0nBvsgnbuvbS6Q==
Date: Tue, 20 Feb 2024 11:07:01 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michael Walle <michael@walle.cc>, srinivas.kandagatla@linaro.org,
 gregkh@linuxfoundation.org, rafal@milecki.pl, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Message-ID: <20240220110701.5ac88fed@xps-13>
In-Reply-To: <20240220095038.2betrguygehvwodz@pengutronix.de>
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
	<CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
	<20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
	<20240219120414.32395299@xps-13>
	<20240219115358.xui5fpoisvsubdyb@pengutronix.de>
	<CZ938PEUZ1JQ.2DJE7C03HI9OO@walle.cc>
	<20240220101811.6ae23f2e@xps-13>
	<20240220095038.2betrguygehvwodz@pengutronix.de>
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

Hi Marco,

> > > > Regarding UBI(FS) I'm not sure if this is required at all since you=
 have
> > > > an filesystem. IMHO nvmem-cells are very lowelevel and are not made=
 for
> > > > filesystem backed backends. =20
> >=20
> > I'm really talking about UBI, not UBIFS. UBI is just like MTD but
> > handles wear leveling. There is a pending series for enabling nvmem
> > cells on top of UBI. =20
>=20
> Cells on-top of a wear leveling device? Interesting, the cell-api is
> very lowlevel which means the specified cell will be at the exact same
> place on the hardware device as specified in the dts. How do you know
> that with wear leveling underneath the cell-api?

https://lore.kernel.org/lkml/cover.1702952891.git.daniel@makrotopia.org/

I haven't tested it though.

Thanks,
Miqu=C3=A8l

