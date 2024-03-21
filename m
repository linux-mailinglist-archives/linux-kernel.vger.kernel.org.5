Return-Path: <linux-kernel+bounces-110166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99352885B05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB01F21AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645B8615F;
	Thu, 21 Mar 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHn9p6gW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782C1E489;
	Thu, 21 Mar 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032147; cv=none; b=GRiX/MIo6fdal4cVLu8A5yoSta2cJDI+E+XWwc22iMTfHLUW0LA8jKt/m8wcRfhugN0K6LzUh4XkAfWfDur9lJq32igrijXLFL9NKlrqxXS7jFBtHemkV0Kp3xW2Z+o7Y8g4wpWmBwu5ZY36Rac30Eb74y/kY4+73rOgPqnKmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032147; c=relaxed/simple;
	bh=1X+hNJMGK6SqdH8ZPP6qaRmvCLvttst+h+aM4nW4TUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ukr79FtxwyTX+DCv5maoad+wIt/YBmztkULTjZYFqoNdFYJ70gmOzBCfs49Iqfciy9XBlzH81Llpwbf4VVjG3LSZtfi5fGSo6u/uwW6rFb1E9nvFONnQEuxbWpWznj2jnMh7WX4WStQQiAuwYnue6GDmwdZa5cQY1uDwSnPvARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHn9p6gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057FDC433F1;
	Thu, 21 Mar 2024 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711032146;
	bh=1X+hNJMGK6SqdH8ZPP6qaRmvCLvttst+h+aM4nW4TUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHn9p6gWloIhsr8q0wVLpZxCd0EDS1d4xQ6+pSX0XnN7d8yq5hF5uGnn+zpVoOZxP
	 KTvpbW7/DIp5PQE/Hjz2h1pDrrn+S2AZ4m7ZLjBwmyUOevV+KYoHuyu84VI4X4qbfd
	 vdizrvk2UmdojHguVVfEkKvPJZOFkr7ubHzlRIDsHjFpj6uz0ZR1eUHcG6dFb11s4L
	 NJB29Yblv/AT1QqiFOqLQV5NoZ6IV3eJKE06R8j/dANe3ocCOpUcw9UfekLoAyErvo
	 uSj5AYB3xmH0b8jq8WCZbrpIHSdKmZFS8TAfv/GdkWXCottixUk//xoI8dsSgW5gr8
	 5y5IPK6cMBayQ==
Date: Thu, 21 Mar 2024 07:42:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Paolo Abeni
 <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, DENG Qingfang
 <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, erkin.bozoglu@xeront.com,
 mithat.guner@xeront.com
Subject: Re: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
Message-ID: <20240321074224.5850c05e@kernel.org>
In-Reply-To: <20240321-tentacled-pearl-ferret-efd5be@lemur>
References: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
	<f6f064b8-efb2-4ab0-94f1-468d5d273d6e@arinc9.com>
	<49d23df1340f342822702de0439674ddbc5bff6f.camel@redhat.com>
	<7a7e6c46-03a4-48eb-9f46-84a05259cf26@arinc9.com>
	<20240321-tentacled-pearl-ferret-efd5be@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024 09:19:02 -0400 Konstantin Ryabitsev wrote:
> On Thu, Mar 21, 2024 at 02:29:19PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> > > For future memory: I think the SoB in the cover letter is not require=
d,
> > > and is, at least to me, a bit confusing.
> > >=20
> > > No action needed here, I'll keep this unmodified, but I suggest to om=
it
> > > it in future submission. =20
> >=20
> > b4 puts it on the cover letter so it's not my doing. =20
>=20
> This is done because many subsystems use the cover letter as the merge co=
mmit
> message.=20

Could be wrong, but I think it was DaveM who originated this practice,
in networking..

> Those subsystems who don't follow this practice don't generally care
> if there's a Signed-Off-By in the cover letter anyway, so I don't see why=
 this
> is a concern that it's there.

Because we have to remove it, extra work. And the benefit of adding it
in the first place is unclear.

