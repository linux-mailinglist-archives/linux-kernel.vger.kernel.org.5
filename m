Return-Path: <linux-kernel+bounces-111057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B5886771
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D877CB21CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05811CB0;
	Fri, 22 Mar 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CM9SHIfn"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF691118C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092320; cv=none; b=tygHJkzVgQQFmXIRnnjAk8lWf5OrejqNooR9XD+6N9svCi4ofvNJ42p+mNC0UTlqiSQc9csGtysn856u73GtTt/HYDBENv9a/KaKYzgVkvCyAy3puozXt9bTi3lRBkwUcLsB0auu0OUxLo+81YSeZmA4A+pN2hUWCx0+AWgkscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092320; c=relaxed/simple;
	bh=E1HU3MaaZuurSbEALSn4O+2+Vq9VJFs+Q64NGMlxrrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ9edbKcGktIw7jgs480t4XOOnFrXNjsoLNXkLk1Q/uZsRnXRNpkWfB2f28oPpt0z5whgxlFThvrxmo/F6aakahmPozNJLW9tN9gAeFRN+StGEGvWUrc0XOt1onRSpw024C3bFpQmJ3PueJdm8OydbcOhMwMCd6i3jst3sHGPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CM9SHIfn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D522AC0009;
	Fri, 22 Mar 2024 07:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711092308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1HU3MaaZuurSbEALSn4O+2+Vq9VJFs+Q64NGMlxrrw=;
	b=CM9SHIfnmGUNE1IzwOHvaAK1g9NZ1WvSYOa1vy60o/YQLH+EvEtHHb29PRtIBWb4L3RIDV
	0PiXPywzFRxF9wikKti3xzriBzcF/sQezg97XH8ji5eFsS79+JbYiwlA50ozVpBGSUJTL0
	87FqpXCjxeKhLVv9ok5FL2/DmyVXAtAKT0FD68aCxXgWObOW9eyubS1Jw9+qZZPOVzL1dO
	zu6WBd4zyihBgkUJVLxs0aOqzjad7LJgs2MdKNDE8XF9w6OO1c9In1GQ/E6jAzCsKOVrTJ
	OcJXrroAquMWl68MFgsx2UvUfun+9D+qHZV7M54eaPeQ5ZoTCdc0TW8GShIdzg==
Date: Fri, 22 Mar 2024 08:25:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Pali
 =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, Alexey
 Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH 1/2] phy: marvell: a3700-comphy: Fix out of bounds read
Message-ID: <20240322082506.6d4cfa69@xps-13>
In-Reply-To: <20240321164734.49273-1-m.kobuk@ispras.ru>
References: <20240321164734.49273-1-m.kobuk@ispras.ru>
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

Hi Mikhail,

m.kobuk@ispras.ru wrote on Thu, 21 Mar 2024 19:47:30 +0300:

> There is an out of bounds read access of 'gbe_phy_init_fix[fix_idx].addr'
> every iteration after 'fix_idx' reaches 'ARRAY_SIZE(gbe_phy_init_fix)'.
>=20
> Make sure 'gbe_phy_init[addr]' is used when all elements of
> 'gbe_phy_init_fix' array are handled.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native ke=
rnel implementation")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

