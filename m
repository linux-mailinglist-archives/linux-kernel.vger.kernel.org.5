Return-Path: <linux-kernel+bounces-100433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80E879780
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC951282F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95D7C6C8;
	Tue, 12 Mar 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CRnpOGj7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB27B3E5;
	Tue, 12 Mar 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257231; cv=none; b=Lb+1oHz/OdisFBx/fAPIi+VACaDOsUDRnEAxLw/qGgdMdZJ+WAYJliT7tOxsRfpvXqfBHYmsVjTL9RGKFx2nsFn6ihadIa50U1ZtkkxutzYUZVPQB/FHqXhwc7hNu1DgJkYZ+q/bvHZ0tNLvtQpJtoZZCyjwXcHPeosek2amIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257231; c=relaxed/simple;
	bh=4QoYwtaR2a7omQwUBxbzONi95ZuvPaOkAYyrjfJKR4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD5ycwzvuSpf/ugnjVcIdDk4Tob2oCLvtjZeKhRmjwMXML4BLUNdMO0LyzfcIfjh5g+JmACbuDBqf39DtIxNqZJBGZF3fQ7Kg635mHOl+n7d4gMc0Nh+MIJH0z5lpmjHWW0wjVlvh0kRmAyWeI3i1dv5ceAIa9G2zFqzbMSpJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CRnpOGj7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4801D1C000D;
	Tue, 12 Mar 2024 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710257227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWFuTR9EE+EdIqMSgXCGOUuGRY+Sbvto2K1yVsekP80=;
	b=CRnpOGj7TSxW/oBFDuWtQSTRBDymEn+N+GFGLrqwHYMDbxl0k6vpiq3/omqTU6KmuljuPD
	9b6qkpj21I+TVHPARj/TzczAe7Tj0jcy/+H2GHFdlZrdj8oSBxbMKwOeGNX1jglMzj7sIv
	fDC+7bIqGoB5814s1iXA/z5bR8pRCwB2u/ng2dTw/iYokiTJata8NhEBkAK7Mpeu4ytxoF
	WzeW1WU+zdMqEh4xtTwKjE7EGvzgQCgooBhtxSfkFt8rMZKzdS3UL6cyb0g/4YZ2WNH5vL
	lnZGAM/lfybVVX3aqnsIQvDL7sUKZBKA+RTzTeK/N3yhk1dpZbnhXQ2wm639Pw==
Date: Tue, 12 Mar 2024 16:27:05 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: <taras.chornyi@plvision.eu>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <andrew@lunn.ch>, <thomas.petazzoni@bootlin.com>,
 <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: marvell: prestera: fix driver reload
Message-ID: <20240312162705.0097ee5a@kmaincent-XPS-13-7390>
In-Reply-To: <20240311135112.2642491-2-enachman@marvell.com>
References: <20240311135112.2642491-1-enachman@marvell.com>
 <20240311135112.2642491-2-enachman@marvell.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 11 Mar 2024 15:51:10 +0200
Elad Nachman <enachman@marvell.com> wrote:

> From: Elad Nachman <enachman@marvell.com>
>=20
> Driver rmmod after insmod would fail because of
> the following issues:
>=20
> 1. API call to reset the switch HW and restart the
>    firmware CPU firmware code loading was missing in
>    driver removal code handler.
> 2. Timeout waiting for the firmware CPU firmware
>    loader code to start was too small.
>=20
> Fix by adding API call to reset the switch HW and
> restart the firmware CPU firmware code loading when
> handling the driver removal procedure,
> increase the timeout waiting for this restart operation
> from 5 to 30 seconds.

Tested-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

