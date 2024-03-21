Return-Path: <linux-kernel+bounces-109829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4635885631
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5F2828F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92B3BBC2;
	Thu, 21 Mar 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yj2wxetE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAEB12B81;
	Thu, 21 Mar 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011974; cv=none; b=CvXq++kOGHxil1Sk/X7/AFw47V/bw3QJWR720q5wRqlz1bxZD08GIsoq3LrbJUwV0nLx/IJf2OaY6bcFfLYvL1gzER77332ARm0YEcGAjiwHJEW+HHGQMBOLwgdW+aLSnuDPNLpIJ4UqO+7eiZ5qndXPnH3QVeaaB3onKHxDctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011974; c=relaxed/simple;
	bh=ApUe4g5isArkGJCqj6ovGwuBj4eEwcEl+XEuUF9koxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG1V56emxfGqXM/Mo5GZzidYOtav770K9iakbwQ/h8taclUknySiJB6FQH8YpF1tIw+hV1W3zJ7xmgNLeFaf1gCWzsk0/hQK4hsfTlT9IR/GxM/b8veXbL8U7s7wS4OqLjMIrcAd27axma/RimH+2+9x+Kn10yStIiHit8UiUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yj2wxetE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6533B20004;
	Thu, 21 Mar 2024 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711011963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApUe4g5isArkGJCqj6ovGwuBj4eEwcEl+XEuUF9koxs=;
	b=Yj2wxetET2SzxRT8SrwtiFJW4QlGc6ABbexCsTEu6+TvVJYsrjdrA6TpTVJtDaX709Dok4
	aSaLyQAr86M+uRWv54c3SYfBc1NXye+DAgfsqdZWTnfxg6pTT2LqloAawCRefOHndYats8
	kW4CklN1vjzHU1nryCLAgdvgFrZz2rIR3Wjeys0tVJfmeZEpkSBMN2kolccvrxUcbHookM
	a4Eom/MjxbC5Wn+1j3z7JD/jx/bTwxTLW/KO1D2sC+ho3NfTpFNUG1zi/P5vBYRQQ1rxZU
	jmFqMIZOGp2Hwua8Y2oqAkYTvTqPiAH7Xz/EO4644Oowybc/3FdbnOaWsHggCA==
Date: Thu, 21 Mar 2024 10:06:00 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: <taras.chornyi@plvision.eu>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <andrew@lunn.ch>, <thomas.petazzoni@bootlin.com>,
 <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
 <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix prestera driver fail to probe twice
Message-ID: <20240321100600.5ccba11d@kmaincent-XPS-13-7390>
In-Reply-To: <20240320172008.2989693-1-enachman@marvell.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
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

On Wed, 20 Mar 2024 19:20:03 +0200
Elad Nachman <enachman@marvell.com> wrote:

> From: Elad Nachman <enachman@marvell.com>
>=20
> Fix issues resulting from insmod, rmmod and insmod of the
> prestera driver:

Please add "net" prefixes to all your patches subject, like that:
[PATCH net v2 x/5]

I think the maintainers bots won't works if you don't.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

