Return-Path: <linux-kernel+bounces-99355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A787872B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9511F218F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835653E27;
	Mon, 11 Mar 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="z8AlPkLX"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762E53E0A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181282; cv=none; b=mUF+cXIqi6gtewLLaGIl6nHqE32YsGBzVP5U1nv4JRLlVoMYeiJn2MtV0YJaxbflfgYcnxb56x0Cf+3H+2+l6EzbNSAIAVyB2o5FQkcLgcRv8UGN9p0zmic2hgNdYfL/kk28+n4vdCbDktsg41q8K4x0nqpkp2nm3pXtSQYtp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181282; c=relaxed/simple;
	bh=BUUe45GmcgEf+7sZXAFei90Gwt6yjfK4dCtth9t62L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma2RiPQQI7uZSIzvQvKydxm08JzmmlrG7xqfi8UCCGcB4GmsCHpoEW5cofjTj4SHIiGrjeCiZMe2M8oXs4IEUNKCWiVEK5ur0qotdQYcL+VJApbWberzxPqsCtFlIcJU6ilRMUqVb1YC1EKHylCScYEg1I0igmPsh3rgeZhp3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=z8AlPkLX; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E98F51CF161;
	Mon, 11 Mar 2024 19:21:18 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710181279; bh=uu0vN9OWT5pwA8su6yrDf5xh0xrr2nA/BSmFKgc9obg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z8AlPkLXRH8Hln+3lBF66TakbKoQUJNIR7HACFeYLc4orin1UX92nUGDp6Gof/ce/
	 EQ1hv+PfbQXUyjFF5VdWAjRr2jLchmmiN/QqFZMGlO58xrr+nTSIL66116Flyq170G
	 am4F5ykQZhKId0GOCZ/puKSRUomgVsonaZAZC/jouLH0aDGhQpGkQkpYNHp0oMZptV
	 ypJa45o8g4vyJOeZqoAg6VU+R65qWHeszCI1fdHilIlLAlJ+AAeM/KILPqHqCw1XNM
	 hphvY1/fF3bpiPNqx6HpAVgdXaEUZzzZfAX5oSs36H7PnEbeICfJtQos3IHDnEMpF+
	 M/BhtUiTpE3JA==
Date: Mon, 11 Mar 2024 19:21:18 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Linux regressions mailing list
 <regressions@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
 "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, stable@kernel.org
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when
 used repeatedly in one file
Message-ID: <20240311192118.31cfc1fb@meshulam.tesarici.cz>
In-Reply-To: <CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
References: <20240306111157.29327-1-petr@tesarici.cz>
	<20240311182516.1e2eebd8@meshulam.tesarici.cz>
	<CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2024 18:43:59 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Mar 11, 2024 at 6:25=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesa=
rici.cz> wrote:
> >
> > On Wed,  6 Mar 2024 12:11:57 +0100
> > Petr Tesarik <petr@tesarici.cz> wrote:
> > =20
> > > Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> > > initialized in the same file.
> > >
> > > With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> > >
> > >       static struct lock_class_key __key;
> > >
> > > Since u64_stats_init() is a function (albeit an inline one), all calls
> > > within the same file end up using the same instance, effectively trea=
ting
> > > them all as a single lock-class. =20
> >
> > What happens with this fix now?
> >
> > IIUC it should be reviewed by Eric, but I don't know through which tree
> > it should be merged. Any plans yet? =20
>=20
> I thought I gave a reply, but apparently not .
>=20
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thank you!

Petr T

