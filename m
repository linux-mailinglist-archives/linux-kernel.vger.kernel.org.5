Return-Path: <linux-kernel+bounces-132933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B7A899C23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8560B1C22947
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379016C6B1;
	Fri,  5 Apr 2024 11:54:39 +0000 (UTC)
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522B16C69D;
	Fri,  5 Apr 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318079; cv=none; b=X9oX+IXno4DDzxGgoBFwU5ilbEshp86LdUHi0IRP6q/5ilA/46ULJL6BxGv86GxKRc1Wa96507RkuzJMgScSiAC4kPdtiSLwkzUAq7VI+51nmpueugTpEf6TBOKweFCI04d9y8n925BdnU38+M4C8ji8zHglaCdGLrVX4EOO8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318079; c=relaxed/simple;
	bh=8mLPbX2YqMJtrQVpt/7ZkJIQ0ttb96FYDDYY/fHYIho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ+S0GnU9O24qArcPDu7lUzX8u6Ni3ECEdhTIve0LX7s00uSdP3KdlMvn7soA2AD3LNNOu7AymKwYlv9TUuWU895Ur0/52i4SUZRabO/y458lxFzbhbx8LXEmdqu1GPyQXNOG1mMKROrMtOH7dCoIj81EZW/U+GwJ+SN2QvoUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 05F27A160;
	Fri,  5 Apr 2024 11:54:34 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject:
 Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Fri, 05 Apr 2024 13:54:34 +0200
Message-ID: <12413606.O9o76ZdvQC@lichtvoll.de>
In-Reply-To: <6034738.lOV4Wx5bFT@lichtvoll.de>
References:
 <2325246.ElGaqSPkdT@lichtvoll.de>
 <be5a7213-78b3-4917-b95b-ec31cd2350e4@leemhuis.info>
 <6034738.lOV4Wx5bFT@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Martin Steigerwald - 05.04.24, 13:49:00 CEST:
> Linux regression tracking (Thorsten Leemhuis) - 19.03.24, 09:40:06 CEST:
> > On 16.03.24 17:12, Martin Steigerwald wrote:
> > > Martin Steigerwald - 16.03.24, 17:02:44 CET:
> > >> ThinkPad T14 AMD Gen 1 fails to hibernate with self-compiled 6.8.1.
> > >> Hibernation works correctly with self-compiled 6.7.9.
> > >=20
> > > Apparently 6.8.1 does not even reboot correctly anymore. runit on
> > > Devuan. It says it is doing the system reboot but then nothing
> > > happens.
> > >=20
> > > As for hibernation the kernel cancels the attempt and returns back
> > > to
> > > user space desktop session.
> > >=20
> > >> Trying to use "no_console_suspend" to debug next. Will not do
> > >> bisect
> > >> between major kernel releases on a production machine.
> >=20
> > FWIW, without a bisection I guess no developer will take a closer look
> > (but I might be wrong and you lucky here!), as any change in those
> > hundreds of drivers used on that machine can possibly lead to problems
> > like yours. So without a bisection we are likely stuck here, unless
> > someone else runs into the same problem and bisects or fixes it.
> > Sorry, but that's just how it is.
>=20
> The plot thickens, now 6.7.12 as compared to 6.7.11 which failed
> hibernation with busy work queues=C2=B9 and 6.7.9 + bcachefs downgrade fi=
xes
> fails hibernation with the same error message than 6.8.1:
[=E2=80=A6]
> Not doing it today or probably the weekend, but now I have some
> actionable git bisect plan without bisecting between major kernel
> releases which as I have been told between 6.7 an 6.8-rc1 can lead to
> non working modeset graphics on AMD Ryzen in between.
>=20
> It seems now I only need to git bisect between 6.7.11 and 6.7.12 to find
> the patch that breaks hibernation on 6.8.1 as well. However first I
> will briefly check whether 6.8.4 hibernates okay.

6.8.4 is still affected and fails hibernation with the same error message.

> [1] * 6.7.11: Fails to hibernate - work queues still busy
> @ 2024-04-02 19:29 Martin Steigerwald
>=20
> https://lore.kernel.org/regressions/2ad93b57-8fdc-476e-83b7-2c0af1cfd41d
> @leemhuis.info/T/#t

=2D-=20
Martin



