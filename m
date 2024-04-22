Return-Path: <linux-kernel+bounces-153694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28308AD1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58466281046
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620315381D;
	Mon, 22 Apr 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="apwd0xpN"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B321474D2;
	Mon, 22 Apr 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802844; cv=none; b=TNyg6yOiaE7jRLMoP1DzDx6IUyZMG+ky0ymu58i3PgbgTdH2IaS9tJBnNSxYAieykUOlewPiF2hK2LwYHfFPGzyjto4FF/XPOjrQXdtT6+pIGUHFU+HPfCX/PH9b3QJrhULn+OKxymbq6MWcWzEm1JyE9Q6Vj1CVdmV6vvxIOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802844; c=relaxed/simple;
	bh=H+5ifd3rJFrn7La+R7Jq0qBUFBBAzUtH9vz5BUqJqno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjzpa0GdJV2DpEd5BPq9v+k1Mzzz4uSs4mAeAnk+/P8Lu1tOfYDlyugL6uaoAapSUF1ON+Af7mnS4LJX2OypF1diuGtBmdnUsVsR/uZJk4CC3BS2tpEAHRHAa8VfCB5YRlLKTxZsJTf6i0PGfWKfSNFWrWlt2PRZV6ZPSQwMFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=apwd0xpN; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DFE7FF80C;
	Mon, 22 Apr 2024 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713802833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+5ifd3rJFrn7La+R7Jq0qBUFBBAzUtH9vz5BUqJqno=;
	b=apwd0xpNA1Qt0vvFaHPmcY9lgnXnvJjbS8S60Oifr66DhJ5GQIzlPoZVTsSv10r2CkgjvU
	bV4BN/WPut0OWOYNgDyWBQ1SFkLv/oEhA8otZhNV+OUrw6jJVDHrmYUQrDSPE5YnE2SUgf
	uADijSy6PQ8Pdlt75Z/GcpvF91xCkGGH4ZUGl1M39K0s0iKzvMuqHWm2JCvbqX3lc6+uBi
	npkz+4+IoCbMJb6sVjTwiGBSKF03hibwmFlC3sl+q8Hk/onvwFAjMszbIpBlZ5iXGgd3kE
	uQ0pTONFlZt44T/sYdr0uemom7Jq0UTvc8XWrM3UD71MlpK0VIrE1QHQQWk5Yg==
Date: Mon, 22 Apr 2024 18:20:30 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 2/3] net: pse-pd: pse_core: Fix pse
 regulator type
Message-ID: <20240422182030.34524046@kmaincent-XPS-13-7390>
In-Reply-To: <ZiZ7-n5q3COmPRx6@nanopsycho>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
	<20240422-fix_poe-v2-2-e58325950f07@bootlin.com>
	<ZiZ7-n5q3COmPRx6@nanopsycho>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 22 Apr 2024 17:02:18 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> Mon, Apr 22, 2024 at 03:35:47PM CEST, kory.maincent@bootlin.com wrote:
> >From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >
> >Clarify PSE regulator as voltage regulator, not current.
> >The PSE (Power Sourcing Equipment) regulator is defined as a voltage
> >regulator, maintaining fixed voltage while accommodating varying current.
> >
> >Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> This looks like a fix. Can you provide "Fixes" tag please and perhaps
> send this to -net tree?

Indeed I should have used the Fixes tag.
The PoE patch series that introduce this issue is currently in net-next.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

