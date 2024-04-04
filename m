Return-Path: <linux-kernel+bounces-131856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6074A898CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5C1C21ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5A762D0;
	Thu,  4 Apr 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhxBAQRp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1M6ZOl46"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D51CA84
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249576; cv=none; b=BXT/WxpKyX0j0xABkCN4dG+uvOPhaRV7J0oisG5QS3vpbgI3OQSEwIfdyQr6IUb18kb8VyfYIVPidjTN4ym7Z8BhLqdG9qRvutCVrs53DOQ4qLutyOPyZvqbOZSU8jrQ1PWZ4RgryyL8pgUQfVq27EFNU1cjdPs7JPhArVjiIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249576; c=relaxed/simple;
	bh=Xov/W0E31ifQozW0fhKUs9bbDNuFa7IX5G3pMtVN7bM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sJ83UHVX5mnqyh3FwjcplS0s0JO0sgtx6A7Y1bm4qLmUJJstH4kal0S7nH+F9n40n8bKH36dnvj2RiycJHqkSO45VlWjacfIY0OEPpgCvReGDUAQTPvpnyehmp4VpAxBXopwqmXb0PUHSm5FKAGHtnrbQYfHilWIwjVk7A9KM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhxBAQRp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1M6ZOl46; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712249573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JX/6LEuH1nrDXzYEDxupwbV5UlrvBalnE8NfAturiSk=;
	b=qhxBAQRpHKmiMvrVOFGqZKz54FkZmCUXdqr1cMynvv4SG46P1gi81C0o1hsOcPabBy8QdB
	2UfVthJGIIhKCm74rY/N+Pyk1jIrQrTX2+iNKdvSdvxMQAgy10UmkGRQxa2Gi1TXebMnZw
	zKZIotrX1ZYS7ov1ovkz8gWg3JbeihTjOr/hisQ5sU5GGOxPOhcUcCPlVOvoN0uyHvSDbR
	H7zT4nWMICgDgrS5OaWwNC8C+mYYNKyk2KDgF8iYl+saUBChHFy0CfZLcP9yfSF5s1DzEZ
	IuebJm5B3Pw4acQvlHYFaIP4jAQ4/nbTjHu/H5i6fSrpRaeXuV6B1b2foXQeSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712249573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JX/6LEuH1nrDXzYEDxupwbV5UlrvBalnE8NfAturiSk=;
	b=1M6ZOl46rqxRuPz51XrVMTNKwDYb0Nm1loy0mYnoCjHmx8fgGy3rhR3z81lFsFsdG6ZQBl
	R7fL7LCMHChcX6CA==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] timers/migration: Fix ignored event due to missing
 CPU update
In-Reply-To: <Zg2Ct6M2RJAYHgCB@localhost.localdomain>
References: <20240401214859.11533-1-frederic@kernel.org>
 <87r0fo9jmw.fsf@somnus> <Zg2Ct6M2RJAYHgCB@localhost.localdomain>
Date: Thu, 04 Apr 2024 18:52:52 +0200
Message-ID: <878r1tvzmj.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Tue, Apr 02, 2024 at 11:52:23AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>> Frederic Weisbecker <frederic@kernel.org> writes:
>>=20
>> > When a group event is updated with its expiry unchanged but a different
>> > CPU, that target change may go unnoticed and the event may be propagat=
ed
>> > up with a stale CPU value. The following depicts a scenario that has
>> > been actually observed:
>>=20
>> urgh...
>>=20
>> >
>> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> > ---
>> >  kernel/time/timer_migration.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migrati=
on.c
>> > index c63a0afdcebe..90786bb9a607 100644
>> > --- a/kernel/time/timer_migration.c
>> > +++ b/kernel/time/timer_migration.c
>> > @@ -762,8 +762,11 @@ bool tmigr_update_events(struct tmigr_group *grou=
p, struct tmigr_group *child,
>> >  	 * queue when the expiry time changed only or when it could be ignor=
ed.
>> >  	 */
>> >  	if (timerqueue_node_queued(&evt->nextevt)) {
>> > -		if ((evt->nextevt.expires =3D=3D nextexp) && !evt->ignore)
>> > +		if ((evt->nextevt.expires =3D=3D nextexp) && !evt->ignore) {
>> > +			if (evt->cpu !=3D first_childevt->cpu)
>> > +				evt->cpu =3D first_childevt->cpu;
>>=20
>> Why not just unconditionally overwriting the evt->cpu value here?
>
> Right! See below:
>
> ---
> From d038dad7345398a2f6671a3cda98a48805f9eba3 Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Mon, 1 Apr 2024 23:48:59 +0200
> Subject: [PATCH v2] timers/migration: Fix ignored event due to missing CP=
U update
>
> When a group event is updated with its expiry unchanged but a different
> CPU, that target change may go unnoticed and the event may be propagated
> up with a stale CPU value. The following depicts a scenario that has
> been actually observed:
>
>                        [GRP2:0]
>                    migrator =3D GRP1:1
>                    active   =3D GRP1:1
>                    nextevt  =3D TGRP1:0 (T0)
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator =3D NONE       [...]
>             active   =3D NONE
>             nextevt  =3D TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator =3D NONE
>       active   =3D NONE
>       nextevt  =3D T0
>       /         \
>     0 (T0)       1 (T1)
>     idle         idle
>
> 0) The hierarchy has 3 levels. The left part (GRP1:0) is all idle,
> including CPU 0 and CPU 1 which have a timer each: T0 and T1. They have
> the same expiry value.
>
>                        [GRP2:0]
>                    migrator =3D GRP1:1
>                    active   =3D GRP1:1
>                    nextevt  =3D KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator =3D NONE       [...]
>             active   =3D NONE
>             nextevt  =3D TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator =3D NONE
>       active   =3D NONE
>       nextevt  =3D T0
>       /         \
>     0 (T0)       1 (T1)
>     idle         idle
>
> 1) The migrator in GRP1:1 handles remotely T0. The event is dequeued
> from the top and T0 executed.
>
>                        [GRP2:0]
>                    migrator =3D GRP1:1
>                    active   =3D GRP1:1
>                    nextevt  =3D KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator =3D NONE       [...]
>             active   =3D NONE
>             nextevt  =3D TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator =3D NONE
>       active   =3D NONE
>       nextevt  =3D T1
>       /         \
>     0            1 (T1)
>     idle         idle
>
> 2) The migrator in GRP1:1 fetches the next timer for CPU 0 and finds
> none. But it updates the events from its groups, starting with GRP0:0
> which now has T1 as its next event. So far so good.
>
>                        [GRP2:0]
>                    migrator =3D GRP1:1
>                    active   =3D GRP1:1
>                    nextevt  =3D KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator =3D NONE       [...]
>             active   =3D NONE
>             nextevt  =3D TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator =3D NONE
>       active   =3D NONE
>       nextevt  =3D T1
>       /         \
>     0            1 (T1)
>     idle         idle
>
> 3) The migrator in GRP1:1 proceeds upward and updates the events in
> GRP1:0. The child event TGRP0:0 is found queued with the same expiry
> as before. And therefore it is left unchanged. However the target CPU
> is not the same but that fact is ignored so TGRP0:0 still points to
> CPU 0 when it should point to CPU 1.
>
>                        [GRP2:0]
>                    migrator =3D GRP1:1
>                    active   =3D GRP1:1
>                    nextevt  =3D TGRP1:0 (T0)
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator =3D NONE       [...]
>             active   =3D NONE
>             nextevt  =3D TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator =3D NONE
>       active   =3D NONE
>       nextevt  =3D T1
>       /         \
>     0            1 (T1)
>     idle         idle
>
> 4) The propagation has reached the top level and TGRP1:0, having TGRP0:0
> as its first event, also wrongly points to CPU 0. TGRP1:0 is added to
> the top level group.
>
>                        [GRP2:0]
>                    migrator =3D GRP1:1
>                    active   =3D GRP1:1
>                    nextevt  =3D KTIME_MAX
>                     /              \
>                [GRP1:0]           [GRP1:1]
>             migrator =3D NONE       [...]
>             active   =3D NONE
>             nextevt  =3D TGRP0:0 (T0)
>             /           \
>         [GRP0:0]       [...]
>       migrator =3D NONE
>       active   =3D NONE
>       nextevt  =3D T1
>       /         \
>     0            1 (T1)
>     idle         idle
>
> 5) The migrator in GRP1:1 dequeues the next event in top level pointing
> to CPU 0. But since it actually doesn't see any real event in CPU 0, it
> early returns.
>
> 6) T1 is left unhandled until either CPU 0 or CPU 1 wake up.
>
> Some other bad scenario may involve trees with just two levels.
>
> Fix this with unconditionally updating the CPU of the child event before
> considering to early return while updating a queued event with an
> unchanged expiry value.
>
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Thanks,

	Anna-Maria


