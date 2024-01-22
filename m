Return-Path: <linux-kernel+bounces-33954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785EF8370C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30BF293F65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35F4439D;
	Mon, 22 Jan 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CiwkLTW3"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3744381;
	Mon, 22 Jan 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947423; cv=none; b=CMqhh30dRKZDhdase0baAWroImeJX0CT3tz6Ew+muONph3mgT7EAr5RJIQMnJ13vG+LdSbUijhKXKy/D2UC4OSd2JbFQ4a4SePicX6+iNidV4YaKfXoeDHh/4jpTyg5qJQNV7f/3wVVbAG2ohUyzGQw9droKXpIhaq/U8YrwE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947423; c=relaxed/simple;
	bh=EJO7ijoy/QEyNtkXI5m0dLezfhXMbbi40EIs5xDpTNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9V2gpGj24ZXp89mmVPiUJRQUXpTHqmnkln2MJtyTLV4oRTOTmE9jDFlibSbiDZuK5BZG8H96MshREkDW0Tew8c+KJ+8YR8kuPK8e1OkG/F0S0KLBHZZI4A5tse5Qxa6nIU+4urvLYeG1Ey41m7LurDDWDISlYAJKunDS85yG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CiwkLTW3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 199FB1C0006;
	Mon, 22 Jan 2024 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705947418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJO7ijoy/QEyNtkXI5m0dLezfhXMbbi40EIs5xDpTNw=;
	b=CiwkLTW30HAq8YFrXK6atoT0l2XdjZd3qmaXQJ/VjXYEmI5zC8E7u17mfvI++Icaf62caw
	BZeks39EpN24q6ATPbYW2L6YoHBHRWiK0/asNvq6O2fQG2EbH/RcwCpq8lXwiEyT3s5zGW
	xMSDGjKTdOvFbxenrPd17/Sjn0W7CB260iJXHm0MvUSFxzMMb1zkihOynkvcnFlIe2MTW1
	TGgKKVg0DGh49LtJd46zd0eCTRaubE+yWNOdV6EvBJWMumk/DWGCqCBIz9/bwWvkdmGXsu
	oRCBVb/1PJN4BI8odcy52PRWMmDP0NEBole9OU7Wzy8qj/u3juWzN3e2vn3teQ==
Date: Mon, 22 Jan 2024 19:16:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 02/33] ieee802154: ca8210: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240122191026.1041a09f@xps-13>
In-Reply-To: <145fba5c430e40114ab861229e52efd3ff941e42.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
	<145fba5c430e40114ab861229e52efd3ff941e42.1705944943.git.u.kleine-koenig@pengutronix.de>
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

Hi Uwe,

u.kleine-koenig@pengutronix.de wrote on Mon, 22 Jan 2024 19:06:57 +0100:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

