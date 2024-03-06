Return-Path: <linux-kernel+bounces-93484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C001873081
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F6C28714E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF705D75B;
	Wed,  6 Mar 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gN6lJXYr"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E2171D1;
	Wed,  6 Mar 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713093; cv=none; b=DgNhftloU5MKoltNEFF43laNd/qh1IM/7wSpXCpfdxMSyFs80irstg2IsDzusPCE+LsXKgc4ngKorVznqnY8zICAVemcC73ly8xk1n1GD94i/aKOQ9y2YoM2F10XY1CWpXp5djDal5hDvs5dLgdqJp7hqTCV10KPjmnDiDxh6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713093; c=relaxed/simple;
	bh=RQharEHEYWoPma76ARZR3AdbTSGUP1YPwJ6YXDDDB04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdO53jsoXjh24CHmQt8Z9C8E2LeypvPpm9iFuLfs/K4uxt6+IcD76JlDKhkJGVI8t51Lm4nIUbZTaC1rpyMLeAbRo8AJK33RgQY/LvQnVmZD1SPtRwV6hT9k07xxGa6o5QtwZIhQK7tssuXgGUfeAG5Ex1BqT+IhbZRlF1NC/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gN6lJXYr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DCDC40002;
	Wed,  6 Mar 2024 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709713089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQharEHEYWoPma76ARZR3AdbTSGUP1YPwJ6YXDDDB04=;
	b=gN6lJXYrVjraonAorfjFbeu7zHFeBxGvARW6ndXzV4XLAUPjJvGpxMIUq+iFToy2iUBGgw
	IwhLLERxMg/5AjsejODXwLhh8X70PfrKIlW5xiaQSKxhfMl1tyIP7E4LwvCeM0Co8qH3nj
	hpctzJnH7ekEqjf9q/qRe41uJBwOZy93Z5bMKoHD1pcU8SlYGOt9rc/5/v2tplJMzvo45T
	DmJEGL1jlJg1khqZcy+JzuVnnRADeRtR9iiR0Ektd+d/0pCbvXe6E97K9ikS5tXGe/Z0+N
	zut/Jdx0XW7wJTmPrhUcqBPyZwtFgx2MJZABVcwmtblB/gar2toakAZVhlt6VA==
Date: Wed, 6 Mar 2024 09:18:07 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH wpan-next] wifi: cfg802154: make wpan_phy_class constant
Message-ID: <20240306091807.4fd6a6a7@xps-13>
In-Reply-To: <20240305-class_cleanup-wpan-v1-1-376f751fd481@marliere.net>
References: <20240305-class_cleanup-wpan-v1-1-376f751fd481@marliere.net>
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

Hi Ricardo,

ricardo@marliere.net wrote on Tue, 05 Mar 2024 16:55:24 -0300:

> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the wpan_phy_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

