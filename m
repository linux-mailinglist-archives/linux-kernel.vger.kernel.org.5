Return-Path: <linux-kernel+bounces-101202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B087A3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1241F1C2154C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355618EAD;
	Wed, 13 Mar 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDhckm8d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9mcgESd/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADD1755A;
	Wed, 13 Mar 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317589; cv=none; b=MnOr85bzxjXj1jQZXPD+AisYL+vIC9IInye9i5PkmHpBN9g1ng+dAB7XnJcrjNUh3U5vY0xciP1jle+otXUb+Rfkwm8bMrFDE5P6jhXxzxUzb9fegyjNHBHhsP276X6OEo+tLhbODzjV2TGvauU+td6gs9vj0QvGkWfxPWe00Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317589; c=relaxed/simple;
	bh=tUuSOamMV4WydCgUMCgQyUEJgIyha1cE00JSbUEBgLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkV4/OP8xn/b/053YHZno9nea1e7zWbtfslAbFmeIhZD8ozp2P4N4w+oBcgajsZQBJ3pO10v/0LbIQJ+VyW6Vzmx+yMejZMg3d1CdR5tjYBWHlwIhc+qzdgSbQafOfWtass7qSIZzyF2F6HVHcsn8/Q0SsTIAfC57PHhusVey/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDhckm8d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9mcgESd/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 09:13:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710317584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghBbxv10Yx+PhzZT76BoMKiCE5Hea/IDnIEecFzQG0s=;
	b=bDhckm8dgUj5r+TTLUf6hHq+frC9tCYE9Vh7d3Pnk31ugyDX1YpkeqZ1gdiIrGLw/BoThp
	3cIqV3pIwFyJhO8MRKCDfZqaa5/N3VlHANaLMDTLIeijpQx6+x/LQXl5G9QTQC5hJsw3hv
	SOD5QCLF9IZA4b/wih4/yuN/CBEj8LtdTplzojlH1IEpIe4q9DK4OwPfnakuzWDvp2x+rQ
	23dAShmG/EghnDKaokywjOy6iVLGrvRF0MWMKW7fqByUV7+l3wp/fYAYcqFqOoFFptu/sp
	6mqDQCR2APqOVStX5O1BoUXm58PW5tjUt1g0crB5RS2QThduxMgbsoy0mc3YZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710317584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghBbxv10Yx+PhzZT76BoMKiCE5Hea/IDnIEecFzQG0s=;
	b=9mcgESd/8meQye1/yvE06TsGjEeS/VwioA326OhcULvk/9NUl7usEuUkweobiIpwjgn6rc
	V8bvyF3MVk3kDQAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240313081303.DClwQrvb@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <ZfDMTlTH2SdwlB9M@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZfDMTlTH2SdwlB9M@x1>

On 2024-03-12 18:42:38 [-0300], Arnaldo Carvalho de Melo wrote:
=E2=80=A6
> But:
>=20
> [acme@nine ~]$ pidof exec_child
> 24273 24271 24270 24269 24268 24267 24266 24265 24264 24263 24262 24261 2=
4260 24259=20
=E2=80=A6

> [root@nine ~]# cat /proc/24263/stack
> [<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
> [<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> [root@nine ~]#
=E2=80=A6
> [acme@nine ~]$ ps ax|grep exec_child| wc -l
> 504
> [acme@nine ~]$ ps ax|grep exec_child| tail
>   24264 pts/0    R      0:04 exec_child
>   24265 pts/0    R      0:04 exec_child
>   24266 pts/0    R      0:04 exec_child
>   24267 pts/0    R      0:04 exec_child
>   24268 pts/0    R      0:04 exec_child
>   24269 pts/0    R      0:04 exec_child
>   24270 pts/0    R      0:04 exec_child
>   24271 pts/0    R      0:04 exec_child
>   24273 pts/0    R      0:04 exec_child
>   26704 pts/1    S+     0:00 grep --color=3Dauto exec_child
> [acme@nine ~]$
>=20
> All in 'R' state.
>=20
> [root@nine ~]# killall exec_child
> exec_child: no process found
> [root@nine ~]# ps ax | grep exec_child | head -5
>   22964 pts/0    R      0:06 exec_child
>   23046 pts/0    R      0:05 exec_child
>   23128 pts/0    R      0:05 exec_child
>   23129 pts/0    R      0:05 exec_child
>   23181 pts/0    R      0:05 exec_child
> [root@nine ~]# kill 22964 23046 23128 23129 23181
> [root@nine ~]# ps ax | grep exec_child | head -5
>   23182 pts/0    R      0:06 exec_child
>   23196 pts/0    R      0:06 exec_child
>   23197 pts/0    R      0:06 exec_child
>   23210 pts/0    R      0:06 exec_child
>   23213 pts/0    R      0:06 exec_child
> [root@nine ~]#

You can't kill them?

> at the end they disappeared, on this last run.
>=20
> But if I do a 'killall remove_on_exec' and stop that loop (control+C/Z)
> we get all those exec_child running a seemingly eternal loop:

Is this new or was it there? Is this VM or bare metal?

One part I don't get: did you let it run or did you kill it?
`exec_child' spins until a signal is received or the parent kills it. So
it shouldn't remain there for ever. And my guess, that it is in spinning
in userland and not in kernel.
I tried it on bare metal and VM and couldn't reproduce this.
=E2=80=A6
>=20
> - Arnaldo

Sebastian

