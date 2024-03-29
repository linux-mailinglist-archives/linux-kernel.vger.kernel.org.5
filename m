Return-Path: <linux-kernel+bounces-125115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD2892057
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235D0B30887
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8C139CFF;
	Fri, 29 Mar 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjnA5F4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34741206;
	Fri, 29 Mar 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725061; cv=none; b=gC0L2sGfwH606Ok4XUYR5AJlGhJ5GTHHs9m13DTpN7OyKw3r0/pR90GM5Dbz2h04efoask1RKbtPYvSvpPMgNEDXVyaugVO724b/CKfQr43mCtdFaudsdA70YEmOBK2Y5PPzqYgspFZs9AwyiemHOV+iFVuXK72D8KSL+fVJ39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725061; c=relaxed/simple;
	bh=iY/rcKU9DweBFcuokJdWYvhSzphuNeIqLpvKFobXslI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFewDfqjPhVHJwiWg2cpPNex0T+pcWfpPa4FL84OvNB9KF/MDul4rM6DxxRlx260BtOyYdtOLCd7fAQUkwbXlUH+RALG9UuZFeaU0gBHUymJOryjGRwd+6VLMIfpaVRodGEfaxf2QOuvLMyeL4MHowAFPXDI+mdaiXpQnV7iG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjnA5F4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B28C433F1;
	Fri, 29 Mar 2024 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725060;
	bh=iY/rcKU9DweBFcuokJdWYvhSzphuNeIqLpvKFobXslI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjnA5F4d7NKRGXPMI9496JDKcnXoAGOMe6p8Q/qKQoHp3UQfVlxhg9gt1UzgUAOJI
	 1QlEorcRlUEfMd7LHy4rSticw10UyAJcBUAC6TF15uMZ4E78Vb5qRGO7hff0PWX8KL
	 7Puc+G69aL3gRlBg1WLXXziR+/GK0yE27weDANTHJpKIXy26ViNj7c2dANkXtXH38a
	 e9EJ5Tv5ZaqYBtuwjKYMgWpg9myhoJa4Y5RuHA0FhDJCKBmraCFnmEgsX7CHjXKOyd
	 G0Dd257NK9sJxTdDrND+hyOMgiSnMF8c4cDI3UKWrdPk10L/y/dnZU4L2nzztA2KGT
	 8hcCQq2Zwq2jA==
Date: Fri, 29 Mar 2024 08:10:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Stefan Eichenberger <eichest@gmail.com>, Dimitri
 Fedrau <dima.fedrau@gmail.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Shay Agroskin
 <shayagr@amazon.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: ethtool: Add impedance mismatch
 result code to cable test
Message-ID: <20240329081058.15ee0f1d@kernel.org>
In-Reply-To: <CAJN1KkxcX9dfhMVvQCFLosTgO5U2tAjvHEO-prViSacOB6DQRg@mail.gmail.com>
References: <20240327162918.2426792-1-paweldembicki@gmail.com>
	<20240327162918.2426792-2-paweldembicki@gmail.com>
	<20240328190226.7aab8b76@kernel.org>
	<CAJN1KkxcX9dfhMVvQCFLosTgO5U2tAjvHEO-prViSacOB6DQRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Mar 2024 10:31:10 +0100 Pawe=C5=82 Dembicki wrote:
> > I'm not a cable expert but going purely by the language
> > abnormal !=3D mismatch. Mismatch indicates there are two
> > values we are comparing. =20
>=20
> Impedance mismatch can be detected because some parts of the cable may
> have different (abnormal) impedance, causing reflections at those
> points. Ethernet cables should have a characteristic impedance of 100
> Ohms, so any mismatch from this value is considered abnormal.

I see, makes sense.

> I can provide a rephrased version if the commit description was not
> detailed enough.

That'd be great. Or maybe even better a short comment above the enum
entry?

