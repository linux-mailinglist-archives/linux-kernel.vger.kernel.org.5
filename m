Return-Path: <linux-kernel+bounces-158715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC58B241B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FD7288384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202114A4DA;
	Thu, 25 Apr 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kYH3808D"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AE14A4DD;
	Thu, 25 Apr 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055415; cv=none; b=nymhe/S9PtGIBK3ckIUCrcuacQsu3V2NiRLfntohr4IQLlMlsH0VJmfveOTLPVoKOyVc/pTEfkl11FBkA1p8i6qDefu/nTt8eDodCFz6fPBmzDcosk1IvN3I4/U0KFvpjRKCiYDDMXsBn125d4QtUYxMrPUIDdEwv1fEgLLTqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055415; c=relaxed/simple;
	bh=TEW1mcZD9eKXNx7NEGVW7zx92fjFU0ygxRhQm5D3gt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7gJ6W4G2aFkAZyvO0wfBtPE0jqIpfdPe/FW0i+zr2OLRgDyAq5LTtok287V21FwGCEOem7bid7R1UjYfHfeVWOJsaDJatb5ABAHp5u4GSu1XUk1c6wwdug22Dd9AtwMHLlfjs4WS43oTXN1a+NCSq//emMgMvrs0dX/p32L7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kYH3808D; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6207540010;
	Thu, 25 Apr 2024 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714055405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEW1mcZD9eKXNx7NEGVW7zx92fjFU0ygxRhQm5D3gt0=;
	b=kYH3808DYYExVlgH8uPTwp7AfZX5ZmagrS5zr7XMxoNIFdeT5JWrDxygAuA6ljrkavT8sM
	jAl4B/XGssFjE5/po7i8V0BjJ5fvhBA8T6hxOvF2KSNYbiKeQdOYRhINQPHZ1UuMOf0wXs
	yNLhUNFsXRbp+IKrLQjN4RbAtAf32o6lF2MWbmvO3Ibt1bF/BM/3LOFVtyGWkfqcRzITek
	opWhLKCxP3LN+ZICJMx56w6+6jBJQ57IwTmXKkMo04dbTypUkG2mg9I+N+9+d1Jfsne/07
	qf7au1F+xWTvU+Uv0mTor7O6rXuDYfKJpyS9XLZwGIIhq6GJM2K5gibzXOHDXg==
Date: Thu, 25 Apr 2024 16:30:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425163002.5894c5e5@kmaincent-XPS-13-7390>
In-Reply-To: <20240425070619.601d5e40@kernel.org>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
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

On Thu, 25 Apr 2024 07:06:19 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 25 Apr 2024 10:31:10 +0200 Kory Maincent wrote:
> > Your reviewed-by tag has not been taken in the commit merged.
> > It seems patchwork does not take the cover letter tag reply into
> > account, I think only b4 does. =20
>=20
> Sorry about that.
> The problem is that patchwork doesn't correctly group the cover letter
> in your postings. Not sure why.=20

Weird, I used b4 so it should work.

> Could you experiment with tweaking the posting?
> Maybe we can "bisect" the problem.

Do you want me to like post a v5 with the "pw-bot: cr" tag? But if I put the
tag only on the cover letter it won't work then. Maybe on all patches?
Was it the same for the PoE support patch series?
If so, we could look at it with my future patch series that will bring new
features to PoE.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

